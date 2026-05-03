import os
import re
import sys
import pandas as pd
import sqlite3

from output_utils import dated_copy

# Omitted from merged vulnerability_summary / rtos_totals (e.g. legacy reports on disk).
RTOS_EXCLUDED_FROM_VULNERABILITY_SUMMARY = frozenset({'freertos-10.6.0'})

# KLEE strings classified as "my" types in My Vulnerability Types (keep in sync with filters).
MY_VULNERABILITY_TYPES_DIRECT = (
    "Information leak vulnerability (V0)",
    "Uninitialized pointer dereference(read) vulnerability",
    "Arbitrary memory write vulnerability (V0)",
    "Limited memory write vulnerability (V2)",
    "Potential Function pointer dereference vulnerability"
)

MY_VULNERABILITY_TYPES_GUARDED = frozenset({
    "Information leak vulnerability (V1)",
    "Arbitrary memory write vulnerability (V1)",
    "Arbitrary memory write vulnerability (V5)",
    "Limited memory write vulnerability (V3)",
})

MY_VULNERABILITY_TYPES_ALL = frozenset(MY_VULNERABILITY_TYPES_DIRECT) | MY_VULNERABILITY_TYPES_GUARDED

# Traceable metric-to-type mapping (single source of truth for RTOS metrics).
DIRECT_METRIC_TYPE_MAP = {
    'FunctionPointerDeref': ('Potential Function pointer dereference vulnerability',),
    'InformationLeak_V0': ('Information leak vulnerability (V0)',),
    'MemoryWrite_Arbitrary': ('Arbitrary memory write vulnerability (V0)',),
    'MemoryWrite_Limited_V2': ('Limited memory write vulnerability (V2)',),
    'UninitializedPointerDeref': ('Uninitialized pointer dereference(read) vulnerability',),
}

GUARDED_METRIC_TYPE_MAP = {
    'FunctionPointerDeref': tuple(),  # kept for symmetry (expect 0)
    'InformationLeak_V1': ('Information leak vulnerability (V1)',),
    'MemoryWrite_Arbitrary': (
        'Arbitrary memory write vulnerability (V1)',
        'Arbitrary memory write vulnerability (V5)',
    ),
    'MemoryWrite_Limited_V3': ('Limited memory write vulnerability (V3)',),
    'UninitializedPointerDeref': tuple(),  # excluded from guarded mapping
}

# Per-RTOS summary table in vulnerability_summary.xlsx (≤31 chars for Excel sheet title).
# Columns are suitable for publication; see build_rtos_vulnerability_metrics_table docstring.
VULN_METRICS_SHEET_NAME = "RTOS_Vulnerability_Metrics"
# Long form: "Merged My Vulnerability Types V2" (Excel limits sheet titles to 31 characters).
MERGED_MY_VUL_TYPES_V2_SHEET = "Merged My Vulnerability Ty V2"


def _finding_matches_any_type(vulnerability_type_cell, type_iterable):
    """Substring match so optional KLEE suffixes after the type string still match."""
    s = str(vulnerability_type_cell)
    return any(t in s for t in type_iterable)


def _memory_write_class_from_vul_string(vul_type):
    """
    W-I vs W-II from concatenated KLEE type cell (per syscall row).
    Direct-only policy:
    - I  := Arbitrary memory write vulnerability (V0)
    - II := Limited memory write vulnerability (V2)
    If both appear, return ``I, II``.
    """
    s = str(vul_type)
    has_i = any(
        m in s
        for m in (
            'Arbitrary memory write vulnerability (V0)',
        )
    )
    has_ii = any(
        m in s
        for m in (
            'Limited memory write vulnerability (V2)',
        )
    )
    if has_i and has_ii:
        return 'I, II'
    if has_i:
        return 'I'
    if has_ii:
        return 'II'
    return 'X'


def _memory_write_summary_total_string(mw_series):
    """Human-readable totals for My Vulnerability Types ``Memory Write`` column."""
    mw = mw_series.astype(str).str.strip()
    only_i = int((mw == 'I').sum())
    only_ii = int((mw == 'II').sum())
    both = int((mw == 'I, II').sum())
    neither = int((mw == 'X').sum())
    return f'I_only:{only_i} II_only:{only_ii} I+II:{both} X:{neither}'


def collect_vulnerabilities_list(root_folder, rtos_project_name):
    """
    Walk test-info-output once; parse KLEE Error lines.
    rtos_project_name: e.g. freertos-10.5.1 (must match merge keys in all_rtos_map).
    """
    vulnerabilities = []
    test_info_folder = os.path.join(root_folder, 'test-info-output')
    symbolic_root = os.path.abspath(root_folder)

    if not os.path.isdir(test_info_folder):
        return vulnerabilities

    for dirpath, dirnames, filenames in os.walk(test_info_folder):
        if 'test_info.txt' in filenames:
            test_info_txt_path = os.path.join(dirpath, 'test_info.txt')
            harness_name = os.path.basename(dirpath)
            try:
                with open(test_info_txt_path, 'r', encoding='utf-8') as file:
                    for line in file:
                        if "KLEE: Error:" in line:
                            match = re.search(r'KLEE: Error: (.*?)on file (.*?): line (\d+)', line)
                            target_name = os.path.basename(dirpath)
                            parts = target_name.split('_')
                            if len(parts) >= 3 and root_folder == "/home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/":
                                target_name = parts[2]
                            if match:
                                vulnerabilities.append({
                                    'Harness': harness_name,
                                    'TestInfoPath': test_info_txt_path,
                                    'File': match.group(2),
                                    'Function': target_name,
                                    'Vulnerability Type': match.group(1),
                                    'Line Number': match.group(3),
                                    'RTOS': rtos_project_name,
                                    'RTOS_Project': rtos_project_name,
                                    'SymbolicRoot': symbolic_root,
                                })
                            else:
                                vulnerabilities.append({
                                    'Harness': harness_name,
                                    'TestInfoPath': test_info_txt_path,
                                    'File': '',
                                    'Function': target_name,
                                    'Vulnerability Type': line.strip(),
                                    'Line Number': 'N/A',
                                    'RTOS': rtos_project_name,
                                    'RTOS_Project': rtos_project_name,
                                    'SymbolicRoot': symbolic_root,
                                })
            except Exception as e:
                print(f'Error reading {test_info_txt_path}: {e}')
    return vulnerabilities


def build_vulnerability_frames(vulnerabilities):
    """
    Build the same DataFrames as vulnerability_analysis from a list of vul dicts
    (single or multiple RTOS). Aggregation key is (RTOS_Project, Function).
    Returns: df, vul_funcs_df, filtered_df, without_semantic_vul_df, verification_df
    """
    if vulnerabilities:
        df = pd.DataFrame(vulnerabilities)
    else:
        df = pd.DataFrame(columns=[
            'Harness', 'TestInfoPath', 'File', 'Function', 'Vulnerability Type',
            'Line Number', 'RTOS', 'RTOS_Project', 'SymbolicRoot'])

    vul_funcs = {}
    for vul in vulnerabilities:
        func = vul['Function']
        rproj = vul.get('RTOS_Project', 'unknown')
        key = (rproj, func)
        if key not in vul_funcs:
            vul_funcs[key] = {
                'RTOS_Project': rproj,
                'Harness': {vul['Harness']},
                'File': {vul['File']} if vul.get('File') else set(),
                'Function': func,
                'Vulnerability Type': {vul['Vulnerability Type']},
                'Line Number': [vul['Line Number']],
                'Number of Vulnerabilities': 1,
            }
        else:
            vul_funcs[key]['Harness'].add(vul['Harness'])
            if vul.get('File'):
                vul_funcs[key]['File'].add(vul['File'])
            vul_funcs[key]['Vulnerability Type'].add(vul['Vulnerability Type'])
            vul_funcs[key]['Line Number'].append(vul['Line Number'])
            vul_funcs[key]['Number of Vulnerabilities'] += 1

    if vul_funcs:
        vul_funcs_df = pd.DataFrame(vul_funcs.values())
        vul_funcs_df['Harness'] = vul_funcs_df['Harness'].apply(
            lambda x: '\n'.join(sorted(str(i) for i in x)))
        vul_funcs_df['File'] = vul_funcs_df['File'].apply(
            lambda x: '\n'.join(sorted(str(i) for i in x)))
        vul_funcs_df['Vulnerability Type'] = vul_funcs_df['Vulnerability Type'].apply(
            lambda x: '\n'.join(str(i) for i in x))
        vul_funcs_df['Line Number'] = vul_funcs_df['Line Number'].apply(
            lambda x: '\n'.join(str(i) for i in x))
    else:
        print("No vulnerabilities found")
        vul_funcs_df = pd.DataFrame(columns=[
            'RTOS_Project', 'Harness', 'File', 'Function', 'Vulnerability Type',
            'Line Number', 'Number of Vulnerabilities'])

    my_vul_types_all = sorted(MY_VULNERABILITY_TYPES_ALL, key=len, reverse=True)
    pattern = '|'.join(map(re.escape, my_vul_types_all))
    filtered_df = vul_funcs_df[vul_funcs_df['Vulnerability Type'].str.contains(pattern, regex=True, na=False)].copy()
    merge_keys = ['RTOS_Project', 'Function'] if 'RTOS_Project' in filtered_df.columns else ['Function']
    filtered_df = filtered_df.drop_duplicates(subset=merge_keys)

    filtered_df['DoS'] = "✔"
    filtered_df['FP'] = filtered_df['Vulnerability Type'].apply(
        lambda x: '✔' if 'Potential Function pointer dereference vulnerability' in x else 'X'
    )
    filtered_df['Memory Read'] = filtered_df['Vulnerability Type'].apply(
        lambda x: '✔' if (
            'Information leak vulnerability (V0)' in x
            or 'Information leak vulnerability (V1)' in x
        ) else 'X'
    )

    filtered_df['Memory Write'] = filtered_df['Vulnerability Type'].apply(
        _memory_write_class_from_vul_string
    )
    filtered_df['MPU (T)'] = filtered_df['Vulnerability Type'].apply(
        lambda x: '✔' if 'MPU violation (T)' in x else 'X'
    )
    filtered_df['MPU (F)'] = filtered_df['Vulnerability Type'].apply(
        lambda x: '✔' if 'MPU violation (F)' in x else 'X'
    )

    for vul_type in my_vul_types_all:
        mask = df['Vulnerability Type'].apply(
            lambda v, vt=vul_type: _finding_matches_any_type(v, (vt,))
        )
        if 'RTOS_Project' in df.columns:
            location_count = (
                df[mask].groupby(['RTOS_Project', 'Function'])['Line Number']
                .nunique().reset_index()
                .rename(columns={'Line Number': f'Num of {vul_type} Locations'}))
            filtered_df = filtered_df.merge(
                location_count, on=['RTOS_Project', 'Function'], how='left')
        else:
            location_count = (
                df[mask].groupby('Function')['Line Number']
                .nunique().reset_index()
                .rename(columns={'Line Number': f'Num of {vul_type} Locations'}))
            filtered_df = filtered_df.merge(location_count, on='Function', how='left')
        filtered_df[f'Num of {vul_type} Locations'] = filtered_df[f'Num of {vul_type} Locations'].fillna(0).astype(int)

    summary_row = {
        'RTOS_Project': '',
        'Function': '总计',
        'Harness': '',
        'Vulnerability Type': '',
        'Line Number': '',
        'Number of Vulnerabilities': '',
        'File': '',
        'DoS': filtered_df['DoS'].value_counts().get('✔', 0),
        'FP': filtered_df['FP'].value_counts().get('✔', 0),
        'Memory Read': filtered_df['Memory Read'].value_counts().get('✔', 0),
        'Memory Write': _memory_write_summary_total_string(filtered_df['Memory Write']),
        'MPU (T)': filtered_df['MPU (T)'].value_counts().get('✔', 0),
        'MPU (F)': filtered_df['MPU (F)'].value_counts().get('✔', 0),
    }
    for vul_type in my_vul_types_all:
        col_name = f'Num of {vul_type} Locations'
        if col_name in filtered_df.columns:
            summary_row[col_name] = filtered_df[col_name].sum()

    filtered_df = pd.concat([filtered_df, pd.DataFrame([summary_row])], ignore_index=True)

    without_semantic_vul_types = [
        "Information leak vulnerability (V0)",
        "Information leak vulnerability (V1)",
        "Limited memory write vulnerability (V1)",
        "Uninitialized pointer dereference(read) vulnerability",
        "Arbitrary memory write vulnerability (V0)",
        "Limited memory write vulnerability (V2)"
    ]
    pattern2 = '|'.join(map(re.escape, without_semantic_vul_types))
    without_semantic_vul_df = vul_funcs_df[
        vul_funcs_df['Vulnerability Type'].str.contains(pattern2, regex=True, na=False)].copy()
    without_semantic_vul_df['DoS'] = "✔"
    without_semantic_vul_df['FP'] = without_semantic_vul_df['Vulnerability Type'].apply(
        lambda x: '✔' if 'Potential Function pointer dereference vulnerability' in x else 'X'
    )
    without_semantic_vul_df['Memory Read'] = without_semantic_vul_df['Vulnerability Type'].apply(
        lambda x: '✔' if 'Information leak vulnerability (V0)' in x
        or 'Information leak vulnerability (V1)' in x
        else 'X'
    )
    without_semantic_vul_df['Memory Write'] = without_semantic_vul_df['Vulnerability Type'].apply(
        _memory_write_class_from_vul_string
    )

    summary_row2 = {
        'RTOS_Project': '',
        'Function': '总计',
        'Harness': '',
        'Vulnerability Type': '',
        'Line Number': '',
        'Number of Vulnerabilities': '',
        'File': '',
        'DoS': without_semantic_vul_df['DoS'].value_counts().get('✔', 0),
        'FP': without_semantic_vul_df['FP'].value_counts().get('✔', 0),
        'Memory Read': without_semantic_vul_df['Memory Read'].value_counts().get('✔', 0),
        'Memory Write': _memory_write_summary_total_string(without_semantic_vul_df['Memory Write']),
    }
    without_semantic_vul_df = pd.concat(
        [without_semantic_vul_df, pd.DataFrame([summary_row2])], ignore_index=True)

    rtos_tag = vulnerabilities[0]['RTOS'] if vulnerabilities else ''
    symbolic_root = vulnerabilities[0]['SymbolicRoot'] if vulnerabilities else ''
    verification_df = _build_verification_details(
        df, my_vul_types_all, rtos_tag, symbolic_root)

    return df, vul_funcs_df, filtered_df, without_semantic_vul_df, verification_df


