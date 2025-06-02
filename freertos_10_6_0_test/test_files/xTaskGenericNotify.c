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
TaskHandle_t KLEE_xTaskToNotify;
UBaseType_t KLEE_uxIndexToNotify;
uint32_t KLEE_ulValue;
eNotifyAction KLEE_eAction;
uint32_t * KLEE_pulPreviousNotificationValue;
klee_make_symbolic_controllable(&KLEE_xTaskToNotify, sizeof(KLEE_xTaskToNotify), "KLEE_xTaskToNotify", true);
klee_make_symbolic_controllable(&KLEE_uxIndexToNotify, sizeof(KLEE_uxIndexToNotify), "KLEE_uxIndexToNotify", true);
klee_make_symbolic_controllable(&KLEE_ulValue, sizeof(KLEE_ulValue), "KLEE_ulValue", true);
klee_make_symbolic_controllable(&KLEE_eAction, sizeof(KLEE_eAction), "KLEE_eAction", true);
klee_make_symbolic_controllable(&KLEE_pulPreviousNotificationValue, sizeof(KLEE_pulPreviousNotificationValue), "KLEE_pulPreviousNotificationValue", true);
if (KLEE_xTaskToNotify < KERNEL_REGION_START || KLEE_xTaskToNotify > KERNEL_REGION_END) { return 0; }
if (KLEE_pulPreviousNotificationValue < ATTACK_CAPABILITY_REGION_START || KLEE_pulPreviousNotificationValue > ATTACK_CAPABILITY_REGION_END) { return 0; }
xTaskGenericNotify(KLEE_xTaskToNotify,KLEE_uxIndexToNotify,KLEE_ulValue,KLEE_eAction,KLEE_pulPreviousNotificationValue);
return 0;
}
void vTaskFunction1( void *pvParameters )
{
assert(0);
}
