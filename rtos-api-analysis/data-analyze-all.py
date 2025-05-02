import os
import re
import pandas as pd

def vulnerability_analysis(root_folder, output_folder):
    # Create lists to store the data
    vulnerabilities = []
    test_info_folder = os.path.join(root_folder, 'test-info-output')
    for dirpath, dirnames, filenames in os.walk(test_info_folder):
        if 'test_info.txt' in filenames:
            file_path = os.path.join(dirpath, 'test_info.txt')
            try:
                with open(file_path, 'r', encoding='utf-8') as file:
                    for line in file:
                        if "KLEE: Error:" in line:
                            match = re.search(r'KLEE: Error: (.*?)on file (.*?): line (\d+)', line)
                            # Put the filename as the target function name in the vulnerabilities list
                            target_name = os.path.basename(dirpath) 
                            # The target function name may like test_MPU_uxTaskGetStackHighWaterMark
                            # We need to extract the function name from the target name
                            target_name = os.path.basename(dirpath)
                            parts = target_name.split('_')

                            if len(parts) >= 3 and root_folder == "/home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/":
                                target_name = parts[2]
                            else:
                                target_name = target_name
                            if match:
                                vul_type = match.group(1)
                                file_path = match.group(2)
                                line_num = match.group(3)
                                vulnerabilities.append({
                                    'File': file_path,
                                    'Function': target_name,
                                    'Vulnerability Type': vul_type,
                                    'Line Number': line_num
                                })
                            else:
                                vulnerabilities.append({
                                    'File': file_path,
                                    'Function': target_name,
                                    'Vulnerability Type': line.strip(),
                                    'Line Number': 'N/A'
                                })
            except Exception as e:
                print(f'Error reading {file_path}: {e}')
                
    # Create DataFrame for detailed report
    df = pd.DataFrame(vulnerabilities)
    
    # Create vulnerability functions report
    # For a function, we need to separate the files and vulnerability types
    vul_funcs = {}
    for vul in vulnerabilities:
        func = vul['Function']
        if func not in vul_funcs:
            vul_funcs[func] = {
                'File': {vul['File']},
                'Function': func,
                'Vulnerability Type': {vul['Vulnerability Type']}, # Use set to deduplicate
                'Line Number': [vul['Line Number']],
                'Number of Vulnerabilities': 1
            }
        else:
            vul_funcs[func]['File'].add(vul['File'])
            vul_funcs[func]['Vulnerability Type'].add(vul['Vulnerability Type'])
            vul_funcs[func]['Line Number'].append(vul['Line Number'])
            vul_funcs[func]['Number of Vulnerabilities'] += 1

    # Convert to DataFrame
    vul_funcs_df = pd.DataFrame(vul_funcs.values())
    # Combine vulnerability types and line numbers into single cells
    vul_funcs_df['File'] = vul_funcs_df['File'].apply(lambda x: '\n'.join(str(i) for i in x))
    vul_funcs_df['Vulnerability Type'] = vul_funcs_df['Vulnerability Type'].apply(lambda x: '\n'.join(str(i) for i in x))
    vul_funcs_df['Line Number'] = vul_funcs_df['Line Number'].apply(lambda x: '\n'.join(str(i) for i in x))
    
    # Save both reports to a single Excel file with two sheets
    rtos_name = root_folder.split('/')[-3]  # Get the actual RTOS name from the path
    excel_path = os.path.join(output_folder, f'{rtos_name}_vulnerability_report.xlsx')
    
    with pd.ExcelWriter(excel_path, engine='openpyxl') as writer:
        df.to_excel(writer, sheet_name='Detailed Report', index=False)
        vul_funcs_df.to_excel(writer, sheet_name='Vulnerability Functions Report', index=False)
    
    print(f'Vulnerability Report with both sheets saved to: {excel_path}')

def get_rtos_folder():
    print("Please select the RTOS folder:")
    print("1. FreeRTOS-10.5.1")
    print("2. FreeRTOS-10.6.0")
    print("3. TizenRT")
    print("4. RT-Thread")
    print("5. ThreadX")
    # show the default path
    print("Default path: /home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/")
    choice = input("Enter the number of the RTOS folder: ")
    # give a default path
    default_path = "/home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/"
    
    if choice == "1":
        return "/home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/"
    elif choice == "2":
        return "/home/klee/klee_src/test-rtos/freertos-10.6.0/symbolic_execution/"
    # These two are not ready yet, so print a message
    elif choice == "3": 
        return "/home/klee/klee_src/test-rtos/tizenrt/symbolic_execution/"
    elif choice == "4":
        print("RT-Thread is not ready yet")
        return default_path 
    elif choice == "5":
        return "/home/klee/klee_src/test-rtos/threadx-5.3/symbolic_execution/"
    else:
        return default_path
        

