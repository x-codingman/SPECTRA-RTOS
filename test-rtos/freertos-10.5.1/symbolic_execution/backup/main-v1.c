#include <FreeRTOS.h>
#include <task.h>
#include <queue.h>
#include <klee/klee.h>
// add to check out how does klee reason the array with symbolic index
#include <list.h>
static List_t pxReadyTasksLists[ configMAX_PRIORITIES ];

int main()
{
    // TaskHandle_t xTaskToNotify;
    // klee_make_symbolic(&xTaskToNotify,sizeof(xTaskToNotify),"xTaskToNotify");
    // UBaseType_t uxIndexToNotify;
    // klee_make_symbolic(&uxIndexToNotify,sizeof(uxIndexToNotify),"uxIndexToNotify");
    // uint32_t ulValue;
    // klee_make_symbolic(&ulValue,sizeof(ulValue),"ulValue");
    // eNotifyAction eAction;
    // klee_make_symbolic(&eAction,sizeof(eAction),"eAction");
    // uint32_t * pulPreviousNotificationValue;
    // klee_make_symbolic(&pulPreviousNotificationValue,sizeof(pulPreviousNotificationValue),"pulPreviousNotificationValue");

    // xTaskGenericNotify(xTaskToNotify,uxIndexToNotify,ulValue,eAction,pulPreviousNotificationValue );

// The source file is changed
    // UBaseType_t uxIndexToWait;
    // klee_make_symbolic(&uxIndexToWait,sizeof(uxIndexToWait),"uxIndexToWait");
    // uint32_t ulBitsToClearOnEntry;
    // klee_make_symbolic(&ulBitsToClearOnEntry,sizeof(ulBitsToClearOnEntry),"ulBitsToClearOnEntry");
    // uint32_t ulBitsToClearOnExit;
    // klee_make_symbolic(&ulBitsToClearOnExit,sizeof(ulBitsToClearOnExit),"ulBitsToClearOnExit");
    // uint32_t * pulNotificationValue;
    // klee_make_symbolic(&pulNotificationValue,sizeof(pulNotificationValue),"pulNotificationValue");
    // TickType_t xTicksToWait;
    // klee_make_symbolic(&xTicksToWait,sizeof(xTicksToWait),"xTicksToWait");
    // xTaskGenericNotifyWait(uxIndexToWait, ulBitsToClearOnEntry, ulBitsToClearOnExit, pulNotificationValue, xTicksToWait );

    // TaskHandle_t xTaskToResume;
    // klee_make_symbolic(&xTaskToResume, sizeof(xTaskToResume), "xTaskToResume");
    // vTaskResume(xTaskToResume);

    // UBaseType_t uxIndexToWait;
    // klee_make_symbolic(&uxIndexToWait,sizeof(uxIndexToWait),"uxIndexToWait");
    // BaseType_t xClearCountOnExit;
    // klee_make_symbolic(&xClearCountOnExit,sizeof(xClearCountOnExit),"xClearCountOnExit");
    // TickType_t xTicksToWait;
    // klee_make_symbolic(&xTicksToWait,sizeof(xTicksToWait),"xTicksToWait");
    // ulTaskGenericNotifyTake(uxIndexToWait,xClearCountOnExit,xTicksToWait );

    QueueHandle_t xQueue;
    klee_make_symbolic(&xQueue,sizeof(xQueue),"xQueue");
    const void * const pvItemToQueue;
    klee_make_symbolic(&pvItemToQueue,sizeof(pvItemToQueue),"pvItemToQueue");
    TickType_t xTicksToWait;
    klee_make_symbolic(&xTicksToWait,sizeof(xTicksToWait),"xTicksToWait");
    const BaseType_t xCopyPosition;
    klee_make_symbolic(&xCopyPosition,sizeof(xCopyPosition),"xCopyPosition");
    xQueueGenericSend(xQueue,pvItemToQueue,xTicksToWait,xCopyPosition );

    // QueueHandle_t xQueue;
    // klee_make_symbolic(&xQueue, sizeof(xQueue), "xQueue");
    // BaseType_t xNewQueue;
    // klee_make_symbolic(&xNewQueue, sizeof(xNewQueue), "xNewQueue");
    // xQueueGenericReset(xQueue, xNewQueue );

    // to check out how does klee reason the array with symbolic index
    // UBaseType_t uxTopPriority;
    // klee_make_symbolic(&uxTopPriority, sizeof(uxTopPriority), "uxTopPriority");
    // TaskHandle_t xTask;
    // klee_make_symbolic(&xTask, sizeof(xTask), "xTask");
    // listGET_OWNER_OF_NEXT_ENTRY(xTask, &( pxReadyTasksLists[ uxTopPriority ] ) );
    return 0;
}