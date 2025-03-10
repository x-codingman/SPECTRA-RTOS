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
    TaskFunction_t KLEE_pxTaskCode;
    klee_make_symbolic_controllable(&KLEE_pxTaskCode, sizeof(KLEE_pxTaskCode), "KLEE_pxTaskCode", true);
    const char * const * KLEE_pcName;
    klee_make_symbolic_controllable(&KLEE_pcName, sizeof(KLEE_pcName), "KLEE_pcName", true);
    const uint32_t KLEE_ulStackDepth;
    klee_make_symbolic_controllable(&KLEE_ulStackDepth, sizeof(KLEE_ulStackDepth), "KLEE_ulStackDepth", true);
    void * const * KLEE_pvParameters;
    klee_make_symbolic_controllable(&KLEE_pvParameters, sizeof(KLEE_pvParameters), "KLEE_pvParameters", true);
    UBaseType_t KLEE_uxPriority;
    klee_make_symbolic_controllable(&KLEE_uxPriority, sizeof(KLEE_uxPriority), "KLEE_uxPriority", true);
    StackType_t * const * KLEE_puxStackBuffer;
    klee_make_symbolic_controllable(&KLEE_puxStackBuffer, sizeof(KLEE_puxStackBuffer), "KLEE_puxStackBuffer", true);
    StaticTask_t * const * KLEE_pxTaskBuffer;
    klee_make_symbolic_controllable(&KLEE_pxTaskBuffer, sizeof(KLEE_pxTaskBuffer), "KLEE_pxTaskBuffer", true);
    MPU_xTaskCreateStatic(KLEE_pxTaskCode, KLEE_pcName, KLEE_ulStackDepth, KLEE_pvParameters, KLEE_uxPriority, KLEE_puxStackBuffer, KLEE_pxTaskBuffer);
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
    return 0;
}
