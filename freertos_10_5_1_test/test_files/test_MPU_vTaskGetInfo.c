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
    TaskHandle_t KLEE_xTask;
    klee_make_symbolic_controllable(&KLEE_xTask, sizeof(KLEE_xTask), "KLEE_kernel_xTask", true);
    TaskStatus_t * * KLEE_pxTaskStatus;
    klee_make_symbolic_controllable(&KLEE_pxTaskStatus, sizeof(KLEE_pxTaskStatus), "KLEE_pxTaskStatus", true);
    BaseType_t KLEE_xGetFreeStackSpace;
    klee_make_symbolic_controllable(&KLEE_xGetFreeStackSpace, sizeof(KLEE_xGetFreeStackSpace), "KLEE_xGetFreeStackSpace", true);
    eTaskState KLEE_eState;
    klee_make_symbolic_controllable(&KLEE_eState, sizeof(KLEE_eState), "KLEE_eState", true);
    MPU_vTaskGetInfo(KLEE_xTask, KLEE_pxTaskStatus, KLEE_xGetFreeStackSpace, KLEE_eState);
    return 0;
}
