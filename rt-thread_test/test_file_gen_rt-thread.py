import os
import re

output_dir = "test_files"
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

lwp_dir = "/home/klee/klee_src/test-rtos/rt-thread/components/lwp"
header_files = [f for f in os.listdir(lwp_dir) if f.endswith('.h')]

def extract_params(param_str):
    params = []
    param_str = param_str.strip()
    if not param_str or param_str.upper() == "VOID" or param_str == "void":
        return params

    # 移除编译器特定的属性
    param_str = re.sub(r'__attribute__\s*\([^)]*\)', '', param_str)
    param_str = re.sub(r'rt_weak', '', param_str)

    param_str_parts = [part.strip() for part in re.split(r',(?![^\(]*\))', param_str)]
    for segment in param_str_parts:
        # 处理如 "void *arg[]"
        m = re.match(r'(.+?[*\s])(\**)(\w+)(\[\s*\])?$', segment)
        if m:
            param_type = (m.group(1) + m.group(2)).replace('  ', ' ').strip()
            param_name = m.group(3).strip()
            if m.group(4):  # 如果有[]
                # 变长数组参数，转为指针类型
                param_type = param_type + ' *'
            params.append((param_type.strip(), param_name))
        else:
            # 兜底处理
            parts = segment.rsplit(' ', 1)
            if len(parts) == 2:
                params.append((parts[0].strip(), parts[1].strip()))
    return params

def generate_c_file(func_name, params, header_files, return_type):
    # 移除编译器特定的属性
    return_type = re.sub(r'__attribute__\s*\([^)]*\)', '', return_type)
    return_type = re.sub(r'rt_weak', '', return_type).strip()

    content = """/* RT-Thread System call */
#include <rtthread.h>
#include <rthw.h>
#include <board.h>
#include <string.h>
#include <stdint.h>
#include <rtdbg.h>
#include "syscall_generic.h"
#include "libc_musl.h"
#include "lwp_internal.h"
#include <mm_aspace.h>
#include <lwp_user_mm.h>
#include <lwp_arch.h>
#include <fcntl.h>
#include <sys/utsname.h>
#include <eventfd.h>
#include <poll.h>
#include <sys/epoll.h>
#include <sys/select.h>
#include <dfs_file.h>
#include <dfs_dentry.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/stat.h>
#include <sys/statfs.h>
#include <sys/timerfd.h>
#include <sys/ioctl.h>
#include <sys/signalfd.h>
#include "mqueue.h"
#include <netdev_ipaddr.h>
#include <netdev.h>
#include <sal_netdb.h>
#include <sal_socket.h>
#include <sys/socket.h>
#include "lwp_ipc_internal.h"
#include <sched.h>
#include <sys/sysinfo.h>
#include "lwp_arch_comm.h"
#include "lwp_signal.h"
#include "lwp_elf.h"
#include "lwp_sys_socket.h"
#include "lwp_futex_internal.h"
#include "lwp_mm.h"
#include "lwp_pid.h"
#include "lwp_dbg.h"
#include "lwp_args.h"
#include "lwp_avl.h"
#include "page.h"
#include "lwp_ipc.h"
#include "lwp_syscall.h"
#include "lwp.h"
#include "lwp_shm.h"

"""
    # 添加其他头文件
    for h in header_files:
        content += f'#include "{h}"\n'
    content += "#include \"klee/klee.h\"\n#include <stdio.h>\n\nint main()\n{\n"
    call_params = []
    for param_type, param_name in params:
        klee_var = f"KLEE_{param_name}"
        content += f"    {param_type} {klee_var};\n"
        content += f'    klee_make_symbolic_controllable(&{klee_var}, sizeof({klee_var}), "{klee_var}", true);\n'
        call_params.append(klee_var)
    args_str = ', '.join(call_params)
    # 返回值处理
    if return_type and return_type.strip() != "void":
        ret_var = f"KLEE_return_{func_name}"
        content += f"    {return_type} {ret_var};\n"
        content += f'    klee_make_symbolic_controllable(&{ret_var}, sizeof({ret_var}), "{ret_var}", true);\n'
        content += f"    {ret_var} = {func_name}({args_str});\n"
    else:
        content += f"    {func_name}({args_str});\n"
    content += '    return 0;\n'
    content += '}\n'
    return content

def extract_syscalls_from_file(file_path):
    syscalls = set()
    with open(file_path, 'r') as f:
        content = f.read()
        # 匹配函数定义，忽略编译器特定的属性
        func_pattern = re.compile(r'(\w[\w\s\*]+)\s+(sys_\w+)\s*\(([^)]*)\)')
        matches = func_pattern.finditer(content)
        for match in matches:
            return_type, func_name, param_str = match.groups()
            # 移除编译器特定的属性
            return_type = re.sub(r'__attribute__\s*\([^)]*\)', '', return_type)
            return_type = re.sub(r'rt_weak', '', return_type)
            syscalls.add((return_type.strip(), func_name, param_str))
    return syscalls

# 从.h和.c文件中提取syscall定义
h_syscalls = extract_syscalls_from_file(os.path.join(lwp_dir, 'lwp_syscall.h'))
c_syscalls = extract_syscalls_from_file(os.path.join(lwp_dir, 'lwp_syscall.c'))

# 合并两个文件中的syscall定义
all_syscalls = h_syscalls.union(c_syscalls)

count = 0
for return_type, func_name, param_str in all_syscalls:
    params = extract_params(param_str)
    c_content = generate_c_file(func_name, params, header_files, return_type)
    with open(os.path.join(output_dir, f"{func_name}.c"), 'w') as f:
        f.write(c_content)
    count += 1
print("done, total count: ", count)



