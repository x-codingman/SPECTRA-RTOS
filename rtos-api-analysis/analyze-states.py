import os
import re
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import sqlite3

from output_utils import dated_copy

_REPO_ROOT = Path(__file__).resolve().parent.parent
_SCRIPT_DIR = Path(__file__).resolve().parent


def get_explored_paths_from_info(info_path):
    """Return explored paths count from a KLEE ``info`` file, or ``None``."""
    if not os.path.exists(info_path):
        return None
    try:
        with open(info_path, 'r') as f:
            content = f.read()
            match = re.search(r'KLEE: done: explored paths = (\d+)', content)
            if match:
                return int(match.group(1))
    except Exception as e:
        print(f"Error reading {info_path}: {e}")
    return None


def get_fork_stats_from_info(info_path):
    """Return fork timing / percentage fields parsed from ``info``, or ``None``."""
    if not os.path.exists(info_path):
        return None
    try:
        with open(info_path, 'r') as f:
            content = f.read()
            
            forks_time_match = re.search(r'KLEE: done: forks time = (\d+)', content)
            forks_time = int(forks_time_match.group(1)) if forks_time_match else 0
            
            kernel_forks_time_match = re.search(r'KLEE: done: kernel objects forks time = (\d+)', content)
            kernel_forks_time = int(kernel_forks_time_match.group(1)) if kernel_forks_time_match else 0
            
            kernel_forks_percentage_match = re.search(r'KLEE: done: kernel objects forks time percentage = ([\d.]+)%', content)
            kernel_forks_percentage = float(kernel_forks_percentage_match.group(1)) if kernel_forks_percentage_match else 0.0
            
            param_forks_time_match = re.search(r'KLEE: done: parameter caused forks time = (\d+)', content)
            param_forks_time = int(param_forks_time_match.group(1)) if param_forks_time_match else 0
            
            param_forks_percentage_match = re.search(r'KLEE: done: parameter caused forks time percentage = ([\d.]+)%', content)
            param_forks_percentage = float(param_forks_percentage_match.group(1)) if param_forks_percentage_match else 0.0
            
            return {
                'ForksTime': forks_time,
                'KernelForksTime': kernel_forks_time,
                'KernelForksPercentage': kernel_forks_percentage,
                'ParamForksTime': param_forks_time,
                'ParamForksPercentage': param_forks_percentage
            }
    except Exception as e:
        print(f"Error reading {info_path}: {e}")
    return None


def plot_states(df, rtos_name, output_folder):
    """Bar chart of explored paths per system call."""
    plt.figure(figsize=(12, 8))
    bar_width = 0.5
    plt.bar(range(len(df)), df['ExploredPaths'], width=bar_width)
    
    num_ticks = min(10, len(df))
    tick_positions = np.linspace(0, len(df)-1, num_ticks, dtype=int)
    tick_labels = [f"{i+1}" for i in tick_positions]
    
    plt.xticks(tick_positions, tick_labels, rotation=0, fontsize=28, weight='bold')
    plt.xlabel('System Call Index', fontsize=28, weight='bold')
    plt.ylabel('Number of Explored Paths', fontsize=28, weight='bold')
    plt.title(f'States Analysis - {rtos_name}', fontsize=32, weight='bold')
    plt.grid(True, linestyle='--', alpha=0.7)
    
    if df['ExploredPaths'].max() > 0:
        plt.yscale('log', base=10)
        y_max = np.ceil(np.log10(df['ExploredPaths'].max()))
        y_ticks = [10**i for i in range(int(y_max)+1)]
        y_labels = [f'10^{i}' for i in range(int(y_max)+1)]
        plt.yticks(y_ticks, y_labels, fontsize=24, weight='bold')
    
    plt.tight_layout()
    _p = os.path.join(output_folder, f'{rtos_name}_states.png')
    plt.savefig(_p, dpi=300, bbox_inches='tight')
    dated_copy(_p)
    plt.close()


