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
    TickType_t KLEE_xTicksToCatchUp;
    klee_make_symbolic_controllable(&KLEE_xTicksToCatchUp, sizeof(KLEE_xTicksToCatchUp), "KLEE_xTicksToCatchUp", true);
    MPU_xTaskCatchUpTicks(KLEE_xTicksToCatchUp);
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
    return 0;
}
