import os
import re
import pandas as pd

from output_utils import dated_copy

def extract_vul_info(file_path, include_details=True):
    """
    Extract vulnerability information from the specified file.
    Recognizes all KLEE vulnerability strings (including MPU violation (T)/(F)).
    :param file_path: Path to the file to process.
    :param include_details: Whether to include file name and line number in the output.
    :return: List of extracted records.
    """
    # Define regex patterns
    pattern_with_details = re.compile(
        r"Found in .+?/test-info-output/(?P<syscall_name>.+?)/test_info\.txt:\s+"
        r"KLEE: Error: (?P<vul_type>.+?)on file (?P<file_name>.+?): line (?P<line_number>\d+)"
    )
    pattern_without_details = re.compile(
        r"Found in .+?/test-info-output/(?P<syscall_name>.+?)/test_info\.txt:\s+"
        r"KLEE: Error: (?P<vul_type>.+?)on file"
    )

    pattern = pattern_with_details if include_details else pattern_without_details
    results = []

    # Read the file and extract information
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
            matches = pattern.finditer(content)
            for match in matches:
                record = {
                    "System Call": match.group("syscall_name"),
                    "Vulnerability Type": match.group("vul_type").strip(),
                }
                if include_details:
                    record["File Name"] = match.group("file_name")
                    record["Line Number"] = match.group("line_number")
                results.append(record)
    except FileNotFoundError:
        print(f"Error: File '{file_path}' does not exist.")
        return []

    return results

def generate_tables(file_path):
    """
    Generate two tables: one with detailed info (file name, line number) and one without.
    :param file_path: Path to the file to process.
    """
    # Extract data for both cases
    data_with_details = extract_vul_info(file_path, include_details=True)
    data_without_details = extract_vul_info(file_path, include_details=False)

    _base = os.path.join(os.path.dirname(os.path.abspath(__file__)), "results")
    os.makedirs(_base, exist_ok=True)

    # Create DataFrames and save to Excel files
    if data_with_details:
        df_with_details = pd.DataFrame(data_with_details)
        output_with_details = os.path.join(_base, "vulnerability_report_with_details.xlsx")
        df_with_details.to_excel(output_with_details, index=False, engine='openpyxl')
        dated_copy(output_with_details)
        print(f"Table with file name and line numbers saved as '{output_with_details}'.")

    if data_without_details:
        df_without_details = pd.DataFrame(data_without_details)
        output_without_details = os.path.join(_base, "vulnerability_report_minimal.xlsx")
        df_without_details.to_excel(output_without_details, index=False, engine='openpyxl')
        dated_copy(output_without_details)
        print(f"Table with minimal details saved as '{output_without_details}'.")




# Specify the file path
file_path = "/home/klee/klee_test/rtos-api-analysis/info_freertos_10.6.0"  # Replace with your file path
generate_tables(file_path)