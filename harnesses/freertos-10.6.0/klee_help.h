#ifndef KLEE_HELP_H
    #define KLEE_HELP_H
 
    #include "stdbool.h"
    #include <stdint.h>

#define MPU_ENABLE_ADDRESS_START 0xefff2000
#define MPU_ENABLE_ADDRESS_END 0xefff4000
#define OTHER_REGION_START 0x70000000
#define OTHER_REGION_END 0x7fffffff
#define ATTACK_CAPABILITY_REGION_START 0x80000000
#define ATTACK_CAPABILITY_REGION_END 0x8fffffff
#define KERNEL_REGION_START 0x90000000
#define KERNEL_REGION_END 0x9fffffff

#define portTOTAL_NUM_REGIONS 8
#define portIS_PRIVILEGED()      xIsPrivileged() 

#define portRAISE_PRIVILEGE()

#define portRESET_PRIVILEGE() vResetPrivilege()
    typedef struct MPURegionSettings
    {
        uint32_t ulRBAR; /**< RBAR for the region. */
        uint32_t ulRLAR; /**< RLAR for the region. */
    } MPURegionSettings_t;

typedef struct MPU_SETTINGS
    {
        uint32_t ulMAIR0;                                              /**< MAIR0 for the task containing attributes for all the 4 per task regions. */
        MPURegionSettings_t xRegionsSettings[ portTOTAL_NUM_REGIONS ]; /**< Settings for 4 per task regions. */
    } xMPU_SETTINGS;




 
    




#endif