def plot_forks_time(df, rtos_name, output_folder):
    """Bar chart of fork time per system call."""
    plt.figure(figsize=(12, 8))
    bar_width = 0.5
    plt.bar(range(len(df)), df['ForksTime'], width=bar_width)
    
    num_ticks = min(10, len(df))
    tick_positions = np.linspace(0, len(df)-1, num_ticks, dtype=int)
    tick_labels = [f"{i+1}" for i in tick_positions]
    
    plt.xticks(tick_positions, tick_labels, rotation=0, fontsize=28, weight='bold')
    plt.xlabel('System Call Index', fontsize=28, weight='bold')
    plt.ylabel('Forks Time (ms)', fontsize=28, weight='bold')
    plt.title(f'Forks Time Analysis - {rtos_name}', fontsize=32, weight='bold')
    plt.grid(True, linestyle='--', alpha=0.7)
    
    if df['ForksTime'].max() > 0:
        plt.yscale('log', base=10)
        y_max = np.ceil(np.log10(df['ForksTime'].max()))
        y_ticks = [10**i for i in range(int(y_max)+1)]
        y_labels = [f'10^{i}' for i in range(int(y_max)+1)]
        plt.yticks(y_ticks, y_labels, fontsize=24, weight='bold')
    
    plt.tight_layout()
    _p = os.path.join(output_folder, f'{rtos_name}_forks_time.png')
    plt.savefig(_p, dpi=300, bbox_inches='tight')
    dated_copy(_p)
    plt.close()


def plot_kernel_forks_percentage(df, rtos_name, output_folder):
    """Kernel forks time as percentage of fork time."""
    plt.figure(figsize=(12, 8))
    bar_width = 0.5
    plt.bar(range(len(df)), df['KernelForksPercentage'], width=bar_width)
    
    num_ticks = min(10, len(df))
    tick_positions = np.linspace(0, len(df)-1, num_ticks, dtype=int)
    tick_labels = [f"{i+1}" for i in tick_positions]
    
    plt.xticks(tick_positions, tick_labels, rotation=0, fontsize=28, weight='bold')
    plt.xlabel('System Call Index', fontsize=28, weight='bold')
    plt.ylabel('Kernel Forks Percentage (%)', fontsize=28, weight='bold')
    plt.title(f'Kernel Forks Percentage Analysis - {rtos_name}', fontsize=32, weight='bold')
    plt.grid(True, linestyle='--', alpha=0.7)
    
    plt.ylim(0, 100)
    y_ticks = [0, 20, 40, 60, 80, 100]
    y_labels = ['0%', '20%', '40%', '60%', '80%', '100%']
    plt.yticks(y_ticks, y_labels, fontsize=24, weight='bold')
    
    plt.tight_layout()
    _p = os.path.join(output_folder, f'{rtos_name}_kernel_forks_percentage.png')
    plt.savefig(_p, dpi=300, bbox_inches='tight')
    dated_copy(_p)
    plt.close()


def plot_fork_distribution(df, rtos_name, output_folder):
    """Pie chart: syscalls with non-zero fork / param / kernel-object fork counts."""
    total_forks_gt_zero = df[df['ForksTime'] > 0]
    param_forks_gt_zero = df[df['ParamForksTime'] > 0]
    kernel_forks_gt_zero = df[df['KernelForksTime'] > 0]
    
    plt.figure(figsize=(12, 8))

    labels = ['Total Forks > 0', 'Parameter Forks > 0', 'Kernel Forks > 0']
    sizes = [len(total_forks_gt_zero), len(param_forks_gt_zero), len(kernel_forks_gt_zero)]
    colors = ['#ff9999', '#66b3ff', '#99ff99']

    plt.pie(sizes, labels=labels, colors=colors, autopct='%1.1f%%', startangle=90, 
            textprops={'fontsize': 18, 'weight': 'bold'})
    plt.title(f'Fork Distribution Analysis - {rtos_name}', fontsize=24, weight='bold')

    total_functions = len(df)
    total_gt_zero_count = len(total_forks_gt_zero)
    param_gt_zero_count = len(param_forks_gt_zero)
    kernel_gt_zero_count = len(kernel_forks_gt_zero)
    
    total_gt_zero_percentage = round((total_gt_zero_count / total_functions) * 100, 1) if total_functions > 0 else 0
    param_gt_zero_percentage = round((param_gt_zero_count / total_functions) * 100, 1) if total_functions > 0 else 0
    kernel_gt_zero_percentage = round((kernel_gt_zero_count / total_functions) * 100, 1) if total_functions > 0 else 0
    
    info_text = f'Total Functions: {total_functions}\n'
    info_text += f'Total Forks > 0: {total_gt_zero_count} ({total_gt_zero_percentage}%)\n'
    info_text += f'Parameter Forks > 0: {param_gt_zero_count} ({param_gt_zero_percentage}%)\n'
    info_text += f'Kernel Forks > 0: {kernel_gt_zero_count} ({kernel_gt_zero_percentage}%)'
    
    plt.figtext(0.5, 0.02, info_text, ha='center', fontsize=14, weight='bold',
               bbox=dict(boxstyle="round,pad=0.3", facecolor="white", alpha=0.8))
    
    plt.tight_layout()
    _p = os.path.join(output_folder, f'{rtos_name}_fork_distribution.png')
    plt.savefig(_p, dpi=300, bbox_inches='tight')
    dated_copy(_p)
    plt.close()


