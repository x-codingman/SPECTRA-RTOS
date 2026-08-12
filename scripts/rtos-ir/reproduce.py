#!/usr/bin/env python3
"""Reproduce the four RTOS experiment bitcode sets with LLVM 11."""

import argparse
import concurrent.futures
import json
import os
import shutil
import subprocess
import sys
import threading
from datetime import datetime, timezone
from pathlib import Path

from compare_ir import compare


ROOT = Path(__file__).resolve().parents[2]
EXPECTED_REVISIONS = {
    "threadx": "06dabb0ad0403f59889ce85eeb3d48dbd9d3759b",
    "rt-thread": "5b3320624da5149fc21c2d3e1f321d855e3d0dfe",
    "tizenrt": "39544961e865be55cacd4b58c6240b959b68c096",
}
NAMES = ("freertos", "threadx", "rt-thread", "tizenrt")
PRINT_LOCK = threading.Lock()
LOCAL_LLVM_11 = Path("/tmp/llvm-110-install_O_D_A/bin")
DEFAULT_TOOLCHAIN = Path(
    os.environ.get(
        "LLVM_BIN", str(LOCAL_LLVM_11 if (LOCAL_LLVM_11 / "clang").is_file() else Path())
    )
)


class BuildError(RuntimeError):
    pass


def run(command, cwd=None, quiet=False):
    command = [str(part) for part in command]
    process = subprocess.run(
        command,
        cwd=str(cwd) if cwd else None,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        universal_newlines=True,
    )
    if process.returncode:
        raise BuildError(
            "command failed: {}\n{}{}".format(
                " ".join(command), process.stdout, process.stderr
            )
        )
    if not quiet and process.stderr:
        with PRINT_LOCK:
            sys.stderr.write(process.stderr)
    return process.stdout.strip()


def require_file(path, description):
    if not path.is_file():
        raise BuildError("{} not found: {}".format(description, path))


def require_dir(path, description):
    if not path.is_dir():
        raise BuildError("{} not found: {}".format(description, path))


def check_llvm(tools):
    for name, path in tools.items():
        resolved = shutil.which(str(path))
        if not resolved:
            raise BuildError("LLVM tool not found: {} ({})".format(name, path))
        tools[name] = resolved
    version = run([tools["clang"], "--version"], quiet=True).splitlines()[0]
    if "version 11." not in version:
        raise BuildError("the experiment requires LLVM 11, found: {}".format(version))
    return version


def git_head(path):
    return run(["git", "rev-parse", "HEAD"], cwd=path, quiet=True)


def check_revision(name, source):
    expected = EXPECTED_REVISIONS.get(name)
    if not expected:
        return None
    actual = git_head(source)
    if actual != expected:
        raise BuildError(
            "{} source revision mismatch: expected {}, found {}".format(
                name, expected, actual
            )
        )
    return actual


def ensure_patch(source, patch):
    require_file(patch, "experiment patch")
    reverse = subprocess.run(
        ["git", "apply", "--reverse", "--check", str(patch)],
        cwd=str(source),
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )
    if reverse.returncode == 0:
        return "already-applied"
    check = subprocess.run(
        ["git", "apply", "--check", str(patch)],
        cwd=str(source),
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )
    if check.returncode:
        raise BuildError("patch is neither applicable nor already applied: {}".format(patch))
    run(["git", "apply", str(patch)], cwd=source, quiet=True)
    return "applied"


def prepare_tizen(source):
    config = source / "os" / ".config"
    generated = source / "os" / "include" / "tinyara" / "config.h"
    if config.is_file() and generated.is_file():
        return "already-configured"
    run(["./tools/configure.sh", "stm32h745zi-nucleo/hello"], cwd=source / "os")
    run(["make", "context"], cwd=source / "os")
    return "configured"


def compile_one(tools, source, output, includes, flags):
    output.parent.mkdir(parents=True, exist_ok=True)
    command = [tools["clang"]]
    command.extend(["-I" + str(path) for path in includes])
    command.extend(flags)
    command.extend([source, "-o", output])
    run(command, quiet=True)
    return output


def parallel_map(jobs, function, items):
    if jobs == 1:
        return [function(item) for item in items]
    with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as executor:
        return list(executor.map(function, items))


