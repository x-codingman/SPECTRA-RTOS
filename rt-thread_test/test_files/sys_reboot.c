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
    int KLEE_magic;
    klee_make_symbolic_controllable(&KLEE_magic, sizeof(KLEE_magic), "KLEE_magic", true);
    int KLEE_magic2;
    klee_make_symbolic_controllable(&KLEE_magic2, sizeof(KLEE_magic2), "KLEE_magic2", true);
    int KLEE_type;
    klee_make_symbolic_controllable(&KLEE_type, sizeof(KLEE_type), "KLEE_type", true);
    void * KLEE_arg;
    klee_make_symbolic_controllable(&KLEE_arg, sizeof(KLEE_arg), "KLEE_arg", true);
    endif

sysret_t KLEE_return_sys_reboot;
    klee_make_symbolic_controllable(&KLEE_return_sys_reboot, sizeof(KLEE_return_sys_reboot), "KLEE_return_sys_reboot", true);
    KLEE_return_sys_reboot = sys_reboot(KLEE_magic, KLEE_magic2, KLEE_type, KLEE_arg);
    return 0;
}
