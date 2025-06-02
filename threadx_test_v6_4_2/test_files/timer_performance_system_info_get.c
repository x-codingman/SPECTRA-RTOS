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
    ULONG * KLEE_TX_activates;
    klee_make_symbolic_controllable(&KLEE_TX_activates, sizeof(KLEE_TX_activates), "KLEE_TX_activates", true);
    ULONG * KLEE_TX_reactivates;
    klee_make_symbolic_controllable(&KLEE_TX_reactivates, sizeof(KLEE_TX_reactivates), "KLEE_TX_reactivates", true);
    ULONG * KLEE_TX_deactivates;
    klee_make_symbolic_controllable(&KLEE_TX_deactivates, sizeof(KLEE_TX_deactivates), "KLEE_TX_deactivates", true);
    ULONG * KLEE_TX_expirations;
    klee_make_symbolic_controllable(&KLEE_TX_expirations, sizeof(KLEE_TX_expirations), "KLEE_TX_expirations", true);
    ULONG * KLEE_TX_expiration_adjusts;
    klee_make_symbolic_controllable(&KLEE_TX_expiration_adjusts, sizeof(KLEE_TX_expiration_adjusts), "KLEE_TX_expiration_adjusts", true);
    ALIGN_TYPE extra_parameters[3];
    extra_parameters[0] = (ALIGN_TYPE) KLEE_TX_deactivates;
    extra_parameters[1] = (ALIGN_TYPE) KLEE_TX_expirations;
    extra_parameters[2] = (ALIGN_TYPE) KLEE_TX_expiration_adjusts;
    _txm_module_manager_tx_timer_performance_system_info_get_dispatch(module_instance, KLEE_TX_activates, KLEE_TX_reactivates, extra_parameters);
}
