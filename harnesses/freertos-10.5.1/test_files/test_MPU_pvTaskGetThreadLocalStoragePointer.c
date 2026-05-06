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
    TaskHandle_t KLEE_xTaskToQuery;
    klee_make_symbolic_controllable(&KLEE_xTaskToQuery, sizeof(KLEE_xTaskToQuery), "KLEE_kernel_xTaskToQuery", true);
    BaseType_t KLEE_xIndex;
    klee_make_symbolic_controllable(&KLEE_xIndex, sizeof(KLEE_xIndex), "KLEE_xIndex", true);
    void * KLEE_return_val;
    klee_make_symbolic_controllable(&KLEE_return_val, sizeof(KLEE_return_val), "KLEE_return_val", true);
    KLEE_return_val = MPU_pvTaskGetThreadLocalStoragePointer(KLEE_xTaskToQuery, KLEE_xIndex);
    return 0;
}
