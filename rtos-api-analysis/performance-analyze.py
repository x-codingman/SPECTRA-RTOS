# This script is used to analyze the performance of the existing table
# and generate the performance report

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import os



def analyze_performance(result_folder, rtos_version, store_folder):
    #check result folder exists. If not, create it
    if not os.path.exists(result_folder):
        print(f'{result_folder} does not exist, please run the data-analyze-all.py first')
        return

    df = pd.read_excel(os.path.join(result_folder, f'{rtos_version}_runtime_info.xlsx'), engine='openpyxl')

    # Analyze the Elapsed time this table and give me the summary of the elapsed time
    # 1. Calculate the total elapsed time
    total_elapsed_time = df['Elapsed'].sum()
    # 2. Calculate the average elapsed time
    average_elapsed_time = df['Elapsed'].mean()
    # 3. Calculate the median elapsed time
    median_elapsed_time = df['Elapsed'].median()
    # 4. Calculate the standard deviation of the elapsed time
    std_elapsed_time = df['Elapsed'].std()
    # 5. Calculate the minimum elapsed time
    min_elapsed_time = df['Elapsed'].min()
    # 6. Calculate the maximum elapsed time
    max_elapsed_time = df['Elapsed'].max()
    # 7. Calculate the number of APIs
    num_completed_apis = df['Elapsed'].count()
    # 8. Calculate the number of unique APIs
    num_all_apis = df['System Call'].nunique()
    # 9. Calculate the number of APIs that have elapsed time greater than 3600 seconds
    num_apis_gt_3600 = df[df['Elapsed'] > 3600]['Elapsed'].count()
    # 10. Calculate the number of APIs that have elapsed time greater than 30 minutes
    num_apis_gt_30_minutes = df[df['Elapsed'] > 1800]['Elapsed'].count()

    # 10 Create the summary of the elaspsed time as a table
    summary_table = pd.DataFrame({
        'RTOS': [rtos_version],
        'Total(s)': [total_elapsed_time],
        'Mean(s)': [average_elapsed_time], 
        'Median(s)': [median_elapsed_time],
        'Standard Deviation(s)': [std_elapsed_time],
        'Minimum(s)': [min_elapsed_time],
        'Maximum(s)': [max_elapsed_time],
        'Completed API Count': [num_completed_apis],
        'All API Count': [num_all_apis],
        '> 1-Hour': [num_apis_gt_3600],
        '> 30-Minutes': [num_apis_gt_30_minutes]
    })
    # 11 Save the summary table to a excel file
    summary_table.to_excel(os.path.join(store_folder, f'{rtos_version}_elapsed_time_summary.xlsx'), index=False)

    # Analyze the Elapsed time this table and draw the Pareto Chart
    # 1. Calculate the total elapsed time for each API
    total_elapsed_time = df['Elapsed'].sum()
    # 2. Calculate the percentage of the elapsed time for each API
    df['Percentage'] = df['Elapsed'] / total_elapsed_time
    # 3. Sort the API by the elapsed time
    df = df.sort_values(by='Elapsed', ascending=False) 
    # 4. Draw the Pareto Chart
    plt.figure(figsize=(10, 6))
    # Use the indexs of System Calls since the "System Call" strings are too long
    if rtos_version == 'freertos-10.5.1':
        rtos_name = 'FreeRTOS'
    elif rtos_version == 'tizenrt':
        rtos_name = 'TizenRT'
    else:
        rtos_name = "Default"
    plt.bar(df.index, df['Percentage'])
    plt.title(f'Pareto Chart of Elapsed Time of {rtos_name} System Calls')
    plt.xlabel('System Call')
    plt.ylabel('Percentage')
    plt.savefig(os.path.join(store_folder, f'{rtos_version}_elapsed_time_pareto_chart.png'))

if __name__ == '__main__':
    # Read the existing table
    # Specify the result folder
    result_folder = '/home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/results'
    rtos_version = 'freertos-10.5.1'
    store_folder = '/home/klee/klee_src/rtos-api-analysis/results'
    analyze_performance(result_folder, rtos_version, store_folder)
    result_folder = '/home/klee/klee_src/test-rtos/tizenrt/symbolic_execution/results'
    rtos_version = 'tizenrt'
    analyze_performance(result_folder, rtos_version, store_folder)
    result_folder = '/home/klee/klee_src/test-rtos/threadx-5.3/symbolic_execution/results'
    rtos_version = 'threadx-5.3'
    analyze_performance(result_folder, rtos_version, store_folder)  
    
