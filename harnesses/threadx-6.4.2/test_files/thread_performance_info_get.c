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
    ULONG * KLEE_TX_resumptions;
    klee_make_symbolic_controllable(&KLEE_TX_resumptions, sizeof(KLEE_TX_resumptions), "KLEE_TX_resumptions", true);
    ULONG * KLEE_TX_suspensions;
    klee_make_symbolic_controllable(&KLEE_TX_suspensions, sizeof(KLEE_TX_suspensions), "KLEE_TX_suspensions", true);
    ULONG * KLEE_TX_solicited_preemptions;
    klee_make_symbolic_controllable(&KLEE_TX_solicited_preemptions, sizeof(KLEE_TX_solicited_preemptions), "KLEE_TX_solicited_preemptions", true);
    ULONG * KLEE_TX_interrupt_preemptions;
    klee_make_symbolic_controllable(&KLEE_TX_interrupt_preemptions, sizeof(KLEE_TX_interrupt_preemptions), "KLEE_TX_interrupt_preemptions", true);
    ULONG * KLEE_TX_priority_inversions;
    klee_make_symbolic_controllable(&KLEE_TX_priority_inversions, sizeof(KLEE_TX_priority_inversions), "KLEE_TX_priority_inversions", true);
    ULONG * KLEE_TX_time_slices;
    klee_make_symbolic_controllable(&KLEE_TX_time_slices, sizeof(KLEE_TX_time_slices), "KLEE_TX_time_slices", true);
    ULONG * KLEE_TX_relinquishes;
    klee_make_symbolic_controllable(&KLEE_TX_relinquishes, sizeof(KLEE_TX_relinquishes), "KLEE_TX_relinquishes", true);
    ULONG * KLEE_TX_timeouts;
    klee_make_symbolic_controllable(&KLEE_TX_timeouts, sizeof(KLEE_TX_timeouts), "KLEE_TX_timeouts", true);
    ULONG * KLEE_TX_wait_aborts;
    klee_make_symbolic_controllable(&KLEE_TX_wait_aborts, sizeof(KLEE_TX_wait_aborts), "KLEE_TX_wait_aborts", true);
    TX_THREAD ** KLEE_TX_last_preempted_by;
    klee_make_symbolic_controllable(&KLEE_TX_last_preempted_by, sizeof(KLEE_TX_last_preempted_by), "KLEE_TX_last_preempted_by", true);
    ALIGN_TYPE extra_parameters[9];
    extra_parameters[0] = (ALIGN_TYPE) KLEE_TX_suspensions;
    extra_parameters[1] = (ALIGN_TYPE) KLEE_TX_solicited_preemptions;
    extra_parameters[2] = (ALIGN_TYPE) KLEE_TX_interrupt_preemptions;
    extra_parameters[3] = (ALIGN_TYPE) KLEE_TX_priority_inversions;
    extra_parameters[4] = (ALIGN_TYPE) KLEE_TX_time_slices;
    extra_parameters[5] = (ALIGN_TYPE) KLEE_TX_relinquishes;
    extra_parameters[6] = (ALIGN_TYPE) KLEE_TX_timeouts;
    extra_parameters[7] = (ALIGN_TYPE) KLEE_TX_wait_aborts;
    extra_parameters[8] = (ALIGN_TYPE) KLEE_TX_last_preempted_by;
    _txm_module_manager_tx_thread_performance_info_get_dispatch(module_instance, KLEE_TX_thread_ptr, KLEE_TX_resumptions, extra_parameters);
}
