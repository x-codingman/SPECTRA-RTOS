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
    TickType_t * const * KLEE_pxPreviousWakeTime;
    klee_make_symbolic_controllable(&KLEE_pxPreviousWakeTime, sizeof(KLEE_pxPreviousWakeTime), "KLEE_pxPreviousWakeTime", true);
    const TickType_t KLEE_xTimeIncrement;
    klee_make_symbolic_controllable(&KLEE_xTimeIncrement, sizeof(KLEE_xTimeIncrement), "KLEE_xTimeIncrement", true);
    MPU_xTaskDelayUntil(KLEE_pxPreviousWakeTime, KLEE_xTimeIncrement);
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
    return 0;
}
