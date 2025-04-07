1. Specify the following paths. In my test case, the threadx source folder is put in the /home/klee/klee_src/test-rtos/threadx-5.3/.

```
BUILD_DIR             := ./build
BUILD_EXTRA_DIR       := ./build_extra
KERNEL_DIR            := /home/klee/klee_src/test-rtos/threadx-5.3/
KLEE_DIR              := /home/klee/klee_src/
```

2. Run the commands below. These two commands will generate the intermediate bc files and the final test files, respectively.

```
make -j
make target
```

The final .test.bc files will be generated in the ./build/test_bc_files/.../evaluation_files folder.
