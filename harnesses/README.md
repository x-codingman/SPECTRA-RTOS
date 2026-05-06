# RTOS harness workspaces

Each subdirectory is a **self-contained front end** for one RTOS revision: harness sources, build glue, and batch drivers that invoke the patched KLEE binary on generated `.test.bc` files under `test_bc_files/`.

| Directory | Kernel source (under `test-rtos/`) |
|-----------|-------------------------------------|
| `freertos-10.5.1/` | `freertos-10.5.1/` |
| `freertos-10.6.0/` | `freertos-10.6.0/` (nested FreeRTOS tree as vendored) |
| `rt-thread/` | `rt-thread/` |
| `threadx-6.4.2/` | `threadx-6.4.2/` |
| `tizenrt/` | `tizenrt/` |

Scripts resolve the **repository root** as `Path(__file__).resolve().parents[2]` (two levels below `harnesses/<name>/`).

Repo structure: [README.md](../README.md) (repository layout).
