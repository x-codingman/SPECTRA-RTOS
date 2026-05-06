#!/usr/bin/env python3
"""
Annotate ``vulnerability_summary.xlsx`` **in place** (default): refresh MyType rows
(``KO_Related`` / ``KO_Pattern_Detail``) and rebuild ``MyType_KO_Annotation_Stats`` and
``MyType_KO_Impact_Summary``.

Kernel names: ``EMBEDDED_KERNEL_NAMES_BY_RTOS``. Optional ``--patterns-file`` appends
raw regex lines (``name || regex``).
"""

import argparse
import math
import os
import re
import sys
from collections import Counter
from typing import Any, Dict, List, Optional, Sequence, Set, Tuple

# Sheets in vulnerability summary workbook (names ≤ 31 characters for Excel).
MYTYPE_KO_ANNOTATION_STATS_SHEET = "MyType_KO_Annotation_Stats"
MYTYPE_KO_IMPACT_SUMMARY_SHEET = "MyType_KO_Impact_Summary"

# Columns appended to each MyType_* sheet
KO_COL_RELATED = "KO_Related"
KO_COL_DETAIL = "KO_Pattern_Detail"
SHEET_DIRECT = "MyType_Source_Lines"
SHEET_GUARDED = "MyType_Source_Lines_Guarded"

# ---------------------------------------------------------------------------
# Per-RTOS substring keys (matched case-insensitively in RTOS_Project) map to typical
# C identifiers for that RTOS row. Each name becomes a regex word boundary match.
# Rows first try the matched RTOS list; unmatched rows union all RTOS-specific lists.
# Key "*" is merged into every RTOS symbol list for cross-cutting identifiers (e.g. sched).
# ---------------------------------------------------------------------------
GLOBAL_NAME_KEY = "*"
EMBEDDED_KERNEL_NAMES_BY_RTOS: Dict[str, List[str]] = {
    GLOBAL_NAME_KEY: [
        "sched",
    ],
    "freertos": [
        "pcTCB",
        "pxTCB",
        "xTCB",
        "pxNewTCB",
        "xQueue",
        "pxQueue",
        "pxTimer",
        "pxList",
        "pxContainer",
        "pxEventBits",
        "pxQueueSetContainer",
        "pxMutex",
        "pxSemaphore",
        "pxEventGroup",
        "pxStreamBuffer",
        "xTaskHandle",
        "pxCurrentTCB"
    ],
    "threadx": [
        "pool_ptr",
        "thread_ptr",
        "semaphore_ptr",
        "mutex_ptr",
        "timer_ptr",
        "queue_ptr",
        "group_ptr"
    ],
    "tizenrt": [
        "mutex",
        "sem",
        "tcb",
        "rtcb",
        "mq",
        "mq_stat",
        "mqmsg"
    ],
    "rt-thread": [
        "object",
        "timer",
        "mq",
        "rt_mutex",
        "rt_event",
    ],
}


def _word_bound_regex_for_identifier(name: str) -> Optional[str]:
    """C identifier → ``\b`` + escaped + ``\b`` (substring match, whole token)."""
    n = (name or "").strip()
    if not n:
        return None
    return r"\b" + re.escape(n) + r"\b"


def _label_rule_string_tuple_for_name(
    rtos_key: str, raw_name: str
) -> Optional[Tuple[str, str]]:
    pat = _word_bound_regex_for_identifier(raw_name)
    if not pat:
        return None
    return (f"{rtos_key}:{raw_name.strip()}", pat)


def _match_rtos_key_for_project(
    rtos_project: str, name_table: Dict[str, List[str]]
) -> str:
    """
    Pick which RTOS bucket to use. Longer key first (``rt-thread`` before ``rt``).
    Skips ``GLOBAL_NAME_KEY`` (not a project substring). Empty string = no match → use
    union in ``enrich_mytype_dataframe``.
    """
    rp = (rtos_project or "").lower()
    keys = [k for k in name_table.keys() if k != GLOBAL_NAME_KEY]
    keys.sort(key=len, reverse=True)
    for k in keys:
        if k.lower() in rp:
            return k
    return ""


