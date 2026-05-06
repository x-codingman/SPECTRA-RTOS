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
    ULONG KLEE_TX_event_id;
    klee_make_symbolic_controllable(&KLEE_TX_event_id, sizeof(KLEE_TX_event_id), "KLEE_TX_event_id", true);
    ULONG KLEE_TX_info_field_1;
    klee_make_symbolic_controllable(&KLEE_TX_info_field_1, sizeof(KLEE_TX_info_field_1), "KLEE_TX_info_field_1", true);
    ULONG KLEE_TX_info_field_2;
    klee_make_symbolic_controllable(&KLEE_TX_info_field_2, sizeof(KLEE_TX_info_field_2), "KLEE_TX_info_field_2", true);
    ULONG KLEE_TX_info_field_3;
    klee_make_symbolic_controllable(&KLEE_TX_info_field_3, sizeof(KLEE_TX_info_field_3), "KLEE_TX_info_field_3", true);
    ULONG KLEE_TX_info_field_4;
    klee_make_symbolic_controllable(&KLEE_TX_info_field_4, sizeof(KLEE_TX_info_field_4), "KLEE_TX_info_field_4", true);
    ALIGN_TYPE extra_parameters[3];
    extra_parameters[0] = (ALIGN_TYPE) KLEE_TX_info_field_2;
    extra_parameters[1] = (ALIGN_TYPE) KLEE_TX_info_field_3;
    extra_parameters[2] = (ALIGN_TYPE) KLEE_TX_info_field_4;
    _txm_module_manager_tx_trace_user_event_insert_dispatch(module_instance, KLEE_TX_event_id, KLEE_TX_info_field_1, extra_parameters);
}
