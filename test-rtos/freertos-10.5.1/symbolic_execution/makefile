CC                    := clang

BUILD_DIR             := ./build
BUILD_DIR_ABS         := $(abspath $(BUILD_DIR))

FREERTOS_DIR_REL      := ../../FreeRTOS
FREERTOS_DIR          := $(abspath $(FREERTOS_DIR_REL))

KERNEL_DIR            := ${FREERTOS_DIR}/Source

INCLUDE_DIRS          := -I.
INCLUDE_DIRS          += -I${KERNEL_DIR}/include
INCLUDE_DIRS          += -I${KERNEL_DIR}/portable/ThirdParty/GCC/Posix
INCLUDE_DIRS          += -I${KERNEL_DIR}/portable/ThirdParty/GCC/Posix/utils
# INCLUDE_DIRS          += -I/home/master/Downloads/FreeRTOSv202212.01/FreeRTOS/Source/portable/GCC/ARM_CM33/non_secure/portmacrocommon.h

SOURCE_FILES          := $(wildcard *.c)
SOURCE_FILES          += $(wildcard ${FREERTOS_DIR}/Source/*.c)
# Memory manager (use malloc() / free() )
SOURCE_FILES          += ${KERNEL_DIR}/portable/MemMang/heap_3.c
# posix port
SOURCE_FILES          += ${KERNEL_DIR}/portable/ThirdParty/GCC/Posix/port.c
SOURCE_FILES          += ${KERNEL_DIR}/portable/ThirdParty/GCC/Posix/utils/wait_for_event.c

BC_FILES              := $(SOURCE_FILES:%.c=$(BUILD_DIR)/%.bc)
# BC_FILES              += $(wildcard /home/klee/klee_build/runtime/POSIX/fd64_Release+Debug+Asserts.bc)
# BC_FILES              += $(wildcard /home/klee/klee_build/runtime/POSIX/fd_init64_Release+Debug+Asserts.bc)
# BC_FILES              += $(wildcard /home/klee/klee_build/runtime/POSIX/illegal64_Release+Debug+Asserts.bc)
# BC_FILES              += $(wildcard /home/klee/klee_build/runtime/POSIX/klee_init_env64_Release+Debug+Asserts.bc)
# BC_FILES              += $(wildcard /home/klee/klee_build/runtime/POSIX/stubs64_Release+Debug+Asserts.bc)

CFLAGS                := -emit-llvm -c -g -m64

all: $(BC_FILES) result.bc


$(BUILD_DIR)/%.bc : %.c 
	-mkdir -p $(@D)
	$(CC) $(INCLUDE_DIRS) $(CFLAGS) $< -o $@

result.bc : $(BC_FILES)
	-mkdir -p ${@D}
	llvm-link $^ -o $@

clean:
	rm -rf $(BUILD_DIR)