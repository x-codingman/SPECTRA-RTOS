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
void vTaskFunction1( void *pvParameters )
{
    TaskHandle_t KLEE_xTaskToNotify;
    klee_make_symbolic_controllable(&KLEE_xTaskToNotify, sizeof(KLEE_xTaskToNotify), "KLEE_xTaskToNotify", true);
    UBaseType_t KLEE_uxIndexToNotify;
    klee_make_symbolic_controllable(&KLEE_uxIndexToNotify, sizeof(KLEE_uxIndexToNotify), "KLEE_uxIndexToNotify", true);
    uint32_t KLEE_ulValue;
    klee_make_symbolic_controllable(&KLEE_ulValue, sizeof(KLEE_ulValue), "KLEE_ulValue", true);
    eNotifyAction KLEE_eAction;
    klee_make_symbolic_controllable(&KLEE_eAction, sizeof(KLEE_eAction), "KLEE_eAction", true);
    uint32_t * * KLEE_pulPreviousNotificationValue;
    klee_make_symbolic_controllable(&KLEE_pulPreviousNotificationValue, sizeof(KLEE_pulPreviousNotificationValue), "KLEE_pulPreviousNotificationValue", true);
    MPU_xTaskGenericNotify(KLEE_xTaskToNotify, KLEE_uxIndexToNotify, KLEE_ulValue, KLEE_eAction, KLEE_pulPreviousNotificationValue);
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
    return 0;
}
