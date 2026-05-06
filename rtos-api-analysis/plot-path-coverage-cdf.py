#!/usr/bin/env python3
"""
Plot path coverage CDF for symbolic execution of RTOS system calls.

Metric (per syscall): Explored Paths = number of execution paths covered
during symbolic execution of that system call.

CDF interpretation: For each RTOS, what fraction of syscalls explored ≤ N paths.
Paper-style: Common in software testing evaluation to show coverage distribution
across targets (e.g., KLEE OSDI, fuzzing papers).

Data source: *_runtime_info.xlsx / *_runtime_info_walltime.xlsx (Explored Paths column)
"""

import os
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

from output_utils import dated_copy

_SCRIPT_DIR = Path(__file__).resolve().parent


def get_rtos_display_name(rtos_version):
    """Convert internal RTOS version string to display name."""
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


def load_explored_paths_per_syscall(result_folder, rtos_version, use_walltime=True):
    """
    Load Explored Paths per syscall from runtime_info.
    Returns sorted array of path counts (one per syscall).
    """
    if use_walltime:
        xlsx_path = os.path.join(result_folder, f'{rtos_version}_runtime_info_walltime.xlsx')
        if not os.path.exists(xlsx_path):
            xlsx_path = os.path.join(result_folder, f'{rtos_version}_runtime_info.xlsx')
    else:
        xlsx_path = os.path.join(result_folder, f'{rtos_version}_runtime_info.xlsx')

    if not os.path.exists(xlsx_path):
        return None

    df = pd.read_excel(xlsx_path, engine='openpyxl')
    if 'System Call' in df.columns:
        df = df[~df['System Call'].isin(['Total Finished', 'Total'])]

    paths = pd.to_numeric(df['Explored Paths'], errors='coerce')
    paths = paths.dropna()
    paths = paths[paths >= 0]
    arr = paths.values.astype(float)

    if len(arr) == 0:
        return None
    return np.sort(arr)


def load_path_coverage_ratio_df(result_folder, rtos_version, use_walltime=True):
    """
    Load DataFrame with path coverage ratio per syscall.
    Path coverage = Completed / Explored (we explored / total paths we encountered).
    """
    if use_walltime:
        xlsx_path = os.path.join(result_folder, f'{rtos_version}_runtime_info_walltime.xlsx')
        if not os.path.exists(xlsx_path):
            xlsx_path = os.path.join(result_folder, f'{rtos_version}_runtime_info.xlsx')
    else:
        xlsx_path = os.path.join(result_folder, f'{rtos_version}_runtime_info.xlsx')

    if not os.path.exists(xlsx_path):
        return None
    df = pd.read_excel(xlsx_path, engine='openpyxl')
    if 'System Call' not in df.columns:
        return None
    df = df[~df['System Call'].isin(['Total Finished', 'Total'])]

    explored = pd.to_numeric(df['Explored Paths'], errors='coerce')
    completed = pd.to_numeric(df['Completed Paths'], errors='coerce')
    partial = pd.to_numeric(df['Partially Completed Paths'], errors='coerce')
    df['Explored'] = explored
    df['Completed'] = completed
    df['PathCoverage'] = np.where(explored > 0, completed / explored, np.nan)
    df = df.dropna(subset=['PathCoverage'])
    df = df.sort_values('PathCoverage', ascending=True).reset_index(drop=True)
    return df[['System Call', 'Explored', 'PathCoverage']]


def load_path_coverage_df(result_folder, rtos_version, use_walltime=True):
    """Load (System Call, Explored Paths) as DataFrame for Pareto chart."""
    if use_walltime:
        xlsx_path = os.path.join(result_folder, f'{rtos_version}_runtime_info_walltime.xlsx')
        if not os.path.exists(xlsx_path):
            xlsx_path = os.path.join(result_folder, f'{rtos_version}_runtime_info.xlsx')
    else:
        xlsx_path = os.path.join(result_folder, f'{rtos_version}_runtime_info.xlsx')

    if not os.path.exists(xlsx_path):
        return None
    df = pd.read_excel(xlsx_path, engine='openpyxl')
    if 'System Call' not in df.columns or 'Explored Paths' not in df.columns:
        return None
    df = df[~df['System Call'].isin(['Total Finished', 'Total'])]
    df['Explored Paths'] = pd.to_numeric(df['Explored Paths'], errors='coerce')
    df = df.dropna(subset=['Explored Paths'])
    df = df[df['Explored Paths'] >= 0]
    return df[['System Call', 'Explored Paths']]