def _build_verification_details(df, my_vul_types, rtos_tag, symbolic_root):
    """
    One row per KLEE-reported finding (filtered to my_vul_types) for manual FP review.
    """
    if df is None or df.empty:
        return pd.DataFrame()
    pattern = '|'.join(map(re.escape, my_vul_types))
    sub = df[df['Vulnerability Type'].str.contains(pattern, regex=True, na=False)].copy()
    if sub.empty:
        return pd.DataFrame(columns=[
            'Verification_ID', 'RTOS', 'SymbolicRoot', 'Harness', 'Function',
            'Vulnerability Type', 'File', 'Line Number', 'TestInfoPath',
            'Manual_FP_review', 'FP_verdict', 'Notes'])
    sub.insert(0, 'Verification_ID', range(1, len(sub) + 1))
    sub['Manual_FP_review'] = ''
    sub['FP_verdict'] = ''  # pending | TP | FP | unclear
    sub['Notes'] = ''
    if 'RTOS' not in sub.columns:
        sub.insert(1, 'RTOS', rtos_tag)
    if 'SymbolicRoot' not in sub.columns:
        sub['SymbolicRoot'] = symbolic_root
    # Readable column order (keep any extra columns after these)
    preferred = [
        'Verification_ID', 'RTOS', 'SymbolicRoot', 'Harness', 'Function',
        'Vulnerability Type', 'File', 'Line Number', 'TestInfoPath',
        'Manual_FP_review', 'FP_verdict', 'Notes',
    ]
    cols = [c for c in preferred if c in sub.columns]
    rest = [c for c in sub.columns if c not in cols]
    return sub[cols + rest]


def build_merged_my_vulnerability_types_from_detailed(merged_detailed):
    """
    Build merged "My Vulnerability Types" at syscall granularity.

    One row per (RTOS_Project, _syscall_key) over DIRECT taxonomy only, so
    Memory Write can reflect that a single syscall has both W-I and W-II
    (shown as "I, II").
    """
    df = _prepare_merged_detailed_for_my_types(merged_detailed)
    if df.empty or 'Vulnerability Type' not in df.columns:
        return pd.DataFrame()

    df = df[df['Vulnerability Type'].apply(
        lambda v: _finding_matches_any_type(v, MY_VULNERABILITY_TYPES_DIRECT)
    )].copy()
    if df.empty:
        return pd.DataFrame()

    group_keys = ['RTOS_Project', '_syscall_key']

    rows = []
    # Keep old-style ordering semantics: first appearance order in merged data.
    key_rows = df[group_keys].drop_duplicates(keep='first')
    for _, krow in key_rows.iterrows():
        rtos = krow['RTOS_Project']
        skey = krow['_syscall_key']
        g = df[(df['RTOS_Project'] == rtos) & (df['_syscall_key'] == skey)]
        vul_types = sorted(set(str(x) for x in g['Vulnerability Type'].dropna()))
        vul_join = '\n'.join(vul_types)
        func_display = ''
        if 'Function' in g.columns:
            funcs = [str(x).strip() for x in g['Function'].dropna() if str(x).strip()]
            if funcs:
                func_display = funcs[0]

        row = {
            'RTOS': rtos,
            'Function': func_display if func_display else (skey if pd.notna(skey) else ''),
            'Number of vulnerability alerts': int(len(g)),
            'DoS': '✔',
            'FP': '✔' if 'Potential Function pointer dereference vulnerability' in vul_join else 'X',
            'Memory Read': '✔' if (
                'Information leak vulnerability (V0)' in vul_join
                or 'Information leak vulnerability (V1)' in vul_join
            ) else 'X',
            'Memory Write': _memory_write_class_from_vul_string(vul_join),
            'Num of Information leak vulnerability (V0) Locations': int(
                g.loc[g['Vulnerability Type'].apply(
                    lambda v: _finding_matches_any_type(v, ('Information leak vulnerability (V0)',))
                ), 'Line Number'].astype(str).nunique()
            ),
            'Num of Uninitialized pointer dereference(read) vulnerability Locations': int(
                g.loc[g['Vulnerability Type'].apply(
                    lambda v: _finding_matches_any_type(v, ('Uninitialized pointer dereference(read) vulnerability',))
                ), 'Line Number'].astype(str).nunique()
            ),
            'Num of Arbitrary memory write vulnerability (V0) Locations': int(
                g.loc[g['Vulnerability Type'].apply(
                    lambda v: _finding_matches_any_type(v, ('Arbitrary memory write vulnerability (V0)',))
                ), 'Line Number'].astype(str).nunique()
            ),
            'Num of Limited memory write vulnerability (V2) Locations': int(
                g.loc[g['Vulnerability Type'].apply(
                    lambda v: _finding_matches_any_type(v, ('Limited memory write vulnerability (V2)',))
                ), 'Line Number'].astype(str).nunique()
            ),
        }
        rows.append(row)

    out = pd.DataFrame(rows)
    if out.empty:
        return out
    return out.reset_index(drop=True)


def vulnerability_analysis(root_folder, output_folder, rtos_project_name=None):
    """
    Per-RTOS report. Pass rtos_project_name (e.g. freertos-10.5.1) so the output
    filename matches generate_summary_excel keys; if None, inferred from path.
    """
    if rtos_project_name is None:
        rtos_project_name = os.path.basename(os.path.dirname(root_folder.rstrip(os.sep)))

    vulnerabilities = collect_vulnerabilities_list(root_folder, rtos_project_name)
    df, vul_funcs_df, filtered_df, without_semantic_vul_df, verification_df = (
        build_vulnerability_frames(vulnerabilities))

    excel_path = os.path.join(output_folder, f'{rtos_project_name}_vulnerability_report.xlsx')

    with pd.ExcelWriter(excel_path, engine='openpyxl') as writer:
        verification_df.to_excel(writer, sheet_name='Verification Details', index=False)
        df.to_excel(writer, sheet_name='Detailed Report', index=False)
        vul_funcs_df.to_excel(writer, sheet_name='Vulnerability Functions Report', index=False)
        filtered_df.to_excel(writer, sheet_name='My Vulnerability Types', index=False)
        without_semantic_vul_df.to_excel(writer, sheet_name='Without Semantic Check', index=False)
    print(f'Vulnerability Report (incl. Verification Details) saved to: {excel_path}')
    dated_copy(excel_path)


def get_rtos_folder():
    print("Please select the RTOS folder:")
    print("0. All RTOS")
    print("1. FreeRTOS-10.5.1")
    print("2. TizenRT")
    print("3. RT-Thread")
    print("4. ThreadX")
    # show the default path
    print("Default path: /home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/")
    choice = input("Enter the number of the RTOS folder: ")
    # give a default path
    default_path = "/home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/"
    if choice == "0":
        return {
            "freertos-10.5.1": "/home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/",
            "tizenrt": "/home/klee/klee_src/test-rtos/tizenrt/symbolic_execution/",
            "rt-thread": "/home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/",
            "threadx-6.4.2": "/home/klee/klee_src/test-rtos/threadx-6.4.2/symbolic_execution/"
        }
    if choice == "1":
        return "/home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/"
    elif choice == "2":
        return "/home/klee/klee_src/test-rtos/tizenrt/symbolic_execution/"
    elif choice == "3":
        return "/home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/"
    elif choice == "4":
        return "/home/klee/klee_src/test-rtos/threadx-6.4.2/symbolic_execution/"
    else:
        return default_path
        