def link_and_prune(tools, inputs, output, rt_thread=False):
    output.parent.mkdir(parents=True, exist_ok=True)
    raw = output.with_suffix(".raw.bc")
    command = [tools["llvm-link"]]
    if rt_thread:
        command.append("--only-needed")
    command.extend(inputs)
    command.extend(["-o", raw])
    run(command, quiet=True)
    if rt_thread:
        opt_flags = [
            "-O3",
            "-deadargelim",
            "-internalize",
            "-adce",
            "-internalize-public-api-list=main",
            "-globaldce",
            "-strip-dead-prototypes",
        ]
    else:
        opt_flags = [
            "-passes=internalize,globaldce",
            "-internalize-public-api-list=main",
        ]
    run([tools["opt"]] + opt_flags + [raw, "-o", output], quiet=True)
    raw.unlink()
    return output


def selected_sources(harness, samples):
    sources = sorted((harness / "test_files").glob("*.c"))
    if not samples:
        return sources
    lookup = {path.stem: path for path in sources}
    missing = sorted(set(samples) - set(lookup))
    if missing:
        raise BuildError("unknown test(s): {}".format(", ".join(missing)))
    return [lookup[name] for name in samples]


def compare_output(tools, generated, baseline):
    require_file(baseline, "baseline IR")
    result = compare(generated, baseline, tools["llvm-dis"], tools["llvm-nm"])
    return {
        "test": generated.name[:-8],
        "status": result["status"],
        "differences": result["differences"],
        "generated_sha256": result["left"]["sha256"],
        "baseline_sha256": result["right"]["sha256"],
    }


def build_freertos(args, tools, output):
    source = args.freertos_source.resolve()
    harness = ROOT / "harnesses" / "freertos-10.5.1"
    require_dir(source / "Source", "FreeRTOS 10.5.1 source")
    task_header = source / "Source" / "include" / "task.h"
    require_file(task_header, "FreeRTOS task.h")
    if 'tskKERNEL_VERSION_NUMBER       "V10.5.1"' not in task_header.read_text():
        raise BuildError("FreeRTOS source is not version 10.5.1: {}".format(source))
    tests = selected_sources(harness, args.sample)
    includes = [
        harness,
        ROOT / "include",
        source / "Source" / "include",
        source / "Source" / "symbolic_execution",
        source / "Source" / "portable" / "ThirdParty" / "GCC" / "Posix",
        source / "Source" / "portable" / "ThirdParty" / "GCC" / "Posix" / "utils",
    ]
    flags = ["-emit-llvm", "-c", "-g", "-O0"]
    object_dir = output / "objects"
    kernel_sources = sorted((source / "Source").glob("*.c"))
    kernel_objects = parallel_map(
        args.jobs,
        lambda item: compile_one(
            tools, item, object_dir / "kernel" / (item.stem + ".bc"), includes, flags
        ),
        kernel_sources,
    )
    test_objects = parallel_map(
        args.jobs,
        lambda item: compile_one(
            tools, item, object_dir / "tests" / (item.stem + ".bc"), includes, flags
        ),
        tests,
    )

    def finish(pair):
        test, test_object = pair
        generated = output / "test_bc_files" / (test.stem + ".test.bc")
        link_and_prune(tools, kernel_objects + [test_object], generated)
        return compare_output(tools, generated, harness / "test_bc_files" / generated.name)

    results = parallel_map(args.jobs, finish, list(zip(tests, test_objects)))
    return "source-rebuild", "FreeRTOS 10.5.1", None, results