def compute_cdf(data):
    """ECDF: (0,0) prepended, piecewise linear."""
    x = np.sort(data)
    n = len(x)
    if n == 0:
        return np.array([0]), np.array([0])
    x_vals = np.concatenate([[0], x])
    y_vals = np.concatenate([[0], np.arange(1, n + 1) / n])
    return x_vals, y_vals


def load_instruction_coverage_df(result_folder, rtos_version, use_walltime=True):
    """
    Load (System Call, InstructionCoverage) from runtime_info_walltime.
    Instruction coverage = CoveredInstructions / (Covered+Uncovered) from run.stats.
    Reflects exploration capability independent of path count (code-level coverage).
    """
    if use_walltime:
        xlsx_path = os.path.join(result_folder, f'{rtos_version}_runtime_info_walltime.xlsx')
        if not os.path.exists(xlsx_path):
            xlsx_path = os.path.join(result_folder, f'{rtos_version}_runtime_info.xlsx')
    else:
        xlsx_path = os.path.join(result_folder, f'{rtos_version}_runtime_info.xlsx')
    if not os.path.exists(xlsx_path):
        return None
    df = pd.read_excel(xlsx_path, engine='openpyxl')
    if 'System Call' not in df.columns:
        return None
    df = df[~df['System Call'].isin(['Total Finished', 'Total'])]
    if 'InstructionCoverage' not in df.columns:
        return None
    df['InstructionCoverage'] = pd.to_numeric(df['InstructionCoverage'], errors='coerce')
    df = df.dropna(subset=['InstructionCoverage'])
    df = df[df['InstructionCoverage'] >= 0]
    df = df.sort_values('InstructionCoverage', ascending=True).reset_index(drop=True)
    return df[['System Call', 'InstructionCoverage']]


def load_explored_paths_sorted_df(result_folder, rtos_version, use_walltime=True):
    """Load (System Call, Explored Paths) sorted by Explored ascending."""
    df = load_path_coverage_df(result_folder, rtos_version, use_walltime)
    if df is None or len(df) == 0:
        return None
    df = df[df['Explored Paths'] > 0].copy()  # exclude 0 for clean chart
    if len(df) == 0:
        return None
    df = df.rename(columns={'Explored Paths': 'Explored'})
    df = df.sort_values('Explored', ascending=True).reset_index(drop=True)
    return df


def plot_instruction_coverage_by_syscall_index(result_folder, rtos_versions, output_folder,
                                               figsize=(14, 10), use_walltime=True):
    """
    For each RTOS: X = syscall index, Y = Instruction Coverage (sorted low to high).
    Instruction coverage = fraction of code reached; independent of path count.
    Best metric for exploration capability: comparable across syscalls of different complexity.
    """
    colors = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b']
    n_rtos = len(rtos_versions)
    fig, axes = plt.subplots(2, 2, figsize=figsize)
    axes = axes.flatten()

    for idx, rtos_version in enumerate(rtos_versions):
        if idx >= 4:
            break
        ax = axes[idx]
        df = load_instruction_coverage_df(result_folder, rtos_version, use_walltime=use_walltime)
        if df is None or len(df) == 0:
            ax.text(0.5, 0.5, 'No data', ha='center', va='center', transform=ax.transAxes)
            ax.set_title(get_rtos_display_name(rtos_version), fontsize=20)
            continue

        x = np.arange(len(df))
        y = df['InstructionCoverage'].values
        ax.plot(x, y, color=colors[idx % len(colors)], linewidth=1.5, marker='o',
                markersize=3, alpha=0.8)
        ax.set_xlabel('System Call Index', fontsize=18, weight='bold')
        ax.set_ylabel('Instruction Coverage', fontsize=18, weight='bold')
        ax.set_title(get_rtos_display_name(rtos_version), fontsize=22, weight='bold')
        ax.set_ylim(0, 1.05)
        ax.set_xlim(-0.5, len(df) - 0.5)
        ax.grid(True, linestyle='--', alpha=0.7)
        ax.tick_params(axis='both', labelsize=14)
        ax.set_yticks(np.arange(0, 1.1, 0.2))

    for j in range(n_rtos, 4):
        axes[j].set_visible(False)

    fig.suptitle('Instruction Coverage per System Call (by RTOS, sorted low to high)',
                 fontsize=24, weight='bold', y=1.02)
    fig.tight_layout()
    os.makedirs(output_folder, exist_ok=True)
    out_path = os.path.join(output_folder, 'instruction_coverage_by_syscall_index.png')
    fig.savefig(out_path, dpi=300, bbox_inches='tight')
    dated_copy(out_path)
    plt.close(fig)
    print(f'Instruction coverage by syscall index saved to: {out_path}')