def time_tranform(time_str):

    # Split the time string into its components
    hours, minutes, seconds = [int(i) for i in time_str.split(":")]

    # Calculate total seconds
    total_seconds = hours * 3600 + minutes * 60 + seconds
    return total_seconds


def get_walltime_seconds(stats_path):
    """
    Get total elapsed wall time from run.stats (KLEE SQLite).
    WallTime is stored in microseconds; returns seconds (float).
    Returns None if run.stats not found or error.
    """
    if not os.path.isfile(stats_path):
        return None
    try:
        conn = sqlite3.connect(stats_path)
        cursor = conn.cursor()
        cursor.execute("SELECT MAX(WallTime) FROM stats;")
        result = cursor.fetchone()
        conn.close()
        if result and result[0] is not None:
            return float(result[0]) / 1e6  # microseconds -> seconds
    except Exception as e:
        print(f"Error reading {stats_path}: {e}")
    return None


def get_instruction_coverage(stats_path):
    """
    Get instruction coverage from run.stats: CoveredInstructions / (Covered + Uncovered).
    Returns None if run.stats not found or error.
    """
    if not os.path.isfile(stats_path):
        return None
    try:
        conn = sqlite3.connect(stats_path)
        cursor = conn.cursor()
        cursor.execute("""
            SELECT CoveredInstructions, UncoveredInstructions FROM stats
            ORDER BY Instructions DESC LIMIT 1;
        """)
        result = cursor.fetchone()
        conn.close()
        if result and (result[0] + result[1]) > 0:
            return round(float(result[0]) / (result[0] + result[1]), 4)
    except Exception as e:
        print(f"Error reading instruction coverage from {stats_path}: {e}")
    return None


# KLEE logs this when --max-time fires (see Executor.cpp Timer callback).
_HALT_TIMER_MARKER = "HaltTimer invoked"


def halted_by_max_time_label(folder_path):
    """
    Detect whether this harness run stopped due to --max-time.
    Reads messages.txt under folder_path. Returns 'yes', 'no', or 'unknown'.
    """
    msg_path = os.path.join(folder_path, "messages.txt")
    if not os.path.isfile(msg_path):
        return "unknown"
    try:
        with open(msg_path, "r", encoding="utf-8", errors="ignore") as f:
            text = f.read()
        return "yes" if _HALT_TIMER_MARKER in text else "no"
    except Exception as e:
        print(f"Warning: could not read {msg_path}: {e}")
        return "unknown"


def _read_text_utf8(path):
    """Read text with UTF-8; replace undecodable bytes (avoids locale/ascii issues on Py3.6)."""
    with open(path, 'r', encoding='utf-8', errors='replace') as f:
        return f.read()


def extract_info(directory, output_folder):
    # 创建一个空的DataFrame来存储结果
    df = pd.DataFrame(columns=['System Call', 'Elapsed', 'Explored Paths',
                               'Total Instructions', 'Completed Paths', 'Partially Completed Paths',
                               'Generated Tests', 'StoppedByMaxTime', 'Last Instruction'])

    # 遍历目录下的每个子文件夹
    directory = os.path.join(directory, 'output')
    if not os.path.isdir(directory):
        print(f"Warning: extract_info: no directory {directory}, skipping runtime info.")
        rtos_name = os.path.abspath(directory).rstrip('/').split(os.sep)[-3]
        ri_path = os.path.join(output_folder, f'{rtos_name}_runtime_info.xlsx')
        df.to_excel(ri_path, index=False)
        dated_copy(ri_path)
        return

    for folder in os.listdir(directory):
        folder_path = os.path.join(directory, folder)
        if os.path.isdir(folder_path):
            info_file = os.path.join(folder_path, "info")

            # 检查info文件是否存在
            if os.path.isfile(info_file):
                try:
                    content = _read_text_utf8(info_file)
                except OSError as e:
                    print(f"Warning: could not read {info_file}: {e}")
                    continue

                # 提取信息（格式不完整或字段缺失时走 messages.txt 回退）
                try:
                    if 'Elapsed: ' not in content:
                        raise IndexError
                    elapsed = content.split('Elapsed: ')[1].split('\n')[0]
                    explored_paths = content.split('explored paths = ')[1].split('\n')[0]
                    total_instructions = content.split('total instructions = ')[1].split('\n')[0]
                    completed_paths = content.split('completed paths = ')[1].split('\n')[0]
                    partially_completed_paths = content.split('partially completed paths = ')[1].split('\n')[0]
                    generated_tests = content.split('generated tests = ')[1].split('\n')[0]
                    df = df.append({'System Call': folder, 'Elapsed': time_tranform(elapsed), 'Explored Paths': explored_paths,'Total Instructions': total_instructions,
                                    'Completed Paths': completed_paths, 'Partially Completed Paths': partially_completed_paths,
                                    'Generated Tests': generated_tests,
                                    'StoppedByMaxTime': halted_by_max_time_label(folder_path),
                                    'Last Instruction': 'NA'}, ignore_index=True)
                except (IndexError, ValueError, TypeError):
                    # info 不完整或 Elapsed 无法解析：从 messages.txt 取最后一行 KLEE: Execute:
                    message_file = os.path.join(folder_path, "messages.txt")
                    klee_execute_line = None
                    if os.path.isfile(message_file):
                        try:
                            text = _read_text_utf8(message_file)
                            lines = text.splitlines()
                            for line in reversed(lines):
                                if line.startswith("KLEE: Execute:"):
                                    klee_execute_line = line
                                    break
                        except OSError as e:
                            print(f"Warning: could not read {message_file}: {e}")
                    df = df.append({'System Call': folder, 'Elapsed': 'NA', 'Explored Paths': 'NA',
                                    'Completed Paths': 'NA', 'Partially Completed Paths': 'NA',
                                    'Generated Tests': 'NA',
                                    'StoppedByMaxTime': halted_by_max_time_label(folder_path),
                                    'Last Instruction': klee_execute_line if klee_execute_line else 'NA'}, ignore_index=True)
    # Satatistic the API finished and not finished
    # For each row, check the 'Elapsed' column
    # If the 'Elapsed' is not 'NA', then the API is finished normally
    # If the 'Elapsed' is 'NA', then the API is not finished normally
    # Count the number of API finished and not finished
    finished_count = df[df['Elapsed'] != 'NA'].shape[0]
    all_count = df.shape[0]
    # Add a new row to the DataFrame
    df = df.append({'System Call': 'Total Finished', 'Elapsed': finished_count/all_count, 'Explored Paths': 'NA',
                    'Completed Paths': 'NA', 'Partially Completed Paths': 'NA',
                    'Generated Tests': 'NA',
                    'StoppedByMaxTime': 'NA',
                    'Last Instruction': 'NA'}, ignore_index=True)

    # generate a excel file
    rtos_name = directory.split('/')[-3]  # Get the actual RTOS name from the path
    ri_path = os.path.join(output_folder, f'{rtos_name}_runtime_info.xlsx')
    df.to_excel(ri_path, index=False)
    _regular = df[df['System Call'] != 'Total Finished']
    _n_max = (_regular['StoppedByMaxTime'] == 'yes').sum()
    print(f'RTOS runtime info saved to: {rtos_name}_runtime_info.xlsx (StoppedByMaxTime=yes: {_n_max})')
    dated_copy(ri_path)


def extract_info_from_run_stats(directory, output_folder):
    """
    Extract Elapsed from run.stats (WallTime, microsecond precision) when available,
    else fall back to info (second precision). Saves to *_runtime_info_walltime.xlsx.
    """
    directory = os.path.join(directory, 'output')
    df = pd.DataFrame(columns=['System Call', 'Elapsed', 'Source', 'InstructionCoverage',
                               'Explored Paths', 'Total Instructions', 'Completed Paths',
                               'Partially Completed Paths', 'Generated Tests', 'StoppedByMaxTime'])

    for folder in os.listdir(directory):
        folder_path = os.path.join(directory, folder)
        if not os.path.isdir(folder_path):
            continue

        elapsed = None
        source = 'info'
        instruction_coverage = None

        stats_path = os.path.join(folder_path, 'run.stats')
        walltime_sec = get_walltime_seconds(stats_path)
        if walltime_sec is not None:
            elapsed = round(walltime_sec, 4)
            source = 'run.stats'
        instruction_coverage = get_instruction_coverage(stats_path)

        if elapsed is None:
            info_file = os.path.join(folder_path, 'info')
            if os.path.isfile(info_file):
                try:
                    content = _read_text_utf8(info_file)
                    elapsed_str = content.split('Elapsed: ')[1].split('\n')[0]
                    elapsed = time_tranform(elapsed_str)
                except (IndexError, ValueError, OSError):
                    elapsed = 'NA'

        if elapsed is None:
            elapsed = 'NA'

        info_file = os.path.join(folder_path, 'info')
        explored_paths = total_instructions = completed = partial = generated = 'NA'
        if os.path.isfile(info_file):
            try:
                content = _read_text_utf8(info_file)
                explored_paths = content.split('explored paths = ')[1].split('\n')[0]
                total_instructions = content.split('total instructions = ')[1].split('\n')[0]
                completed = content.split('completed paths = ')[1].split('\n')[0]
                partial = content.split('partially completed paths = ')[1].split('\n')[0]
                generated = content.split('generated tests = ')[1].split('\n')[0]
            except (IndexError, ValueError, OSError):
                pass

        df = df.append({'System Call': folder, 'Elapsed': elapsed, 'Source': source,
                        'InstructionCoverage': instruction_coverage if instruction_coverage is not None else 'NA',
                        'Explored Paths': explored_paths, 'Total Instructions': total_instructions,
                        'Completed Paths': completed, 'Partially Completed Paths': partial,
                        'Generated Tests': generated,
                        'StoppedByMaxTime': halted_by_max_time_label(folder_path)}, ignore_index=True)

    finished = df[df['Elapsed'] != 'NA'].shape[0]
    total = df.shape[0]
    _n_max = (df['StoppedByMaxTime'] == 'yes').sum()
    df = df.append({'System Call': 'Total Finished', 'Elapsed': finished / total if total else 0,
                    'Source': '', 'InstructionCoverage': 'NA', 'Explored Paths': 'NA',
                    'Total Instructions': 'NA', 'Completed Paths': 'NA',
                    'Partially Completed Paths': 'NA', 'Generated Tests': 'NA',
                    'StoppedByMaxTime': 'NA'}, ignore_index=True)

    rtos_name = directory.split('/')[-3]
    out_path = os.path.join(output_folder, f'{rtos_name}_runtime_info_walltime.xlsx')
    df.to_excel(out_path, index=False)
    walltime_count = (df['Source'] == 'run.stats').sum()
    print(f'RTOS runtime info (walltime) saved to: {rtos_name}_runtime_info_walltime.xlsx '
          f'({walltime_count} from run.stats, StoppedByMaxTime=yes: {_n_max})')
    dated_copy(out_path)


