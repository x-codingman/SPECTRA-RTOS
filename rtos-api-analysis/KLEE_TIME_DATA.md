# KLEE 时间数据精度说明

## 当前使用的数据源：info 文件的 Elapsed

- **格式**：`Elapsed: HH:MM:SS`（如 `00:00:04`）
- **精度**：**秒级**（整数）
- **来源**：KLEE 用 `std::time()` 计算 `endTime - startTime`，再用 `toHMS()` 输出
- **代码位置**：`tools/klee/main.cpp` 约 1641–1653 行

因此会出现大量 Elapsed=0（不足 1 秒都被记成 0）。

---

## 可选的高精度时间数据

### 1. run.stats（SQLite）— **微秒级**

- **字段**：`WallTime`（单位：**微秒**）
- **来源**：`StatsTracker::elapsed().toMicroseconds()`
- **说明**：KLEE  internally 使用 monotonic steady clock（纳秒级）
- **注意**：当前测试输出目录中**可能没有** run.stats，需要确认 KLEE 是否启用了 stats 输出

### 2. info 文件中的 forks time — **毫秒级**（推测）

- **格式**：`KLEE: done: forks time = 12`
- **单位**：推测为**毫秒**（与 KLEE 内部统计单位一致）
- **说明**：这是 fork 相关耗时，**不是总运行时间**，不能替代 Elapsed

### 3. Started / Finished 时间戳

- **格式**：`Started: 2025-07-27 11:39:42`，`Finished: 2025-07-27 11:39:46`
- **精度**：**秒级**

---

## 建议：获取毫秒/微秒级总运行时间

### 方案 A：改用 run.stats 的 WallTime（若存在）

1. 确认各 syscall 输出目录下是否有 `run.stats`
2. 若有，在 `data-analyze-all.py` 中改为从 run.stats 读取 `MAX(WallTime)` 或最后一条 `WallTime`
3. 将微秒转换为秒：`elapsed_seconds = WallTime / 1_000_000`

### 方案 B：修改 KLEE 源码，让 info 输出更高精度

在 `tools/klee/main.cpp` 中，将 Elapsed 的生成由 `toHMS()` 改为使用 wall clock 的精确时长，例如：

```cpp
// 当前实现（秒级）
std::tie(h,m,s) = time::seconds(endTime - startTime).toHMS();

// 可改为使用 getWallTime 计算并输出秒+毫秒
auto elapsed = time::Span(time::getWallTime() - startWallTime);
// 输出 elapsed.toSeconds() 或 toMilliseconds()
```

然后重新编译 KLEE，再运行测试。

### 方案 C：用 klee-stats 提取 run.stats

若已有 run.stats，可用 KLEE 自带的 `klee-stats` 读取统计信息。
