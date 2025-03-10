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
    const uint8_t KLEE_ucQueueType;
    klee_make_symbolic_controllable(&KLEE_ucQueueType, sizeof(KLEE_ucQueueType), "KLEE_ucQueueType", true);
    StaticQueue_t * * KLEE_pxStaticQueue;
    klee_make_symbolic_controllable(&KLEE_pxStaticQueue, sizeof(KLEE_pxStaticQueue), "KLEE_pxStaticQueue", true);
    MPU_xQueueCreateMutexStatic(KLEE_ucQueueType, KLEE_pxStaticQueue);
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
    return 0;
}
