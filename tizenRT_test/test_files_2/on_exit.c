#include "klee_help.h"
#include <stdlib.h>
#include <klee/klee.h>
#include "queue.h"
extern volatile dq_queue_t g_readytorun;
extern FAR struct tcb_s klee_tcb;
int main()
{
g_readytorun.head = (dq_entry_t*)&klee_tcb;
// CODE void (*)(int KLEE_arg0;
// FAR void *) KLEE_arg1;
// FAR void * KLEE_arg2;
// klee_make_symbolic_controllable(&KLEE_arg0, sizeof(KLEE_arg0), "KLEE_arg0", true);
// klee_make_symbolic_controllable(&KLEE_arg1, sizeof(KLEE_arg1), "KLEE_arg1", true);
// klee_make_symbolic_controllable(&KLEE_arg2, sizeof(KLEE_arg2), "KLEE_arg2", true);
// on_exit(KLEE_arg0, KLEE_arg1, KLEE_arg2);

return 0;
}