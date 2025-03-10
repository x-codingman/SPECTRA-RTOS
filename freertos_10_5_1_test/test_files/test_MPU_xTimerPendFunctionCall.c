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
    PendedFunction_t KLEE_xFunctionToPend;
    klee_make_symbolic_controllable(&KLEE_xFunctionToPend, sizeof(KLEE_xFunctionToPend), "KLEE_xFunctionToPend", true);
    void * * KLEE_pvParameter1;
    klee_make_symbolic_controllable(&KLEE_pvParameter1, sizeof(KLEE_pvParameter1), "KLEE_pvParameter1", true);
    uint32_t KLEE_ulParameter2;
    klee_make_symbolic_controllable(&KLEE_ulParameter2, sizeof(KLEE_ulParameter2), "KLEE_ulParameter2", true);
    TickType_t KLEE_xTicksToWait;
    klee_make_symbolic_controllable(&KLEE_xTicksToWait, sizeof(KLEE_xTicksToWait), "KLEE_xTicksToWait", true);
    MPU_xTimerPendFunctionCall(KLEE_xFunctionToPend, KLEE_pvParameter1, KLEE_ulParameter2, KLEE_xTicksToWait);
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
    return 0;
}
