import os
import re

def find_function_declarations(directory, output_file):
    # 匹配所有可能的函数返回类型
    pattern = r'\b(?:UINT|VOID|ULONG|CHAR|INT|FLOAT|DOUBLE|LONG|UNSIGNED|STRUCT|ENUM|UNION|BOOL|TX_|ALIGN_TYPE)\s+\w+\s*\([^;]*\)'
    
    # 存储所有找到的函数声明
    functions = []
    # 存储带指针的函数声明
    pointer_functions = []
    # 存储没有找到函数声明的文件
    no_functions_files = []
    # 统计变量
    total_functions = 0
    pointer_count = 0
    
    # 遍历目录
    for root, dirs, files in os.walk(directory):
        for file in files:
            # 只处理.c和.h文件
            if file.endswith(('.c', '.h')):
                file_path = os.path.join(root, file)
                try:
                    with open(file_path, 'r', encoding='utf-8') as f:
                        content = f.read()
                        
                        # 查找所有匹配的函数声明
                        matches = list(re.finditer(pattern, content, re.DOTALL))
                        if matches:
                            for match in matches:
                                function_line = match.group().strip()
                                functions.append(f"File: {file_path}\nFunction: {function_line}\n")
                                
                                # 检查是否包含指针参数
                                if '*' in function_line:
                                    pointer_count += 1
                                    pointer_functions.append(f"File: {file_path}\nFunction: {function_line}\n")
                                total_functions += 1
                        else:
                            print(f"No function declarations found in: {file_path}")
                            no_functions_files.append(file_path)
                            
                except Exception as e:
                    print(f"Error reading {file_path}: {str(e)}")
    
    # 将结果写入输出文件
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("Function Declarations Found:\n\n")
        f.write('\n'.join(functions))
        
        # 添加统计信息
        f.write(f"\n\nStatistics:\n")
        f.write(f"Total functions: {total_functions}\n")
        f.write(f"Functions with pointer parameters: {pointer_count}\n")
        f.write(f"Percentage: {(pointer_count/total_functions*100):.2f}%\n")
        
        # 添加没有找到函数声明的文件列表
        if no_functions_files:
            f.write("\n\nFiles without function declarations:\n")
            for file in no_functions_files:
                f.write(f"{file}\n")
            print(f"Found {len(no_functions_files)} files without function declarations!")
    
    # 将带指针的函数声明写入单独的文件
    pointer_output_file = "pointer_functions.txt"
    with open(pointer_output_file, 'w', encoding='utf-8') as f:
        f.write("Functions with Pointer Parameters:\n\n")
        f.write('\n'.join(pointer_functions))
        f.write(f"\n\nTotal: {pointer_count} functions with pointer parameters\n")

# 使用示例
target_directory = "."  # 当前目录
output_file = "function_declarations.txt"
find_function_declarations(target_directory, output_file)