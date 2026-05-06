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
    TX_SEMAPHORE * KLEE_TX_semaphore_ptr;
    klee_make_symbolic_controllable(&KLEE_TX_semaphore_ptr, sizeof(KLEE_TX_semaphore_ptr), "KLEE_TX_semaphore_ptr", true);
    VOID (*semaphore_put_notify)(TX_SEMAPHORE *notify_semaphore_ptr);
    klee_make_symbolic_controllable(&semaphore_put_notify, sizeof(semaphore_put_notify), "semaphore_put_notify", true);
    _txm_module_manager_tx_semaphore_put_notify_dispatch(module_instance, KLEE_TX_semaphore_ptr, semaphore_put_notify);
}