def build_kernel_object_rules(
    name_table: Dict[str, List[str]], extra: Sequence[Tuple[str, str]]
) -> Tuple[
    List[Tuple[str, Any]],  # union: all embedded names + extra
    Dict[str, List[Tuple[str, Any]]],  # per-RTOS, each includes extra at end
    Dict[str, List[str]],  # filtered name table (for row matching)
]:
    """
    From ``{ rtos_key: [identifiers] }`` build compiled patterns. Per-key rules are
    used when ``RTOS_Project`` matches that key; union is used for file-wide scans
    and as fallback for unknown projects.
    """
    table: Dict[str, List[str]] = {}
    for k, names in (name_table or {}).items():
        table[k] = [x for x in (names or []) if str(x).strip()]
    table = {k: v for k, v in table.items() if v}
    global_names = list(table.get(GLOBAL_NAME_KEY, []))

    for_rtos: Dict[str, List[str]] = {}
    for k, names in table.items():
        if k == GLOBAL_NAME_KEY:
            continue
        merged = list(names) + global_names
        for_rtos[k] = list(dict.fromkeys(merged))
    # ``table_out`` keys = substring matches for ``RTOS_Project`` (no global key).
    table_out: Dict[str, List[str]] = dict(for_rtos)

    embedded_tuples: List[Tuple[str, str]] = []
    for k, names in for_rtos.items():
        for raw in names:
            t = _label_rule_string_tuple_for_name(k, str(raw))
            if t is not None:
                embedded_tuples.append(t)
    if not for_rtos and global_names:
        for raw in global_names:
            t = _label_rule_string_tuple_for_name(GLOBAL_NAME_KEY, str(raw))
            if t is not None:
                embedded_tuples.append(t)

    extra_tuples = list(extra) if extra else []
    extra_compiled = _compile_rules([], extra_tuples) if extra_tuples else []

    rules_by_rt: Dict[str, List[Tuple[str, Any]]] = {}
    for k, names in for_rtos.items():
        tups = [
            t
            for raw in names
            for t in (_label_rule_string_tuple_for_name(k, str(raw)),)
            if t is not None
        ]
        rules_by_rt[k] = _compile_rules(tups, []) + extra_compiled

    union = (
        _compile_rules(embedded_tuples, extra_tuples)
        if (embedded_tuples or extra_tuples)
        else []
    )
    if not for_rtos and not extra_tuples:
        return [], rules_by_rt, table_out
    return union, rules_by_rt, table_out


def _parse_patterns_file(path: str) -> List[Tuple[str, str]]:
    """Lines appended after EMBEDDED; ``name || regex`` or bare regex (extra_N)."""
    out: List[Tuple[str, str]] = []
    extra_i = 0
    with open(path, "r", encoding="utf-8", errors="replace") as f:
        for raw in f:
            line = raw.strip()
            if not line or line.startswith("#"):
                continue
            if "||" in line:
                left, right = line.split("||", 1)
                name = left.strip() or f"extra_{extra_i}"
                pat = right.strip()
                extra_i += 1
            else:
                name = f"extra_{extra_i}"
                pat = line
                extra_i += 1
            if pat:
                out.append((name, pat))
    return out


def _compile_rules(
    embedded: Sequence[Tuple[str, str]], extra: Sequence[Tuple[str, str]]
) -> List[Tuple[str, Any]]:
    rules: List[Tuple[str, Any]] = []
    for label, s in list(embedded) + list(extra):
        try:
            rules.append((label, re.compile(s)))
        except re.error as e:
            print(f"Warning: skip invalid regex for {label!r}: {e}", file=sys.stderr)
    return rules


def scan_file(
    path: str, rules: Sequence[Tuple[str, Any]]
) -> List[Dict[str, object]]:
    rows: List[Dict[str, object]] = []
    try:
        with open(path, "r", encoding="utf-8", errors="replace") as f:
            for lineno, line in enumerate(f, start=1):
                for label, cpat in rules:
                    for m in cpat.finditer(line):
                        rows.append(
                            {
                                "file": path,
                                "line": lineno,
                                "column_1based": m.start() + 1,
                                "match": m.group(0),
                                "pattern": label,
                            }
                        )
    except OSError as e:
        print(f"Warning: could not read {path}: {e}", file=sys.stderr)
    return rows


