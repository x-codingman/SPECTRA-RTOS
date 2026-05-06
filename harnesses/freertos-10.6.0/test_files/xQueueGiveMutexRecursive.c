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
QueueHandle_t KLEE_pxMutex;
klee_make_symbolic_controllable(&KLEE_pxMutex, sizeof(KLEE_pxMutex), "KLEE_pxMutex", true);
if (KLEE_pxMutex < KERNEL_REGION_START || KLEE_pxMutex > KERNEL_REGION_END) { return 0; }
xQueueGiveMutexRecursive(KLEE_pxMutex);
return 0;
}
void vTaskFunction1( void *pvParameters )
{
assert(0);
}
