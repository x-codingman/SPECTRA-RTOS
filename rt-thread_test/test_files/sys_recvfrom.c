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
    int KLEE_socket;
    klee_make_symbolic_controllable(&KLEE_socket, sizeof(KLEE_socket), "KLEE_socket", true);
    void * KLEE_mem;
    klee_make_symbolic_controllable(&KLEE_mem, sizeof(KLEE_mem), "KLEE_mem", true);
    size_t KLEE_len;
    klee_make_symbolic_controllable(&KLEE_len, sizeof(KLEE_len), "KLEE_len", true);
    int KLEE_flags;
    klee_make_symbolic_controllable(&KLEE_flags, sizeof(KLEE_flags), "KLEE_flags", true);
    struct musl_sockaddr * KLEE_from;
    klee_make_symbolic_controllable(&KLEE_from, sizeof(KLEE_from), "KLEE_from", true);
    socklen_t * KLEE_fromlen;
    klee_make_symbolic_controllable(&KLEE_fromlen, sizeof(KLEE_fromlen), "KLEE_fromlen", true);
    sysret_t KLEE_return_sys_recvfrom;
    klee_make_symbolic_controllable(&KLEE_return_sys_recvfrom, sizeof(KLEE_return_sys_recvfrom), "KLEE_return_sys_recvfrom", true);
    KLEE_return_sys_recvfrom = sys_recvfrom(KLEE_socket, KLEE_mem, KLEE_len, KLEE_flags, KLEE_from, KLEE_fromlen);
    return 0;
}
