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
TaskHandle_t KLEE_xTaskToQuery;
BaseType_t KLEE_xIndex;
void * KLEE_pvValue;
klee_make_symbolic_controllable(&KLEE_xTaskToQuery, sizeof(KLEE_xTaskToQuery), "KLEE_xTaskToQuery", true);
klee_make_symbolic_controllable(&KLEE_xIndex, sizeof(KLEE_xIndex), "KLEE_xIndex", true);
klee_make_symbolic_controllable(&KLEE_pvValue, sizeof(KLEE_pvValue), "KLEE_pvValue", true);
if (KLEE_xTaskToQuery < KERNEL_REGION_START || KLEE_xTaskToQuery > KERNEL_REGION_END) { return 0; }
vTaskSetThreadLocalStoragePointer(KLEE_xTaskToQuery,KLEE_xIndex,KLEE_pvValue);
return 0;
}
void vTaskFunction1( void *pvParameters )
{
assert(0);
}
