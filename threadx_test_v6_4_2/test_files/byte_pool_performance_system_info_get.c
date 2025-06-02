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
    ULONG * KLEE_TX_allocates;
    klee_make_symbolic_controllable(&KLEE_TX_allocates, sizeof(KLEE_TX_allocates), "KLEE_TX_allocates", true);
    ULONG * KLEE_TX_releases;
    klee_make_symbolic_controllable(&KLEE_TX_releases, sizeof(KLEE_TX_releases), "KLEE_TX_releases", true);
    ULONG * KLEE_TX_fragments_searched;
    klee_make_symbolic_controllable(&KLEE_TX_fragments_searched, sizeof(KLEE_TX_fragments_searched), "KLEE_TX_fragments_searched", true);
    ULONG * KLEE_TX_merges;
    klee_make_symbolic_controllable(&KLEE_TX_merges, sizeof(KLEE_TX_merges), "KLEE_TX_merges", true);
    ULONG * KLEE_TX_splits;
    klee_make_symbolic_controllable(&KLEE_TX_splits, sizeof(KLEE_TX_splits), "KLEE_TX_splits", true);
    ULONG * KLEE_TX_suspensions;
    klee_make_symbolic_controllable(&KLEE_TX_suspensions, sizeof(KLEE_TX_suspensions), "KLEE_TX_suspensions", true);
    ULONG * KLEE_TX_timeouts;
    klee_make_symbolic_controllable(&KLEE_TX_timeouts, sizeof(KLEE_TX_timeouts), "KLEE_TX_timeouts", true);
    ALIGN_TYPE extra_parameters[5];
    extra_parameters[0] = (ALIGN_TYPE) KLEE_TX_fragments_searched;
    extra_parameters[1] = (ALIGN_TYPE) KLEE_TX_merges;
    extra_parameters[2] = (ALIGN_TYPE) KLEE_TX_splits;
    extra_parameters[3] = (ALIGN_TYPE) KLEE_TX_suspensions;
    extra_parameters[4] = (ALIGN_TYPE) KLEE_TX_timeouts;
    _txm_module_manager_tx_byte_pool_performance_system_info_get_dispatch(module_instance, KLEE_TX_allocates, KLEE_TX_releases, extra_parameters);
}
