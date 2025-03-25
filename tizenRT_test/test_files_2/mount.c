#include "klee_help.h"
#include <sys/mount.h>
#include <klee/klee.h>
#include "queue.h"
extern volatile dq_queue_t g_readytorun;
extern FAR struct tcb_s klee_tcb;
int main()
{
g_readytorun.head = (dq_entry_t*)&klee_tcb;
const char* KLEE_arg0;
const char* KLEE_arg1;
const char* KLEE_arg2;
unsigned long KLEE_arg3;
const void* KLEE_arg4;
klee_make_symbolic_controllable(&KLEE_arg0, sizeof(KLEE_arg0), "KLEE_arg0", true);
klee_make_symbolic_controllable(&KLEE_arg1, sizeof(KLEE_arg1), "KLEE_arg1", true);
klee_make_symbolic_controllable(&KLEE_arg2, sizeof(KLEE_arg2), "KLEE_arg2", true);
klee_make_symbolic_controllable(&KLEE_arg3, sizeof(KLEE_arg3), "KLEE_arg3", true);
klee_make_symbolic_controllable(&KLEE_arg4, sizeof(KLEE_arg4), "KLEE_arg4", true);
mount(KLEE_arg0, KLEE_arg1, KLEE_arg2, KLEE_arg3, KLEE_arg4);

return 0;
}