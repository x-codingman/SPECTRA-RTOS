#!/usr/bin/env python3
"""
Memory usage plots: peak KLEE heap (MallocUsage) per system call, compared across RTOS.

Data source: analyze-memory-and-coverage.py → *_memory_and_coverage_analysis.xlsx
Column: Memory Usage (MB) — from run.stats row with max Instructions (same as existing bar charts).

Why not only box plots: per-syscall memory is heavy-tailed (few syscalls use much more RAM),
so boxplots show many “fliers”. Prefer ECDF or violin for the full picture.
"""

import os
import contextlib

try:
    from contextlib import nullcontext
except ImportError:
    @contextlib.contextmanager
    def nullcontext():
        yield None

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

from output_utils import dated_copy

_RC_PAPER = {
    "font.family": "serif",
    "font.serif": [
        "Times New Roman",
        "Times",
        "Nimbus Roman",
        "DejaVu Serif",
        "Liberation Serif",
    ],
    "mathtext.fontset": "stix",
}

# (excel file prefix before _memory_and_coverage_analysis.xlsx, legend / x tick label)
DEFAULT_RTOS = [
    ("FreeRTOS", "FreeRTOS"),
    ("ThreadX", "ThreadX"),
    ("RT-Thread", "RT-Thread"),
    ("TizenRT", "TizenRT"),
]

COLORS = ["#1f77b4", "#ff7f0e", "#2ca02c", "#d62728", "#9467bd", "#8c564b"]


def compute_cdf(data):
    """ECDF: F(x) = fraction of samples <= x. Prepend (0, 0) for curve from origin."""
    x = np.sort(np.asarray(data, dtype=float))
    n = len(x)
    if n == 0:
        return np.array([0.0]), np.array([0.0])
    x_vals = np.concatenate([[0.0], x])
    y_vals = np.concatenate([[0.0], np.arange(1, n + 1) / n])
    return x_vals, y_vals


def load_memory_mb_per_syscall(memory_folder, file_prefix):
    path = os.path.join(memory_folder, f"{file_prefix}_memory_and_coverage_analysis.xlsx")
    if not os.path.exists(path):
        print(f"Warning: {path} not found.")
        return None
    df = pd.read_excel(path, engine="openpyxl")
    if "Memory Usage (MB)" not in df.columns:
        return None
    s = pd.to_numeric(df["Memory Usage (MB)"], errors="coerce").dropna()
    s = s[s > 0]
    return s.values if len(s) else None


def plot_memory_usage_cdf(
    memory_folder,
    rtos_list,
    output_path,
    paper_style=True,
    figsize=None,
    x_scale="symlog",
    linthresh=1.0,
):
    """
    ECDF of per-syscall peak memory (MB): same idea as syscall_execution_cdf.
    Heavy tails appear as a long climb toward 1 — no separate outlier glyphs.
    """
    if paper_style:
        figsize = figsize or (7.0, 4.25)
        fs_label = 18
        fs_tick = 15
        line_w = 1.8
        rc_ctx = plt.rc_context(_RC_PAPER)
    else:
        figsize = figsize or (10, 6)
        fs_label = 28
        fs_tick = 20
        line_w = 2.0
        rc_ctx = nullcontext()

    series = []
    for prefix, label in rtos_list:
        arr = load_memory_mb_per_syscall(memory_folder, prefix)
        if arr is not None and len(arr):
            series.append((label, arr))

    if not series:
        print("No memory xlsx data found. Run analyze-memory-and-coverage.py first.")
        return

    with rc_ctx:
        fig, ax = plt.subplots(figsize=figsize)
        all_x_max = 0.0
        for i, (label, arr) in enumerate(series):
            x, y = compute_cdf(arr)
            all_x_max = max(all_x_max, float(x[-1]))
            ax.plot(
                x,
                y,
                color=COLORS[i % len(COLORS)],
                linewidth=line_w,
                label=label,
            )

        ax.set_xlabel("Peak memory (MB)", fontsize=fs_label, weight="bold")
        ax.set_ylabel("Cumulative fraction", fontsize=fs_label, weight="bold")
        ax.legend(fontsize=fs_tick, loc="lower right", framealpha=0.95)
        ax.grid(True, linestyle="--", alpha=0.55)
        ax.set_xlim(left=0, right=all_x_max * 1.02)
        ax.set_ylim(0, 1.02)
        ax.set_yticks(np.arange(0, 1.1, 0.2))
        ax.set_yticklabels(["0", "0.2", "0.4", "0.6", "0.8", "1.0"], fontsize=fs_tick)
        ax.tick_params(axis="x", labelsize=fs_tick)

        if x_scale == "symlog":
            ax.set_xscale("symlog", linthresh=linthresh, linscale=1)
        elif x_scale == "log":
            ax.set_xscale("log")

        fig.tight_layout()
        out_dir = os.path.dirname(output_path)
        if out_dir:
            os.makedirs(out_dir, exist_ok=True)
        fig.savefig(output_path, dpi=300, bbox_inches="tight")
        dated_copy(output_path)
        plt.close(fig)

    print(f"Memory ECDF saved to: {output_path}")


