import os
import re

output_dir = "test_files"
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

def extract_params(param_str):
    params = []
    param_str = param_str.strip()
    if param_str.upper() == "VOID":  # Special handling for VOID type
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
#generate the declaration of the function
#Change the func_name to _txm_module_manager_tx_"+func_name+"_dispatch
# Add a first parameter TXM_MODULE_INSTANCE *module_instance
# The last parameter end without a comma
# If parameters are more than 3, add a extra_parameters array
    # If parameters are more than 3, add an extra_parameters array
    # if len(params) > 3:
    #     # Only first 2 params are passed directly, rest go into extra_parameters
    #     content += f'ALIGN_TYPE _txm_module_manager_tx_{func_name}_dispatch(TXM_MODULE_INSTANCE *module_instance'
    #     if params:
    #         # Add first two parameters (if present)
    #         for i, (param_type, param_name) in enumerate(params[:2]):
    #             content += f', {param_type} {param_name}'
    #         # Always add the extra_parameters array as the last parameter
    #         extra_size = len(params) - 2
    #         content += f', ALIGN_TYPE *extra_parameters'
    #     content += ');\n\n'
    # else:
    #     content += f'ALIGN_TYPE _txm_module_manager_tx_{func_name}_dispatch(TXM_MODULE_INSTANCE *module_instance'
    #     if params:
    #         content += ', '
    #         for i, (param_type, param_name) in enumerate(params):
    #             if i == len(params) - 1:
    #                 content += f'{param_type} {param_name}'
    #             else:
    #                 content += f'{param_type} {param_name}, '
    #     content += ');\n\n'

    content += 'extern TX_THREAD *    _tx_thread_current_ptr;\n\n'
    #content += '_tx_thread_current_ptr -> tx_thread_module_instance_ptr->txm_module_instance_property_flags |= TXM_MODULE_MEMORY_PROTECTION;\n\n'
    content += 'UCHAR                   pool_start[9120];\n\n'
    content += 'int main()\n{\n'
    content += '    _txm_module_manager_object_pool_created = true;\n'
    content += '    klee_make_symbolic_controllable(&_tx_thread_current_ptr, sizeof(_tx_thread_current_ptr), "_tx_thread_current_ptr", false);\n'
    #content += '    _txm_module_kernel_call_dispatcher=_txm_module_manager_kernel_dispatch;\n'
    content += '    TXM_MODULE_INSTANCE *module_instance = _tx_thread_current_ptr -> tx_thread_module_instance_ptr;\n'
    call_params = ['module_instance']
    extra_params = []

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

    func_call = "{}({});".format("_txm_module_manager_tx_"+func_name+"_dispatch", ', '.join(call_params))
    content += f'    {func_call}\n'
    content += '}\n'
    return content

with open('funcs.txt', 'r') as f:
    content = f.read().splitlines()

for line in content:
    match = re.match(r'(.+)\s+_txe_(\w+)\((.*)\);', line)
    if match:
        return_type, func_name, param_str = match.groups()
        params = extract_params(param_str)
        
        c_content = generate_c_file(func_name, params, return_type)
        with open(os.path.join(output_dir, f"{func_name}.c"), 'w') as f:
            f.write(c_content)