def _write_merged_detailed_sheet(writer, merged_detailed):
    """Write full per-row KLEE findings (concat of each RTOS Detailed Report)."""
    if merged_detailed is not None and not merged_detailed.empty:
        merged_detailed.to_excel(writer, sheet_name='Merged Detailed Report', index=False)
    else:
        pd.DataFrame(
            {'Message': ['No Detailed Report in per-RTOS *_vulnerability_report.xlsx; run vulnerability_analysis.']}
        ).to_excel(writer, sheet_name='Merged Detailed Report', index=False)


def _infer_rtos_project_from_row(row):
    """
    When RTOS_Project is missing (old reports), infer from SymbolicRoot or File path.
    Paths look like .../test-rtos/freertos-10.5.1/symbolic_execution/...
    """
    if 'RTOS_Project' in row.index and pd.notna(row.get('RTOS_Project')):
        return str(row['RTOS_Project']).strip() or 'unknown'
    rt = row.get('RTOS')
    if pd.notna(rt) and str(rt).strip() not in ('', 'test-rtos'):
        return str(rt).strip()
    sr = str(row.get('SymbolicRoot', '') or '').replace('\\', '/')
    m = re.search(r'/test-rtos/([^/]+)/', sr)
    if m:
        return m.group(1)
    fp = str(row.get('File', '') or '').replace('\\', '/')
    m = re.search(r'test-rtos/([^/]+)/', fp)
    if m:
        return m.group(1)
    m = re.search(r'/test-rtos/([^/]+)/', fp)
    if m:
        return m.group(1)
    return 'unknown'


def _syscall_key_from_row(row):
    """
    One KLEE harness / syscall test: prefer Harness (test-info-output folder name),
    else parent directory of TestInfoPath, else Function.
    """
    h = row.get('Harness')
    if h is not None and pd.notna(h) and str(h).strip():
        return str(h).strip()
    tp = str(row.get('TestInfoPath', '') or '')
    if tp:
        return os.path.basename(os.path.normpath(os.path.dirname(tp)))
    fn = row.get('Function')
    if fn is not None and pd.notna(fn) and str(fn).strip():
        return str(fn).strip()
    return 'unknown'


def _resolve_source_file_path(file_str, symbolic_root):
    """Map KLEE-reported File path to a readable path under the repo."""
    if not file_str or not str(file_str).strip():
        return None
    p = str(file_str).strip().replace('\\', '/')
    if os.path.isabs(p) and os.path.isfile(p):
        return p
    roots = []
    if symbolic_root:
        sr = os.path.abspath(symbolic_root)
        roots.extend([
            os.path.abspath(os.path.join(sr, '..', '..', '..')),
            os.path.abspath(os.path.join(sr, '..', '..')),
            os.path.abspath(os.path.join(sr, '..')),
        ])
    script_dir = os.path.dirname(os.path.abspath(__file__))
    roots.append(os.path.abspath(os.path.join(script_dir, '..')))
    for root in roots:
        cand = os.path.normpath(os.path.join(root, p))
        if os.path.isfile(cand):
            return cand
    # TizenRT: KLEE/LLVM often reports paths relative to os/kernel (e.g.
    # group/group_leave.c, mqueue/mq_notify.c), not the repo root.
    if symbolic_root:
        sr = os.path.abspath(symbolic_root)
        tizenrt_home = os.path.normpath(os.path.join(sr, '..'))
        if os.path.basename(tizenrt_home) == 'tizenrt':
            tizen_kernel = os.path.join(tizenrt_home, 'os', 'kernel')
            if os.path.isdir(tizen_kernel):
                cand = os.path.normpath(os.path.join(tizen_kernel, p))
                if os.path.isfile(cand):
                    return cand
    return None


def _read_source_line_one_indexed(path, line_1based):
    try:
        ln = int(line_1based)
    except (TypeError, ValueError):
        return ''
    if ln < 1 or not path:
        return ''
    try:
        with open(path, 'r', encoding='utf-8', errors='replace') as f:
            for i, line in enumerate(f, start=1):
                if i == ln:
                    return line.rstrip('\n\r')
    except OSError:
        pass
    return ''


def _prepare_merged_detailed_for_my_types(merged_detailed):
    """Return copy with RTOS_Project, _syscall_key, _function_key; exclude omitted RTOS."""
    if merged_detailed is None or merged_detailed.empty:
        return pd.DataFrame()
    df = merged_detailed.copy()
    if 'RTOS_Project' in df.columns:
        df = df[~df['RTOS_Project'].isin(RTOS_EXCLUDED_FROM_VULNERABILITY_SUMMARY)]
    if df.empty:
        return df
    if 'RTOS_Project' not in df.columns:
        df['RTOS_Project'] = df.apply(_infer_rtos_project_from_row, axis=1)
    else:
        df['RTOS_Project'] = df['RTOS_Project'].apply(
            lambda x: str(x).strip() if pd.notna(x) and str(x).strip() else None)
        mask = df['RTOS_Project'].isna() | (df['RTOS_Project'] == '')
        df.loc[mask, 'RTOS_Project'] = df.loc[mask].apply(_infer_rtos_project_from_row, axis=1)
    df['_syscall_key'] = df.apply(_syscall_key_from_row, axis=1)
    if 'Function' in df.columns:
        df['_function_key'] = df['Function'].apply(
            lambda x: str(x).strip() if pd.notna(x) and str(x).strip() else ''
        )
    else:
        df['_function_key'] = ''
    return df


def build_my_type_syscall_count_sheet(merged_detailed):
    """
    Long table: per RTOS, per Type_Category (direct | guarded), per type string,
    count distinct syscalls. Direct and guarded are computed separately (overlap
    strings such as uninit may appear in both sections).
    """
    df = _prepare_merged_detailed_for_my_types(merged_detailed)
    if df.empty or 'Vulnerability Type' not in df.columns:
        return pd.DataFrame()
    df = df[df['Vulnerability Type'].apply(
        lambda v: _finding_matches_any_type(v, MY_VULNERABILITY_TYPES_ALL)
    )]
    if df.empty:
        return pd.DataFrame()

    def _append_block(rows_out, frame, rtos_label, type_category, types_tuple):
        mask = frame['Vulnerability Type'].apply(
            lambda v, tt=types_tuple: _finding_matches_any_type(v, tt)
        )
        sub = frame[mask]
        rows_out.append({
            'RTOS_Project': rtos_label,
            'Type_Category': type_category,
            'My_Vulnerability_Type': f'(any {type_category} type)',
            'Unique_Syscall_Count': int(sub['_syscall_key'].nunique()) if not sub.empty else 0,
        })
        for vt in types_tuple:
            ss = sub[sub['Vulnerability Type'].apply(
                lambda v, t=vt: _finding_matches_any_type(v, (t,))
            )]
            rows_out.append({
                'RTOS_Project': rtos_label,
                'Type_Category': type_category,
                'My_Vulnerability_Type': vt,
                'Unique_Syscall_Count': int(ss['_syscall_key'].nunique()) if not ss.empty else 0,
            })

    rows = []
    for rtos in sorted(df['RTOS_Project'].dropna().unique()):
        sub_rtos = df[df['RTOS_Project'] == rtos]
        _append_block(rows, sub_rtos, rtos, 'direct', MY_VULNERABILITY_TYPES_DIRECT)
        _append_block(
            rows, sub_rtos, rtos, 'guarded', tuple(sorted(MY_VULNERABILITY_TYPES_GUARDED)))

    for type_category, types_tuple in (
        ('direct', MY_VULNERABILITY_TYPES_DIRECT),
        ('guarded', tuple(sorted(MY_VULNERABILITY_TYPES_GUARDED))),
    ):
        _append_block(rows, df, 'ALL (merged)', type_category, types_tuple)

    out = pd.DataFrame(rows)
    return out


def build_my_type_syscall_count_sheet_without_guarded(merged_detailed):
    """
    Long table: per RTOS (and ALL), unique syscall counts + alert counts under merged taxonomy
    (without direct/guarded split):
      - Information leak: V0 or V1
      - Arbitrary write: V0 or V1 or V5
      - Limited write: V2 or V3
      - Uninitialized pointer dereference
      - Function pointer dereference
    """
    df = _prepare_merged_detailed_for_my_types(merged_detailed)
    if df.empty or 'Vulnerability Type' not in df.columns:
        return pd.DataFrame()
    df = df[df['Vulnerability Type'].apply(
        lambda v: _finding_matches_any_type(v, MY_VULNERABILITY_TYPES_ALL)
    )]
    if df.empty:
        return pd.DataFrame()

    merged_map = (
        ('(any merged my-type)', (
            'Information leak vulnerability (V0)',
            'Information leak vulnerability (V1)',
            'Arbitrary memory write vulnerability (V0)',
            'Arbitrary memory write vulnerability (V1)',
            'Arbitrary memory write vulnerability (V5)',
            'Limited memory write vulnerability (V2)',
            'Limited memory write vulnerability (V3)',
            'Uninitialized pointer dereference(read) vulnerability',
            'Potential Function pointer dereference vulnerability',
        )),
        ('Information leak (V0|V1)', (
            'Information leak vulnerability (V0)',
            'Information leak vulnerability (V1)',
        )),
        ('Memory write arbitrary (V0|V1|V5)', (
            'Arbitrary memory write vulnerability (V0)',
            'Arbitrary memory write vulnerability (V1)',
            'Arbitrary memory write vulnerability (V5)',
        )),
        ('Memory write limited (V2|V3)', (
            'Limited memory write vulnerability (V2)',
            'Limited memory write vulnerability (V3)',
        )),
        ('Uninitialized pointer dereference', (
            'Uninitialized pointer dereference(read) vulnerability',
        )),
        ('Function pointer dereference', (
            'Potential Function pointer dereference vulnerability',
        )),
    )

    def _append_rows(rows_out, frame, rtos_label):
        for label, types_tuple in merged_map:
            mask = frame['Vulnerability Type'].apply(
                lambda v, tt=types_tuple: _finding_matches_any_type(v, tt)
            )
            ss = frame[mask]
            rows_out.append({
                'RTOS_Project': rtos_label,
                'Type_Category': 'withoutguarded',
                'My_Vulnerability_Type': label,
                'Unique_Syscall_Count': int(ss['_syscall_key'].nunique()) if not ss.empty else 0,
                'AlertCount': int(len(ss)) if not ss.empty else 0,
            })

    rows = []
    for rtos in sorted(df['RTOS_Project'].dropna().unique()):
        _append_rows(rows, df[df['RTOS_Project'] == rtos], rtos)
    _append_rows(rows, df, 'ALL (merged)')
    return pd.DataFrame(rows)


