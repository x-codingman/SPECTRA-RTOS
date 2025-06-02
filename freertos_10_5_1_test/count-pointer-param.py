import re

func_decl_pattern = re.compile(
    r'^\s*([\w\s\*\d_]+)\s+(\w+)\s*\(([^)]*)\)\s*;', re.MULTILINE)

total_func_count = 0
pointer_func_count = 0
no_pointer_func_names = []

with open('funcs.txt', 'r') as f:
    content = f.read()

matches = func_decl_pattern.findall(content)
total_func_count = len(matches)

def is_pointer_param(param):
    # 只要有*，或者类型/名字以Handle_t结尾，都算指针
    if not param or param.lower() == 'void':
        return False
    # 拆分类型和名字
    parts = param.strip().rsplit(' ', 1)
    type_part = parts[0] if len(parts) > 1 else param.strip()
    name_part = parts[1] if len(parts) > 1 else ''
    # 检查*，Handle_t结尾，_t*结尾等
    return (
        '*' in type_part
        or type_part.endswith('Handle_t')
        or name_part.endswith('Handle_t')
        or re.search(r'_t\s*\*$', type_part)
        or re.search(r'_t\s*\*$', name_part)
    )

for return_type, func_name, params in matches:
    param_list = [p.strip() for p in params.split(',') if p.strip() and p.strip().lower() != 'void']
    if any(is_pointer_param(p) for p in param_list):
        pointer_func_count += 1
    else:
        no_pointer_func_names.append(func_name)

print(f"Total number of function declarations: {total_func_count}")
print(f"Number of functions with pointer parameters: {pointer_func_count}")
print(f"Ratio: {pointer_func_count/total_func_count:.2%}")
print("\nFunctions WITHOUT pointer parameters:")
for name in no_pointer_func_names:
    print(name)