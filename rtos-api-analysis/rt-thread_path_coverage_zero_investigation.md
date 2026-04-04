# RTOS Path Coverage = 0 调查报告

本文档覆盖 RT-Thread、TizenRT、ThreadX 三个 RTOS 的 path coverage = 0 原因分析。

---

## 总览

| RTOS | 零覆盖数量 | 主要原因 |
|------|------------|----------|
| **RT-Thread** | 22 | loop-breaking（16）+ klee_terminate_state（9，有重叠）+ 原因未明（4） |
| **TizenRT** | 9 | klee_terminate_state（9，全部）——阻塞模拟与 assert |
| **ThreadX 6.4.2** | 3 | 执行错误（3）——“calling function with too few arguments” |

---

# 一、RT-Thread

## 概述

共 **22 个** syscall 的 path coverage (Completed/Explored) = 0。通过分析各 syscall 的 `messages.txt`、`info` 等输出，分类如下。

---

## 分类统计

| 终止原因 | 数量 | Syscall 列表 |
|----------|------|--------------|
| **1. loop-breaking（Executor 中 terminateState）** | **16** | sys_chmod, sys_chown, sys_enter_critical, sys_exit_critical, sys_event_create, sys_execve, sys_fork, sys_getpgid, sys_getsid, sys_mb_create, sys_mq_unlink, sys_mutex_create, sys_rt_timer_create, sys_sem_create, sys_sem_take, sys_umount2, sys_vfork |
| **2. klee_terminate_state（stub 中 lwp_user_accessible 失败）** | **9** | sys_chmod, sys_chown, sys_event_create, sys_mb_create, sys_mq_create, sys_mq_unlink, sys_mutex_create, sys_sem_create, sys_umount2 |
| **3. 仅有 states size 0，无 loop-break 且无 klee_terminate_state** | **4** | sys_getrlimit, sys_pipe, sys_socketpair, sys_utimensat |

注：部分 syscall 同时存在 1 和 2（多条路径分别被不同机制终止）。

---

## 1. loop-breaking（biMap + terminateState）

**机制**：同一 Br 指令执行超过 10 次后，KLEE 认为在循环中，将 `biMap[i]=1`，后续再遇到该指令时调用 `terminateState(state)` 终止当前路径。

**messages 特征**：
```
KLEE: DEBUG: Try to break the loop
KLEE: DEBUG: terminate the State, try to break the loop
```

**受影响的 syscall**（messages 中可查到 loop-breaking 终止）：

| Syscall | explored | loop-break 次数 | 备注 |
|---------|----------|-----------------|------|
| sys_enter_critical | 1 | 1 | 已通过 Executor 修改改为“强制退出分支” |
| sys_exit_critical | 1 | 1 | 同上 |
| sys_sem_take | 3 | 3 | 无 klee_terminate_state，纯 loop-breaking |
| sys_chmod | 3 | 2 | 同时有 klee_terminate_state |
| sys_chown | 3 | 2 | 同上 |
| sys_event_create | 6 | 5 | 同上 |
| sys_mb_create | 6 | 5 | 同上 |
| sys_mutex_create | 5 | 4 | 同上 |
| sys_sem_create | 7 | 6 | 同上 |
| sys_fork | 2 | 2 | fork 相关逻辑，有 rt_vsnprintf 等循环 |
| sys_execve | 2 | 2 | 同上 |
| sys_vfork | 2 | 2 | 同上 |
| sys_mq_unlink | 2 | 1 | 同时有 klee_terminate_state |
| sys_umount2 | 3 | 2 | 同上 |

**结论**：Executor 中的 loop-breaking 修改（用“强制退出分支”代替 terminateState）理论上可改善上述 syscall 的 completed paths，尤其是 sys_sem_take、sys_enter_critical、sys_exit_critical 等未掺杂 klee_terminate_state 的 case。

---

## 2. klee_terminate_state（lwp_user_mm_stub）

**机制**：`lwp_user_mm_stub.c` 中，`lwp_user_strlen` 等检查用户指针合法性。当 `lwp_user_accessable(ptr)` 失败时，调用 `klee_terminate_state()` 终止当前路径。

**messages 特征**：
```
KLEE: DEBUG: terminate state invoked from the tested program
```

**涉及 syscall**：需要传入路径名、 buffer 等用户空间指针的 syscall，例如 sys_chmod、sys_chown、sys_event_create、sys_mq_unlink、sys_umount2 等。

**行为说明**：
- 对符号 ptr，KLEE 会 fork：合法 / 非法 两条路径
- 非法路径 → klee_terminate_state → 该路径被终止
- 合法路径应继续执行

若仍有 completed=0，说明合法路径也最终在某处被终止，例如：
- 后续再次遇到 lwp_user_accessable 失败
- 或进入 loop-breaking 分支被 terminateState

---

## 3. 仅有 states size 0 → **已查明：Harness 错误**

