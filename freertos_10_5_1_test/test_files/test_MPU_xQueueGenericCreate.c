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
    const UBaseType_t KLEE_uxQueueLength;
    klee_make_symbolic_controllable(&KLEE_uxQueueLength, sizeof(KLEE_uxQueueLength), "KLEE_uxQueueLength", true);
    const UBaseType_t KLEE_uxItemSize;
    klee_make_symbolic_controllable(&KLEE_uxItemSize, sizeof(KLEE_uxItemSize), "KLEE_uxItemSize", true);
    const uint8_t KLEE_ucQueueType;
    klee_make_symbolic_controllable(&KLEE_ucQueueType, sizeof(KLEE_ucQueueType), "KLEE_ucQueueType", true);
    MPU_xQueueGenericCreate(KLEE_uxQueueLength, KLEE_uxItemSize, KLEE_ucQueueType);
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
    return 0;
}
