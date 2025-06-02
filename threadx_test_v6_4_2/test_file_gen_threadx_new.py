import os
import re

output_dir = "test_files"
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

def extract_params(param_str):
    params = []
    param_str = param_str.strip()
    if param_str.upper() == "VOID" or param_str == "":  # Special handling for VOID type or empty
        return params

    param_str_parts = [part.strip() for part in param_str.split(",")]
    buffer = ""

    for segment in param_str_parts:
        if not buffer:
            buffer = segment
        else:
            buffer += ", " + segment

        open_brackets = buffer.count('(')
        close_brackets = buffer.count(')')
        
        if open_brackets == close_brackets:  # when we have a complete parameter
            segment = buffer
            buffer = ""

            if "(" in segment and ")" in segment and "(*" in segment:  # Function pointer
                func_ptr_decl = segment
                match = re.search(r'\(\*(\w+)\)', func_ptr_decl)
                if match:
                    func_ptr_name = match.group(1)
                    params.append((func_ptr_decl, func_ptr_name))
            else:
                type_name, var_name = re.match(r'(\w+(?:\s*\*\s*\*?)?)\s*(\w+)', segment).groups()
                param_type = type_name.strip()
                param_name = "KLEE_TX_"+var_name.strip()
                params.append((param_type, param_name))

    return params

def generate_c_file(func_name, params, return_type):
    content = '''#include "tx_api.h"
#include "txm_module.h"
#include "klee/klee.h"
#include "klee_help.h"\n\n'''
    content += 'extern TX_THREAD *    _tx_thread_current_ptr;\n\n'
    content += 'UCHAR                   pool_start[9120];\n\n'
    content += 'int main()\n{\n'
    content += '    _txm_module_manager_object_pool_created = true;\n'
    content += '    klee_make_symbolic_controllable(&_tx_thread_current_ptr, sizeof(_tx_thread_current_ptr), "_tx_thread_current_ptr", false);\n'
    content += '    TXM_MODULE_INSTANCE *module_instance = _tx_thread_current_ptr -> tx_thread_module_instance_ptr;\n'
    call_params = ['module_instance']
    for param_type, param_name in params:
        if '(' in param_type:  # If it's a function pointer
            content += f"    {param_type};\n"
            call_params.append(param_name)
            content += f'    klee_make_symbolic_controllable(&{param_name}, sizeof({param_name}), "{param_name}", true);\n'
        else:
            if(param_name != 'pool_start'):
                content += f"    {param_type} {param_name};\n"
                content += f'    klee_make_symbolic_controllable(&{param_name}, sizeof({param_name}), "{param_name}", true);\n'
            call_params.append(param_name)
    if len(params) > 3:
        extra_size = len(params) - 2
        content += f'    ALIGN_TYPE extra_parameters[{extra_size}];\n'
        index = 0
        for param_type, param_name in params[2:]:
            content += f'    extra_parameters[{index}] = (ALIGN_TYPE) {param_name};\n'
            index += 1
        call_params[:] = call_params[:3]
        call_params.append('extra_parameters')
    # 处理函数名前缀
    dispatch_name = func_name
    if func_name.startswith('_tx_'):
        dispatch_name = func_name[4:]  # 去掉_tx_前缀
    elif func_name.startswith('_txe_'):
        dispatch_name = func_name[5:]  # 去掉_txe_前缀
    elif func_name.startswith('_txm_'):
        dispatch_name = func_name[5:]  # 去掉_txm_前缀
    func_call = "{}({});".format("_txm_module_manager_tx_"+dispatch_name+"_dispatch", ', '.join(call_params))
    content += f'    {func_call}\n'
    content += '}\n'
    return content

with open('funcs_new.txt', 'r') as f:
    content = f.read().splitlines()

for line in content:
    line = line.strip()
    if not line or line.startswith('//'):
        continue
    # 兼容各种声明格式
    match = re.match(r'([\w\s\*]+?)\s+(\w+)\s*\((.*)\)\s*;?$', line)
    if match:
        return_type, func_name, param_str = match.groups()
        params = extract_params(param_str)
        c_content = generate_c_file(func_name, params, return_type)
        # 处理文件名，去掉前缀
        file_name = func_name
        if func_name.startswith('_tx_'):
            file_name = func_name[4:]  # 去掉_tx_前缀
        elif func_name.startswith('_txe_'):
            file_name = func_name[5:]  # 去掉_txe_前缀
        elif func_name.startswith('_txm_'):
            file_name = func_name[5:]  # 去掉_txm_前缀
        with open(os.path.join(output_dir, f"{file_name}.c"), 'w') as f:
            f.write(c_content) 