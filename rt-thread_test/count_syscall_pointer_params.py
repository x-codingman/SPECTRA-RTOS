#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
RT-Thread Smart (LWP): count pointer-like parameters on syscalls listed in
lwp_syscall_backup.c (SYSCALL_SIGN table + matching C definitions).

[A] Syscalls (unique names from SYSCALL_SIGN) with at least one kernel-related
    pointer param vs any pointer-like param.
[B] Pointer-like parameter slots: kernel vs user.

Kernel heuristic (see USE_LOOSE_KERNEL_HEURISTIC):
  Core: RT-Thread IPC / object typedefs passed as parameters, e.g. rt_sem_t,
        rt_mutex_t, rt_event_t, rt_mailbox_t, rt_mq_t, rt_timer_t, rt_thread_t,
        rt_device_t, rt_object_t, rt_lwp_t, ... (often pointer-sized handles).

  Loose: same as Tizen-style control-plane structs (pollfd, msghdr, sigaction,
         sigset_t, timer_t*, mq_attr*, etc.) — optional, default on.

  User: void*, char*, struct stat*, timespec*, musl_sockaddr*, and other
        data-plane pointers not matched above. Function-pointer parameters
        (containing '(*') count as user.

Input: default path points at test-rtos/rt-thread/.../lwp_syscall_backup.c
  relative to this directory.

After a run, see rtthread_syscall_pointer_type_audit.txt for distinct type
fragments (parameter types without the name) classified as kernel vs user, with
slot counts, for manual review.

Usage:
  python3 count_syscall_pointer_params.py
  python3 count_syscall_pointer_params.py /path/to/lwp_syscall_backup.c
