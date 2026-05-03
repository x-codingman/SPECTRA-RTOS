#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
TizenRT / TinyARA: count pointer-like syscall parameters from syscall.csv.
- [A] Syscalls with at least one kernel-related pointer parameter; syscalls with
    at least one pointer-like parameter.
- [B] Total pointer-like parameter slots, split into kernel vs user.

Usage:
  python3 count_pointer_params.py
  python3 count_pointer_params.py /path/to/syscall.csv

Optional: like the ThreadX script, treat uintptr_t without '*' as a user slot
(COUNT_UINTPTR_AS_USER_POINTER_SLOT; default off).

----------------------------------------------------------------------------
Classification (for papers / reports)

Here "kernel" means **pointers that match a loose heuristic for OS control plane,
objects, or handles** — not "must point into kernel virtual memory". Many matches
live in user memory but are strongly managed by the kernel or a subsystem. "user"
means **mostly data plane**: raw buffers, path strings, typical in/out metadata
(e.g. struct stat*, sockaddr*, timespec*) unless listed below.

  A. Core — typical OS / libc control blocks or synchronization objects
     - struct tcb_s*           task control block
     - struct file_struct*     stdio stream control block (internal sem, buffer)
     - struct streamlist*      per-group stream table (e.g. sched_getstreams)
     - pthread_mutex_t* / cond_t* / attr_t* / mutexattr_t* / pthread_key_t*
     - pthread_t*              e.g. pthread_create output thread id
     - sem_t*                  semaphore object
     - DIR*                    opaque directory stream

  B. Loose extension — counted as kernel by default; storage often user-side but
     treated as kernel-related for parameters that should not be modeled as plain
     byte arrays (MPU / symbolic execution style).
     - timer_t*                timer id out-parameter
     - pthread_addr_t*         e.g. pthread_join result slot
     - struct mq_attr*         message queue attributes
     - struct shmid_ds*        shmctl control structure
     - struct aiocb*           async I/O control block
     - struct sigevent*        async notification registration
     - struct sigaction*       signal disposition
     - sigset_t* / struct siginfo* / siginfo_t*  masks and siginfo buffers
     - struct msghdr*          socket scatter/gather
     - struct pollfd*          poll entries
     - fd_set*                 select bitmasks
     - struct dirent*          directory entry (pairs with DIR)
     - struct symtab_s*        binfmt symbol table

  C. Explicitly user (no dedicated regex; anything not matching kernel is user)
     - void* / char* I/O buffers, pathnames
     - struct stat* / statfs* / sockaddr* / timespec* / timeval* / itimerspec*
     - struct sched_param*, most int* out-parameters (unless listed above)
     - Function pointer types (CODE, (*...) always user

Set USE_LOOSE_KERNEL_HEURISTIC=False to use only class A (stricter object-pointer
notion).
----------------------------------------------------------------------------
"""
import csv
import os
import re
import sys

DEFAULT_CSV = os.path.join(os.path.dirname(os.path.abspath(__file__)), "syscall.csv")

# uintptr_t without '*' as address-wide slot (ThreadX ALIGN_TYPE analogy)
COUNT_UINTPTR_AS_USER_POINTER_SLOT = False

# True: kernel = A core + B loose (default, biases toward counting OS control plane)
# False: kernel = A core only
USE_LOOSE_KERNEL_HEURISTIC = True

# --- A. Core: TCB / stream table / POSIX sync / directory stream ---
_KERNEL_PTR_RES_CORE = (
    r"(?i)\b(?:FAR\s+)?(?:const\s+)?(?:struct\s+)?tcb_s\s*\*",
    r"(?i)\b(?:FAR\s+)?(?:const\s+)?(?:struct\s+)?file_struct\s*\*",
    r"(?i)\b(?:FAR\s+)?(?:const\s+)?(?:struct\s+)?streamlist\s*\*",
    r"(?i)\b(?:FAR\s+)?(?:const\s+)?pthread_mutex_t\s*\*",
    r"(?i)\b(?:FAR\s+)?(?:const\s+)?pthread_cond_t\s*\*",
    r"(?i)\b(?:FAR\s+)?(?:const\s+)?pthread_attr_t\s*\*",
    r"(?i)\b(?:FAR\s+)?(?:const\s+)?pthread_mutexattr_t\s*\*",
    r"(?i)\b(?:FAR\s+)?(?:const\s+)?pthread_key_t\s*\*",
    r"(?i)\b(?:FAR\s+)?pthread_t\s*\*",
    r"(?i)\b(?:FAR\s+)?(?:const\s+)?sem_t\s*\*",
    r"(?i)\b(?:FAR\s+)?DIR\s*\*",
)

# --- B. Loose: handle outs + signal/IPC/AIO/poll/select/VFS control plane ---
_KERNEL_PTR_RES_LOOSE = (
    r"(?i)\btimer_t\s*\*",
    r"(?i)\b(?:FAR\s+)?pthread_addr_t\s*\*",
    r"(?i)\b(?:FAR\s+)?(?:const\s+)?(?:struct\s+)?mq_attr\s*\*",
    r"(?i)\b(?:FAR\s+)?(?:const\s+)?(?:struct\s+)?shmid_ds\s*\*",
    r"(?i)\b(?:FAR\s+)?(?:const\s+)?(?:struct\s+)?aiocb\s*\*",
    r"(?i)\b(?:FAR\s+)?(?:const\s+)?(?:struct\s+)?sigevent\s*\*",
    r"(?i)\b(?:FAR\s+)?(?:const\s+)?(?:struct\s+)?sigaction\s*\*",
    r"(?i)\b(?:FAR\s+)?(?:const\s+)?(?:struct\s+)?siginfo\s*\*",
    r"(?i)\b(?:FAR\s+)?(?:const\s+)?siginfo_t\s*\*",
    r"(?i)\b(?:FAR\s+)?(?:const\s+)?(?:struct\s+)?sigset_t\s*\*",
    r"(?i)\b(?:FAR\s+)?(?:const\s+)?(?:struct\s+)?msghdr\s*\*",
    r"(?i)\b(?:FAR\s+)?(?:const\s+)?(?:struct\s+)?pollfd\s*\*",
    r"(?i)\b(?:FAR\s+)?fd_set\s*\*",
    r"(?i)\b(?:FAR\s+)?(?:const\s+)?(?:struct\s+)?dirent\s*\*",
    r"(?i)\b(?:FAR\s+)?(?:const\s+)?(?:struct\s+)?symtab_s\s*\*",
)

_KERNEL_OBJECT_PTR_RES = _KERNEL_PTR_RES_CORE + (
    _KERNEL_PTR_RES_LOOSE if USE_LOOSE_KERNEL_HEURISTIC else ()
)
_KERNEL_OBJECT_PTR_TYPE = re.compile("|".join(f"({p})" for p in _KERNEL_OBJECT_PTR_RES))


def is_pointer_like_type(s: str) -> bool:
    """One CSV type fragment: explicit pointer, function pointer, or array param (e.g. int [2])."""
    t = s.strip()
    if not t or t == "...":
        return False
    if re.search(r"\(\s*\*", t):
        return True
    if "*" in t:
        return True
    if re.search(r"\[[^\]]*\]", t):
        return True
    if COUNT_UINTPTR_AS_USER_POINTER_SLOT and re.search(
        r"\buintptr_t\b", t, re.I
    ):
        return True
    return False


def classify_pointer_type(type_str: str) -> str:
    """
    kernel: matches _KERNEL_OBJECT_PTR_RES (core +/- loose; see module docstring).
    Otherwise user (e.g. FAR char*, struct stat*, sockaddr*).
    """
    p = re.sub(r"\s+", " ", type_str.strip())
    if re.search(r"\(\s*\*", p):
        return "user"
    if _KERNEL_OBJECT_PTR_TYPE.search(p):
        return "kernel"
    return "user"


def _cell_has_pointer_and_classify(cell: str):
    """
    One CSV cell may list A|B alternatives; that is still one parameter slot.
    The slot is pointer-like if any variant is; kernel if any variant classifies kernel.
    """
    cell = cell.strip()
    if not cell or cell == "...":
        return None, None  # not a pointer slot

    variants = [v.strip() for v in cell.split("|")]
    ptr_variants = [v for v in variants if is_pointer_like_type(v)]
    if not ptr_variants:
        if COUNT_UINTPTR_AS_USER_POINTER_SLOT and any(
            re.search(r"\buintptr_t\b", v, re.I) for v in variants
        ):
            return "user", "uintptr_t slot"
        return None, None

    kinds = [classify_pointer_type(v) for v in ptr_variants]
    kind = "kernel" if "kernel" in kinds else "user"
    return kind, cell


def process_syscall_csv(csv_path, output_txt, pointer_txt):
    functions_dump = []
    pointer_dump = []

    total_syscalls = 0
    syscalls_with_any_pointer = 0
    syscalls_with_kernel_ptr = 0

    total_slots = 0
    kernel_slots = 0
    user_slots = 0

    with open(csv_path, newline="", encoding="utf-8", errors="replace") as f:
        reader = csv.reader(f)
        for row in reader:
            if not row or not row[0].strip():
                continue
            name = row[0].strip()
            if len(row) < 4:
                continue

            ret = row[3].strip() if len(row) > 3 else "int"
            raw_params = [c.strip() for c in row[4:] if c.strip()]
            param_cells = [c for c in raw_params if c != "..."]

            total_syscalls += 1
            pseudo_decl = f"{ret} {name}({', '.join(raw_params)})"
            functions_dump.append(f"Syscall: {name}\n  {pseudo_decl}\n")

            this_kernel = False
            this_any = False
            ptr_lines = []

            for cell in param_cells:
                if cell == "...":
                    continue
                r = _cell_has_pointer_and_classify(cell)
                if r[0] is None:
                    continue
                kind, _ = r
                this_any = True
                total_slots += 1
                if kind == "kernel":
                    kernel_slots += 1
                    this_kernel = True
                else:
                    user_slots += 1
                ptr_lines.append(f"    [{kind}] {cell}")

            if this_any:
                syscalls_with_any_pointer += 1
            if this_kernel:
                syscalls_with_kernel_ptr += 1
            if ptr_lines:
                pointer_dump.append(
                    f"Syscall: {name}\n  {pseudo_decl}\n" + "\n".join(ptr_lines) + "\n"
                )

    with open(output_txt, "w", encoding="utf-8") as out:
        out.write(f"Input: {os.path.abspath(csv_path)}\n\n")
        out.write("=== Syscall table (all rows) ===\n\n")
        out.write("\n".join(functions_dump))
        out.write("\n=== Statistics ===\n\n")
        out.write("[A] Syscalls (rows in CSV)\n")
        out.write(f"  Total syscalls: {total_syscalls}\n")
        out.write(
            f"  With at least one kernel-related pointer param "
            f"({'loose' if USE_LOOSE_KERNEL_HEURISTIC else 'core-only'} heuristic): "
            f"{syscalls_with_kernel_ptr}\n"
        )
        out.write(
            f"  With at least one pointer / array / func-ptr param: "
            f"{syscalls_with_any_pointer}\n"
        )
        out.write("\n[B] Parameter slots (pointer-like)\n")
        out.write(f"  Total slots: {total_slots}\n")
        out.write(
            f"    - kernel (OS/control-plane heuristic, see script docstring): "
            f"{kernel_slots}\n"
        )
        out.write(f"    - user (data-plane / unmatched): {user_slots}\n")
        if total_slots:
            out.write(
                f"  Kernel share: {kernel_slots / total_slots * 100:.2f}%\n"
            )
            out.write(
                f"  User share: {user_slots / total_slots * 100:.2f}%\n"
            )
        out.write(
            "\nNotes:\n"
            "  - One CSV column = one logical parameter; A|B counts as one slot.\n"
            "  - Kernel = core + (optional loose); toggle USE_LOOSE_KERNEL_HEURISTIC in script.\n"
            "  - Array parameters (e.g. int [2]) count as pointer-like slots.\n"
        )

    with open(pointer_txt, "w", encoding="utf-8") as out:
        out.write("Syscalls with at least one pointer-like parameter:\n\n")
        out.write("\n".join(pointer_dump))
        out.write("\n--- Totals ---\n")
        out.write(
            f"Syscalls with at least one kernel ptr param: {syscalls_with_kernel_ptr}\n"
        )
        out.write(
            f"Syscalls with at least one pointer slot: {syscalls_with_any_pointer}\n"
        )
        out.write(f"Slots: {total_slots} (kernel {kernel_slots}, user {user_slots})\n")

    print(f"Read: {csv_path}")
    print(f"Total syscalls: {total_syscalls}")
    print(
        f"With pointer params: {syscalls_with_any_pointer} "
        f"({syscalls_with_any_pointer/total_syscalls:.2%})"
    )
    print(
        f"With kernel-related ptr ({'loose' if USE_LOOSE_KERNEL_HEURISTIC else 'core'}): "
        f"{syscalls_with_kernel_ptr} "
        f"({syscalls_with_kernel_ptr/total_syscalls:.2%})"
    )
    print(f"Pointer slots: {total_slots} (kernel {kernel_slots}, user {user_slots})")
    print(f"Wrote: {output_txt}, {pointer_txt}")


if __name__ == "__main__":
    csv_path = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_CSV
    if not os.path.isfile(csv_path):
        print(f"Error: file not found: {csv_path}")
        sys.exit(1)
    base = os.path.dirname(os.path.abspath(__file__))
    process_syscall_csv(
        csv_path,
        os.path.join(base, "syscall_pointer_stats.txt"),
        os.path.join(base, "syscall_pointer_detail.txt"),
    )
