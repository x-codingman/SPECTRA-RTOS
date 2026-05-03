"""
Helpers for dated copies of generated artifacts (YYYY-MM-DD suffix before extension).

Primary file (e.g. foo.xlsx) stays unchanged for downstream scripts; a second file
foo_2026-03-31.xlsx is created alongside for versioning.

Excel / SpreadsheetML uses XML: most C0 control characters (except tab, LF, CR) are
illegal and can produce a file desktop Excel refuses to open. Long text must stay
under the per-cell limit (~32767 chars).
"""

import datetime
import math
import os
import shutil

import pandas as pd

# Excel 2007+ per-sheet column cap (XFD = 16384).
EXCEL_MAX_COLUMNS = 16384
# Safe margin under Excel's per-cell character limit.
EXCEL_MAX_CELL_CHARS = 32760


def date_tag():
    return datetime.datetime.now().strftime("%Y-%m-%d")


def add_date_suffix(path):
    root, ext = os.path.splitext(path)
    return f"{root}_{date_tag()}{ext}"


def sanitize_excel_cell_value(val, max_chars=EXCEL_MAX_CELL_CHARS):
    """
    Make a scalar safe for openpyxl / Excel: strip illegal XML characters, cap length,
    drop non-finite floats, and avoid formula injection for strings starting with = + - @.
    """
    if val is None:
        return None
    try:
        if pd.isna(val):
            return None
    except (TypeError, ValueError):
        pass

    if isinstance(val, bool):
        return val
    if isinstance(val, float):
        if math.isnan(val) or math.isinf(val):
            return None
        return val
    if isinstance(val, int):
        return val

    if isinstance(val, (datetime.datetime, datetime.date, datetime.time)):
        return val

    try:
        import numpy as np

        if isinstance(val, np.generic):
            if isinstance(val, np.floating):
                x = float(val)
                if math.isnan(x) or math.isinf(x):
                    return None
                return x
            if isinstance(val, np.integer):
                return int(val)
            if isinstance(val, np.bool_):
                return bool(val)
    except Exception:
        pass

    try:
        if isinstance(val, pd.Timestamp):
            return val
    except Exception:
        pass

    s = str(val)
    s = "".join(c for c in s if ord(c) >= 32 or c in "\t\n\r")
    if len(s) > max_chars:
        s = s[: max(0, max_chars - 3)] + "..."
    # Force text in Excel when the cell could be parsed as a formula.
    if s and s[0] in ("=", "+", "-", "@"):
        s = "'" + s
    return s


def sanitize_dataframe_for_excel(df, max_chars=EXCEL_MAX_CELL_CHARS):
    """Apply sanitize_excel_cell_value to object/string columns; clean inf in float cols."""
    if df is None or df.empty:
        return df
    out = df.copy()
    # Use iloc by position so duplicate column names (e.g. wide merged sheets) still work:
    # df[name] can return a DataFrame when names repeat.
    for i in range(out.shape[1]):
        series = out.iloc[:, i]
        dtype = series.dtype
        if dtype == object or str(dtype).startswith("string"):
            sanitized = series.map(
                lambda x, mc=max_chars: sanitize_excel_cell_value(x, max_chars=mc)
            )
            out.iloc[:, i] = sanitized.values
        elif str(dtype).startswith("float"):
            out.iloc[:, i] = series.replace(
                [float("inf"), float("-inf")], pd.NA
            ).values
    return out


def dated_copy(path):
    """
    After writing `path`, duplicate to `path_YYYY-MM-DD.ext`.
    Returns the dated path, or None if `path` is missing.
    """
    if not path or not os.path.isfile(path):
        return None
    dst = add_date_suffix(path)
    shutil.copy2(path, dst)
    return dst
