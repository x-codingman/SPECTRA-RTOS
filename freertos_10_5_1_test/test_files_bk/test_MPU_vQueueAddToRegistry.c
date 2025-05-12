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
extern TaskHandle_t pxCurrentTCB;
void vTaskFunction1();
void vTaskFunction1(){
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    TaskHandle_t initial_xTask;
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, &initial_xTask);
    QueueHandle_t KLEE_xQueue;
    klee_make_symbolic_controllable(&KLEE_xQueue, sizeof(KLEE_xQueue), "KLEE_kernel_xQueue", true);
    const char * * KLEE_pcName;
    klee_make_symbolic_controllable(&KLEE_pcName, sizeof(KLEE_pcName), "KLEE_pcName", true);
    MPU_vQueueAddToRegistry(KLEE_xQueue, KLEE_pcName);
    return 0;
}