def plot_explored_paths_by_syscall_index(result_folder, rtos_versions, output_folder,
                                         figsize=(14, 10), use_walltime=True):
    """
    For each RTOS: X = syscall index, Y = Explored Paths (sorted low to high).
    Avoids coverage=0 issues: shows exploration effort, not completion ratio.
    All values >= 1; no reviewer confusion about early-terminated paths.
    """
    colors = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b']
    n_rtos = len(rtos_versions)
    fig, axes = plt.subplots(2, 2, figsize=figsize)
    axes = axes.flatten()

    for idx, rtos_version in enumerate(rtos_versions):
        if idx >= 4:
            break
        ax = axes[idx]
        df = load_explored_paths_sorted_df(result_folder, rtos_version, use_walltime=use_walltime)
        if df is None or len(df) == 0:
            ax.text(0.5, 0.5, 'No data', ha='center', va='center', transform=ax.transAxes)
            ax.set_title(get_rtos_display_name(rtos_version), fontsize=20)
            continue

        x = np.arange(len(df))
        y = df['Explored'].values
        ax.plot(x, y, color=colors[idx % len(colors)], linewidth=1.5, marker='o',
                markersize=3, alpha=0.8)
        ax.set_xlabel('System Call Index', fontsize=18, weight='bold')
        ax.set_ylabel('Explored Paths', fontsize=18, weight='bold')
        ax.set_title(get_rtos_display_name(rtos_version), fontsize=22, weight='bold')
        ax.set_ylim(bottom=0)
        ax.set_xlim(-0.5, len(df) - 0.5)
        ax.set_yscale('symlog', linthresh=1, linscale=1)
        ax.grid(True, linestyle='--', alpha=0.7)
        ax.tick_params(axis='both', labelsize=14)

    for j in range(n_rtos, 4):
        axes[j].set_visible(False)

    fig.suptitle('Path Exploration per System Call (by RTOS, sorted low to high)',
                 fontsize=24, weight='bold', y=1.02)
    fig.tight_layout()
    os.makedirs(output_folder, exist_ok=True)
    out_path = os.path.join(output_folder, 'explored_paths_by_syscall_index.png')
    fig.savefig(out_path, dpi=300, bbox_inches='tight')
    dated_copy(out_path)
    plt.close(fig)
    print(f'Explored paths by syscall index saved to: {out_path}')


def plot_path_coverage_by_syscall_index(result_folder, rtos_versions, output_folder,
                                         figsize=(12, 6), use_walltime=True):
    """
    For each RTOS: X = syscall index, Y = path coverage (Completed/Explored).
    Note: Some syscalls have coverage=0 (paths terminated by design, e.g. blocking/fork).
    Prefer plot_explored_paths_by_syscall_index for paper to avoid reviewer questions.
    """
    colors = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b']
    n_rtos = len(rtos_versions)
    fig, axes = plt.subplots(2, 2, figsize=(14, 10))
    axes = axes.flatten()

    for idx, rtos_version in enumerate(rtos_versions):
        if idx >= 4:
            break
        ax = axes[idx]
        df = load_path_coverage_ratio_df(result_folder, rtos_version, use_walltime=use_walltime)
        if df is None or len(df) == 0:
            ax.text(0.5, 0.5, 'No data', ha='center', va='center', transform=ax.transAxes)
            ax.set_title(get_rtos_display_name(rtos_version), fontsize=20)
            continue

        x = np.arange(len(df))
        y = df['PathCoverage'].values
        ax.plot(x, y, color=colors[idx % len(colors)], linewidth=1.5, marker='o',
                markersize=3, alpha=0.8)
        ax.set_xlabel('System Call Index', fontsize=18, weight='bold')
        ax.set_ylabel('Path Coverage\n(Completed / Explored)', fontsize=18, weight='bold')
        ax.set_title(get_rtos_display_name(rtos_version), fontsize=22, weight='bold')
        ax.set_ylim(0, 1.05)
        ax.set_xlim(-0.5, len(df) - 0.5)
        ax.grid(True, linestyle='--', alpha=0.7)
        ax.tick_params(axis='both', labelsize=14)

    for j in range(n_rtos, 4):
        axes[j].set_visible(False)

    fig.suptitle('Path Coverage per System Call (by RTOS)', fontsize=26, weight='bold', y=1.02)
    fig.tight_layout()
    os.makedirs(output_folder, exist_ok=True)
    out_path = os.path.join(output_folder, 'path_coverage_by_syscall_index.png')
    fig.savefig(out_path, dpi=300, bbox_inches='tight')
    dated_copy(out_path)
    plt.close(fig)
    print(f'Path coverage by syscall index saved to: {out_path}')