def plot_parameter_forks_percentage(df, rtos_name, output_folder):
    """Bar chart of parameter-caused forks percentage."""
    plt.figure(figsize=(12, 8))
    bar_width = 0.5
    plt.bar(range(len(df)), df['ParamForksPercentage'], width=bar_width)
    
    num_ticks = min(10, len(df))
    tick_positions = np.linspace(0, len(df)-1, num_ticks, dtype=int)
    tick_labels = [f"{i+1}" for i in tick_positions]
    
    plt.xticks(tick_positions, tick_labels, rotation=0, fontsize=28, weight='bold')
    plt.xlabel('System Call Index', fontsize=28, weight='bold')
    plt.ylabel('Parameter Forks Percentage (%)', fontsize=28, weight='bold')
    plt.title(f'Parameter Forks Percentage Analysis - {rtos_name}', fontsize=32, weight='bold')
    plt.grid(True, linestyle='--', alpha=0.7)
    
    plt.ylim(0, 100)
    y_ticks = [0, 20, 40, 60, 80, 100]
    y_labels = ['0%', '20%', '40%', '60%', '80%', '100%']
    plt.yticks(y_ticks, y_labels, fontsize=24, weight='bold')
    
    plt.tight_layout()
    _p = os.path.join(output_folder, f'{rtos_name}_parameter_forks_percentage.png')
    plt.savefig(_p, dpi=300, bbox_inches='tight')
    dated_copy(_p)
    plt.close()


def plot_fork_comparison(df, rtos_name, output_folder):
    """Grouped bars: kernel vs parameter fork percentages."""
    plt.figure(figsize=(12, 8))
    
    x = range(len(df))
    bar_width = 0.35
    
    plt.bar([i - bar_width/2 for i in x], df['KernelForksPercentage'], bar_width, 
            label='Kernel Forks %', color='#ff9999', alpha=0.8)
    plt.bar([i + bar_width/2 for i in x], df['ParamForksPercentage'], bar_width, 
            label='Parameter Forks %', color='#66b3ff', alpha=0.8)
    
    num_ticks = min(10, len(df))
    tick_positions = np.linspace(0, len(df)-1, num_ticks, dtype=int)
    tick_labels = [f"{i+1}" for i in tick_positions]
    
    plt.xticks(tick_positions, tick_labels, rotation=0, fontsize=24, weight='bold')
    plt.xlabel('System Call Index', fontsize=28, weight='bold')
    plt.ylabel('Forks Percentage (%)', fontsize=28, weight='bold')
    plt.title(f'Kernel vs Parameter Forks Comparison - {rtos_name}', fontsize=32, weight='bold')
    plt.legend(fontsize=20, loc='upper right')
    plt.grid(True, linestyle='--', alpha=0.7)
    
    plt.ylim(0, 100)
    y_ticks = [0, 20, 40, 60, 80, 100]
    y_labels = ['0%', '20%', '40%', '60%', '80%', '100%']
    plt.yticks(y_ticks, y_labels, fontsize=20, weight='bold')
    
    plt.tight_layout()
    _p = os.path.join(output_folder, f'{rtos_name}_fork_comparison.png')
    plt.savefig(_p, dpi=300, bbox_inches='tight')
    dated_copy(_p)
    plt.close()