def time_tranform(time_str):

    # Split the time string into its components
    hours, minutes, seconds = [int(i) for i in time_str.split(":")]

    # Calculate total seconds
    total_seconds = hours * 3600 + minutes * 60 + seconds
    return total_seconds

def extract_info(directory, output_folder):
    # 创建一个空的DataFrame来存储结果
    df = pd.DataFrame(columns=['System Call', 'Elapsed', 'Explored Paths', 
                               'Total Instructions', 'Completed Paths', 'Partially Completed Paths', 
                               'Generated Tests'])

    # 遍历目录下的每个子文件夹  
    directory = os.path.join(directory, 'output')
    for folder in os.listdir(directory):
        folder_path = os.path.join(directory, folder)
        if os.path.isdir(folder_path):
            info_file = os.path.join(folder_path, "info")
            
            # 检查info文件是否存在
            if os.path.isfile(info_file):
                with open(info_file, 'r') as file:
                    content = file.read()

                    # 提取信息
                    try:
                        elapsed = content.split('Elapsed: ')[1].split('\n')[0]
                        explored_paths = content.split('explored paths = ')[1].split('\n')[0]
                        # avg_constructs = content.split('avg. constructs per query = ')[1].split('\n')[0]
                        # total_queries = content.split('total queries = ')[1].split('\n')[0]
                        # valid_queries = content.split('valid queries = ')[1].split('\n')[0]
                        # invalid_queries = content.split('invalid queries = ')[1].split('\n')[0]
                        # query_cex = content.split('query cex = ')[1].split('\n')[0]
                        total_instructions = content.split('total instructions = ')[1].split('\n')[0]
                        completed_paths = content.split('completed paths = ')[1].split('\n')[0]
                        partially_completed_paths = content.split('partially completed paths = ')[1].split('\n')[0]
                        generated_tests = content.split('generated tests = ')[1].split('\n')[0]

                        # 添加到DataFrame
                        # df = df.append({'System Call': folder, 'Elapsed': time_tranform(elapsed), 'Explored Paths': explored_paths, 
                        #                 'Avg. Constructs Per Query': avg_constructs, 'Total Queries': total_queries, 
                        #                 'Valid Queries': valid_queries, 'Invalid Queries': invalid_queries, 
                        #                 'Query Cex': query_cex, 'Total Instructions': total_instructions, 
                        #                 'Completed Paths': completed_paths, 'Partially Completed Paths': partially_completed_paths, 
                        #                 'Generated Tests': generated_tests}, ignore_index=True)
                        df = df.append({'System Call': folder, 'Elapsed': time_tranform(elapsed), 'Explored Paths': explored_paths,'Total Instructions': total_instructions, 
                                        'Completed Paths': completed_paths, 'Partially Completed Paths': partially_completed_paths, 
                                        'Generated Tests': generated_tests}, ignore_index=True)
                    except IndexError:
                        # 如果格式不匹配，添加NA
                        # df = df.append({'System Call': folder, 'Elapsed': 'NA', 'Explored Paths': 'NA', 
                        #                 'Avg. Constructs Per Query': 'NA', 'Total Queries': 'NA', 
                        #                 'Valid Queries': 'NA', 'Invalid Queries': 'NA', 
                        #                 'Query Cex': 'NA', 'Total Instructions': 'NA', 
                        #                 'Completed Paths': 'NA', 'Partially Completed Paths': 'NA', 
                        #                 'Generated Tests': 'NA'}, ignore_index=True)
                        df = df.append({'System Call': folder, 'Elapsed': 'NA', 'Explored Paths': 'NA', 
                                        'Completed Paths': 'NA', 'Partially Completed Paths': 'NA', 
                                        'Generated Tests': 'NA'}, ignore_index=True)
    # generate a excel file
    rtos_name = directory.split('/')[-3]  # Get the actual RTOS name from the path
    df.to_excel(os.path.join(output_folder, f'{rtos_name}_runtime_info.xlsx'), index=False)
    print(f'RTOS runtime info saved to: {rtos_name}_runtime_info.xlsx')







root_folder = get_rtos_folder()

# Replace 'your_folder_path' with the path to your main folder
# Create a folder to store the output inside the root folder
output_folder = os.path.join(root_folder, 'results')    
if not os.path.exists(output_folder):
    os.makedirs(output_folder)
vulnerability_analysis(root_folder, output_folder)
extract_info(root_folder, output_folder)