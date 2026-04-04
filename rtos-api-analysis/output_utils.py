"""
Helpers for dated copies of generated artifacts (YYYY-MM-DD suffix before extension).

Primary file (e.g. foo.xlsx) stays unchanged for downstream scripts; a second file
foo_2026-03-31.xlsx is created alongside for versioning.
"""

import datetime
import os
import shutil


def date_tag():
    return datetime.datetime.now().strftime("%Y-%m-%d")


def add_date_suffix(path):
    root, ext = os.path.splitext(path)
    return f"{root}_{date_tag()}{ext}"


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
