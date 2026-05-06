import hashlib
import os
import re
from pathlib import Path

_REPO = Path(__file__).resolve().parents[2]
directory = str(_REPO / "test-rtos" / "tizenrt" / "apps" / "examples")

defines = []


def balance_brackets(s):
    """If '(' count exceeds ')', trim from the last unmatched '(' onward."""
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


hashes = set()


def remove_comments(content):
    content = re.sub(r'//.*', '', content)
    content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)
    return content


for foldername, _, filenames in os.walk(directory):
    for filename in filenames:
        if filename.endswith('.c') or filename.endswith('.h'):
            filepath = os.path.join(foldername, filename)
            with open(filepath, 'r', encoding='utf-8', errors='ignore') as file:
                file_content = file.read()
                file_content = remove_comments(file_content)
                matches = re.findall(r"#define [^\n]*", file_content)
                for match in matches:
                    match = match.rstrip('\\')
                    match = balance_brackets(match)
                    macro_name = match.split(' ')[1]
                    hash_value = hashlib.md5(macro_name.encode()).hexdigest()
                    if hash_value not in hashes:
                        defines.append(match)
                        hashes.add(hash_value)

formatted_defines = "\n".join(defines)

with open('macro_all.h', 'w', encoding='utf-8') as output_file:
    output_file.write(formatted_defines)