def _safe_str(x: Any) -> str:
    if x is None:
        return ""
    if isinstance(x, float) and math.isnan(x):
        return ""
    s = str(x)
    if s.lower() in ("nan", "none", ""):
        return ""
    return s.strip()


def _resolve_path_from_mytype_row(
    row: Any, klee_src_root: Optional[str]
) -> Optional[str]:
    """Prefer Resolved_Source_Path; else join File_As_Reported to klee_src_root if relative."""
    try:
        r = row["Resolved_Source_Path"]  # type: ignore[index]
    except (KeyError, TypeError, IndexError):
        r = None
    p = _safe_str(r)
    if p and os.path.isfile(p):
        return os.path.normpath(p)

    try:
        f = row["File_As_Reported"]  # type: ignore[index]
    except (KeyError, TypeError, IndexError):
        f = None
    rel = _safe_str(f)
    if not rel:
        return None
    if os.path.isabs(rel) and os.path.isfile(rel):
        return os.path.normpath(rel)
    if klee_src_root:
        cand = os.path.normpath(os.path.join(klee_src_root, rel))
        if os.path.isfile(cand):
            return cand
    return None


def _allowed_source_suffix(path: str) -> bool:
    pl = path.lower()
    return pl.endswith((".c", ".h", ".hpp", ".cc", ".cpp"))


def line_hits_kernel_object_patterns(
    line_text: str, rules: Sequence[Tuple[str, Any]]
) -> Tuple[bool, List[str]]:
    """Return (any_match, [ 'label:match', ... ])."""
    if not line_text or not str(line_text).strip():
        return False, []
    s = str(line_text)
    hits: List[str] = []
    for label, cpat in rules:
        for m in cpat.finditer(s):
            hits.append(f"{label}:{m.group(0)}")
    return (len(hits) > 0), hits


def _read_line_n_from_file(path: str, line_1based: int) -> Optional[str]:
    if line_1based < 1 or not path or not os.path.isfile(path):
        return None
    try:
        with open(path, "r", encoding="utf-8", errors="replace") as f:
            for i, line in enumerate(f, start=1):
                if i == line_1based:
                    return line.rstrip("\n\r")
    except OSError:
        return None
    return None


def vulnerability_line_text_for_row(
    row: Any,
    klee_src_root: Optional[str],
    file_line_cache: Dict[str, List[str]],
) -> Optional[str]:
    """
    Text of the KLEE-reported line: prefer ``Source_Line``; else read file at
    ``Line_Number`` from resolved path.
    """
    sl = row.get("Source_Line") if hasattr(row, "get") else None
    t = _safe_str(sl)
    if t:
        return t
    path = _resolve_path_from_mytype_row(row, klee_src_root)
    if not path:
        return None
    ln = row.get("Line_Number")
    try:
        n = int(float(ln))
    except (TypeError, ValueError):
        return None
    if n < 1:
        return None
    if path not in file_line_cache:
        try:
            with open(path, "r", encoding="utf-8", errors="replace") as f:
                file_line_cache[path] = f.readlines()
        except OSError:
            file_line_cache[path] = []
    lines = file_line_cache[path]
    if not lines or n > len(lines):
        return _read_line_n_from_file(path, n)
    return lines[n - 1].rstrip("\n\r")


