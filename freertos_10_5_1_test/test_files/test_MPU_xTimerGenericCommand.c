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
    TimerHandle_t KLEE_xTimer;
    klee_make_symbolic_controllable(&KLEE_xTimer, sizeof(KLEE_xTimer), "KLEE_xTimer", true);
    const BaseType_t KLEE_xCommandID;
    klee_make_symbolic_controllable(&KLEE_xCommandID, sizeof(KLEE_xCommandID), "KLEE_xCommandID", true);
    const TickType_t KLEE_xOptionalValue;
    klee_make_symbolic_controllable(&KLEE_xOptionalValue, sizeof(KLEE_xOptionalValue), "KLEE_xOptionalValue", true);
    BaseType_t * const * KLEE_pxHigherPriorityTaskWoken;
    klee_make_symbolic_controllable(&KLEE_pxHigherPriorityTaskWoken, sizeof(KLEE_pxHigherPriorityTaskWoken), "KLEE_pxHigherPriorityTaskWoken", true);
    const TickType_t KLEE_xTicksToWait;
    klee_make_symbolic_controllable(&KLEE_xTicksToWait, sizeof(KLEE_xTicksToWait), "KLEE_xTicksToWait", true);
    MPU_xTimerGenericCommand(KLEE_xTimer, KLEE_xCommandID, KLEE_xOptionalValue, KLEE_pxHigherPriorityTaskWoken, KLEE_xTicksToWait);
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
    return 0;
}
