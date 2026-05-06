# SPECTRA artifact documentation

Documentation for **this repository snapshot** (SPECTRA + patched KLEE + RTOS harnesses). It is intentionally separate from upstream KLEE Doxygen inputs in the parent `docs/` folder (e.g. `overview`, `intro`).

## Reading order

1. **[Harnesses index](../../harnesses/README.md)** — Table of `harnesses/<rtos>/` directories.
2. **[Repository layout](repository-layout.md)** — Engine, `harnesses/`, `test-rtos/`, and analysis tooling.
3. **[Naming conventions](naming-conventions.md)** — Kebab-case harness names, RTOS keys, `parents[2]` path rule.

## Relation to upstream KLEE docs

| Location | Role |
|---------|------|
| `docs/overview`, `docs/intro`, … | **Upstream** KLEE design notes consumed by Doxygen. |
| `docs/spectra-artifact/` (this tree) | **Artifact-specific** orientation for reviewers and reproducibility wrappers. |

## Ethics note

Findings were reported to the relevant maintainers. Exact CVE counts and disclosure status belong in the paper / submission narrative, not duplicated here.

