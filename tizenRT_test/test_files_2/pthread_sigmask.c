#include "klee_help.h"
#include <signal.h>
#include <klee/klee.h>
#include "queue.h"
extern volatile dq_queue_t g_readytorun;
extern FAR struct tcb_s klee_tcb;
int main()
{
g_readytorun.head = (dq_entry_t*)&klee_tcb;
int KLEE_arg0;
FAR const sigset_t* KLEE_arg1;
FAR sigset_t* KLEE_arg2;
klee_make_symbolic_controllable(&KLEE_arg0, sizeof(KLEE_arg0), "KLEE_arg0", true);
klee_make_symbolic_controllable(&KLEE_arg1, sizeof(KLEE_arg1), "KLEE_arg1", true);
klee_make_symbolic_controllable(&KLEE_arg2, sizeof(KLEE_arg2), "KLEE_arg2", true);
pthread_sigmask(KLEE_arg0, KLEE_arg1, KLEE_arg2);

return 0;
}