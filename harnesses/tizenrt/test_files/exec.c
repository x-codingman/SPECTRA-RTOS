#include "klee_help.h"
#include <tinyara/binfmt/binfmt.h>
#include <klee/klee.h>
#include "queue.h"
extern volatile dq_queue_t g_readytorun;
extern FAR struct tcb_s klee_tcb;
int main()
{
g_readytorun.head = (dq_entry_t*)&klee_tcb;
FAR const char * KLEE_arg0;
FAR char * const * KLEE_arg1;
FAR const struct symtab_s * KLEE_arg2;
int KLEE_arg3;
klee_make_symbolic_controllable(&KLEE_arg0, sizeof(KLEE_arg0), "KLEE_arg0", true);
klee_make_symbolic_controllable(&KLEE_arg1, sizeof(KLEE_arg1), "KLEE_arg1", true);
klee_make_symbolic_controllable(&KLEE_arg2, sizeof(KLEE_arg2), "KLEE_arg2", true);
klee_make_symbolic_controllable(&KLEE_arg3, sizeof(KLEE_arg3), "KLEE_arg3", true);
exec(KLEE_arg0, KLEE_arg1, KLEE_arg2, KLEE_arg3);

return 0;
}