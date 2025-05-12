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
    EventGroupHandle_t KLEE_xEventGroup;
    klee_make_symbolic_controllable(&KLEE_xEventGroup, sizeof(KLEE_xEventGroup), "KLEE_kernel_xEventGroup", true);
    const EventBits_t KLEE_uxBitsToClear;
    klee_make_symbolic_controllable(&KLEE_uxBitsToClear, sizeof(KLEE_uxBitsToClear), "KLEE_uxBitsToClear", true);
    EventBits_t KLEE_return_val;
    klee_make_symbolic_controllable(&KLEE_return_val, sizeof(KLEE_return_val), "KLEE_return_val", true);
    KLEE_return_val = MPU_xEventGroupClearBits(KLEE_xEventGroup, KLEE_uxBitsToClear);
    return 0;
}
