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
    TaskHandle_t KLEE_xTaskToSet;
    klee_make_symbolic_controllable(&KLEE_xTaskToSet, sizeof(KLEE_xTaskToSet), "KLEE_kernel_xTaskToSet", true);
    BaseType_t KLEE_xIndex;
    klee_make_symbolic_controllable(&KLEE_xIndex, sizeof(KLEE_xIndex), "KLEE_xIndex", true);
    void * KLEE_pvValue;
    klee_make_symbolic_controllable(&KLEE_pvValue, sizeof(KLEE_pvValue), "KLEE_pvValue", true);
    MPU_vTaskSetThreadLocalStoragePointer(KLEE_xTaskToSet, KLEE_xIndex, KLEE_pvValue);
    return 0;
}
