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
    TaskStatus_t * const * KLEE_pxTaskStatusArray;
    klee_make_symbolic_controllable(&KLEE_pxTaskStatusArray, sizeof(KLEE_pxTaskStatusArray), "KLEE_pxTaskStatusArray", true);
    const UBaseType_t KLEE_uxArraySize;
    klee_make_symbolic_controllable(&KLEE_uxArraySize, sizeof(KLEE_uxArraySize), "KLEE_uxArraySize", true);
    configRUN_TIME_COUNTER_TYPE * const * KLEE_pulTotalRunTime;
    klee_make_symbolic_controllable(&KLEE_pulTotalRunTime, sizeof(KLEE_pulTotalRunTime), "KLEE_pulTotalRunTime", true);
    UBaseType_t KLEE_return_val;
    klee_make_symbolic_controllable(&KLEE_return_val, sizeof(KLEE_return_val), "KLEE_return_val", true);
    KLEE_return_val = MPU_uxTaskGetSystemState(KLEE_pxTaskStatusArray, KLEE_uxArraySize, KLEE_pulTotalRunTime);
    return 0;
}
