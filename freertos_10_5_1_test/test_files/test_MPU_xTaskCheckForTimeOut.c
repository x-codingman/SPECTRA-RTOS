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
    TimeOut_t * const * KLEE_pxTimeOut;
    klee_make_symbolic_controllable(&KLEE_pxTimeOut, sizeof(KLEE_pxTimeOut), "KLEE_pxTimeOut", true);
    TickType_t * const * KLEE_pxTicksToWait;
    klee_make_symbolic_controllable(&KLEE_pxTicksToWait, sizeof(KLEE_pxTicksToWait), "KLEE_pxTicksToWait", true);
    MPU_xTaskCheckForTimeOut(KLEE_pxTimeOut, KLEE_pxTicksToWait);
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
    return 0;
}
