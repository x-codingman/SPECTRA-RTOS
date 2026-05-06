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
    const UBaseType_t KLEE_uxMaxCount;
    klee_make_symbolic_controllable(&KLEE_uxMaxCount, sizeof(KLEE_uxMaxCount), "KLEE_uxMaxCount", true);
    const UBaseType_t KLEE_uxInitialCount;
    klee_make_symbolic_controllable(&KLEE_uxInitialCount, sizeof(KLEE_uxInitialCount), "KLEE_uxInitialCount", true);
    StaticQueue_t * KLEE_pxStaticQueue;
    klee_make_symbolic_controllable(&KLEE_pxStaticQueue, sizeof(KLEE_pxStaticQueue), "KLEE_pxStaticQueue", true);
    QueueHandle_t KLEE_return_val;
    klee_make_symbolic_controllable(&KLEE_return_val, sizeof(KLEE_return_val), "KLEE_kernel_return_val", true);
    KLEE_return_val = MPU_xQueueCreateCountingSemaphoreStatic(KLEE_uxMaxCount, KLEE_uxInitialCount, KLEE_pxStaticQueue);
    return 0;
}
