#include "klee_help.h"
#include <FreeRTOS.h>
#include <task.h>
#include <queue.h>
#include <klee/klee.h>
#include <list.h>
#define STACK_SIZE 200
#define MPU_ENABLE_ADDRESS_START 0xefff2000
#define MPU_ENABLE_ADDRESS_END 0xefff4000
#define ATTACK_CAPABILITY_REGION_START 0x80000000
#define ATTACK_CAPABILITY_REGION_END 0x8fffffff
void vTaskFunction1( void *pvParameters );


bool isTested;
bool isRunApi;
int main()
{
isTested = false;
isRunApi = false;
TaskHandle_t xTaskToResume;
klee_make_symbolic_controllable(&xTaskToResume, sizeof(xTaskToResume), "xTaskToResume", false);
if(xTaskToResume == NULL) return 0;
MPU_vTaskResumeImpl(xTaskToResume);
klee_access_control_message(isTested&&!isRunApi);
return 0;
}
void vTaskFunction1( void *pvParameters )
{
    assert(0);
}

void vTaskResume(TaskHandle_t xTaskToResume ){
    isRunApi=true;
}

bool portIS_TASK_PRIVILEGED(){
    isTested = true;
    return false;
}
