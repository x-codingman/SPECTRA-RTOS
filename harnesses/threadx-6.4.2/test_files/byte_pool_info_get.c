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
    TX_BYTE_POOL * KLEE_TX_pool_ptr;
    klee_make_symbolic_controllable(&KLEE_TX_pool_ptr, sizeof(KLEE_TX_pool_ptr), "KLEE_TX_pool_ptr", true);
    CHAR ** KLEE_TX_name;
    klee_make_symbolic_controllable(&KLEE_TX_name, sizeof(KLEE_TX_name), "KLEE_TX_name", true);
    ULONG * KLEE_TX_available_bytes;
    klee_make_symbolic_controllable(&KLEE_TX_available_bytes, sizeof(KLEE_TX_available_bytes), "KLEE_TX_available_bytes", true);
    ULONG * KLEE_TX_fragments;
    klee_make_symbolic_controllable(&KLEE_TX_fragments, sizeof(KLEE_TX_fragments), "KLEE_TX_fragments", true);
    TX_THREAD ** KLEE_TX_first_suspended;
    klee_make_symbolic_controllable(&KLEE_TX_first_suspended, sizeof(KLEE_TX_first_suspended), "KLEE_TX_first_suspended", true);
    ULONG * KLEE_TX_suspended_count;
    klee_make_symbolic_controllable(&KLEE_TX_suspended_count, sizeof(KLEE_TX_suspended_count), "KLEE_TX_suspended_count", true);
    TX_BYTE_POOL ** KLEE_TX_next_pool;
    klee_make_symbolic_controllable(&KLEE_TX_next_pool, sizeof(KLEE_TX_next_pool), "KLEE_TX_next_pool", true);
    ALIGN_TYPE extra_parameters[5];
    extra_parameters[0] = (ALIGN_TYPE) KLEE_TX_available_bytes;
    extra_parameters[1] = (ALIGN_TYPE) KLEE_TX_fragments;
    extra_parameters[2] = (ALIGN_TYPE) KLEE_TX_first_suspended;
    extra_parameters[3] = (ALIGN_TYPE) KLEE_TX_suspended_count;
    extra_parameters[4] = (ALIGN_TYPE) KLEE_TX_next_pool;
    _txm_module_manager_tx_byte_pool_info_get_dispatch(module_instance, KLEE_TX_pool_ptr, KLEE_TX_name, extra_parameters);
}
