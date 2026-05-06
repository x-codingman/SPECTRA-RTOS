"""
Extract per-harness timings from ``output/<harness>/info`` under a symbolic run directory.
Writes ``results/<label>-symbolic-execution-run-time-evaluation.xlsx``.
"""
import os
from pathlib import Path

import pandas as pd

from output_utils import dated_copy


def time_transform(time_str):
    hours, minutes, seconds = [int(i) for i in time_str.split(":")]
    return hours * 3600 + minutes * 60 + seconds


def extract_info(directory):
    df = pd.DataFrame(columns=['System Call', 'Elapsed', 'Explored Paths', 'Avg. Constructs Per Query',
                               'Total Queries', 'Valid Queries', 'Invalid Queries', 'Query Cex',
                               'Total Instructions', 'Completed Paths', 'Partially Completed Paths',
                               'Generated Tests'])

    for folder in os.listdir(directory):
        folder_path = os.path.join(directory, folder)
        if os.path.isdir(folder_path):
            info_file = os.path.join(folder_path, "info")
            if os.path.isfile(info_file):
                with open(info_file, 'r', encoding='utf-8', errors='replace') as file:
                    content = file.read()
                    try:
                        elapsed = content.split('Elapsed: ')[1].split('\n')[0]
                        explored_paths = content.split('explored paths = ')[1].split('\n')[0]
                        total_instructions = content.split('total instructions = ')[1].split('\n')[0]
                        completed_paths = content.split('completed paths = ')[1].split('\n')[0]
                        partially_completed_paths = content.split('partially completed paths = ')[1].split('\n')[0]
                        generated_tests = content.split('generated tests = ')[1].split('\n')[0]

                        df = df.append({'System Call': folder, 'Elapsed': time_transform(elapsed),
                                        'Explored Paths': explored_paths, 'Total Instructions': total_instructions,
                                        'Completed Paths': completed_paths,
                                        'Partially Completed Paths': partially_completed_paths,
                                        'Generated Tests': generated_tests}, ignore_index=True)
                    except IndexError:
                        df = df.append({'System Call': folder, 'Elapsed': 'NA', 'Explored Paths': 'NA',
                                        'Completed Paths': 'NA', 'Partially Completed Paths': 'NA',
                                        'Generated Tests': 'NA'}, ignore_index=True)
    return df


if __name__ == '__main__':
    repo = Path(__file__).resolve().parent.parent
    test_rtos = 'FreeRTOS-Kernel-10.6.0'
    directory_path = repo / test_rtos / 'symbolic_execution' / 'output'
    dataframe = extract_info(str(directory_path))
    print(dataframe)

    script_dir = Path(__file__).resolve().parent
    _results = script_dir / 'results'
    _results.mkdir(parents=True, exist_ok=True)
    _out = _results / f'{test_rtos}-symbolic-execution-run-time-evaluation.xlsx'
    dataframe.to_excel(str(_out), index=False)
    dated_copy(str(_out))
