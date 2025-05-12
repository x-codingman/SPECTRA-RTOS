/* RT-Thread System call */
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

#include "lwp_arch_comm.h"
#include "lwp_signal.h"
#include "lwp_elf.h"
#include "lwp_sys_socket.h"
#include "lwp_futex_internal.h"
#include "lwp_mm.h"
#include "lwp_pid.h"
#include "libc_musl.h"
#include "lwp_dbg.h"
#include "lwp_ipc_internal.h"
#include "lwp_user_mm.h"
#include "lwp_args.h"
#include "lwp_avl.h"
#include "page.h"
#include "syscall_generic.h"
#include "lwp_ipc.h"
#include "lwp_syscall.h"
#include "lwp.h"
#include "lwp_internal.h"
#include "lwp_shm.h"
#include "klee/klee.h"
#include <stdio.h>

int main()
{
    int * KLEE_uaddr;
    klee_make_symbolic_controllable(&KLEE_uaddr, sizeof(KLEE_uaddr), "KLEE_uaddr", true);
    int KLEE_op;
    klee_make_symbolic_controllable(&KLEE_op, sizeof(KLEE_op), "KLEE_op", true);
    int KLEE_val;
    klee_make_symbolic_controllable(&KLEE_val, sizeof(KLEE_val), "KLEE_val", true);
    const struct timespec * KLEE_timeout;
    klee_make_symbolic_controllable(&KLEE_timeout, sizeof(KLEE_timeout), "KLEE_timeout", true);
    int * KLEE_uaddr2;
    klee_make_symbolic_controllable(&KLEE_uaddr2, sizeof(KLEE_uaddr2), "KLEE_uaddr2", true);
    int KLEE_val3;
    klee_make_symbolic_controllable(&KLEE_val3, sizeof(KLEE_val3), "KLEE_val3", true);
    ifdef ARCH_MM_MMU
sysret_t KLEE_return_sys_futex;
    klee_make_symbolic_controllable(&KLEE_return_sys_futex, sizeof(KLEE_return_sys_futex), "KLEE_return_sys_futex", true);
    KLEE_return_sys_futex = sys_futex(KLEE_uaddr, KLEE_op, KLEE_val, KLEE_timeout, KLEE_uaddr2, KLEE_val3);
    return 0;
}
