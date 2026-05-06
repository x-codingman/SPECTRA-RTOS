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
    UINT KLEE_TX_object_type;
    klee_make_symbolic_controllable(&KLEE_TX_object_type, sizeof(KLEE_TX_object_type), "KLEE_TX_object_type", true);
    CHAR * KLEE_TX_name;
    klee_make_symbolic_controllable(&KLEE_TX_name, sizeof(KLEE_TX_name), "KLEE_TX_name", true);
    UINT KLEE_TX_name_length;
    klee_make_symbolic_controllable(&KLEE_TX_name_length, sizeof(KLEE_TX_name_length), "KLEE_TX_name_length", true);
    VOID ** KLEE_TX_object_ptr;
    klee_make_symbolic_controllable(&KLEE_TX_object_ptr, sizeof(KLEE_TX_object_ptr), "KLEE_TX_object_ptr", true);
    ALIGN_TYPE extra_parameters[2];
    extra_parameters[0] = (ALIGN_TYPE) KLEE_TX_name_length;
    extra_parameters[1] = (ALIGN_TYPE) KLEE_TX_object_ptr;
    _txm_module_manager_tx_module_object_pointer_get_extended_dispatch(module_instance, KLEE_TX_object_type, KLEE_TX_name, extra_parameters);
}
