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
    ULONG * KLEE_TX_puts;
    klee_make_symbolic_controllable(&KLEE_TX_puts, sizeof(KLEE_TX_puts), "KLEE_TX_puts", true);
    ULONG * KLEE_TX_gets;
    klee_make_symbolic_controllable(&KLEE_TX_gets, sizeof(KLEE_TX_gets), "KLEE_TX_gets", true);
    ULONG * KLEE_TX_suspensions;
    klee_make_symbolic_controllable(&KLEE_TX_suspensions, sizeof(KLEE_TX_suspensions), "KLEE_TX_suspensions", true);
    ULONG * KLEE_TX_timeouts;
    klee_make_symbolic_controllable(&KLEE_TX_timeouts, sizeof(KLEE_TX_timeouts), "KLEE_TX_timeouts", true);
    ULONG * KLEE_TX_inversions;
    klee_make_symbolic_controllable(&KLEE_TX_inversions, sizeof(KLEE_TX_inversions), "KLEE_TX_inversions", true);
    ULONG * KLEE_TX_inheritances;
    klee_make_symbolic_controllable(&KLEE_TX_inheritances, sizeof(KLEE_TX_inheritances), "KLEE_TX_inheritances", true);
    ALIGN_TYPE extra_parameters[4];
    extra_parameters[0] = (ALIGN_TYPE) KLEE_TX_suspensions;
    extra_parameters[1] = (ALIGN_TYPE) KLEE_TX_timeouts;
    extra_parameters[2] = (ALIGN_TYPE) KLEE_TX_inversions;
    extra_parameters[3] = (ALIGN_TYPE) KLEE_TX_inheritances;
    _txm_module_manager_tx_mutex_performance_system_info_get_dispatch(module_instance, KLEE_TX_puts, KLEE_TX_gets, extra_parameters);
}