def plot_path_coverage_cdf(result_folder, rtos_versions, output_path,
                           figsize=(10, 6), x_scale='log', use_walltime=True):
    """
    Plot CDF of path coverage (explored paths per syscall).
    Per syscall: how many paths were covered; CDF shows distribution across syscalls.
    """
    fig, ax = plt.subplots(figsize=figsize)
    colors = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b']
    all_x_max = 0

    for i, rtos_version in enumerate(rtos_versions):
        data = load_explored_paths_per_syscall(result_folder, rtos_version,
                                               use_walltime=use_walltime)
        if data is None:
            continue

        x, y = compute_cdf(data)
        all_x_max = max(all_x_max, x[-1])
        color = colors[i % len(colors)]
        label = get_rtos_display_name(rtos_version)
        ax.plot(x, y, color=color, linewidth=2, label=label)

    ax.set_xlabel('Explored Paths per System Call', fontsize=28, weight='bold')
    ax.set_ylabel('Cumulative Fraction', fontsize=28, weight='bold')
    ax.set_title('CDF of Path Coverage per System Call', fontsize=32, weight='bold')
    ax.legend(fontsize=18, loc='lower right')
    ax.grid(True, linestyle='--', alpha=0.7)
    ax.set_xlim(left=0, right=all_x_max * 1.02)
    ax.set_ylim(bottom=0, top=1.02)

    if x_scale == 'log':
        ax.set_xscale('symlog', linthresh=1, linscale=1)
        ax.set_xlim(left=0)
        xticks = [0, 1, 10, 100, 1000, 10000, 100000]
        xticks = [t for t in xticks if t <= all_x_max * 1.1]
        ax.set_xticks(xticks)
        xtick_labels = ['0' if t == 0 else f'$10^{{{int(np.log10(t))}}}$' for t in xticks]
        ax.set_xticklabels(xtick_labels)

    ax.set_yticks(np.arange(0, 1.1, 0.2))
    ax.set_yticklabels(['0', '0.2', '0.4', '0.6', '0.8', '1.0'], fontsize=24, weight='bold')
    ax.tick_params(axis='both', labelsize=24)
    fig.tight_layout()
    fig.savefig(output_path, dpi=300, bbox_inches='tight')
    dated_copy(output_path)
    plt.close(fig)
    print(f'Path coverage CDF saved to: {output_path}')


def plot_instruction_coverage_box(result_folder, rtos_versions, output_path,
                                  figsize=(10, 6), use_walltime=True):
    """Box plot: instruction coverage distribution per RTOS."""
    fig, ax = plt.subplots(figsize=figsize)
    colors = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b']
    data_by_rtos = []
    labels = []
    for rtos_version in rtos_versions:
        df = load_instruction_coverage_df(result_folder, rtos_version, use_walltime=use_walltime)
        if df is not None and len(df) > 0:
            data_by_rtos.append(df['InstructionCoverage'].values)
            labels.append(get_rtos_display_name(rtos_version))

    if not data_by_rtos:
        print('No instruction coverage data found.')
        return

    bp = ax.boxplot(data_by_rtos, labels=labels, patch_artist=True,
                    showfliers=True, flierprops=dict(marker='o', markersize=4, alpha=0.5))
    for i, patch in enumerate(bp['boxes']):
        patch.set_facecolor(colors[i % len(colors)])
        patch.set_alpha(0.7)
    ax.set_ylabel('Instruction Coverage', fontsize=28, weight='bold')
    ax.set_xlabel('RTOS', fontsize=28, weight='bold')
    ax.set_title('Instruction Coverage per System Call (by RTOS)', fontsize=32, weight='bold')
    ax.set_ylim(0, 1.05)
    ax.tick_params(axis='both', labelsize=20)
    ax.grid(True, axis='y', linestyle='--', alpha=0.7)
    fig.tight_layout()
    fig.savefig(output_path, dpi=300, bbox_inches='tight')
    dated_copy(output_path)
    plt.close(fig)
    print(f'Instruction coverage box plot saved to: {output_path}')