def analyze_states(root_folder, output_folder, rtos_name):
    """Build per-harness dataframe from ``info`` files and emit plots."""
    data_list = []
    
    for folder in os.listdir(root_folder):
        folder_path = os.path.join(root_folder, folder)
        if os.path.isdir(folder_path):
            explored_paths = get_explored_paths_from_info(os.path.join(folder_path, 'info'))
            fork_stats = get_fork_stats_from_info(os.path.join(folder_path, 'info'))
            
            if explored_paths is not None and fork_stats is not None:
                data_list.append({
                    'System Call': folder,
                    'ExploredPaths': explored_paths,
                    'ForksTime': fork_stats['ForksTime'],
                    'KernelForksTime': fork_stats['KernelForksTime'],
                    'KernelForksPercentage': fork_stats['KernelForksPercentage'],
                    'ParamForksTime': fork_stats['ParamForksTime'],
                    'ParamForksPercentage': fork_stats['ParamForksPercentage']
                })
    
    if not data_list:
        print(f"No valid data found for {rtos_name}")
        return None
    
    df = pd.DataFrame(data_list)
    
    total_forks_time = df['ForksTime'].sum()
    if total_forks_time > 0:
        df['KernelForksPercentageOfTotal'] = round((df['KernelForksTime'] / total_forks_time) * 100, 2)
        df['ParamForksPercentageOfTotal'] = round((df['ParamForksTime'] / total_forks_time) * 100, 2)
    else:
        df['KernelForksPercentageOfTotal'] = 0.0
        df['ParamForksPercentageOfTotal'] = 0.0
    
    kernel_forks_gt_zero = df[df['KernelForksTime'] > 0]
    kernel_forks_gt_zero_count = len(kernel_forks_gt_zero)
    kernel_forks_gt_zero_percentage = round((kernel_forks_gt_zero_count / len(df)) * 100, 2) if len(df) > 0 else 0
    
    stats_summary = [
        {'Metric': 'Total Explored Paths', 'Value': int(df['ExploredPaths'].sum())},
        {'Metric': 'Average Explored Paths', 'Value': round(df['ExploredPaths'].mean(), 2)},
        {'Metric': 'Median Explored Paths', 'Value': round(df['ExploredPaths'].median(), 2)},
        {'Metric': 'Max Explored Paths', 'Value': int(df['ExploredPaths'].max())},
        {'Metric': 'Min Explored Paths', 'Value': int(df['ExploredPaths'].min())},
        {'Metric': 'Explored Paths Std Dev', 'Value': round(df['ExploredPaths'].std(), 2)},
        
        {'Metric': 'Total Forks Time', 'Value': int(df['ForksTime'].sum())},
        {'Metric': 'Average Forks Time', 'Value': round(df['ForksTime'].mean(), 2)},
        {'Metric': 'Median Forks Time', 'Value': round(df['ForksTime'].median(), 2)},
        {'Metric': 'Max Forks Time', 'Value': int(df['ForksTime'].max())},
        {'Metric': 'Min Forks Time', 'Value': int(df['ForksTime'].min())},
        {'Metric': 'Forks Time Std Dev', 'Value': round(df['ForksTime'].std(), 2)},
        
        {'Metric': 'Total Kernel Forks Time', 'Value': int(df['KernelForksTime'].sum())},
        {'Metric': 'Average Kernel Forks Time', 'Value': round(df['KernelForksTime'].mean(), 2)},
        {'Metric': 'Median Kernel Forks Time', 'Value': round(df['KernelForksTime'].median(), 2)},
        {'Metric': 'Max Kernel Forks Time', 'Value': int(df['KernelForksTime'].max())},
        {'Metric': 'Min Kernel Forks Time', 'Value': int(df['KernelForksTime'].min())},
        
        {'Metric': 'Average Kernel Forks Percentage', 'Value': round(df['KernelForksPercentage'].mean(), 2)},
        {'Metric': 'Max Kernel Forks Percentage', 'Value': round(df['KernelForksPercentage'].max(), 2)},
        {'Metric': 'Min Kernel Forks Percentage', 'Value': round(df['KernelForksPercentage'].min(), 2)},
        
        {'Metric': 'Total Parameter Forks Time', 'Value': int(df['ParamForksTime'].sum())},
        {'Metric': 'Average Parameter Forks Time', 'Value': round(df['ParamForksTime'].mean(), 2)},
        {'Metric': 'Median Parameter Forks Time', 'Value': round(df['ParamForksTime'].median(), 2)},
        {'Metric': 'Max Parameter Forks Time', 'Value': int(df['ParamForksTime'].max())},
        {'Metric': 'Min Parameter Forks Time', 'Value': int(df['ParamForksTime'].min())},
        
        {'Metric': 'Average Parameter Forks Percentage', 'Value': round(df['ParamForksPercentage'].mean(), 2)},
        {'Metric': 'Max Parameter Forks Percentage', 'Value': round(df['ParamForksPercentage'].max(), 2)},
        {'Metric': 'Min Parameter Forks Percentage', 'Value': round(df['ParamForksPercentage'].min(), 2)},
        
        {'Metric': 'Functions with Kernel Forks > 0', 'Value': kernel_forks_gt_zero_count},
        {'Metric': 'Functions with Kernel Forks > 0 Percentage', 'Value': f"{kernel_forks_gt_zero_percentage}%"},
        {'Metric': 'Total Functions Analyzed', 'Value': len(df)}
    ]
    
    summary_df = pd.DataFrame(stats_summary)
    excel_path = os.path.join(output_folder, f'{rtos_name}_states_analysis.xlsx')
    
    with pd.ExcelWriter(excel_path, engine='openpyxl') as writer:
        df.to_excel(writer, sheet_name='Detailed States Data', index=False)
        summary_df.to_excel(writer, sheet_name='Summary Statistics', index=False)
    dated_copy(excel_path)

    print(f'States analysis results saved to: {excel_path}')
    print(f'{rtos_name} - Functions with Kernel Forks > 0: {kernel_forks_gt_zero_count}/{len(df)} ({kernel_forks_gt_zero_percentage}%)')
    print(f'{rtos_name} - Median Forks Time: {round(df["ForksTime"].median(), 2)}')
    
    plot_states(df, rtos_name, output_folder)
    plot_forks_time(df, rtos_name, output_folder)
    plot_kernel_forks_percentage(df, rtos_name, output_folder)
    plot_fork_distribution(df, rtos_name, output_folder)
    plot_parameter_forks_percentage(df, rtos_name, output_folder)
    plot_fork_comparison(df, rtos_name, output_folder)
    
    return df


