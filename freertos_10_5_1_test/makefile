CC                    := clang

BUILD_DIR             := ./build

BUILD_DIR_ABS         := $(abspath $(BUILD_DIR))

FREERTOS_DIR_REL      := ../test-rtos/freertos-10.5.1/Source
FREERTOS_DIR          := $(abspath $(FREERTOS_DIR_REL))

KERNEL_DIR            := ${FREERTOS_DIR}/

#TARGET_DIR            := /home/klee/FreeRTOS-kernel-revision/portable/GCC/ARM_CM33_NTZ/non_secure


KLEE_INCLUDE_DIR      := /home/klee/klee_src/include/


INCLUDE_DIRS          := -I.
# INCLUDE_DIRS          += -I/usr/lib/gcc/arm-none-eabi/6.3.1/include
# INCLUDE_DIRS          += -I/usr/lib/gcc/arm-none-eabi/6.3.1/include-fixed
# INCLUDE_DIRS          += -I/usr/lib/gcc/arm-none-eabi/6.3.1/../../../arm-none-eabi/include
# INCLUDE_DIRS          += -I${TARGET_DIR}/
INCLUDE_DIRS          += -I${KLEE_INCLUDE_DIR}
INCLUDE_DIRS          += -I${KERNEL_DIR}/include
INCLUDE_DIRS          += -I${KERNEL_DIR}/symbolic_execution
INCLUDE_DIRS          += -I${KERNEL_DIR}/portable/ThirdParty/GCC/Posix
INCLUDE_DIRS          += -I${KERNEL_DIR}/portable/ThirdParty/GCC/Posix/utils
# INCLUDE_DIRS          += -I/home/master/Downloads/FreeRTOSv202212.01/FreeRTOS/Source/portable/GCC/ARM_CM33/non_secure/portmacrocommon.h

#SOURCE_FILES          := $(wildcard *.c)
SOURCE_FILES          += $(wildcard ${FREERTOS_DIR}/*.c)
# SOURCE_FILES          += $(wildcard ${TARGET_DIR}/*.c)
#SOURCE_FILES          += ${FREERTOS_DIR}/Source/portable/Common/mpu_wrappers.c
# Memory manager (use malloc() / free() )
SOURCE_FILES          += ${KERNEL_DIR}/portable/MemMang/heap_3.c
# posix port
SOURCE_FILES          += ${KERNEL_DIR}/portable/ThirdParty/GCC/Posix/port.c
SOURCE_FILES          += ${KERNEL_DIR}/portable/ThirdParty/GCC/Posix/utils/wait_for_event.c



BC_FILES              := $(SOURCE_FILES:%.c=$(BUILD_DIR)/%.bc)
TEST_SOURCE_FILES     := $(wildcard test_files/*.c)
TEST_BC_DIR           := ./test_bc_files
TEST_BC_FILES         := $(TEST_SOURCE_FILES:test_files/%.c=$(TEST_BC_DIR)/%.test.bc)
# BC_FILES              += $(wildcard /home/klee/klee_build/runtime/POSIX/fd64_Release+Debug+Asserts.bc)
# BC_FILES              += $(wildcard /home/klee/klee_build/runtime/POSIX/fd_init64_Release+Debug+Asserts.bc)
# BC_FILES              += $(wildcard /home/klee/klee_build/runtime/POSIX/illegal64_Release+Debug+Asserts.bc)
# BC_FILES              += $(wildcard /home/klee/klee_build/runtime/POSIX/klee_init_env64_Release+Debug+Asserts.bc)
# BC_FILES              += $(wildcard /home/klee/klee_build/runtime/POSIX/stubs64_Release+Debug+Asserts.bc)

CFLAGS                :=  -emit-llvm -c -g -O0 
# CFLAGS                += --sysroot=/usr/lib/gcc/arm-none-eabi/6.3.1


all: $(TEST_BC_FILES) 



$(BUILD_DIR)/%.bc : %.c 
	-mkdir -p $(@D)
	$(CC) $(INCLUDE_DIRS) $(CFLAGS) $< -o $@

# result.bc : $(BC_FILES)
# 	-mkdir -p ${@D}
# 	llvm-link $^ -o $@

# vTaskDelay.bc : $(BC_FILES)
# 	-mkdir -p ${@D}
# 	llvm-link $^ -o $@

# vTaskDelayUntil.bc : $(BC_FILES)
# 	-mkdir -p ${@D}
# 	llvm-link $^ -o $@

# xTaskAbortDelay.bc : $(BC_FILES)
# 	-mkdir -p ${@D}
# 	llvm-link $^ -o $@

# uxTaskPriorityGet.bc : $(BC_FILES)
# 	-mkdir -p ${@D}
# 	llvm-link $^ -o $@

# eTaskGetState.bc : $(BC_FILES)
# 	-mkdir -p ${@D}
# 	llvm-link $^ -o $@
%.bc : %.c 
	-mkdir -p $(@D)
	$(CC) $(INCLUDE_DIRS) $(CFLAGS) $< -o $@

$(TEST_BC_DIR)/%.test.bc : $(BC_FILES) test_files/%.bc
	-mkdir -p ${@D}
	llvm-link $^ -o $@


clean:
	rm -rf $(BUILD_DIR) $(TEST_BC_DIR) %.bc

	