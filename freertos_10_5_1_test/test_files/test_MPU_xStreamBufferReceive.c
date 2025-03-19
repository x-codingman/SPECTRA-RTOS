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
    StreamBufferHandle_t KLEE_xStreamBuffer;
    klee_make_symbolic_controllable(&KLEE_xStreamBuffer, sizeof(KLEE_xStreamBuffer), "KLEE_kernel_xStreamBuffer", true);
    void * * KLEE_pvRxData;
    klee_make_symbolic_controllable(&KLEE_pvRxData, sizeof(KLEE_pvRxData), "KLEE_pvRxData", true);
    size_t KLEE_xBufferLengthBytes;
    klee_make_symbolic_controllable(&KLEE_xBufferLengthBytes, sizeof(KLEE_xBufferLengthBytes), "KLEE_xBufferLengthBytes", true);
    TickType_t KLEE_xTicksToWait;
    klee_make_symbolic_controllable(&KLEE_xTicksToWait, sizeof(KLEE_xTicksToWait), "KLEE_xTicksToWait", true);
    size_t KLEE_return_val;
    klee_make_symbolic_controllable(&KLEE_return_val, sizeof(KLEE_return_val), "KLEE_return_val", true);
    KLEE_return_val = MPU_xStreamBufferReceive(KLEE_xStreamBuffer, KLEE_pvRxData, KLEE_xBufferLengthBytes, KLEE_xTicksToWait);
    return 0;
}
