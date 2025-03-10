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
    QueueSetMemberHandle_t KLEE_xQueueOrSemaphore;
    klee_make_symbolic_controllable(&KLEE_xQueueOrSemaphore, sizeof(KLEE_xQueueOrSemaphore), "KLEE_xQueueOrSemaphore", true);
    QueueSetHandle_t KLEE_xQueueSet;
    klee_make_symbolic_controllable(&KLEE_xQueueSet, sizeof(KLEE_xQueueSet), "KLEE_xQueueSet", true);
    MPU_xQueueRemoveFromSet(KLEE_xQueueOrSemaphore, KLEE_xQueueSet);
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
    return 0;
}