def _build_my_type_source_line_sheet_for_types(merged_detailed, types_iterable):
    """
    One row per (RTOS, syscall, finding type): File:Line + one source line.
    types_iterable: e.g. MY_VULNERABILITY_TYPES_DIRECT or sorted GUARDED tuple.
    """
    df = _prepare_merged_detailed_for_my_types(merged_detailed)
    if df.empty or 'Vulnerability Type' not in df.columns:
        return pd.DataFrame()
    df = df[df['Vulnerability Type'].apply(
        lambda v, tt=types_iterable: _finding_matches_any_type(v, tt)
    )]
    if df.empty:
        return pd.DataFrame()

    rows = []
    grouped = df.groupby(['RTOS_Project', '_syscall_key', 'Vulnerability Type'], dropna=False)
    for (rtos, skey, vtype), g in grouped:
        row0 = g.iloc[0]
        file_s = row0.get('File', '') or ''
        line_s = row0.get('Line Number', '')
        sym = row0.get('SymbolicRoot', '')
        resolved = _resolve_source_file_path(file_s, sym)
        src_line = _read_source_line_one_indexed(resolved, line_s)
        rows.append({
            'RTOS_Project': rtos,
            'Syscall_Key': skey,
            'My_Vulnerability_Type': vtype,
            'File_As_Reported': file_s,
            'Line_Number': line_s,
            'Resolved_Source_Path': resolved or '',
            'Source_Line': src_line,
        })
    out = pd.DataFrame(rows)
    if not out.empty:
        out = out.sort_values(
            ['RTOS_Project', 'Syscall_Key', 'My_Vulnerability_Type']
        ).reset_index(drop=True)
        # Stable syscall numbering per RTOS (same Syscall_Key → same index on all its rows).
        sku = (
            out[['RTOS_Project', 'Syscall_Key']]
            .drop_duplicates()
            .sort_values(['RTOS_Project', 'Syscall_Key'])
            .reset_index(drop=True)
        )
        sku['Syscall_Index'] = sku.groupby('RTOS_Project', sort=False).cumcount() + 1
        sku['Total_Syscalls_In_RTOS'] = sku.groupby('RTOS_Project')['Syscall_Key'].transform(
            'count'
        )
        out = out.merge(sku, on=['RTOS_Project', 'Syscall_Key'], how='left')
        front = [
            'RTOS_Project',
            'Syscall_Index',
            'Total_Syscalls_In_RTOS',
            'Syscall_Key',
        ]
        rest = [c for c in out.columns if c not in front]
        out = out[front + rest]
    return out


def build_my_type_source_line_sheet(merged_detailed):
    """
    One row per (RTOS, syscall, finding type): first File:Line and one source line.
    Only MY_VULNERABILITY_TYPES_DIRECT findings (substring match).
    """
    return _build_my_type_source_line_sheet_for_types(
        merged_detailed, MY_VULNERABILITY_TYPES_DIRECT
    )


def build_my_type_source_line_sheet_guarded(merged_detailed):
    """
    Same columns as MyType_Source_Lines but only MY_VULNERABILITY_TYPES_GUARDED
    (V1/V3 guarded KLEE strings). Syscall_Index / Total_Syscalls_In_RTOS are per-RTOS
    within guarded rows only (not the same numbering as the direct sheet).
    """
    return _build_my_type_source_line_sheet_for_types(
        merged_detailed, tuple(sorted(MY_VULNERABILITY_TYPES_GUARDED))
    )


def build_merged_my_vulnerability_types_v2(merged_detailed):
    """
    One row per merged Detailed Report finding that matches ``MY_VULNERABILITY_TYPES_DIRECT``.

    Columns: index, RTOS, syscall function, file basename + line, DoS / FP / V0 leak /
    V0 arbitrary write / V2 limited write / V5 / uninit markers (✔/X), and full
    ``Vulnerability_Type`` for that row. Sheet title in the workbook is
    ``MERGED_MY_VUL_TYPES_V2_SHEET`` (≤31 chars; long name: Merged My Vulnerability Types V2).
    """
    df = _prepare_merged_detailed_for_my_types(merged_detailed)
    if df.empty or 'Vulnerability Type' not in df.columns:
        return pd.DataFrame()

    mask = df['Vulnerability Type'].apply(
        lambda v: _finding_matches_any_type(v, MY_VULNERABILITY_TYPES_DIRECT)
    )
    sub = df[mask].copy()
    if sub.empty:
        return pd.DataFrame()

    def _cell_tick(vt, needle):
        return '✔' if needle in vt else 'X'

    rows = []
    for _, row in sub.iterrows():
        vt = str(row.get('Vulnerability Type', '') or '')
        f = row.get('File', '')
        if f is None or (isinstance(f, float) and pd.isna(f)):
            f = ''
        f = str(f).strip()
        file_name = os.path.basename(f) if f else ''
        line_no = row.get('Line Number', '')
        func = row.get('Function', '')
        if func is None or (isinstance(func, float) and pd.isna(func)):
            func = ''
        rtos = row.get('RTOS_Project', '') or row.get('RTOS', '')
        if rtos is None or (isinstance(rtos, float) and pd.isna(rtos)):
            rtos = ''
        rows.append({
            'RTOS': str(rtos).strip(),
            'Syscall_Function': str(func).strip(),
            'File_Name': file_name,
            'Line_Number': line_no,
            'DoS': '✔',
            'FP': _cell_tick(vt, 'Potential Function pointer dereference vulnerability'),
            'V0_Information_Leak': _cell_tick(vt, 'Information leak vulnerability (V0)'),
            'V0_Arbitrary_Write': _cell_tick(vt, 'Arbitrary memory write vulnerability (V0)'),
            'V2_Limited_Write': _cell_tick(vt, 'Limited memory write vulnerability (V2)'),
            'V5_Arbitrary_Write': _cell_tick(vt, 'Arbitrary memory write vulnerability (V5)'),
            'Uninitialized': _cell_tick(vt, 'Uninitialized pointer dereference(read) vulnerability'),
            'Vulnerability_Type': vt,
        })

    out = pd.DataFrame(rows)
    out = out.sort_values(
        ['RTOS', 'Syscall_Function', 'File_Name', 'Line_Number'],
        kind='mergesort',
    ).reset_index(drop=True)
    out.insert(0, 'Index', range(1, len(out) + 1))
    return out


def build_rtos_vulnerability_metrics_table(merged_detailed):
    """
    Build a per-RTOS metrics table for publication (sheet: VULN_METRICS_SHEET_NAME).

    Data source: merged KLEE ``Detailed Report``. Rows are split into two **policy**
    slices that match ``MY_VULNERABILITY_TYPES_DIRECT`` and
    ``MY_VULNERABILITY_TYPES_GUARDED`` respectively (substring rules in
    ``_finding_matches_any_type``). The same physical finding can appear in both
    slices when its KLEE string is listed under both policies (e.g. uninitialized
    pointer dereference).

    **Direct (``MY_VULNERABILITY_TYPES_DIRECT``).**
    Information leak **(V0)** only; arbitrary memory write **(V0)** only; limited
    memory write **(V2)**; function-pointer dereference; uninitialized pointer
    (where reported under the direct taxonomy).

    **Guarded (``MY_VULNERABILITY_TYPES_GUARDED``).**
    Information leak **(V1)**; arbitrary memory write **(V1)** and **(V5)**; limited
    memory write **(V3)**.
    Function-pointer findings appear only in the **Direct** policy list, so guarded
    function-pointer counts are zero by construction.

    *UniqueSyscalls_* = distinct affected syscall functions (``_function_key``, i.e.
    ``Function``). *AlertCount_* = number of finding rows. Arbitrary- and limited-write
    categories are **independent** within each policy slice (a harness with both
    arbitrary and limited findings increments both).

    The final row *ALL (merged)* aggregates across RTOS projects in the merge.
    """
    df_base = _prepare_merged_detailed_for_my_types(merged_detailed)
    if df_base.empty or 'Vulnerability Type' not in df_base.columns:
        return pd.DataFrame()

    vt = df_base['Vulnerability Type']
    m_direct = vt.apply(lambda v: _finding_matches_any_type(v, MY_VULNERABILITY_TYPES_DIRECT))
    m_guarded = vt.apply(lambda v: _finding_matches_any_type(v, MY_VULNERABILITY_TYPES_GUARDED))
    df_d = df_base[m_direct].copy()
    df_g = df_base[m_guarded].copy()
    if df_d.empty and df_g.empty:
        return pd.DataFrame()

    def _ua(sub, mask):
        if sub is None or sub.empty:
            return 0, 0
        ss = sub[mask]
        if ss.empty:
            return 0, 0
        if '_function_key' in ss.columns:
            f = ss['_function_key'].astype(str).str.strip()
            return int(f[f != ''].nunique()), int(len(ss))
        return int(ss['_syscall_key'].nunique()), int(len(ss))

    def _aggregate_direct(sub):
        """Direct policy: V0 leak; arbitrary V0; limited V2; FP; uninit."""
        out = {}
        if sub.empty:
            keys_d = (
                'UniqueSyscalls_AllSelectedTypes_Direct',
                'AlertCount_AllSelectedTypes_Direct',
                'UniqueSyscalls_FunctionPointerDeref_Direct',
                'AlertCount_FunctionPointerDeref_Direct',
                'UniqueSyscalls_InformationLeak_V0_Direct',
                'AlertCount_InformationLeak_V0_Direct',
                'UniqueSyscalls_MemoryWrite_Arbitrary_Direct',
                'AlertCount_MemoryWrite_Arbitrary_Direct',
                'UniqueSyscalls_MemoryWrite_Limited_V2_Direct',
                'AlertCount_MemoryWrite_Limited_V2_Direct',
                'UniqueSyscalls_UninitializedPointerDeref_Direct',
                'AlertCount_UninitializedPointerDeref_Direct',
            )
            return {k: 0 for k in keys_d}

        m_all = pd.Series(True, index=sub.index)
        out['UniqueSyscalls_AllSelectedTypes_Direct'], out['AlertCount_AllSelectedTypes_Direct'] = (
            _ua(sub, m_all)
        )
        v = sub['Vulnerability Type'].astype(str)
        pairs = []
        for name, types_tuple in DIRECT_METRIC_TYPE_MAP.items():
            if not types_tuple:
                m = pd.Series(False, index=v.index)
            else:
                m = pd.Series(False, index=v.index)
                for t in types_tuple:
                    m = m | v.str.contains(t, regex=False)
            pairs.append((name, m))
        for name, m in pairs:
            u, a = _ua(sub, m)
            out[f'UniqueSyscalls_{name}_Direct'] = u
            out[f'AlertCount_{name}_Direct'] = a

        return out

    def _aggregate_guarded(sub):
        """Guarded policy: V1 leak; arbitrary V1/V5; limited V3; uninit. FP not in guarded taxonomy."""
        keys_g = (
            'UniqueSyscalls_AllSelectedTypes_Guarded',
            'AlertCount_AllSelectedTypes_Guarded',
            'UniqueSyscalls_FunctionPointerDeref_Guarded',
            'AlertCount_FunctionPointerDeref_Guarded',
            'UniqueSyscalls_InformationLeak_V1_Guarded',
            'AlertCount_InformationLeak_V1_Guarded',
            'UniqueSyscalls_MemoryWrite_Arbitrary_Guarded',
            'AlertCount_MemoryWrite_Arbitrary_Guarded',
            'UniqueSyscalls_MemoryWrite_Limited_V3_Guarded',
            'AlertCount_MemoryWrite_Limited_V3_Guarded',
            'UniqueSyscalls_UninitializedPointerDeref_Guarded',
            'AlertCount_UninitializedPointerDeref_Guarded',
        )
        out = {}
        if sub.empty:
            return dict.fromkeys(keys_g, 0)

        m_all = pd.Series(True, index=sub.index)
        out['UniqueSyscalls_AllSelectedTypes_Guarded'], out['AlertCount_AllSelectedTypes_Guarded'] = (
            _ua(sub, m_all)
        )
        v = sub['Vulnerability Type'].astype(str)
        pairs = []
        for name, types_tuple in GUARDED_METRIC_TYPE_MAP.items():
            if not types_tuple:
                m = pd.Series(False, index=v.index)
            else:
                m = pd.Series(False, index=v.index)
                for t in types_tuple:
                    m = m | v.str.contains(t, regex=False)
            pairs.append((name, m))
        for name, m in pairs:
            u, a = _ua(sub, m)
            out[f'UniqueSyscalls_{name}_Guarded'] = u
            out[f'AlertCount_{name}_Guarded'] = a

        return out

    def _one_row(sub_d, sub_g, rtos_label):
        r = {'RTOS_Project': rtos_label}
        r.update(_aggregate_direct(sub_d))
        r.update(_aggregate_guarded(sub_g))
        return r

    all_rtos = set()
    if not df_d.empty:
        all_rtos |= set(df_d['RTOS_Project'].dropna().unique())
    if not df_g.empty:
        all_rtos |= set(df_g['RTOS_Project'].dropna().unique())

    rows = []
    for rproj in sorted(all_rtos, key=str.lower):
        sd = df_d[df_d['RTOS_Project'] == rproj] if not df_d.empty else df_d
        sg = df_g[df_g['RTOS_Project'] == rproj] if not df_g.empty else df_g
        rows.append(_one_row(sd, sg, rproj))
    rows.append(_one_row(df_d, df_g, 'ALL (merged)'))

    out = pd.DataFrame(rows)
    col_order = [
        'RTOS_Project',
        # Direct policy
        'UniqueSyscalls_AllSelectedTypes_Direct',
        'AlertCount_AllSelectedTypes_Direct',
        'UniqueSyscalls_FunctionPointerDeref_Direct',
        'AlertCount_FunctionPointerDeref_Direct',
        'UniqueSyscalls_InformationLeak_V0_Direct',
        'AlertCount_InformationLeak_V0_Direct',
        'UniqueSyscalls_MemoryWrite_Arbitrary_Direct',
        'AlertCount_MemoryWrite_Arbitrary_Direct',
        'UniqueSyscalls_MemoryWrite_Limited_V2_Direct',
        'AlertCount_MemoryWrite_Limited_V2_Direct',
        'UniqueSyscalls_UninitializedPointerDeref_Direct',
        'AlertCount_UninitializedPointerDeref_Direct',
        # Guarded policy
        'UniqueSyscalls_AllSelectedTypes_Guarded',
        'AlertCount_AllSelectedTypes_Guarded',
        'UniqueSyscalls_FunctionPointerDeref_Guarded',
        'AlertCount_FunctionPointerDeref_Guarded',
        'UniqueSyscalls_InformationLeak_V1_Guarded',
        'AlertCount_InformationLeak_V1_Guarded',
        'UniqueSyscalls_MemoryWrite_Arbitrary_Guarded',
        'AlertCount_MemoryWrite_Arbitrary_Guarded',
        'UniqueSyscalls_MemoryWrite_Limited_V3_Guarded',
        'AlertCount_MemoryWrite_Limited_V3_Guarded',
        'UniqueSyscalls_UninitializedPointerDeref_Guarded',
        'AlertCount_UninitializedPointerDeref_Guarded',
    ]
    return out[[c for c in col_order if c in out.columns]]


