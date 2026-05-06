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
    ULONG KLEE_TX_request;
    klee_make_symbolic_controllable(&KLEE_TX_request, sizeof(KLEE_TX_request), "KLEE_TX_request", true);
    ALIGN_TYPE KLEE_TX_param_1;
    klee_make_symbolic_controllable(&KLEE_TX_param_1, sizeof(KLEE_TX_param_1), "KLEE_TX_param_1", true);
    ALIGN_TYPE KLEE_TX_param_2;
    klee_make_symbolic_controllable(&KLEE_TX_param_2, sizeof(KLEE_TX_param_2), "KLEE_TX_param_2", true);
    ALIGN_TYPE KLEE_TX_param_3;
    klee_make_symbolic_controllable(&KLEE_TX_param_3, sizeof(KLEE_TX_param_3), "KLEE_TX_param_3", true);
    ALIGN_TYPE extra_parameters[2];
    extra_parameters[0] = (ALIGN_TYPE) KLEE_TX_param_2;
    extra_parameters[1] = (ALIGN_TYPE) KLEE_TX_param_3;
    _txm_module_manager_tx_txm_module_application_request_dispatch(module_instance, KLEE_TX_request, KLEE_TX_param_1, extra_parameters);
}
