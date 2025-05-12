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
    QueueSetHandle_t KLEE_xQueueSet;
    klee_make_symbolic_controllable(&KLEE_xQueueSet, sizeof(KLEE_xQueueSet), "KLEE_kernel_xQueueSet", true);
    const TickType_t KLEE_xTicksToWait;
    klee_make_symbolic_controllable(&KLEE_xTicksToWait, sizeof(KLEE_xTicksToWait), "KLEE_xTicksToWait", true);
    QueueSetMemberHandle_t KLEE_return_val;
    klee_make_symbolic_controllable(&KLEE_return_val, sizeof(KLEE_return_val), "KLEE_kernel_return_val", true);
    KLEE_return_val = MPU_xQueueSelectFromSet(KLEE_xQueueSet, KLEE_xTicksToWait);
    return 0;
}
