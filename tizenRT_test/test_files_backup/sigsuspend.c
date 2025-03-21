#include "klee_help.h"
#include <signal.h>
#include <klee/klee.h>
#include "queue.h"
extern volatile dq_queue_t g_readytorun;
extern FAR struct tcb_s klee_tcb;
int main()
{
g_readytorun.head = (dq_entry_t*)&klee_tcb;
FAR const sigset_t* arg0;
klee_make_symbolic_controllable(&arg0, sizeof(arg0), "arg0", true);
sigsuspend(arg0);

return 0;
}