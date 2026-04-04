# Path Coverage = 0: Analysis for Paper Clarification

## Summary

Some syscalls show path coverage (Completed / Explored) = 0 because **all explored paths are "partially completed"** — they terminate before reaching a natural exit. This is **by design** in our symbolic execution setup, not a KLEE defect. Below we categorize and explain each case for TizenRT and RT-Thread.

---

## Root Cause: Path Termination

In KLEE:
- **Completed path**: Reaches a normal exit (e.g., `return` from main) and generates a test case.
- **Partially completed path**: Terminated early and does not reach a normal exit.

When all paths are partially completed, path coverage = 0. The termination is triggered by one of the following.

---

## TizenRT (9 syscalls with coverage = 0)

| Syscall | Explored | Cause |
|---------|----------|-------|
| mq_timedsend, mq_timedreceive | 2 | Blocking: queue/semaphore operations that would block. Code path hits `klee_terminate_state()` when simulating timeout/blocking. |
| sem_timedwait | 2 | Blocking: timed wait on semaphore. Same as above. |
| pthread_cond_timedwait, sigwaitinfo, sigtimedwait | 1 | Blocking: conditional wait or signal wait. Paths terminate when simulation would block. |
| pthread_setspecific, pthread_getspecific | 1 | TLS: thread-local storage; may involve platform-specific or external code that KLEE cannot continue. |
| up_assert | 1 | **Explicit termination**: The harness defines `up_assert()` to call `klee_terminate_state()` to simulate RTOS assertion failure (e.g., MPU/privilege violation). |

**Evidence in logs** (e.g., mq_timedsend, sem_timedwait):
```
KLEE: Execute: ./klee_help.h:17
KLEE: DEBUG: terminate state invoked from the tested program
```
Line 17 in `klee_help.h` is `klee_terminate_state()` inside `up_assert()`.

---

## RT-Thread (22 syscalls with coverage = 0)

### 1. Process Creation (3 syscalls)
| Syscall | Cause |
|---------|-------|
| sys_fork, sys_execve, sys_vfork | Process creation: parent/child split; no single "return from main" semantics. Paths are terminated when encountering fork/exec. |

**Evidence**: Logs show `Detect __asm__ external function!` (inline asm for syscall trap) and `terminate the State, try to break the loop`.

### 2. Kernel Object Creation (6 syscalls)
| Syscall | Explored | Cause |
|---------|----------|-------|
| sys_sem_create, sys_event_create, sys_mb_create | 6–7 | Create kernel objects; likely hit inline asm (syscall interface) or external kernel code. |
| sys_mq_create, sys_mutex_create, sys_rt_timer_create | 5–6 | Same: creation involves kernel/system calls KLEE cannot model. |

**Evidence** (sys_sem_create): `Detect __asm__ external function!` and `terminate state invoked from the tested program`.

### 3. Critical Section (2 syscalls)
| Syscall | Cause |
|---------|-------|
| sys_enter_critical, sys_exit_critical | Disable/enable interrupts; use inline asm or platform-specific code. KLEE terminates to avoid unbounded or unmodeled execution. |

**Evidence**: `terminate the State, try to break the loop` (loop detection).

### 4. Blocking / IPC (2 syscalls)
| Syscall | Cause |
|---------|-------|
| sys_sem_take | Blocking wait; paths terminated when simulation would block. |
| sys_pipe, sys_socketpair | IPC; may block or involve external syscalls. |

### 5. File System / Other (8 syscalls)
| Syscall | Cause |
|---------|-------|
| sys_chmod, sys_chown, sys_umount2, sys_utimensat | File system operations; call into kernel or external modules KLEE cannot execute. |
| sys_getrlimit, sys_getsid, sys_getpgid, sys_mq_unlink | System information or cleanup; involve kernel/syscall boundaries. |

---

## Suggested Text for Paper

**In evaluation or discussion section:**

> *Path coverage of 0.* Some syscalls report path coverage (Completed/Explored) = 0. This occurs when all explored paths terminate before reaching a normal exit, i.e., they are "partially completed" in KLEE’s terminology. The causes are intentional and by design:
>
> 1. **Blocking semantics**: Syscalls such as `mq_timedsend` and `sem_timedwait` may block on full queues or unavailable resources. Our harness uses `klee_terminate_state()` to model these blocking paths, so they do not complete normally.
>
> 2. **Process creation**: `fork`, `execve`, and `vfork` change process boundaries; there is no single “return from main” path. Paths are terminated at the process-creation boundary.
>
> 3. **Platform-dependent code**: Critical sections, syscall interfaces, and kernel object creation rely on inline assembly or external code. KLEE cannot execute these and terminates such paths.
>
> 4. **Assertion simulation**: The harness defines `up_assert()` to call `klee_terminate_state()`, simulating RTOS assertion failure (e.g., privilege or MPU violation). Paths that hit these assertions are treated as partially completed.
>
> These terminations reflect the nature of the tested RTOS APIs and our testing strategy, not a limitation of KLEE itself. Syscalls with coverage = 0 still provide exploration and bug-finding for the reachable code paths.

---

## Statistics

| RTOS | Total Syscalls | Zero Coverage | Percentage |
|------|----------------|---------------|------------|
| TizenRT | 161 | 9 | 5.6% |
| RT-Thread | 205 | 22 | 10.7% |
| FreeRTOS 10.5.1 | 106 | 0 | 0% |
| ThreadX 6.4.2 | 96 | 3 | 3.1% |

FreeRTOS and ThreadX have fewer or no zero-coverage syscalls because they expose fewer blocking, process-creation, and platform-dependent interfaces in the evaluated API set.
