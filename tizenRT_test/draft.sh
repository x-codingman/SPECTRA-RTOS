# mq_getattr
rm -rf /home/klee/klee_src/test-rtos/tizenrt/symbolic_execution/output/mq_getattr &&\
rm -rf /home/klee/klee_src/test-rtos/tizenrt/symbolic_execution/test-info-output/mq_getattr &&\
/home/klee/klee_src/build/bin/klee \
  --search=dfs \
  -debug-print-instructions=all:stderr \
  --test-info-output-dir=/home/klee/klee_src/test-rtos/tizenrt/symbolic_execution/test-info-output/mq_getattr \
  --output-dir=/home/klee/klee_src/test-rtos/tizenrt/symbolic_execution/output/mq_getattr \
  --test-target-name=mq_getattr \
  /home/klee/klee_src/tizenRT_test/test_bc_files/mq_getattr.test.bc




