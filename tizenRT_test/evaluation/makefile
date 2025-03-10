
include /home/klee/klee_src/test-rtos/tizenrt/build/configs/stm32h745zi-nucleo/hello/defconfig


CC                    := clang

BUILD_DIR             := ./build
BUILD_EXTRA_DIR       := ./build_extra
BUILD_DIR_ABS         := $(abspath $(BUILD_DIR))

RTOS_REL      := /home/klee/klee_src/test-rtos/tizenrt
RTOS_DIR          := $(abspath $(RTOS_REL))

KERNEL_DIR            := ${RTOS_DIR}/os/kernel
OS_DIR            := ${RTOS_DIR}/os
#TARGET_DIR            := /home/klee/FreeRTOS-kernel-revision/portable/GCC/ARM_CM33_NTZ/non_secure


KLEE_INCLUDE_DIR      := /home/klee/klee_src/include/


INCLUDE_DIRS          := -I.


INCLUDE_DIRS          += -I${KLEE_INCLUDE_DIR}
INCLUDE_DIRS          += -I${RTOS_DIR}/os/include
INCLUDE_DIRS          += -I${RTOS_DIR}/os/kernel
INCLUDE_DIRS          += -I${RTOS_DIR}/os/arch/arm/include
INCLUDE_DIRS          += -I${RTOS_DIR}/os/pm
INCLUDE_DIRS          += -I${RTOS_DIR}/os/fs

INCLUDE_DIRS          += -I${RTOS_DIR}/os/fs/smartfs
INCLUDE_DIRS          += -I${RTOS_DIR}/os/fs/tmpfs
INCLUDE_DIRS          += -I${RTOS_DIR}/os/arch/arm/src/common
INCLUDE_DIRS          += -I${RTOS_DIR}/os/include/arch/chip
INCLUDE_DIRS          += -I${RTOS_DIR}/os/arch/arm/src/armv7-m
INCLUDE_DIRS          += -I/home/klee/klee_src/test-rtos/tizenrt/os/board/rtl8730e/src/component/file_system/fatfs/r0.14b/include/ff.h