def plot_memory_usage_violin(
    memory_folder,
    rtos_list,
    output_path,
    paper_style=True,
    figsize=None,
    y_scale="log",
):
    """
    Violin plot: shows density shape (heavy tail visible as a long thin body).
    """
    if paper_style:
        figsize = figsize or (7.0, 4.25)
        fs_label = 18
        fs_tick = 15
        rc_ctx = plt.rc_context(_RC_PAPER)
    else:
        figsize = figsize or (10, 6)
        fs_label = 28
        fs_tick = 20
        rc_ctx = nullcontext()

    data_by_rtos = []
    labels = []
    for prefix, label in rtos_list:
        arr = load_memory_mb_per_syscall(memory_folder, prefix)
        if arr is not None and len(arr):
            data_by_rtos.append(arr)
            labels.append(label)

    if not data_by_rtos:
        print("No memory xlsx data found.")
        return

    positions = np.arange(1, len(labels) + 1)

    with rc_ctx:
        fig, ax = plt.subplots(figsize=figsize)
        parts = ax.violinplot(
            data_by_rtos,
            positions=positions,
            widths=0.7,
            showmeans=False,
            showmedians=True,
            showextrema=True,
        )
        for i, b in enumerate(parts["bodies"]):
            b.set_facecolor(COLORS[i % len(COLORS)])
            b.set_alpha(0.75)
            b.set_edgecolor("0.3")
        if parts.get("cmedians") is not None:
            parts["cmedians"].set_color("0.15")
            parts["cmedians"].set_linewidth(1.5)
        if parts.get("cbars") is not None:
            parts["cbars"].set_color("0.35")

        ax.set_xticks(positions)
        ax.set_xticklabels(labels, fontsize=fs_tick)
        ax.set_ylabel("Peak memory (MB)", fontsize=fs_label, weight="bold")
        ax.tick_params(axis="both", labelsize=fs_tick)
        ax.grid(True, axis="y", linestyle="--", alpha=0.55)

        if y_scale == "log":
            ax.set_yscale("log")
            ymin = min(d.min() for d in data_by_rtos)
            ymax = max(d.max() for d in data_by_rtos)
            ax.set_ylim(bottom=ymin * 0.85, top=ymax * 1.15)

        fig.tight_layout()
        out_dir = os.path.dirname(output_path)
        if out_dir:
            os.makedirs(out_dir, exist_ok=True)
        fig.savefig(output_path, dpi=300, bbox_inches="tight")
        plt.close(fig)

    print(f"Memory violin plot saved to: {output_path}")


def plot_memory_usage_box(
    memory_folder,
    rtos_list,
    output_path,
    paper_style=True,
    figsize=None,
    y_scale="log",
    show_fliers=True,
):
    """
    One box per RTOS: distribution of per-syscall peak memory (MB).
    Log scale by default — spans orders of magnitude across syscalls.
    Set show_fliers=False to hide points beyond whiskers (summary-only view).
    """
    if paper_style:
        figsize = figsize or (7.0, 4.25)
        fs_label = 18
        fs_tick = 15
        show_title = False
        rc_ctx = plt.rc_context(_RC_PAPER)
    else:
        figsize = figsize or (10, 6)
        fs_label = 28
        fs_tick = 20
        show_title = True
        rc_ctx = nullcontext()

    data_by_rtos = []
    labels = []
    for prefix, label in rtos_list:
        arr = load_memory_mb_per_syscall(memory_folder, prefix)
        if arr is not None and len(arr):
            data_by_rtos.append(arr)
            labels.append(label)

    if not data_by_rtos:
        print("No memory xlsx data found. Run analyze-memory-and-coverage.py first.")
        return

    with rc_ctx:
        fig, ax = plt.subplots(figsize=figsize)
        bp = ax.boxplot(
            data_by_rtos,
            labels=labels,
            patch_artist=True,
            showfliers=show_fliers,
            flierprops=dict(marker="o", markersize=3, alpha=0.45),
        )
        for i, patch in enumerate(bp["boxes"]):
            patch.set_facecolor(COLORS[i % len(COLORS)])
            patch.set_alpha(0.75)

        ax.set_ylabel("Peak memory (MB per syscall)", fontsize=fs_label, weight="bold")
        if show_title:
            ax.set_title(
                "KLEE peak heap usage (MallocUsage) per system call",
                fontsize=32,
                weight="bold",
            )
        ax.tick_params(axis="both", labelsize=fs_tick)
        ax.grid(True, axis="y", linestyle="--", alpha=0.55)

        if y_scale == "log":
            ax.set_yscale("log")
            # sensible floor above 0
            ymin = min(d.min() for d in data_by_rtos)
            ymax = max(d.max() for d in data_by_rtos)
            ax.set_ylim(bottom=ymin * 0.85, top=ymax * 1.15)

        fig.tight_layout()
        out_dir = os.path.dirname(output_path)
        if out_dir:
            os.makedirs(out_dir, exist_ok=True)
        fig.savefig(output_path, dpi=300, bbox_inches="tight")
        dated_copy(output_path)
        plt.close(fig)

    print(f"Memory box plot saved to: {output_path}")


if __name__ == "__main__":
    memory_dir = "/home/klee/klee_src/rtos-api-analysis/results/memory"
    plot_memory_usage_cdf(
        memory_dir,
        DEFAULT_RTOS,
        os.path.join(memory_dir, "memory_usage_cdf.png"),
        paper_style=True,
        x_scale="symlog",
        linthresh=1.0,
    )
    plot_memory_usage_violin(
        memory_dir,
        DEFAULT_RTOS,
        os.path.join(memory_dir, "memory_usage_violin.png"),
        paper_style=True,
        y_scale="log",
    )
    plot_memory_usage_box(
        memory_dir,
        DEFAULT_RTOS,
        os.path.join(memory_dir, "memory_usage_box.png"),
        paper_style=True,
        y_scale="log",
        show_fliers=True,
    )
    plot_memory_usage_box(
        memory_dir,
        DEFAULT_RTOS,
        os.path.join(memory_dir, "memory_usage_box_no_fliers.png"),
        paper_style=True,
        y_scale="log",
        show_fliers=False,
    )
