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
    TX_EVENT_FLAGS_GROUP * KLEE_TX_group_ptr;
    klee_make_symbolic_controllable(&KLEE_TX_group_ptr, sizeof(KLEE_TX_group_ptr), "KLEE_TX_group_ptr", true);
    ULONG KLEE_TX_requested_flags;
    klee_make_symbolic_controllable(&KLEE_TX_requested_flags, sizeof(KLEE_TX_requested_flags), "KLEE_TX_requested_flags", true);
    UINT KLEE_TX_get_option;
    klee_make_symbolic_controllable(&KLEE_TX_get_option, sizeof(KLEE_TX_get_option), "KLEE_TX_get_option", true);
    ULONG * KLEE_TX_actual_flags_ptr;
    klee_make_symbolic_controllable(&KLEE_TX_actual_flags_ptr, sizeof(KLEE_TX_actual_flags_ptr), "KLEE_TX_actual_flags_ptr", true);
    ULONG KLEE_TX_wait_option;
    klee_make_symbolic_controllable(&KLEE_TX_wait_option, sizeof(KLEE_TX_wait_option), "KLEE_TX_wait_option", true);
    ALIGN_TYPE extra_parameters[3];
    extra_parameters[0] = (ALIGN_TYPE) KLEE_TX_get_option;
    extra_parameters[1] = (ALIGN_TYPE) KLEE_TX_actual_flags_ptr;
    extra_parameters[2] = (ALIGN_TYPE) KLEE_TX_wait_option;
    _txm_module_manager_tx_event_flags_get_dispatch(module_instance, KLEE_TX_group_ptr, KLEE_TX_requested_flags, extra_parameters);
}
