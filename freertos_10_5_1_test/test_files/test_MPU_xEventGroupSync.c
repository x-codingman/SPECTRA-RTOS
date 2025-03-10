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
void vTaskFunction1( void *pvParameters )
{
    EventGroupHandle_t KLEE_xEventGroup;
    klee_make_symbolic_controllable(&KLEE_xEventGroup, sizeof(KLEE_xEventGroup), "KLEE_xEventGroup", true);
    const EventBits_t KLEE_uxBitsToSet;
    klee_make_symbolic_controllable(&KLEE_uxBitsToSet, sizeof(KLEE_uxBitsToSet), "KLEE_uxBitsToSet", true);
    const EventBits_t KLEE_uxBitsToWaitFor;
    klee_make_symbolic_controllable(&KLEE_uxBitsToWaitFor, sizeof(KLEE_uxBitsToWaitFor), "KLEE_uxBitsToWaitFor", true);
    TickType_t KLEE_xTicksToWait;
    klee_make_symbolic_controllable(&KLEE_xTicksToWait, sizeof(KLEE_xTicksToWait), "KLEE_xTicksToWait", true);
    MPU_xEventGroupSync(KLEE_xEventGroup, KLEE_uxBitsToSet, KLEE_uxBitsToWaitFor, KLEE_xTicksToWait);
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
    return 0;
}
