#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
FreeRTOS (MPU_* wrappers): count pointer-like parameters in funcs.txt.

[A] Functions with at least one FreeRTOS kernel-handle parameter vs any pointer-like param.
[B] Pointer-like parameter slots split into kernel vs user.

Classification (see also KERNEL_HANDLE_TYPE):
  kernel — parameter type names a FreeRTOS *Handle_t (TaskHandle_t, QueueHandle_t,
           TimerHandle_t, EventGroupHandle_t, StreamBufferHandle_t, QueueSetHandle_t,
           QueueSetMemberHandle_t, ...). Handles are typedef'd pointers to kernel objects;
           parameters may omit '*' in the source text.

  user   — other pointer-like parameters: void*, char*, user buffers (StackType_t*,
           StaticQueue_t*, TaskStatus_t*, TickType_t*, uint8_t*, ...), and typedefs that
           look like pointers via '*' or *_t* heuristics but are not *Handle_t.

Function pointers (e.g. TaskFunction_t) are not counted as pointer parameters unless
the declaration uses a '*' form.

Usage:
  python3 count-pointer-param.py
  python3 count-pointer-param.py /path/to/funcs.txt
"""
import os
import re
import sys

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
DEFAULT_FUNCS = os.path.join(SCRIPT_DIR, "funcs.txt")

# Matches FreeRTOS object handle typedefs (…Handle_t).
KERNEL_HANDLE_TYPE = re.compile(r"\b[A-Za-z_]\w*Handle_t\b")

# Start of a C-like declaration: return type, function name, '('
_DECL_START = re.compile(r"([\w\s\*\d_]+?)\s+(\w+)\s*\(")


def _flatten_for_parse(text: str) -> str:
    """Join lines so multiline parameter lists stay one logical string."""
    return re.sub(r"[\r\n]+", " ", text)


def parse_declarations(text: str):
    """
    Scan flattened source with balanced parentheses so nested ')' in params
    (e.g. function types) does not truncate the list.
    """
    flat = _flatten_for_parse(text)
    out = []
    i = 0
    n = len(flat)
    while i < n:
        m = _DECL_START.search(flat, i)
        if not m:
            break
        rt = m.group(1).strip()
        fn = m.group(2)
        open_paren = m.end() - 1
        depth = 0
        k = open_paren
        while k < n:
            c = flat[k]
            if c == "(":
                depth += 1
            elif c == ")":
                depth -= 1
                if depth == 0:
                    params = flat[open_paren + 1 : k].strip()
                    k += 1
                    while k < n and flat[k].isspace():
                        k += 1
                    if k < n and flat[k] == ";":
                        out.append((rt, fn, params))
                        i = k + 1
                        break
            k += 1
        else:
            break
    return out


def is_pointer_param(param: str) -> bool:
    """True if param is treated as pointer-like (legacy heuristic for this test set)."""
    if not param or param.strip().lower() == "void":
        return False
    parts = param.strip().rsplit(" ", 1)
    type_part = parts[0] if len(parts) > 1 else param.strip()
    name_part = parts[1] if len(parts) > 1 else ""
    return bool(
        "*" in type_part
        or type_part.endswith("Handle_t")
        or name_part.endswith("Handle_t")
        or re.search(r"_t\s*\*$", type_part)
        or re.search(r"_t\s*\*$", name_part)
    )


def is_kernel_handle_param(param: str) -> bool:
    """True if the parameter type includes a *Handle_t (FreeRTOS kernel object reference)."""
    if not param or param.strip().lower() == "void":
        return False
    parts = param.strip().rsplit(" ", 1)
    type_part = parts[0] if len(parts) > 1 else param.strip()
    return bool(KERNEL_HANDLE_TYPE.search(type_part))


def split_param_list(params: str):
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
            if p and p.lower() != "void":
                parts.append(p)
            cur = []
        else:
            cur.append(ch)
    tail = "".join(cur).strip()
    if tail and tail.lower() != "void":
        parts.append(tail)
    return parts


def main():
    funcs_path = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_FUNCS
    if not os.path.isfile(funcs_path):
        print(f"Error: file not found: {funcs_path}")
        sys.exit(1)

    with open(funcs_path, "r", encoding="utf-8", errors="replace") as f:
        content = f.read()

    matches = parse_declarations(content)
    total_func_count = len(matches)

    funcs_with_any_pointer = 0
    funcs_with_kernel = 0
    pointer_slots = 0
    kernel_slots = 0
    user_slots = 0

    no_pointer_names = []
    detail_lines = []

    for return_type, func_name, params in matches:
        param_list = split_param_list(params)
        ptr_params = [p for p in param_list if is_pointer_param(p)]
        if not ptr_params:
            no_pointer_names.append(func_name)
            continue

        funcs_with_any_pointer += 1
        lines = [f"Function: {func_name}", f"  {return_type} {func_name}(...)"]
        this_kernel = False
        for p in ptr_params:
            pointer_slots += 1
            if is_kernel_handle_param(p):
                kernel_slots += 1
                this_kernel = True
                lines.append(f"    [kernel] {p}")
            else:
                user_slots += 1
                lines.append(f"    [user] {p}")
        if this_kernel:
            funcs_with_kernel += 1
        detail_lines.append("\n".join(lines) + "\n")

    stats_path = os.path.join(SCRIPT_DIR, "freertos_pointer_stats.txt")
    detail_path = os.path.join(SCRIPT_DIR, "freertos_pointer_detail.txt")

    with open(stats_path, "w", encoding="utf-8") as out:
        out.write(f"Input: {os.path.abspath(funcs_path)}\n\n")
        out.write("=== Statistics ===\n\n")
        out.write("[A] Functions\n")
        out.write(f"  Total declarations parsed: {total_func_count}\n")
        out.write(
            f"  With at least one pointer-like parameter: {funcs_with_any_pointer}\n"
        )
        out.write(
            f"  With at least one kernel-handle parameter (*Handle_t): {funcs_with_kernel}\n"
        )
        out.write(
            f"  With no pointer-like parameters: {len(no_pointer_names)}\n"
        )
        if total_func_count:
            out.write(
                f"  Pointer function ratio: {funcs_with_any_pointer / total_func_count:.2%}\n"
            )
            out.write(
                f"  Kernel-handle function ratio: {funcs_with_kernel / total_func_count:.2%}\n"
            )
        out.write("\n[B] Pointer-like parameter slots\n")
        out.write(f"  Total slots: {pointer_slots}\n")
        out.write(f"    - kernel (*Handle_t): {kernel_slots}\n")
        out.write(f"    - user (other pointer-like): {user_slots}\n")
        if pointer_slots:
            out.write(
                f"  Kernel slot share: {kernel_slots / pointer_slots * 100:.2f}%\n"
            )
        out.write(
            "\nNotes:\n"
            "  - Kernel = type substring matches *Handle_t (see KERNEL_HANDLE_TYPE).\n"
            "  - Multiline declarations are parsed after newline flattening.\n"
        )

    with open(detail_path, "w", encoding="utf-8") as out:
        out.write("Functions with pointer-like parameters:\n\n")
        out.write("\n".join(detail_lines))
        out.write("\n--- Totals ---\n")
        out.write(f"Functions with kernel-handle params: {funcs_with_kernel}\n")
        out.write(f"Pointer slots: {pointer_slots} (kernel {kernel_slots}, user {user_slots})\n")

    print(f"Read: {funcs_path}")
    print(f"Total declarations parsed: {total_func_count}")
    if total_func_count:
        print(
            f"With pointer-like params: {funcs_with_any_pointer} "
            f"({funcs_with_any_pointer / total_func_count:.2%})"
        )
        print(
            f"With kernel-handle (*Handle_t) params: {funcs_with_kernel} "
            f"({funcs_with_kernel / total_func_count:.2%})"
        )
    else:
        print("With pointer-like params: 0")
        print("With kernel-handle (*Handle_t) params: 0")
    print(f"Pointer slots: {pointer_slots} (kernel {kernel_slots}, user {user_slots})")
    print(f"Wrote: {stats_path}, {detail_path}")
    print("\nFunctions WITHOUT pointer-like parameters:")
    for name in no_pointer_names:
        print(name)


if __name__ == "__main__":
    main()
