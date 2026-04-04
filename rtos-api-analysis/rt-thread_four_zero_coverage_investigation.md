# RT-Thread 剩余 4 个 Path Coverage = 0 的调研报告

## 概述

在 loop-breaking 修改后，RT-Thread 仍有 **4 个** syscall 的 path coverage (Completed/Explored) = 0：

- `sys_pipe`
- `sys_getrlimit`
- `sys_socketpair`
- `sys_utimensat`

---

## 根本原因：Harness 错误

所有 4 个 syscall 的 `.ptr.err` 文件均报告：

```
Error: memory error: invalid pointer: make_symbolic
```

| Syscall       | 出错行 | 错误描述                         |
|---------------|--------|----------------------------------|
| sys_pipe      | 99     | memory error: invalid pointer   |
| sys_getrlimit | 101    | memory error: invalid pointer   |
| sys_socketpair| 105    | memory error: invalid pointer   |
| sys_utimensat | 103    | memory error: invalid pointer   |

---

## 具体问题

### 1. sys_pipe

**Syscall 签名**：`sysret_t sys_pipe(int fd[2])`（需要指向 `int[2]` 的指针）

**Harness 错误**：
```c
klee_make_symbolic_controllable(&KLEE_fd[2], ...);   // &KLEE_fd[2] 越界（有效索引 0,1）
sys_pipe(KLEE_fd[2]);                               // 传入 int 而非 int*
```

- `KLEE_fd[2]` 越界
- `sys_pipe` 期望 `int*`，实际传入 `int`，指针无效，导致 `lwp_user_accessable` / `lwp_put_to_user` 内存错误

### 2. sys_getrlimit

**Syscall 签名**：`sysret_t sys_getrlimit(unsigned int resource, unsigned long rlim[2])`

**Harness 错误**：
```c
klee_make_symbolic_controllable(&KLEE_rlim[2], ...);  // 越界
sys_getrlimit(KLEE_resource, KLEE_rlim[2]);           // 传入 unsigned long 而非 unsigned long*
```

- 应传入 `KLEE_rlim`（数组名，即指针），而非 `KLEE_rlim[2]`（越界元素）

### 3. sys_socketpair

**Syscall 签名**：`sysret_t sys_socketpair(int domain, int type, int protocol, int fd[2])`

**Harness 错误**：
```c
klee_make_symbolic_controllable(&KLEE_fd[2], ...);   // 越界
sys_socketpair(..., KLEE_fd[2]);                     // 传入 int 而非 int*
```

- 问题与 sys_pipe 相同

### 4. sys_utimensat

**Syscall 签名**：`sysret_t sys_utimensat(int fd, const char *path, const struct timespec times[2], int flags)`

**Harness 错误**：
```c
klee_make_symbolic_controllable(&KLEE___times[2], ...);  // 越界
sys_utimensat(..., KLEE___times[2], ...);                // 传入 struct timespec 而非 const struct timespec*
```

- 应传入 `KLEE___times`（指向数组的指针）

---

## 修复方案

对所有 harness，均需：

1. 使用数组整体做符号化：`klee_make_symbolic_controllable(KLEE_xxx, sizeof(KLEE_xxx), ...)`
2. 将数组名作为指针传入 syscall：`sys_xxx(..., KLEE_xxx, ...)`

---

## 与 loop-breaking 的关系

这 4 个 syscall **与 Executor 的 loop-breaking 无关**。  
路径在执行阶段因 **invalid pointer** 被 `terminateStateOnError` 终止，属于 harness 设计错误，而非 KLEE 内部机制。