def enrich_mytype_dataframe(
    df: Any,
    name_table: Dict[str, List[str]],
    rules_by_rt: Dict[str, List[Tuple[str, Any]]],
    union_rules: Sequence[Tuple[str, Any]],
    klee_src_root: Optional[str],
) -> Any:
    """
    Add KO_Related (Y/N/U) and KO_Pattern_Detail. Rules for each row are chosen by
    ``RTOS_Project`` → ``name_table`` key, else ``union_rules``.
    """
    if df is None or df.empty:
        return df
    file_line_cache: Dict[str, List[str]] = {}
    related: List[str] = []
    detail: List[str] = []
    for _, row in df.iterrows():
        vline = vulnerability_line_text_for_row(row, klee_src_root, file_line_cache)
        if vline is None:
            related.append("U")
            detail.append("")
            continue
        rp = _safe_str(row.get("RTOS_Project", ""))
        g = _match_rtos_key_for_project(rp, name_table)
        if g and g in rules_by_rt and rules_by_rt[g]:
            use_rules: Sequence[Tuple[str, Any]] = rules_by_rt[g]
        else:
            use_rules = union_rules
        ok, hits = line_hits_kernel_object_patterns(vline, use_rules)
        related.append("Y" if ok else "N")
        detail.append("; ".join(hits) if hits else "")
    out = df.copy()
    out[KO_COL_RELATED] = related
    out[KO_COL_DETAIL] = detail
    return out


def build_ko_impact_summary_dataframe(direct_df: Any, guarded_df: Any) -> Any:
    """
    Counts and ratios: per policy (Direct / Guarded / combined), per RTOS, per vuln type.
    """
    import pandas as pd

    def _one_row(
        pol: str, scope: str, sub: Any
    ) -> Dict[str, Any]:
        if sub is None or sub.empty or KO_COL_RELATED not in sub.columns:
            return {
                "Policy": pol,
                "Scope": scope,
                "Rows": 0,
                "KO_Y": 0,
                "KO_N": 0,
                "KO_U": 0,
                "Pct_Y_of_YN": None,
                "Pct_Y_of_All": None,
            }
        y = int((sub[KO_COL_RELATED] == "Y").sum())
        n = int((sub[KO_COL_RELATED] == "N").sum())
        u = int((sub[KO_COL_RELATED] == "U").sum())
        tot = y + n + u
        yn = y + n
        return {
            "Policy": pol,
            "Scope": scope,
            "Rows": tot,
            "KO_Y": y,
            "KO_N": n,
            "KO_U": u,
            "Pct_Y_of_YN": (100.0 * y / yn) if yn else None,
            "Pct_Y_of_All": (100.0 * y / tot) if tot else None,
        }

    rows: List[Dict[str, Any]] = []
    rows.append(_one_row("Direct", "All", direct_df))
    rows.append(_one_row("Guarded", "All", guarded_df))

    parts: List[Any] = []
    if direct_df is not None and not direct_df.empty:
        parts.append(direct_df)
    if guarded_df is not None and not guarded_df.empty:
        parts.append(guarded_df)
    comb = pd.concat(parts, ignore_index=True) if parts else pd.DataFrame()
    rows.append(_one_row("Direct+Guarded", "All_rows_listed", comb))

    for pol_name, sub in (("Direct", direct_df), ("Guarded", guarded_df)):
        if sub is None or sub.empty or "RTOS_Project" not in sub.columns:
            continue
        if KO_COL_RELATED not in sub.columns:
            continue
        for rtos, grp in sub.groupby("RTOS_Project", dropna=False):
            r = _one_row(pol_name, f"RTOS={rtos}", grp)
            r["Policy"] = pol_name
            r["Scope"] = f"RTOS={rtos}"
            rows.append(r)

    for pol_name, sub in (("Direct", direct_df), ("Guarded", guarded_df)):
        if sub is None or sub.empty or "My_Vulnerability_Type" not in sub.columns:
            continue
        if KO_COL_RELATED not in sub.columns:
            continue
        for vtype, grp in sub.groupby("My_Vulnerability_Type", dropna=False):
            vshort = str(vtype)[:80] + ("..." if len(str(vtype)) > 80 else "")
            r = _one_row(pol_name, f"Type={vshort}", grp)
            r["Policy"] = pol_name
            r["Scope"] = f"Type={vshort}"
            rows.append(r)

    return pd.DataFrame(rows)


