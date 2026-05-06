#include "klee_help.h"
#include <FreeRTOS.h>
#include <task.h>
#include <queue.h>
#include <klee/klee.h>
#include <list.h>
#include <stream_buffer.h>
#include <timers.h>
#include <event_groups.h>
#define STACK_SIZE 200
#define MPU_ENABLE_ADDRESS_START 0xefff2000
#define MPU_ENABLE_ADDRESS_END 0xefff4000
#define ATTACK_CAPABILITY_REGION_START 0x80000000
#define ATTACK_CAPABILITY_REGION_END 0x8fffffff
void vTaskFunction1( void *pvParameters );
int main()
{
xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
TimeOut_t * KLEE_pxTimeOut;
klee_make_symbolic_controllable(&KLEE_pxTimeOut, sizeof(KLEE_pxTimeOut), "KLEE_pxTimeOut", true);
if (KLEE_pxTimeOut < ATTACK_CAPABILITY_REGION_START || KLEE_pxTimeOut > ATTACK_CAPABILITY_REGION_END) { return 0; }
vTaskSetTimeOutState(KLEE_pxTimeOut);
return 0;
}
void vTaskFunction1( void *pvParameters )
{
assert(0);
}
