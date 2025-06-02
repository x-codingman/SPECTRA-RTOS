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
    VOID * KLEE_TX_memory_ptr;
    klee_make_symbolic_controllable(&KLEE_TX_memory_ptr, sizeof(KLEE_TX_memory_ptr), "KLEE_TX_memory_ptr", true);
    _txm_module_manager_tx_byte_release_dispatch(module_instance, KLEE_TX_memory_ptr);
}
