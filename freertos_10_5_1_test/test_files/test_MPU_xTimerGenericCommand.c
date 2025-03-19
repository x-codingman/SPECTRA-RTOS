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
    TimerHandle_t KLEE_xTimer;
    klee_make_symbolic_controllable(&KLEE_xTimer, sizeof(KLEE_xTimer), "KLEE_kernel_xTimer", true);
    const BaseType_t KLEE_xCommandID;
    klee_make_symbolic_controllable(&KLEE_xCommandID, sizeof(KLEE_xCommandID), "KLEE_xCommandID", true);
    const TickType_t KLEE_xOptionalValue;
    klee_make_symbolic_controllable(&KLEE_xOptionalValue, sizeof(KLEE_xOptionalValue), "KLEE_xOptionalValue", true);
    BaseType_t * const * KLEE_pxHigherPriorityTaskWoken;
    klee_make_symbolic_controllable(&KLEE_pxHigherPriorityTaskWoken, sizeof(KLEE_pxHigherPriorityTaskWoken), "KLEE_pxHigherPriorityTaskWoken", true);
    const TickType_t KLEE_xTicksToWait;
    klee_make_symbolic_controllable(&KLEE_xTicksToWait, sizeof(KLEE_xTicksToWait), "KLEE_xTicksToWait", true);
    BaseType_t KLEE_return_val;
    klee_make_symbolic_controllable(&KLEE_return_val, sizeof(KLEE_return_val), "KLEE_return_val", true);
    KLEE_return_val = MPU_xTimerGenericCommand(KLEE_xTimer, KLEE_xCommandID, KLEE_xOptionalValue, KLEE_pxHigherPriorityTaskWoken, KLEE_xTicksToWait);
    return 0;
}
