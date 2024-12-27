#ifndef KLEE_HELP_H
    #define KLEE_HELP_H
 
    #include "stdbool.h"
    #include <stdint.h>

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