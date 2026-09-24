# Research Scope and Ethics

This repository is used for ethical academic systems research and analysis
intended to improve the correctness, robustness, and reliability of RTOS
implementations.

This is authorized academic security research on a local RTOS repository that
the researcher is permitted to assess.

- Scope: `/tmp/klee_src` and its KLEE implementation, RTOS source trees,
  harnesses, generated IR/bitcode, and local experimental results.
- Goal: Defensive vulnerability analysis and patch validation.
- Allowed: Static analysis, local harness execution, and minimal reproduction.
- Excluded: External scanning, credential access, persistence, or production
  systems.
- Stop condition: Produce evidence, root cause, and a defensive fix.

- Conduct experiments only in the isolated, controlled research environment
  provided for this project and on systems, images, and source code that are
  authorized for testing.
- Treat systems analysis, harness generation, symbolic execution, and
  reproduction work as academic research conducted within the authorized
  environment. Do not target production systems, third-party deployments, or
  infrastructure outside that environment.
- Minimize unnecessary impact and preserve existing source trees, experimental
  results, and user data unless a task explicitly requires changing them.
- Validate findings carefully and responsibly document and report identified
  issues through the appropriate channels before public disclosure.
- Describe results accurately, distinguishing confirmed system issues from
  modeling artifacts, failed analyses, and candidates that still require
  semantic validation.
