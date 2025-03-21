import os
import re
import hashlib
# 定义要扫描的目录
directory = "/home/klee/tizenrt/apps/examples"


# 初始化一个空列表来存储提取到的#define语句
defines = []
def balance_brackets(s):
    """如果在字符串中左括号数量多于右括号，删除最后一个左括号及其后的所有内容"""
    count = 0
    last_open_index = -1
    for i, c in enumerate(s):
        if c == '(':
            count += 1
            last_open_index = i
        elif c == ')':
            count -= 1
    if count > 0 and last_open_index != -1:
        return s[:last_open_index]
    return s
# 初始化一个集合来存储已经处理过的宏名称的哈希值
hashes = set()

def remove_comments(content):
    # 移除单行注释
    content = re.sub(r'//.*', '', content)
    # 移除多行注释
    content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)
    return content



# 遍历目录和子目录中的所有文件
for foldername, _, filenames in os.walk(directory):
    for filename in filenames:
        if filename.endswith('.c') or filename.endswith('.h'):
            filepath = os.path.join(foldername, filename)
            with open(filepath, 'r', encoding='utf-8', errors='ignore') as file:
                file_content = file.read()
                # 移除注释
                file_content = remove_comments(file_content)
                matches = re.findall(r"#define [^\n]*", file_content)
                for match in matches:
                    match = match.rstrip('\\')
                    match = balance_brackets(match)
                    
                    # 计算哈希值
                    macro_name = match.split(' ')[1]
                    hash_value = hashlib.md5(macro_name.encode()).hexdigest()

                    # 检查哈希值是否已经存在
                    if hash_value not in hashes:
                        defines.append(match)
                        hashes.add(hash_value)

formatted_defines = "\n".join(defines)

# 将格式化后的宏定义写入macro_all.h文件中
with open('macro_all.h', 'w',encoding='utf-8') as output_file:
    output_file.write(formatted_defines)