if __name__ == '__main__':
    tr = _REPO_ROOT / 'test-rtos'
    root_folders = [
        str(tr / 'freertos-10.5.1' / 'symbolic_execution' / 'output'),
        str(tr / 'threadx-6.4.2' / 'symbolic_execution' / 'output'),
        str(tr / 'rt-thread' / 'symbolic_execution' / 'output'),
        str(tr / 'tizenrt' / 'symbolic_execution' / 'output'),
    ]
    rtos_names = [
        'FreeRTOS',
        'ThreadX',
        'RT-Thread',
        'TizenRT'
    ]
    output_folder = str(_SCRIPT_DIR / 'results' / 'states')
    
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)
    
    all_rtos_states_data = []
    all_rtos_forks_time_data = []
    all_rtos_kernel_forks_percentage_data = []
    
    for root_folder, rtos_name in zip(root_folders, rtos_names):
        print(f"Analyzing states for {rtos_name}...")
        df = analyze_states(root_folder, output_folder, rtos_name)
        if df is not None:
            all_rtos_states_data.append(df['ExploredPaths'].values)
            all_rtos_forks_time_data.append(df['ForksTime'].values)
            all_rtos_kernel_forks_percentage_data.append(df['KernelForksPercentage'].values)
    
    print("States analysis completed!") 