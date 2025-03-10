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
    QueueHandle_t KLEE_xQueue;
    klee_make_symbolic_controllable(&KLEE_xQueue, sizeof(KLEE_xQueue), "KLEE_xQueue", true);
    UBaseType_t KLEE_uxQueueNumber;
    klee_make_symbolic_controllable(&KLEE_uxQueueNumber, sizeof(KLEE_uxQueueNumber), "KLEE_uxQueueNumber", true);
    MPU_vQueueSetQueueNumber(KLEE_xQueue, KLEE_uxQueueNumber);
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
    return 0;
}
