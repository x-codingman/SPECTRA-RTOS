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
    TX_QUEUE * KLEE_TX_queue_ptr;
    klee_make_symbolic_controllable(&KLEE_TX_queue_ptr, sizeof(KLEE_TX_queue_ptr), "KLEE_TX_queue_ptr", true);
    ULONG * KLEE_TX_messages_sent;
    klee_make_symbolic_controllable(&KLEE_TX_messages_sent, sizeof(KLEE_TX_messages_sent), "KLEE_TX_messages_sent", true);
    ULONG * KLEE_TX_messages_received;
    klee_make_symbolic_controllable(&KLEE_TX_messages_received, sizeof(KLEE_TX_messages_received), "KLEE_TX_messages_received", true);
    ULONG * KLEE_TX_empty_suspensions;
    klee_make_symbolic_controllable(&KLEE_TX_empty_suspensions, sizeof(KLEE_TX_empty_suspensions), "KLEE_TX_empty_suspensions", true);
    ULONG * KLEE_TX_full_suspensions;
    klee_make_symbolic_controllable(&KLEE_TX_full_suspensions, sizeof(KLEE_TX_full_suspensions), "KLEE_TX_full_suspensions", true);
    ULONG * KLEE_TX_full_errors;
    klee_make_symbolic_controllable(&KLEE_TX_full_errors, sizeof(KLEE_TX_full_errors), "KLEE_TX_full_errors", true);
    ULONG * KLEE_TX_timeouts;
    klee_make_symbolic_controllable(&KLEE_TX_timeouts, sizeof(KLEE_TX_timeouts), "KLEE_TX_timeouts", true);
    ALIGN_TYPE extra_parameters[5];
    extra_parameters[0] = (ALIGN_TYPE) KLEE_TX_messages_received;
    extra_parameters[1] = (ALIGN_TYPE) KLEE_TX_empty_suspensions;
    extra_parameters[2] = (ALIGN_TYPE) KLEE_TX_full_suspensions;
    extra_parameters[3] = (ALIGN_TYPE) KLEE_TX_full_errors;
    extra_parameters[4] = (ALIGN_TYPE) KLEE_TX_timeouts;
    _txm_module_manager_tx_queue_performance_info_get_dispatch(module_instance, KLEE_TX_queue_ptr, KLEE_TX_messages_sent, extra_parameters);
}
