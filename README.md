# The SLIP Problem: Detecting Shared Legacy Isolation-breaking Pointers in MCU-Oriented Real-Time Operating Systems

This repository contains [SPECTRA](https://github.com/x-codingman/SPECTRA-RTOS), the research artifact accompanying our NDSS 2027 paper. SPECTRA is a symbolic-execution framework for detecting Shared Legacy Isolation-breaking Pointers (SLIP) vulnerabilities in real-time operating systems (RTOSs).


## Repository layout

| Location | Contents |
|----------|----------|
| **Root** (`CMakeLists.txt`, `include/`, `lib/`, `runtime/`, `tools/`, ...) | **SPECTRA**'s customized **KLEE** engine: source code and build layout. |
| **`harnesses/`** | Per-RTOS harness workspaces ([harnesses/README.md](harnesses/README.md)). |
| **`test-rtos/`** | Vendored RTOS kernel trees the harnesses build against. |
| **`rtos-api-analysis/`** | Scripts and helpers to aggregate or inspect analysis outputs. |
| **`docs/results/`** | Complete per-system-call vulnerability-detection results from the paper, with a PDF table, public CVE identifiers, and structured data. |
| **`examples/`**, **`test/`**, **`unittests/`** | KLEE examples and tests shipped with the engine. |
| **`scripts/`**, **`utils/`** | Build and utility scripts. |

## Full vulnerability-detection results

The complete results for the 210 reported system calls are available as a
[readable table](docs/results/full-vulnerability-results.md), the
[PDF table](docs/results/full-vulnerability-results.pdf), and
[structured JSON data](docs/results/full-vulnerability-results.json).
The table documentation identifies the evaluated RTOS configurations and explains
the category labels and public CVE identifier mappings.

## Docker build (KLEE)

Build the image from the repository root:

```bash
docker build -t spectra-klee:latest -f Dockerfile .
```

Start an interactive container:

```bash
docker run --rm -it spectra-klee:latest bash
```

The `Dockerfile` already configures dependencies and builds KLEE under `/home/klee/klee_src/build`.  
To rebuild manually inside the container:

```bash
cd /home/klee/klee_src
mkdir -p build && cd build
cmake -DENABLE_SOLVER_Z3=ON -DENABLE_POSIX_RUNTIME=ON -DZ3_DIR=/tmp/z3-4.8.15-install/lib/ ..
make -j"$(nproc)"
```

## Run each RTOS harness

General flow for each harness:

1. Build `.test.bc` inputs in the harness directory (`make`).
2. Run symbolic execution batch (`python3 run_test.py`).

Commands:

```bash
# FreeRTOS 10.5.1
cd harnesses/freertos-10.5.1
make -j"$(nproc)"
python3 run_test.py

# FreeRTOS 10.6.0
cd ../freertos-10.6.0
make -j"$(nproc)"
python3 run_test.py

# RT-Thread
cd ../rt-thread
make -j"$(nproc)"
python3 run_test.py

# ThreadX 6.4.2
cd ../threadx-6.4.2
make -j"$(nproc)" target
python3 run_test.py

# TizenRT
cd ../tizenrt
make -j"$(nproc)"
python3 run_test.py
```

All `run_test.py` scripts use `${REPO_ROOT}/build/bin/klee` and write results into each RTOS tree under `test-rtos/*/symbolic_execution/`.
If a harness `makefile` still contains machine-specific absolute paths, update them to your local checkout before running `make`.
