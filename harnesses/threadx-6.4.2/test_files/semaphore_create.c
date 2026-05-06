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
    TX_SEMAPHORE * KLEE_TX_semaphore_ptr;
    klee_make_symbolic_controllable(&KLEE_TX_semaphore_ptr, sizeof(KLEE_TX_semaphore_ptr), "KLEE_TX_semaphore_ptr", true);
    CHAR * KLEE_TX_name_ptr;
    klee_make_symbolic_controllable(&KLEE_TX_name_ptr, sizeof(KLEE_TX_name_ptr), "KLEE_TX_name_ptr", true);
    ULONG KLEE_TX_initial_count;
    klee_make_symbolic_controllable(&KLEE_TX_initial_count, sizeof(KLEE_TX_initial_count), "KLEE_TX_initial_count", true);
    UINT KLEE_TX_semaphore_control_block_size;
    klee_make_symbolic_controllable(&KLEE_TX_semaphore_control_block_size, sizeof(KLEE_TX_semaphore_control_block_size), "KLEE_TX_semaphore_control_block_size", true);
    ALIGN_TYPE extra_parameters[2];
    extra_parameters[0] = (ALIGN_TYPE) KLEE_TX_initial_count;
    extra_parameters[1] = (ALIGN_TYPE) KLEE_TX_semaphore_control_block_size;
    _txm_module_manager_tx_semaphore_create_dispatch(module_instance, KLEE_TX_semaphore_ptr, KLEE_TX_name_ptr, extra_parameters);
}
