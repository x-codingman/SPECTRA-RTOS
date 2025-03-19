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
    const char * const * KLEE_pcTimerName;
    klee_make_symbolic_controllable(&KLEE_pcTimerName, sizeof(KLEE_pcTimerName), "KLEE_pcTimerName", true);
    const TickType_t KLEE_xTimerPeriodInTicks;
    klee_make_symbolic_controllable(&KLEE_xTimerPeriodInTicks, sizeof(KLEE_xTimerPeriodInTicks), "KLEE_xTimerPeriodInTicks", true);
    const UBaseType_t KLEE_uxAutoReload;
    klee_make_symbolic_controllable(&KLEE_uxAutoReload, sizeof(KLEE_uxAutoReload), "KLEE_uxAutoReload", true);
    void * const * KLEE_pvTimerID;
    klee_make_symbolic_controllable(&KLEE_pvTimerID, sizeof(KLEE_pvTimerID), "KLEE_pvTimerID", true);
    TimerCallbackFunction_t KLEE_pxCallbackFunction;
    klee_make_symbolic_controllable(&KLEE_pxCallbackFunction, sizeof(KLEE_pxCallbackFunction), "KLEE_pxCallbackFunction", true);
    /* Timer API */ TimerHandle_t KLEE_return_val;
    klee_make_symbolic_controllable(&KLEE_return_val, sizeof(KLEE_return_val), "KLEE_kernel_return_val", true);
    KLEE_return_val = MPU_xTimerCreate(KLEE_pcTimerName, KLEE_xTimerPeriodInTicks, KLEE_uxAutoReload, KLEE_pvTimerID, KLEE_pxCallbackFunction);
    return 0;
}
