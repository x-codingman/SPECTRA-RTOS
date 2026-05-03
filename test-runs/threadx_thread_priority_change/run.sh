#!/usr/bin/env bash
# ThreadX thread_priority_change — isolated under klee_src/test-runs
set -euo pipefail

BASE="$(cd "$(dirname "$0")" && pwd)"
OUT="${BASE}/output/test_10"
INFO="${BASE}/test-info-output/test_10"
KLEE="/home/klee/klee_src/build/bin/klee"
BC="/home/klee/klee_src/freertos_10_5_1_test/test_bc_files/test_MPU_xTaskCallApplicationTaskHook.test.bc"
#/home/klee/klee_src/rt-thread_test/test_bc_files/sys_device_write.test.bc
#/home/klee/klee_src/freertos_10_5_1_test/test_bc_files/test_MPU_xTaskCallApplicationTaskHook.test.bc
#/home/klee/klee_src/threadx_test_v6_4_2/test_bc_files/queue_front_send.test.bc

clear
rm -rf "$OUT" "$INFO"
# KLEE uses a single mkdir() on --output-dir / --test-info-output-dir; the path
# must not exist yet. Only ensure parent directories exist.
mkdir -p "${BASE}/output" "${BASE}/test-info-output"

exec "$KLEE" --search=dfs \
  -debug-print-instructions=all:stderr \
  --output-dir="$OUT" \
  --test-info-output-dir="$INFO" \
  --test-target-name=thread_priority_change \
  "$BC"