def collect_unique_sources_from_vulnerability_summary(
    xlsx_path: str, klee_src_root: Optional[str]
) -> Dict[str, Dict[str, Any]]:
    """
    Walk MyType_Source_Lines and MyType_Source_Lines_Guarded; map absolute file path
    to metadata: rtos (set, later joined), seen_direct, seen_guarded.
    """
    import pandas as pd

    meta: Dict[str, Dict[str, Any]] = {}
    sheets = [
        (SHEET_DIRECT, True, False),
        (SHEET_GUARDED, False, True),
    ]
    for sheet, is_direct, is_guarded in sheets:
        try:
            df = pd.read_excel(
                xlsx_path, sheet_name=sheet, engine="openpyxl"
            )
        except (ValueError, OSError) as e:
            print(
                f"Warning: skip sheet {sheet!r} ({e})",
                file=sys.stderr,
            )
            continue
        if df is None or df.empty:
            continue
        for _, row in df.iterrows():
            path = _resolve_path_from_mytype_row(row, klee_src_root)
            if not path or not _allowed_source_suffix(path):
                continue
            rproj = _safe_str(row.get("RTOS_Project", ""))
            if path not in meta:
                meta[path] = {
                    "rtos": set(),
                    "direct": False,
                    "guarded": False,
                }
            if rproj:
                meta[path]["rtos"].add(rproj)
            if is_direct:
                meta[path]["direct"] = True
            if is_guarded:
                meta[path]["guarded"] = True
    return meta


def count_patterns_by_file(path: str, rules: Sequence[Tuple[str, Any]]) -> Counter:
    c: Counter = Counter()
    for r in scan_file(path, rules):
        lab = r.get("pattern")
        if lab is not None:
            c[str(lab)] += 1
    return c


def build_annotation_stats_dataframe(
    file_meta: Dict[str, Dict[str, Any]], rules: Sequence[Tuple[str, Any]]
) -> Any:
    """Wide table: one row per source file, pattern count columns, Total + TOTAL row."""
    import pandas as pd

    pattern_names = [label for label, _ in rules]
    rows_out: List[Dict[str, Any]] = []
    if not file_meta:
        base = {c: [""] for c in ["Index", "RTOS_Project", "In_MyType_Direct", "In_MyType_Guarded"]}
        base["Source_File"] = ["(all files)"]
        for n in pattern_names + ["Total_Pattern_Matches"]:
            base[n] = [0]
        base["Index"] = ["TOTAL"]
        return pd.DataFrame(base)

    for idx, (abs_path, info) in enumerate(
        sorted(file_meta.items(), key=lambda x: x[0]), start=1
    ):
        rtos_set: Set[str] = info.get("rtos") or set()  # type: ignore[assignment]
        rtxt = ", ".join(sorted(x for x in rtos_set if x)) if rtos_set else ""
        c = count_patterns_by_file(abs_path, rules)
        tot = int(sum(c.values()))
        row: Dict[str, Any] = {
            "Index": idx,
            "Source_File": abs_path,
            "RTOS_Project": rtxt,
            "In_MyType_Direct": "Y" if info.get("direct") else "N",
            "In_MyType_Guarded": "Y" if info.get("guarded") else "N",
            "Total_Pattern_Matches": tot,
        }
        for name in pattern_names:
            row[name] = int(c.get(name, 0))
        rows_out.append(row)

    df = pd.DataFrame(rows_out)
    col_order = (
        [
            "Index",
            "Source_File",
            "RTOS_Project",
            "In_MyType_Direct",
            "In_MyType_Guarded",
        ]
        + pattern_names
        + ["Total_Pattern_Matches"]
    )
    for c in col_order:
        if c not in df.columns:
            df[c] = 0 if c in pattern_names + ["Total_Pattern_Matches"] else ""
    df = df[col_order]

    total_row: Dict[str, Any] = {
        "Index": "TOTAL",
        "Source_File": "(all files)",
        "RTOS_Project": "",
        "In_MyType_Direct": "",
        "In_MyType_Guarded": "",
    }
    for name in pattern_names:
        total_row[name] = int(df[name].sum())
    total_row["Total_Pattern_Matches"] = int(df["Total_Pattern_Matches"].sum())
    df = pd.concat([df, pd.DataFrame([total_row])], ignore_index=True)
    return df


