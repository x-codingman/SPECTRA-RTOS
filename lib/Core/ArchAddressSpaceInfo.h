#ifndef ARCH_ADDRESS_SPACE_INFO_H
#define ARCH_ADDRESS_SPACE_INFO_H


/* MPU_CTRL (Armv8-M): memory-mapped enable / PRIVDEFENA / HFNMIENA; same as
 * MPU_ARMV8M_CTRL. Replaces prior test-only 0xefff3000. */
#define MPU_ENABLE_ADDRESS 0xE000ED94

/* Modeled MPU register window (see threadx_test/klee_help.h). Used to sanity-check
 * absolute addresses in checkMPUViolation. */
#define MPU_REGION_START 0xefff2000
#define MPU_REGION_END 0xefff4000

/* Armv8-M MPU registers in PPB (see Arm User Guide 107565 §3.2.1). Used for
 * checkMPUViolation fixed-value checks alongside the RTOS window above. */
#define MPU_ARMV8M_SCS_START 0xE000ED90
#define MPU_ARMV8M_SCS_END 0xE000EDC8 /* exclusive: through MAIR1 */

#define MPU_ARMV8M_TYPE 0xE000ED90
#define MPU_ARMV8M_CTRL 0xE000ED94
#define MPU_ARMV8M_RNR 0xE000ED98
#define MPU_ARMV8M_RBAR 0xE000ED9C
#define MPU_ARMV8M_RLAR 0xE000EDA0
#define MPU_ARMV8M_RBAR_A1 0xE000EDA4
#define MPU_ARMV8M_RLAR_A1 0xE000EDA8
#define MPU_ARMV8M_RBAR_A2 0xE000EDAC
#define MPU_ARMV8M_RLAR_A2 0xE000EDB0
#define MPU_ARMV8M_RBAR_A3 0xE000EDB4
#define MPU_ARMV8M_RLAR_A3 0xE000EDB8
#define MPU_ARMV8M_MAIR0 0xE000EDC0
#define MPU_ARMV8M_MAIR1 0xE000EDC4

#define ATTACK_CAPABILITY_REGION_START 0x80000000
#define ATTACK_CAPABILITY_REGION_END 0x8fffffff

#define PRIVILEGED_REGION_END 0x90000000
#define PRIVILEGED_REGION_START 0x9fffffff

#endif