def build_rtos_vulnerability_metrics_mapping_sheet():
    """
    Explicit metric-to-vulnerability-type mapping for RTOS_Vulnerability_Metrics.
    """
    rows = [
        {
            'Metric': 'UniqueSyscalls_*',
            'Policy': 'Direct/Guarded',
            'Mapped_Vulnerability_Types': 'Unique functions (Function column) among rows selected by metric mask.',
            'Notes': 'UniqueSyscalls metrics are deduped by Function (not alert rows).',
        },
        {
            'Metric': 'AlertCount_*',
            'Policy': 'Direct/Guarded',
            'Mapped_Vulnerability_Types': 'Count of finding rows selected by metric mask.',
            'Notes': 'AlertCount metrics are row-level counts.',
        },
        {
            'Metric': 'UniqueSyscalls_AllSelectedTypes_Direct / AlertCount_AllSelectedTypes_Direct',
            'Policy': 'Direct',
            'Mapped_Vulnerability_Types': ', '.join(MY_VULNERABILITY_TYPES_DIRECT),
            'Notes': 'Direct taxonomy slice.',
        },
        {
            'Metric': 'UniqueSyscalls_InformationLeak_V0_Direct / AlertCount_InformationLeak_V0_Direct',
            'Policy': 'Direct',
            'Mapped_Vulnerability_Types': ' OR '.join(DIRECT_METRIC_TYPE_MAP['InformationLeak_V0']),
            'Notes': '',
        },
        {
            'Metric': 'UniqueSyscalls_MemoryWrite_Arbitrary_Direct / AlertCount_MemoryWrite_Arbitrary_Direct',
            'Policy': 'Direct',
            'Mapped_Vulnerability_Types': ' OR '.join(DIRECT_METRIC_TYPE_MAP['MemoryWrite_Arbitrary']),
            'Notes': 'Direct W-I uses V0 only.',
        },
        {
            'Metric': 'UniqueSyscalls_MemoryWrite_Limited_V2_Direct / AlertCount_MemoryWrite_Limited_V2_Direct',
            'Policy': 'Direct',
            'Mapped_Vulnerability_Types': ' OR '.join(DIRECT_METRIC_TYPE_MAP['MemoryWrite_Limited_V2']),
            'Notes': '',
        },
        {
            'Metric': 'UniqueSyscalls_UninitializedPointerDeref_Direct / AlertCount_UninitializedPointerDeref_Direct',
            'Policy': 'Direct',
            'Mapped_Vulnerability_Types': ' OR '.join(DIRECT_METRIC_TYPE_MAP['UninitializedPointerDeref']),
            'Notes': '',
        },
        {
            'Metric': 'UniqueSyscalls_FunctionPointerDeref_Direct / AlertCount_FunctionPointerDeref_Direct',
            'Policy': 'Direct',
            'Mapped_Vulnerability_Types': ' OR '.join(DIRECT_METRIC_TYPE_MAP['FunctionPointerDeref']),
            'Notes': '',
        },
        {
            'Metric': 'UniqueSyscalls_AllSelectedTypes_Guarded / AlertCount_AllSelectedTypes_Guarded',
            'Policy': 'Guarded',
            'Mapped_Vulnerability_Types': ', '.join(sorted(MY_VULNERABILITY_TYPES_GUARDED)),
            'Notes': 'Guarded taxonomy slice.',
        },
        {
            'Metric': 'UniqueSyscalls_InformationLeak_V1_Guarded / AlertCount_InformationLeak_V1_Guarded',
            'Policy': 'Guarded',
            'Mapped_Vulnerability_Types': ' OR '.join(GUARDED_METRIC_TYPE_MAP['InformationLeak_V1']),
            'Notes': '',
        },
        {
            'Metric': 'UniqueSyscalls_MemoryWrite_Arbitrary_Guarded / AlertCount_MemoryWrite_Arbitrary_Guarded',
            'Policy': 'Guarded',
            'Mapped_Vulnerability_Types': ' OR '.join(GUARDED_METRIC_TYPE_MAP['MemoryWrite_Arbitrary']),
            'Notes': 'As requested: guarded arbitrary includes V1 and V5.',
        },
        {
            'Metric': 'UniqueSyscalls_MemoryWrite_Limited_V3_Guarded / AlertCount_MemoryWrite_Limited_V3_Guarded',
            'Policy': 'Guarded',
            'Mapped_Vulnerability_Types': ' OR '.join(GUARDED_METRIC_TYPE_MAP['MemoryWrite_Limited_V3']),
            'Notes': '',
        },
        {
            'Metric': 'UniqueSyscalls_UninitializedPointerDeref_Guarded / AlertCount_UninitializedPointerDeref_Guarded',
            'Policy': 'Guarded',
            'Mapped_Vulnerability_Types': '(none)',
            'Notes': 'Excluded from guarded mapping; expected 0.',
        },
        {
            'Metric': 'UniqueSyscalls_FunctionPointerDeref_Guarded / AlertCount_FunctionPointerDeref_Guarded',
            'Policy': 'Guarded',
            'Mapped_Vulnerability_Types': '(none)',
            'Notes': 'Guarded taxonomy has no function-pointer type; expected 0.',
        },
    ]
    return pd.DataFrame(rows)


