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
    const uint16_t KLEE_usStackDepth;
    klee_make_symbolic_controllable(&KLEE_usStackDepth, sizeof(KLEE_usStackDepth), "KLEE_usStackDepth", true);
    void * const * KLEE_pvParameters;
    klee_make_symbolic_controllable(&KLEE_pvParameters, sizeof(KLEE_pvParameters), "KLEE_pvParameters", true);
    UBaseType_t KLEE_uxPriority;
    klee_make_symbolic_controllable(&KLEE_uxPriority, sizeof(KLEE_uxPriority), "KLEE_uxPriority", true);
    TaskHandle_t * const * KLEE_pxCreatedTask;
    klee_make_symbolic_controllable(&KLEE_pxCreatedTask, sizeof(KLEE_pxCreatedTask), "KLEE_pxCreatedTask", true);
    MPU_xTaskCreate(KLEE_pxTaskCode, KLEE_pcName, KLEE_usStackDepth, KLEE_pvParameters, KLEE_uxPriority, KLEE_pxCreatedTask);
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
    return 0;
}
