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
    const void * KLEE_pvTxData;
    klee_make_symbolic_controllable(&KLEE_pvTxData, sizeof(KLEE_pvTxData), "KLEE_pvTxData", true);
    size_t KLEE_xDataLengthBytes;
    klee_make_symbolic_controllable(&KLEE_xDataLengthBytes, sizeof(KLEE_xDataLengthBytes), "KLEE_xDataLengthBytes", true);
    TickType_t KLEE_xTicksToWait;
    klee_make_symbolic_controllable(&KLEE_xTicksToWait, sizeof(KLEE_xTicksToWait), "KLEE_xTicksToWait", true);
    /* Stream Buffer API */ size_t KLEE_return_val;
    klee_make_symbolic_controllable(&KLEE_return_val, sizeof(KLEE_return_val), "KLEE_return_val", true);
    KLEE_return_val = MPU_xStreamBufferSend(KLEE_xStreamBuffer, KLEE_pvTxData, KLEE_xDataLengthBytes, KLEE_xTicksToWait);
    return 0;
}
