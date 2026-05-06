# Naming conventions

Applies to **SPECTRA artifact** code and docs. Vendor trees under `test-rtos/` are excluded unless explicitly patched.

## 1. Top-level layout

| Namespace | Role |
|-----------|------|
| Engine (`lib/`, `include/`, `runtime/`, …) | **KLEE-derived**; follow existing LLVM/C++ style. |
| `test-rtos/` | **Vendored kernels** — folder names match snapshots (e.g. `freertos-10.5.1`, `rt-thread`, `tizenrt`, `threadx-6.4.2`). |
| `harnesses/<name>/` | **One workspace per evaluated RTOS revision**; `<name>` is **kebab-case** aligned with the kernel folder where possible. |
| `rtos-api-analysis/` | **Offline analysis**; Python modules use `snake_case.py`. |

## 2. Harness folder names

| Directory | `test-rtos` subtree |
|-----------|---------------------|
| `harnesses/freertos-10.5.1/` | `test-rtos/freertos-10.5.1/` |
| `harnesses/freertos-10.6.0/` | `test-rtos/freertos-10.6.0/` |
| `harnesses/rt-thread/` | `test-rtos/rt-thread/` |
| `harnesses/threadx-6.4.2/` | `test-rtos/threadx-6.4.2/` |
| `harnesses/tizenrt/` | `test-rtos/tizenrt/` |

## 3. Logical RTOS keys (Python / spreadsheets)

Hyphenated IDs used in merge scripts and reports:

`freertos-10.5.1`, `freertos-10.6.0`, `rt-thread`, `threadx-6.4.2`, `tizenrt`

Keep these consistent with helpers such as `_symbolic_roots_map()` in `data-analyze-all.py`.

## 4. Path resolution in harness scripts

Harness Python uses:

```text
REPO_ROOT = Path(__file__).resolve().parents[2]
```

because each harness file lives at `harnesses/<rtos>/script.py` (two parents up to the repository root). **Do not** hard-code home-directory prefixes.

## 5. Documentation files

| Location | Convention |
|----------|--------------|
| Repository root `README.md` | Short index with links into `docs/spectra-artifact/`. |
| `docs/spectra-artifact/*.md` | **Lowercase hyphenated** filenames (`repository-layout.md`). |
| Per-harness `README.md` | Optional; use relative links to `docs/spectra-artifact/`. |
| Upstream `docs/overview`, `intro` | KLEE Doxygen sources; do not rename casually. |

## 6. Generated or scratch artifacts

Do not commit:

- `*_temp_output.txt`, `draft.sh`, `*.backup*`, `funcs_new.txt`, `test_files.bk/`, or other duplicate “new/bk” trees. Regenerate from scripts when needed.

## 7. Third-party exceptions

Files under `test-rtos/**` follow upstream naming (including occasional `*new*` in vendor code). Only trim or rename when you intentionally carry a **documented** fork.

