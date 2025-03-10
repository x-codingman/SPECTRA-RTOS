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
    MPU_xQueueCreateMutex(KLEE_ucQueueType);
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
    return 0;
}
