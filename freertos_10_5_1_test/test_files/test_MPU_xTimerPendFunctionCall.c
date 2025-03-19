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
    PendedFunction_t KLEE_xFunctionToPend;
    klee_make_symbolic_controllable(&KLEE_xFunctionToPend, sizeof(KLEE_xFunctionToPend), "KLEE_xFunctionToPend", true);
    void * * KLEE_pvParameter1;
    klee_make_symbolic_controllable(&KLEE_pvParameter1, sizeof(KLEE_pvParameter1), "KLEE_pvParameter1", true);
    uint32_t KLEE_ulParameter2;
    klee_make_symbolic_controllable(&KLEE_ulParameter2, sizeof(KLEE_ulParameter2), "KLEE_ulParameter2", true);
    TickType_t KLEE_xTicksToWait;
    klee_make_symbolic_controllable(&KLEE_xTicksToWait, sizeof(KLEE_xTicksToWait), "KLEE_xTicksToWait", true);
    BaseType_t KLEE_return_val;
    klee_make_symbolic_controllable(&KLEE_return_val, sizeof(KLEE_return_val), "KLEE_return_val", true);
    KLEE_return_val = MPU_xTimerPendFunctionCall(KLEE_xFunctionToPend, KLEE_pvParameter1, KLEE_ulParameter2, KLEE_xTicksToWait);
    return 0;
}
