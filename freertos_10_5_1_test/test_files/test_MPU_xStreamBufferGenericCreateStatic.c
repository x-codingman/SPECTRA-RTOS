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
    size_t KLEE_xBufferSizeBytes;
    klee_make_symbolic_controllable(&KLEE_xBufferSizeBytes, sizeof(KLEE_xBufferSizeBytes), "KLEE_xBufferSizeBytes", true);
    size_t KLEE_xTriggerLevelBytes;
    klee_make_symbolic_controllable(&KLEE_xTriggerLevelBytes, sizeof(KLEE_xTriggerLevelBytes), "KLEE_xTriggerLevelBytes", true);
    BaseType_t KLEE_xIsMessageBuffer;
    klee_make_symbolic_controllable(&KLEE_xIsMessageBuffer, sizeof(KLEE_xIsMessageBuffer), "KLEE_xIsMessageBuffer", true);
    uint8_t * const * KLEE_pucStreamBufferStorageArea;
    klee_make_symbolic_controllable(&KLEE_pucStreamBufferStorageArea, sizeof(KLEE_pucStreamBufferStorageArea), "KLEE_pucStreamBufferStorageArea", true);
    StaticStreamBuffer_t * const * KLEE_pxStaticStreamBuffer;
    klee_make_symbolic_controllable(&KLEE_pxStaticStreamBuffer, sizeof(KLEE_pxStaticStreamBuffer), "KLEE_pxStaticStreamBuffer", true);
    StreamBufferCallbackFunction_t KLEE_pxSendCompletedCallback;
    klee_make_symbolic_controllable(&KLEE_pxSendCompletedCallback, sizeof(KLEE_pxSendCompletedCallback), "KLEE_pxSendCompletedCallback", true);
    StreamBufferCallbackFunction_t KLEE_pxReceiveCompletedCallback;
    klee_make_symbolic_controllable(&KLEE_pxReceiveCompletedCallback, sizeof(KLEE_pxReceiveCompletedCallback), "KLEE_pxReceiveCompletedCallback", true);
    StreamBufferHandle_t KLEE_return_val;
    klee_make_symbolic_controllable(&KLEE_return_val, sizeof(KLEE_return_val), "KLEE_kernel_return_val", true);
    KLEE_return_val = MPU_xStreamBufferGenericCreateStatic(KLEE_xBufferSizeBytes, KLEE_xTriggerLevelBytes, KLEE_xIsMessageBuffer, KLEE_pucStreamBufferStorageArea, KLEE_pxStaticStreamBuffer, KLEE_pxSendCompletedCallback, KLEE_pxReceiveCompletedCallback);
    return 0;
}
