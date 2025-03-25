#include "klee_help.h"
#include <sys/socket.h>
#include <klee/klee.h>
#include "queue.h"
extern volatile dq_queue_t g_readytorun;
extern FAR struct tcb_s klee_tcb;
int main()
{
g_readytorun.head = (dq_entry_t*)&klee_tcb;
int KLEE_arg0;
FAR const void* KLEE_arg1;
size_t KLEE_arg2;
int KLEE_arg3;
FAR const struct sockaddr* KLEE_arg4;
socklen_t KLEE_arg5;
klee_make_symbolic_controllable(&KLEE_arg0, sizeof(KLEE_arg0), "KLEE_arg0", true);
klee_make_symbolic_controllable(&KLEE_arg1, sizeof(KLEE_arg1), "KLEE_arg1", true);
klee_make_symbolic_controllable(&KLEE_arg2, sizeof(KLEE_arg2), "KLEE_arg2", true);
klee_make_symbolic_controllable(&KLEE_arg3, sizeof(KLEE_arg3), "KLEE_arg3", true);
klee_make_symbolic_controllable(&KLEE_arg4, sizeof(KLEE_arg4), "KLEE_arg4", true);
klee_make_symbolic_controllable(&KLEE_arg5, sizeof(KLEE_arg5), "KLEE_arg5", true);
sendto(KLEE_arg0, KLEE_arg1, KLEE_arg2, KLEE_arg3, KLEE_arg4, KLEE_arg5);

return 0;
}