def _add_my_type_summary_sheets(writer, merged_detailed):
    """Append My-Type syscall stats + one-line code extract (direct + guarded) to vulnerability_summary.xlsx."""
    counts = build_my_type_syscall_count_sheet(merged_detailed)
    counts_wo_guarded = build_my_type_syscall_count_sheet_without_guarded(merged_detailed)
    lines = build_my_type_source_line_sheet(merged_detailed)
    lines_guarded = build_my_type_source_line_sheet_guarded(merged_detailed)

    if counts is not None and not counts.empty:
        counts.to_excel(writer, sheet_name='MyType_Syscall_Counts', index=False)
    else:
        pd.DataFrame({
            'Message': ['No merged detailed rows for MY_VULNERABILITY_TYPES_ALL; see Merged Detailed Report.']
        }).to_excel(writer, sheet_name='MyType_Syscall_Counts', index=False)

    if counts_wo_guarded is not None and not counts_wo_guarded.empty:
        counts_wo_guarded.to_excel(writer, sheet_name='withoutguarded', index=False)
    else:
        pd.DataFrame({
            'Message': ['No merged detailed rows for MY_VULNERABILITY_TYPES_ALL; see Merged Detailed Report.']
        }).to_excel(writer, sheet_name='withoutguarded', index=False)

    if lines is not None and not lines.empty:
        lines.to_excel(writer, sheet_name='MyType_Source_Lines', index=False)
    else:
        pd.DataFrame({
            'Message': [
                'No DIRECT-type rows to extract (MyType_Source_Lines uses MY_VULNERABILITY_TYPES_DIRECT only).'
            ]
        }).to_excel(writer, sheet_name='MyType_Source_Lines', index=False)

    if lines_guarded is not None and not lines_guarded.empty:
        lines_guarded.to_excel(writer, sheet_name='MyType_Source_Lines_Guarded', index=False)
    else:
        pd.DataFrame({
            'Message': [
                'No GUARDED-type rows to extract (MyType_Source_Lines_Guarded uses MY_VULNERABILITY_TYPES_GUARDED only).'
            ]
        }).to_excel(writer, sheet_name='MyType_Source_Lines_Guarded', index=False)

    metrics = build_rtos_vulnerability_metrics_table(merged_detailed)
    if metrics is not None and not metrics.empty:
        metrics.to_excel(writer, sheet_name=VULN_METRICS_SHEET_NAME, index=False)
    else:
        pd.DataFrame({
            'Message': [
                'No merged Detailed Report rows for MY_VULNERABILITY_TYPES_ALL; '
                'see build_rtos_vulnerability_metrics_table in data-analyze-all.py.'
            ]
        }).to_excel(writer, sheet_name=VULN_METRICS_SHEET_NAME, index=False)

    mapping = build_rtos_vulnerability_metrics_mapping_sheet()
    mapping.to_excel(writer, sheet_name='RTOS_Vuln_Metrics_Map', index=False)

    v2 = build_merged_my_vulnerability_types_v2(merged_detailed)
    if v2 is not None and not v2.empty:
        v2.to_excel(writer, sheet_name=MERGED_MY_VUL_TYPES_V2_SHEET, index=False)
    else:
        pd.DataFrame({
            'Message': [
                'No DIRECT-type rows for Merged My Vulnerability Types V2 '
                '(see Merged Detailed Report and MY_VULNERABILITY_TYPES_DIRECT).'
            ]
        }).to_excel(writer, sheet_name=MERGED_MY_VUL_TYPES_V2_SHEET, index=False)


def write_rtos_vulnerability_type_totals(merged_detailed, output_folder):
    """
    Per-RTOS stats from Merged Detailed Report:
    - Finding_Count: KLEE error lines (may repeat per syscall).
    - Unique_Syscall_Count: distinct harness / syscall tests with >=1 finding of that type.
    Writes vulnerability_summary_rtos_totals.xlsx.
    """
    if merged_detailed is None or merged_detailed.empty:
        return
    if 'Vulnerability Type' not in merged_detailed.columns:
        print('Warning: write_rtos_vulnerability_type_totals: no Vulnerability Type column.')
        return

    df = merged_detailed.copy()
    if 'RTOS_Project' in df.columns:
        df = df[~df['RTOS_Project'].isin(RTOS_EXCLUDED_FROM_VULNERABILITY_SUMMARY)]
    if df.empty:
        print('Warning: write_rtos_vulnerability_type_totals: no rows after RTOS filter.')
        return
    if 'RTOS_Project' not in df.columns:
        df['RTOS_Project'] = df.apply(_infer_rtos_project_from_row, axis=1)
    else:
        df['RTOS_Project'] = df['RTOS_Project'].apply(
            lambda x: str(x).strip() if pd.notna(x) and str(x).strip() else None)
        mask = df['RTOS_Project'].isna() | (df['RTOS_Project'] == '')
        df.loc[mask, 'RTOS_Project'] = df.loc[mask].apply(_infer_rtos_project_from_row, axis=1)

    df['_syscall_key'] = df.apply(_syscall_key_from_row, axis=1)

    finding_counts = (
        df.groupby(['RTOS_Project', 'Vulnerability Type'], dropna=False)
        .size()
        .reset_index(name='Finding_Count')
        .sort_values(['RTOS_Project', 'Vulnerability Type'])
    )
    finding_pivot = finding_counts.pivot_table(
        index='RTOS_Project',
        columns='Vulnerability Type',
        values='Finding_Count',
        fill_value=0,
        aggfunc='sum',
    )
    finding_pivot['Total'] = finding_pivot.sum(axis=1)
    finding_total_row = pd.DataFrame([finding_pivot.sum(axis=0)], index=['Total'])
    finding_pivot_out = pd.concat([finding_pivot, finding_total_row])

    syscall_counts = (
        df.groupby(['RTOS_Project', 'Vulnerability Type'], dropna=False)['_syscall_key']
        .nunique()
        .reset_index(name='Unique_Syscall_Count')
        .sort_values(['RTOS_Project', 'Vulnerability Type'])
    )
    syscall_pivot = syscall_counts.pivot_table(
        index='RTOS_Project',
        columns='Vulnerability Type',
        values='Unique_Syscall_Count',
        fill_value=0,
        aggfunc='sum',
    )
    syscall_pivot['Total'] = syscall_pivot.sum(axis=1)
    syscall_total_row = pd.DataFrame([syscall_pivot.sum(axis=0)], index=['Total'])
    syscall_pivot_out = pd.concat([syscall_pivot, syscall_total_row])

    notes = pd.DataFrame([
        {
            'Metric': 'Finding_Count',
            '说明': '「告警条数」：Merged Detailed Report 中，对应 RTOS × 漏洞类型 的 KLEE 报错行数（test_info.txt 里每条 Error 计一次）。同一 syscall/harness 可对应多条（不同路径/行号）。',
            'Description': 'Number of KLEE error lines; one harness may contribute multiple findings.',
        },
        {
            'Metric': 'Unique_Syscall_Count',
            '说明': '「涉及漏洞的 syscall 数量」：在同一 RTOS × 漏洞类型 下，对 Harness（无则用 TestInfoPath 上级目录名，再无则 Function）去重后的个数，即「至少出现过一次该类型告警」的独立 syscall 测试数。',
            'Description': 'Distinct syscall tests (Harness / test-info folder key) with at least one finding of that type.',
        },
        {
            'Metric': '_syscall_key',
            '说明': '内部键：优先 Harness 列；否则取 test_info.txt 所在目录名；再否则 Function。',
            'Description': 'Dedup key: Harness, else dirname(TestInfoPath), else Function.',
        },
    ])

    out_path = os.path.join(output_folder, 'vulnerability_summary_rtos_totals.xlsx')
    with pd.ExcelWriter(out_path, engine='openpyxl') as writer:
        notes.to_excel(writer, sheet_name='Notes', index=False)
        finding_counts.to_excel(writer, sheet_name='Finding_Counts', index=False)
        finding_pivot_out.to_excel(writer, sheet_name='Finding_Pivot')
        syscall_counts.to_excel(writer, sheet_name='Syscall_Counts', index=False)
        syscall_pivot_out.to_excel(writer, sheet_name='Syscall_Pivot')
    dated_copy(out_path)
    print(f'Per-RTOS totals (findings + unique syscalls) saved to: {out_path}')


def write_memory_write_ii_mpu_t_ratio(merged_my_vul_df, output_folder):
    """
    Among rows in My Vulnerability Types with limited write (W-II)—``Memory Write``
    is ``II`` or ``I, II``—compute the fraction that also have MPU (T) == ✔.
    Per RTOS plus an ALL (merged) row.
    """
    if merged_my_vul_df is None or merged_my_vul_df.empty:
        return
    df = merged_my_vul_df.copy()
    if 'Function' in df.columns:
        df = df[~df['Function'].astype(str).isin(['总计', 'Total'])]
    if 'Memory Write' not in df.columns:
        print('write_memory_write_ii_mpu_t_ratio: no Memory Write column, skip.')
        return
    mpu_t_col = 'MPU (T)'
    has_mpu_t = mpu_t_col in df.columns

    def _ii_mask(series):
        s = series.astype(str).str.strip()
        return s.eq('II') | s.eq('I, II')

    def _mpu_t_mask(frame):
        if not has_mpu_t:
            return pd.Series(False, index=frame.index)
        return frame[mpu_t_col].astype(str).str.strip() == '✔'

    rows = []
    for rtos in sorted(df['RTOS'].dropna().unique()):
        sub = df[df['RTOS'] == rtos]
        ii = _ii_mask(sub['Memory Write'])
        n_ii = int(ii.sum())
        n_both = int((ii & _mpu_t_mask(sub)).sum()) if has_mpu_t else 0
        ratio = (n_both / n_ii) if n_ii else None
        rows.append({
            'RTOS': rtos,
            'MemoryWrite_II_Count': n_ii,
            'MemoryWrite_II_and_MPU_T_Count': n_both,
            'Ratio_II_with_MPU_T': ratio,
        })

    ii_all = _ii_mask(df['Memory Write'])
    n_ii_all = int(ii_all.sum())
    n_both_all = int((ii_all & _mpu_t_mask(df)).sum()) if has_mpu_t else 0
    ratio_all = (n_both_all / n_ii_all) if n_ii_all else None
    rows.append({
        'RTOS': 'ALL (merged)',
        'MemoryWrite_II_Count': n_ii_all,
        'MemoryWrite_II_and_MPU_T_Count': n_both_all,
        'Ratio_II_with_MPU_T': ratio_all,
    })

    notes = pd.DataFrame([{
        'Metric': 'Ratio_II_with_MPU_T',
        '说明': (
            '在合并后的 My Vulnerability Types 中：分母为 Memory Write 含 W-II 的 syscall 数'
            '（值为 II 或 I, II）；分子为其中 MPU (T) = ✔ 的条数。比例 = 分子/分母。'
        ),
        'Description': (
            'Among rows with limited memory write (Memory Write is II or I, II), '
            'fraction with MPU violation (T). '
            'Denominator: MemoryWrite_II_Count; numerator: MemoryWrite_II_and_MPU_T_Count.'
        ),
    }])
    out_df = pd.DataFrame(rows)
    out_path = os.path.join(output_folder, 'vulnerability_summary_mwii_mpu_t_ratio.xlsx')
    with pd.ExcelWriter(out_path, engine='openpyxl') as writer:
        notes.to_excel(writer, sheet_name='Notes', index=False)
        out_df.to_excel(writer, sheet_name='Ratios', index=False)
    dated_copy(out_path)
    print(f'Memory-Write II and MPU (T) ratio saved to: {out_path}')


