# This script reads function declarations from funcs.txt and generates test files
# Each test file includes:
# - Required headers
# - A main() function that creates a task
# - Symbolic variables for function arguments
# - A call to the target function
# - Control flags to restrict symbolic values

import os
import re

def process_function_declaration(declaration):
    # Skip empty declarations
    if not declaration.strip():
        return None
    
    # Validate function declaration format
    if '(' not in declaration or ')' not in declaration:
        print(f"Skipping invalid function declaration: {declaration}")
        return None

    # Extract return type and function name
    parts = declaration.split('(')[0].strip().split()
    func_name = parts[-1]  # Last word is the function name
    return_type = ' '.join(parts[:-1])  # Everything before the function name is return type

    # Extract parameter types and names
    args_str = declaration[declaration.find('(')+1:declaration.rfind(')')].strip()
    args = []
    arg_types = []
    
    if args_str and args_str != "void":
        # Split on commas that are not inside parameter types
        current_arg = ""
        paren_count = 0
        
        for char in args_str:
            if char == '(':
                paren_count += 1
            elif char == ')':
                paren_count -= 1
            elif char == ',' and paren_count == 0:
                args.append(current_arg.strip())
                current_arg = ""
                continue
            current_arg += char
            
        if current_arg:
            args.append(current_arg.strip())
            
        # Extract parameter names and types from full parameter declarations
        param_names = []
        param_types = []
        for arg in args:
            parts = arg.split()
            # Handle pointer parameters
            if '*' in arg:
                param_name = parts[-1].replace('*', '').strip()
                param_type = ' '.join(parts[:-1]) + ' *'
            else:
                param_name = parts[-1].strip()
                param_type = ' '.join(parts[:-1])
            # Remove any const or other qualifiers from name
            param_name = param_name.replace('const', '').strip()
            param_names.append(param_name)
            param_types.append(param_type)
        
        args = param_names
        arg_types = param_types
    
    # Skip if function name is empty
    if not func_name:
        print(f"Skipping function with empty name: {declaration}")
        return None
        
    return func_name, args, arg_types

# Read all lines from funcs.txt
with open('funcs.txt', 'r') as file:
    content = file.read()

# Split content into function declarations by looking for semicolons
declarations = []
current_decl = ""

for line in content.split('\n'):
    line = line.strip()
    current_decl += " " + line
    if ';' in line:
        declarations.append(current_decl.strip())
        current_decl = ""

# Create test_files directory if it doesn't exist
if not os.path.exists('test_files'):
    os.makedirs('test_files')

# Process each function declaration
for declaration in declarations:
    result = process_function_declaration(declaration)
    if result:
        func_name, args, arg_types = result
        # Generate test file name
        test_file = f'test_{func_name}.c'
        
        # Create test file
        with open(os.path.join('test_files', test_file), 'w') as file:
            # Write required headers
            file.write('#include "klee_help.h"\n')
            file.write('#include <FreeRTOS.h>\n')
            file.write('#include <task.h>\n')
            file.write('#include <queue.h>\n')
            file.write('#include <semphr.h>\n')
            file.write('#include <timers.h>\n')
            file.write('#include <event_groups.h>\n')
            file.write('#include <stream_buffer.h>\n\n')
            file.write('#include <klee/klee.h>\n')
            file.write('#include "wrappers.h"\n')
            # Write symbolic variable declarations
            file.write('void vTaskFunction1( void *pvParameters )\n')
            file.write('{\n')
            
            # Declare and make symbolic variables for each argument
            for i, (arg, arg_type) in enumerate(zip(args, arg_types)):
                if arg:  # Only process non-empty argument names
                    file.write(f'    {arg_type} KLEE_{arg};\n')
                    file.write(f'    klee_make_symbolic_controllable(&KLEE_{arg}, sizeof(KLEE_{arg}), "KLEE_{arg}", true);\n')
            
            # Write function call with symbolic variables
            if args:
                args_str = ', '.join(f'KLEE_{arg}' for arg in args if arg)
                file.write(f'    {func_name}({args_str});\n')
            else:
                file.write(f'    {func_name}();\n')
                
            file.write('    assert(0);\n')
            file.write('}\n\n')
            
            # Write main function
            file.write('#define STACK_SIZE 1000\n\n')
            file.write('int main()\n')
            file.write('{\n')
            file.write('    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);\n')
            file.write('    return 0;\n')
            file.write('}\n')


