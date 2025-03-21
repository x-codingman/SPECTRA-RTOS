#include "klee_help.h"
#include <sched.h>
#include <klee/klee.h>
#include "queue.h"
extern volatile dq_queue_t g_readytorun;
extern FAR struct tcb_s klee_tcb;
int main()
{
g_readytorun.head = (dq_entry_t*)&klee_tcb;
FAR const char* arg0;
int arg1;
int arg2;
main_t arg3;
FAR char * const  arg4;
klee_make_symbolic_controllable(&arg0, sizeof(arg0), "arg0", true);
klee_make_symbolic_controllable(&arg1, sizeof(arg1), "arg1", true);
klee_make_symbolic_controllable(&arg2, sizeof(arg2), "arg2", true);
klee_make_symbolic_controllable(&arg3, sizeof(arg3), "arg3", true);
klee_make_symbolic_controllable(&arg4, sizeof(arg4), "arg4", true);
task_create(arg0, arg1, arg2, arg3, arg4);

return 0;
}