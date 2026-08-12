# RTOS IR reproduction

This directory replaces the experiment Makefiles' absolute paths with one LLVM
11 pipeline and compares every generated module with the checked-in baseline.

## Versions and reproduction level

| Name | Source used by the experiment | Reproduction level |
| --- | --- | --- |
| FreeRTOS | 10.5.1 (the request's `5.1` is the repository's `10.5.1`) | kernel and harness rebuilt from C |
| ThreadX | 6.4.2, commit `06dabb0` | kernel, module manager, wrapper and harness rebuilt from C after `experiment.patch` |
| RT-Thread | 5.2.0, commit `5b33206` | historical kernel/harness IR relinked and pruned |
| TizenRT | commit `3954496`, `stm32h745zi-nucleo/hello` | harness rebuilt from C and linked with the experiment's pruned kernel aggregate |

If `FreeRTOS 5.1` means the historical 5.1.0 release rather than the repository
directory `freertos-10.5.1`, that source and a matching baseline are not present
here. The FreeRTOS result below applies only to 10.5.1.

RT-Thread cannot currently be rebuilt fully from C: its compile database names
an unavailable `x86_64-linux-musl-cross` sysroot. TizenRT's checked-in
`all.test.bc` is already a selected/pruned aggregate, and the original full
kernel compile database is not present. The script reports these two modes
explicitly instead of describing them as full source rebuilds.

The checked-in TizenRT IR predates a later change that made the harness
`up_assert` stub call `klee_terminate_state`. The harness stub is kept empty so
the source again matches the current experiment IR.

## Source checkouts

The parent repository records RT-Thread and TizenRT as gitlinks, so create or
mount the exact revisions at these paths. ThreadX 6.4.2 is also expected there:

```text
test-rtos/threadx-6.4.2  06dabb0ad0403f59889ce85eeb3d48dbd9d3759b
test-rtos/rt-thread      5b3320624da5149fc21c2d3e1f321d855e3d0dfe
test-rtos/tizenrt        39544961e865be55cacd4b58c6240b959b68c096
```

For a fresh parent checkout (the gitlinks have no `.gitmodules` entries), the
three trees can be populated explicitly:

```sh
git clone https://github.com/eclipse-threadx/threadx.git test-rtos/threadx-6.4.2
git -C test-rtos/threadx-6.4.2 checkout 06dabb0ad0403f59889ce85eeb3d48dbd9d3759b
git clone https://github.com/RT-Thread/rt-thread.git test-rtos/rt-thread
git -C test-rtos/rt-thread checkout 5b3320624da5149fc21c2d3e1f321d855e3d0dfe
git clone https://github.com/Samsung/TizenRT.git test-rtos/tizenrt
git -C test-rtos/tizenrt checkout 39544961e865be55cacd4b58c6240b959b68c096
```

The ThreadX experiment patch is applied automatically when necessary. TizenRT
is configured automatically with `stm32h745zi-nucleo/hello`. The RT-Thread
patch is retained in `harnesses/rt-thread/experiment.patch` for a future full
source rebuild once the matching musl sysroot is available.

## Usage

Build one representative test per RTOS:

```sh
python3 scripts/rtos-ir/reproduce.py freertos --sample test_MPU_eTaskGetState
python3 scripts/rtos-ir/reproduce.py threadx --sample block_allocate
python3 scripts/rtos-ir/reproduce.py rt-thread --sample sys_accept \
  --rt-thread-build /path/to/rt-thread/bsp/qemu-vexpress-a9
python3 scripts/rtos-ir/reproduce.py tizenrt --sample _exit
```

Omit `--sample` to build every harness. To build all four in one invocation,
use `all` and provide `--rt-thread-build`. Outputs go under `reproduced-ir/`;
each RTOS gets a `manifest.json` containing hashes and comparison results.
Set `LLVM_BIN` or pass `--toolchain /path/to/llvm-11/bin` when LLVM 11 is not
on `PATH`.

`exact` means identical SHA-256. `structural` means target, data layout,
defined/undefined symbols, per-function opcode sequences, and direct call graph
match after ignoring debug paths, metadata numbering, and linked LLVM type
numbering. The comparison also recognizes Clang's optional O0-only `main`
return slot by its allocation and zero-initialization data flow. `different`
makes the command fail.

## Verified result

The complete harness sets were rebuilt or relinked in the isolated worktree
with LLVM 11 and compared with the current experiment modules:

| RTOS | Tests | Exact | Structural | Different |
| --- | ---: | ---: | ---: | ---: |
| FreeRTOS 10.5.1 | 105 | 0 | 105 | 0 |
| ThreadX 6.4.2 | 96 | 0 | 96 | 0 |
| RT-Thread 5.2.0 | 205 | 52 | 153 | 0 |
| TizenRT 3.1 | 161 | 0 | 161 | 0 |

Generated modules are intentionally ignored by git. Re-running the commands
produces the per-test hashes and status in each `manifest.json`.
