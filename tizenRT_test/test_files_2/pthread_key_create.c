#include "klee_help.h"
#include <pthread.h>
#include <klee/klee.h>
#include "queue.h"
extern volatile dq_queue_t g_readytorun;
extern FAR struct tcb_s klee_tcb;
int main()
{
g_readytorun.head = (dq_entry_t*)&klee_tcb;
FAR pthread_key_t* KLEE_arg0;
CODE void (*KLEE_arg1)(FAR void*) ;
klee_make_symbolic_controllable(&KLEE_arg0, sizeof(KLEE_arg0), "KLEE_arg0", true);
klee_make_symbolic_controllable(&KLEE_arg1, sizeof(KLEE_arg1), "KLEE_arg1", true);
pthread_key_create(KLEE_arg0, KLEE_arg1);

return 0;
}