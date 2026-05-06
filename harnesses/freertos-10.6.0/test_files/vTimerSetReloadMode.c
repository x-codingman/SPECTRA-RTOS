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
const UBaseType_t KLEE_uxAutoReload;
klee_make_symbolic_controllable(&KLEE_xTimer, sizeof(KLEE_xTimer), "KLEE_xTimer", true);
klee_make_symbolic_controllable(&KLEE_uxAutoReload, sizeof(KLEE_uxAutoReload), "KLEE_uxAutoReload", true);
if (KLEE_xTimer < KERNEL_REGION_START || KLEE_xTimer > KERNEL_REGION_END) { return 0; }
vTimerSetReloadMode(KLEE_xTimer,KLEE_uxAutoReload);
return 0;
}
void vTaskFunction1( void *pvParameters )
{
assert(0);
}
