import os
import pandas as pd
import matplotlib.pyplot as plt
import re
import sqlite3
import numpy as np


def get_max_memory_usage(stats_path):
    if not os.path.exists(stats_path):
        return None
    try:
        conn = sqlite3.connect(stats_path)
        cursor = conn.cursor()
        cursor.execute("SELECT MAX(MallocUsage) FROM stats;")
        result = cursor.fetchone()
        conn.close()
        if result and result[0]:
            return round(float(result[0]) / (1024 * 1024), 2)  # 转为MB并保留两位小数
    except Exception as e:
        print(f"Error reading {stats_path}: {e}")
    return None

def get_klee_stats(stats_path):
    if not os.path.exists(stats_path):
        return None
    try:
        conn = sqlite3.connect(stats_path)
        cursor = conn.cursor()
        cursor.execute("""
            SELECT Instructions, MallocUsage, CoveredInstructions, UncoveredInstructions
            FROM stats
            ORDER BY Instructions DESC LIMIT 1;
        """)
        result = cursor.fetchone()
        conn.close()
        if result:
            instructions = float(result[0])
            memory_mb = round(float(result[1]) / (1024 * 1024), 2)
            covered = float(result[2])
            uncovered = float(result[3])
            coverage = round(covered / (covered + uncovered), 2) if (covered + uncovered) > 0 else 0.00
            return instructions, memory_mb, coverage
    except Exception as e:
        print(f"Error reading {stats_path}: {e}")
    return None, None, None

def plot_instructions(df, rtos_name, output_folder):
    plt.figure(figsize=(12, 6))
    bar_width = 0.5
    plt.bar(range(len(df)), df['Instructions'], width=bar_width)
    
    num_ticks = min(10, len(df))
    tick_positions = np.linspace(0, len(df)-1, num_ticks, dtype=int)
    tick_labels = [f"{i+1}" for i in tick_positions]
    
    plt.xticks(tick_positions, tick_labels, rotation=0)
    plt.title(f'Instructions by System Call - {rtos_name}')
    plt.xlabel('System Call Index')
    plt.ylabel('Instructions')
    plt.grid(True, linestyle='--', alpha=0.7)
    
    plt.yscale('log', base=10)
    
    # 统一纵坐标刻度，从1开始
    y_min = 0  # 从1开始，所以log10(1) = 0
    y_max = np.ceil(np.log10(df['Instructions'].max()))
    y_ticks = [10**i for i in range(int(y_min), int(y_max)+1)]
    y_labels = [f'10^{i}' for i in range(int(y_min), int(y_max)+1)]
    plt.yticks(y_ticks, y_labels)
    
    plt.tight_layout()
    plt.savefig(os.path.join(output_folder, f'{rtos_name}_instructions.png'), dpi=300, bbox_inches='tight')

def plot_memory(df, rtos_name, output_folder):
    plt.figure(figsize=(12, 8))
    bar_width = 0.5
    plt.bar(range(len(df)), df['Memory Usage (MB)'], width=bar_width)
    
    num_ticks = min(10, len(df))
    tick_positions = np.linspace(0, len(df)-1, num_ticks, dtype=int)
    tick_labels = [f"{i+1}" for i in tick_positions]
    
    plt.xticks(tick_positions, tick_labels, rotation=0, fontsize=32, weight='bold')
    plt.xlabel('System Call Index', fontsize=45, weight='bold')
    plt.ylabel('Memory Usage (MB)', fontsize=45, weight='bold')
    plt.grid(True, linestyle='--', alpha=0.7)
    
    plt.yscale('log', base=10)
    
    # 统一纵坐标刻度，从1开始
    y_min = 0  # 从1开始，所以log10(1) = 0
    y_max = np.ceil(np.log10(df['Memory Usage (MB)'].max()))
    y_ticks = [10**i for i in range(int(y_min), int(y_max)+1)]
    y_labels = [f'10^{i}' for i in range(int(y_min), int(y_max)+1)]
    plt.yticks(y_ticks, y_labels, fontsize=32, weight='bold')
    
    plt.tight_layout()
    plt.savefig(os.path.join(output_folder, f'{rtos_name}_memory.png'), dpi=300, bbox_inches='tight')
    
