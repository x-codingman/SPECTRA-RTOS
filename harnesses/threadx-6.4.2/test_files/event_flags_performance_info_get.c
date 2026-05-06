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
    ULONG * KLEE_TX_sets;
    klee_make_symbolic_controllable(&KLEE_TX_sets, sizeof(KLEE_TX_sets), "KLEE_TX_sets", true);
    ULONG * KLEE_TX_gets;
    klee_make_symbolic_controllable(&KLEE_TX_gets, sizeof(KLEE_TX_gets), "KLEE_TX_gets", true);
    ULONG * KLEE_TX_suspensions;
    klee_make_symbolic_controllable(&KLEE_TX_suspensions, sizeof(KLEE_TX_suspensions), "KLEE_TX_suspensions", true);
    ULONG * KLEE_TX_timeouts;
    klee_make_symbolic_controllable(&KLEE_TX_timeouts, sizeof(KLEE_TX_timeouts), "KLEE_TX_timeouts", true);
    ALIGN_TYPE extra_parameters[3];
    extra_parameters[0] = (ALIGN_TYPE) KLEE_TX_gets;
    extra_parameters[1] = (ALIGN_TYPE) KLEE_TX_suspensions;
    extra_parameters[2] = (ALIGN_TYPE) KLEE_TX_timeouts;
    _txm_module_manager_tx_event_flags_performance_info_get_dispatch(module_instance, KLEE_TX_group_ptr, KLEE_TX_sets, extra_parameters);
}
