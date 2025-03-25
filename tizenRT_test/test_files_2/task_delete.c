#include "klee_help.h"
#include <sched.h>
#include <klee/klee.h>
#include "queue.h"
extern volatile dq_queue_t g_readytorun;
extern FAR struct tcb_s klee_tcb;
int main()
{
g_readytorun.head = (dq_entry_t*)&klee_tcb;
pid_t KLEE_arg0;
klee_make_symbolic_controllable(&KLEE_arg0, sizeof(KLEE_arg0), "KLEE_arg0", true);
task_delete(KLEE_arg0);

return 0;
}