def build_threadx(args, tools, output):
    source = args.threadx_source.resolve()
    harness = ROOT / "harnesses" / "threadx-6.4.2"
    require_dir(source / "common", "ThreadX source")
    revision = check_revision("threadx", source)
    patch_status = ensure_patch(source, harness / "experiment.patch")
    tests = selected_sources(harness, args.sample)
    common_includes = [
        harness,
        ROOT / "include",
        source / "common" / "inc",
        source / "ports_module" / "cortex_m33" / "gnu" / "inc",
    ]
    all_includes = common_includes + [
        source / "common_modules" / "inc",
        source / "common_modules" / "module_manager" / "inc",
    ]
    flags = ["-fno-asm", "-emit-llvm", "-m64", "-c", "-g"]
    object_dir = output / "objects"
    common_sources = sorted((source / "common" / "src").glob("*.c"))
    manager_sources = sorted(
        (source / "common_modules" / "module_manager" / "src").glob("*.c")
    )
    common_objects = parallel_map(
        args.jobs,
        lambda item: compile_one(
            tools, item, object_dir / "common" / (item.stem + ".bc"), common_includes, flags
        ),
        common_sources,
    )
    manager_objects = parallel_map(
        args.jobs,
        lambda item: compile_one(
            tools, item, object_dir / "manager" / (item.stem + ".bc"), all_includes, flags
        ),
        manager_sources,
    )
    common_bc = output / "objects" / "common.bc"
    manager_bc = output / "objects" / "manager.bc"
    run([tools["llvm-link"]] + common_objects + ["-o", common_bc], quiet=True)
    run([tools["llvm-link"]] + manager_objects + [common_bc, "-o", manager_bc], quiet=True)

    def finish(test):
        candidates = [
            source / "common_modules" / "module_lib" / "src" / ("txm_" + test.stem + ".c"),
            source / "common_modules" / "module_lib" / "src" / (test.stem + ".c"),
        ]
        module_source = next((path for path in candidates if path.is_file()), None)
        if module_source is None:
            raise BuildError("ThreadX module wrapper not found for {}".format(test.stem))
        module_bc = compile_one(
            tools,
            module_source,
            object_dir / "modules" / (test.stem + ".bc"),
            all_includes,
            flags,
        )
        test_bc = compile_one(
            tools, test, object_dir / "tests" / (test.stem + ".bc"), all_includes, flags
        )
        generated = output / "test_bc_files" / (test.stem + ".test.bc")
        link_and_prune(tools, [manager_bc, module_bc, test_bc], generated)
        return compare_output(tools, generated, harness / "test_bc_files" / generated.name)

    results = parallel_map(args.jobs, finish, tests)
    return "source-rebuild", "ThreadX 6.4.2", revision, results, patch_status


def build_rt_thread(args, tools, output):
    source = args.rt_thread_source.resolve()
    harness = ROOT / "harnesses" / "rt-thread"
    require_dir(source / "components", "RT-Thread source")
    revision = check_revision("rt-thread", source)
    artifacts = args.rt_thread_build
    if artifacts is None:
        raise BuildError(
            "RT-Thread needs --rt-thread-build pointing to qemu-vexpress-a9 historical "
            "build artifacts; a source rebuild also needs the original x86_64-musl sysroot"
        )
    artifacts = artifacts.resolve()
    kernel_bc = artifacts / "bc_out" / "all_kernel.bc"
    require_file(kernel_bc, "RT-Thread all_kernel.bc")
    tests = selected_sources(harness, args.sample)

    def finish(test):
        candidates = [
            artifacts / "build" / "kernel" / "components" / "lwp" / "test_files" / (test.stem + ".bc"),
            artifacts / "bc_out" / "test_files" / (test.stem + ".bc"),
        ]
        test_bc = next((path for path in candidates if path.is_file()), None)
        if test_bc is None:
            raise BuildError("historical RT-Thread test IR not found for {}".format(test.stem))
        generated = output / "test_bc_files" / (test.stem + ".test.bc")
        link_and_prune(tools, [kernel_bc, test_bc], generated, rt_thread=True)
        return compare_output(tools, generated, harness / "test_bc_files" / generated.name)

    results = parallel_map(args.jobs, finish, tests)
    return "historical-ir-relink", "RT-Thread 5.2.0", revision, results


