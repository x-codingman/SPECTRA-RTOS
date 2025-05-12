# 使用 clang 编译 lwp_syscall.c 为 lwp_syscall.bc（LLVM bitcode）

# RT-Thread 源码根目录（可自定义）
RTT_ROOT = /home/klee/klee_src/test-rtos/rt-thread

# 工具链
CC = clang

# 源文件
SRC = $(RTT_ROOT)/components/lwp/lwp_syscall.c

# 目标文件
OBJ = lwp_syscall.bc

# 头文件路径（根据 scons 输出整理，部分路径可根据实际情况删减或补充）
INCLUDES = -I$(RTT_ROOT)/components/dfs/dfs_v2/include \
-I$(RTT_ROOT)/components/drivers/include \
-I$(RTT_ROOT)/components/drivers/include/drivers \
-I$(RTT_ROOT)/components/drivers/include/drivers/classes \
-I$(RTT_ROOT)/components/drivers/include/drivers/core \
-I$(RTT_ROOT)/components/drivers/include/dt-bindings/thermal \
-I$(RTT_ROOT)/components/drivers/include/ipc \
-I$(RTT_ROOT)/components/drivers/pci \
-I$(RTT_ROOT)/components/drivers/phy \
-I$(RTT_ROOT)/components/finsh \
-I$(RTT_ROOT)/components/libc/compilers/common/include \
-I$(RTT_ROOT)/components/libc/compilers/common/include/sys \
-I$(RTT_ROOT)/components/libc/compilers/musl \
-I$(RTT_ROOT)/components/libc/posix/io/eventfd \
-I$(RTT_ROOT)/components/libc/posix/io/poll \
-I$(RTT_ROOT)/components/libc/posix/ipc \
-I$(RTT_ROOT)/components/lwp \
-I$(RTT_ROOT)/components/lwp/arch/arm/cortex-a \
-I$(RTT_ROOT)/components/mm \
-I$(RTT_ROOT)/components/net/netdev/include \
-I$(RTT_ROOT)/components/net/netdev/include/arpa \
-I$(RTT_ROOT)/components/net/sal/include \
-I$(RTT_ROOT)/components/net/sal/include/socket/sys_socket/sys \
-I$(RTT_ROOT)/components/utilities/libadt/avl \
-I$(RTT_ROOT)/components/utilities/libadt/bitmap \
-I$(RTT_ROOT)/components/utilities/libadt/ref \
-I$(RTT_ROOT)/include \
-I$(RTT_ROOT)/include/klibc \
-I$(RTT_ROOT)/libcpu/arm/cortex-a \
-I$(RTT_ROOT)/bsp/qemu-vexpress-a9/drivers \
-I$(RTT_ROOT)/bsp/qemu-vexpress-a9 \
-I$(RTT_ROOT)/components/libc/compilers/common/extension \
-I$(RTT_ROOT)/components/legacy \
-I.

# 编译选项（生成LLVM bitcode）
CFLAGS = -shared -Wl,--unresolved-symbols=ignore-all -emit-llvm -c -O2 -Wall -g -std=gnu99 -D__GNUC__=4 -Du32='uint32_t' \
    -isystem $(RTT_ROOT)/components/libc/compilers/common/include \
    -isystem $(RTT_ROOT)/components/libc/compilers/musl/include

# 目标规则
$(OBJ): $(SRC)
	$(CC) $(CFLAGS) $(INCLUDES) $< -o $@

.PHONY: clean
clean:
	rm -f $(OBJ)
