# SPECTRA (anonymous artifact)

**SPECTRA** detects **Shared Legacy Isolation-breaking Pointers (SLIP)**: kernel-internal object pointers exposed to untrusted threads in privilege-separated RTOS designs.

This tree ships a customized **KLEE** engine, **`harnesses/`** workspaces per RTOS revision, and **`rtos-api-analysis/`** for aggregating results—intended for anonymous artifact review.

## Documentation

| Resource | Description |
|----------|-------------|
| **[`docs/` index](docs/README.md)** | Separates upstream KLEE docs from artifact docs. |
| **[Artifact docs index](docs/spectra-artifact/README.md)** | Reading order. |
| **[Repository layout](docs/spectra-artifact/repository-layout.md)** | Layers and directory reference. |
| **[Naming conventions](docs/spectra-artifact/naming-conventions.md)** | `harnesses/` layout, RTOS keys, path rules. |
| **[Harnesses index](harnesses/README.md)** | Table of per-RTOS directories. |

## Quick orientation

| Layer | Location |
|-------|----------|
| Symbolic engine (KLEE-derived) | `lib/`, `include/`, `runtime/`, `tools/`, `scripts/`, `test/`, … |
| Vendored RTOS sources | `test-rtos/` |
| Harnesses & drivers | `harnesses/freertos-10.5.1/`, `harnesses/freertos-10.6.0/`, `harnesses/rt-thread/`, `harnesses/threadx-6.4.2/`, `harnesses/tizenrt/` |
| Spreadsheets / figures | `rtos-api-analysis/` |

## Ethics

Findings were disclosed to maintainers. CVE and disclosure details belong in the paper / submission narrative.
