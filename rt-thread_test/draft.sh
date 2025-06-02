
rm -rf /home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/output/sys_mutex_delete &&\
rm -rf /home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/test-info-output/sys_mutex_delete &&\
/home/klee/klee_src/build/bin/klee \
  --search=dfs \
  -debug-print-instructions=all:stderr \
  --test-info-output-dir=/home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/test-info-output/sys_mutex_delete \
  --output-dir=/home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/output/sys_mutex_delete \
  --test-target-name=sys_mutex_delete \
  /home/klee/klee_src/rt-thread_test/test_bc_files/sys_mutex_delete.test.bc



# sys_thread_startup
rm -rf /home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/output/sys_thread_startup &&\
rm -rf /home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/test-info-output/sys_thread_startup &&\
/home/klee/klee_src/build/bin/klee \
  --search=dfs \
  -debug-print-instructions=all:stderr \
  --test-info-output-dir=/home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/test-info-output/sys_thread_startup \
  --output-dir=/home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/output/sys_thread_startup \
  --test-target-name=sys_thread_startup \
  /home/klee/klee_src/rt-thread_test/test_bc_files/sys_thread_startup.test.bc

# sys_timer_settime
rm -rf /home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/output/sys_timer_settime &&\
rm -rf /home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/test-info-output/sys_timer_settime &&\
/home/klee/klee_src/build/bin/klee \
  --search=dfs \
  -debug-print-instructions=all:stderr \
  --test-info-output-dir=/home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/test-info-output/sys_timer_settime \
  --output-dir=/home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/output/sys_timer_settime \
  --test-target-name=sys_timer_settime \
  /home/klee/klee_src/rt-thread_test/test_bc_files/sys_timer_settime.test.bc

  # sys_mb_delete
rm -rf /home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/output/sys_mb_delete-1 &&\
rm -rf /home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/test-info-output/sys_mb_delete-1 &&\
/home/klee/klee_src/build/bin/klee \
  --search=dfs \
  -debug-print-instructions=all:stderr \
  --test-info-output-dir=/home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/test-info-output/sys_mb_delete-1 \
  --output-dir=/home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/output/sys_mb_delete-1 \
  --test-target-name=sys_mb_delete \
  /home/klee/klee_src/rt-thread_test/test_bc_files/sys_mb_delete.test.bc

#sys_channel_send
rm -rf /home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/output/sys_channel_send &&\
rm -rf /home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/test-info-output/sys_channel_send &&\
/home/klee/klee_src/build/bin/klee \
  --search=dfs \
  -debug-print-instructions=all:stderr \
  --test-info-output-dir=/home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/test-info-output/sys_channel_send \
  --output-dir=/home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/output/sys_channel_send \
  --test-target-name=sys_channel_send \
  /home/klee/klee_src/rt-thread_test/test_bc_files/sys_channel_send.test.bc


#sys_mq_send
rm -rf /home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/output/sys_mq_send &&\
rm -rf /home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/test-info-output/sys_mq_send &&\
/home/klee/klee_src/build/bin/klee \
  --search=dfs \
  -debug-print-instructions=all:stderr \
  --test-info-output-dir=/home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/test-info-output/sys_mq_send \
  --output-dir=/home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/output/sys_mq_send \
  --test-target-name=sys_mq_send \
  /home/klee/klee_src/rt-thread_test/test_bc_files/sys_mq_send.test.bc

#sys_timer_settime
rm -rf /home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/output/sys_timer_settime &&\
rm -rf /home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/test-info-output/sys_timer_settime &&\
/home/klee/klee_src/build/bin/klee \
  --search=dfs \
  -debug-print-instructions=all:stderr \
  --test-info-output-dir=/home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/test-info-output/sys_timer_settime \
  --output-dir=/home/klee/klee_src/test-rtos/rt-thread/symbolic_execution/output/sys_timer_settime \
  --test-target-name=sys_timer_settime \
  /home/klee/klee_src/rt-thread_test/test_bc_files/sys_timer_settime.test.bc


