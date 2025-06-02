import os

def merge_files_in_subdirectories(root_dir, target_filename, output_filename):
    """
    遍历给定目录及其所有子目录，将找到的指定文件名的文件内容合并到一个新文件中。
    
    :param root_dir: 要搜索的根目录路径。
    :param target_filename: 要合并的文件的名称。
    :param output_filename: 合并后文件的名称。
    """
    # 确保输出文件是空的或不存在
    with open(output_filename, 'w') as f:
        pass

    for dirpath, dirnames, filenames in os.walk(root_dir):
        if target_filename in filenames:
            filepath = os.path.join(dirpath, target_filename)
            with open(filepath, 'r') as file_to_merge:
                content = file_to_merge.read()
                # 追加内容到输出文件
                with open(output_filename, 'a') as output_file:
                    output_file.write(content + "\n")

# 使用示例
root_dir = '/home/klee/FreeRTOS-Kernel-10.6.0/symbolic_execution/output'  # 这里替换成你的目录路径
target_filename = 'test_info.txt'  # 这里替换成你要合并的文件名
output_filename = 'merged_freertos_10_6_0_text_info.txt'  # 合并后的文件将保存为这个名字

merge_files_in_subdirectories(root_dir, target_filename, output_filename)
