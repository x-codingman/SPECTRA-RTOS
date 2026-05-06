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
    const char * KLEE_name;
    klee_make_symbolic_controllable(&KLEE_name, sizeof(KLEE_name), "KLEE_name", true);
    int KLEE_af;
    klee_make_symbolic_controllable(&KLEE_af, sizeof(KLEE_af), "KLEE_af", true);
    struct hostent * KLEE_ret;
    klee_make_symbolic_controllable(&KLEE_ret, sizeof(KLEE_ret), "KLEE_ret", true);
    char * KLEE_buf;
    klee_make_symbolic_controllable(&KLEE_buf, sizeof(KLEE_buf), "KLEE_buf", true);
    size_t KLEE_buflen;
    klee_make_symbolic_controllable(&KLEE_buflen, sizeof(KLEE_buflen), "KLEE_buflen", true);
    struct hostent ** KLEE_result;
    klee_make_symbolic_controllable(&KLEE_result, sizeof(KLEE_result), "KLEE_result", true);
    int * KLEE_err;
    klee_make_symbolic_controllable(&KLEE_err, sizeof(KLEE_err), "KLEE_err", true);
    define HOSTENT_BUFSZ   512
sysret_t KLEE_return_sys_gethostbyname2_r;
    klee_make_symbolic_controllable(&KLEE_return_sys_gethostbyname2_r, sizeof(KLEE_return_sys_gethostbyname2_r), "KLEE_return_sys_gethostbyname2_r", true);
    KLEE_return_sys_gethostbyname2_r = sys_gethostbyname2_r(KLEE_name, KLEE_af, KLEE_ret, KLEE_buf, KLEE_buflen, KLEE_result, KLEE_err);
    return 0;
}
