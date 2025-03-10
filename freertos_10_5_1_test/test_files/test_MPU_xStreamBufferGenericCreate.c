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
    size_t KLEE_xBufferSizeBytes;
    klee_make_symbolic_controllable(&KLEE_xBufferSizeBytes, sizeof(KLEE_xBufferSizeBytes), "KLEE_xBufferSizeBytes", true);
    size_t KLEE_xTriggerLevelBytes;
    klee_make_symbolic_controllable(&KLEE_xTriggerLevelBytes, sizeof(KLEE_xTriggerLevelBytes), "KLEE_xTriggerLevelBytes", true);
    BaseType_t KLEE_xIsMessageBuffer;
    klee_make_symbolic_controllable(&KLEE_xIsMessageBuffer, sizeof(KLEE_xIsMessageBuffer), "KLEE_xIsMessageBuffer", true);
    StreamBufferCallbackFunction_t KLEE_pxSendCompletedCallback;
    klee_make_symbolic_controllable(&KLEE_pxSendCompletedCallback, sizeof(KLEE_pxSendCompletedCallback), "KLEE_pxSendCompletedCallback", true);
    StreamBufferCallbackFunction_t KLEE_pxReceiveCompletedCallback;
    klee_make_symbolic_controllable(&KLEE_pxReceiveCompletedCallback, sizeof(KLEE_pxReceiveCompletedCallback), "KLEE_pxReceiveCompletedCallback", true);
    MPU_xStreamBufferGenericCreate(KLEE_xBufferSizeBytes, KLEE_xTriggerLevelBytes, KLEE_xIsMessageBuffer, KLEE_pxSendCompletedCallback, KLEE_pxReceiveCompletedCallback);
    assert(0);
}

#define STACK_SIZE 1000

int main()
{
    xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
    return 0;
}
