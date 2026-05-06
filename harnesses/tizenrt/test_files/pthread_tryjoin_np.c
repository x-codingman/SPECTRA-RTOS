#include "klee_help.h"
#include <pthread.h>
#include <klee/klee.h>
#include "queue.h"
extern volatile dq_queue_t g_readytorun;
extern FAR struct tcb_s klee_tcb;
int main()
{
g_readytorun.head = (dq_entry_t*)&klee_tcb;
pthread_t KLEE_arg0;
FAR pthread_addr_t* KLEE_arg1;
klee_make_symbolic_controllable(&KLEE_arg0, sizeof(KLEE_arg0), "KLEE_arg0", true);
klee_make_symbolic_controllable(&KLEE_arg1, sizeof(KLEE_arg1), "KLEE_arg1", true);
pthread_tryjoin_np(KLEE_arg0, KLEE_arg1);

return 0;
}