"""
import os
import re
import sys
from collections import Counter

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
DEFAULT_SYSCALL_C = os.path.normpath(
    os.path.join(SCRIPT_DIR, "..", "test-rtos", "rt-thread", "components", "lwp", "lwp_syscall_backup.c")
)

USE_LOOSE_KERNEL_HEURISTIC = True

_SYSCALL_NAMES_RE = re.compile(r"SYSCALL_SIGN\s*\(\s*(sys_\w+)\s*\)")

# Core: RT-Thread kernel / IPC object parameter types (word-boundary match on decl snippet)
_KERNEL_CORE_RES = (
    r"\brt_sem_t\b",
    r"\brt_mutex_t\b",
    r"\brt_event_t\b",
    r"\brt_mailbox_t\b",
    r"\brt_mq_t\b",
    r"\brt_timer_t\b",
    r"\brt_thread_t\b",
    r"\brt_device_t\b",
    r"\brt_object_t\b",
    r"\brt_lwp_t\b",
    r"\brt_processgroup_t\b",
    r"\brt_channel_msg_t\b",
    r"\brt_session_t\b",
)

# Loose: POSIX / control-plane (optional)
_KERNEL_LOOSE_RES = (
    r"\bstruct\s+pollfd\s*\*",
    r"\bfd_set\s*\*",
    r"\bstruct\s+msghdr\s*\*",
    r"\bconst\s+struct\s+msghdr\s*\*",
    r"\bstruct\s+k_sigaction\s*\*",
    r"\bconst\s+struct\s+k_sigaction\s*\*",
    r"\bstruct\s+sigevent\s*\*",
    r"\bconst\s+struct\s+sigevent\s*\*",
    r"\bsigset_t\s*\*",
    r"\bconst\s+sigset_t\s*\*",
    r"\bsiginfo_t\s*\*",
    r"\bstruct\s+siginfo\s*\*",
    r"\btimer_t\s*\*",
    r"\bstruct\s+mq_attr\s*\*",
    r"\bconst\s+struct\s+mq_attr\s*\*",
    r"\bstruct\s+shmid_ds\s*\*",
    r"\bstruct\s+aiocb\s*\*",
    r"\bstruct\s+libc_dirent\s*\*",
)

_KERNEL_TYPE_PARTS = _KERNEL_CORE_RES + (
    _KERNEL_LOOSE_RES if USE_LOOSE_KERNEL_HEURISTIC else ()
)
_KERNEL_TYPE_RE = re.compile(
    "|".join(f"(?:{p})" for p in _KERNEL_TYPE_PARTS),
    re.I,
)
# IPC/object typedefs are pointer-sized handles but often appear without '*' in sources.
_RT_IPC_HANDLE_RE = re.compile(
    "|".join(f"(?:{p})" for p in _KERNEL_CORE_RES),
    re.I,
)
# Core-only (excludes loose POSIX/control-plane patterns) for audit bucketing.
_KERNEL_CORE_ONLY_RE = re.compile(
    "|".join(f"(?:{p})" for p in _KERNEL_CORE_RES),
    re.I,
)


def ordered_syscall_names(content: str):
    seen = set()
    out = []
    for m in _SYSCALL_NAMES_RE.finditer(content):
        n = m.group(1)
        if n not in seen:
            seen.add(n)
            out.append(n)
    return out


def extract_params_balanced(content: str, name: str):
    """
    Find 'return_type name(' using a definition-like prefix, then slice the
    parameter list with balanced parentheses.
    """
    esc = re.escape(name)
    # Allow "void *foo" as well as "void * foo" before the syscall name.
    m = re.search(
        rf"(?:^|\n)\s*([A-Za-z_][\w\s\*\d_:,]*?)\s*\*?\s*{esc}\s*\(",
        content,
        re.MULTILINE,
    )
    if not m:
        return None, None
    ret = " ".join(m.group(1).split())
    open_paren = m.end() - 1
    depth = 0
    k = open_paren
    n = len(content)
    while k < n:
        c = content[k]
        if c == "(":
            depth += 1
        elif c == ")":
            depth -= 1
            if depth == 0:
                params = content[open_paren + 1 : k].strip()
                return ret, params
        k += 1
    return None, None


def split_param_list(params: str):
    if not params.strip() or params.strip() == "void":
        return []
    parts = []
    depth = 0
    cur = []
    for ch in params:
        if ch == "(":
            depth += 1
            cur.append(ch)
        elif ch == ")":
            depth = max(0, depth - 1)
            cur.append(ch)
        elif ch == "," and depth == 0:
            p = "".join(cur).strip()
            if p and p != "...":
                parts.append(p)
            cur = []
        else:
            cur.append(ch)
    tail = "".join(cur).strip()
    if tail and tail != "...":
        parts.append(tail)
    return parts


def _param_type_fragment(param: str) -> str:
    param = param.strip()
    if not param:
        return ""
    parts = param.rsplit(" ", 1)
    if len(parts) == 2 and re.match(r"^[a-zA-Z_]\w*$", parts[1]):
        return parts[0].strip()
    return param


def is_pointer_like_param(param: str) -> bool:
    if not param or param.strip().lower() == "void" or param.strip() == "...":
        return False
    frag = _param_type_fragment(param)
    if _RT_IPC_HANDLE_RE.search(frag):
        return True
    if re.search(r"\(\s*\*", param):
        return True
    if "*" in param:
        return True
    if re.search(r"\[[^\]]*\]", param):
        return True
    return False


def is_kernel_related_param(param: str) -> bool:
    if not is_pointer_like_param(param):
        return False
    frag = _param_type_fragment(param)
    if re.search(r"\(\s*\*", frag):
        return False
    return bool(_KERNEL_TYPE_RE.search(frag))


def _audit_type_key(param: str) -> str:
    """Type fragment only, whitespace collapsed (for grouping)."""
    frag = _param_type_fragment(param)
    return " ".join(frag.split())


def _is_kernel_core_type_fragment(frag: str) -> bool:
    if re.search(r"\(\s*\*", frag):
        return False
    return bool(_KERNEL_CORE_ONLY_RE.search(frag))


def _write_type_audit(
    path: str,
    kernel_core: Counter,
    kernel_loose: Counter,
    user_types: Counter,
    loose_enabled: bool,
):
    lines = [
        f"Input: {os.path.abspath(path)}",
        "",
        "Type fragments = parameter type without the variable name (heuristic split).",
        "Counts = pointer-like parameter slots across resolved syscalls.",
        "",
        "=== Kernel — core (RT-Thread _KERNEL_CORE_RES: rt_sem_t, rt_mutex_t, ...) ===",
    ]
    for t, c in kernel_core.most_common():
        lines.append(f"  {c:4d}  {t}")
    if not kernel_core:
        lines.append("  (none)")
    lines.append("")
    if loose_enabled:
        lines.append(
            "=== Kernel — loose (USE_LOOSE_KERNEL_HEURISTIC: pollfd*, sigaction*, ... ) ==="
        )
        for t, c in kernel_loose.most_common():
            lines.append(f"  {c:4d}  {t}")
        if not kernel_loose:
            lines.append("  (none)")
    else:
        lines.append("=== Kernel — loose === (disabled; enable USE_LOOSE_KERNEL_HEURISTIC)")
    lines.append("")
    lines.append("=== User (pointer-like slots not classified as kernel) ===")
    for t, c in user_types.most_common():
        lines.append(f"  {c:4d}  {t}")
    if not user_types:
        lines.append("  (none)")
    lines.append("")
    lines.append("=== Summary ===")
    lines.append(f"  Distinct core kernel types: {len(kernel_core)}")
    if loose_enabled:
        lines.append(f"  Distinct loose kernel types: {len(kernel_loose)}")
    lines.append(f"  Distinct user types: {len(user_types)}")
    lines.append("")
    lines.append(
        "Manual review: move misclassified types by editing _KERNEL_CORE_RES / "
        "_KERNEL_LOOSE_RES or classification logic in count_syscall_pointer_params.py."
    )
    audit_path = os.path.join(SCRIPT_DIR, "rtthread_syscall_pointer_type_audit.txt")
    with open(audit_path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")
    return audit_path


def process_file(path: str):
    with open(path, "r", encoding="utf-8", errors="replace") as f:
        content = f.read()

    names = ordered_syscall_names(content)
    stats_path = os.path.join(SCRIPT_DIR, "rtthread_syscall_pointer_stats.txt")
    detail_path = os.path.join(SCRIPT_DIR, "rtthread_syscall_pointer_detail.txt")

    kernel_core_types = Counter()
    kernel_loose_types = Counter()
    user_types = Counter()

    total = len(names)
    funcs_any_ptr = 0
    funcs_kernel = 0
    slots = 0
    kernel_slots = 0
    user_slots = 0
    missing_def = []
    detail_blocks = []

    for name in names:
        ret_type, param_str = extract_params_balanced(content, name)
        if param_str is None:
            missing_def.append(name)
            continue
        plist = split_param_list(param_str)
        ptrs = [p for p in plist if is_pointer_like_param(p)]
        if not ptrs:
            continue
        funcs_any_ptr += 1
        lines = [
            f"Syscall: {name}",
            f"  {ret_type} {name}({param_str})",
        ]
        this_k = False
        for p in ptrs:
            slots += 1
            key = _audit_type_key(p)
            if is_kernel_related_param(p):
                kernel_slots += 1
                this_k = True
                lines.append(f"    [kernel] {p}")
                frag = _param_type_fragment(p)
                if _is_kernel_core_type_fragment(frag):
                    kernel_core_types[key] += 1
                else:
                    kernel_loose_types[key] += 1
            else:
                user_slots += 1
                lines.append(f"    [user] {p}")
                user_types[key] += 1
        if this_k:
            funcs_kernel += 1
        detail_blocks.append("\n".join(lines) + "\n")

    with open(stats_path, "w", encoding="utf-8") as out:
        out.write(f"Input: {os.path.abspath(path)}\n\n")
        out.write("=== Statistics ===\n\n")
        out.write("[A] Syscalls (unique SYSCALL_SIGN names)\n")
        out.write(f"  Total in table: {total}\n")
        out.write(f"  Definitions found in this file: {total - len(missing_def)}\n")
        if missing_def:
            out.write(f"  Missing definition match: {len(missing_def)}\n")
            for n in missing_def:
                out.write(f"    - {n}\n")
        out.write(
            f"  With at least one pointer-like parameter: {funcs_any_ptr}\n"
        )
        out.write(
            f"  With at least one kernel-related pointer param "
            f"({'loose' if USE_LOOSE_KERNEL_HEURISTIC else 'core-only'}): "
            f"{funcs_kernel}\n"
        )
        out.write("\n[B] Pointer-like parameter slots (syscalls that have any)\n")
        out.write(f"  Total slots: {slots}\n")
        out.write(f"    - kernel: {kernel_slots}\n")
        out.write(f"    - user: {user_slots}\n")
        if slots:
            out.write(f"  Kernel share: {kernel_slots / slots * 100:.2f}%\n")
        out.write(
            "\nNotes:\n"
            "  - Kernel = RT-Thread object typedefs (+ optional loose POSIX/control-plane).\n"
            "  - Definition match requires a C return type at line start (avoids @see comments).\n"
            "  - Type list for manual review: rtthread_syscall_pointer_type_audit.txt\n"
        )

    audit_path = _write_type_audit(
        path,
        kernel_core_types,
        kernel_loose_types,
        user_types,
        USE_LOOSE_KERNEL_HEURISTIC,
    )

    with open(detail_path, "w", encoding="utf-8") as out:
        out.write("Syscalls with pointer-like parameters:\n\n")
        out.write("\n".join(detail_blocks))
        out.write("\n--- Totals ---\n")
        out.write(f"Kernel-related pointer syscalls: {funcs_kernel}\n")
        out.write(f"Slots: {slots} (kernel {kernel_slots}, user {user_slots})\n")

    print(f"Read: {path}")
    print(f"Unique SYSCALL_SIGN syscalls: {total}")
    print(f"Definitions resolved: {total - len(missing_def)}")
    if missing_def:
        print(f"Missing ({len(missing_def)}): {', '.join(missing_def[:10])}" + (" ..." if len(missing_def) > 10 else ""))
    print(
        f"Syscalls with pointer params: {funcs_any_ptr} "
        f"({funcs_any_ptr / total:.2%} of table)" if total else "Syscalls with pointer params: 0"
    )
    print(
        f"With kernel-related pointer params: {funcs_kernel} "
        f"({funcs_kernel / total:.2%} of table)" if total else "With kernel-related pointer params: 0"
    )
    print(f"Pointer slots: {slots} (kernel {kernel_slots}, user {user_slots})")
    print(
        f"Type audit: {len(kernel_core_types)} core + {len(kernel_loose_types)} loose "
        f"kernel types, {len(user_types)} user types (see file)"
    )
    print(f"Wrote: {stats_path}, {detail_path}, {audit_path}")


def main():
    path = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_SYSCALL_C
    if not os.path.isfile(path):
        print(f"Error: file not found: {path}")
        sys.exit(1)
    process_file(path)


if __name__ == "__main__":
    main()
