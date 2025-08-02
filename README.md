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
- 🎯 Taint-aware symbolic execution for attacker-controlled memory tracking
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
├── rtos/                  # Refined RTOS source trees
├── harnesses/             # Generated test harnesses
├── spectra-core/          # Core engine (symbolic pointer tracker, validator)
├── scripts/               # Automation scripts for build and testing
└── README.md              # Project documentation
```

## 📬 Ethic Consideration


## 🚀 Quick Start
```
# Step 1: Build the RTOS kernel as LLVM bitcode library
cd rtos/freertos
make llvm-lib

# Step 2: Generate a test harness for a system call
python3 scripts/gen_harness.py --rtos freertos --syscall xTaskCreate

# Step 3: Run symbolic execution
klee --spectra-mode harnesses/freertos/xTaskCreate.bc
```