def build_tizenrt(args, tools, output):
    source = args.tizenrt_source.resolve()
    harness = ROOT / "harnesses" / "tizenrt"
    require_dir(source / "os", "TizenRT source")
    revision = check_revision("tizenrt", source)
    prepare_status = prepare_tizen(source)
    aggregate = args.tizen_kernel_bc.resolve()
    require_file(aggregate, "TizenRT pruned kernel aggregate")
    tests = selected_sources(harness, args.sample)
    includes = [
        harness,
        ROOT / "include",
        source / "lib" / "libc" / "aio",
        source / "os" / "include",
        source / "os" / "kernel",
        source / "os" / "arch" / "arm" / "include",
        source / "os" / "pm",
        source / "os" / "fs",
        source / "os" / "fs" / "smartfs",
        source / "os" / "fs" / "tmpfs",
        source / "os" / "arch" / "arm" / "src" / "common",
        source / "os" / "include" / "arch" / "chip",
        source / "os" / "arch" / "arm" / "src" / "armv7-m",
    ]
    flags = ["-emit-llvm", "-c", "-w", "-g", "-Wundef"]
    object_dir = output / "objects"
    def finish(test):
        test_bc = compile_one(
            tools,
            test,
            object_dir / "tests" / (test.stem + ".bc"),
            includes,
            flags,
        )
        generated = output / "test_bc_files" / (test.stem + ".test.bc")
        link_and_prune(tools, [aggregate, test_bc], generated)
        return compare_output(tools, generated, harness / "test_bc_files" / generated.name)

    results = parallel_map(args.jobs, finish, tests)
    return "harness-source-plus-kernel-ir", "TizenRT 3.1 (2023 revision)", revision, results, prepare_status


def clean_output(output_root, name, force):
    output = output_root / name
    if output.exists():
        if not force:
            raise BuildError("output already exists (use --force): {}".format(output))
        if output.resolve().parent != output_root.resolve():
            raise BuildError("refusing to remove output outside output root")
        shutil.rmtree(str(output))
    output.mkdir(parents=True)
    return output


def parse_args():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("rtos", choices=NAMES + ("all",))
    parser.add_argument("--sample", action="append", help="test stem; repeat as needed")
    parser.add_argument("--output-root", type=Path, default=ROOT / "reproduced-ir")
    parser.add_argument("--jobs", type=int, default=min(4, os.cpu_count() or 1))
    parser.add_argument("--force", action="store_true")
    parser.add_argument("--toolchain", type=Path, default=DEFAULT_TOOLCHAIN)
    parser.add_argument("--freertos-source", type=Path, default=ROOT / "test-rtos" / "freertos-10.5.1")
    parser.add_argument("--threadx-source", type=Path, default=ROOT / "test-rtos" / "threadx-6.4.2")
    parser.add_argument("--rt-thread-source", type=Path, default=ROOT / "test-rtos" / "rt-thread")
    parser.add_argument("--rt-thread-build", type=Path)
    parser.add_argument("--tizenrt-source", type=Path, default=ROOT / "test-rtos" / "tizenrt")
    parser.add_argument("--tizen-kernel-bc", type=Path, default=ROOT / "harnesses" / "tizenrt" / "all.test.bc")
    args = parser.parse_args()
    if args.jobs < 1:
        parser.error("--jobs must be positive")
    return args


def main():
    args = parse_args()
    tools = {
        name: args.toolchain / name
        for name in ("clang", "llvm-link", "opt", "llvm-dis", "llvm-nm")
    }
    try:
        compiler = check_llvm(tools)
        names = NAMES if args.rtos == "all" else (args.rtos,)
        builders = {
            "freertos": build_freertos,
            "threadx": build_threadx,
            "rt-thread": build_rt_thread,
            "tizenrt": build_tizenrt,
        }
        overall = []
        for name in names:
            print("[{}] building".format(name), flush=True)
            output = clean_output(args.output_root.resolve(), name, args.force)
            built = builders[name](args, tools, output)
            mode, version, revision, results = built[:4]
            extra = built[4] if len(built) > 4 else None
            manifest = {
                "rtos": name,
                "version": version,
                "revision": revision,
                "mode": mode,
                "preparation": extra,
                "compiler": compiler,
                "generated_at": datetime.now(timezone.utc).isoformat(),
                "tests": results,
            }
            with (output / "manifest.json").open("w") as stream:
                json.dump(manifest, stream, indent=2, sort_keys=True)
                stream.write("\n")
            counts = {
                status: sum(item["status"] == status for item in results)
                for status in ("exact", "structural", "different")
            }
            print("[{}] {}".format(name, counts), flush=True)
            overall.extend((name, item) for item in results)
        return 1 if any(item["status"] == "different" for _, item in overall) else 0
    except (BuildError, RuntimeError) as error:
        print("error: {}".format(error), file=sys.stderr)
        return 2


if __name__ == "__main__":
    sys.exit(main())
