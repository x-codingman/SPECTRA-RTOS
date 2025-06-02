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
TimerHandle_t KLEE_xTimer;
const BaseType_t KLEE_xCommandID;
const TickType_t KLEE_xOptionalValue;
BaseType_t * const KLEE_pxHigherPriorityTaskWoken;
const TickType_t KLEE_xTicksToWait;
klee_make_symbolic_controllable(&KLEE_xTimer, sizeof(KLEE_xTimer), "KLEE_xTimer", true);
klee_make_symbolic_controllable(&KLEE_xCommandID, sizeof(KLEE_xCommandID), "KLEE_xCommandID", true);
klee_make_symbolic_controllable(&KLEE_xOptionalValue, sizeof(KLEE_xOptionalValue), "KLEE_xOptionalValue", true);
klee_make_symbolic_controllable(&KLEE_pxHigherPriorityTaskWoken, sizeof(KLEE_pxHigherPriorityTaskWoken), "KLEE_pxHigherPriorityTaskWoken", true);
klee_make_symbolic_controllable(&KLEE_xTicksToWait, sizeof(KLEE_xTicksToWait), "KLEE_xTicksToWait", true);
if (KLEE_xTimer < KERNEL_REGION_START || KLEE_xTimer > KERNEL_REGION_END) { return 0; }
if (KLEE_pxHigherPriorityTaskWoken < ATTACK_CAPABILITY_REGION_START || KLEE_pxHigherPriorityTaskWoken > ATTACK_CAPABILITY_REGION_END) { return 0; }
xTimerGenericCommand(KLEE_xTimer,KLEE_xCommandID,KLEE_xOptionalValue,KLEE_pxHigherPriorityTaskWoken,KLEE_xTicksToWait);
return 0;
}
void vTaskFunction1( void *pvParameters )
{
assert(0);
}
