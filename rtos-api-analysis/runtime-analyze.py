# This script is used to analyze the performance of the existing table
# and generate the performance report

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import os

from output_utils import dated_copy


def _load_runtime_table(result_folder, rtos_version):
    """Prefer walltime xlsx (StoppedByMaxTime column); else runtime_info.xlsx."""
    wall = os.path.join(result_folder, f'{rtos_version}_runtime_info_walltime.xlsx')
    base = os.path.join(result_folder, f'{rtos_version}_runtime_info.xlsx')
    if os.path.isfile(wall):
        return pd.read_excel(wall, engine='openpyxl'), 'walltime'
    if os.path.isfile(base):
        return pd.read_excel(base, engine='openpyxl'), 'runtime_info'
    return None, None


def _per_syscall_rows(df):
    """Exclude summary rows from data-analyze-all output."""
    return df[~df['System Call'].astype(str).isin(['Total Finished', 'Total', '总计'])].copy()


def analyze_performance(result_folder, rtos_version, store_folder):
    #check result folder exists. If not, create it
    if not os.path.exists(result_folder):
        print(f'{result_folder} does not exist, please run the data-analyze-all.py first')
        return

    df, src = _load_runtime_table(result_folder, rtos_version)
    if df is None:
        print(f'No runtime_info xlsx for {rtos_version} in {result_folder}')
        return

    syscalls = _per_syscall_rows(df)
    elapsed = pd.to_numeric(syscalls['Elapsed'], errors='coerce')
    valid = elapsed.notna()

    # Analyze Elapsed (numeric rows only; excludes NA / failed runs)
    total_elapsed_time = elapsed[valid].sum()
    average_elapsed_time = elapsed[valid].mean()
    median_elapsed_time = elapsed[valid].median()
    median_elapsed_minutes = median_elapsed_time / 60.0 if pd.notna(median_elapsed_time) else np.nan
    std_elapsed_time = elapsed[valid].std()
    min_elapsed_time = elapsed[valid].min()
    max_elapsed_time = elapsed[valid].max()
    num_completed_apis = int(valid.sum())
    num_all_apis = len(syscalls)
    num_apis_gt_3600 = int((elapsed[valid] > 3600).sum())
    num_apis_gt_30_minutes = int((elapsed[valid] > 1800).sum())

    # StoppedByMaxTime: from messages.txt (HaltTimer), column added by data-analyze-all.py
    n_max_yes = n_max_no = n_max_unk = None
    has_max_col = 'StoppedByMaxTime' in syscalls.columns
    if has_max_col:
        col = syscalls['StoppedByMaxTime'].astype(str)
        n_max_yes = int((col == 'yes').sum())
        n_max_no = int((col == 'no').sum())
        n_max_unk = int((col == 'unknown').sum())

    # 10 Create the summary of the elaspsed time as a table
    summary_table = pd.DataFrame({
        'RTOS': [rtos_version],
        'SourceTable': [src or ''],
        'Total(s)': [total_elapsed_time],
        'Mean(s)': [average_elapsed_time],
        'Median(s)': [median_elapsed_time],
        'Median(min)': [median_elapsed_minutes],
        'Standard Deviation(s)': [std_elapsed_time],
        'Minimum(s)': [min_elapsed_time],
        'Maximum(s)': [max_elapsed_time],
        'Completed API Count': [num_completed_apis],
        'All API Count': [num_all_apis],
        '> 1-Hour': [num_apis_gt_3600],
        '> 30-Minutes': [num_apis_gt_30_minutes],
        'StoppedByMaxTime_yes': [n_max_yes],
        'StoppedByMaxTime_no': [n_max_no],
        'StoppedByMaxTime_unknown': [n_max_unk],
    })
    # 11 Save the summary table to a excel file
    _sum_path = os.path.join(store_folder, f'{rtos_version}_elapsed_time_summary.xlsx')
    summary_table.to_excel(_sum_path, index=False)
    dated_copy(_sum_path)
    print(f'{rtos_version} elapsed time summary table is saved to {_sum_path}')
    if has_max_col:
        print(f'  StoppedByMaxTime: yes={n_max_yes}, no={n_max_no}, unknown={n_max_unk}')
    # Analyze the Elapsed time this table and draw the Pareto Chart
    pareto_df = syscalls.loc[valid].copy()
    pareto_df['Elapsed'] = elapsed[valid]
    if total_elapsed_time:
        pareto_df['Percentage'] = pareto_df['Elapsed'] / total_elapsed_time
    else:
        pareto_df['Percentage'] = 0.0
    pareto_df = pareto_df.sort_values(by='Elapsed', ascending=False)
    plt.figure(figsize=(10, 6))
    if rtos_version == 'freertos-10.5.1':
        rtos_name = 'FreeRTOS'
    elif rtos_version == 'tizenrt':
        rtos_name = 'TizenRT'
    elif rtos_version == 'threadx-6.4.2':
        rtos_name = 'ThreadX'
    elif rtos_version == 'rt-thread':
        rtos_name = 'RT-Thread'
    else:
        rtos_name = "Default"
    plt.bar(pareto_df.index, pareto_df['Percentage'])
    plt.title(f'Pareto Chart of Elapsed Time of {rtos_name} System Calls')
    plt.xlabel('System Call')
    plt.ylabel('Percentage')
    _par_path = os.path.join(store_folder, f'{rtos_version}_elapsed_time_pareto_chart.png')
    plt.savefig(_par_path)
    dated_copy(_par_path)

if __name__ == '__main__':
    # Read the existing table
    # Specify the result folder
    result_folder = '/home/klee/klee_src/rtos-api-analysis/results'
    rtos_version = 'freertos-10.5.1'
    store_folder = '/home/klee/klee_src/rtos-api-analysis/results/runtime'
    if not os.path.exists(store_folder):
        os.makedirs(store_folder)
    analyze_performance(result_folder, rtos_version, store_folder)
    rtos_version = 'tizenrt'
    analyze_performance(result_folder, rtos_version, store_folder)
    rtos_version = 'threadx-6.4.2'
    analyze_performance(result_folder, rtos_version, store_folder)
    rtos_version = 'rt-thread'
    analyze_performance(result_folder, rtos_version, store_folder)  
    
