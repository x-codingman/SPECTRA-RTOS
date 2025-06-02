#include "tx_api.h"
#include "txm_module.h"
#include "klee/klee.h"
#include "klee_help.h"

extern TX_THREAD *    _tx_thread_current_ptr;

UCHAR                   pool_start[9120];

int main()
{
    _txm_module_manager_object_pool_created = true;
    klee_make_symbolic_controllable(&_tx_thread_current_ptr, sizeof(_tx_thread_current_ptr), "_tx_thread_current_ptr", false);
    TXM_MODULE_INSTANCE *module_instance = _tx_thread_current_ptr -> tx_thread_module_instance_ptr;
    TX_THREAD * KLEE_TX_thread_ptr;
    klee_make_symbolic_controllable(&KLEE_TX_thread_ptr, sizeof(KLEE_TX_thread_ptr), "KLEE_TX_thread_ptr", true);
    CHAR * KLEE_TX_name_ptr;
    klee_make_symbolic_controllable(&KLEE_TX_name_ptr, sizeof(KLEE_TX_name_ptr), "KLEE_TX_name_ptr", true);
    VOID (*entry_function)(ULONG entry_input);
    klee_make_symbolic_controllable(&entry_function, sizeof(entry_function), "entry_function", true);
    ULONG KLEE_TX_entry_input;
    klee_make_symbolic_controllable(&KLEE_TX_entry_input, sizeof(KLEE_TX_entry_input), "KLEE_TX_entry_input", true);
    VOID * KLEE_TX_stack_start;
    klee_make_symbolic_controllable(&KLEE_TX_stack_start, sizeof(KLEE_TX_stack_start), "KLEE_TX_stack_start", true);
    ULONG KLEE_TX_stack_size;
    klee_make_symbolic_controllable(&KLEE_TX_stack_size, sizeof(KLEE_TX_stack_size), "KLEE_TX_stack_size", true);
    UINT KLEE_TX_priority;
    klee_make_symbolic_controllable(&KLEE_TX_priority, sizeof(KLEE_TX_priority), "KLEE_TX_priority", true);
    UINT KLEE_TX_preempt_threshold;
    klee_make_symbolic_controllable(&KLEE_TX_preempt_threshold, sizeof(KLEE_TX_preempt_threshold), "KLEE_TX_preempt_threshold", true);
    ULONG KLEE_TX_time_slice;
    klee_make_symbolic_controllable(&KLEE_TX_time_slice, sizeof(KLEE_TX_time_slice), "KLEE_TX_time_slice", true);
    UINT KLEE_TX_auto_start;
    klee_make_symbolic_controllable(&KLEE_TX_auto_start, sizeof(KLEE_TX_auto_start), "KLEE_TX_auto_start", true);
    UINT KLEE_TX_thread_control_block_size;
    klee_make_symbolic_controllable(&KLEE_TX_thread_control_block_size, sizeof(KLEE_TX_thread_control_block_size), "KLEE_TX_thread_control_block_size", true);
    ALIGN_TYPE extra_parameters[9];
    extra_parameters[0] = (ALIGN_TYPE) entry_function;
    extra_parameters[1] = (ALIGN_TYPE) KLEE_TX_entry_input;
    extra_parameters[2] = (ALIGN_TYPE) KLEE_TX_stack_start;
    extra_parameters[3] = (ALIGN_TYPE) KLEE_TX_stack_size;
    extra_parameters[4] = (ALIGN_TYPE) KLEE_TX_priority;
    extra_parameters[5] = (ALIGN_TYPE) KLEE_TX_preempt_threshold;
    extra_parameters[6] = (ALIGN_TYPE) KLEE_TX_time_slice;
    extra_parameters[7] = (ALIGN_TYPE) KLEE_TX_auto_start;
    extra_parameters[8] = (ALIGN_TYPE) KLEE_TX_thread_control_block_size;
    _txm_module_manager_tx_thread_create_dispatch(module_instance, KLEE_TX_thread_ptr, KLEE_TX_name_ptr, extra_parameters);
}
