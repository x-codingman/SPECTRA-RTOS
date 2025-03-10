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
    QueueHandle_t KLEE_pxMutex;
    klee_make_symbolic_controllable(&KLEE_pxMutex, sizeof(KLEE_pxMutex), "KLEE_pxMutex", true);
    MPU_xQueueGiveMutexRecursive(KLEE_pxMutex);
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
    return 0;
}