def process_vulnerability_workbook(
    input_xlsx: str,
    output_xlsx: str,
    name_table: Dict[str, List[str]],
    union_rules: Sequence[Tuple[str, Any]],
    rules_by_rt: Dict[str, List[Tuple[str, Any]]],
    klee_src_root: Optional[str],
) -> int:
    """
    Write workbook (same path as input uses temp+replace). Refreshes per-row
    ``KO_Related`` / ``KO_Pattern_Detail``, ``MYTYPE_KO_ANNOTATION_STATS_SHEET``, and
    ``MYTYPE_KO_IMPACT_SUMMARY_SHEET``. Re-run overwrites those sheets and columns.
    """
    import pandas as pd

    try:
        xf = pd.ExcelFile(input_xlsx, engine="openpyxl")
    except Exception as e:
        print(f"Error: could not read {input_xlsx!r}: {e}", file=sys.stderr)
        return 1

    def _load(sheet: str) -> Any:
        if sheet not in xf.sheet_names:
            return None
        return pd.read_excel(
            xf, sheet_name=sheet, engine="openpyxl"
        ).copy()

    direct = _load(SHEET_DIRECT)
    guarded = _load(SHEET_GUARDED)

    for dframe in (direct, guarded):
        if dframe is None or dframe.empty:
            continue
        for c in (KO_COL_RELATED, KO_COL_DETAIL):
            if c in dframe.columns:
                dframe.drop(columns=[c], inplace=True, errors="ignore")

    if direct is not None and not direct.empty:
        direct = enrich_mytype_dataframe(
            direct, name_table, rules_by_rt, union_rules, klee_src_root
        )
    if guarded is not None and not guarded.empty:
        guarded = enrich_mytype_dataframe(
            guarded, name_table, rules_by_rt, union_rules, klee_src_root
        )

    file_meta = collect_unique_sources_from_vulnerability_summary(
        input_xlsx, klee_src_root
    )
    n_meta = len(file_meta)
    stats_per_file = build_annotation_stats_dataframe(file_meta, union_rules)
    impact_df = build_ko_impact_summary_dataframe(direct, guarded)

    out_dir = os.path.dirname(output_xlsx) or "."
    os.makedirs(out_dir, exist_ok=True)
    skip_copy = {
        MYTYPE_KO_ANNOTATION_STATS_SHEET,
        MYTYPE_KO_IMPACT_SUMMARY_SHEET,
    }

    in_abs = os.path.abspath(input_xlsx)
    out_abs = os.path.abspath(output_xlsx)
    write_path = output_xlsx
    tmp_path: Optional[str] = None
    if in_abs == out_abs:
        import tempfile

        fd, tmp_path = tempfile.mkstemp(suffix="_ko_tmp.xlsx", dir=out_dir)
        os.close(fd)
        write_path = tmp_path

    with pd.ExcelWriter(write_path, engine="openpyxl") as writer:
        for sheet in xf.sheet_names:
            if sheet in skip_copy:
                continue
            if sheet == SHEET_DIRECT and direct is not None:
                direct.to_excel(writer, sheet_name=sheet, index=False)
            elif sheet == SHEET_GUARDED and guarded is not None:
                guarded.to_excel(writer, sheet_name=sheet, index=False)
            else:
                try:
                    pd.read_excel(
                        xf, sheet_name=sheet, engine="openpyxl"
                    ).to_excel(writer, sheet_name=sheet, index=False)
                except Exception as e:
                    print(
                        f"Warning: could not copy sheet {sheet!r}: {e}",
                        file=sys.stderr,
                    )
        stats_per_file.to_excel(
            writer, sheet_name=MYTYPE_KO_ANNOTATION_STATS_SHEET, index=False
        )
        impact_df.to_excel(
            writer, sheet_name=MYTYPE_KO_IMPACT_SUMMARY_SHEET, index=False
        )

    if tmp_path is not None:
        try:
            os.replace(tmp_path, output_xlsx)
        except OSError as e:
            print(f"Error: could not replace workbook: {e}", file=sys.stderr)
            try:
                os.unlink(tmp_path)
            except OSError:
                pass
            return 1

    n_dir = 0 if direct is None else len(direct)
    n_g = 0 if guarded is None else len(guarded)
    n_y = 0
    if direct is not None and KO_COL_RELATED in direct.columns:
        n_y += int((direct[KO_COL_RELATED] == "Y").sum())
    if guarded is not None and KO_COL_RELATED in guarded.columns:
        n_y += int((guarded[KO_COL_RELATED] == "Y").sum())

    print(
        f"Annotated {SHEET_DIRECT!r} ({n_dir} row(s)) and {SHEET_GUARDED!r} ({n_g} row(s)); "
        f"KO_Related=Y on {n_y} row(s) total. "
        f"Sheets: {MYTYPE_KO_ANNOTATION_STATS_SHEET!r} ({n_meta} file(s)), "
        f"{MYTYPE_KO_IMPACT_SUMMARY_SHEET!r} (ratios). -> {out_abs}",
        file=sys.stderr,
    )
    if n_meta == 0:
        print(
            "Hint: set --klee-src-root if paths do not resolve.",
            file=sys.stderr,
        )
    return 0


