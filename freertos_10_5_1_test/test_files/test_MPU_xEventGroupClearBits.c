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
    const EventBits_t KLEE_uxBitsToClear;
    klee_make_symbolic_controllable(&KLEE_uxBitsToClear, sizeof(KLEE_uxBitsToClear), "KLEE_uxBitsToClear", true);
    MPU_xEventGroupClearBits(KLEE_xEventGroup, KLEE_uxBitsToClear);
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
    return 0;
}