**messages 特征**：仅有 `states size 1` → `states size 0`，无 “terminate the State” 或 “terminate state invoked”。

**涉及 syscall**：sys_getrlimit, sys_pipe, sys_socketpair, sys_utimensat

**根因（已确认）**：4 个 harness 均存在 **数组越界 + 错误传参**：
- 使用 `&arr[2]`、`arr[2]` 对 `arr[2]` 大小的数组操作（有效索引 0,1），导致越界
- 将数组**元素**（int/struct）当作**指针**传给需 `ptr[2]` 的 syscall，触发 `memory error: invalid pointer`
- 详见 `rt-thread_four_zero_coverage_investigation.md`。已修复 harness。

---

## 4. __asm__ 与 Detect __asm__ external function

**结论**：`__asm__` 不会直接 terminate 路径。KLEE 会返回符号值并继续执行。

在 sys_chmod、sys_event_create、sys_fork、sys_execve、sys_mb_create、sys_mutex_create、sys_sem_create 等 messages 中可见多次 `Detect __asm__ external function!`，但路径依然继续；终止来自 loop-breaking 或 klee_terminate_state，而非 __asm__ 本身。

---

## 5. 建议

1. **已实施的 loop-breaking 修改**：继续生效，对 sys_enter_critical、sys_exit_critical、sys_sem_take 等应有明显效果。
2. **重跑 rt-thread 全量测试**：验证修改后的 path coverage 提升。
3. **sys_getrlimit 等异常 syscall**：检查 harness（如 `&KLEE_rlim[2]`）和 test_info，修正潜在 bug。
4. **lwp_user_mm_stub**：若希望更多 completed paths，可考虑放宽或调整 stub 中的用户指针检查策略。

---

# 二、TizenRT

## 概述

共 **9 个** syscall 的 path coverage = 0。分析表明**全部**由 `klee_terminate_state` 终止，**无** loop-breaking。

## 分类统计

| 终止原因 | 数量 | Syscall 列表 |
|----------|------|--------------|
| **klee_terminate_state（阻塞模拟 + assert）** | **9** | mq_timedreceive, mq_timedsend, pthread_cond_timedwait, pthread_getspecific, pthread_setspecific, sem_timedwait, sigtimedwait, sigwaitinfo, up_assert |

## 机制说明

1. **阻塞 API（mq_timedsend, mq_timedreceive, sem_timedwait 等）**  
   当模拟超时或阻塞时，代码路径会走到 `up_assert()` → `klee_terminate_state()`（`tizenRT_test/klee_help.h` 第 17 行）。

2. **pthread_setspecific / pthread_getspecific**  
   TLS 相关，可能涉及平台特定或外部代码，路径同样通过 `up_assert`/`klee_terminate_state` 终止。

3. **up_assert**  
   harness 显式将 `up_assert()` 定义为调用 `klee_terminate_state()`，用于模拟 RTOS 断言失败（如 MPU/权限违反）。

**messages 特征**：
```
KLEE: Execute: ./klee_help.h:17
KLEE: DEBUG: terminate state invoked from the tested program
```

## 与 Executor 修改的关系

TizenRT 的 path coverage = 0 **与 loop-breaking 无关**，全部来自 harness/stub 中的 `klee_terminate_state`。  
当前 Executor 中的 loop-breaking 修改对 TizenRT 零覆盖 syscall **无影响**。若需提高 TizenRT 的 completed paths，需调整 harness 或阻塞建模（例如不将阻塞路径直接 terminate）。

---

# 三、ThreadX 6.4.2

## 概述

共 **3 个** syscall 的 path coverage = 0：thread_relinquish, time_get, trace_disable。  
分析表明**全部**由 KLEE 执行错误终止，**无** loop-breaking，**无** klee_terminate_state。

## 终止原因

**KLEE 执行错误**：`calling function with too few arguments`

**错误文件**：`test000001.user.err`  
**错误信息**：
```
Error: calling function with too few arguments
File: test_files/thread_relinquish.c (或 time_get.c / trace_disable.c)
Line: 15
```

**原因分析**：  
三个 harness 均调用 `_txm_module_manager_tx_*_dispatch(module_instance)`。该 dispatch 函数期望更多参数，而 harness 只传入 `module_instance`，导致 KLEE 报 “calling function with too few arguments” 并 `terminateStateOnExecError` 终止当前路径。

## 与 Executor 修改的关系

ThreadX 的 path coverage = 0 **与 loop-breaking 无关**。  
问题出在 **harness 与 dispatch 函数签名不匹配**（参数个数不足）。需要修正 harness 或 dispatch 包装，使调用参数与声明一致。

## 建议

修正 `thread_relinquish.c`、`time_get.c`、`trace_disable.c` 中对 `_txm_module_manager_tx_*_dispatch` 的调用，补全缺失参数或调整函数签名。