SOURCE_FILES          := $(shell find ${OS_DIR} -type f -name '*.c')
# SOURCE_FILES          += $(wildcard ${KERNEL_DIR}/../arch/arm/src/armv7-m/*.c)
SOURCE_FILES          += $(wildcard ${KERNEL_DIR}/../arch/arm/src/common/*.c)
# SOURCE_FILES          += $(wildcard ${KERNEL_DIR}/../arch/arm/src/chip/*.c)

IGNORE_FILES  := ${KERNEL_DIR}/debug/mem_leak_checker.c
IGNORE_FILES  += ${KERNEL_DIR}/log_dump/log_dump.c
IGNORE_FILES  += ${KERNEL_DIR}/task_monitor/task_monitor.c
IGNORE_FILES  += ${KERNEL_DIR}/preference/preference_common.c
IGNORE_FILES  += ${KERNEL_DIR}/preference/preference_remove.c
IGNORE_FILES  += ${KERNEL_DIR}/preference/preference_write.c
IGNORE_FILES  += ${KERNEL_DIR}/../arch/arm/src/armv7-m/up_releasepending.c
IGNORE_FILES  += ${KERNEL_DIR}/../arch/arm/src/armv7-m/up_unblocktask.c
IGNORE_FILES  += ${KERNEL_DIR}/../arch/arm/src/armv7-m/up_initialstate.c
IGNORE_FILES  += ${KERNEL_DIR}/../arch/arm/src/armv7-m/up_svcall.c
IGNORE_FILES  += ${KERNEL_DIR}/../arch/arm/src/armv7-m/up_vectors.c
IGNORE_FILES  += ${KERNEL_DIR}/../arch/arm/src/armv7-m/up_setupregions.c
IGNORE_FILES  += ${KERNEL_DIR}/../arch/arm/src/armv7-m/up_mpusavecontext.c
IGNORE_FILES  += ${KERNEL_DIR}/../arch/arm/src/armv7-m/up_mpurestorecontext.c
IGNORE_FILES  += ${KERNEL_DIR}/../arch/arm/src/armv7-m/up_mpu.c
IGNORE_FILES  += ${KERNEL_DIR}/../arch/arm/src/common/up_task_start.c
IGNORE_FILES  += ${KERNEL_DIR}/../arch/arm/src/common/up_etherstub.c


IGNORE_FILES  += $(shell find ${OS_DIR}/pm/ -type f -name '*.c')
IGNORE_FILES  += $(shell find ${OS_DIR}/logm/ -type f -name '*.c')
IGNORE_FILES  += $(shell find ${OS_DIR}/drivers/ -type f -name '*.c')
IGNORE_FILES  += $(shell find ${OS_DIR}/syscall/ -type f -name '*.c')
IGNORE_FILES  += $(shell find ${OS_DIR}/binfmt/ -type f -name '*.c')
IGNORE_FILES  += $(shell find ${OS_DIR}/net/ -type f -name '*.c')
IGNORE_FILES  += $(shell find ${OS_DIR}/arch/ -type f -name '*.c')
IGNORE_FILES  += $(shell find ${OS_DIR}/board/ -type f -name '*.c')
IGNORE_FILES  += $(shell find ${OS_DIR}/tools/ -type f -name '*.c')
IGNORE_FILES  += $(shell find ${OS_DIR}/userspace/ -type f -name '*.c')
IGNORE_FILES  += $(shell find ${OS_DIR}/mm/ -type f -name '*.c')
IGNORE_FILES  += $(shell find ${OS_DIR}/include/ -type f -name '*.c')
IGNORE_FILES  += $(shell find ${OS_DIR}/se/ -type f -name '*.c')
IGNORE_FILES  += $(shell find ${OS_DIR}/fs/driver/ -type f -name '*.c')
IGNORE_FILES  += $(shell find ${OS_DIR}/fs/tmpfs/ -type f -name '*.c')
IGNORE_FILES  += $(shell find ${OS_DIR}/wqueue -type f -name '*.c')
IGNORE_FILES  += $(shell find ${OS_DIR}/fs/smartfs -type f -name '*.c')
IGNORE_FILES  += $(shell find ${OS_DIR}/fs/romfs -type f -name '*.c')
IGNORE_FILES  += $(shell find ${OS_DIR}/fs/mqueue -type f -name '*.c')

NEW_SOURCE_FILES := $(filter-out $(IGNORE_FILES), $(SOURCE_FILES))




NEW_SOURCE_BC_FILES              := $(NEW_SOURCE_FILES:%.c=$(BUILD_DIR)/source/%.bc)
TEST_SOURCE_FILES     := $(wildcard test_files/*.c)
TEST_BC_FILES         := $(TEST_SOURCE_FILES:%.c= $(BUILD_DIR)/test_files/%.bc)
TEST_FINAL_BC_FILES         := $(TEST_SOURCE_FILES:%.c= $(BUILD_DIR)/test_files/%.test.bc)
# BC_FILES              += $(wildcard /home/klee/klee_build/runtime/POSIX/fd64_Release+Debug+Asserts.bc)
# BC_FILES              += $(wildcard /home/klee/klee_build/runtime/POSIX/fd_init64_Release+Debug+Asserts.bc)
# BC_FILES              += $(wildcard /home/klee/klee_build/runtime/POSIX/illegal64_Release+Debug+Asserts.bc)
# BC_FILES              += $(wildcard /home/klee/klee_build/runtime/POSIX/klee_init_env64_Release+Debug+Asserts.bc)
# BC_FILES              += $(wildcard /home/klee/klee_build/runtime/POSIX/stubs64_Release+Debug+Asserts.bc)



CFLAGS                :=  -emit-llvm -c -w -g  -Wundef
# CFLAGS                += --sysroot=/usr/lib/gcc/arm-none-eabi/6.3.1




all: $(TEST_FINAL_BC_FILES) $(NEW_SOURCE_BC_FILES)
$(TEST_FINAL_BC_FILES):$(NEW_SOURCE_BC_FILES) 


define find_deps
  $(shell find $(BUILD_DIR) -type f -name $(1).bc)
endef



$(BUILD_DIR)/%.bc : %.c 
	-mkdir -p $(@D)
	$(CC) $(INCLUDE_DIRS) $(CFLAGS) $< -o $@

$(BUILD_DIR)/source/%.bc : %.c
	-mkdir -p $(@D)
	$(CC) $(INCLUDE_DIRS) $(CFLAGS) $< -o $@

$(BUILD_DIR)/test_files/%.bc : %.c 
	-mkdir -p $(@D)
	$(CC) $(INCLUDE_DIRS) $(CFLAGS) $< -o $@

# $(BUILD_DIR)/test_files/test_files/%.test.bc: $(BUILD_DIR)/test_files/test_files/%.bc 
# 	llvm-link $(call find_deps,$*) -o $@


$(BUILD_DIR)/test_files/test_files/%.test.bc: $(BUILD_DIR)/test_files/test_files/%.bc $(NEW_SOURCE_BC_FILES)
	llvm-link $^ -o $@



clean:
	rm -rf $(BUILD_DIR) 