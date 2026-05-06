# Repository layout

Canonical map of the **top-level** tree. Paths are relative to the repository root.

## 1. Layered view

```
┌─────────────────────────────────────────────────────────────┐
│ Symbolic engine (KLEE-derived)                                 │
│ lib/ include/ runtime/ tools/ scripts/ cmake/ …               │
└─────────────────────────────┬───────────────────────────────┘
                              │ produces build/bin/klee
                              ▼
┌─────────────────────────────────────────────────────────────┐
│ harnesses/<rtos-revision>/                                   │
│ Per-RTOS workspaces (generators, Makefile, run_test.py, …)    │
└─────────────────────────────┬───────────────────────────────┘
                              │ consumes test-rtos/
                              ▼
┌─────────────────────────────────────────────────────────────┐
│ test-rtos/                                                   │
│ Vendored RTOS sources                                        │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│ rtos-api-analysis/                                           │
│ Offline aggregation / plots on KLEE outputs                  │
└─────────────────────────────────────────────────────────────┘
```

## 2. Directory reference

### 2.1 Symbolic engine (KLEE base)

| Path | Purpose |
|------|---------|
| `lib/` | Core interpreter and analysis libraries. |
| `include/` | Public headers (`klee/`). |
| `runtime/` | POSIX / intrinsic runtimes linked into bitcode. |
| `tools/` | Drivers (e.g. `klee` executable). |
| `scripts/` | Build and regression helpers. |
| `test/` | LLVM lit tests for the engine. |
| `unittests/` | Engine C++ unit tests. |
| `cmake/` | CMake modules. |
| `examples/` | Small upstream examples. |
| `utils/` | Shared utilities. |
| `nlohmann_json/` | Bundled JSON dependency. |
| `test_files/` | Small inputs for core tooling/tests. |
| `CMakeLists.txt` | Root CMake. |
| `CHANGELOG.md` | Changelog. |

### 2.2 Vendored kernels

| Path | Purpose |
|------|---------|
| `test-rtos/` | Third-party RTOS trees; large, mostly unmodified. |

### 2.3 Harness workspaces (`harnesses/`)

See also [`harnesses/README.md`](../../harnesses/README.md).

| Path | RTOS target |
|------|-------------|
| `harnesses/freertos-10.5.1/` | FreeRTOS 10.5.1 |
| `harnesses/freertos-10.6.0/` | FreeRTOS 10.6.0 |
| `harnesses/rt-thread/` | RT-Thread |
| `harnesses/threadx-6.4.2/` | ThreadX 6.4.2 |
| `harnesses/tizenrt/` | TizenRT |

### 2.4 Evaluation tooling

| Path | Purpose |
|------|---------|
| `rtos-api-analysis/` | Python pipeline: spreadsheets and figures from KLEE `info` / `test_info` style logs. Default outputs: `rtos-api-analysis/results/`. |

### 2.5 Container and assets

| Path | Purpose |
|------|---------|
| `Dockerfile` | Container recipe (build reproducibility). |
| `DESIGN.assets/` | Figures for design notes. |

### 2.6 Repository metadata

Examples: `.github/`, `.cirrus.yml`, `.clang-format`, `.gitignore`, `.gitmodules`.

