#include "klee_help.h"
#include <FreeRTOS.h>
#include <task.h>
#include <queue.h>
#include <klee/klee.h>
#include <list.h>
#include <stream_buffer.h>
#include <timers.h>
#include <event_groups.h>
#define STACK_SIZE 200
#define MPU_ENABLE_ADDRESS_START 0xefff2000
#define MPU_ENABLE_ADDRESS_END 0xefff4000
#define ATTACK_CAPABILITY_REGION_START 0x80000000
#define ATTACK_CAPABILITY_REGION_END 0x8fffffff
void vTaskFunction1( void *pvParameters );
int main()
{
xTaskCreate(vTaskFunction1, "Task1", STACK_SIZE, NULL, 1, NULL);
StreamBufferHandle_t KLEE_xStreamBuffer;
void * KLEE_pvRxData;
size_t KLEE_xBufferLengthBytes;
TickType_t KLEE_xTicksToWait;
klee_make_symbolic_controllable(&KLEE_xStreamBuffer, sizeof(KLEE_xStreamBuffer), "KLEE_xStreamBuffer", true);
klee_make_symbolic_controllable(&KLEE_pvRxData, sizeof(KLEE_pvRxData), "KLEE_pvRxData", true);
klee_make_symbolic_controllable(&KLEE_xBufferLengthBytes, sizeof(KLEE_xBufferLengthBytes), "KLEE_xBufferLengthBytes", true);
klee_make_symbolic_controllable(&KLEE_xTicksToWait, sizeof(KLEE_xTicksToWait), "KLEE_xTicksToWait", true);
if (KLEE_xStreamBuffer < KERNEL_REGION_START || KLEE_xStreamBuffer > KERNEL_REGION_END) { return 0; }
if (KLEE_pvRxData < ATTACK_CAPABILITY_REGION_START || KLEE_pvRxData > ATTACK_CAPABILITY_REGION_END) { return 0; }
xStreamBufferReceive(KLEE_xStreamBuffer,KLEE_pvRxData,KLEE_xBufferLengthBytes,KLEE_xTicksToWait);
return 0;
}
void vTaskFunction1( void *pvParameters )
{
assert(0);
}
