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
UBaseType_t KLEE_uxIndexToWaitOn;
uint32_t KLEE_ulBitsToClearOnEntry;
uint32_t KLEE_ulBitsToClearOnExit;
uint32_t * KLEE_pulNotificationValue;
TickType_t KLEE_xTicksToWait;
klee_make_symbolic_controllable(&KLEE_uxIndexToWaitOn, sizeof(KLEE_uxIndexToWaitOn), "KLEE_uxIndexToWaitOn", true);
klee_make_symbolic_controllable(&KLEE_ulBitsToClearOnEntry, sizeof(KLEE_ulBitsToClearOnEntry), "KLEE_ulBitsToClearOnEntry", true);
klee_make_symbolic_controllable(&KLEE_ulBitsToClearOnExit, sizeof(KLEE_ulBitsToClearOnExit), "KLEE_ulBitsToClearOnExit", true);
klee_make_symbolic_controllable(&KLEE_pulNotificationValue, sizeof(KLEE_pulNotificationValue), "KLEE_pulNotificationValue", true);
klee_make_symbolic_controllable(&KLEE_xTicksToWait, sizeof(KLEE_xTicksToWait), "KLEE_xTicksToWait", true);
if (KLEE_pulNotificationValue < ATTACK_CAPABILITY_REGION_START || KLEE_pulNotificationValue > ATTACK_CAPABILITY_REGION_END) { return 0; }
xTaskGenericNotifyWait(KLEE_uxIndexToWaitOn,KLEE_ulBitsToClearOnEntry,KLEE_ulBitsToClearOnExit,KLEE_pulNotificationValue,KLEE_xTicksToWait);
return 0;
}
void vTaskFunction1( void *pvParameters )
{
assert(0);
}
