# SPECTRA (anonymous artifact)

## Repository layout

| Location | Contents |
|----------|----------|
| **Root** (`CMakeLists.txt`, `include/`, `lib/`, `runtime/`, `tools/`, …) | **SPECTRA**'s customized **KLEE** engine: sources and build layout. |
| **`harnesses/`** | Per-RTOS harness workspaces ([harnesses/README.md](harnesses/README.md)). |
| **`test-rtos/`** | Vendored RTOS kernel trees the harnesses build against. |
| **`rtos-api-analysis/`** | Scripts and helpers to aggregate or inspect analysis outputs. |
| **`examples/`**, **`test/`**, **`unittests/`** | KLEE examples and tests shipped with the engine. |
| **`scripts/`**, **`utils/`** | Build and utility scripts. |

This tree is for anonymous artifact review only; it does not include step-by-step reproduction instructions.
