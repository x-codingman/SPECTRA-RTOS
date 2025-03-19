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
    TaskHandle_t KLEE_xTaskToNotify;
    klee_make_symbolic_controllable(&KLEE_xTaskToNotify, sizeof(KLEE_xTaskToNotify), "KLEE_kernel_xTaskToNotify", true);
    UBaseType_t KLEE_uxIndexToNotify;
    klee_make_symbolic_controllable(&KLEE_uxIndexToNotify, sizeof(KLEE_uxIndexToNotify), "KLEE_uxIndexToNotify", true);
    uint32_t KLEE_ulValue;
    klee_make_symbolic_controllable(&KLEE_ulValue, sizeof(KLEE_ulValue), "KLEE_ulValue", true);
    eNotifyAction KLEE_eAction;
    klee_make_symbolic_controllable(&KLEE_eAction, sizeof(KLEE_eAction), "KLEE_eAction", true);
    uint32_t * * KLEE_pulPreviousNotificationValue;
    klee_make_symbolic_controllable(&KLEE_pulPreviousNotificationValue, sizeof(KLEE_pulPreviousNotificationValue), "KLEE_pulPreviousNotificationValue", true);
    BaseType_t KLEE_return_val;
    klee_make_symbolic_controllable(&KLEE_return_val, sizeof(KLEE_return_val), "KLEE_return_val", true);
    KLEE_return_val = MPU_xTaskGenericNotify(KLEE_xTaskToNotify, KLEE_uxIndexToNotify, KLEE_ulValue, KLEE_eAction, KLEE_pulPreviousNotificationValue);
    return 0;
}
