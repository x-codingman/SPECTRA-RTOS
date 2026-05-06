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
    CHAR ** KLEE_TX_name;
    klee_make_symbolic_controllable(&KLEE_TX_name, sizeof(KLEE_TX_name), "KLEE_TX_name", true);
    ULONG * KLEE_TX_current_value;
    klee_make_symbolic_controllable(&KLEE_TX_current_value, sizeof(KLEE_TX_current_value), "KLEE_TX_current_value", true);
    TX_THREAD ** KLEE_TX_first_suspended;
    klee_make_symbolic_controllable(&KLEE_TX_first_suspended, sizeof(KLEE_TX_first_suspended), "KLEE_TX_first_suspended", true);
    ULONG * KLEE_TX_suspended_count;
    klee_make_symbolic_controllable(&KLEE_TX_suspended_count, sizeof(KLEE_TX_suspended_count), "KLEE_TX_suspended_count", true);
    TX_SEMAPHORE ** KLEE_TX_next_semaphore;
    klee_make_symbolic_controllable(&KLEE_TX_next_semaphore, sizeof(KLEE_TX_next_semaphore), "KLEE_TX_next_semaphore", true);
    ALIGN_TYPE extra_parameters[4];
    extra_parameters[0] = (ALIGN_TYPE) KLEE_TX_current_value;
    extra_parameters[1] = (ALIGN_TYPE) KLEE_TX_first_suspended;
    extra_parameters[2] = (ALIGN_TYPE) KLEE_TX_suspended_count;
    extra_parameters[3] = (ALIGN_TYPE) KLEE_TX_next_semaphore;
    _txm_module_manager_tx_semaphore_info_get_dispatch(module_instance, KLEE_TX_semaphore_ptr, KLEE_TX_name, extra_parameters);
}
