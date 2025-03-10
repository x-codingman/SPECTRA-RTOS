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
    TimerHandle_t KLEE_xTimer;
    klee_make_symbolic_controllable(&KLEE_xTimer, sizeof(KLEE_xTimer), "KLEE_xTimer", true);
    void * * KLEE_pvNewID;
    klee_make_symbolic_controllable(&KLEE_pvNewID, sizeof(KLEE_pvNewID), "KLEE_pvNewID", true);
    MPU_vTimerSetTimerID(KLEE_xTimer, KLEE_pvNewID);
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
    return 0;
}
