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
    TaskStatus_t * const * KLEE_pxTaskStatusArray;
    klee_make_symbolic_controllable(&KLEE_pxTaskStatusArray, sizeof(KLEE_pxTaskStatusArray), "KLEE_pxTaskStatusArray", true);
    const UBaseType_t KLEE_uxArraySize;
    klee_make_symbolic_controllable(&KLEE_uxArraySize, sizeof(KLEE_uxArraySize), "KLEE_uxArraySize", true);
    configRUN_TIME_COUNTER_TYPE * const * KLEE_pulTotalRunTime;
    klee_make_symbolic_controllable(&KLEE_pulTotalRunTime, sizeof(KLEE_pulTotalRunTime), "KLEE_pulTotalRunTime", true);
    MPU_uxTaskGetSystemState(KLEE_pxTaskStatusArray, KLEE_uxArraySize, KLEE_pulTotalRunTime);
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
    return 0;
}
