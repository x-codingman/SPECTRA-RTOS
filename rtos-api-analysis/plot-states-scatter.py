#!/usr/bin/env python3
"""
Scatter: per-syscall Explored Paths vs kernel-objects fork time share (%).

Data: *_states_analysis.xlsx from analyze-states.py (KLEE info per harness).
Y-axis is fork *time* attribution, not path counts — caption accordingly in papers.
"""

import os
import contextlib
from pathlib import Path

_SCRIPT_DIR = Path(__file__).resolve().parent

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

# (excel stem prefix before _states_analysis.xlsx, legend label)
DEFAULT_RTOS_CONFIG = [
    ("FreeRTOS", "FreeRTOS"),
    ("ThreadX", "ThreadX"),
    ("RT-Thread", "RT-Thread"),
    ("TizenRT", "TizenRT"),
]

COLORS = ["#1f77b4", "#ff7f0e", "#2ca02c", "#d62728", "#9467bd", "#8c564b"]


def load_states_frame(states_folder, prefix):
    path = os.path.join(states_folder, f"{prefix}_states_analysis.xlsx")
    if not os.path.exists(path):
        print(f"Warning: missing {path}")
        return None
    df = pd.read_excel(path, engine="openpyxl")
    ex = pd.to_numeric(df["ExploredPaths"], errors="coerce")
    ky = pd.to_numeric(df["KernelForksPercentage"], errors="coerce")
    m = ex.notna() & ky.notna() & (ex >= 0) & (ky >= 0) & (ky <= 100)
    out = pd.DataFrame({"ExploredPaths": ex[m], "KernelForksPercentage": ky[m]})
    return out if len(out) else None


def plot_explored_vs_kernel_fork_share(
    states_folder,
    rtos_config,
    output_path,
    paper_style=True,
    figsize=(7.0, 4.25),
    linthresh=1.0,
):
    """
    Scatter each syscall: x = explored paths, y = kernel fork time % (per KLEE info).
    X-axis uses symlog so both small and large path counts are visible.
    """
    if paper_style:
        fs_label = 15
        fs_tick = 13
        fs_legend = 11
        marker_size = 22
        alpha = 0.55
        edgecolors = "face"
        linewidths = 0.3
        rc_ctx = plt.rc_context(_RC_PAPER)
    else:
        fs_label = 22
        fs_tick = 18
        fs_legend = 14
        marker_size = 40
        alpha = 0.6
        edgecolors = "k"
        linewidths = 0.2
        rc_ctx = nullcontext()

    with rc_ctx:
        fig, ax = plt.subplots(figsize=figsize)

        for i, (prefix, label) in enumerate(rtos_config):
            df = load_states_frame(states_folder, prefix)
            if df is None:
                continue
            color = COLORS[i % len(COLORS)]
            ax.scatter(
                df["ExploredPaths"],
                df["KernelForksPercentage"],
                c=color,
                s=marker_size,
                alpha=alpha,
                label=label,
                edgecolors=edgecolors,
                linewidths=linewidths,
                zorder=2,
            )

        ax.set_xlabel("Explored paths (per syscall)", fontsize=fs_label, weight="bold")
        ax.set_ylabel(
            "Kernel-objects fork time share (%)",
            fontsize=fs_label,
            weight="bold",
        )
        ax.set_ylim(-2, 102)
        ax.grid(True, linestyle="--", alpha=0.5, zorder=0)
        ax.set_xscale("symlog", linthresh=linthresh, linscale=1)
        ax.set_xlim(left=0)

        ax.legend(
            fontsize=fs_legend,
            loc="upper right",
            framealpha=0.95,
            scatterpoints=1,
            scatteryoffsets=[0.35],
        )
        ax.tick_params(axis="both", labelsize=fs_tick)

        fig.tight_layout()
        out_dir = os.path.dirname(output_path)
        if out_dir:
            os.makedirs(out_dir, exist_ok=True)
        fig.savefig(output_path, dpi=300, bbox_inches="tight")
        dated_copy(output_path)
        plt.close(fig)

    print(f"Scatter plot saved to: {output_path}")


if __name__ == "__main__":
    states_dir = str(_SCRIPT_DIR / "results" / "states")
    out = os.path.join(states_dir, "explored_paths_vs_kernel_fork_time_share_scatter.png")
    plot_explored_vs_kernel_fork_share(
        states_dir,
        DEFAULT_RTOS_CONFIG,
        out,
        paper_style=True,
        linthresh=1.0,
    )