def generate_summary_excel(root_folder, output_folder, split_size=80):
    summary_excel_path = os.path.join(output_folder, 'vulnerability_summary.xlsx')
    merged_df = None
    merged_verification = None
    merged_detailed = None

    for rtos_name, rtos_path in root_folder.items():
        if rtos_name in RTOS_EXCLUDED_FROM_VULNERABILITY_SUMMARY:
            print(f"Skipping merge for {rtos_name} (excluded from vulnerability summary).")
            continue
        print(f"Merging vulnerability report of {rtos_name}")
        rtos_vul_path = os.path.join(output_folder, f'{rtos_name}_vulnerability_report.xlsx')
        if not os.path.isfile(rtos_vul_path):
            print(f"Warning: {rtos_vul_path} not found. Skipping...")
            continue

        try:
            ver_df = pd.read_excel(rtos_vul_path, sheet_name='Verification Details', engine='openpyxl')
            if ver_df is not None and not ver_df.empty:
                if merged_verification is None:
                    merged_verification = ver_df
                else:
                    merged_verification = pd.concat([merged_verification, ver_df], ignore_index=True)
        except Exception as e:
            print(f"Warning: could not read 'Verification Details' from {rtos_vul_path}: {e}")

        try:
            detail_df = pd.read_excel(rtos_vul_path, sheet_name='Detailed Report', engine='openpyxl')
            if detail_df is not None and not detail_df.empty:
                detail_df = detail_df.copy()
                detail_df['RTOS_Project'] = rtos_name
                if 'RTOS' not in detail_df.columns:
                    detail_df.insert(0, 'RTOS', rtos_name)
                merged_detailed = (
                    detail_df if merged_detailed is None
                    else pd.concat([merged_detailed, detail_df], ignore_index=True))
        except Exception as e:
            print(f"Warning: could not read 'Detailed Report' from {rtos_vul_path}: {e}")

        try:
            my_vul_df = pd.read_excel(rtos_vul_path, sheet_name='My Vulnerability Types', engine='openpyxl')
            my_vul_df = my_vul_df.drop('File', axis=1, errors='ignore')
            my_vul_df = my_vul_df.drop('Harness', axis=1, errors='ignore')
            my_vul_df = my_vul_df[~my_vul_df['Function'].isin(['总计', 'Total'])]
            my_vul_df['RTOS'] = rtos_name
            if merged_df is None:
                merged_df = my_vul_df
            else:
                merged_df = pd.concat([merged_df, my_vul_df], ignore_index=True)
        except KeyError:
            print(f"Warning: Sheet 'My Vulnerability Types' not found in {rtos_name} vulnerability report.")
        except Exception as e:
            print(f"Warning: Could not read 'My Vulnerability Types' from {rtos_vul_path}: {e}")

    # Prefer syscall-granularity merged table from merged detailed rows so
    # "Memory Write" can reflect I+II per syscall.
    merged_df_from_detailed = build_merged_my_vulnerability_types_from_detailed(merged_detailed)
    if merged_df_from_detailed is not None and not merged_df_from_detailed.empty:
        merged_df = merged_df_from_detailed

    if merged_df is not None and not merged_df.empty:
        write_memory_write_ii_mpu_t_ratio(merged_df.copy(), output_folder)
        merged_df = merged_df.drop(
            columns=[
                'MPU (T)',
                'MPU (F)',
                'Num of MPU violation (T) Locations',
                'Num of MPU violation (F) Locations',
            ],
            errors='ignore',
        )
        merged_df = merged_df.rename(columns={
            'Number of Vulnerabilities': 'Number of vulnerability alerts'
        })

    if merged_verification is not None and not merged_verification.empty:
        merged_verification = merged_verification.reset_index(drop=True)
        merged_verification['Verification_ID'] = range(1, len(merged_verification) + 1)

    if merged_detailed is not None and not merged_detailed.empty:
        merged_detailed = merged_detailed.reset_index(drop=True)
        if 'Detail_ID' not in merged_detailed.columns:
            merged_detailed.insert(0, 'Detail_ID', range(1, len(merged_detailed) + 1))

    nothing = (
        (merged_df is None or merged_df.empty)
        and (merged_verification is None or merged_verification.empty)
        and (merged_detailed is None or merged_detailed.empty)
    )
    if nothing:
        placeholder = pd.DataFrame({
            'Message': ['No vulnerability reports merged (missing xlsx files or empty data). '
                        'Run vulnerability_analysis for each RTOS first.']
        })
        with pd.ExcelWriter(summary_excel_path, engine='openpyxl') as writer:
            placeholder.to_excel(writer, sheet_name='Merged Detailed Report', index=False)
            placeholder.to_excel(writer, sheet_name='Verification Details', index=False)
            placeholder.to_excel(writer, sheet_name='Merged My Vulnerability Types', index=False)
            _add_my_type_summary_sheets(writer, None)
        dated_copy(summary_excel_path)
        print(f'vulnerability_summary.xlsx written with placeholder (no merged data): {summary_excel_path}')
        return

    if merged_df is None or merged_df.empty:
        with pd.ExcelWriter(summary_excel_path, engine='openpyxl') as writer:
            _write_merged_detailed_sheet(writer, merged_detailed)
            if merged_verification is not None and not merged_verification.empty:
                merged_verification.to_excel(writer, sheet_name='Verification Details', index=False)
            else:
                pd.DataFrame(
                    {'Message': ['No Verification Details in per-RTOS reports.']}
                ).to_excel(writer, sheet_name='Verification Details', index=False)
            pd.DataFrame({'Message': ['No rows in My Vulnerability Types after merge.']}).to_excel(
                writer, sheet_name='Merged My Vulnerability Types', index=False)
            _add_my_type_summary_sheets(writer, merged_detailed)
        dated_copy(summary_excel_path)
        print(f'vulnerability_summary.xlsx (no wide My Vulnerability Types) saved to: {summary_excel_path}')
        write_rtos_vulnerability_type_totals(merged_detailed, output_folder)
        return

    columns = ['RTOS'] + [col for col in merged_df.columns if col != 'RTOS']
    merged_df = merged_df[columns]
    merged_df = merged_df.drop(['Vulnerability Type', 'Line Number'], axis=1, errors='ignore')

    prev_rtos = None
    for idx, row in merged_df.iterrows():
        if row['RTOS'] == prev_rtos:
            merged_df.at[idx, 'RTOS'] = ''
        else:
            prev_rtos = row['RTOS']

    summary_row = {
        'RTOS': 'Total',
        'Function': '',
        'Number of vulnerability alerts': '',
        'DoS': merged_df['DoS'].value_counts().get('✔', 0),
        'FP': merged_df['FP'].value_counts().get('✔', 0),
        'Memory Read': merged_df['Memory Read'].value_counts().get('✔', 0),
        'Memory Write': _memory_write_summary_total_string(merged_df['Memory Write']),
    }
    if 'MPU (T)' in merged_df.columns:
        summary_row['MPU (T)'] = merged_df['MPU (T)'].value_counts().get('✔', 0)
    if 'MPU (F)' in merged_df.columns:
        summary_row['MPU (F)'] = merged_df['MPU (F)'].value_counts().get('✔', 0)
    for col in merged_df.columns:
        if col not in summary_row:
            summary_row[col] = ''
    merged_df = pd.concat([merged_df, pd.DataFrame([summary_row])], ignore_index=True)

    n = len(merged_df)
    index_col = list(range(1, n)) + ['']
    merged_df.insert(0, 'Index', index_col)

    # 拆分表格，每split_size行为一组，横向拼接
    data_df = merged_df.iloc[:-1].reset_index(drop=True)
    total_row = merged_df.iloc[[-1]].reset_index(drop=True)
    n_rows = data_df.shape[0]
    n_splits = (n_rows + split_size - 1) // split_size
    split_dfs = []
    for i in range(n_splits):
        chunk = data_df.iloc[i*split_size:(i+1)*split_size].reset_index(drop=True)
        if len(chunk) < split_size:
            chunk = pd.concat([chunk, pd.DataFrame([['']*chunk.shape[1]]*(split_size-len(chunk)), columns=chunk.columns)], ignore_index=True)
        split_dfs.append(chunk)
    wide_df = pd.concat(split_dfs, axis=1)
    total_row_wide = pd.DataFrame([['']*wide_df.shape[1]], columns=wide_df.columns)
    for i in range(n_splits):
        col_offset = i * split_dfs[0].shape[1]
        for col in total_row.columns:
            if col in split_dfs[0].columns:
                total_row_wide.iloc[0, col_offset + split_dfs[0].columns.get_loc(col)] = total_row.iloc[0][col]
    wide_df = pd.concat([wide_df, total_row_wide], ignore_index=True)

    replace_dict = {
        '✔': '\\tickYes',
        'X': '-'
    }
    wide_df = wide_df.replace(replace_dict)
    with pd.ExcelWriter(summary_excel_path, engine='openpyxl') as writer:
        _write_merged_detailed_sheet(writer, merged_detailed)
        if merged_verification is not None and not merged_verification.empty:
            merged_verification.to_excel(writer, sheet_name='Verification Details', index=False)
        else:
            pd.DataFrame(
                {'Message': ['No Verification Details sheet in per-RTOS reports; re-run data-analyze-all vulnerability_analysis.']}
            ).to_excel(writer, sheet_name='Verification Details', index=False)
        wide_df.to_excel(writer, sheet_name='Merged My Vulnerability Types', index=False)
        _add_my_type_summary_sheets(writer, merged_detailed)
    dated_copy(summary_excel_path)
    print(f'Merged vulnerability_summary.xlsx (Merged Detailed Report + Verification Details + wide types) saved to: {summary_excel_path}')
    write_rtos_vulnerability_type_totals(merged_detailed, output_folder)

if __name__ == "__main__":

    output_folder = "results"
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    all_rtos_folder_path = {
        "freertos-10.5.1": "/home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/",
        "tizenrt": "/home/klee/klee_src/test-rtos/tizenrt/symbolic_execution/",
        "rt-thread": "/home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/",
        "threadx-6.4.2": "/home/klee/klee_src/test-rtos/threadx-6.4.2/symbolic_execution/",
    }

    if "--summary-only" in sys.argv:
        # Merge existing results/<rtos>_vulnerability_report.xlsx → vulnerability_summary.xlsx
        # (no re-scan of test-info-output; use when per-RTOS reports are already up to date.)
        generate_summary_excel(all_rtos_folder_path, output_folder, split_size=80)
        print("Done (--summary-only: merged from existing *_vulnerability_report.xlsx in results/).")
    else:
        root_folder_path = get_rtos_folder()
        if isinstance(root_folder_path, dict):
            for rtos_name, rtos_path in root_folder_path.items():
                print(f"=== vulnerability_analysis + extract_info: {rtos_name} ===")
                vulnerability_analysis(rtos_path, output_folder, rtos_project_name=rtos_name)
                extract_info(rtos_path, output_folder)
        else:
            vulnerability_analysis(root_folder_path, output_folder)
            extract_info(root_folder_path, output_folder)
        for rtos_name, rtos_path in all_rtos_folder_path.items():
            if os.path.isdir(os.path.join(rtos_path, 'output')):
                extract_info_from_run_stats(rtos_path, output_folder)
        generate_summary_excel(all_rtos_folder_path, output_folder, split_size=80)

    