def _default_klee_src_root() -> str:
    env = os.environ.get("KLEE_SRC", "").strip()
    if env and os.path.isdir(env):
        return os.path.abspath(env)
    return os.path.abspath(os.path.join(os.path.dirname(__file__), os.pardir, os.pardir))


def _default_vulnerability_summary_path() -> str:
    return os.path.abspath(
        os.path.join(os.path.dirname(__file__), "results", "vulnerability_summary.xlsx")
    )


def main(argv: Optional[List[str]] = None) -> int:
    p = argparse.ArgumentParser(
        description="Refresh KO columns and stats sheets in vulnerability_summary.xlsx "
        "(in place by default).",
    )
    p.add_argument(
        "xlsx",
        nargs="?",
        default=None,
        metavar="WORKBOOK",
        help="Path to vulnerability_summary.xlsx (default: rtos-api-analysis/results/vulnerability_summary.xlsx).",
    )
    p.add_argument(
        "-o",
        "--output",
        metavar="XLSX",
        default="",
        help="If set, write the result to this file instead of overwriting the input.",
    )
    p.add_argument(
        "--klee-src-root",
        metavar="DIR",
        default="",
        help="Prepend to relative File_As_Reported (default: KLEE_SRC or klee_src next to this script).",
    )
    p.add_argument(
        "--patterns-file",
        metavar="FILE",
        help="Append extra raw-regex rules (name || regex) after name-table rules.",
    )
    args = p.parse_args(argv)

    in_xlsx = os.path.abspath(args.xlsx or _default_vulnerability_summary_path())
    if not os.path.isfile(in_xlsx):
        print(f"Error: workbook not found: {in_xlsx}", file=sys.stderr)
        return 1

    out_x = str(args.output).strip() if args.output else ""
    out_xlsx = os.path.abspath(out_x) if out_x else in_xlsx

    extra: List[Tuple[str, str]] = []
    if args.patterns_file:
        if not os.path.isfile(args.patterns_file):
            print(
                f"Error: --patterns-file not found: {args.patterns_file}",
                file=sys.stderr,
            )
            return 1
        extra = _parse_patterns_file(args.patterns_file)

    union_rules, rules_by_rt, name_table = build_kernel_object_rules(
        EMBEDDED_KERNEL_NAMES_BY_RTOS, extra
    )
    if not union_rules:
        print(
            "Error: no kernel name patterns (fill EMBEDDED_KERNEL_NAMES_BY_RTOS "
            "and/or use --patterns-file).",
            file=sys.stderr,
        )
        return 1

    kroot = args.klee_src_root.strip() if args.klee_src_root else _default_klee_src_root()
    return process_vulnerability_workbook(
        in_xlsx, out_xlsx, name_table, union_rules, rules_by_rt, kroot
    )


if __name__ == "__main__":
    raise SystemExit(main())
