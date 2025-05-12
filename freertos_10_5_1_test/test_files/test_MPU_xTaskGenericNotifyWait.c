#include "klee_help.h"
#include <FreeRTOS.h>
#include <task.h>
#include <queue.h>
#include <semphr.h>
#include <timers.h>
#include <event_groups.h>
#include <stream_buffer.h>

#include <klee/klee.h>
#include "wrappers.h"
extern TaskHandle_t pxCurrentTCB;
void vTaskFunction1();
void vTaskFunction1(){
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    TaskHandle_t initial_xTask;
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, &initial_xTask);
    UBaseType_t KLEE_uxIndexToWaitOn;
    klee_make_symbolic_controllable(&KLEE_uxIndexToWaitOn, sizeof(KLEE_uxIndexToWaitOn), "KLEE_uxIndexToWaitOn", true);
    uint32_t KLEE_ulBitsToClearOnEntry;
    klee_make_symbolic_controllable(&KLEE_ulBitsToClearOnEntry, sizeof(KLEE_ulBitsToClearOnEntry), "KLEE_ulBitsToClearOnEntry", true);
    uint32_t KLEE_ulBitsToClearOnExit;
    klee_make_symbolic_controllable(&KLEE_ulBitsToClearOnExit, sizeof(KLEE_ulBitsToClearOnExit), "KLEE_ulBitsToClearOnExit", true);
    uint32_t * KLEE_pulNotificationValue;
    klee_make_symbolic_controllable(&KLEE_pulNotificationValue, sizeof(KLEE_pulNotificationValue), "KLEE_pulNotificationValue", true);
    TickType_t KLEE_xTicksToWait;
    klee_make_symbolic_controllable(&KLEE_xTicksToWait, sizeof(KLEE_xTicksToWait), "KLEE_xTicksToWait", true);
    BaseType_t KLEE_return_val;
    klee_make_symbolic_controllable(&KLEE_return_val, sizeof(KLEE_return_val), "KLEE_return_val", true);
    KLEE_return_val = MPU_xTaskGenericNotifyWait(KLEE_uxIndexToWaitOn, KLEE_ulBitsToClearOnEntry, KLEE_ulBitsToClearOnExit, KLEE_pulNotificationValue, KLEE_xTicksToWait);
    return 0;
}
