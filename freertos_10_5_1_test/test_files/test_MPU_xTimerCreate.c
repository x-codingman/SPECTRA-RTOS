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
    MPU_xTimerCreate(KLEE_pcTimerName, KLEE_xTimerPeriodInTicks, KLEE_uxAutoReload, KLEE_pvTimerID, KLEE_pxCallbackFunction);
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
    return 0;
}
