#include "klee_help.h"
#include <stdlib.h>
#include <klee/klee.h>
#include "queue.h"
extern volatile dq_queue_t g_readytorun;
extern FAR struct tcb_s klee_tcb;
int main()
{
g_readytorun.head = (dq_entry_t*)&klee_tcb;
const char* arg0;
klee_make_symbolic_controllable(&arg0, sizeof(arg0), "arg0", true);
unsetenv(arg0);

return 0;
}