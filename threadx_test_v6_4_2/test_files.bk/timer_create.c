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
    CHAR * KLEE_TX_name_ptr;
    klee_make_symbolic_controllable(&KLEE_TX_name_ptr, sizeof(KLEE_TX_name_ptr), "KLEE_TX_name_ptr", true);
    VOID (*expiration_function)(ULONG input);
    klee_make_symbolic_controllable(&expiration_function, sizeof(expiration_function), "expiration_function", true);
    ULONG KLEE_TX_expiration_input;
    klee_make_symbolic_controllable(&KLEE_TX_expiration_input, sizeof(KLEE_TX_expiration_input), "KLEE_TX_expiration_input", true);
    ULONG KLEE_TX_initial_ticks;
    klee_make_symbolic_controllable(&KLEE_TX_initial_ticks, sizeof(KLEE_TX_initial_ticks), "KLEE_TX_initial_ticks", true);
    ULONG KLEE_TX_reschedule_ticks;
    klee_make_symbolic_controllable(&KLEE_TX_reschedule_ticks, sizeof(KLEE_TX_reschedule_ticks), "KLEE_TX_reschedule_ticks", true);
    UINT KLEE_TX_auto_activate;
    klee_make_symbolic_controllable(&KLEE_TX_auto_activate, sizeof(KLEE_TX_auto_activate), "KLEE_TX_auto_activate", true);
    UINT KLEE_TX_timer_control_block_size;
    klee_make_symbolic_controllable(&KLEE_TX_timer_control_block_size, sizeof(KLEE_TX_timer_control_block_size), "KLEE_TX_timer_control_block_size", true);
    ALIGN_TYPE extra_parameters[6];
    extra_parameters[0] = (ALIGN_TYPE) expiration_function;
    extra_parameters[1] = (ALIGN_TYPE) KLEE_TX_expiration_input;
    extra_parameters[2] = (ALIGN_TYPE) KLEE_TX_initial_ticks;
    extra_parameters[3] = (ALIGN_TYPE) KLEE_TX_reschedule_ticks;
    extra_parameters[4] = (ALIGN_TYPE) KLEE_TX_auto_activate;
    extra_parameters[5] = (ALIGN_TYPE) KLEE_TX_timer_control_block_size;
    _txm_module_manager_tx_timer_create_dispatch(module_instance, KLEE_TX_timer_ptr, KLEE_TX_name_ptr, extra_parameters);
}
