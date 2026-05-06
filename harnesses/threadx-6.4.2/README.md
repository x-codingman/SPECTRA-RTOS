ThreadX 6.4.2 harness build notes:

1. In `makefile`, keep `KERNEL_DIR` pointed at the vendored tree (default: `../../test-rtos/threadx-6.4.2/`) and `KLEE_DIR` at the repository root (`../../`).
2. Run `make -j`, then `make target` to emit harness `.test.bc` files.

Linked module bitcode paths mirror the resolved absolute `KERNEL_DIR` under `./build/common_modules_lib/`.

See also: [Naming conventions](../../docs/spectra-artifact/naming-conventions.md) and [Repository layout](../../docs/spectra-artifact/repository-layout.md).
