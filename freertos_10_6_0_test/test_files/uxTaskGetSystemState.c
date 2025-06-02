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
TaskStatus_t * KLEE_pxTaskStatusArray;
UBaseType_t KLEE_uxArraySize;
configRUN_TIME_COUNTER_TYPE * KLEE_pulTotalRunTime;
klee_make_symbolic_controllable(&KLEE_pxTaskStatusArray, sizeof(KLEE_pxTaskStatusArray), "KLEE_pxTaskStatusArray", true);
klee_make_symbolic_controllable(&KLEE_uxArraySize, sizeof(KLEE_uxArraySize), "KLEE_uxArraySize", true);
klee_make_symbolic_controllable(&KLEE_pulTotalRunTime, sizeof(KLEE_pulTotalRunTime), "KLEE_pulTotalRunTime", true);
if (KLEE_uxArraySize < KERNEL_REGION_START || KLEE_uxArraySize > KERNEL_REGION_END) { return 0; }
if (KLEE_pulTotalRunTime < KERNEL_REGION_START || KLEE_pulTotalRunTime > KERNEL_REGION_END) { return 0; }
uxTaskGetSystemState(KLEE_pxTaskStatusArray,KLEE_uxArraySize,KLEE_pulTotalRunTime);
return 0;
}
void vTaskFunction1( void *pvParameters )
{
assert(0);
}