def plot_path_coverage_box(result_folder, rtos_versions, output_path,
                           figsize=(10, 6), use_walltime=True):
    """Box plot: path coverage (Completed/Explored) distribution per RTOS."""
    fig, ax = plt.subplots(figsize=figsize)
    colors = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b']
    data_by_rtos = []
    labels = []
    for rtos_version in rtos_versions:
        df = load_path_coverage_ratio_df(result_folder, rtos_version, use_walltime=use_walltime)
        if df is not None and len(df) > 0:
            data_by_rtos.append(df['PathCoverage'].values)
            labels.append(get_rtos_display_name(rtos_version))

    if not data_by_rtos:
        print('No path coverage data found.')
        return

    bp = ax.boxplot(data_by_rtos, labels=labels, patch_artist=True,
                    showfliers=False)
    for i, patch in enumerate(bp['boxes']):
        patch.set_facecolor(colors[i % len(colors)])
        patch.set_alpha(0.7)
    ax.set_ylabel('Path Coverage (Completed / Explored)', fontsize=28, weight='bold')
    ax.set_xlabel('RTOS', fontsize=28, weight='bold')
    ax.set_title('Path Coverage per System Call (by RTOS)', fontsize=32, weight='bold')
    ax.set_ylim(0, 1.05)
    ax.tick_params(axis='both', labelsize=20)
    ax.grid(True, axis='y', linestyle='--', alpha=0.7)
    fig.tight_layout()
    fig.savefig(output_path, dpi=300, bbox_inches='tight')
    dated_copy(output_path)
    plt.close(fig)
    print(f'Path coverage box plot saved to: {output_path}')


def plot_path_coverage_pareto(result_folder, rtos_version, output_folder,
                               top_n=25, use_walltime=True):
    """Pareto: top N syscalls by explored paths (per RTOS)."""
    df = load_path_coverage_df(result_folder, rtos_version, use_walltime=use_walltime)
    if df is None or len(df) == 0:
        return
    df = df.sort_values('Explored Paths', ascending=False).head(top_n)
    total = df['Explored Paths'].sum()
    df['Pct'] = df['Explored Paths'] / total * 100
    df['CumPct'] = df['Pct'].cumsum()

    fig, ax1 = plt.subplots(figsize=(12, 6))
    x = np.arange(len(df))
    ax1.bar(x, df['Explored Paths'], color='#1f77b4', alpha=0.8)
    ax1.set_xlabel('System Call', fontsize=24, weight='bold')
    ax1.set_ylabel('Explored Paths', fontsize=24, weight='bold')
    ax1.set_xticks(x)
    ax1.set_xticklabels(df['System Call'], rotation=45, ha='right', fontsize=14)
    ax1.set_yscale('symlog', linthresh=1, linscale=1)
    ax1.set_ylim(bottom=0)

    ax2 = ax1.twinx()
    ax2.plot(x, df['CumPct'], color='#d62728', linewidth=2, marker='o', markersize=4)
    ax2.set_ylabel('Cumulative %', fontsize=24, weight='bold')
    ax2.set_ylim(0, 105)
    ax2.set_yticks(np.arange(0, 101, 20))

    ax1.set_title(f'Top {top_n} Syscalls by Path Coverage - {get_rtos_display_name(rtos_version)}',
                  fontsize=28, weight='bold')
    fig.tight_layout()
    os.makedirs(output_folder, exist_ok=True)
    out_path = os.path.join(output_folder, f'{rtos_version}_path_coverage_pareto.png')
    fig.savefig(out_path, dpi=300, bbox_inches='tight')
    dated_copy(out_path)
    plt.close(fig)
    print(f'Path coverage Pareto saved to: {out_path}')


if __name__ == '__main__':
    result_folder = str(_SCRIPT_DIR / 'results')
    store_folder = str(_SCRIPT_DIR / 'results' / 'path_coverage')

    if not os.path.exists(store_folder):
        os.makedirs(store_folder)

    rtos_list = ['freertos-10.5.1', 'tizenrt', 'threadx-6.4.2', 'rt-thread']
    rtos_available = [r for r in rtos_list
                      if (os.path.exists(os.path.join(result_folder, f'{r}_runtime_info_walltime.xlsx')) or
                         os.path.exists(os.path.join(result_folder, f'{r}_runtime_info.xlsx')))]

    if rtos_available:
        plot_instruction_coverage_by_syscall_index(result_folder, rtos_available, store_folder,
                                                    use_walltime=True)
        plot_path_coverage_by_syscall_index(result_folder, rtos_available, store_folder,
                                            use_walltime=True)
        output_path_box = os.path.join(store_folder, 'path_coverage_box.png')
        plot_path_coverage_box(result_folder, rtos_available, output_path_box, use_walltime=True)

        output_cdf = os.path.join(store_folder, 'path_coverage_cdf.png')
        plot_path_coverage_cdf(result_folder, rtos_available, output_cdf,
                              x_scale='log', use_walltime=True)

        for r in rtos_available:
            plot_path_coverage_pareto(result_folder, r, store_folder,
                                     top_n=25, use_walltime=True)
    else:
        print('No runtime_info found. Run data-analyze-all.py first.')
