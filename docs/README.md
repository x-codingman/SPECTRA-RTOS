# Documentation directory (`docs/`)

This folder contains **two disjoint documentation tracks**.

## 1. Upstream KLEE (Doxygen and SMT benchmarks)

Sources such as **`overview`**, **`intro`** (typically without `.md`), **`doxygen.cfg.in`**, and **`SMT-COMP/`** belong to **upstream KLEE**. They feed the CMake Doxygen target and solver competition artifacts.

**Do not** move or rename these files unless you are reconciling with upstream.

## 2. SPECTRA artifact (Markdown, reviewer-facing)

**[`spectra-artifact/`](spectra-artifact/README.md)** holds **project-specific** documentation:

- Repository layout and mental model
- Naming conventions for harness directories and analysis keys
- Reading order for anonymous artifact evaluation

The **repository root** [`README.md`](../README.md) links here for navigation.

RTOS harness workspaces live under **[`harnesses/`](../harnesses/README.md)** (not in this `docs/` tree).
