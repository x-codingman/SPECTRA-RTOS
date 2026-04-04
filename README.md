# SPECTRA: Symbolic Pointer Exposure Checking and TRacking Architecture

**SPECTRA** is a symbolic execution-based framework for detecting **Shared Legacy Object Pointers (SLOP)** vulnerabilities in **Real-Time Operating Systems (RTOSs)**. These vulnerabilities arise from exposing internal kernel object pointers to untrusted user threads, even in privilege-separated architectures.

> 📢 This repository is part of an anonymous artifact submission. All identifiers that may reveal authorship have been removed or anonymized.

---

## 🔍 Overview

RTOS kernels often expose internal object pointers (e.g., task descriptors, mutex handles) to user code for performance. However, this legacy practice violates memory isolation in modern deployments and leads to:
- Denial-of-Service (DoS)
- Unauthorized memory access
- Control-flow hijacking

**SPECTRA** addresses this with:
- Hardware-free kernel service harnessing
- Attacker-aware symbolic pointer tracking
- Dual-layer boundary & semantic validation

---

## ⚙️ Features

- ⚡ Lightweight kernel service testing without full RTOS emulation
- 🎯 Under-constrained symbolic execution for attacker-controlled memory tracking
- 🔎 Detection of exploitable pointer dereferences
- 📊 Evaluated on 4 widely-used RTOSs: FreeRTOS, TizenRT, RT-Thread, ThreadX

---

## 🛠️ Architecture

SPECTRA consists of three main phases:

1. **Phase I: Kernel Harness Generation**
   - Strip platform-specific code
   - Compile RTOS as host-executable library
   - Auto-generate test harnesses for kernel services

2. **Phase II: Symbolic Execution**
   - Under-constrained symbolic execution
   - Lazy memory initialization
   - Attacker-aware pointer taint tracking

3. **Phase III: Exploitability Analysis**
   - Boundary + semantic validation
   - Detect DoS, memory access violations, control hijacks

---

## 📁 Repository Structure

```text
.
├── test-rtos/                # RTOS source (e.g., FreeRTOS, ThreadX, TizenRT)
├── lib/                      # Core engine of SPECTRA (symbolic analysis logic)
├── rtos-api-analysis/        # Automation scripts for analysis the vulnerability detection results
├── freertos_10_5_1_test/     # Harnesses and scripts for building and testing FreeRTOS v10.5.1
├── freertos_10_6_0_test/     # Harnesses and scripts for building and testing FreeRTOS v10.6.0 (patched)
├── rt-thread_test/     # Harnesses and scripts for building and testing RT-Thread
├── threadx_test_v6_4_2/      # Harnesses and scripts for building and testing ThreadX v6.4.2
├── tizenRT_test/             # Harnesses and scripts for building and testing TizenRT (commit 3954496)
└── README.md                 # Project documentation (this file)
```


## Tested RTOS Versions

| RTOS      | Version(s)        | CVE Status                              | Patched                                               |
|-----------|-------------------|-----------------------------------------|--------------------------------------------------------|
| FreeRTOS  | 10.5.1 / 10.6.0   | 1 CVE assigned by AWS                   | Yes (patched after 10.6.1)                             |
| TizenRT   | commit 3954496    | Disclosure under review                 | No                                                     |
| RT-Thread | 5.1.0             | 7 CVEs assigned by VulDB                | Partially                                              |
| ThreadX   | 6.4.2             | Requesting CVEs from Eclipse Foundation | Patched internally, planned public release in September |

## 📬 Ethic Consideration
We have reported all identified vulnerable system calls to the corresponding maintainers, and they have acknowledged our findings — including AWS (FreeRTOS), Eclipse Foundation (ThreadX), and RT-Thread. Samsung (TizenRT) is currently reviewing our report. To date, our research has resulted in 8 CVEs assigned by AWS and VulDB~\cite{vuldb}, covering a total of 97 vulnerable system calls across FreeRTOS and RT-Thread. Additionally, the maintainers of ThreadX are in the process of applying for CVEs through the Eclipse Foundation.

## 🧱 Requirements

### 🔧 Hardware Dependencies

- **Processor:** Intel Core i7-8700K (or equivalent)
- **Memory:** ≥ 64 GB RAM (recommended for parallel symbolic execution)
- **Storage:** ≥ 256 GB available disk space

> 💡 Note: Comparable hardware may also suffice. 

---

### 💻 Software Dependencies

- **Operating System:**  
  - Tested on **Ubuntu 24.04 LTS**  
  - Other Linux distributions or OSes are not officially supported or tested.

- **Runtime Environment:**  
  - `git`  
  - `docker` (used for environment isolation and reproducibility)

> 💡 Note: A pre-built Docker image is recommended for artifact evaluation, but is **not currently available** in this version.

## 🚀 Quick Start

### Step 1: Build SPECTRA with KLEE
```
sudo apt-get update
sudo apt-get install google-perftools libgoogle-perftools-dev
mkdir build && cd build
cmake \
  -DCMAKE_CXX_FLAGS_DEBUG="-g" \
  -DCMAKE_C_FLAGS_DEBUG="-g" \
  -DCMAKE_CXX_FLAGS_RELEASE="-O3 -DNDEBUG" \
  -DCMAKE_C_FLAGS_RELEASE="-O3 -DNDEBUG" \
  -DCMAKE_CXX_FLAGS_RELWITHDEBINFO="-O2 -g -DNDEBUG" \
  -DCMAKE_C_FLAGS_RELWITHDEBINFO="-O2 -g -DNDEBUG" \
  -DENABLE_SOLVER_STP=ON \
  -DENABLE_POSIX_RUNTIME=ON \
  -DSTP_DIR=/tmp/stp-2.3.3-install/lib/cmake/STP/ \
  ..
make -j
```

### Step 2: Run SPECTRA on targeted RTOS
Navigate to the directory of the target RTOS test harness (e.g., FreeRTOS 10.5.1):
```
cd freertos_10_5_1_test
python3 run_test.py
```
The run_test.py script automatically invokes SPECTRA on all supported system calls for that RTOS version.


