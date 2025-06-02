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
    TX_TIMER * KLEE_TX_timer_ptr;
    klee_make_symbolic_controllable(&KLEE_TX_timer_ptr, sizeof(KLEE_TX_timer_ptr), "KLEE_TX_timer_ptr", true);
    CHAR ** KLEE_TX_name;
    klee_make_symbolic_controllable(&KLEE_TX_name, sizeof(KLEE_TX_name), "KLEE_TX_name", true);
    UINT * KLEE_TX_active;
    klee_make_symbolic_controllable(&KLEE_TX_active, sizeof(KLEE_TX_active), "KLEE_TX_active", true);
    ULONG * KLEE_TX_remaining_ticks;
    klee_make_symbolic_controllable(&KLEE_TX_remaining_ticks, sizeof(KLEE_TX_remaining_ticks), "KLEE_TX_remaining_ticks", true);
    ULONG * KLEE_TX_reschedule_ticks;
    klee_make_symbolic_controllable(&KLEE_TX_reschedule_ticks, sizeof(KLEE_TX_reschedule_ticks), "KLEE_TX_reschedule_ticks", true);
    TX_TIMER ** KLEE_TX_next_timer;
    klee_make_symbolic_controllable(&KLEE_TX_next_timer, sizeof(KLEE_TX_next_timer), "KLEE_TX_next_timer", true);
    ALIGN_TYPE extra_parameters[4];
    extra_parameters[0] = (ALIGN_TYPE) KLEE_TX_active;
    extra_parameters[1] = (ALIGN_TYPE) KLEE_TX_remaining_ticks;
    extra_parameters[2] = (ALIGN_TYPE) KLEE_TX_reschedule_ticks;
    extra_parameters[3] = (ALIGN_TYPE) KLEE_TX_next_timer;
    _txm_module_manager_tx_timer_info_get_dispatch(module_instance, KLEE_TX_timer_ptr, KLEE_TX_name, extra_parameters);
}
