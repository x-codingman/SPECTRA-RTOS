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
    QueueHandle_t KLEE_xQueue;
    klee_make_symbolic_controllable(&KLEE_xQueue, sizeof(KLEE_xQueue), "KLEE_kernel_xQueue", true);
    const void * const * KLEE_pvItemToQueue;
    klee_make_symbolic_controllable(&KLEE_pvItemToQueue, sizeof(KLEE_pvItemToQueue), "KLEE_pvItemToQueue", true);
    TickType_t KLEE_xTicksToWait;
    klee_make_symbolic_controllable(&KLEE_xTicksToWait, sizeof(KLEE_xTicksToWait), "KLEE_xTicksToWait", true);
    const BaseType_t KLEE_xCopyPosition;
    klee_make_symbolic_controllable(&KLEE_xCopyPosition, sizeof(KLEE_xCopyPosition), "KLEE_xCopyPosition", true);
    /* Queue API */ BaseType_t KLEE_return_val;
    klee_make_symbolic_controllable(&KLEE_return_val, sizeof(KLEE_return_val), "KLEE_return_val", true);
    KLEE_return_val = MPU_xQueueGenericSend(KLEE_xQueue, KLEE_pvItemToQueue, KLEE_xTicksToWait, KLEE_xCopyPosition);
    return 0;
}
