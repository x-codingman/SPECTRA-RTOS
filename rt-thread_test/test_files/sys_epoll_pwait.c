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
    int KLEE_fd;
    klee_make_symbolic_controllable(&KLEE_fd, sizeof(KLEE_fd), "KLEE_fd", true);
    struct epoll_event * KLEE_ev;
    klee_make_symbolic_controllable(&KLEE_ev, sizeof(KLEE_ev), "KLEE_ev", true);
    int KLEE_cnt;
    klee_make_symbolic_controllable(&KLEE_cnt, sizeof(KLEE_cnt), "KLEE_cnt", true);
    int KLEE_to;
    klee_make_symbolic_controllable(&KLEE_to, sizeof(KLEE_to), "KLEE_to", true);
    const sigset_t * KLEE_sigs;
    klee_make_symbolic_controllable(&KLEE_sigs, sizeof(KLEE_sigs), "KLEE_sigs", true);
    unsigned long KLEE_sigsetsize;
    klee_make_symbolic_controllable(&KLEE_sigsetsize, sizeof(KLEE_sigsetsize), "KLEE_sigsetsize", true);
    sysret_t KLEE_return_sys_epoll_pwait;
    klee_make_symbolic_controllable(&KLEE_return_sys_epoll_pwait, sizeof(KLEE_return_sys_epoll_pwait), "KLEE_return_sys_epoll_pwait", true);
    KLEE_return_sys_epoll_pwait = sys_epoll_pwait(KLEE_fd, KLEE_ev, KLEE_cnt, KLEE_to, KLEE_sigs, KLEE_sigsetsize);
    return 0;
}
