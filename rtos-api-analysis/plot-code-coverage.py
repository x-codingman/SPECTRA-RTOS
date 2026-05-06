#!/usr/bin/env python3
"""
Plot code coverage (instruction coverage) for symbolic execution of RTOS system calls.

Code coverage = CoveredInstructions / (CoveredInstructions + UncoveredInstructions)
from KLEE's run.stats. Measures the fraction of LLVM instructions that were
executed at least once during symbolic execution.

Prerequisite: Run data-analyze-all.py first to populate InstructionCoverage in xlsx.
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


def load_code_coverage_df(result_folder, rtos_version, use_walltime=True):
    """Load (System Call, InstructionCoverage) from runtime_info_walltime.xlsx."""
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
    df['CodeCoverage'] = pd.to_numeric(df['InstructionCoverage'], errors='coerce')
    df = df.dropna(subset=['CodeCoverage'])
    df = df[df['CodeCoverage'] >= 0]
    df = df.sort_values('CodeCoverage', ascending=True).reset_index(drop=True)
    return df[['System Call', 'CodeCoverage']]


def compute_cdf(data):
    """ECDF: (0,0) prepended, piecewise linear."""
    x = np.sort(data)
    n = len(x)
    if n == 0:
        return np.array([0]), np.array([0])
    x_vals = np.concatenate([[0], x])
    y_vals = np.concatenate([[0], np.arange(1, n + 1) / n])
    return x_vals, y_vals


def plot_code_coverage_by_syscall(result_folder, rtos_versions, output_folder,
                                  figsize=(14, 10), use_walltime=True):
    """For each RTOS: X = syscall index, Y = code coverage (sorted low to high)."""
    colors = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b']
    n_rtos = len(rtos_versions)
    fig, axes = plt.subplots(2, 2, figsize=figsize)
    axes = axes.flatten()

    for idx, rtos_version in enumerate(rtos_versions):
        if idx >= 4:
            break
        ax = axes[idx]
        df = load_code_coverage_df(result_folder, rtos_version, use_walltime=use_walltime)
        if df is None or len(df) == 0:
            ax.text(0.5, 0.5, 'No data', ha='center', va='center', transform=ax.transAxes)
            ax.set_title(get_rtos_display_name(rtos_version), fontsize=20)
            continue

        x = np.arange(len(df))
        y = df['CodeCoverage'].values
        ax.plot(x, y, color=colors[idx % len(colors)], linewidth=1.5, marker='o',
                markersize=3, alpha=0.8)
        ax.set_xlabel('System Call Index', fontsize=18, weight='bold')
        ax.set_ylabel('Code Coverage', fontsize=18, weight='bold')
        ax.set_title(get_rtos_display_name(rtos_version), fontsize=22, weight='bold')
        ax.set_ylim(0, 1.05)
        ax.set_xlim(-0.5, len(df) - 0.5)
        ax.grid(True, linestyle='--', alpha=0.7)
        ax.tick_params(axis='both', labelsize=14)
        ax.set_yticks(np.arange(0, 1.1, 0.2))

    for j in range(n_rtos, 4):
        axes[j].set_visible(False)

    fig.suptitle('Code Coverage per System Call (by RTOS, sorted low to high)',
                 fontsize=24, weight='bold', y=1.02)
    fig.tight_layout()
    os.makedirs(output_folder, exist_ok=True)
    out_path = os.path.join(output_folder, 'code_coverage_by_syscall_index.png')
    fig.savefig(out_path, dpi=300, bbox_inches='tight')
    dated_copy(out_path)
    plt.close(fig)
    print(f'Code coverage by syscall index saved to: {out_path}')


def plot_code_coverage_cdf(result_folder, rtos_versions, output_path,
                           figsize=(10, 6), use_walltime=True):
    """Plot CDF of code coverage across syscalls per RTOS."""
    fig, ax = plt.subplots(figsize=figsize)
    colors = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b']

    for i, rtos_version in enumerate(rtos_versions):
        df = load_code_coverage_df(result_folder, rtos_version, use_walltime=use_walltime)
        if df is None or len(df) == 0:
            continue
        data = df['CodeCoverage'].values
        x, y = compute_cdf(data)
        color = colors[i % len(colors)]
        label = get_rtos_display_name(rtos_version)
        ax.plot(x, y, color=color, linewidth=2, label=label)

    ax.set_xlabel('Code Coverage', fontsize=28, weight='bold')
    ax.set_ylabel('Cumulative Fraction', fontsize=28, weight='bold')
    ax.set_title('CDF of Code Coverage per System Call', fontsize=32, weight='bold')
    ax.legend(fontsize=18, loc='lower right')
    ax.grid(True, linestyle='--', alpha=0.7)
    ax.set_xlim(0, 1.02)
    ax.set_ylim(0, 1.02)
    ax.set_yticks(np.arange(0, 1.1, 0.2))
    ax.tick_params(axis='both', labelsize=20)
    fig.tight_layout()
    fig.savefig(output_path, dpi=300, bbox_inches='tight')
    dated_copy(output_path)
    plt.close(fig)
    print(f'Code coverage CDF saved to: {output_path}')


def plot_code_coverage_box(result_folder, rtos_versions, output_path,
                           figsize=(10, 6), use_walltime=True):
    """Box plot: code coverage distribution per RTOS."""
    fig, ax = plt.subplots(figsize=figsize)
    colors = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b']
    data_by_rtos = []
    labels = []
    for rtos_version in rtos_versions:
        df = load_code_coverage_df(result_folder, rtos_version, use_walltime=use_walltime)
        if df is not None and len(df) > 0:
            data_by_rtos.append(df['CodeCoverage'].values)
            labels.append(get_rtos_display_name(rtos_version))

    if not data_by_rtos:
        print('No code coverage data found.')
        return

    bp = ax.boxplot(data_by_rtos, labels=labels, patch_artist=True,
                    showfliers=True, flierprops=dict(marker='o', markersize=4, alpha=0.5))
    for i, patch in enumerate(bp['boxes']):
        patch.set_facecolor(colors[i % len(colors)])
        patch.set_alpha(0.7)
    ax.set_ylabel('Code Coverage', fontsize=28, weight='bold')
    ax.set_xlabel('RTOS', fontsize=28, weight='bold')
    ax.set_title('Code Coverage per System Call (by RTOS)', fontsize=32, weight='bold')
    ax.set_ylim(0, 1.05)
    ax.tick_params(axis='both', labelsize=20)
    ax.grid(True, axis='y', linestyle='--', alpha=0.7)
    fig.tight_layout()
    fig.savefig(output_path, dpi=300, bbox_inches='tight')
    dated_copy(output_path)
    plt.close(fig)
    print(f'Code coverage box plot saved to: {output_path}')


def print_code_coverage_summary(result_folder, rtos_versions, use_walltime=True):
    """Print summary statistics for code coverage."""
    print('\n=== Code Coverage Summary ===')
    print('(Code coverage = CoveredInstructions / (Covered + Uncovered) from KLEE run.stats)')
    print()
    for rtos_version in rtos_versions:
        df = load_code_coverage_df(result_folder, rtos_version, use_walltime=use_walltime)
        if df is None or len(df) == 0:
            print(f'{get_rtos_display_name(rtos_version)}: No data')
            continue
        cov = df['CodeCoverage'].values
        print(f'{get_rtos_display_name(rtos_version)}:')
        print(f'  syscalls: {len(cov)}, mean: {cov.mean():.3f}, median: {np.median(cov):.3f}')
        print(f'  min: {cov.min():.3f}, max: {cov.max():.3f}')
        low = (cov < 0.5).sum()
        if low > 0:
            print(f'  low (<0.5): {low}')
        print()


if __name__ == '__main__':
    result_folder = str(_SCRIPT_DIR / 'results')
    store_folder = str(_SCRIPT_DIR / 'results' / 'code_coverage')

    rtos_list = ['freertos-10.5.1', 'tizenrt', 'threadx-6.4.2', 'rt-thread']
    rtos_available = [r for r in rtos_list
                      if (os.path.exists(os.path.join(result_folder, f'{r}_runtime_info_walltime.xlsx')) or
                         os.path.exists(os.path.join(result_folder, f'{r}_runtime_info.xlsx')))]

    if not rtos_available:
        print('No runtime_info found. Run data-analyze-all.py first.')

    os.makedirs(store_folder, exist_ok=True)

    print_code_coverage_summary(result_folder, rtos_available, use_walltime=True)

    if rtos_available:
        plot_code_coverage_by_syscall(result_folder, rtos_available, store_folder,
                                      use_walltime=True)
        plot_code_coverage_cdf(result_folder, rtos_available,
                              os.path.join(store_folder, 'code_coverage_cdf.png'),
                              use_walltime=True)
        plot_code_coverage_box(result_folder, rtos_available,
                              os.path.join(store_folder, 'code_coverage_box.png'),
                              use_walltime=True)
        print(f'\nAll code coverage plots saved to: {store_folder}')
