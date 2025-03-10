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
    UBaseType_t KLEE_uxIndexToWaitOn;
    klee_make_symbolic_controllable(&KLEE_uxIndexToWaitOn, sizeof(KLEE_uxIndexToWaitOn), "KLEE_uxIndexToWaitOn", true);
    BaseType_t KLEE_xClearCountOnExit;
    klee_make_symbolic_controllable(&KLEE_xClearCountOnExit, sizeof(KLEE_xClearCountOnExit), "KLEE_xClearCountOnExit", true);
    TickType_t KLEE_xTicksToWait;
    klee_make_symbolic_controllable(&KLEE_xTicksToWait, sizeof(KLEE_xTicksToWait), "KLEE_xTicksToWait", true);
    MPU_ulTaskGenericNotifyTake(KLEE_uxIndexToWaitOn, KLEE_xClearCountOnExit, KLEE_xTicksToWait);
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
    return 0;
}
