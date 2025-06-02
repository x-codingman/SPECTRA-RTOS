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
    TX_BLOCK_POOL * KLEE_TX_pool_ptr;
    klee_make_symbolic_controllable(&KLEE_TX_pool_ptr, sizeof(KLEE_TX_pool_ptr), "KLEE_TX_pool_ptr", true);
    VOID ** KLEE_TX_block_ptr;
    klee_make_symbolic_controllable(&KLEE_TX_block_ptr, sizeof(KLEE_TX_block_ptr), "KLEE_TX_block_ptr", true);
    ULONG KLEE_TX_wait_option;
    klee_make_symbolic_controllable(&KLEE_TX_wait_option, sizeof(KLEE_TX_wait_option), "KLEE_TX_wait_option", true);
    _txm_module_manager_tx_block_allocate_dispatch(module_instance, KLEE_TX_pool_ptr, KLEE_TX_block_ptr, KLEE_TX_wait_option);
}
