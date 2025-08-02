#timer_delete
rm -rf /home/klee/klee_src/test-rtos/threadx-5.3/symbolic_execution/output/timer_delete &&\
rm -rf /home/klee/klee_src/test-rtos/threadx-5.3/symbolic_execution/test-info-output/timer_delete &&\
/home/klee/klee_src/build/bin/klee \
  --search=dfs \
  -debug-print-instructions=all:stderr \
  --test-info-output-dir=/home/klee/klee_src/test-rtos/threadx-5.3/symbolic_execution/test-info-output/timer_delete \
  --output-dir=/home/klee/klee_src/test-rtos/threadx-5.3/symbolic_execution/output/timer_delete \
  --test-target-name=timer_delete \
  /home/klee/klee_src/threadx_test/test_bc_files/timer_delete.test.bc

  #thread_preemption_change
  rm -rf /home/klee/klee_src/test-rtos/threadx-5.3/symbolic_execution/output/thread_preemption_change &&\
  rm -rf /home/klee/klee_src/test-rtos/threadx-5.3/symbolic_execution/test-info-output/thread_preemption_change &&\
  /home/klee/klee_src/build/bin/klee \
  --search=dfs \
  -debug-print-instructions=all:stderr \
  --test-info-output-dir=/home/klee/klee_src/test-rtos/threadx-5.3/symbolic_execution/test-info-output/thread_preemption_change \
  --output-dir=/home/klee/klee_src/test-rtos/threadx-5.3/symbolic_execution/output/thread_preemption_change \
  --test-target-name=thread_preemption_change \
  /home/klee/klee_src/threadx_test/test_bc_files/thread_preemption_change.test.bc

  #event_flags_get
  rm -rf /home/klee/klee_src/test-rtos/threadx-6.4.2/symbolic_execution/output/event_flags_get &&\
  rm -rf /home/klee/klee_src/test-rtos/threadx-6.4.2/symbolic_execution/test-info-output/event_flags_get &&\
  /home/klee/klee_src/build/bin/klee \
  --search=dfs \
  -debug-print-instructions=all:stderr \
  --test-info-output-dir=/home/klee/klee_src/test-rtos/threadx-6.4.2/symbolic_execution/test-info-output/event_flags_get \
  --output-dir=/home/klee/klee_src/test-rtos/threadx-6.4.2/symbolic_execution/output/event_flags_get \
  --test-target-name=event_flags_get \
  /home/klee/klee_src/threadx_test_v6_4_2/test_bc_files/event_flags_get.test.bc


  #event_flags_set
  rm -rf /home/klee/klee_src/test-rtos/threadx-6.4.2/symbolic_execution/output/event_flags_set &&\
  rm -rf /home/klee/klee_src/test-rtos/threadx-6.4.2/symbolic_execution/test-info-output/event_flags_set &&\
  /home/klee/klee_src/build/bin/klee \
  --search=dfs \
  -debug-print-instructions=all:stderr \
  --test-info-output-dir=/home/klee/klee_src/test-rtos/threadx-6.4.2/symbolic_execution/test-info-output/event_flags_set \
  --output-dir=/home/klee/klee_src/test-rtos/threadx-6.4.2/symbolic_execution/output/event_flags_set \
  --test-target-name=event_flags_set \
  /home/klee/klee_src/threadx_test_v6_4_2/test_bc_files/event_flags_set.test.bc

