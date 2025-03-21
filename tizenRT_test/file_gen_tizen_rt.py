import csv
import os
import re

OUTPUT_DIR = './test_files/'
CSV_FILE = 'syscall.csv'
CONFIG_FILE = '/home/klee/TizenRT/os/include/tinyara/config.h'

def handle_macro_condition(macro_condition):
    defines = []
    undefines = []
    condition_checks = []

    # Pattern for 'defined' and '!defined'
    for match in re.findall(r'\bdefined\(([^)]+)\)', macro_condition):
        defines.append(match.strip())
    for match in re.findall(r'!defined\(([^)]+)\)', macro_condition):
        undefines.append(match.strip())

    # Pattern for conditions like CONFIG_NFILE_DESCRIPTORS > 0
    for match in re.findall(r'([A-Z_]+) ([<>!=]+ \d+)', macro_condition):
        macro_name, condition = match
        defines.append(f"{macro_name.strip()} 1")  # Define the macro with a value of 1
        condition_checks.append(f"{macro_name.strip()} {condition.strip()}")

    return defines, undefines, " && ".join(condition_checks)


def generate_c_file(func, defines, undefines):
    function_name = func[0].replace('"', '').strip()
    includes = func[1].replace('"', '').strip()
    return_type = func[3].replace('"', '').strip()
    parameters = [p.replace('"', '').strip() for p in func[4:]]

    args_with_type = [f"{t} arg{i}" for i, t in enumerate(parameters) if t]
    function_call = f"{function_name}({', '.join([f'arg{i}' for i in range(len(args_with_type))])});\n"

    content = []
    content.append('#include "klee_help.h"')
    content.append(f'#include <{includes}>')
    content.append('#include <klee/klee.h>')
    content.append('#include "queue.h"')
    content.append('extern volatile dq_queue_t g_readytorun;')
    content.append('extern FAR struct tcb_s klee_tcb;')
    content.append('int main()')
    content.append('{')
    
    content.append('g_readytorun.head = (dq_entry_t*)&klee_tcb;')
    content.append('\n'.join([f"{t};" for t in args_with_type]))
    for i in range(len(args_with_type)):
        content.append(f'klee_make_symbolic_controllable(&arg{i}, sizeof(arg{i}), "arg{i}", true);')
    content.append(function_call)
    content.append('return 0;')
    content.append('}')

    with open(os.path.join(OUTPUT_DIR, f"{function_name}.c"), 'w') as file:
        file.write('\n'.join(content))


def main():
    if not os.path.exists(OUTPUT_DIR):
        os.makedirs(OUTPUT_DIR)

    all_defines = set()
    all_undefines = set()

    with open(CSV_FILE, 'r') as file:
        reader = csv.reader(file)
        for row in reader:
            defines, undefines, _ = handle_macro_condition(row[2].replace('"', '').strip())
            all_defines.update(defines)
            all_undefines.update(undefines)

    # Remove any defines that are also in undefines
    all_defines = all_defines.difference(all_undefines)

    with open(CONFIG_FILE, 'a') as config_file:
        config_file.write("\n// Appended by script\n")
        for d in all_defines:
            config_file.write(f"#define {d}\n")
        for u in all_undefines:
            config_file.write(f"#undef {u}\n")

    with open(CSV_FILE, 'r') as file:
        reader = csv.reader(file)
        for row in reader:
            generate_c_file(row, all_defines, all_undefines)


if __name__ == '__main__':
    main()
