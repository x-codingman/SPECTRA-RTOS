#!/usr/bin/env python3
"""Compare LLVM bitcode while ignoring paths, metadata IDs, and type numbering."""

import argparse
import hashlib
import json
import re
import subprocess
import sys
from pathlib import Path


SYMBOL_RE = r'@(?:"([^"]+)"|([-A-Za-z$._0-9]+))'
DEFINE_RE = re.compile(r'^define\b.*?' + SYMBOL_RE + r'\s*\(')
DIRECT_CALL_RE = re.compile(r'\b(?:call|invoke)\b.*?' + SYMBOL_RE + r'\s*\(')
CAST_CALL_RE = re.compile(
    r'\b(?:call|invoke)\b.*?\b(?:bitcast|addrspacecast)\s*\([^@\n]*?'
    + SYMBOL_RE
    + r'\s+to\b'
)
ASSIGN_RE = re.compile(r'^\s*(?:[%@][-A-Za-z$._0-9]+\s*=\s*)?([A-Za-z][A-Za-z0-9._-]*)\b')


def run_output(command):
    process = subprocess.run(
        [str(part) for part in command],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        universal_newlines=True,
    )
    if process.returncode:
        raise RuntimeError(
            "command failed: {}\n{}".format(" ".join(map(str, command)), process.stderr)
        )
    return process.stdout


def sha256(path):
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def symbols(path, llvm_nm, option):
    result = set()
    for line in run_output([llvm_nm, option, path]).splitlines():
        fields = line.split()
        if fields:
            result.add(fields[-1])
    return sorted(result)


def ir_shape(path, llvm_dis):
    text = run_output([llvm_dis, "-o", "-", path])
    target_triple = ""
    data_layout = ""
    current = None
    opcodes = {}
    calls = set()
    main_i32_allocas = {}

    for line in text.splitlines():
        if line.startswith("target triple ="):
            target_triple = line.partition("=")[2].strip().strip('"')
        elif line.startswith("target datalayout ="):
            data_layout = line.partition("=")[2].strip().strip('"')

        match = DEFINE_RE.match(line)
        if match:
            current = match.group(1) or match.group(2)
            opcodes[current] = []
            main_i32_allocas = {}
            continue
        if current is None:
            continue
        if line == "}":
            current = None
            continue

        stripped = line.strip()
        if (
            not stripped
            or stripped.startswith((";", "!"))
            or re.match(r'^(?:[-A-Za-z$._0-9]+|"[^"]+"):\s*(?:;.*)?$', stripped)
        ):
            continue
        instruction = ASSIGN_RE.match(line)
        if instruction:
            opcode = instruction.group(1)
            # Metadata attachments and SSA/type names are intentionally omitted.
            if opcode not in ("attributes", "source_filename", "target"):
                if current == "main":
                    allocation = re.match(
                        r'^\s*(%[-A-Za-z$._0-9]+)\s*=\s*alloca\s+i32\b', line
                    )
                    if allocation and not opcodes[current]:
                        main_i32_allocas[allocation.group(1)] = len(opcodes[current])
                    store = re.match(
                        r'^\s*store\s+i32\s+0,\s+i32\*\s+(%[-A-Za-z$._0-9]+)\b',
                        line,
                    )
                    if store and store.group(1) in main_i32_allocas:
                        index = main_i32_allocas.pop(store.group(1))
                        del opcodes[current][index]
                        for name, old_index in list(main_i32_allocas.items()):
                            if old_index > index:
                                main_i32_allocas[name] = old_index - 1
                        continue
                opcodes[current].append(opcode)
        call = DIRECT_CALL_RE.search(line) or CAST_CALL_RE.search(line)
        if call:
            calls.add((current, call.group(1) or call.group(2)))

    return {
        "target_triple": target_triple,
        "data_layout": data_layout,
        "function_opcodes": {key: value for key, value in sorted(opcodes.items())},
        "direct_calls": [list(item) for item in sorted(calls)],
    }


def summarize(path, llvm_dis, llvm_nm):
    summary = ir_shape(path, llvm_dis)
    summary.update(
        {
            "sha256": sha256(path),
            "defined_symbols": symbols(path, llvm_nm, "--defined-only"),
            "undefined_symbols": symbols(path, llvm_nm, "--undefined-only"),
        }
    )
    return summary


def compare(left, right, llvm_dis="llvm-dis", llvm_nm="llvm-nm"):
    left_summary = summarize(Path(left), llvm_dis, llvm_nm)
    right_summary = summarize(Path(right), llvm_dis, llvm_nm)
    keys = (
        "target_triple",
        "data_layout",
        "defined_symbols",
        "undefined_symbols",
        "function_opcodes",
        "direct_calls",
    )
    differences = [key for key in keys if left_summary[key] != right_summary[key]]
    if left_summary["sha256"] == right_summary["sha256"]:
        status = "exact"
    elif not differences:
        status = "structural"
    else:
        status = "different"
    return {
        "status": status,
        "differences": differences,
        "left": left_summary,
        "right": right_summary,
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("left", type=Path)
    parser.add_argument("right", type=Path)
    parser.add_argument("--llvm-dis", default="llvm-dis")
    parser.add_argument("--llvm-nm", default="llvm-nm")
    parser.add_argument("--json", action="store_true")
    args = parser.parse_args()

    result = compare(args.left, args.right, args.llvm_dis, args.llvm_nm)
    if args.json:
        json.dump(result, sys.stdout, indent=2, sort_keys=True)
        print()
    else:
        print(result["status"])
        if result["differences"]:
            print("differences: {}".format(", ".join(result["differences"])))
    return 0 if result["status"] in ("exact", "structural") else 1


if __name__ == "__main__":
    sys.exit(main())
