#vTaskGetInfo
rm -rf /home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/output/vTaskGetInfo &&\
rm -rf /home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/test-info-output/vTaskGetInfo &&\
/home/klee/klee_src/build/bin/klee \
  --search=dfs \
  -debug-print-instructions=all:stderr \
  --test-info-output-dir=/home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/test-info-output/vTaskGetInfo \
  --output-dir=/home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/output/vTaskGetInfo \
  --test-target-name=vTaskGetInfo \
  /home/klee/klee_src/freertos_10_5_1_test/test_bc_files/test_MPU_vTaskGetInfo.test.bc

#vTaskDelete
rm -rf /home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/output/vTaskDelete &&\
rm -rf /home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/test-info-output/vTaskDelete &&\
/home/klee/klee_src/build/bin/klee \
  --search=dfs \
  -debug-print-instructions=all:stderr \
  --test-info-output-dir=/home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/test-info-output/vTaskDelete \
  --output-dir=/home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/output/vTaskDelete \
  --test-target-name=vTaskDelete \
  /home/klee/klee_src/freertos_10_5_1_test/test_bc_files/test_MPU_vTaskDelete.test.bc

#xStreamBufferReceive
rm -rf /home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/output/xStreamBufferReceive &&\
rm -rf /home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/test-info-output/xStreamBufferReceive &&\
/home/klee/klee_src/build/bin/klee \
  --search=dfs \
  -debug-print-instructions=all:stderr \
  --test-info-output-dir=/home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/test-info-output/xStreamBufferReceive \
  --output-dir=/home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/output/xStreamBufferReceive \
  --test-target-name=xStreamBufferReceive \
  /home/klee/klee_src/freertos_10_5_1_test/test_bc_files/test_MPU_xStreamBufferReceive.test.bc

#xStreamBufferSend
rm -rf /home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/output/xStreamBufferSend &&\
rm -rf /home/klee/klee_src/test-rtos/freertos-10.5.1/symbolic_execution/test-info-output/xStreamBufferSend &&\