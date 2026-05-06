#include "klee_help.h"
#include <sys/select.h>
#include <klee/klee.h>
#include "queue.h"
extern volatile dq_queue_t g_readytorun;
extern FAR struct tcb_s klee_tcb;
int main()
{
g_readytorun.head = (dq_entry_t*)&klee_tcb;
int KLEE_arg0;
FAR fd_set* KLEE_arg1;
FAR fd_set* KLEE_arg2;
FAR fd_set* KLEE_arg3;
FAR struct timeval* KLEE_arg4;
klee_make_symbolic_controllable(&KLEE_arg0, sizeof(KLEE_arg0), "KLEE_arg0", true);
klee_make_symbolic_controllable(&KLEE_arg1, sizeof(KLEE_arg1), "KLEE_arg1", true);
klee_make_symbolic_controllable(&KLEE_arg2, sizeof(KLEE_arg2), "KLEE_arg2", true);
klee_make_symbolic_controllable(&KLEE_arg3, sizeof(KLEE_arg3), "KLEE_arg3", true);
klee_make_symbolic_controllable(&KLEE_arg4, sizeof(KLEE_arg4), "KLEE_arg4", true);
select(KLEE_arg0, KLEE_arg1, KLEE_arg2, KLEE_arg3, KLEE_arg4);

return 0;
}