def plot_coverage(df, rtos_name, output_folder):
    plt.figure(figsize=(12, 8))
    bar_width = 0.5
    plt.bar(range(len(df)), df['Coverage'], width=bar_width)
    
    num_ticks = min(10, len(df))
    tick_positions = np.linspace(0, len(df)-1, num_ticks, dtype=int)
    tick_labels = [f"{i+1}" for i in tick_positions]
    
    plt.xticks(tick_positions, tick_labels, rotation=0, fontsize=28, weight='bold')
    plt.xlabel('System Call Index', fontsize=28, weight='bold') 
    plt.ylabel('Coverage', fontsize=28, weight='bold')
    plt.grid(True, linestyle='--', alpha=0.7)
    
    # Set y-axis limits from 0 to 1 since coverage is a ratio
    plt.ylim(0, 1)
    
    # Set y-axis ticks at regular intervals
    y_ticks = [0, 0.2, 0.4, 0.6, 0.8, 1.0]
    y_labels = ['0', '0.2', '0.4', '0.6', '0.8', '1.0']
    plt.yticks(y_ticks, y_labels, fontsize=24, weight='bold')
    
    plt.tight_layout()
    plt.savefig(os.path.join(output_folder, f'{rtos_name}_coverage.png'), dpi=300, bbox_inches='tight')
    

def analyze_memory_and_coverage(root_folder, output_folder, rtos_name):
    df = pd.DataFrame(columns=['System Call', 'Instructions', 'Memory Usage (MB)', 'Coverage'])
    
    for folder in os.listdir(root_folder):
        folder_path = os.path.join(root_folder, folder)
        if os.path.isdir(folder_path):
            stats = get_klee_stats(os.path.join(folder_path, 'run.stats'))
            if stats:
                    instructions, memory_mb, coverage = stats
                    df = df.append({
                        'System Call': folder,
                        'Instructions': round(instructions, 2),   
                        'Memory Usage (MB)': memory_mb,
                        'Coverage': coverage
                    }, ignore_index=True)

    stats = {
        'Total Memory (MB)': round(df['Memory Usage (MB)'].sum(), 4),
        'Average Memory (MB)': round(df['Memory Usage (MB)'].mean(), 4),
        'Max Memory (MB)': round(df['Memory Usage (MB)'].max(), 4),
        'Min Memory (MB)': round(df['Memory Usage (MB)'].min(), 4),
        'Memory Std Dev (MB)': round(df['Memory Usage (MB)'].std(), 4),
        'Average Coverage': round(df['Coverage'].mean(), 4),
        'Average 100% Coverage': round(df[df['Coverage'] == 1.0].shape[0] / df.shape[0], 4),
        'Average less than 5% Coverage': round(df[df['Coverage'] < 0.05].shape[0] / df.shape[0], 4),
        'Max Coverage': round(df['Coverage'].max(), 4),
        'Min Coverage': round(df['Coverage'].min(), 4),
    }
    
    summary_df = pd.DataFrame([stats])
    excel_path = os.path.join(output_folder, f'{rtos_name}_memory_and_coverage_analysis.xlsx')
    
    with pd.ExcelWriter(excel_path, engine='openpyxl') as writer:
        df.to_excel(writer, sheet_name='Detailed Memory Usage', index=False)
        summary_df.to_excel(writer, sheet_name='Summary Statistics', index=False)
    print(f'Memory analysis results saved to: {excel_path}')
    plot_memory(df, rtos_name, output_folder)
    plot_instructions(df, rtos_name, output_folder)
    plot_coverage(df, rtos_name, output_folder)
    return df

if __name__ == '__main__':
    root_folders = [
        '/home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/output',
        '/home/klee/klee_src/test-rtos/threadx-6.4.2/symbolic_execution/output',
        '/home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/output',
        '/home/klee/klee_src/test-rtos/tizenrt/symbolic_execution/output',
    ]
    rtos_names = [
        'FreeRTOS',
        'ThreadX',
        'RT-Thread',
        'TizenRT'
    ]
    output_folder = "/home/klee/klee_src/rtos-api-analysis/results/memory"
    
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)
    
    all_rtos_memory_data = []
    all_rtos_instructions_data = []
    
    for root_folder, rtos_name in zip(root_folders, rtos_names):
        df = analyze_memory_and_coverage(root_folder, output_folder, rtos_name)
        all_rtos_memory_data.append(df['Memory Usage (MB)'].values)
        all_rtos_instructions_data.append(df['Instructions'].values)
    
