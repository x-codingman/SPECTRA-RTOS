#include "klee_help.h"
#include <unistd.h>
#include <klee/klee.h>
#include "queue.h"
extern volatile dq_queue_t g_readytorun;
extern FAR struct tcb_s klee_tcb;
void vTaskFunction1( void *pvParameters );
int main()
{
g_readytorun.head = (dq_entry_t*)&klee_tcb;
FAR const char * arg0;
FAR char *const  arg1;

task_create("vTaskFunction1",1,1024,vTaskFunction1,NULL);
klee_make_symbolic_controllable(&arg0, sizeof(arg0), "arg0", true);
klee_make_symbolic_controllable(&arg1, sizeof(arg1), "arg1", true);
execv(arg0, arg1);

return 0;
}