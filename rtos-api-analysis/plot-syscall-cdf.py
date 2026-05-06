#!/usr/bin/env python3
"""
Plot CDF (Cumulative Distribution Function) of syscall execution performance.
Shows what fraction of system calls complete within a given time.

CDF logic:
  - Data: Elapsed time per syscall from runtime_info.xlsx
  - ECDF: (0, 0) prepended, then (x_i, i/n) for sorted data
  - Plot: piecewise linear (connect points, no smoothing) - standard in papers

Data source: *_runtime_info.xlsx from data-analyze-all.py (Elapsed column)
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

# Paper-style: Times-like serif (IEEE/ACM common). Matplotlib falls back if TNR missing.
_RC_PAPER = {
    "font.family": "serif",
    "font.serif": [
        "Times New Roman",
        "Times",
        "Nimbus Roman",
        "DejaVu Serif",
        "Liberation Serif",
    ],
    # STIX is close to Times for math (e.g. 10^n on log axis); use 'cm' for classic LaTeX look
    "mathtext.fontset": "stix",
}


def get_rtos_display_name(rtos_version):
    """Convert internal RTOS version string to display name (with version)."""
    name_map = {
        'freertos-10.5.1': 'FreeRTOS 10.5.1',
        'freertos-10.6.0': 'FreeRTOS 10.6.0',
        'FreeRTOS-Kernel-10.6.0': 'FreeRTOS 10.6.0',
        'tizenrt': 'TizenRT',
        'rt-thread': 'RT-Thread',
        'threadx-6.4.2': 'ThreadX 6.4.2',
        'threadx-5.3': 'ThreadX 5.3',
    }
    return name_map.get(rtos_version, rtos_version)


def get_rtos_paper_name(rtos_version):
    """Short RTOS name for paper figures (no version number)."""
    name_map = {
        'freertos-10.5.1': 'FreeRTOS',
        'freertos-10.6.0': 'FreeRTOS',
        'FreeRTOS-Kernel-10.6.0': 'FreeRTOS',
        'tizenrt': 'TizenRT',
        'rt-thread': 'RT-Thread',
        'threadx-6.4.2': 'ThreadX',
        'threadx-5.3': 'ThreadX',
    }
    return name_map.get(rtos_version, rtos_version)


def load_elapsed_times(result_folder, rtos_version, use_walltime=False):
    """
    Load Elapsed times from runtime_info.xlsx or runtime_info_walltime.xlsx.
    use_walltime: prefer run.stats WallTime (microsecond precision) when file exists.
    Returns sorted array of elapsed times in seconds.
    """
    if use_walltime:
        xlsx_path = os.path.join(result_folder, f'{rtos_version}_runtime_info_walltime.xlsx')
        if not os.path.exists(xlsx_path):
            xlsx_path = os.path.join(result_folder, f'{rtos_version}_runtime_info.xlsx')
    else:
        xlsx_path = os.path.join(result_folder, f'{rtos_version}_runtime_info.xlsx')

    if not os.path.exists(xlsx_path):
        print(f'Warning: {xlsx_path} not found, skipping.')
        return None

    df = pd.read_excel(xlsx_path, engine='openpyxl')

    if 'System Call' in df.columns:
        df = df[~df['System Call'].isin(['Total Finished', 'Total'])]

    elapsed = pd.to_numeric(df['Elapsed'], errors='coerce')
    elapsed = elapsed.dropna()
    elapsed = elapsed[elapsed >= 0]
    arr = elapsed.values

    if len(arr) == 0:
        print(f'Warning: No valid Elapsed data for {rtos_version}.')
        return None

    return np.sort(arr)


def compute_cdf(data):
    """
    Compute CDF points for piecewise-linear plot.
    Standard ECDF: F(x) = (number of values <= x) / n.
    Returns (x, y) with (0, 0) prepended so curve starts at origin.
    """
    x = np.sort(data)
    n = len(x)
    if n == 0:
        return np.array([0]), np.array([0])
    x_vals = np.concatenate([[0], x])
    y_vals = np.concatenate([[0], np.arange(1, n + 1) / n])
    return x_vals, y_vals


def plot_syscall_cdf(result_folder, rtos_versions, output_path,
                     time_unit='seconds', figsize=(10, 6), x_scale='linear',
                     use_walltime=True, paper_style=False):
    """
    Plot CDF of syscall execution time for one or more RTOS.
    Curve always starts at (0, 0) and ends at (max_x, 1).

    Args:
        result_folder: Path to folder containing *_runtime_info.xlsx
        rtos_versions: List of RTOS version strings
        output_path: Path to save the figure
        time_unit: 'seconds' or 'minutes'
        figsize: Figure size
        x_scale: 'linear' (recommended, clear origin) | 'symlog' | 'log'
        paper_style: If True, use Times New Roman (serif) when available, larger
            type than before, no figure title (use caption in paper), short RTOS names.
    """
    if paper_style:
        figsize = (7.0, 4.25)
        fs_label = 15
        fs_tick = 13
        fs_legend = 13
        line_w = 1.8
        show_title = False
        name_fn = get_rtos_paper_name
        rc_ctx = plt.rc_context(_RC_PAPER)
    else:
        fs_title = 37
        fs_label = 33
        fs_tick = 25
        fs_legend = 19
        line_w = 2
        title = 'CDF of System Call Execution Time'
        show_title = True
        name_fn = get_rtos_display_name
        rc_ctx = nullcontext()

    with rc_ctx:
        fig, ax = plt.subplots(figsize=figsize)

        xlabel = 'Elapsed Time (min)' if time_unit == 'minutes' else 'Elapsed Time (s)'

        colors = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b']
        all_x_max = 0

        for i, rtos_version in enumerate(rtos_versions):
            data = load_elapsed_times(result_folder, rtos_version, use_walltime=use_walltime)
            if data is None:
                continue

            x, y = compute_cdf(data)

            if time_unit == 'minutes':
                x = x / 60.0

            all_x_max = max(all_x_max, x[-1])
            color = colors[i % len(colors)]
            label = name_fn(rtos_version)
            ax.plot(x, y, color=color, linewidth=line_w, label=label)

        ax.set_xlabel(xlabel, fontsize=fs_label, weight='bold')
        ax.set_ylabel('Cumulative Fraction', fontsize=fs_label, weight='bold')
        if show_title:
            ax.set_title(title, fontsize=fs_title, weight='bold')
        ax.legend(fontsize=fs_legend, loc='lower right', framealpha=0.95)
        ax.grid(True, linestyle='--', alpha=0.7)

        ax.set_xlim(left=0, right=all_x_max * 1.02)
        ax.set_ylim(bottom=0, top=1.02)
        if x_scale == 'symlog':
            linthresh = 1.0 if time_unit == 'seconds' else 1 / 60
            ax.set_xscale('symlog', linthresh=linthresh, linscale=1)
        elif x_scale == 'log':
            ax.set_xscale('symlog', linthresh=1, linscale=1)  # symlog to show 0
            ax.set_xlim(left=0)
            if time_unit == 'seconds':
                xticks = [0, 10, 100, 1000, 10000, 100000]
            else:
                xticks = [0, 10, 100, 1000, 10000]
            xticks = [t for t in xticks if t <= all_x_max * 1.1]
            ax.set_xticks(xticks)
            xtick_labels = [
                '0' if t == 0 else f'$10^{{{int(np.log10(t))}}}$' for t in xticks
            ]
            ax.set_xticklabels(xtick_labels, fontsize=fs_tick)

        ax.set_yticks(np.arange(0, 1.1, 0.2))
        ax.set_yticklabels(['0', '0.2', '0.4', '0.6', '0.8', '1.0'], fontsize=fs_tick)
        ax.tick_params(axis='both', labelsize=fs_tick)
        if x_scale != 'log':
            ax.tick_params(axis='x', labelsize=fs_tick)
        fig.tight_layout()
        fig.savefig(output_path, dpi=300, bbox_inches='tight')
        dated_copy(output_path)
        plt.close(fig)
    print(f'CDF plot saved to: {output_path}')


def plot_single_rtos_cdf(result_folder, rtos_version, output_folder,
                         time_unit='seconds', figsize=(10, 6)):
    """Plot CDF for a single RTOS and save to output_folder."""
    os.makedirs(output_folder, exist_ok=True)
    output_path = os.path.join(output_folder, f'{rtos_version}_syscall_cdf.png')
    plot_syscall_cdf(result_folder, [rtos_version], output_path, time_unit, figsize)


if __name__ == '__main__':
    result_folder = str(_SCRIPT_DIR / 'results')
    store_folder = str(_SCRIPT_DIR / 'results' / 'runtime')

    if not os.path.exists(store_folder):
        os.makedirs(store_folder)

    # Multi-RTOS CDF comparison (seconds)
    rtos_list = ['freertos-10.5.1', 'tizenrt', 'threadx-6.4.2', 'rt-thread']
    # Prefer walltime (run.stats) for precision; include RTOS with either data source
    rtos_available = [r for r in rtos_list
                      if (os.path.exists(os.path.join(result_folder, f'{r}_runtime_info_walltime.xlsx')) or
                         os.path.exists(os.path.join(result_folder, f'{r}_runtime_info.xlsx')))]

    if rtos_available:
        output_path = os.path.join(store_folder, 'syscall_execution_cdf.png')
        plot_syscall_cdf(result_folder, rtos_available, output_path,
                         time_unit='seconds', x_scale='log', use_walltime=True,
                         paper_style=True)

        output_path_min = os.path.join(store_folder, 'syscall_execution_cdf_minutes.png')
        plot_syscall_cdf(result_folder, rtos_available, output_path_min,
                         time_unit='minutes', x_scale='log', use_walltime=True,
                         paper_style=True)
    else:
        print('No runtime_info.xlsx found. Run data-analyze-all.py first.')
