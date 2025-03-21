#include "klee_help.h"
#include <sys/socket.h>
#include <klee/klee.h>
#include "queue.h"
extern volatile dq_queue_t g_readytorun;
extern FAR struct tcb_s klee_tcb;
int main()
{
g_readytorun.head = (dq_entry_t*)&klee_tcb;
int arg0;
FAR const void* arg1;
size_t arg2;
int arg3;
FAR const struct sockaddr* arg4;
socklen_t arg5;
klee_make_symbolic_controllable(&arg0, sizeof(arg0), "arg0", true);
klee_make_symbolic_controllable(&arg1, sizeof(arg1), "arg1", true);
klee_make_symbolic_controllable(&arg2, sizeof(arg2), "arg2", true);
klee_make_symbolic_controllable(&arg3, sizeof(arg3), "arg3", true);
klee_make_symbolic_controllable(&arg4, sizeof(arg4), "arg4", true);
klee_make_symbolic_controllable(&arg5, sizeof(arg5), "arg5", true);
sendto(arg0, arg1, arg2, arg3, arg4, arg5);

return 0;
}