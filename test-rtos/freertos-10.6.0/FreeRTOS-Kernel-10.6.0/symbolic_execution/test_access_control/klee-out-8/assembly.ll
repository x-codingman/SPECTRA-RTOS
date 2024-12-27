; ModuleID = 'test.test.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.KernelObject = type { %struct.OpaqueObject*, i32, i8* }
%struct.OpaqueObject = type opaque
%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.__sigset_t = type { [16 x i64] }
%struct.tskTaskControlBlock = type opaque
%struct.xTASK_STATUS = type { %struct.tskTaskControlBlock*, i8*, i64, i32, i64, i64, i32, i64*, i16 }
%struct.xTIME_OUT = type { i64, i64 }
%struct.xSTATIC_TCB = type { i8*, %struct.MPU_SETTINGS, [2 x %struct.xSTATIC_LIST_ITEM], i64, i8*, [16 x i8], [2 x i64], i8*, [5 x i8*], i32, [3 x i32], [3 x i8], i8, i8 }
%struct.MPU_SETTINGS = type { i32, [8 x %struct.MPURegionSettings] }
%struct.MPURegionSettings = type { i32, i32 }
%struct.xSTATIC_LIST_ITEM = type { i64, [4 x i8*] }
%struct.xTASK_PARAMETERS = type { void (i8*)*, i8*, i16, i8*, i64, i64*, [1 x %struct.xMEMORY_REGION], %struct.xSTATIC_TCB* }
%struct.xMEMORY_REGION = type { i8*, i32, i32 }
%struct.QueueDefinition = type opaque
%struct.xSTATIC_QUEUE = type { [3 x i8*], %union.anon, [2 x %struct.xSTATIC_LIST], [3 x i64], [2 x i8], i8, i8*, i64, i8 }
%union.anon = type { i8* }
%struct.xSTATIC_LIST = type { i64, i8*, %struct.xSTATIC_MINI_LIST_ITEM }
%struct.xSTATIC_MINI_LIST_ITEM = type { i64, [2 x i8*] }
%struct.tmrTimerControl = type opaque
%struct.xSTATIC_TIMER = type { i8*, %struct.xSTATIC_LIST_ITEM, i64, i8*, void (i8*)*, i64, i8 }
%struct.EventGroupDef_t = type opaque
%struct.xSTATIC_EVENT_GROUP = type { i64, %struct.xSTATIC_LIST, i64, i8 }
%struct.StreamBufferDef_t = type opaque
%struct.xSTATIC_STREAM_BUFFER = type { [4 x i64], [3 x i8*], i8, i64, [2 x i8*] }
%struct.THREAD = type { i64, void (i8*)*, i8*, i64, %struct.event* }
%struct.event = type opaque
%union.pthread_attr_t = type { i64, [48 x i8] }
%struct.sigaction = type { %union.anon.1, %struct.__sigset_t, i32, void ()* }
%union.anon.1 = type { void (i32)* }
%struct.itimerval = type { %struct.xTIME_OUT, %struct.xTIME_OUT }
%struct.tms = type { i64, i64, i64, i64 }

@.str = private unnamed_addr constant [68 x i8] c"/home/klee/FreeRTOS-Kernel-10.6.0/portable/Common/mpu_wrappers_v2.c\00", align 1
@xKernelObjectPool = internal global [256 x %struct.KernelObject] zeroinitializer, section "privileged_data", align 16, !dbg !0
@hSigSetupThread = internal global i32 0, align 4, !dbg !76
@stderr = external dso_local global %struct._IO_FILE*, align 8
@.str.1 = private unnamed_addr constant [88 x i8] c"[WARN] pthread_attr_setstack failed with return value: %d. Default stack will be used.\0A\00", align 1
@.str.1.2 = private unnamed_addr constant [54 x i8] c"[WARN] Increase the stack size to PTHREAD_STACK_MIN.\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"pthread_create\00", align 1
@uxCriticalNesting = internal global i64 0, align 8, !dbg !137
@xAllSignals = internal global %struct.__sigset_t zeroinitializer, align 8, !dbg !123
@.str.3 = private unnamed_addr constant [8 x i8] c"%s: %s\0A\00", align 1
@.str.6 = private unnamed_addr constant [72 x i8] c"/home/klee/FreeRTOS-Kernel-10.6.0//portable/ThirdParty/GCC/Posix/port.c\00", align 1
@hMainThread = internal global i64 0, align 8, !dbg !140
@xSchedulerOriginalSignalMask = internal global %struct.__sigset_t zeroinitializer, align 8, !dbg !135
@.str.7 = private unnamed_addr constant [10 x i8] c"sigaction\00", align 1
@xSchedulerEnd = internal global i64 0, align 8, !dbg !142
@.str.4 = private unnamed_addr constant [10 x i8] c"getitimer\00", align 1
@.str.5 = private unnamed_addr constant [10 x i8] c"setitimer\00", align 1
@prvStartTimeNs = internal global i64 0, align 8, !dbg !144
@isTested = dso_local global i8 0, align 1, !dbg !147
@.str.8 = private unnamed_addr constant [14 x i8] c"xTaskToResume\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskDelayUntilImpl(i64* %pxPreviousWakeTime, i64 %xTimeIncrement) #0 section "privileged_functions" !dbg !159 {
entry:
  %pxPreviousWakeTime.addr = alloca i64*, align 8
  %xTimeIncrement.addr = alloca i64, align 8
  %xReturn = alloca i64, align 8
  %xIsPreviousWakeTimeAccessible = alloca i64, align 8
  store i64* %pxPreviousWakeTime, i64** %pxPreviousWakeTime.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxPreviousWakeTime.addr, metadata !164, metadata !DIExpression()), !dbg !165
  store i64 %xTimeIncrement, i64* %xTimeIncrement.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTimeIncrement.addr, metadata !166, metadata !DIExpression()), !dbg !167
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !168, metadata !DIExpression()), !dbg !169
  store i64 0, i64* %xReturn, align 8, !dbg !169
  call void @llvm.dbg.declare(metadata i64* %xIsPreviousWakeTimeAccessible, metadata !170, metadata !DIExpression()), !dbg !171
  store i64 0, i64* %xIsPreviousWakeTimeAccessible, align 8, !dbg !171
  %0 = load i64*, i64** %pxPreviousWakeTime.addr, align 8, !dbg !172
  %1 = bitcast i64* %0 to i8*, !dbg !172
  %call = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %1, i32 8, i32 3), !dbg !173
  store i64 %call, i64* %xIsPreviousWakeTimeAccessible, align 8, !dbg !174
  %2 = load i64, i64* %xIsPreviousWakeTimeAccessible, align 8, !dbg !175
  %cmp = icmp eq i64 %2, 1, !dbg !177
  br i1 %cmp, label %if.then, label %if.end, !dbg !178

if.then:                                          ; preds = %entry
  %3 = load i64*, i64** %pxPreviousWakeTime.addr, align 8, !dbg !179
  %4 = load i64, i64* %xTimeIncrement.addr, align 8, !dbg !181
  %call1 = call i64 @xTaskDelayUntil(i64* %3, i64 %4), !dbg !182
  store i64 %call1, i64* %xReturn, align 8, !dbg !183
  br label %if.end, !dbg !184

if.end:                                           ; preds = %if.then, %entry
  %5 = load i64, i64* %xReturn, align 8, !dbg !185
  ret i64 %5, !dbg !186
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i64 @xPortIsAuthorizedToAccessBuffer(i8*, i32, i32) #2 section "privileged_functions"

declare dso_local i64 @xTaskDelayUntil(i64*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskAbortDelayImpl(%struct.tskTaskControlBlock* %xTask) #0 section "privileged_functions" !dbg !187 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %xReturn = alloca i64, align 8
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !190, metadata !DIExpression()), !dbg !191
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !192, metadata !DIExpression()), !dbg !193
  store i64 0, i64* %xReturn, align 8, !dbg !193
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !194, metadata !DIExpression()), !dbg !195
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !195
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !196, metadata !DIExpression()), !dbg !197
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !198
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !200
  br i1 %cmp, label %if.then, label %if.else, !dbg !201

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !202
  %call = call i64 @xTaskAbortDelay(%struct.tskTaskControlBlock* %1), !dbg !204
  store i64 %call, i64* %xReturn, align 8, !dbg !205
  br label %if.end12, !dbg !206

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !207
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !209
  store i32 %3, i32* %lIndex, align 4, !dbg !210
  %4 = load i32, i32* %lIndex, align 4, !dbg !211
  %cmp1 = icmp sge i32 %4, 1, !dbg !211
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !211

land.rhs:                                         ; preds = %if.else
  %5 = load i32, i32* %lIndex, align 4, !dbg !211
  %cmp2 = icmp slt i32 %5, 257, !dbg !211
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %6 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !213
  %land.ext = zext i1 %6 to i32, !dbg !211
  %conv = sext i32 %land.ext to i64, !dbg !211
  %cmp3 = icmp ne i64 %conv, 0, !dbg !214
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !215

if.then5:                                         ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !216
  %sub = sub nsw i32 %7, 1, !dbg !216
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !216
  %8 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !216
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !218
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !219
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !221
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !222

if.then9:                                         ; preds = %if.then5
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !223
  %call10 = call i64 @xTaskAbortDelay(%struct.tskTaskControlBlock* %10), !dbg !225
  store i64 %call10, i64* %xReturn, align 8, !dbg !226
  br label %if.end, !dbg !227

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !228

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %11 = load i64, i64* %xReturn, align 8, !dbg !229
  ret i64 %11, !dbg !230
}

declare dso_local i64 @xTaskAbortDelay(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define internal %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %lIndex, i32 %ulKernelObjectType) #0 section "privileged_functions" !dbg !231 {
entry:
  %lIndex.addr = alloca i32, align 4
  %ulKernelObjectType.addr = alloca i32, align 4
  store i32 %lIndex, i32* %lIndex.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %lIndex.addr, metadata !234, metadata !DIExpression()), !dbg !235
  store i32 %ulKernelObjectType, i32* %ulKernelObjectType.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %ulKernelObjectType.addr, metadata !236, metadata !DIExpression()), !dbg !237
  %0 = load i32, i32* %lIndex.addr, align 4, !dbg !238
  %cmp = icmp sge i32 %0, 0, !dbg !238
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !238

land.rhs:                                         ; preds = %entry
  %1 = load i32, i32* %lIndex.addr, align 4, !dbg !238
  %cmp1 = icmp slt i32 %1, 256, !dbg !238
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %2 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !240
  %land.ext = zext i1 %2 to i32, !dbg !238
  %conv = sext i32 %land.ext to i64, !dbg !238
  %cmp2 = icmp ne i64 %conv, 0, !dbg !238
  %conv3 = zext i1 %cmp2 to i32, !dbg !238
  %cmp4 = icmp eq i32 %conv3, 0, !dbg !238
  br i1 %cmp4, label %if.then, label %if.end, !dbg !241

if.then:                                          ; preds = %land.end
  call void @vAssertCalled(i8* getelementptr inbounds ([68 x i8], [68 x i8]* @.str, i64 0, i64 0), i64 317), !dbg !238
  br label %if.end, !dbg !238

if.end:                                           ; preds = %if.then, %land.end
  %3 = load i32, i32* %lIndex.addr, align 4, !dbg !242
  %idxprom = sext i32 %3 to i64, !dbg !242
  %arrayidx = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom, !dbg !242
  %ulKernelObjectType6 = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx, i32 0, i32 1, !dbg !242
  %4 = load i32, i32* %ulKernelObjectType6, align 8, !dbg !242
  %5 = load i32, i32* %ulKernelObjectType.addr, align 4, !dbg !242
  %cmp7 = icmp eq i32 %4, %5, !dbg !242
  %conv8 = zext i1 %cmp7 to i32, !dbg !242
  %cmp9 = icmp eq i32 %conv8, 0, !dbg !242
  br i1 %cmp9, label %if.then11, label %if.end12, !dbg !244

if.then11:                                        ; preds = %if.end
  call void @vAssertCalled(i8* getelementptr inbounds ([68 x i8], [68 x i8]* @.str, i64 0, i64 0), i64 318), !dbg !242
  br label %if.end12, !dbg !242

if.end12:                                         ; preds = %if.then11, %if.end
  %6 = load i32, i32* %lIndex.addr, align 4, !dbg !245
  %idxprom13 = sext i32 %6 to i64, !dbg !246
  %arrayidx14 = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom13, !dbg !246
  %xInternalObjectHandle = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx14, i32 0, i32 0, !dbg !247
  %7 = load %struct.OpaqueObject*, %struct.OpaqueObject** %xInternalObjectHandle, align 8, !dbg !247
  ret %struct.OpaqueObject* %7, !dbg !248
}

declare dso_local void @vAssertCalled(i8*, i64) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTaskDelayImpl(i64 %xTicksToDelay) #0 section "privileged_functions" !dbg !249 {
entry:
  %xTicksToDelay.addr = alloca i64, align 8
  store i64 %xTicksToDelay, i64* %xTicksToDelay.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToDelay.addr, metadata !252, metadata !DIExpression()), !dbg !253
  %0 = load i64, i64* %xTicksToDelay.addr, align 8, !dbg !254
  call void @vTaskDelay(i64 %0), !dbg !255
  ret void, !dbg !256
}

declare dso_local void @vTaskDelay(i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_uxTaskPriorityGetImpl(%struct.tskTaskControlBlock* %pxTask) #0 section "privileged_functions" !dbg !257 {
entry:
  %pxTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %uxReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %pxTask, %struct.tskTaskControlBlock** %pxTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %pxTask.addr, metadata !261, metadata !DIExpression()), !dbg !262
  call void @llvm.dbg.declare(metadata i64* %uxReturn, metadata !263, metadata !DIExpression()), !dbg !264
  store i64 5, i64* %uxReturn, align 8, !dbg !264
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !265, metadata !DIExpression()), !dbg !266
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !267, metadata !DIExpression()), !dbg !268
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !268
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTask.addr, align 8, !dbg !269
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !271
  br i1 %cmp, label %if.then, label %if.else, !dbg !272

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTask.addr, align 8, !dbg !273
  %call = call i64 @uxTaskPriorityGet(%struct.tskTaskControlBlock* %1), !dbg !275
  store i64 %call, i64* %uxReturn, align 8, !dbg !276
  br label %if.end12, !dbg !277

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTask.addr, align 8, !dbg !278
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !280
  store i32 %3, i32* %lIndex, align 4, !dbg !281
  %4 = load i32, i32* %lIndex, align 4, !dbg !282
  %cmp1 = icmp sge i32 %4, 1, !dbg !282
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !282

land.rhs:                                         ; preds = %if.else
  %5 = load i32, i32* %lIndex, align 4, !dbg !282
  %cmp2 = icmp slt i32 %5, 257, !dbg !282
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %6 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !284
  %land.ext = zext i1 %6 to i32, !dbg !282
  %conv = sext i32 %land.ext to i64, !dbg !282
  %cmp3 = icmp ne i64 %conv, 0, !dbg !285
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !286

if.then5:                                         ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !287
  %sub = sub nsw i32 %7, 1, !dbg !287
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !287
  %8 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !287
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !289
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !290
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !292
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !293

if.then9:                                         ; preds = %if.then5
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !294
  %call10 = call i64 @uxTaskPriorityGet(%struct.tskTaskControlBlock* %10), !dbg !296
  store i64 %call10, i64* %uxReturn, align 8, !dbg !297
  br label %if.end, !dbg !298

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !299

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %11 = load i64, i64* %uxReturn, align 8, !dbg !300
  ret i64 %11, !dbg !301
}

declare dso_local i64 @uxTaskPriorityGet(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MPU_eTaskGetStateImpl(%struct.tskTaskControlBlock* %pxTask) #0 section "privileged_functions" !dbg !302 {
entry:
  %pxTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %eReturn = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tskTaskControlBlock* %pxTask, %struct.tskTaskControlBlock** %pxTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %pxTask.addr, metadata !306, metadata !DIExpression()), !dbg !307
  call void @llvm.dbg.declare(metadata i32* %eReturn, metadata !308, metadata !DIExpression()), !dbg !309
  store i32 5, i32* %eReturn, align 4, !dbg !309
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !310, metadata !DIExpression()), !dbg !311
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !311
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !312, metadata !DIExpression()), !dbg !313
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTask.addr, align 8, !dbg !314
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !316
  br i1 %cmp, label %if.then, label %if.else, !dbg !317

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTask.addr, align 8, !dbg !318
  %call = call i32 @eTaskGetState(%struct.tskTaskControlBlock* %1), !dbg !320
  store i32 %call, i32* %eReturn, align 4, !dbg !321
  br label %if.end12, !dbg !322

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTask.addr, align 8, !dbg !323
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !325
  store i32 %3, i32* %lIndex, align 4, !dbg !326
  %4 = load i32, i32* %lIndex, align 4, !dbg !327
  %cmp1 = icmp sge i32 %4, 1, !dbg !327
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !327

land.rhs:                                         ; preds = %if.else
  %5 = load i32, i32* %lIndex, align 4, !dbg !327
  %cmp2 = icmp slt i32 %5, 257, !dbg !327
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %6 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !329
  %land.ext = zext i1 %6 to i32, !dbg !327
  %conv = sext i32 %land.ext to i64, !dbg !327
  %cmp3 = icmp ne i64 %conv, 0, !dbg !330
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !331

if.then5:                                         ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !332
  %sub = sub nsw i32 %7, 1, !dbg !332
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !332
  %8 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !332
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !334
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !335
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !337
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !338

if.then9:                                         ; preds = %if.then5
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !339
  %call10 = call i32 @eTaskGetState(%struct.tskTaskControlBlock* %10), !dbg !341
  store i32 %call10, i32* %eReturn, align 4, !dbg !342
  br label %if.end, !dbg !343

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !344

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %11 = load i32, i32* %eReturn, align 4, !dbg !345
  ret i32 %11, !dbg !346
}

declare dso_local i32 @eTaskGetState(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTaskGetInfoImpl(%struct.tskTaskControlBlock* %xTask, %struct.xTASK_STATUS* %pxTaskStatus, i64 %xGetFreeStackSpace, i32 %eState) #0 section "privileged_functions" !dbg !347 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %pxTaskStatus.addr = alloca %struct.xTASK_STATUS*, align 8
  %xGetFreeStackSpace.addr = alloca i64, align 8
  %eState.addr = alloca i32, align 4
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %xIsTaskStatusWriteable = alloca i64, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !369, metadata !DIExpression()), !dbg !370
  store %struct.xTASK_STATUS* %pxTaskStatus, %struct.xTASK_STATUS** %pxTaskStatus.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xTASK_STATUS** %pxTaskStatus.addr, metadata !371, metadata !DIExpression()), !dbg !372
  store i64 %xGetFreeStackSpace, i64* %xGetFreeStackSpace.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xGetFreeStackSpace.addr, metadata !373, metadata !DIExpression()), !dbg !374
  store i32 %eState, i32* %eState.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %eState.addr, metadata !375, metadata !DIExpression()), !dbg !376
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !377, metadata !DIExpression()), !dbg !378
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !379, metadata !DIExpression()), !dbg !380
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !380
  call void @llvm.dbg.declare(metadata i64* %xIsTaskStatusWriteable, metadata !381, metadata !DIExpression()), !dbg !382
  store i64 0, i64* %xIsTaskStatusWriteable, align 8, !dbg !382
  %0 = load %struct.xTASK_STATUS*, %struct.xTASK_STATUS** %pxTaskStatus.addr, align 8, !dbg !383
  %1 = bitcast %struct.xTASK_STATUS* %0 to i8*, !dbg !383
  %call = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %1, i32 72, i32 2), !dbg !384
  store i64 %call, i64* %xIsTaskStatusWriteable, align 8, !dbg !385
  %2 = load i64, i64* %xIsTaskStatusWriteable, align 8, !dbg !386
  %cmp = icmp eq i64 %2, 1, !dbg !388
  br i1 %cmp, label %if.then, label %if.end14, !dbg !389

if.then:                                          ; preds = %entry
  %3 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !390
  %cmp1 = icmp eq %struct.tskTaskControlBlock* %3, null, !dbg !393
  br i1 %cmp1, label %if.then2, label %if.else, !dbg !394

if.then2:                                         ; preds = %if.then
  %4 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !395
  %5 = load %struct.xTASK_STATUS*, %struct.xTASK_STATUS** %pxTaskStatus.addr, align 8, !dbg !397
  %6 = load i64, i64* %xGetFreeStackSpace.addr, align 8, !dbg !398
  %7 = load i32, i32* %eState.addr, align 4, !dbg !399
  call void @vTaskGetInfo(%struct.tskTaskControlBlock* %4, %struct.xTASK_STATUS* %5, i64 %6, i32 %7), !dbg !400
  br label %if.end13, !dbg !401

if.else:                                          ; preds = %if.then
  %8 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !402
  %9 = ptrtoint %struct.tskTaskControlBlock* %8 to i32, !dbg !404
  store i32 %9, i32* %lIndex, align 4, !dbg !405
  %10 = load i32, i32* %lIndex, align 4, !dbg !406
  %cmp3 = icmp sge i32 %10, 1, !dbg !406
  br i1 %cmp3, label %land.rhs, label %land.end, !dbg !406

land.rhs:                                         ; preds = %if.else
  %11 = load i32, i32* %lIndex, align 4, !dbg !406
  %cmp4 = icmp slt i32 %11, 257, !dbg !406
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %12 = phi i1 [ false, %if.else ], [ %cmp4, %land.rhs ], !dbg !408
  %land.ext = zext i1 %12 to i32, !dbg !406
  %conv = sext i32 %land.ext to i64, !dbg !406
  %cmp5 = icmp ne i64 %conv, 0, !dbg !409
  br i1 %cmp5, label %if.then7, label %if.end12, !dbg !410

if.then7:                                         ; preds = %land.end
  %13 = load i32, i32* %lIndex, align 4, !dbg !411
  %sub = sub nsw i32 %13, 1, !dbg !411
  %call8 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !411
  %14 = bitcast %struct.OpaqueObject* %call8 to %struct.tskTaskControlBlock*, !dbg !411
  store %struct.tskTaskControlBlock* %14, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !413
  %15 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !414
  %cmp9 = icmp ne %struct.tskTaskControlBlock* %15, null, !dbg !416
  br i1 %cmp9, label %if.then11, label %if.end, !dbg !417

if.then11:                                        ; preds = %if.then7
  %16 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !418
  %17 = load %struct.xTASK_STATUS*, %struct.xTASK_STATUS** %pxTaskStatus.addr, align 8, !dbg !420
  %18 = load i64, i64* %xGetFreeStackSpace.addr, align 8, !dbg !421
  %19 = load i32, i32* %eState.addr, align 4, !dbg !422
  call void @vTaskGetInfo(%struct.tskTaskControlBlock* %16, %struct.xTASK_STATUS* %17, i64 %18, i32 %19), !dbg !423
  br label %if.end, !dbg !424

if.end:                                           ; preds = %if.then11, %if.then7
  br label %if.end12, !dbg !425

if.end12:                                         ; preds = %if.end, %land.end
  br label %if.end13

if.end13:                                         ; preds = %if.end12, %if.then2
  br label %if.end14, !dbg !426

if.end14:                                         ; preds = %if.end13, %entry
  ret void, !dbg !427
}

declare dso_local void @vTaskGetInfo(%struct.tskTaskControlBlock*, %struct.xTASK_STATUS*, i64, i32) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.tskTaskControlBlock* @MPU_xTaskGetIdleTaskHandleImpl() #0 section "privileged_functions" !dbg !428 {
entry:
  %xIdleTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xIdleTaskHandle, metadata !431, metadata !DIExpression()), !dbg !432
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xIdleTaskHandle, align 8, !dbg !432
  %call = call %struct.tskTaskControlBlock* @xTaskGetIdleTaskHandle(), !dbg !433
  store %struct.tskTaskControlBlock* %call, %struct.tskTaskControlBlock** %xIdleTaskHandle, align 8, !dbg !434
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xIdleTaskHandle, align 8, !dbg !435
  ret %struct.tskTaskControlBlock* %0, !dbg !436
}

declare dso_local %struct.tskTaskControlBlock* @xTaskGetIdleTaskHandle() #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTaskSuspendImpl(%struct.tskTaskControlBlock* %pxTaskToSuspend) #0 section "privileged_functions" !dbg !437 {
entry:
  %pxTaskToSuspend.addr = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %pxTaskToSuspend, %struct.tskTaskControlBlock** %pxTaskToSuspend.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %pxTaskToSuspend.addr, metadata !440, metadata !DIExpression()), !dbg !441
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !442, metadata !DIExpression()), !dbg !443
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !444, metadata !DIExpression()), !dbg !445
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !445
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTaskToSuspend.addr, align 8, !dbg !446
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !448
  br i1 %cmp, label %if.then, label %if.else, !dbg !449

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTaskToSuspend.addr, align 8, !dbg !450
  call void @vTaskSuspend(%struct.tskTaskControlBlock* %1), !dbg !452
  br label %if.end20, !dbg !453

if.else:                                          ; preds = %entry
  %call = call i64 @xTaskGetSchedulerState(), !dbg !454
  %cmp1 = icmp eq i64 %call, 1, !dbg !457
  br i1 %cmp1, label %if.then5, label %lor.lhs.false, !dbg !458

lor.lhs.false:                                    ; preds = %if.else
  %call2 = call i32 (...) bitcast (void ()* @portIS_TASK_PRIVILEGED to i32 (...)*)(), !dbg !459
  %conv = sext i32 %call2 to i64, !dbg !459
  %cmp3 = icmp eq i64 %conv, 1, !dbg !460
  br i1 %cmp3, label %if.then5, label %if.end19, !dbg !461

if.then5:                                         ; preds = %lor.lhs.false, %if.else
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTaskToSuspend.addr, align 8, !dbg !462
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !464
  store i32 %3, i32* %lIndex, align 4, !dbg !465
  %4 = load i32, i32* %lIndex, align 4, !dbg !466
  %cmp6 = icmp sge i32 %4, 1, !dbg !466
  br i1 %cmp6, label %land.rhs, label %land.end, !dbg !466

land.rhs:                                         ; preds = %if.then5
  %5 = load i32, i32* %lIndex, align 4, !dbg !466
  %cmp8 = icmp slt i32 %5, 257, !dbg !466
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.then5
  %6 = phi i1 [ false, %if.then5 ], [ %cmp8, %land.rhs ], !dbg !468
  %land.ext = zext i1 %6 to i32, !dbg !466
  %conv10 = sext i32 %land.ext to i64, !dbg !466
  %cmp11 = icmp ne i64 %conv10, 0, !dbg !469
  br i1 %cmp11, label %if.then13, label %if.end18, !dbg !470

if.then13:                                        ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !471
  %sub = sub nsw i32 %7, 1, !dbg !471
  %call14 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !471
  %8 = bitcast %struct.OpaqueObject* %call14 to %struct.tskTaskControlBlock*, !dbg !471
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !473
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !474
  %cmp15 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !476
  br i1 %cmp15, label %if.then17, label %if.end, !dbg !477

if.then17:                                        ; preds = %if.then13
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !478
  call void @vTaskSuspend(%struct.tskTaskControlBlock* %10), !dbg !480
  br label %if.end, !dbg !481

if.end:                                           ; preds = %if.then17, %if.then13
  br label %if.end18, !dbg !482

if.end18:                                         ; preds = %if.end, %land.end
  br label %if.end19, !dbg !483

if.end19:                                         ; preds = %if.end18, %lor.lhs.false
  br label %if.end20

if.end20:                                         ; preds = %if.end19, %if.then
  ret void, !dbg !484
}

declare dso_local i64 @xTaskGetSchedulerState() #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTaskResumeImpl(%struct.tskTaskControlBlock* %pxTaskToResume) #0 section "privileged_functions" !dbg !485 {
entry:
  %pxTaskToResume.addr = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %pxTaskToResume, %struct.tskTaskControlBlock** %pxTaskToResume.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %pxTaskToResume.addr, metadata !486, metadata !DIExpression()), !dbg !487
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !488, metadata !DIExpression()), !dbg !489
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !490, metadata !DIExpression()), !dbg !491
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !491
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTaskToResume.addr, align 8, !dbg !492
  %1 = ptrtoint %struct.tskTaskControlBlock* %0 to i32, !dbg !493
  store i32 %1, i32* %lIndex, align 4, !dbg !494
  %2 = load i32, i32* %lIndex, align 4, !dbg !495
  %cmp = icmp sge i32 %2, 1, !dbg !495
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !495

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !495
  %cmp1 = icmp slt i32 %3, 257, !dbg !495
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !497
  %land.ext = zext i1 %4 to i32, !dbg !495
  %conv = sext i32 %land.ext to i64, !dbg !495
  %cmp2 = icmp ne i64 %conv, 0, !dbg !498
  br i1 %cmp2, label %if.then, label %if.end7, !dbg !499

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !500
  %sub = sub nsw i32 %5, 1, !dbg !500
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !500
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tskTaskControlBlock*, !dbg !500
  store %struct.tskTaskControlBlock* %6, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !502
  %7 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !503
  %cmp4 = icmp ne %struct.tskTaskControlBlock* %7, null, !dbg !505
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !506

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !507
  call void @vTaskResume(%struct.tskTaskControlBlock* %8), !dbg !509
  br label %if.end, !dbg !510

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end7, !dbg !511

if.end7:                                          ; preds = %if.end, %land.end
  ret void, !dbg !512
}

declare dso_local void @vTaskResume(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskGetTickCountImpl() #0 section "privileged_functions" !dbg !513 {
entry:
  %xReturn = alloca i64, align 8
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !516, metadata !DIExpression()), !dbg !517
  %call = call i64 @xTaskGetTickCount(), !dbg !518
  store i64 %call, i64* %xReturn, align 8, !dbg !519
  %0 = load i64, i64* %xReturn, align 8, !dbg !520
  ret i64 %0, !dbg !521
}

declare dso_local i64 @xTaskGetTickCount() #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_uxTaskGetNumberOfTasksImpl() #0 section "privileged_functions" !dbg !522 {
entry:
  %uxReturn = alloca i64, align 8
  call void @llvm.dbg.declare(metadata i64* %uxReturn, metadata !525, metadata !DIExpression()), !dbg !526
  %call = call i64 @uxTaskGetNumberOfTasks(), !dbg !527
  store i64 %call, i64* %uxReturn, align 8, !dbg !528
  %0 = load i64, i64* %uxReturn, align 8, !dbg !529
  ret i64 %0, !dbg !530
}

declare dso_local i64 @uxTaskGetNumberOfTasks() #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @MPU_pcTaskGetNameImpl(%struct.tskTaskControlBlock* %xTaskToQuery) #0 section "privileged_functions" !dbg !531 {
entry:
  %xTaskToQuery.addr = alloca %struct.tskTaskControlBlock*, align 8
  %pcReturn = alloca i8*, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTaskToQuery, %struct.tskTaskControlBlock** %xTaskToQuery.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTaskToQuery.addr, metadata !535, metadata !DIExpression()), !dbg !536
  call void @llvm.dbg.declare(metadata i8** %pcReturn, metadata !537, metadata !DIExpression()), !dbg !538
  store i8* null, i8** %pcReturn, align 8, !dbg !538
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !539, metadata !DIExpression()), !dbg !540
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !541, metadata !DIExpression()), !dbg !542
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !542
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToQuery.addr, align 8, !dbg !543
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !545
  br i1 %cmp, label %if.then, label %if.else, !dbg !546

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToQuery.addr, align 8, !dbg !547
  %call = call i8* @pcTaskGetName(%struct.tskTaskControlBlock* %1), !dbg !549
  store i8* %call, i8** %pcReturn, align 8, !dbg !550
  br label %if.end12, !dbg !551

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToQuery.addr, align 8, !dbg !552
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !554
  store i32 %3, i32* %lIndex, align 4, !dbg !555
  %4 = load i32, i32* %lIndex, align 4, !dbg !556
  %cmp1 = icmp sge i32 %4, 1, !dbg !556
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !556

land.rhs:                                         ; preds = %if.else
  %5 = load i32, i32* %lIndex, align 4, !dbg !556
  %cmp2 = icmp slt i32 %5, 257, !dbg !556
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %6 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !558
  %land.ext = zext i1 %6 to i32, !dbg !556
  %conv = sext i32 %land.ext to i64, !dbg !556
  %cmp3 = icmp ne i64 %conv, 0, !dbg !559
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !560

if.then5:                                         ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !561
  %sub = sub nsw i32 %7, 1, !dbg !561
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !561
  %8 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !561
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !563
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !564
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !566
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !567

if.then9:                                         ; preds = %if.then5
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !568
  %call10 = call i8* @pcTaskGetName(%struct.tskTaskControlBlock* %10), !dbg !570
  store i8* %call10, i8** %pcReturn, align 8, !dbg !571
  br label %if.end, !dbg !572

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !573

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %11 = load i8*, i8** %pcReturn, align 8, !dbg !574
  ret i8* %11, !dbg !575
}

declare dso_local i8* @pcTaskGetName(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MPU_ulTaskGetRunTimeCounterImpl(%struct.tskTaskControlBlock* %xTask) #0 section "privileged_functions" !dbg !576 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %xReturn = alloca i32, align 4
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !579, metadata !DIExpression()), !dbg !580
  call void @llvm.dbg.declare(metadata i32* %xReturn, metadata !581, metadata !DIExpression()), !dbg !582
  store i32 0, i32* %xReturn, align 4, !dbg !582
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !583, metadata !DIExpression()), !dbg !584
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !585, metadata !DIExpression()), !dbg !586
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !586
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !587
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !589
  br i1 %cmp, label %if.then, label %if.else, !dbg !590

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !591
  %call = call i32 @ulTaskGetRunTimeCounter(%struct.tskTaskControlBlock* %1), !dbg !593
  store i32 %call, i32* %xReturn, align 4, !dbg !594
  br label %if.end12, !dbg !595

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !596
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !598
  store i32 %3, i32* %lIndex, align 4, !dbg !599
  %4 = load i32, i32* %lIndex, align 4, !dbg !600
  %cmp1 = icmp sge i32 %4, 1, !dbg !600
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !600

land.rhs:                                         ; preds = %if.else
  %5 = load i32, i32* %lIndex, align 4, !dbg !600
  %cmp2 = icmp slt i32 %5, 257, !dbg !600
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %6 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !602
  %land.ext = zext i1 %6 to i32, !dbg !600
  %conv = sext i32 %land.ext to i64, !dbg !600
  %cmp3 = icmp ne i64 %conv, 0, !dbg !603
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !604

if.then5:                                         ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !605
  %sub = sub nsw i32 %7, 1, !dbg !605
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !605
  %8 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !605
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !607
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !608
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !610
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !611

if.then9:                                         ; preds = %if.then5
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !612
  %call10 = call i32 @ulTaskGetRunTimeCounter(%struct.tskTaskControlBlock* %10), !dbg !614
  store i32 %call10, i32* %xReturn, align 4, !dbg !615
  br label %if.end, !dbg !616

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !617

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %11 = load i32, i32* %xReturn, align 4, !dbg !618
  ret i32 %11, !dbg !619
}

declare dso_local i32 @ulTaskGetRunTimeCounter(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MPU_ulTaskGetRunTimePercentImpl(%struct.tskTaskControlBlock* %xTask) #0 section "privileged_functions" !dbg !620 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %xReturn = alloca i32, align 4
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !621, metadata !DIExpression()), !dbg !622
  call void @llvm.dbg.declare(metadata i32* %xReturn, metadata !623, metadata !DIExpression()), !dbg !624
  store i32 0, i32* %xReturn, align 4, !dbg !624
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !625, metadata !DIExpression()), !dbg !626
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !627, metadata !DIExpression()), !dbg !628
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !628
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !629
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !631
  br i1 %cmp, label %if.then, label %if.else, !dbg !632

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !633
  %call = call i32 @ulTaskGetRunTimePercent(%struct.tskTaskControlBlock* %1), !dbg !635
  store i32 %call, i32* %xReturn, align 4, !dbg !636
  br label %if.end12, !dbg !637

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !638
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !640
  store i32 %3, i32* %lIndex, align 4, !dbg !641
  %4 = load i32, i32* %lIndex, align 4, !dbg !642
  %cmp1 = icmp sge i32 %4, 1, !dbg !642
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !642

land.rhs:                                         ; preds = %if.else
  %5 = load i32, i32* %lIndex, align 4, !dbg !642
  %cmp2 = icmp slt i32 %5, 257, !dbg !642
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %6 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !644
  %land.ext = zext i1 %6 to i32, !dbg !642
  %conv = sext i32 %land.ext to i64, !dbg !642
  %cmp3 = icmp ne i64 %conv, 0, !dbg !645
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !646

if.then5:                                         ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !647
  %sub = sub nsw i32 %7, 1, !dbg !647
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !647
  %8 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !647
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !649
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !650
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !652
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !653

if.then9:                                         ; preds = %if.then5
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !654
  %call10 = call i32 @ulTaskGetRunTimePercent(%struct.tskTaskControlBlock* %10), !dbg !656
  store i32 %call10, i32* %xReturn, align 4, !dbg !657
  br label %if.end, !dbg !658

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !659

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %11 = load i32, i32* %xReturn, align 4, !dbg !660
  ret i32 %11, !dbg !661
}

declare dso_local i32 @ulTaskGetRunTimePercent(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MPU_ulTaskGetIdleRunTimePercentImpl() #0 section "privileged_functions" !dbg !662 {
entry:
  %xReturn = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %xReturn, metadata !665, metadata !DIExpression()), !dbg !666
  %call = call i32 @ulTaskGetIdleRunTimePercent(), !dbg !667
  store i32 %call, i32* %xReturn, align 4, !dbg !668
  %0 = load i32, i32* %xReturn, align 4, !dbg !669
  ret i32 %0, !dbg !670
}

declare dso_local i32 @ulTaskGetIdleRunTimePercent() #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MPU_ulTaskGetIdleRunTimeCounterImpl() #0 section "privileged_functions" !dbg !671 {
entry:
  %xReturn = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %xReturn, metadata !672, metadata !DIExpression()), !dbg !673
  %call = call i32 @ulTaskGetIdleRunTimeCounter(), !dbg !674
  store i32 %call, i32* %xReturn, align 4, !dbg !675
  %0 = load i32, i32* %xReturn, align 4, !dbg !676
  ret i32 %0, !dbg !677
}

declare dso_local i32 @ulTaskGetIdleRunTimeCounter() #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTaskSetApplicationTaskTagImpl(%struct.tskTaskControlBlock* %xTask, i64 (i8*)* %pxTagValue) #0 section "privileged_functions" !dbg !678 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %pxTagValue.addr = alloca i64 (i8*)*, align 8
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !685, metadata !DIExpression()), !dbg !686
  store i64 (i8*)* %pxTagValue, i64 (i8*)** %pxTagValue.addr, align 8
  call void @llvm.dbg.declare(metadata i64 (i8*)** %pxTagValue.addr, metadata !687, metadata !DIExpression()), !dbg !688
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !689, metadata !DIExpression()), !dbg !690
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !690
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !691, metadata !DIExpression()), !dbg !692
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !693
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !695
  br i1 %cmp, label %if.then, label %if.else, !dbg !696

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !697
  %2 = load i64 (i8*)*, i64 (i8*)** %pxTagValue.addr, align 8, !dbg !699
  call void @vTaskSetApplicationTaskTag(%struct.tskTaskControlBlock* %1, i64 (i8*)* %2), !dbg !700
  br label %if.end10, !dbg !701

if.else:                                          ; preds = %entry
  %3 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !702
  %4 = ptrtoint %struct.tskTaskControlBlock* %3 to i32, !dbg !704
  store i32 %4, i32* %lIndex, align 4, !dbg !705
  %5 = load i32, i32* %lIndex, align 4, !dbg !706
  %cmp1 = icmp sge i32 %5, 1, !dbg !706
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !706

land.rhs:                                         ; preds = %if.else
  %6 = load i32, i32* %lIndex, align 4, !dbg !706
  %cmp2 = icmp slt i32 %6, 257, !dbg !706
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %7 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !708
  %land.ext = zext i1 %7 to i32, !dbg !706
  %conv = sext i32 %land.ext to i64, !dbg !706
  %cmp3 = icmp ne i64 %conv, 0, !dbg !709
  br i1 %cmp3, label %if.then5, label %if.end9, !dbg !710

if.then5:                                         ; preds = %land.end
  %8 = load i32, i32* %lIndex, align 4, !dbg !711
  %sub = sub nsw i32 %8, 1, !dbg !711
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !711
  %9 = bitcast %struct.OpaqueObject* %call to %struct.tskTaskControlBlock*, !dbg !711
  store %struct.tskTaskControlBlock* %9, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !713
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !714
  %cmp6 = icmp ne %struct.tskTaskControlBlock* %10, null, !dbg !716
  br i1 %cmp6, label %if.then8, label %if.end, !dbg !717

if.then8:                                         ; preds = %if.then5
  %11 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !718
  %12 = load i64 (i8*)*, i64 (i8*)** %pxTagValue.addr, align 8, !dbg !720
  call void @vTaskSetApplicationTaskTag(%struct.tskTaskControlBlock* %11, i64 (i8*)* %12), !dbg !721
  br label %if.end, !dbg !722

if.end:                                           ; preds = %if.then8, %if.then5
  br label %if.end9, !dbg !723

if.end9:                                          ; preds = %if.end, %land.end
  br label %if.end10

if.end10:                                         ; preds = %if.end9, %if.then
  ret void, !dbg !724
}

declare dso_local void @vTaskSetApplicationTaskTag(%struct.tskTaskControlBlock*, i64 (i8*)*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 (i8*)* @MPU_xTaskGetApplicationTaskTagImpl(%struct.tskTaskControlBlock* %xTask) #0 section "privileged_functions" !dbg !725 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %xReturn = alloca i64 (i8*)*, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !728, metadata !DIExpression()), !dbg !729
  call void @llvm.dbg.declare(metadata i64 (i8*)** %xReturn, metadata !730, metadata !DIExpression()), !dbg !731
  store i64 (i8*)* null, i64 (i8*)** %xReturn, align 8, !dbg !731
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !732, metadata !DIExpression()), !dbg !733
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !734, metadata !DIExpression()), !dbg !735
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !735
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !736
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !738
  br i1 %cmp, label %if.then, label %if.else, !dbg !739

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !740
  %call = call i64 (i8*)* @xTaskGetApplicationTaskTag(%struct.tskTaskControlBlock* %1), !dbg !742
  store i64 (i8*)* %call, i64 (i8*)** %xReturn, align 8, !dbg !743
  br label %if.end12, !dbg !744

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !745
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !747
  store i32 %3, i32* %lIndex, align 4, !dbg !748
  %4 = load i32, i32* %lIndex, align 4, !dbg !749
  %cmp1 = icmp sge i32 %4, 1, !dbg !749
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !749

land.rhs:                                         ; preds = %if.else
  %5 = load i32, i32* %lIndex, align 4, !dbg !749
  %cmp2 = icmp slt i32 %5, 257, !dbg !749
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %6 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !751
  %land.ext = zext i1 %6 to i32, !dbg !749
  %conv = sext i32 %land.ext to i64, !dbg !749
  %cmp3 = icmp ne i64 %conv, 0, !dbg !752
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !753

if.then5:                                         ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !754
  %sub = sub nsw i32 %7, 1, !dbg !754
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !754
  %8 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !754
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !756
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !757
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !759
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !760

if.then9:                                         ; preds = %if.then5
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !761
  %call10 = call i64 (i8*)* @xTaskGetApplicationTaskTag(%struct.tskTaskControlBlock* %10), !dbg !763
  store i64 (i8*)* %call10, i64 (i8*)** %xReturn, align 8, !dbg !764
  br label %if.end, !dbg !765

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !766

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %11 = load i64 (i8*)*, i64 (i8*)** %xReturn, align 8, !dbg !767
  ret i64 (i8*)* %11, !dbg !768
}

declare dso_local i64 (i8*)* @xTaskGetApplicationTaskTag(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTaskSetThreadLocalStoragePointerImpl(%struct.tskTaskControlBlock* %xTaskToSet, i64 %xIndex, i8* %pvValue) #0 section "privileged_functions" !dbg !769 {
entry:
  %xTaskToSet.addr = alloca %struct.tskTaskControlBlock*, align 8
  %xIndex.addr = alloca i64, align 8
  %pvValue.addr = alloca i8*, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTaskToSet, %struct.tskTaskControlBlock** %xTaskToSet.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTaskToSet.addr, metadata !772, metadata !DIExpression()), !dbg !773
  store i64 %xIndex, i64* %xIndex.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xIndex.addr, metadata !774, metadata !DIExpression()), !dbg !775
  store i8* %pvValue, i8** %pvValue.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvValue.addr, metadata !776, metadata !DIExpression()), !dbg !777
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !778, metadata !DIExpression()), !dbg !779
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !780, metadata !DIExpression()), !dbg !781
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !781
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToSet.addr, align 8, !dbg !782
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !784
  br i1 %cmp, label %if.then, label %if.else, !dbg !785

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToSet.addr, align 8, !dbg !786
  %2 = load i64, i64* %xIndex.addr, align 8, !dbg !788
  %3 = load i8*, i8** %pvValue.addr, align 8, !dbg !789
  call void @vTaskSetThreadLocalStoragePointer(%struct.tskTaskControlBlock* %1, i64 %2, i8* %3), !dbg !790
  br label %if.end10, !dbg !791

if.else:                                          ; preds = %entry
  %4 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToSet.addr, align 8, !dbg !792
  %5 = ptrtoint %struct.tskTaskControlBlock* %4 to i32, !dbg !794
  store i32 %5, i32* %lIndex, align 4, !dbg !795
  %6 = load i32, i32* %lIndex, align 4, !dbg !796
  %cmp1 = icmp sge i32 %6, 1, !dbg !796
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !796

land.rhs:                                         ; preds = %if.else
  %7 = load i32, i32* %lIndex, align 4, !dbg !796
  %cmp2 = icmp slt i32 %7, 257, !dbg !796
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %8 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !798
  %land.ext = zext i1 %8 to i32, !dbg !796
  %conv = sext i32 %land.ext to i64, !dbg !796
  %cmp3 = icmp ne i64 %conv, 0, !dbg !799
  br i1 %cmp3, label %if.then5, label %if.end9, !dbg !800

if.then5:                                         ; preds = %land.end
  %9 = load i32, i32* %lIndex, align 4, !dbg !801
  %sub = sub nsw i32 %9, 1, !dbg !801
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !801
  %10 = bitcast %struct.OpaqueObject* %call to %struct.tskTaskControlBlock*, !dbg !801
  store %struct.tskTaskControlBlock* %10, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !803
  %11 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !804
  %cmp6 = icmp ne %struct.tskTaskControlBlock* %11, null, !dbg !806
  br i1 %cmp6, label %if.then8, label %if.end, !dbg !807

if.then8:                                         ; preds = %if.then5
  %12 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !808
  %13 = load i64, i64* %xIndex.addr, align 8, !dbg !810
  %14 = load i8*, i8** %pvValue.addr, align 8, !dbg !811
  call void @vTaskSetThreadLocalStoragePointer(%struct.tskTaskControlBlock* %12, i64 %13, i8* %14), !dbg !812
  br label %if.end, !dbg !813

if.end:                                           ; preds = %if.then8, %if.then5
  br label %if.end9, !dbg !814

if.end9:                                          ; preds = %if.end, %land.end
  br label %if.end10

if.end10:                                         ; preds = %if.end9, %if.then
  ret void, !dbg !815
}

declare dso_local void @vTaskSetThreadLocalStoragePointer(%struct.tskTaskControlBlock*, i64, i8*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @MPU_pvTaskGetThreadLocalStoragePointerImpl(%struct.tskTaskControlBlock* %xTaskToQuery, i64 %xIndex) #0 section "privileged_functions" !dbg !816 {
entry:
  %xTaskToQuery.addr = alloca %struct.tskTaskControlBlock*, align 8
  %xIndex.addr = alloca i64, align 8
  %pvReturn = alloca i8*, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTaskToQuery, %struct.tskTaskControlBlock** %xTaskToQuery.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTaskToQuery.addr, metadata !819, metadata !DIExpression()), !dbg !820
  store i64 %xIndex, i64* %xIndex.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xIndex.addr, metadata !821, metadata !DIExpression()), !dbg !822
  call void @llvm.dbg.declare(metadata i8** %pvReturn, metadata !823, metadata !DIExpression()), !dbg !824
  store i8* null, i8** %pvReturn, align 8, !dbg !824
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !825, metadata !DIExpression()), !dbg !826
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !827, metadata !DIExpression()), !dbg !828
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !828
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToQuery.addr, align 8, !dbg !829
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !831
  br i1 %cmp, label %if.then, label %if.else, !dbg !832

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToQuery.addr, align 8, !dbg !833
  %2 = load i64, i64* %xIndex.addr, align 8, !dbg !835
  %call = call i8* @pvTaskGetThreadLocalStoragePointer(%struct.tskTaskControlBlock* %1, i64 %2), !dbg !836
  store i8* %call, i8** %pvReturn, align 8, !dbg !837
  br label %if.end12, !dbg !838

if.else:                                          ; preds = %entry
  %3 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToQuery.addr, align 8, !dbg !839
  %4 = ptrtoint %struct.tskTaskControlBlock* %3 to i32, !dbg !841
  store i32 %4, i32* %lIndex, align 4, !dbg !842
  %5 = load i32, i32* %lIndex, align 4, !dbg !843
  %cmp1 = icmp sge i32 %5, 1, !dbg !843
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !843

land.rhs:                                         ; preds = %if.else
  %6 = load i32, i32* %lIndex, align 4, !dbg !843
  %cmp2 = icmp slt i32 %6, 257, !dbg !843
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %7 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !845
  %land.ext = zext i1 %7 to i32, !dbg !843
  %conv = sext i32 %land.ext to i64, !dbg !843
  %cmp3 = icmp ne i64 %conv, 0, !dbg !846
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !847

if.then5:                                         ; preds = %land.end
  %8 = load i32, i32* %lIndex, align 4, !dbg !848
  %sub = sub nsw i32 %8, 1, !dbg !848
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !848
  %9 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !848
  store %struct.tskTaskControlBlock* %9, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !850
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !851
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %10, null, !dbg !853
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !854

if.then9:                                         ; preds = %if.then5
  %11 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !855
  %12 = load i64, i64* %xIndex.addr, align 8, !dbg !857
  %call10 = call i8* @pvTaskGetThreadLocalStoragePointer(%struct.tskTaskControlBlock* %11, i64 %12), !dbg !858
  store i8* %call10, i8** %pvReturn, align 8, !dbg !859
  br label %if.end, !dbg !860

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !861

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %13 = load i8*, i8** %pvReturn, align 8, !dbg !862
  ret i8* %13, !dbg !863
}

declare dso_local i8* @pvTaskGetThreadLocalStoragePointer(%struct.tskTaskControlBlock*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_uxTaskGetSystemStateImpl(%struct.xTASK_STATUS* %pxTaskStatusArray, i64 %uxArraySize, i32* %pulTotalRunTime) #0 section "privileged_functions" !dbg !864 {
entry:
  %pxTaskStatusArray.addr = alloca %struct.xTASK_STATUS*, align 8
  %uxArraySize.addr = alloca i64, align 8
  %pulTotalRunTime.addr = alloca i32*, align 8
  %uxReturn = alloca i64, align 8
  %xIsTaskStatusArrayWriteable = alloca i64, align 8
  %xIsTotalRunTimeWriteable = alloca i64, align 8
  store %struct.xTASK_STATUS* %pxTaskStatusArray, %struct.xTASK_STATUS** %pxTaskStatusArray.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xTASK_STATUS** %pxTaskStatusArray.addr, metadata !868, metadata !DIExpression()), !dbg !869
  store i64 %uxArraySize, i64* %uxArraySize.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxArraySize.addr, metadata !870, metadata !DIExpression()), !dbg !871
  store i32* %pulTotalRunTime, i32** %pulTotalRunTime.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %pulTotalRunTime.addr, metadata !872, metadata !DIExpression()), !dbg !873
  call void @llvm.dbg.declare(metadata i64* %uxReturn, metadata !874, metadata !DIExpression()), !dbg !875
  store i64 0, i64* %uxReturn, align 8, !dbg !875
  call void @llvm.dbg.declare(metadata i64* %xIsTaskStatusArrayWriteable, metadata !876, metadata !DIExpression()), !dbg !877
  store i64 0, i64* %xIsTaskStatusArrayWriteable, align 8, !dbg !877
  call void @llvm.dbg.declare(metadata i64* %xIsTotalRunTimeWriteable, metadata !878, metadata !DIExpression()), !dbg !879
  store i64 0, i64* %xIsTotalRunTimeWriteable, align 8, !dbg !879
  %0 = load %struct.xTASK_STATUS*, %struct.xTASK_STATUS** %pxTaskStatusArray.addr, align 8, !dbg !880
  %1 = bitcast %struct.xTASK_STATUS* %0 to i8*, !dbg !880
  %2 = load i64, i64* %uxArraySize.addr, align 8, !dbg !881
  %mul = mul i64 72, %2, !dbg !882
  %conv = trunc i64 %mul to i32, !dbg !883
  %call = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %1, i32 %conv, i32 2), !dbg !884
  store i64 %call, i64* %xIsTaskStatusArrayWriteable, align 8, !dbg !885
  %3 = load i32*, i32** %pulTotalRunTime.addr, align 8, !dbg !886
  %cmp = icmp ne i32* %3, null, !dbg !888
  br i1 %cmp, label %if.then, label %if.end, !dbg !889

if.then:                                          ; preds = %entry
  %4 = load i32*, i32** %pulTotalRunTime.addr, align 8, !dbg !890
  %5 = bitcast i32* %4 to i8*, !dbg !890
  %call2 = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %5, i32 4, i32 2), !dbg !892
  store i64 %call2, i64* %xIsTotalRunTimeWriteable, align 8, !dbg !893
  br label %if.end, !dbg !894

if.end:                                           ; preds = %if.then, %entry
  %6 = load i64, i64* %xIsTaskStatusArrayWriteable, align 8, !dbg !895
  %cmp3 = icmp eq i64 %6, 1, !dbg !897
  br i1 %cmp3, label %land.lhs.true, label %if.end11, !dbg !898

land.lhs.true:                                    ; preds = %if.end
  %7 = load i32*, i32** %pulTotalRunTime.addr, align 8, !dbg !899
  %cmp5 = icmp eq i32* %7, null, !dbg !900
  br i1 %cmp5, label %if.then9, label %lor.lhs.false, !dbg !901

lor.lhs.false:                                    ; preds = %land.lhs.true
  %8 = load i64, i64* %xIsTotalRunTimeWriteable, align 8, !dbg !902
  %cmp7 = icmp eq i64 %8, 1, !dbg !903
  br i1 %cmp7, label %if.then9, label %if.end11, !dbg !904

if.then9:                                         ; preds = %lor.lhs.false, %land.lhs.true
  %9 = load %struct.xTASK_STATUS*, %struct.xTASK_STATUS** %pxTaskStatusArray.addr, align 8, !dbg !905
  %10 = load i64, i64* %uxArraySize.addr, align 8, !dbg !907
  %11 = load i32*, i32** %pulTotalRunTime.addr, align 8, !dbg !908
  %call10 = call i64 @uxTaskGetSystemState(%struct.xTASK_STATUS* %9, i64 %10, i32* %11), !dbg !909
  store i64 %call10, i64* %uxReturn, align 8, !dbg !910
  br label %if.end11, !dbg !911

if.end11:                                         ; preds = %if.then9, %lor.lhs.false, %if.end
  %12 = load i64, i64* %uxReturn, align 8, !dbg !912
  ret i64 %12, !dbg !913
}

declare dso_local i64 @uxTaskGetSystemState(%struct.xTASK_STATUS*, i64, i32*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_uxTaskGetStackHighWaterMarkImpl(%struct.tskTaskControlBlock* %xTask) #0 section "privileged_functions" !dbg !914 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %uxReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !917, metadata !DIExpression()), !dbg !918
  call void @llvm.dbg.declare(metadata i64* %uxReturn, metadata !919, metadata !DIExpression()), !dbg !920
  store i64 0, i64* %uxReturn, align 8, !dbg !920
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !921, metadata !DIExpression()), !dbg !922
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !923, metadata !DIExpression()), !dbg !924
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !924
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !925
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !927
  br i1 %cmp, label %if.then, label %if.else, !dbg !928

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !929
  %call = call i64 @uxTaskGetStackHighWaterMark(%struct.tskTaskControlBlock* %1), !dbg !931
  store i64 %call, i64* %uxReturn, align 8, !dbg !932
  br label %if.end12, !dbg !933

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !934
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !936
  store i32 %3, i32* %lIndex, align 4, !dbg !937
  %4 = load i32, i32* %lIndex, align 4, !dbg !938
  %cmp1 = icmp sge i32 %4, 1, !dbg !938
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !938

land.rhs:                                         ; preds = %if.else
  %5 = load i32, i32* %lIndex, align 4, !dbg !938
  %cmp2 = icmp slt i32 %5, 257, !dbg !938
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %6 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !940
  %land.ext = zext i1 %6 to i32, !dbg !938
  %conv = sext i32 %land.ext to i64, !dbg !938
  %cmp3 = icmp ne i64 %conv, 0, !dbg !941
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !942

if.then5:                                         ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !943
  %sub = sub nsw i32 %7, 1, !dbg !943
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !943
  %8 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !943
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !945
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !946
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !948
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !949

if.then9:                                         ; preds = %if.then5
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !950
  %call10 = call i64 @uxTaskGetStackHighWaterMark(%struct.tskTaskControlBlock* %10), !dbg !952
  store i64 %call10, i64* %uxReturn, align 8, !dbg !953
  br label %if.end, !dbg !954

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !955

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %11 = load i64, i64* %uxReturn, align 8, !dbg !956
  ret i64 %11, !dbg !957
}

declare dso_local i64 @uxTaskGetStackHighWaterMark(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i16 @MPU_uxTaskGetStackHighWaterMark2Impl(%struct.tskTaskControlBlock* %xTask) #0 section "privileged_functions" !dbg !958 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %uxReturn = alloca i16, align 2
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !961, metadata !DIExpression()), !dbg !962
  call void @llvm.dbg.declare(metadata i16* %uxReturn, metadata !963, metadata !DIExpression()), !dbg !964
  store i16 0, i16* %uxReturn, align 2, !dbg !964
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !965, metadata !DIExpression()), !dbg !966
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !967, metadata !DIExpression()), !dbg !968
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !968
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !969
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !971
  br i1 %cmp, label %if.then, label %if.else, !dbg !972

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !973
  %call = call zeroext i16 @uxTaskGetStackHighWaterMark2(%struct.tskTaskControlBlock* %1), !dbg !975
  store i16 %call, i16* %uxReturn, align 2, !dbg !976
  br label %if.end12, !dbg !977

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !978
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !980
  store i32 %3, i32* %lIndex, align 4, !dbg !981
  %4 = load i32, i32* %lIndex, align 4, !dbg !982
  %cmp1 = icmp sge i32 %4, 1, !dbg !982
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !982

land.rhs:                                         ; preds = %if.else
  %5 = load i32, i32* %lIndex, align 4, !dbg !982
  %cmp2 = icmp slt i32 %5, 257, !dbg !982
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %6 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !984
  %land.ext = zext i1 %6 to i32, !dbg !982
  %conv = sext i32 %land.ext to i64, !dbg !982
  %cmp3 = icmp ne i64 %conv, 0, !dbg !985
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !986

if.then5:                                         ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !987
  %sub = sub nsw i32 %7, 1, !dbg !987
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !987
  %8 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !987
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !989
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !990
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !992
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !993

if.then9:                                         ; preds = %if.then5
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !994
  %call10 = call zeroext i16 @uxTaskGetStackHighWaterMark2(%struct.tskTaskControlBlock* %10), !dbg !996
  store i16 %call10, i16* %uxReturn, align 2, !dbg !997
  br label %if.end, !dbg !998

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !999

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %11 = load i16, i16* %uxReturn, align 2, !dbg !1000
  ret i16 %11, !dbg !1001
}

declare dso_local zeroext i16 @uxTaskGetStackHighWaterMark2(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.tskTaskControlBlock* @MPU_xTaskGetCurrentTaskHandleImpl() #0 section "privileged_functions" !dbg !1002 {
entry:
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %xExternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1003, metadata !DIExpression()), !dbg !1004
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1004
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xExternalTaskHandle, metadata !1005, metadata !DIExpression()), !dbg !1006
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xExternalTaskHandle, align 8, !dbg !1006
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1007, metadata !DIExpression()), !dbg !1008
  %call = call %struct.tskTaskControlBlock* @xTaskGetCurrentTaskHandle(), !dbg !1009
  store %struct.tskTaskControlBlock* %call, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1010
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1011
  %cmp = icmp ne %struct.tskTaskControlBlock* %0, null, !dbg !1013
  br i1 %cmp, label %if.then, label %if.end4, !dbg !1014

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1015
  %2 = bitcast %struct.tskTaskControlBlock* %1 to %struct.OpaqueObject*, !dbg !1015
  %call1 = call i32 @MPU_GetIndexForHandle(%struct.OpaqueObject* %2, i32 2), !dbg !1015
  store i32 %call1, i32* %lIndex, align 4, !dbg !1017
  %3 = load i32, i32* %lIndex, align 4, !dbg !1018
  %cmp2 = icmp ne i32 %3, -1, !dbg !1020
  br i1 %cmp2, label %if.then3, label %if.end, !dbg !1021

if.then3:                                         ; preds = %if.then
  %4 = load i32, i32* %lIndex, align 4, !dbg !1022
  %add = add nsw i32 %4, 1, !dbg !1022
  %conv = sext i32 %add to i64, !dbg !1024
  %5 = inttoptr i64 %conv to %struct.tskTaskControlBlock*, !dbg !1024
  store %struct.tskTaskControlBlock* %5, %struct.tskTaskControlBlock** %xExternalTaskHandle, align 8, !dbg !1025
  br label %if.end, !dbg !1026

if.end:                                           ; preds = %if.then3, %if.then
  br label %if.end4, !dbg !1027

if.end4:                                          ; preds = %if.end, %entry
  %6 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xExternalTaskHandle, align 8, !dbg !1028
  ret %struct.tskTaskControlBlock* %6, !dbg !1029
}

declare dso_local %struct.tskTaskControlBlock* @xTaskGetCurrentTaskHandle() #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @MPU_GetIndexForHandle(%struct.OpaqueObject* %xHandle, i32 %ulKernelObjectType) #0 section "privileged_functions" !dbg !1030 {
entry:
  %xHandle.addr = alloca %struct.OpaqueObject*, align 8
  %ulKernelObjectType.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %lIndex = alloca i32, align 4
  store %struct.OpaqueObject* %xHandle, %struct.OpaqueObject** %xHandle.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.OpaqueObject** %xHandle.addr, metadata !1033, metadata !DIExpression()), !dbg !1034
  store i32 %ulKernelObjectType, i32* %ulKernelObjectType.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %ulKernelObjectType.addr, metadata !1035, metadata !DIExpression()), !dbg !1036
  call void @llvm.dbg.declare(metadata i32* %i, metadata !1037, metadata !DIExpression()), !dbg !1038
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1039, metadata !DIExpression()), !dbg !1040
  store i32 -1, i32* %lIndex, align 4, !dbg !1040
  %0 = load %struct.OpaqueObject*, %struct.OpaqueObject** %xHandle.addr, align 8, !dbg !1041
  %cmp = icmp ne %struct.OpaqueObject* %0, null, !dbg !1041
  %conv = zext i1 %cmp to i32, !dbg !1041
  %cmp1 = icmp eq i32 %conv, 0, !dbg !1041
  br i1 %cmp1, label %if.then, label %if.end, !dbg !1043

if.then:                                          ; preds = %entry
  call void @vAssertCalled(i8* getelementptr inbounds ([68 x i8], [68 x i8]* @.str, i64 0, i64 0), i64 286), !dbg !1041
  br label %if.end, !dbg !1041

if.end:                                           ; preds = %if.then, %entry
  store i32 0, i32* %i, align 4, !dbg !1044
  br label %for.cond, !dbg !1046

for.cond:                                         ; preds = %for.inc, %if.end
  %1 = load i32, i32* %i, align 4, !dbg !1047
  %cmp3 = icmp slt i32 %1, 256, !dbg !1049
  br i1 %cmp3, label %for.body, label %for.end, !dbg !1050

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %i, align 4, !dbg !1051
  %idxprom = sext i32 %2 to i64, !dbg !1054
  %arrayidx = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom, !dbg !1054
  %xInternalObjectHandle = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx, i32 0, i32 0, !dbg !1055
  %3 = load %struct.OpaqueObject*, %struct.OpaqueObject** %xInternalObjectHandle, align 8, !dbg !1055
  %4 = load %struct.OpaqueObject*, %struct.OpaqueObject** %xHandle.addr, align 8, !dbg !1056
  %cmp5 = icmp eq %struct.OpaqueObject* %3, %4, !dbg !1057
  br i1 %cmp5, label %land.lhs.true, label %if.end13, !dbg !1058

land.lhs.true:                                    ; preds = %for.body
  %5 = load i32, i32* %i, align 4, !dbg !1059
  %idxprom7 = sext i32 %5 to i64, !dbg !1060
  %arrayidx8 = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom7, !dbg !1060
  %ulKernelObjectType9 = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx8, i32 0, i32 1, !dbg !1061
  %6 = load i32, i32* %ulKernelObjectType9, align 8, !dbg !1061
  %7 = load i32, i32* %ulKernelObjectType.addr, align 4, !dbg !1062
  %cmp10 = icmp eq i32 %6, %7, !dbg !1063
  br i1 %cmp10, label %if.then12, label %if.end13, !dbg !1064

if.then12:                                        ; preds = %land.lhs.true
  %8 = load i32, i32* %i, align 4, !dbg !1065
  store i32 %8, i32* %lIndex, align 4, !dbg !1067
  br label %for.end, !dbg !1068

if.end13:                                         ; preds = %land.lhs.true, %for.body
  br label %for.inc, !dbg !1069

for.inc:                                          ; preds = %if.end13
  %9 = load i32, i32* %i, align 4, !dbg !1070
  %inc = add nsw i32 %9, 1, !dbg !1070
  store i32 %inc, i32* %i, align 4, !dbg !1070
  br label %for.cond, !dbg !1071, !llvm.loop !1072

for.end:                                          ; preds = %if.then12, %for.cond
  %10 = load i32, i32* %lIndex, align 4, !dbg !1074
  ret i32 %10, !dbg !1075
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskGetSchedulerStateImpl() #0 section "privileged_functions" !dbg !1076 {
entry:
  %xReturn = alloca i64, align 8
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !1079, metadata !DIExpression()), !dbg !1080
  store i64 1, i64* %xReturn, align 8, !dbg !1080
  %call = call i64 @xTaskGetSchedulerState(), !dbg !1081
  store i64 %call, i64* %xReturn, align 8, !dbg !1082
  %0 = load i64, i64* %xReturn, align 8, !dbg !1083
  ret i64 %0, !dbg !1084
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTaskSetTimeOutStateImpl(%struct.xTIME_OUT* %pxTimeOut) #0 section "privileged_functions" !dbg !1085 {
entry:
  %pxTimeOut.addr = alloca %struct.xTIME_OUT*, align 8
  %xIsTimeOutWriteable = alloca i64, align 8
  store %struct.xTIME_OUT* %pxTimeOut, %struct.xTIME_OUT** %pxTimeOut.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xTIME_OUT** %pxTimeOut.addr, metadata !1095, metadata !DIExpression()), !dbg !1096
  call void @llvm.dbg.declare(metadata i64* %xIsTimeOutWriteable, metadata !1097, metadata !DIExpression()), !dbg !1098
  store i64 0, i64* %xIsTimeOutWriteable, align 8, !dbg !1098
  %0 = load %struct.xTIME_OUT*, %struct.xTIME_OUT** %pxTimeOut.addr, align 8, !dbg !1099
  %1 = bitcast %struct.xTIME_OUT* %0 to i8*, !dbg !1099
  %call = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %1, i32 16, i32 2), !dbg !1100
  store i64 %call, i64* %xIsTimeOutWriteable, align 8, !dbg !1101
  %2 = load i64, i64* %xIsTimeOutWriteable, align 8, !dbg !1102
  %cmp = icmp eq i64 %2, 1, !dbg !1104
  br i1 %cmp, label %if.then, label %if.end, !dbg !1105

if.then:                                          ; preds = %entry
  %3 = load %struct.xTIME_OUT*, %struct.xTIME_OUT** %pxTimeOut.addr, align 8, !dbg !1106
  call void @vTaskSetTimeOutState(%struct.xTIME_OUT* %3), !dbg !1108
  br label %if.end, !dbg !1109

if.end:                                           ; preds = %if.then, %entry
  ret void, !dbg !1110
}

declare dso_local void @vTaskSetTimeOutState(%struct.xTIME_OUT*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskCheckForTimeOutImpl(%struct.xTIME_OUT* %pxTimeOut, i64* %pxTicksToWait) #0 section "privileged_functions" !dbg !1111 {
entry:
  %pxTimeOut.addr = alloca %struct.xTIME_OUT*, align 8
  %pxTicksToWait.addr = alloca i64*, align 8
  %xReturn = alloca i64, align 8
  %xIsTimeOutWriteable = alloca i64, align 8
  %xIsTicksToWaitWriteable = alloca i64, align 8
  store %struct.xTIME_OUT* %pxTimeOut, %struct.xTIME_OUT** %pxTimeOut.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xTIME_OUT** %pxTimeOut.addr, metadata !1114, metadata !DIExpression()), !dbg !1115
  store i64* %pxTicksToWait, i64** %pxTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxTicksToWait.addr, metadata !1116, metadata !DIExpression()), !dbg !1117
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !1118, metadata !DIExpression()), !dbg !1119
  store i64 0, i64* %xReturn, align 8, !dbg !1119
  call void @llvm.dbg.declare(metadata i64* %xIsTimeOutWriteable, metadata !1120, metadata !DIExpression()), !dbg !1121
  store i64 0, i64* %xIsTimeOutWriteable, align 8, !dbg !1121
  call void @llvm.dbg.declare(metadata i64* %xIsTicksToWaitWriteable, metadata !1122, metadata !DIExpression()), !dbg !1123
  store i64 0, i64* %xIsTicksToWaitWriteable, align 8, !dbg !1123
  %0 = load %struct.xTIME_OUT*, %struct.xTIME_OUT** %pxTimeOut.addr, align 8, !dbg !1124
  %1 = bitcast %struct.xTIME_OUT* %0 to i8*, !dbg !1124
  %call = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %1, i32 16, i32 2), !dbg !1125
  store i64 %call, i64* %xIsTimeOutWriteable, align 8, !dbg !1126
  %2 = load i64*, i64** %pxTicksToWait.addr, align 8, !dbg !1127
  %3 = bitcast i64* %2 to i8*, !dbg !1127
  %call1 = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %3, i32 8, i32 2), !dbg !1128
  store i64 %call1, i64* %xIsTicksToWaitWriteable, align 8, !dbg !1129
  %4 = load i64, i64* %xIsTimeOutWriteable, align 8, !dbg !1130
  %cmp = icmp eq i64 %4, 1, !dbg !1132
  br i1 %cmp, label %land.lhs.true, label %if.end, !dbg !1133

land.lhs.true:                                    ; preds = %entry
  %5 = load i64, i64* %xIsTicksToWaitWriteable, align 8, !dbg !1134
  %cmp2 = icmp eq i64 %5, 1, !dbg !1135
  br i1 %cmp2, label %if.then, label %if.end, !dbg !1136

if.then:                                          ; preds = %land.lhs.true
  %6 = load %struct.xTIME_OUT*, %struct.xTIME_OUT** %pxTimeOut.addr, align 8, !dbg !1137
  %7 = load i64*, i64** %pxTicksToWait.addr, align 8, !dbg !1139
  %call3 = call i64 @xTaskCheckForTimeOut(%struct.xTIME_OUT* %6, i64* %7), !dbg !1140
  store i64 %call3, i64* %xReturn, align 8, !dbg !1141
  br label %if.end, !dbg !1142

if.end:                                           ; preds = %if.then, %land.lhs.true, %entry
  %8 = load i64, i64* %xReturn, align 8, !dbg !1143
  ret i64 %8, !dbg !1144
}

declare dso_local i64 @xTaskCheckForTimeOut(%struct.xTIME_OUT*, i64*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskGenericNotifyImpl(%struct.tskTaskControlBlock* %xTaskToNotify, i64 %uxIndexToNotify, i32 %ulValue, i32 %eAction, i32* %pulPreviousNotificationValue) #0 section "privileged_functions" !dbg !1145 {
entry:
  %xTaskToNotify.addr = alloca %struct.tskTaskControlBlock*, align 8
  %uxIndexToNotify.addr = alloca i64, align 8
  %ulValue.addr = alloca i32, align 4
  %eAction.addr = alloca i32, align 4
  %pulPreviousNotificationValue.addr = alloca i32*, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %xIsPreviousNotificationValueWriteable = alloca i64, align 8
  store %struct.tskTaskControlBlock* %xTaskToNotify, %struct.tskTaskControlBlock** %xTaskToNotify.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTaskToNotify.addr, metadata !1149, metadata !DIExpression()), !dbg !1150
  store i64 %uxIndexToNotify, i64* %uxIndexToNotify.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxIndexToNotify.addr, metadata !1151, metadata !DIExpression()), !dbg !1152
  store i32 %ulValue, i32* %ulValue.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %ulValue.addr, metadata !1153, metadata !DIExpression()), !dbg !1154
  store i32 %eAction, i32* %eAction.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %eAction.addr, metadata !1155, metadata !DIExpression()), !dbg !1156
  store i32* %pulPreviousNotificationValue, i32** %pulPreviousNotificationValue.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %pulPreviousNotificationValue.addr, metadata !1157, metadata !DIExpression()), !dbg !1158
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !1159, metadata !DIExpression()), !dbg !1160
  store i64 0, i64* %xReturn, align 8, !dbg !1160
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1161, metadata !DIExpression()), !dbg !1162
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1163, metadata !DIExpression()), !dbg !1164
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1164
  call void @llvm.dbg.declare(metadata i64* %xIsPreviousNotificationValueWriteable, metadata !1165, metadata !DIExpression()), !dbg !1166
  store i64 0, i64* %xIsPreviousNotificationValueWriteable, align 8, !dbg !1166
  %0 = load i32*, i32** %pulPreviousNotificationValue.addr, align 8, !dbg !1167
  %cmp = icmp ne i32* %0, null, !dbg !1169
  br i1 %cmp, label %if.then, label %if.end, !dbg !1170

if.then:                                          ; preds = %entry
  %1 = load i32*, i32** %pulPreviousNotificationValue.addr, align 8, !dbg !1171
  %2 = bitcast i32* %1 to i8*, !dbg !1171
  %call = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %2, i32 4, i32 2), !dbg !1173
  store i64 %call, i64* %xIsPreviousNotificationValueWriteable, align 8, !dbg !1174
  br label %if.end, !dbg !1175

if.end:                                           ; preds = %if.then, %entry
  %3 = load i32*, i32** %pulPreviousNotificationValue.addr, align 8, !dbg !1176
  %cmp1 = icmp eq i32* %3, null, !dbg !1178
  br i1 %cmp1, label %if.then3, label %lor.lhs.false, !dbg !1179

lor.lhs.false:                                    ; preds = %if.end
  %4 = load i64, i64* %xIsPreviousNotificationValueWriteable, align 8, !dbg !1180
  %cmp2 = icmp eq i64 %4, 1, !dbg !1181
  br i1 %cmp2, label %if.then3, label %if.end16, !dbg !1182

if.then3:                                         ; preds = %lor.lhs.false, %if.end
  %5 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToNotify.addr, align 8, !dbg !1183
  %6 = ptrtoint %struct.tskTaskControlBlock* %5 to i32, !dbg !1185
  store i32 %6, i32* %lIndex, align 4, !dbg !1186
  %7 = load i32, i32* %lIndex, align 4, !dbg !1187
  %cmp4 = icmp sge i32 %7, 1, !dbg !1187
  br i1 %cmp4, label %land.rhs, label %land.end, !dbg !1187

land.rhs:                                         ; preds = %if.then3
  %8 = load i32, i32* %lIndex, align 4, !dbg !1187
  %cmp5 = icmp slt i32 %8, 257, !dbg !1187
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.then3
  %9 = phi i1 [ false, %if.then3 ], [ %cmp5, %land.rhs ], !dbg !1189
  %land.ext = zext i1 %9 to i32, !dbg !1187
  %conv = sext i32 %land.ext to i64, !dbg !1187
  %cmp6 = icmp ne i64 %conv, 0, !dbg !1190
  br i1 %cmp6, label %if.then8, label %if.end15, !dbg !1191

if.then8:                                         ; preds = %land.end
  %10 = load i32, i32* %lIndex, align 4, !dbg !1192
  %sub = sub nsw i32 %10, 1, !dbg !1192
  %call9 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !1192
  %11 = bitcast %struct.OpaqueObject* %call9 to %struct.tskTaskControlBlock*, !dbg !1192
  store %struct.tskTaskControlBlock* %11, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1194
  %12 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1195
  %cmp10 = icmp ne %struct.tskTaskControlBlock* %12, null, !dbg !1197
  br i1 %cmp10, label %if.then12, label %if.end14, !dbg !1198

if.then12:                                        ; preds = %if.then8
  %13 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1199
  %14 = load i64, i64* %uxIndexToNotify.addr, align 8, !dbg !1201
  %15 = load i32, i32* %ulValue.addr, align 4, !dbg !1202
  %16 = load i32, i32* %eAction.addr, align 4, !dbg !1203
  %17 = load i32*, i32** %pulPreviousNotificationValue.addr, align 8, !dbg !1204
  %call13 = call i64 @xTaskGenericNotify(%struct.tskTaskControlBlock* %13, i64 %14, i32 %15, i32 %16, i32* %17), !dbg !1205
  store i64 %call13, i64* %xReturn, align 8, !dbg !1206
  br label %if.end14, !dbg !1207

if.end14:                                         ; preds = %if.then12, %if.then8
  br label %if.end15, !dbg !1208

if.end15:                                         ; preds = %if.end14, %land.end
  br label %if.end16, !dbg !1209

if.end16:                                         ; preds = %if.end15, %lor.lhs.false
  %18 = load i64, i64* %xReturn, align 8, !dbg !1210
  ret i64 %18, !dbg !1211
}

declare dso_local i64 @xTaskGenericNotify(%struct.tskTaskControlBlock*, i64, i32, i32, i32*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskGenericNotifyWaitImpl(i64 %uxIndexToWaitOn, i32 %ulBitsToClearOnEntry, i32 %ulBitsToClearOnExit, i32* %pulNotificationValue, i64 %xTicksToWait) #0 section "privileged_functions" !dbg !1212 {
entry:
  %uxIndexToWaitOn.addr = alloca i64, align 8
  %ulBitsToClearOnEntry.addr = alloca i32, align 4
  %ulBitsToClearOnExit.addr = alloca i32, align 4
  %pulNotificationValue.addr = alloca i32*, align 8
  %xTicksToWait.addr = alloca i64, align 8
  %xReturn = alloca i64, align 8
  %xIsNotificationValueWritable = alloca i64, align 8
  store i64 %uxIndexToWaitOn, i64* %uxIndexToWaitOn.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxIndexToWaitOn.addr, metadata !1215, metadata !DIExpression()), !dbg !1216
  store i32 %ulBitsToClearOnEntry, i32* %ulBitsToClearOnEntry.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %ulBitsToClearOnEntry.addr, metadata !1217, metadata !DIExpression()), !dbg !1218
  store i32 %ulBitsToClearOnExit, i32* %ulBitsToClearOnExit.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %ulBitsToClearOnExit.addr, metadata !1219, metadata !DIExpression()), !dbg !1220
  store i32* %pulNotificationValue, i32** %pulNotificationValue.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %pulNotificationValue.addr, metadata !1221, metadata !DIExpression()), !dbg !1222
  store i64 %xTicksToWait, i64* %xTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToWait.addr, metadata !1223, metadata !DIExpression()), !dbg !1224
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !1225, metadata !DIExpression()), !dbg !1226
  store i64 0, i64* %xReturn, align 8, !dbg !1226
  call void @llvm.dbg.declare(metadata i64* %xIsNotificationValueWritable, metadata !1227, metadata !DIExpression()), !dbg !1228
  store i64 0, i64* %xIsNotificationValueWritable, align 8, !dbg !1228
  %0 = load i32*, i32** %pulNotificationValue.addr, align 8, !dbg !1229
  %cmp = icmp ne i32* %0, null, !dbg !1231
  br i1 %cmp, label %if.then, label %if.end, !dbg !1232

if.then:                                          ; preds = %entry
  %1 = load i32*, i32** %pulNotificationValue.addr, align 8, !dbg !1233
  %2 = bitcast i32* %1 to i8*, !dbg !1233
  %call = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %2, i32 4, i32 2), !dbg !1235
  store i64 %call, i64* %xIsNotificationValueWritable, align 8, !dbg !1236
  br label %if.end, !dbg !1237

if.end:                                           ; preds = %if.then, %entry
  %3 = load i32*, i32** %pulNotificationValue.addr, align 8, !dbg !1238
  %cmp1 = icmp eq i32* %3, null, !dbg !1240
  br i1 %cmp1, label %if.then3, label %lor.lhs.false, !dbg !1241

lor.lhs.false:                                    ; preds = %if.end
  %4 = load i64, i64* %xIsNotificationValueWritable, align 8, !dbg !1242
  %cmp2 = icmp eq i64 %4, 1, !dbg !1243
  br i1 %cmp2, label %if.then3, label %if.end5, !dbg !1244

if.then3:                                         ; preds = %lor.lhs.false, %if.end
  %5 = load i64, i64* %uxIndexToWaitOn.addr, align 8, !dbg !1245
  %6 = load i32, i32* %ulBitsToClearOnEntry.addr, align 4, !dbg !1247
  %7 = load i32, i32* %ulBitsToClearOnExit.addr, align 4, !dbg !1248
  %8 = load i32*, i32** %pulNotificationValue.addr, align 8, !dbg !1249
  %9 = load i64, i64* %xTicksToWait.addr, align 8, !dbg !1250
  %call4 = call i64 @xTaskGenericNotifyWait(i64 %5, i32 %6, i32 %7, i32* %8, i64 %9), !dbg !1251
  store i64 %call4, i64* %xReturn, align 8, !dbg !1252
  br label %if.end5, !dbg !1253

if.end5:                                          ; preds = %if.then3, %lor.lhs.false
  %10 = load i64, i64* %xReturn, align 8, !dbg !1254
  ret i64 %10, !dbg !1255
}

declare dso_local i64 @xTaskGenericNotifyWait(i64, i32, i32, i32*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MPU_ulTaskGenericNotifyTakeImpl(i64 %uxIndexToWaitOn, i64 %xClearCountOnExit, i64 %xTicksToWait) #0 section "privileged_functions" !dbg !1256 {
entry:
  %uxIndexToWaitOn.addr = alloca i64, align 8
  %xClearCountOnExit.addr = alloca i64, align 8
  %xTicksToWait.addr = alloca i64, align 8
  %ulReturn = alloca i32, align 4
  store i64 %uxIndexToWaitOn, i64* %uxIndexToWaitOn.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxIndexToWaitOn.addr, metadata !1259, metadata !DIExpression()), !dbg !1260
  store i64 %xClearCountOnExit, i64* %xClearCountOnExit.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xClearCountOnExit.addr, metadata !1261, metadata !DIExpression()), !dbg !1262
  store i64 %xTicksToWait, i64* %xTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToWait.addr, metadata !1263, metadata !DIExpression()), !dbg !1264
  call void @llvm.dbg.declare(metadata i32* %ulReturn, metadata !1265, metadata !DIExpression()), !dbg !1266
  %0 = load i64, i64* %uxIndexToWaitOn.addr, align 8, !dbg !1267
  %1 = load i64, i64* %xClearCountOnExit.addr, align 8, !dbg !1268
  %2 = load i64, i64* %xTicksToWait.addr, align 8, !dbg !1269
  %call = call i32 @ulTaskGenericNotifyTake(i64 %0, i64 %1, i64 %2), !dbg !1270
  store i32 %call, i32* %ulReturn, align 4, !dbg !1271
  %3 = load i32, i32* %ulReturn, align 4, !dbg !1272
  ret i32 %3, !dbg !1273
}

declare dso_local i32 @ulTaskGenericNotifyTake(i64, i64, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskGenericNotifyStateClearImpl(%struct.tskTaskControlBlock* %xTask, i64 %uxIndexToClear) #0 section "privileged_functions" !dbg !1274 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %uxIndexToClear.addr = alloca i64, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !1277, metadata !DIExpression()), !dbg !1278
  store i64 %uxIndexToClear, i64* %uxIndexToClear.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxIndexToClear.addr, metadata !1279, metadata !DIExpression()), !dbg !1280
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !1281, metadata !DIExpression()), !dbg !1282
  store i64 0, i64* %xReturn, align 8, !dbg !1282
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1283, metadata !DIExpression()), !dbg !1284
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1285, metadata !DIExpression()), !dbg !1286
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1286
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !1287
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !1289
  br i1 %cmp, label %if.then, label %if.else, !dbg !1290

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !1291
  %2 = load i64, i64* %uxIndexToClear.addr, align 8, !dbg !1293
  %call = call i64 @xTaskGenericNotifyStateClear(%struct.tskTaskControlBlock* %1, i64 %2), !dbg !1294
  store i64 %call, i64* %xReturn, align 8, !dbg !1295
  br label %if.end12, !dbg !1296

if.else:                                          ; preds = %entry
  %3 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !1297
  %4 = ptrtoint %struct.tskTaskControlBlock* %3 to i32, !dbg !1299
  store i32 %4, i32* %lIndex, align 4, !dbg !1300
  %5 = load i32, i32* %lIndex, align 4, !dbg !1301
  %cmp1 = icmp sge i32 %5, 1, !dbg !1301
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !1301

land.rhs:                                         ; preds = %if.else
  %6 = load i32, i32* %lIndex, align 4, !dbg !1301
  %cmp2 = icmp slt i32 %6, 257, !dbg !1301
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %7 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !1303
  %land.ext = zext i1 %7 to i32, !dbg !1301
  %conv = sext i32 %land.ext to i64, !dbg !1301
  %cmp3 = icmp ne i64 %conv, 0, !dbg !1304
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !1305

if.then5:                                         ; preds = %land.end
  %8 = load i32, i32* %lIndex, align 4, !dbg !1306
  %sub = sub nsw i32 %8, 1, !dbg !1306
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !1306
  %9 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !1306
  store %struct.tskTaskControlBlock* %9, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1308
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1309
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %10, null, !dbg !1311
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !1312

if.then9:                                         ; preds = %if.then5
  %11 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1313
  %12 = load i64, i64* %uxIndexToClear.addr, align 8, !dbg !1315
  %call10 = call i64 @xTaskGenericNotifyStateClear(%struct.tskTaskControlBlock* %11, i64 %12), !dbg !1316
  store i64 %call10, i64* %xReturn, align 8, !dbg !1317
  br label %if.end, !dbg !1318

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !1319

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %13 = load i64, i64* %xReturn, align 8, !dbg !1320
  ret i64 %13, !dbg !1321
}

declare dso_local i64 @xTaskGenericNotifyStateClear(%struct.tskTaskControlBlock*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MPU_ulTaskGenericNotifyValueClearImpl(%struct.tskTaskControlBlock* %xTask, i64 %uxIndexToClear, i32 %ulBitsToClear) #0 section "privileged_functions" !dbg !1322 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %uxIndexToClear.addr = alloca i64, align 8
  %ulBitsToClear.addr = alloca i32, align 4
  %ulReturn = alloca i32, align 4
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !1325, metadata !DIExpression()), !dbg !1326
  store i64 %uxIndexToClear, i64* %uxIndexToClear.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxIndexToClear.addr, metadata !1327, metadata !DIExpression()), !dbg !1328
  store i32 %ulBitsToClear, i32* %ulBitsToClear.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %ulBitsToClear.addr, metadata !1329, metadata !DIExpression()), !dbg !1330
  call void @llvm.dbg.declare(metadata i32* %ulReturn, metadata !1331, metadata !DIExpression()), !dbg !1332
  store i32 0, i32* %ulReturn, align 4, !dbg !1332
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1333, metadata !DIExpression()), !dbg !1334
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1335, metadata !DIExpression()), !dbg !1336
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1336
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !1337
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !1339
  br i1 %cmp, label %if.then, label %if.else, !dbg !1340

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !1341
  %2 = load i64, i64* %uxIndexToClear.addr, align 8, !dbg !1343
  %3 = load i32, i32* %ulBitsToClear.addr, align 4, !dbg !1344
  %call = call i32 @ulTaskGenericNotifyValueClear(%struct.tskTaskControlBlock* %1, i64 %2, i32 %3), !dbg !1345
  store i32 %call, i32* %ulReturn, align 4, !dbg !1346
  br label %if.end12, !dbg !1347

if.else:                                          ; preds = %entry
  %4 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !1348
  %5 = ptrtoint %struct.tskTaskControlBlock* %4 to i32, !dbg !1350
  store i32 %5, i32* %lIndex, align 4, !dbg !1351
  %6 = load i32, i32* %lIndex, align 4, !dbg !1352
  %cmp1 = icmp sge i32 %6, 1, !dbg !1352
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !1352

land.rhs:                                         ; preds = %if.else
  %7 = load i32, i32* %lIndex, align 4, !dbg !1352
  %cmp2 = icmp slt i32 %7, 257, !dbg !1352
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %8 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !1354
  %land.ext = zext i1 %8 to i32, !dbg !1352
  %conv = sext i32 %land.ext to i64, !dbg !1352
  %cmp3 = icmp ne i64 %conv, 0, !dbg !1355
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !1356

if.then5:                                         ; preds = %land.end
  %9 = load i32, i32* %lIndex, align 4, !dbg !1357
  %sub = sub nsw i32 %9, 1, !dbg !1357
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !1357
  %10 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !1357
  store %struct.tskTaskControlBlock* %10, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1359
  %11 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1360
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %11, null, !dbg !1362
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !1363

if.then9:                                         ; preds = %if.then5
  %12 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1364
  %13 = load i64, i64* %uxIndexToClear.addr, align 8, !dbg !1366
  %14 = load i32, i32* %ulBitsToClear.addr, align 4, !dbg !1367
  %call10 = call i32 @ulTaskGenericNotifyValueClear(%struct.tskTaskControlBlock* %12, i64 %13, i32 %14), !dbg !1368
  store i32 %call10, i32* %ulReturn, align 4, !dbg !1369
  br label %if.end, !dbg !1370

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !1371

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %15 = load i32, i32* %ulReturn, align 4, !dbg !1372
  ret i32 %15, !dbg !1373
}

declare dso_local i32 @ulTaskGenericNotifyValueClear(%struct.tskTaskControlBlock*, i64, i32) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskCreate(void (i8*)* %pvTaskCode, i8* %pcName, i16 zeroext %usStackDepth, i8* %pvParameters, i64 %uxPriority, %struct.tskTaskControlBlock** %pxCreatedTask) #0 section "privileged_functions" !dbg !1374 {
entry:
  %pvTaskCode.addr = alloca void (i8*)*, align 8
  %pcName.addr = alloca i8*, align 8
  %usStackDepth.addr = alloca i16, align 2
  %pvParameters.addr = alloca i8*, align 8
  %uxPriority.addr = alloca i64, align 8
  %pxCreatedTask.addr = alloca %struct.tskTaskControlBlock**, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store void (i8*)* %pvTaskCode, void (i8*)** %pvTaskCode.addr, align 8
  call void @llvm.dbg.declare(metadata void (i8*)** %pvTaskCode.addr, metadata !1379, metadata !DIExpression()), !dbg !1380
  store i8* %pcName, i8** %pcName.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pcName.addr, metadata !1381, metadata !DIExpression()), !dbg !1382
  store i16 %usStackDepth, i16* %usStackDepth.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %usStackDepth.addr, metadata !1383, metadata !DIExpression()), !dbg !1384
  store i8* %pvParameters, i8** %pvParameters.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvParameters.addr, metadata !1385, metadata !DIExpression()), !dbg !1386
  store i64 %uxPriority, i64* %uxPriority.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxPriority.addr, metadata !1387, metadata !DIExpression()), !dbg !1388
  store %struct.tskTaskControlBlock** %pxCreatedTask, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock*** %pxCreatedTask.addr, metadata !1389, metadata !DIExpression()), !dbg !1390
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !1391, metadata !DIExpression()), !dbg !1392
  store i64 0, i64* %xReturn, align 8, !dbg !1392
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1393, metadata !DIExpression()), !dbg !1394
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1395, metadata !DIExpression()), !dbg !1396
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1396
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !1397
  store i32 %call, i32* %lIndex, align 4, !dbg !1398
  %0 = load i32, i32* %lIndex, align 4, !dbg !1399
  %cmp = icmp ne i32 %0, -1, !dbg !1401
  br i1 %cmp, label %if.then, label %if.end11, !dbg !1402

if.then:                                          ; preds = %entry
  %1 = load i64, i64* %uxPriority.addr, align 8, !dbg !1403
  %and = and i64 %1, 0, !dbg !1406
  %cmp1 = icmp ne i64 %and, 0, !dbg !1407
  br i1 %cmp1, label %if.then2, label %if.end10, !dbg !1408

if.then2:                                         ; preds = %if.then
  %2 = load void (i8*)*, void (i8*)** %pvTaskCode.addr, align 8, !dbg !1409
  %3 = load i8*, i8** %pcName.addr, align 8, !dbg !1411
  %4 = load i16, i16* %usStackDepth.addr, align 2, !dbg !1412
  %5 = load i8*, i8** %pvParameters.addr, align 8, !dbg !1413
  %6 = load i64, i64* %uxPriority.addr, align 8, !dbg !1414
  %call3 = call i64 @xTaskCreate(void (i8*)* %2, i8* %3, i16 zeroext %4, i8* %5, i64 %6, %struct.tskTaskControlBlock** %xInternalTaskHandle), !dbg !1415
  store i64 %call3, i64* %xReturn, align 8, !dbg !1416
  %7 = load i64, i64* %xReturn, align 8, !dbg !1417
  %cmp4 = icmp eq i64 %7, 1, !dbg !1419
  br i1 %cmp4, label %land.lhs.true, label %if.else, !dbg !1420

land.lhs.true:                                    ; preds = %if.then2
  %8 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1421
  %cmp5 = icmp ne %struct.tskTaskControlBlock* %8, null, !dbg !1422
  br i1 %cmp5, label %if.then6, label %if.else, !dbg !1423

if.then6:                                         ; preds = %land.lhs.true
  %9 = load i32, i32* %lIndex, align 4, !dbg !1424
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1424
  %11 = bitcast %struct.tskTaskControlBlock* %10 to %struct.OpaqueObject*, !dbg !1424
  call void @MPU_StoreHandleAndDataAtIndex(i32 %9, %struct.OpaqueObject* %11, i8* null, i32 2), !dbg !1424
  %12 = load %struct.tskTaskControlBlock**, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8, !dbg !1426
  %cmp7 = icmp ne %struct.tskTaskControlBlock** %12, null, !dbg !1428
  br i1 %cmp7, label %if.then8, label %if.end, !dbg !1429

if.then8:                                         ; preds = %if.then6
  %13 = load i32, i32* %lIndex, align 4, !dbg !1430
  %add = add nsw i32 %13, 1, !dbg !1430
  %conv = sext i32 %add to i64, !dbg !1432
  %14 = inttoptr i64 %conv to %struct.tskTaskControlBlock*, !dbg !1432
  %15 = load %struct.tskTaskControlBlock**, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8, !dbg !1433
  store %struct.tskTaskControlBlock* %14, %struct.tskTaskControlBlock** %15, align 8, !dbg !1434
  br label %if.end, !dbg !1435

if.end:                                           ; preds = %if.then8, %if.then6
  br label %if.end9, !dbg !1436

if.else:                                          ; preds = %land.lhs.true, %if.then2
  %16 = load i32, i32* %lIndex, align 4, !dbg !1437
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %16), !dbg !1439
  br label %if.end9

if.end9:                                          ; preds = %if.else, %if.end
  br label %if.end10, !dbg !1440

if.end10:                                         ; preds = %if.end9, %if.then
  br label %if.end11, !dbg !1441

if.end11:                                         ; preds = %if.end10, %entry
  %17 = load i64, i64* %xReturn, align 8, !dbg !1442
  ret i64 %17, !dbg !1443
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @MPU_GetFreeIndexInKernelObjectPool() #0 section "privileged_functions" !dbg !1444 {
entry:
  %i = alloca i32, align 4
  %lFreeIndex = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %i, metadata !1447, metadata !DIExpression()), !dbg !1448
  call void @llvm.dbg.declare(metadata i32* %lFreeIndex, metadata !1449, metadata !DIExpression()), !dbg !1450
  store i32 -1, i32* %lFreeIndex, align 4, !dbg !1450
  call void @vTaskSuspendAll(), !dbg !1451
  store i32 0, i32* %i, align 4, !dbg !1452
  br label %for.cond, !dbg !1455

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !1456
  %cmp = icmp slt i32 %0, 256, !dbg !1458
  br i1 %cmp, label %for.body, label %for.end, !dbg !1459

for.body:                                         ; preds = %for.cond
  %1 = load i32, i32* %i, align 4, !dbg !1460
  %idxprom = sext i32 %1 to i64, !dbg !1463
  %arrayidx = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom, !dbg !1463
  %xInternalObjectHandle = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx, i32 0, i32 0, !dbg !1464
  %2 = load %struct.OpaqueObject*, %struct.OpaqueObject** %xInternalObjectHandle, align 8, !dbg !1464
  %cmp1 = icmp eq %struct.OpaqueObject* %2, null, !dbg !1465
  br i1 %cmp1, label %if.then, label %if.end, !dbg !1466

if.then:                                          ; preds = %for.body
  %3 = load i32, i32* %i, align 4, !dbg !1467
  %idxprom2 = sext i32 %3 to i64, !dbg !1469
  %arrayidx3 = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom2, !dbg !1469
  %xInternalObjectHandle4 = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx3, i32 0, i32 0, !dbg !1470
  store %struct.OpaqueObject* inttoptr (i64 -1 to %struct.OpaqueObject*), %struct.OpaqueObject** %xInternalObjectHandle4, align 8, !dbg !1471
  %4 = load i32, i32* %i, align 4, !dbg !1472
  store i32 %4, i32* %lFreeIndex, align 4, !dbg !1473
  br label %for.end, !dbg !1474

if.end:                                           ; preds = %for.body
  br label %for.inc, !dbg !1475

for.inc:                                          ; preds = %if.end
  %5 = load i32, i32* %i, align 4, !dbg !1476
  %inc = add nsw i32 %5, 1, !dbg !1476
  store i32 %inc, i32* %i, align 4, !dbg !1476
  br label %for.cond, !dbg !1477, !llvm.loop !1478

for.end:                                          ; preds = %if.then, %for.cond
  %call = call i64 @xTaskResumeAll(), !dbg !1480
  %6 = load i32, i32* %lFreeIndex, align 4, !dbg !1481
  ret i32 %6, !dbg !1482
}

declare dso_local i64 @xTaskCreate(void (i8*)*, i8*, i16 zeroext, i8*, i64, %struct.tskTaskControlBlock**) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define internal void @MPU_StoreHandleAndDataAtIndex(i32 %lIndex, %struct.OpaqueObject* %xHandle, i8* %pvKernelObjectData, i32 %ulKernelObjectType) #0 section "privileged_functions" !dbg !1483 {
entry:
  %lIndex.addr = alloca i32, align 4
  %xHandle.addr = alloca %struct.OpaqueObject*, align 8
  %pvKernelObjectData.addr = alloca i8*, align 8
  %ulKernelObjectType.addr = alloca i32, align 4
  store i32 %lIndex, i32* %lIndex.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %lIndex.addr, metadata !1486, metadata !DIExpression()), !dbg !1487
  store %struct.OpaqueObject* %xHandle, %struct.OpaqueObject** %xHandle.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.OpaqueObject** %xHandle.addr, metadata !1488, metadata !DIExpression()), !dbg !1489
  store i8* %pvKernelObjectData, i8** %pvKernelObjectData.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvKernelObjectData.addr, metadata !1490, metadata !DIExpression()), !dbg !1491
  store i32 %ulKernelObjectType, i32* %ulKernelObjectType.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %ulKernelObjectType.addr, metadata !1492, metadata !DIExpression()), !dbg !1493
  %0 = load i32, i32* %lIndex.addr, align 4, !dbg !1494
  %cmp = icmp sge i32 %0, 0, !dbg !1494
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !1494

land.rhs:                                         ; preds = %entry
  %1 = load i32, i32* %lIndex.addr, align 4, !dbg !1494
  %cmp1 = icmp slt i32 %1, 256, !dbg !1494
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %2 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !1496
  %land.ext = zext i1 %2 to i32, !dbg !1494
  %conv = sext i32 %land.ext to i64, !dbg !1494
  %cmp2 = icmp ne i64 %conv, 0, !dbg !1494
  %conv3 = zext i1 %cmp2 to i32, !dbg !1494
  %cmp4 = icmp eq i32 %conv3, 0, !dbg !1494
  br i1 %cmp4, label %if.then, label %if.end, !dbg !1497

if.then:                                          ; preds = %land.end
  call void @vAssertCalled(i8* getelementptr inbounds ([68 x i8], [68 x i8]* @.str, i64 0, i64 0), i64 307), !dbg !1494
  br label %if.end, !dbg !1494

if.end:                                           ; preds = %if.then, %land.end
  %3 = load %struct.OpaqueObject*, %struct.OpaqueObject** %xHandle.addr, align 8, !dbg !1498
  %4 = load i32, i32* %lIndex.addr, align 4, !dbg !1499
  %idxprom = sext i32 %4 to i64, !dbg !1500
  %arrayidx = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom, !dbg !1500
  %xInternalObjectHandle = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx, i32 0, i32 0, !dbg !1501
  store %struct.OpaqueObject* %3, %struct.OpaqueObject** %xInternalObjectHandle, align 8, !dbg !1502
  %5 = load i32, i32* %ulKernelObjectType.addr, align 4, !dbg !1503
  %6 = load i32, i32* %lIndex.addr, align 4, !dbg !1504
  %idxprom6 = sext i32 %6 to i64, !dbg !1505
  %arrayidx7 = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom6, !dbg !1505
  %ulKernelObjectType8 = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx7, i32 0, i32 1, !dbg !1506
  store i32 %5, i32* %ulKernelObjectType8, align 8, !dbg !1507
  %7 = load i8*, i8** %pvKernelObjectData.addr, align 8, !dbg !1508
  %8 = load i32, i32* %lIndex.addr, align 4, !dbg !1509
  %idxprom9 = sext i32 %8 to i64, !dbg !1510
  %arrayidx10 = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom9, !dbg !1510
  %pvKernelObjectData11 = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx10, i32 0, i32 2, !dbg !1511
  store i8* %7, i8** %pvKernelObjectData11, align 8, !dbg !1512
  ret void, !dbg !1513
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @MPU_SetIndexFreeInKernelObjectPool(i32 %lIndex) #0 section "privileged_functions" !dbg !1514 {
entry:
  %lIndex.addr = alloca i32, align 4
  store i32 %lIndex, i32* %lIndex.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %lIndex.addr, metadata !1517, metadata !DIExpression()), !dbg !1518
  %0 = load i32, i32* %lIndex.addr, align 4, !dbg !1519
  %cmp = icmp sge i32 %0, 0, !dbg !1519
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !1519

land.rhs:                                         ; preds = %entry
  %1 = load i32, i32* %lIndex.addr, align 4, !dbg !1519
  %cmp1 = icmp slt i32 %1, 256, !dbg !1519
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %2 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !1521
  %land.ext = zext i1 %2 to i32, !dbg !1519
  %conv = sext i32 %land.ext to i64, !dbg !1519
  %cmp2 = icmp ne i64 %conv, 0, !dbg !1519
  %conv3 = zext i1 %cmp2 to i32, !dbg !1519
  %cmp4 = icmp eq i32 %conv3, 0, !dbg !1519
  br i1 %cmp4, label %if.then, label %if.end, !dbg !1522

if.then:                                          ; preds = %land.end
  call void @vAssertCalled(i8* getelementptr inbounds ([68 x i8], [68 x i8]* @.str, i64 0, i64 0), i64 269), !dbg !1519
  br label %if.end, !dbg !1519

if.end:                                           ; preds = %if.then, %land.end
  call void @vPortEnterCritical(), !dbg !1523
  %3 = load i32, i32* %lIndex.addr, align 4, !dbg !1524
  %idxprom = sext i32 %3 to i64, !dbg !1526
  %arrayidx = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom, !dbg !1526
  %xInternalObjectHandle = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx, i32 0, i32 0, !dbg !1527
  store %struct.OpaqueObject* null, %struct.OpaqueObject** %xInternalObjectHandle, align 8, !dbg !1528
  %4 = load i32, i32* %lIndex.addr, align 4, !dbg !1529
  %idxprom6 = sext i32 %4 to i64, !dbg !1530
  %arrayidx7 = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom6, !dbg !1530
  %ulKernelObjectType = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx7, i32 0, i32 1, !dbg !1531
  store i32 0, i32* %ulKernelObjectType, align 8, !dbg !1532
  %5 = load i32, i32* %lIndex.addr, align 4, !dbg !1533
  %idxprom8 = sext i32 %5 to i64, !dbg !1534
  %arrayidx9 = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom8, !dbg !1534
  %pvKernelObjectData = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx9, i32 0, i32 2, !dbg !1535
  store i8* null, i8** %pvKernelObjectData, align 8, !dbg !1536
  call void @vPortExitCritical(), !dbg !1537
  ret void, !dbg !1538
}

declare dso_local void @vTaskSuspendAll() #2 section "privileged_functions"

declare dso_local i64 @xTaskResumeAll() #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.tskTaskControlBlock* @MPU_xTaskCreateStatic(void (i8*)* %pxTaskCode, i8* %pcName, i32 %ulStackDepth, i8* %pvParameters, i64 %uxPriority, i64* %puxStackBuffer, %struct.xSTATIC_TCB* %pxTaskBuffer) #0 section "privileged_functions" !dbg !1539 {
entry:
  %pxTaskCode.addr = alloca void (i8*)*, align 8
  %pcName.addr = alloca i8*, align 8
  %ulStackDepth.addr = alloca i32, align 4
  %pvParameters.addr = alloca i8*, align 8
  %uxPriority.addr = alloca i64, align 8
  %puxStackBuffer.addr = alloca i64*, align 8
  %pxTaskBuffer.addr = alloca %struct.xSTATIC_TCB*, align 8
  %xExternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  store void (i8*)* %pxTaskCode, void (i8*)** %pxTaskCode.addr, align 8
  call void @llvm.dbg.declare(metadata void (i8*)** %pxTaskCode.addr, metadata !1602, metadata !DIExpression()), !dbg !1603
  store i8* %pcName, i8** %pcName.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pcName.addr, metadata !1604, metadata !DIExpression()), !dbg !1605
  store i32 %ulStackDepth, i32* %ulStackDepth.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %ulStackDepth.addr, metadata !1606, metadata !DIExpression()), !dbg !1607
  store i8* %pvParameters, i8** %pvParameters.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvParameters.addr, metadata !1608, metadata !DIExpression()), !dbg !1609
  store i64 %uxPriority, i64* %uxPriority.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxPriority.addr, metadata !1610, metadata !DIExpression()), !dbg !1611
  store i64* %puxStackBuffer, i64** %puxStackBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %puxStackBuffer.addr, metadata !1612, metadata !DIExpression()), !dbg !1613
  store %struct.xSTATIC_TCB* %pxTaskBuffer, %struct.xSTATIC_TCB** %pxTaskBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xSTATIC_TCB** %pxTaskBuffer.addr, metadata !1614, metadata !DIExpression()), !dbg !1615
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xExternalTaskHandle, metadata !1616, metadata !DIExpression()), !dbg !1617
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xExternalTaskHandle, align 8, !dbg !1617
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1618, metadata !DIExpression()), !dbg !1619
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1619
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1620, metadata !DIExpression()), !dbg !1621
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !1622
  store i32 %call, i32* %lIndex, align 4, !dbg !1623
  %0 = load i32, i32* %lIndex, align 4, !dbg !1624
  %cmp = icmp ne i32 %0, -1, !dbg !1626
  br i1 %cmp, label %if.then, label %if.end4, !dbg !1627

if.then:                                          ; preds = %entry
  %1 = load void (i8*)*, void (i8*)** %pxTaskCode.addr, align 8, !dbg !1628
  %2 = load i8*, i8** %pcName.addr, align 8, !dbg !1630
  %3 = load i32, i32* %ulStackDepth.addr, align 4, !dbg !1631
  %4 = load i8*, i8** %pvParameters.addr, align 8, !dbg !1632
  %5 = load i64, i64* %uxPriority.addr, align 8, !dbg !1633
  %6 = load i64*, i64** %puxStackBuffer.addr, align 8, !dbg !1634
  %7 = load %struct.xSTATIC_TCB*, %struct.xSTATIC_TCB** %pxTaskBuffer.addr, align 8, !dbg !1635
  %call1 = call %struct.tskTaskControlBlock* @xTaskCreateStatic(void (i8*)* %1, i8* %2, i32 %3, i8* %4, i64 %5, i64* %6, %struct.xSTATIC_TCB* %7), !dbg !1636
  store %struct.tskTaskControlBlock* %call1, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1637
  %8 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1638
  %cmp2 = icmp ne %struct.tskTaskControlBlock* %8, null, !dbg !1640
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !1641

if.then3:                                         ; preds = %if.then
  %9 = load i32, i32* %lIndex, align 4, !dbg !1642
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1642
  %11 = bitcast %struct.tskTaskControlBlock* %10 to %struct.OpaqueObject*, !dbg !1642
  call void @MPU_StoreHandleAndDataAtIndex(i32 %9, %struct.OpaqueObject* %11, i8* null, i32 2), !dbg !1642
  %12 = load i32, i32* %lIndex, align 4, !dbg !1644
  %add = add nsw i32 %12, 1, !dbg !1644
  %conv = sext i32 %add to i64, !dbg !1645
  %13 = inttoptr i64 %conv to %struct.tskTaskControlBlock*, !dbg !1645
  store %struct.tskTaskControlBlock* %13, %struct.tskTaskControlBlock** %xExternalTaskHandle, align 8, !dbg !1646
  br label %if.end, !dbg !1647

if.else:                                          ; preds = %if.then
  %14 = load i32, i32* %lIndex, align 4, !dbg !1648
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %14), !dbg !1650
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  br label %if.end4, !dbg !1651

if.end4:                                          ; preds = %if.end, %entry
  %15 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xExternalTaskHandle, align 8, !dbg !1652
  ret %struct.tskTaskControlBlock* %15, !dbg !1653
}

declare dso_local %struct.tskTaskControlBlock* @xTaskCreateStatic(void (i8*)*, i8*, i32, i8*, i64, i64*, %struct.xSTATIC_TCB*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTaskDelete(%struct.tskTaskControlBlock* %pxTaskToDelete) #0 section "privileged_functions" !dbg !1654 {
entry:
  %pxTaskToDelete.addr = alloca %struct.tskTaskControlBlock*, align 8
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tskTaskControlBlock* %pxTaskToDelete, %struct.tskTaskControlBlock** %pxTaskToDelete.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %pxTaskToDelete.addr, metadata !1655, metadata !DIExpression()), !dbg !1656
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1657, metadata !DIExpression()), !dbg !1658
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1658
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1659, metadata !DIExpression()), !dbg !1660
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTaskToDelete.addr, align 8, !dbg !1661
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !1663
  br i1 %cmp, label %if.then, label %if.else, !dbg !1664

if.then:                                          ; preds = %entry
  %call = call %struct.tskTaskControlBlock* @xTaskGetCurrentTaskHandle(), !dbg !1665
  store %struct.tskTaskControlBlock* %call, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1667
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1668
  %2 = bitcast %struct.tskTaskControlBlock* %1 to %struct.OpaqueObject*, !dbg !1668
  %call1 = call i32 @MPU_GetIndexForHandle(%struct.OpaqueObject* %2, i32 2), !dbg !1668
  store i32 %call1, i32* %lIndex, align 4, !dbg !1669
  %3 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1670
  call void @vTaskDelete(%struct.tskTaskControlBlock* %3), !dbg !1671
  %4 = load i32, i32* %lIndex, align 4, !dbg !1672
  %cmp2 = icmp ne i32 %4, -1, !dbg !1674
  br i1 %cmp2, label %if.then3, label %if.end, !dbg !1675

if.then3:                                         ; preds = %if.then
  %5 = load i32, i32* %lIndex, align 4, !dbg !1676
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %5), !dbg !1678
  br label %if.end, !dbg !1679

if.end:                                           ; preds = %if.then3, %if.then
  br label %if.end16, !dbg !1680

if.else:                                          ; preds = %entry
  %6 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTaskToDelete.addr, align 8, !dbg !1681
  %7 = ptrtoint %struct.tskTaskControlBlock* %6 to i32, !dbg !1683
  store i32 %7, i32* %lIndex, align 4, !dbg !1684
  %8 = load i32, i32* %lIndex, align 4, !dbg !1685
  %cmp4 = icmp sge i32 %8, 1, !dbg !1685
  br i1 %cmp4, label %land.rhs, label %land.end, !dbg !1685

land.rhs:                                         ; preds = %if.else
  %9 = load i32, i32* %lIndex, align 4, !dbg !1685
  %cmp5 = icmp slt i32 %9, 257, !dbg !1685
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %10 = phi i1 [ false, %if.else ], [ %cmp5, %land.rhs ], !dbg !1687
  %land.ext = zext i1 %10 to i32, !dbg !1685
  %conv = sext i32 %land.ext to i64, !dbg !1685
  %cmp6 = icmp ne i64 %conv, 0, !dbg !1688
  br i1 %cmp6, label %if.then8, label %if.end15, !dbg !1689

if.then8:                                         ; preds = %land.end
  %11 = load i32, i32* %lIndex, align 4, !dbg !1690
  %sub = sub nsw i32 %11, 1, !dbg !1690
  %call9 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !1690
  %12 = bitcast %struct.OpaqueObject* %call9 to %struct.tskTaskControlBlock*, !dbg !1690
  store %struct.tskTaskControlBlock* %12, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1692
  %13 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1693
  %cmp10 = icmp ne %struct.tskTaskControlBlock* %13, null, !dbg !1695
  br i1 %cmp10, label %if.then12, label %if.end14, !dbg !1696

if.then12:                                        ; preds = %if.then8
  %14 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1697
  call void @vTaskDelete(%struct.tskTaskControlBlock* %14), !dbg !1699
  %15 = load i32, i32* %lIndex, align 4, !dbg !1700
  %sub13 = sub nsw i32 %15, 1, !dbg !1700
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %sub13), !dbg !1701
  br label %if.end14, !dbg !1702

if.end14:                                         ; preds = %if.then12, %if.then8
  br label %if.end15, !dbg !1703

if.end15:                                         ; preds = %if.end14, %land.end
  br label %if.end16

if.end16:                                         ; preds = %if.end15, %if.end
  ret void, !dbg !1704
}

declare dso_local void @vTaskDelete(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTaskPrioritySet(%struct.tskTaskControlBlock* %pxTask, i64 %uxNewPriority) #0 section "privileged_functions" !dbg !1705 {
entry:
  %pxTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %uxNewPriority.addr = alloca i64, align 8
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tskTaskControlBlock* %pxTask, %struct.tskTaskControlBlock** %pxTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %pxTask.addr, metadata !1708, metadata !DIExpression()), !dbg !1709
  store i64 %uxNewPriority, i64* %uxNewPriority.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxNewPriority.addr, metadata !1710, metadata !DIExpression()), !dbg !1711
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1712, metadata !DIExpression()), !dbg !1713
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1713
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1714, metadata !DIExpression()), !dbg !1715
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTask.addr, align 8, !dbg !1716
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !1718
  br i1 %cmp, label %if.then, label %if.else, !dbg !1719

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTask.addr, align 8, !dbg !1720
  %2 = load i64, i64* %uxNewPriority.addr, align 8, !dbg !1722
  call void @vTaskPrioritySet(%struct.tskTaskControlBlock* %1, i64 %2), !dbg !1723
  br label %if.end10, !dbg !1724

if.else:                                          ; preds = %entry
  %3 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTask.addr, align 8, !dbg !1725
  %4 = ptrtoint %struct.tskTaskControlBlock* %3 to i32, !dbg !1727
  store i32 %4, i32* %lIndex, align 4, !dbg !1728
  %5 = load i32, i32* %lIndex, align 4, !dbg !1729
  %cmp1 = icmp sge i32 %5, 1, !dbg !1729
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !1729

land.rhs:                                         ; preds = %if.else
  %6 = load i32, i32* %lIndex, align 4, !dbg !1729
  %cmp2 = icmp slt i32 %6, 257, !dbg !1729
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %7 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !1731
  %land.ext = zext i1 %7 to i32, !dbg !1729
  %conv = sext i32 %land.ext to i64, !dbg !1729
  %cmp3 = icmp ne i64 %conv, 0, !dbg !1732
  br i1 %cmp3, label %if.then5, label %if.end9, !dbg !1733

if.then5:                                         ; preds = %land.end
  %8 = load i32, i32* %lIndex, align 4, !dbg !1734
  %sub = sub nsw i32 %8, 1, !dbg !1734
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !1734
  %9 = bitcast %struct.OpaqueObject* %call to %struct.tskTaskControlBlock*, !dbg !1734
  store %struct.tskTaskControlBlock* %9, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1736
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1737
  %cmp6 = icmp ne %struct.tskTaskControlBlock* %10, null, !dbg !1739
  br i1 %cmp6, label %if.then8, label %if.end, !dbg !1740

if.then8:                                         ; preds = %if.then5
  %11 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1741
  %12 = load i64, i64* %uxNewPriority.addr, align 8, !dbg !1743
  call void @vTaskPrioritySet(%struct.tskTaskControlBlock* %11, i64 %12), !dbg !1744
  br label %if.end, !dbg !1745

if.end:                                           ; preds = %if.then8, %if.then5
  br label %if.end9, !dbg !1746

if.end9:                                          ; preds = %if.end, %land.end
  br label %if.end10

if.end10:                                         ; preds = %if.end9, %if.then
  ret void, !dbg !1747
}

declare dso_local void @vTaskPrioritySet(%struct.tskTaskControlBlock*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.tskTaskControlBlock* @MPU_xTaskGetHandle(i8* %pcNameToQuery) #0 section "privileged_functions" !dbg !1748 {
entry:
  %pcNameToQuery.addr = alloca i8*, align 8
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %xExternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  store i8* %pcNameToQuery, i8** %pcNameToQuery.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pcNameToQuery.addr, metadata !1751, metadata !DIExpression()), !dbg !1752
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1753, metadata !DIExpression()), !dbg !1754
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1754
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xExternalTaskHandle, metadata !1755, metadata !DIExpression()), !dbg !1756
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xExternalTaskHandle, align 8, !dbg !1756
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1757, metadata !DIExpression()), !dbg !1758
  %0 = load i8*, i8** %pcNameToQuery.addr, align 8, !dbg !1759
  %call = call %struct.tskTaskControlBlock* @xTaskGetHandle(i8* %0), !dbg !1760
  store %struct.tskTaskControlBlock* %call, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1761
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1762
  %cmp = icmp ne %struct.tskTaskControlBlock* %1, null, !dbg !1764
  br i1 %cmp, label %if.then, label %if.end4, !dbg !1765

if.then:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1766
  %3 = bitcast %struct.tskTaskControlBlock* %2 to %struct.OpaqueObject*, !dbg !1766
  %call1 = call i32 @MPU_GetIndexForHandle(%struct.OpaqueObject* %3, i32 2), !dbg !1766
  store i32 %call1, i32* %lIndex, align 4, !dbg !1768
  %4 = load i32, i32* %lIndex, align 4, !dbg !1769
  %cmp2 = icmp ne i32 %4, -1, !dbg !1771
  br i1 %cmp2, label %if.then3, label %if.end, !dbg !1772

if.then3:                                         ; preds = %if.then
  %5 = load i32, i32* %lIndex, align 4, !dbg !1773
  %add = add nsw i32 %5, 1, !dbg !1773
  %conv = sext i32 %add to i64, !dbg !1775
  %6 = inttoptr i64 %conv to %struct.tskTaskControlBlock*, !dbg !1775
  store %struct.tskTaskControlBlock* %6, %struct.tskTaskControlBlock** %xExternalTaskHandle, align 8, !dbg !1776
  br label %if.end, !dbg !1777

if.end:                                           ; preds = %if.then3, %if.then
  br label %if.end4, !dbg !1778

if.end4:                                          ; preds = %if.end, %entry
  %7 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xExternalTaskHandle, align 8, !dbg !1779
  ret %struct.tskTaskControlBlock* %7, !dbg !1780
}

declare dso_local %struct.tskTaskControlBlock* @xTaskGetHandle(i8*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskCallApplicationTaskHook(%struct.tskTaskControlBlock* %xTask, i8* %pvParameter) #0 section "privileged_functions" !dbg !1781 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %pvParameter.addr = alloca i8*, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !1784, metadata !DIExpression()), !dbg !1785
  store i8* %pvParameter, i8** %pvParameter.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvParameter.addr, metadata !1786, metadata !DIExpression()), !dbg !1787
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !1788, metadata !DIExpression()), !dbg !1789
  store i64 0, i64* %xReturn, align 8, !dbg !1789
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1790, metadata !DIExpression()), !dbg !1791
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1792, metadata !DIExpression()), !dbg !1793
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1793
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !1794
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !1796
  br i1 %cmp, label %if.then, label %if.else, !dbg !1797

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !1798
  %2 = load i8*, i8** %pvParameter.addr, align 8, !dbg !1800
  %call = call i64 @xTaskCallApplicationTaskHook(%struct.tskTaskControlBlock* %1, i8* %2), !dbg !1801
  store i64 %call, i64* %xReturn, align 8, !dbg !1802
  br label %if.end12, !dbg !1803

if.else:                                          ; preds = %entry
  %3 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !1804
  %4 = ptrtoint %struct.tskTaskControlBlock* %3 to i32, !dbg !1806
  store i32 %4, i32* %lIndex, align 4, !dbg !1807
  %5 = load i32, i32* %lIndex, align 4, !dbg !1808
  %cmp1 = icmp sge i32 %5, 1, !dbg !1808
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !1808

land.rhs:                                         ; preds = %if.else
  %6 = load i32, i32* %lIndex, align 4, !dbg !1808
  %cmp2 = icmp slt i32 %6, 257, !dbg !1808
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %7 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !1810
  %land.ext = zext i1 %7 to i32, !dbg !1808
  %conv = sext i32 %land.ext to i64, !dbg !1808
  %cmp3 = icmp ne i64 %conv, 0, !dbg !1811
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !1812

if.then5:                                         ; preds = %land.end
  %8 = load i32, i32* %lIndex, align 4, !dbg !1813
  %sub = sub nsw i32 %8, 1, !dbg !1813
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !1813
  %9 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !1813
  store %struct.tskTaskControlBlock* %9, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1815
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1816
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %10, null, !dbg !1818
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !1819

if.then9:                                         ; preds = %if.then5
  %11 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1820
  %12 = load i8*, i8** %pvParameter.addr, align 8, !dbg !1822
  %call10 = call i64 @xTaskCallApplicationTaskHook(%struct.tskTaskControlBlock* %11, i8* %12), !dbg !1823
  store i64 %call10, i64* %xReturn, align 8, !dbg !1824
  br label %if.end, !dbg !1825

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !1826

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %13 = load i64, i64* %xReturn, align 8, !dbg !1827
  ret i64 %13, !dbg !1828
}

declare dso_local i64 @xTaskCallApplicationTaskHook(%struct.tskTaskControlBlock*, i8*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskCreateRestricted(%struct.xTASK_PARAMETERS* %pxTaskDefinition, %struct.tskTaskControlBlock** %pxCreatedTask) #0 section "privileged_functions" !dbg !1829 {
entry:
  %pxTaskDefinition.addr = alloca %struct.xTASK_PARAMETERS*, align 8
  %pxCreatedTask.addr = alloca %struct.tskTaskControlBlock**, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.xTASK_PARAMETERS* %pxTaskDefinition, %struct.xTASK_PARAMETERS** %pxTaskDefinition.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xTASK_PARAMETERS** %pxTaskDefinition.addr, metadata !1855, metadata !DIExpression()), !dbg !1856
  store %struct.tskTaskControlBlock** %pxCreatedTask, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock*** %pxCreatedTask.addr, metadata !1857, metadata !DIExpression()), !dbg !1858
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !1859, metadata !DIExpression()), !dbg !1860
  store i64 0, i64* %xReturn, align 8, !dbg !1860
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1861, metadata !DIExpression()), !dbg !1862
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1863, metadata !DIExpression()), !dbg !1864
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1864
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !1865
  store i32 %call, i32* %lIndex, align 4, !dbg !1866
  %0 = load i32, i32* %lIndex, align 4, !dbg !1867
  %cmp = icmp ne i32 %0, -1, !dbg !1869
  br i1 %cmp, label %if.then, label %if.end8, !dbg !1870

if.then:                                          ; preds = %entry
  %1 = load %struct.xTASK_PARAMETERS*, %struct.xTASK_PARAMETERS** %pxTaskDefinition.addr, align 8, !dbg !1871
  %call1 = call i64 @xTaskCreateRestricted(%struct.xTASK_PARAMETERS* %1, %struct.tskTaskControlBlock** %xInternalTaskHandle), !dbg !1873
  store i64 %call1, i64* %xReturn, align 8, !dbg !1874
  %2 = load i64, i64* %xReturn, align 8, !dbg !1875
  %cmp2 = icmp eq i64 %2, 1, !dbg !1877
  br i1 %cmp2, label %land.lhs.true, label %if.else, !dbg !1878

land.lhs.true:                                    ; preds = %if.then
  %3 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1879
  %cmp3 = icmp ne %struct.tskTaskControlBlock* %3, null, !dbg !1880
  br i1 %cmp3, label %if.then4, label %if.else, !dbg !1881

if.then4:                                         ; preds = %land.lhs.true
  %4 = load i32, i32* %lIndex, align 4, !dbg !1882
  %5 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1882
  %6 = bitcast %struct.tskTaskControlBlock* %5 to %struct.OpaqueObject*, !dbg !1882
  call void @MPU_StoreHandleAndDataAtIndex(i32 %4, %struct.OpaqueObject* %6, i8* null, i32 2), !dbg !1882
  %7 = load %struct.tskTaskControlBlock**, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8, !dbg !1884
  %cmp5 = icmp ne %struct.tskTaskControlBlock** %7, null, !dbg !1886
  br i1 %cmp5, label %if.then6, label %if.end, !dbg !1887

if.then6:                                         ; preds = %if.then4
  %8 = load i32, i32* %lIndex, align 4, !dbg !1888
  %add = add nsw i32 %8, 1, !dbg !1888
  %conv = sext i32 %add to i64, !dbg !1890
  %9 = inttoptr i64 %conv to %struct.tskTaskControlBlock*, !dbg !1890
  %10 = load %struct.tskTaskControlBlock**, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8, !dbg !1891
  store %struct.tskTaskControlBlock* %9, %struct.tskTaskControlBlock** %10, align 8, !dbg !1892
  br label %if.end, !dbg !1893

if.end:                                           ; preds = %if.then6, %if.then4
  br label %if.end7, !dbg !1894

if.else:                                          ; preds = %land.lhs.true, %if.then
  %11 = load i32, i32* %lIndex, align 4, !dbg !1895
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %11), !dbg !1897
  br label %if.end7

if.end7:                                          ; preds = %if.else, %if.end
  br label %if.end8, !dbg !1898

if.end8:                                          ; preds = %if.end7, %entry
  %12 = load i64, i64* %xReturn, align 8, !dbg !1899
  ret i64 %12, !dbg !1900
}

declare dso_local i64 @xTaskCreateRestricted(%struct.xTASK_PARAMETERS*, %struct.tskTaskControlBlock**) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskCreateRestrictedStatic(%struct.xTASK_PARAMETERS* %pxTaskDefinition, %struct.tskTaskControlBlock** %pxCreatedTask) #0 section "privileged_functions" !dbg !1901 {
entry:
  %pxTaskDefinition.addr = alloca %struct.xTASK_PARAMETERS*, align 8
  %pxCreatedTask.addr = alloca %struct.tskTaskControlBlock**, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.xTASK_PARAMETERS* %pxTaskDefinition, %struct.xTASK_PARAMETERS** %pxTaskDefinition.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xTASK_PARAMETERS** %pxTaskDefinition.addr, metadata !1902, metadata !DIExpression()), !dbg !1903
  store %struct.tskTaskControlBlock** %pxCreatedTask, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock*** %pxCreatedTask.addr, metadata !1904, metadata !DIExpression()), !dbg !1905
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !1906, metadata !DIExpression()), !dbg !1907
  store i64 0, i64* %xReturn, align 8, !dbg !1907
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1908, metadata !DIExpression()), !dbg !1909
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1910, metadata !DIExpression()), !dbg !1911
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1911
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !1912
  store i32 %call, i32* %lIndex, align 4, !dbg !1913
  %0 = load i32, i32* %lIndex, align 4, !dbg !1914
  %cmp = icmp ne i32 %0, -1, !dbg !1916
  br i1 %cmp, label %if.then, label %if.end8, !dbg !1917

if.then:                                          ; preds = %entry
  %1 = load %struct.xTASK_PARAMETERS*, %struct.xTASK_PARAMETERS** %pxTaskDefinition.addr, align 8, !dbg !1918
  %call1 = call i64 @xTaskCreateRestrictedStatic(%struct.xTASK_PARAMETERS* %1, %struct.tskTaskControlBlock** %xInternalTaskHandle), !dbg !1920
  store i64 %call1, i64* %xReturn, align 8, !dbg !1921
  %2 = load i64, i64* %xReturn, align 8, !dbg !1922
  %cmp2 = icmp eq i64 %2, 1, !dbg !1924
  br i1 %cmp2, label %land.lhs.true, label %if.else, !dbg !1925

land.lhs.true:                                    ; preds = %if.then
  %3 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1926
  %cmp3 = icmp ne %struct.tskTaskControlBlock* %3, null, !dbg !1927
  br i1 %cmp3, label %if.then4, label %if.else, !dbg !1928

if.then4:                                         ; preds = %land.lhs.true
  %4 = load i32, i32* %lIndex, align 4, !dbg !1929
  %5 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1929
  %6 = bitcast %struct.tskTaskControlBlock* %5 to %struct.OpaqueObject*, !dbg !1929
  call void @MPU_StoreHandleAndDataAtIndex(i32 %4, %struct.OpaqueObject* %6, i8* null, i32 2), !dbg !1929
  %7 = load %struct.tskTaskControlBlock**, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8, !dbg !1931
  %cmp5 = icmp ne %struct.tskTaskControlBlock** %7, null, !dbg !1933
  br i1 %cmp5, label %if.then6, label %if.end, !dbg !1934

if.then6:                                         ; preds = %if.then4
  %8 = load i32, i32* %lIndex, align 4, !dbg !1935
  %add = add nsw i32 %8, 1, !dbg !1935
  %conv = sext i32 %add to i64, !dbg !1937
  %9 = inttoptr i64 %conv to %struct.tskTaskControlBlock*, !dbg !1937
  %10 = load %struct.tskTaskControlBlock**, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8, !dbg !1938
  store %struct.tskTaskControlBlock* %9, %struct.tskTaskControlBlock** %10, align 8, !dbg !1939
  br label %if.end, !dbg !1940

if.end:                                           ; preds = %if.then6, %if.then4
  br label %if.end7, !dbg !1941

if.else:                                          ; preds = %land.lhs.true, %if.then
  %11 = load i32, i32* %lIndex, align 4, !dbg !1942
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %11), !dbg !1944
  br label %if.end7

if.end7:                                          ; preds = %if.else, %if.end
  br label %if.end8, !dbg !1945

if.end8:                                          ; preds = %if.end7, %entry
  %12 = load i64, i64* %xReturn, align 8, !dbg !1946
  ret i64 %12, !dbg !1947
}

declare dso_local i64 @xTaskCreateRestrictedStatic(%struct.xTASK_PARAMETERS*, %struct.tskTaskControlBlock**) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTaskAllocateMPURegions(%struct.tskTaskControlBlock* %xTaskToModify, %struct.xMEMORY_REGION* %xRegions) #0 !dbg !1948 {
entry:
  %xTaskToModify.addr = alloca %struct.tskTaskControlBlock*, align 8
  %xRegions.addr = alloca %struct.xMEMORY_REGION*, align 8
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tskTaskControlBlock* %xTaskToModify, %struct.tskTaskControlBlock** %xTaskToModify.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTaskToModify.addr, metadata !1954, metadata !DIExpression()), !dbg !1955
  store %struct.xMEMORY_REGION* %xRegions, %struct.xMEMORY_REGION** %xRegions.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xMEMORY_REGION** %xRegions.addr, metadata !1956, metadata !DIExpression()), !dbg !1957
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1958, metadata !DIExpression()), !dbg !1959
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1959
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1960, metadata !DIExpression()), !dbg !1961
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToModify.addr, align 8, !dbg !1962
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !1964
  br i1 %cmp, label %if.then, label %if.else, !dbg !1965

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToModify.addr, align 8, !dbg !1966
  %2 = load %struct.xMEMORY_REGION*, %struct.xMEMORY_REGION** %xRegions.addr, align 8, !dbg !1968
  call void @vTaskAllocateMPURegions(%struct.tskTaskControlBlock* %1, %struct.xMEMORY_REGION* %2), !dbg !1969
  br label %if.end10, !dbg !1970

if.else:                                          ; preds = %entry
  %3 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToModify.addr, align 8, !dbg !1971
  %4 = ptrtoint %struct.tskTaskControlBlock* %3 to i32, !dbg !1973
  store i32 %4, i32* %lIndex, align 4, !dbg !1974
  %5 = load i32, i32* %lIndex, align 4, !dbg !1975
  %cmp1 = icmp sge i32 %5, 1, !dbg !1975
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !1975

land.rhs:                                         ; preds = %if.else
  %6 = load i32, i32* %lIndex, align 4, !dbg !1975
  %cmp2 = icmp slt i32 %6, 257, !dbg !1975
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %7 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !1977
  %land.ext = zext i1 %7 to i32, !dbg !1975
  %conv = sext i32 %land.ext to i64, !dbg !1975
  %cmp3 = icmp ne i64 %conv, 0, !dbg !1978
  br i1 %cmp3, label %if.then5, label %if.end9, !dbg !1979

if.then5:                                         ; preds = %land.end
  %8 = load i32, i32* %lIndex, align 4, !dbg !1980
  %sub = sub nsw i32 %8, 1, !dbg !1980
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !1980
  %9 = bitcast %struct.OpaqueObject* %call to %struct.tskTaskControlBlock*, !dbg !1980
  store %struct.tskTaskControlBlock* %9, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1982
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1983
  %cmp6 = icmp ne %struct.tskTaskControlBlock* %10, null, !dbg !1985
  br i1 %cmp6, label %if.then8, label %if.end, !dbg !1986

if.then8:                                         ; preds = %if.then5
  %11 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1987
  %12 = load %struct.xMEMORY_REGION*, %struct.xMEMORY_REGION** %xRegions.addr, align 8, !dbg !1989
  call void @vTaskAllocateMPURegions(%struct.tskTaskControlBlock* %11, %struct.xMEMORY_REGION* %12), !dbg !1990
  br label %if.end, !dbg !1991

if.end:                                           ; preds = %if.then8, %if.then5
  br label %if.end9, !dbg !1992

if.end9:                                          ; preds = %if.end, %land.end
  br label %if.end10

if.end10:                                         ; preds = %if.end9, %if.then
  ret void, !dbg !1993
}

declare dso_local void @vTaskAllocateMPURegions(%struct.tskTaskControlBlock*, %struct.xMEMORY_REGION*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskGetStaticBuffers(%struct.tskTaskControlBlock* %xTask, i64** %ppuxStackBuffer, %struct.xSTATIC_TCB** %ppxTaskBuffer) #0 section "privileged_functions" !dbg !1994 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %ppuxStackBuffer.addr = alloca i64**, align 8
  %ppxTaskBuffer.addr = alloca %struct.xSTATIC_TCB**, align 8
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  %xReturn = alloca i64, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !1998, metadata !DIExpression()), !dbg !1999
  store i64** %ppuxStackBuffer, i64*** %ppuxStackBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata i64*** %ppuxStackBuffer.addr, metadata !2000, metadata !DIExpression()), !dbg !2001
  store %struct.xSTATIC_TCB** %ppxTaskBuffer, %struct.xSTATIC_TCB*** %ppxTaskBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xSTATIC_TCB*** %ppxTaskBuffer.addr, metadata !2002, metadata !DIExpression()), !dbg !2003
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !2004, metadata !DIExpression()), !dbg !2005
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2005
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2006, metadata !DIExpression()), !dbg !2007
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !2008, metadata !DIExpression()), !dbg !2009
  store i64 0, i64* %xReturn, align 8, !dbg !2009
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !2010
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !2012
  br i1 %cmp, label %if.then, label %if.else, !dbg !2013

if.then:                                          ; preds = %entry
  %call = call %struct.tskTaskControlBlock* @xTaskGetCurrentTaskHandle(), !dbg !2014
  store %struct.tskTaskControlBlock* %call, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2016
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2017
  %2 = load i64**, i64*** %ppuxStackBuffer.addr, align 8, !dbg !2018
  %3 = load %struct.xSTATIC_TCB**, %struct.xSTATIC_TCB*** %ppxTaskBuffer.addr, align 8, !dbg !2019
  %call1 = call i64 @xTaskGetStaticBuffers(%struct.tskTaskControlBlock* %1, i64** %2, %struct.xSTATIC_TCB** %3), !dbg !2020
  store i64 %call1, i64* %xReturn, align 8, !dbg !2021
  br label %if.end13, !dbg !2022

if.else:                                          ; preds = %entry
  %4 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !2023
  %5 = ptrtoint %struct.tskTaskControlBlock* %4 to i32, !dbg !2025
  store i32 %5, i32* %lIndex, align 4, !dbg !2026
  %6 = load i32, i32* %lIndex, align 4, !dbg !2027
  %cmp2 = icmp sge i32 %6, 1, !dbg !2027
  br i1 %cmp2, label %land.rhs, label %land.end, !dbg !2027

land.rhs:                                         ; preds = %if.else
  %7 = load i32, i32* %lIndex, align 4, !dbg !2027
  %cmp3 = icmp slt i32 %7, 257, !dbg !2027
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %8 = phi i1 [ false, %if.else ], [ %cmp3, %land.rhs ], !dbg !2029
  %land.ext = zext i1 %8 to i32, !dbg !2027
  %conv = sext i32 %land.ext to i64, !dbg !2027
  %cmp4 = icmp ne i64 %conv, 0, !dbg !2030
  br i1 %cmp4, label %if.then6, label %if.end12, !dbg !2031

if.then6:                                         ; preds = %land.end
  %9 = load i32, i32* %lIndex, align 4, !dbg !2032
  %sub = sub nsw i32 %9, 1, !dbg !2032
  %call7 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !2032
  %10 = bitcast %struct.OpaqueObject* %call7 to %struct.tskTaskControlBlock*, !dbg !2032
  store %struct.tskTaskControlBlock* %10, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2034
  %11 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2035
  %cmp8 = icmp ne %struct.tskTaskControlBlock* %11, null, !dbg !2037
  br i1 %cmp8, label %if.then10, label %if.end, !dbg !2038

if.then10:                                        ; preds = %if.then6
  %12 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2039
  %13 = load i64**, i64*** %ppuxStackBuffer.addr, align 8, !dbg !2041
  %14 = load %struct.xSTATIC_TCB**, %struct.xSTATIC_TCB*** %ppxTaskBuffer.addr, align 8, !dbg !2042
  %call11 = call i64 @xTaskGetStaticBuffers(%struct.tskTaskControlBlock* %12, i64** %13, %struct.xSTATIC_TCB** %14), !dbg !2043
  store i64 %call11, i64* %xReturn, align 8, !dbg !2044
  br label %if.end, !dbg !2045

if.end:                                           ; preds = %if.then10, %if.then6
  br label %if.end12, !dbg !2046

if.end12:                                         ; preds = %if.end, %land.end
  br label %if.end13

if.end13:                                         ; preds = %if.end12, %if.then
  %15 = load i64, i64* %xReturn, align 8, !dbg !2047
  ret i64 %15, !dbg !2048
}

declare dso_local i64 @xTaskGetStaticBuffers(%struct.tskTaskControlBlock*, i64**, %struct.xSTATIC_TCB**) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_uxTaskPriorityGetFromISR(%struct.tskTaskControlBlock* %xTask) #0 section "privileged_functions" !dbg !2049 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %uxReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !2050, metadata !DIExpression()), !dbg !2051
  call void @llvm.dbg.declare(metadata i64* %uxReturn, metadata !2052, metadata !DIExpression()), !dbg !2053
  store i64 5, i64* %uxReturn, align 8, !dbg !2053
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2054, metadata !DIExpression()), !dbg !2055
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !2056, metadata !DIExpression()), !dbg !2057
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2057
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !2058
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !2060
  br i1 %cmp, label %if.then, label %if.else, !dbg !2061

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !2062
  %call = call i64 @uxTaskPriorityGetFromISR(%struct.tskTaskControlBlock* %1), !dbg !2064
  store i64 %call, i64* %uxReturn, align 8, !dbg !2065
  br label %if.end12, !dbg !2066

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !2067
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !2069
  store i32 %3, i32* %lIndex, align 4, !dbg !2070
  %4 = load i32, i32* %lIndex, align 4, !dbg !2071
  %cmp1 = icmp sge i32 %4, 1, !dbg !2071
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !2071

land.rhs:                                         ; preds = %if.else
  %5 = load i32, i32* %lIndex, align 4, !dbg !2071
  %cmp2 = icmp slt i32 %5, 257, !dbg !2071
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %6 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !2073
  %land.ext = zext i1 %6 to i32, !dbg !2071
  %conv = sext i32 %land.ext to i64, !dbg !2071
  %cmp3 = icmp ne i64 %conv, 0, !dbg !2074
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !2075

if.then5:                                         ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !2076
  %sub = sub nsw i32 %7, 1, !dbg !2076
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !2076
  %8 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !2076
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2078
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2079
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !2081
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !2082

if.then9:                                         ; preds = %if.then5
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2083
  %call10 = call i64 @uxTaskPriorityGetFromISR(%struct.tskTaskControlBlock* %10), !dbg !2085
  store i64 %call10, i64* %uxReturn, align 8, !dbg !2086
  br label %if.end, !dbg !2087

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !2088

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %11 = load i64, i64* %uxReturn, align 8, !dbg !2089
  ret i64 %11, !dbg !2090
}

declare dso_local i64 @uxTaskPriorityGetFromISR(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskResumeFromISR(%struct.tskTaskControlBlock* %xTaskToResume) #0 section "privileged_functions" !dbg !2091 {
entry:
  %xTaskToResume.addr = alloca %struct.tskTaskControlBlock*, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTaskToResume, %struct.tskTaskControlBlock** %xTaskToResume.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTaskToResume.addr, metadata !2092, metadata !DIExpression()), !dbg !2093
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !2094, metadata !DIExpression()), !dbg !2095
  store i64 0, i64* %xReturn, align 8, !dbg !2095
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2096, metadata !DIExpression()), !dbg !2097
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !2098, metadata !DIExpression()), !dbg !2099
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2099
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToResume.addr, align 8, !dbg !2100
  %1 = ptrtoint %struct.tskTaskControlBlock* %0 to i32, !dbg !2101
  store i32 %1, i32* %lIndex, align 4, !dbg !2102
  %2 = load i32, i32* %lIndex, align 4, !dbg !2103
  %cmp = icmp sge i32 %2, 1, !dbg !2103
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2103

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2103
  %cmp1 = icmp slt i32 %3, 257, !dbg !2103
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2105
  %land.ext = zext i1 %4 to i32, !dbg !2103
  %conv = sext i32 %land.ext to i64, !dbg !2103
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2106
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !2107

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2108
  %sub = sub nsw i32 %5, 1, !dbg !2108
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !2108
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tskTaskControlBlock*, !dbg !2108
  store %struct.tskTaskControlBlock* %6, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2110
  %7 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2111
  %cmp4 = icmp ne %struct.tskTaskControlBlock* %7, null, !dbg !2113
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !2114

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2115
  %call7 = call i64 @xTaskResumeFromISR(%struct.tskTaskControlBlock* %8), !dbg !2117
  store i64 %call7, i64* %xReturn, align 8, !dbg !2118
  br label %if.end, !dbg !2119

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !2120

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !2121
  ret i64 %9, !dbg !2122
}

declare dso_local i64 @xTaskResumeFromISR(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 (i8*)* @MPU_xTaskGetApplicationTaskTagFromISR(%struct.tskTaskControlBlock* %xTask) #0 section "privileged_functions" !dbg !2123 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %xReturn = alloca i64 (i8*)*, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !2124, metadata !DIExpression()), !dbg !2125
  call void @llvm.dbg.declare(metadata i64 (i8*)** %xReturn, metadata !2126, metadata !DIExpression()), !dbg !2127
  store i64 (i8*)* null, i64 (i8*)** %xReturn, align 8, !dbg !2127
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2128, metadata !DIExpression()), !dbg !2129
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !2130, metadata !DIExpression()), !dbg !2131
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2131
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !2132
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !2134
  br i1 %cmp, label %if.then, label %if.else, !dbg !2135

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !2136
  %call = call i64 (i8*)* @xTaskGetApplicationTaskTagFromISR(%struct.tskTaskControlBlock* %1), !dbg !2138
  store i64 (i8*)* %call, i64 (i8*)** %xReturn, align 8, !dbg !2139
  br label %if.end12, !dbg !2140

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !2141
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !2143
  store i32 %3, i32* %lIndex, align 4, !dbg !2144
  %4 = load i32, i32* %lIndex, align 4, !dbg !2145
  %cmp1 = icmp sge i32 %4, 1, !dbg !2145
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !2145

land.rhs:                                         ; preds = %if.else
  %5 = load i32, i32* %lIndex, align 4, !dbg !2145
  %cmp2 = icmp slt i32 %5, 257, !dbg !2145
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %6 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !2147
  %land.ext = zext i1 %6 to i32, !dbg !2145
  %conv = sext i32 %land.ext to i64, !dbg !2145
  %cmp3 = icmp ne i64 %conv, 0, !dbg !2148
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !2149

if.then5:                                         ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !2150
  %sub = sub nsw i32 %7, 1, !dbg !2150
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !2150
  %8 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !2150
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2152
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2153
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !2155
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !2156

if.then9:                                         ; preds = %if.then5
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2157
  %call10 = call i64 (i8*)* @xTaskGetApplicationTaskTagFromISR(%struct.tskTaskControlBlock* %10), !dbg !2159
  store i64 (i8*)* %call10, i64 (i8*)** %xReturn, align 8, !dbg !2160
  br label %if.end, !dbg !2161

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !2162

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %11 = load i64 (i8*)*, i64 (i8*)** %xReturn, align 8, !dbg !2163
  ret i64 (i8*)* %11, !dbg !2164
}

declare dso_local i64 (i8*)* @xTaskGetApplicationTaskTagFromISR(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskGenericNotifyFromISR(%struct.tskTaskControlBlock* %xTaskToNotify, i64 %uxIndexToNotify, i32 %ulValue, i32 %eAction, i32* %pulPreviousNotificationValue, i64* %pxHigherPriorityTaskWoken) #0 section "privileged_functions" !dbg !2165 {
entry:
  %xTaskToNotify.addr = alloca %struct.tskTaskControlBlock*, align 8
  %uxIndexToNotify.addr = alloca i64, align 8
  %ulValue.addr = alloca i32, align 4
  %eAction.addr = alloca i32, align 4
  %pulPreviousNotificationValue.addr = alloca i32*, align 8
  %pxHigherPriorityTaskWoken.addr = alloca i64*, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTaskToNotify, %struct.tskTaskControlBlock** %xTaskToNotify.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTaskToNotify.addr, metadata !2169, metadata !DIExpression()), !dbg !2170
  store i64 %uxIndexToNotify, i64* %uxIndexToNotify.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxIndexToNotify.addr, metadata !2171, metadata !DIExpression()), !dbg !2172
  store i32 %ulValue, i32* %ulValue.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %ulValue.addr, metadata !2173, metadata !DIExpression()), !dbg !2174
  store i32 %eAction, i32* %eAction.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %eAction.addr, metadata !2175, metadata !DIExpression()), !dbg !2176
  store i32* %pulPreviousNotificationValue, i32** %pulPreviousNotificationValue.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %pulPreviousNotificationValue.addr, metadata !2177, metadata !DIExpression()), !dbg !2178
  store i64* %pxHigherPriorityTaskWoken, i64** %pxHigherPriorityTaskWoken.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxHigherPriorityTaskWoken.addr, metadata !2179, metadata !DIExpression()), !dbg !2180
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !2181, metadata !DIExpression()), !dbg !2182
  store i64 0, i64* %xReturn, align 8, !dbg !2182
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2183, metadata !DIExpression()), !dbg !2184
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !2185, metadata !DIExpression()), !dbg !2186
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2186
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToNotify.addr, align 8, !dbg !2187
  %1 = ptrtoint %struct.tskTaskControlBlock* %0 to i32, !dbg !2188
  store i32 %1, i32* %lIndex, align 4, !dbg !2189
  %2 = load i32, i32* %lIndex, align 4, !dbg !2190
  %cmp = icmp sge i32 %2, 1, !dbg !2190
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2190

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2190
  %cmp1 = icmp slt i32 %3, 257, !dbg !2190
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2192
  %land.ext = zext i1 %4 to i32, !dbg !2190
  %conv = sext i32 %land.ext to i64, !dbg !2190
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2193
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !2194

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2195
  %sub = sub nsw i32 %5, 1, !dbg !2195
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !2195
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tskTaskControlBlock*, !dbg !2195
  store %struct.tskTaskControlBlock* %6, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2197
  %7 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2198
  %cmp4 = icmp ne %struct.tskTaskControlBlock* %7, null, !dbg !2200
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !2201

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2202
  %9 = load i64, i64* %uxIndexToNotify.addr, align 8, !dbg !2204
  %10 = load i32, i32* %ulValue.addr, align 4, !dbg !2205
  %11 = load i32, i32* %eAction.addr, align 4, !dbg !2206
  %12 = load i32*, i32** %pulPreviousNotificationValue.addr, align 8, !dbg !2207
  %13 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !2208
  %call7 = call i64 @xTaskGenericNotifyFromISR(%struct.tskTaskControlBlock* %8, i64 %9, i32 %10, i32 %11, i32* %12, i64* %13), !dbg !2209
  store i64 %call7, i64* %xReturn, align 8, !dbg !2210
  br label %if.end, !dbg !2211

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !2212

if.end8:                                          ; preds = %if.end, %land.end
  %14 = load i64, i64* %xReturn, align 8, !dbg !2213
  ret i64 %14, !dbg !2214
}

declare dso_local i64 @xTaskGenericNotifyFromISR(%struct.tskTaskControlBlock*, i64, i32, i32, i32*, i64*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTaskGenericNotifyGiveFromISR(%struct.tskTaskControlBlock* %xTaskToNotify, i64 %uxIndexToNotify, i64* %pxHigherPriorityTaskWoken) #0 section "privileged_functions" !dbg !2215 {
entry:
  %xTaskToNotify.addr = alloca %struct.tskTaskControlBlock*, align 8
  %uxIndexToNotify.addr = alloca i64, align 8
  %pxHigherPriorityTaskWoken.addr = alloca i64*, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTaskToNotify, %struct.tskTaskControlBlock** %xTaskToNotify.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTaskToNotify.addr, metadata !2218, metadata !DIExpression()), !dbg !2219
  store i64 %uxIndexToNotify, i64* %uxIndexToNotify.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxIndexToNotify.addr, metadata !2220, metadata !DIExpression()), !dbg !2221
  store i64* %pxHigherPriorityTaskWoken, i64** %pxHigherPriorityTaskWoken.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxHigherPriorityTaskWoken.addr, metadata !2222, metadata !DIExpression()), !dbg !2223
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2224, metadata !DIExpression()), !dbg !2225
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !2226, metadata !DIExpression()), !dbg !2227
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2227
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToNotify.addr, align 8, !dbg !2228
  %1 = ptrtoint %struct.tskTaskControlBlock* %0 to i32, !dbg !2229
  store i32 %1, i32* %lIndex, align 4, !dbg !2230
  %2 = load i32, i32* %lIndex, align 4, !dbg !2231
  %cmp = icmp sge i32 %2, 1, !dbg !2231
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2231

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2231
  %cmp1 = icmp slt i32 %3, 257, !dbg !2231
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2233
  %land.ext = zext i1 %4 to i32, !dbg !2231
  %conv = sext i32 %land.ext to i64, !dbg !2231
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2234
  br i1 %cmp2, label %if.then, label %if.end7, !dbg !2235

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2236
  %sub = sub nsw i32 %5, 1, !dbg !2236
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !2236
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tskTaskControlBlock*, !dbg !2236
  store %struct.tskTaskControlBlock* %6, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2238
  %7 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2239
  %cmp4 = icmp ne %struct.tskTaskControlBlock* %7, null, !dbg !2241
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !2242

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2243
  %9 = load i64, i64* %uxIndexToNotify.addr, align 8, !dbg !2245
  %10 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !2246
  call void @vTaskGenericNotifyGiveFromISR(%struct.tskTaskControlBlock* %8, i64 %9, i64* %10), !dbg !2247
  br label %if.end, !dbg !2248

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end7, !dbg !2249

if.end7:                                          ; preds = %if.end, %land.end
  ret void, !dbg !2250
}

declare dso_local void @vTaskGenericNotifyGiveFromISR(%struct.tskTaskControlBlock*, i64, i64*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueGenericSendImpl(%struct.QueueDefinition* %xQueue, i8* %pvItemToQueue, i64 %xTicksToWait, i64 %xCopyPosition) #0 section "privileged_functions" !dbg !2251 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %pvItemToQueue.addr = alloca i8*, align 8
  %xTicksToWait.addr = alloca i64, align 8
  %xCopyPosition.addr = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %xReturn = alloca i64, align 8
  %xIsItemToQueueReadable = alloca i64, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !2257, metadata !DIExpression()), !dbg !2258
  store i8* %pvItemToQueue, i8** %pvItemToQueue.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvItemToQueue.addr, metadata !2259, metadata !DIExpression()), !dbg !2260
  store i64 %xTicksToWait, i64* %xTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToWait.addr, metadata !2261, metadata !DIExpression()), !dbg !2262
  store i64 %xCopyPosition, i64* %xCopyPosition.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xCopyPosition.addr, metadata !2263, metadata !DIExpression()), !dbg !2264
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2265, metadata !DIExpression()), !dbg !2266
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2267, metadata !DIExpression()), !dbg !2268
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2268
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !2269, metadata !DIExpression()), !dbg !2270
  store i64 0, i64* %xReturn, align 8, !dbg !2270
  call void @llvm.dbg.declare(metadata i64* %xIsItemToQueueReadable, metadata !2271, metadata !DIExpression()), !dbg !2272
  store i64 0, i64* %xIsItemToQueueReadable, align 8, !dbg !2272
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !2273
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2274
  store i32 %1, i32* %lIndex, align 4, !dbg !2275
  %2 = load i32, i32* %lIndex, align 4, !dbg !2276
  %cmp = icmp sge i32 %2, 1, !dbg !2276
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2276

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2276
  %cmp1 = icmp slt i32 %3, 257, !dbg !2276
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2278
  %land.ext = zext i1 %4 to i32, !dbg !2276
  %conv = sext i32 %land.ext to i64, !dbg !2276
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2279
  br i1 %cmp2, label %if.then, label %if.end21, !dbg !2280

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2281
  %sub = sub nsw i32 %5, 1, !dbg !2281
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2281
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2281
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2283
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2284
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2286
  br i1 %cmp4, label %if.then6, label %if.end20, !dbg !2287

if.then6:                                         ; preds = %if.then
  %8 = load i8*, i8** %pvItemToQueue.addr, align 8, !dbg !2288
  %cmp7 = icmp ne i8* %8, null, !dbg !2291
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !2292

if.then9:                                         ; preds = %if.then6
  %9 = load i8*, i8** %pvItemToQueue.addr, align 8, !dbg !2293
  %10 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2295
  %call10 = call i64 @uxQueueGetQueueItemSize(%struct.QueueDefinition* %10), !dbg !2296
  %conv11 = trunc i64 %call10 to i32, !dbg !2296
  %call12 = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %9, i32 %conv11, i32 1), !dbg !2297
  store i64 %call12, i64* %xIsItemToQueueReadable, align 8, !dbg !2298
  br label %if.end, !dbg !2299

if.end:                                           ; preds = %if.then9, %if.then6
  %11 = load i8*, i8** %pvItemToQueue.addr, align 8, !dbg !2300
  %cmp13 = icmp eq i8* %11, null, !dbg !2302
  br i1 %cmp13, label %if.then17, label %lor.lhs.false, !dbg !2303

lor.lhs.false:                                    ; preds = %if.end
  %12 = load i64, i64* %xIsItemToQueueReadable, align 8, !dbg !2304
  %cmp15 = icmp eq i64 %12, 1, !dbg !2305
  br i1 %cmp15, label %if.then17, label %if.end19, !dbg !2306

if.then17:                                        ; preds = %lor.lhs.false, %if.end
  %13 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2307
  %14 = load i8*, i8** %pvItemToQueue.addr, align 8, !dbg !2309
  %15 = load i64, i64* %xTicksToWait.addr, align 8, !dbg !2310
  %16 = load i64, i64* %xCopyPosition.addr, align 8, !dbg !2311
  %call18 = call i64 @xQueueGenericSend(%struct.QueueDefinition* %13, i8* %14, i64 %15, i64 %16), !dbg !2312
  store i64 %call18, i64* %xReturn, align 8, !dbg !2313
  br label %if.end19, !dbg !2314

if.end19:                                         ; preds = %if.then17, %lor.lhs.false
  br label %if.end20, !dbg !2315

if.end20:                                         ; preds = %if.end19, %if.then
  br label %if.end21, !dbg !2316

if.end21:                                         ; preds = %if.end20, %land.end
  %17 = load i64, i64* %xReturn, align 8, !dbg !2317
  ret i64 %17, !dbg !2318
}

declare dso_local i64 @uxQueueGetQueueItemSize(%struct.QueueDefinition*) #2 section "privileged_functions"

declare dso_local i64 @xQueueGenericSend(%struct.QueueDefinition*, i8*, i64, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_uxQueueMessagesWaitingImpl(%struct.QueueDefinition* %pxQueue) #0 section "privileged_functions" !dbg !2319 {
entry:
  %pxQueue.addr = alloca %struct.QueueDefinition*, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %uxReturn = alloca i64, align 8
  store %struct.QueueDefinition* %pxQueue, %struct.QueueDefinition** %pxQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %pxQueue.addr, metadata !2323, metadata !DIExpression()), !dbg !2324
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2325, metadata !DIExpression()), !dbg !2326
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2327, metadata !DIExpression()), !dbg !2328
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2328
  call void @llvm.dbg.declare(metadata i64* %uxReturn, metadata !2329, metadata !DIExpression()), !dbg !2330
  store i64 0, i64* %uxReturn, align 8, !dbg !2330
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %pxQueue.addr, align 8, !dbg !2331
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2332
  store i32 %1, i32* %lIndex, align 4, !dbg !2333
  %2 = load i32, i32* %lIndex, align 4, !dbg !2334
  %cmp = icmp sge i32 %2, 1, !dbg !2334
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2334

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2334
  %cmp1 = icmp slt i32 %3, 257, !dbg !2334
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2336
  %land.ext = zext i1 %4 to i32, !dbg !2334
  %conv = sext i32 %land.ext to i64, !dbg !2334
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2337
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !2338

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2339
  %sub = sub nsw i32 %5, 1, !dbg !2339
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2339
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2339
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2341
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2342
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2344
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !2345

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2346
  %call7 = call i64 @uxQueueMessagesWaiting(%struct.QueueDefinition* %8), !dbg !2348
  store i64 %call7, i64* %uxReturn, align 8, !dbg !2349
  br label %if.end, !dbg !2350

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !2351

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %uxReturn, align 8, !dbg !2352
  ret i64 %9, !dbg !2353
}

declare dso_local i64 @uxQueueMessagesWaiting(%struct.QueueDefinition*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_uxQueueSpacesAvailableImpl(%struct.QueueDefinition* %xQueue) #0 section "privileged_functions" !dbg !2354 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %uxReturn = alloca i64, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !2355, metadata !DIExpression()), !dbg !2356
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2357, metadata !DIExpression()), !dbg !2358
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2359, metadata !DIExpression()), !dbg !2360
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2360
  call void @llvm.dbg.declare(metadata i64* %uxReturn, metadata !2361, metadata !DIExpression()), !dbg !2362
  store i64 0, i64* %uxReturn, align 8, !dbg !2362
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !2363
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2364
  store i32 %1, i32* %lIndex, align 4, !dbg !2365
  %2 = load i32, i32* %lIndex, align 4, !dbg !2366
  %cmp = icmp sge i32 %2, 1, !dbg !2366
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2366

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2366
  %cmp1 = icmp slt i32 %3, 257, !dbg !2366
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2368
  %land.ext = zext i1 %4 to i32, !dbg !2366
  %conv = sext i32 %land.ext to i64, !dbg !2366
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2369
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !2370

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2371
  %sub = sub nsw i32 %5, 1, !dbg !2371
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2371
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2371
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2373
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2374
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2376
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !2377

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2378
  %call7 = call i64 @uxQueueSpacesAvailable(%struct.QueueDefinition* %8), !dbg !2380
  store i64 %call7, i64* %uxReturn, align 8, !dbg !2381
  br label %if.end, !dbg !2382

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !2383

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %uxReturn, align 8, !dbg !2384
  ret i64 %9, !dbg !2385
}

declare dso_local i64 @uxQueueSpacesAvailable(%struct.QueueDefinition*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueReceiveImpl(%struct.QueueDefinition* %pxQueue, i8* %pvBuffer, i64 %xTicksToWait) #0 section "privileged_functions" !dbg !2386 {
entry:
  %pxQueue.addr = alloca %struct.QueueDefinition*, align 8
  %pvBuffer.addr = alloca i8*, align 8
  %xTicksToWait.addr = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %xReturn = alloca i64, align 8
  %xIsReceiveBufferWritable = alloca i64, align 8
  store %struct.QueueDefinition* %pxQueue, %struct.QueueDefinition** %pxQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %pxQueue.addr, metadata !2389, metadata !DIExpression()), !dbg !2390
  store i8* %pvBuffer, i8** %pvBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvBuffer.addr, metadata !2391, metadata !DIExpression()), !dbg !2392
  store i64 %xTicksToWait, i64* %xTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToWait.addr, metadata !2393, metadata !DIExpression()), !dbg !2394
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2395, metadata !DIExpression()), !dbg !2396
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2397, metadata !DIExpression()), !dbg !2398
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2398
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !2399, metadata !DIExpression()), !dbg !2400
  store i64 0, i64* %xReturn, align 8, !dbg !2400
  call void @llvm.dbg.declare(metadata i64* %xIsReceiveBufferWritable, metadata !2401, metadata !DIExpression()), !dbg !2402
  store i64 0, i64* %xIsReceiveBufferWritable, align 8, !dbg !2402
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %pxQueue.addr, align 8, !dbg !2403
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2404
  store i32 %1, i32* %lIndex, align 4, !dbg !2405
  %2 = load i32, i32* %lIndex, align 4, !dbg !2406
  %cmp = icmp sge i32 %2, 1, !dbg !2406
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2406

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2406
  %cmp1 = icmp slt i32 %3, 257, !dbg !2406
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2408
  %land.ext = zext i1 %4 to i32, !dbg !2406
  %conv = sext i32 %land.ext to i64, !dbg !2406
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2409
  br i1 %cmp2, label %if.then, label %if.end15, !dbg !2410

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2411
  %sub = sub nsw i32 %5, 1, !dbg !2411
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2411
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2411
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2413
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2414
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2416
  br i1 %cmp4, label %if.then6, label %if.end14, !dbg !2417

if.then6:                                         ; preds = %if.then
  %8 = load i8*, i8** %pvBuffer.addr, align 8, !dbg !2418
  %9 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2420
  %call7 = call i64 @uxQueueGetQueueItemSize(%struct.QueueDefinition* %9), !dbg !2421
  %conv8 = trunc i64 %call7 to i32, !dbg !2421
  %call9 = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %8, i32 %conv8, i32 2), !dbg !2422
  store i64 %call9, i64* %xIsReceiveBufferWritable, align 8, !dbg !2423
  %10 = load i64, i64* %xIsReceiveBufferWritable, align 8, !dbg !2424
  %cmp10 = icmp eq i64 %10, 1, !dbg !2426
  br i1 %cmp10, label %if.then12, label %if.end, !dbg !2427

if.then12:                                        ; preds = %if.then6
  %11 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2428
  %12 = load i8*, i8** %pvBuffer.addr, align 8, !dbg !2430
  %13 = load i64, i64* %xTicksToWait.addr, align 8, !dbg !2431
  %call13 = call i64 @xQueueReceive(%struct.QueueDefinition* %11, i8* %12, i64 %13), !dbg !2432
  store i64 %call13, i64* %xReturn, align 8, !dbg !2433
  br label %if.end, !dbg !2434

if.end:                                           ; preds = %if.then12, %if.then6
  br label %if.end14, !dbg !2435

if.end14:                                         ; preds = %if.end, %if.then
  br label %if.end15, !dbg !2436

if.end15:                                         ; preds = %if.end14, %land.end
  %14 = load i64, i64* %xReturn, align 8, !dbg !2437
  ret i64 %14, !dbg !2438
}

declare dso_local i64 @xQueueReceive(%struct.QueueDefinition*, i8*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueuePeekImpl(%struct.QueueDefinition* %xQueue, i8* %pvBuffer, i64 %xTicksToWait) #0 section "privileged_functions" !dbg !2439 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %pvBuffer.addr = alloca i8*, align 8
  %xTicksToWait.addr = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %xReturn = alloca i64, align 8
  %xIsReceiveBufferWritable = alloca i64, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !2440, metadata !DIExpression()), !dbg !2441
  store i8* %pvBuffer, i8** %pvBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvBuffer.addr, metadata !2442, metadata !DIExpression()), !dbg !2443
  store i64 %xTicksToWait, i64* %xTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToWait.addr, metadata !2444, metadata !DIExpression()), !dbg !2445
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2446, metadata !DIExpression()), !dbg !2447
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2448, metadata !DIExpression()), !dbg !2449
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2449
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !2450, metadata !DIExpression()), !dbg !2451
  store i64 0, i64* %xReturn, align 8, !dbg !2451
  call void @llvm.dbg.declare(metadata i64* %xIsReceiveBufferWritable, metadata !2452, metadata !DIExpression()), !dbg !2453
  store i64 0, i64* %xIsReceiveBufferWritable, align 8, !dbg !2453
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !2454
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2455
  store i32 %1, i32* %lIndex, align 4, !dbg !2456
  %2 = load i32, i32* %lIndex, align 4, !dbg !2457
  %cmp = icmp sge i32 %2, 1, !dbg !2457
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2457

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2457
  %cmp1 = icmp slt i32 %3, 257, !dbg !2457
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2459
  %land.ext = zext i1 %4 to i32, !dbg !2457
  %conv = sext i32 %land.ext to i64, !dbg !2457
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2460
  br i1 %cmp2, label %if.then, label %if.end15, !dbg !2461

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2462
  %sub = sub nsw i32 %5, 1, !dbg !2462
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2462
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2462
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2464
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2465
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2467
  br i1 %cmp4, label %if.then6, label %if.end14, !dbg !2468

if.then6:                                         ; preds = %if.then
  %8 = load i8*, i8** %pvBuffer.addr, align 8, !dbg !2469
  %9 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2471
  %call7 = call i64 @uxQueueGetQueueItemSize(%struct.QueueDefinition* %9), !dbg !2472
  %conv8 = trunc i64 %call7 to i32, !dbg !2472
  %call9 = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %8, i32 %conv8, i32 2), !dbg !2473
  store i64 %call9, i64* %xIsReceiveBufferWritable, align 8, !dbg !2474
  %10 = load i64, i64* %xIsReceiveBufferWritable, align 8, !dbg !2475
  %cmp10 = icmp eq i64 %10, 1, !dbg !2477
  br i1 %cmp10, label %if.then12, label %if.end, !dbg !2478

if.then12:                                        ; preds = %if.then6
  %11 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2479
  %12 = load i8*, i8** %pvBuffer.addr, align 8, !dbg !2481
  %13 = load i64, i64* %xTicksToWait.addr, align 8, !dbg !2482
  %call13 = call i64 @xQueuePeek(%struct.QueueDefinition* %11, i8* %12, i64 %13), !dbg !2483
  store i64 %call13, i64* %xReturn, align 8, !dbg !2484
  br label %if.end, !dbg !2485

if.end:                                           ; preds = %if.then12, %if.then6
  br label %if.end14, !dbg !2486

if.end14:                                         ; preds = %if.end, %if.then
  br label %if.end15, !dbg !2487

if.end15:                                         ; preds = %if.end14, %land.end
  %14 = load i64, i64* %xReturn, align 8, !dbg !2488
  ret i64 %14, !dbg !2489
}

declare dso_local i64 @xQueuePeek(%struct.QueueDefinition*, i8*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueSemaphoreTakeImpl(%struct.QueueDefinition* %xQueue, i64 %xTicksToWait) #0 section "privileged_functions" !dbg !2490 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %xTicksToWait.addr = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %xReturn = alloca i64, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !2493, metadata !DIExpression()), !dbg !2494
  store i64 %xTicksToWait, i64* %xTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToWait.addr, metadata !2495, metadata !DIExpression()), !dbg !2496
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2497, metadata !DIExpression()), !dbg !2498
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2499, metadata !DIExpression()), !dbg !2500
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2500
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !2501, metadata !DIExpression()), !dbg !2502
  store i64 0, i64* %xReturn, align 8, !dbg !2502
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !2503
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2504
  store i32 %1, i32* %lIndex, align 4, !dbg !2505
  %2 = load i32, i32* %lIndex, align 4, !dbg !2506
  %cmp = icmp sge i32 %2, 1, !dbg !2506
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2506

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2506
  %cmp1 = icmp slt i32 %3, 257, !dbg !2506
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2508
  %land.ext = zext i1 %4 to i32, !dbg !2506
  %conv = sext i32 %land.ext to i64, !dbg !2506
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2509
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !2510

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2511
  %sub = sub nsw i32 %5, 1, !dbg !2511
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2511
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2511
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2513
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2514
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2516
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !2517

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2518
  %9 = load i64, i64* %xTicksToWait.addr, align 8, !dbg !2520
  %call7 = call i64 @xQueueSemaphoreTake(%struct.QueueDefinition* %8, i64 %9), !dbg !2521
  store i64 %call7, i64* %xReturn, align 8, !dbg !2522
  br label %if.end, !dbg !2523

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !2524

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !2525
  ret i64 %10, !dbg !2526
}

declare dso_local i64 @xQueueSemaphoreTake(%struct.QueueDefinition*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.QueueDefinition* @MPU_xQueueSelectFromSetImpl(%struct.QueueDefinition* %xQueueSet, i64 %xBlockTimeTicks) #0 section "privileged_functions" !dbg !2527 {
entry:
  %xQueueSet.addr = alloca %struct.QueueDefinition*, align 8
  %xBlockTimeTicks.addr = alloca i64, align 8
  %xInternalQueueSetHandle = alloca %struct.QueueDefinition*, align 8
  %xSelectedMemberInternal = alloca %struct.QueueDefinition*, align 8
  %xSelectedMemberExternal = alloca %struct.QueueDefinition*, align 8
  %lIndexQueueSet = alloca i32, align 4
  %lIndexSelectedMember = alloca i32, align 4
  store %struct.QueueDefinition* %xQueueSet, %struct.QueueDefinition** %xQueueSet.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueueSet.addr, metadata !2530, metadata !DIExpression()), !dbg !2531
  store i64 %xBlockTimeTicks, i64* %xBlockTimeTicks.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xBlockTimeTicks.addr, metadata !2532, metadata !DIExpression()), !dbg !2533
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueSetHandle, metadata !2534, metadata !DIExpression()), !dbg !2535
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !2535
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xSelectedMemberInternal, metadata !2536, metadata !DIExpression()), !dbg !2537
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xSelectedMemberInternal, align 8, !dbg !2537
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xSelectedMemberExternal, metadata !2538, metadata !DIExpression()), !dbg !2539
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xSelectedMemberExternal, align 8, !dbg !2539
  call void @llvm.dbg.declare(metadata i32* %lIndexQueueSet, metadata !2540, metadata !DIExpression()), !dbg !2541
  call void @llvm.dbg.declare(metadata i32* %lIndexSelectedMember, metadata !2542, metadata !DIExpression()), !dbg !2543
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueueSet.addr, align 8, !dbg !2544
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2545
  store i32 %1, i32* %lIndexQueueSet, align 4, !dbg !2546
  %2 = load i32, i32* %lIndexQueueSet, align 4, !dbg !2547
  %cmp = icmp sge i32 %2, 1, !dbg !2547
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2547

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndexQueueSet, align 4, !dbg !2547
  %cmp1 = icmp slt i32 %3, 257, !dbg !2547
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2549
  %land.ext = zext i1 %4 to i32, !dbg !2547
  %conv = sext i32 %land.ext to i64, !dbg !2547
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2550
  br i1 %cmp2, label %if.then, label %if.end18, !dbg !2551

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndexQueueSet, align 4, !dbg !2552
  %sub = sub nsw i32 %5, 1, !dbg !2552
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2552
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2552
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !2554
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !2555
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2557
  br i1 %cmp4, label %if.then6, label %if.end17, !dbg !2558

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !2559
  %9 = load i64, i64* %xBlockTimeTicks.addr, align 8, !dbg !2561
  %call7 = call %struct.QueueDefinition* @xQueueSelectFromSet(%struct.QueueDefinition* %8, i64 %9), !dbg !2562
  store %struct.QueueDefinition* %call7, %struct.QueueDefinition** %xSelectedMemberInternal, align 8, !dbg !2563
  %10 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xSelectedMemberInternal, align 8, !dbg !2564
  %cmp8 = icmp ne %struct.QueueDefinition* %10, null, !dbg !2566
  br i1 %cmp8, label %if.then10, label %if.end16, !dbg !2567

if.then10:                                        ; preds = %if.then6
  %11 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xSelectedMemberInternal, align 8, !dbg !2568
  %12 = bitcast %struct.QueueDefinition* %11 to %struct.OpaqueObject*, !dbg !2568
  %call11 = call i32 @MPU_GetIndexForHandle(%struct.OpaqueObject* %12, i32 1), !dbg !2568
  store i32 %call11, i32* %lIndexSelectedMember, align 4, !dbg !2570
  %13 = load i32, i32* %lIndexSelectedMember, align 4, !dbg !2571
  %cmp12 = icmp ne i32 %13, -1, !dbg !2573
  br i1 %cmp12, label %if.then14, label %if.end, !dbg !2574

if.then14:                                        ; preds = %if.then10
  %14 = load i32, i32* %lIndexSelectedMember, align 4, !dbg !2575
  %add = add nsw i32 %14, 1, !dbg !2575
  %conv15 = sext i32 %add to i64, !dbg !2577
  %15 = inttoptr i64 %conv15 to %struct.QueueDefinition*, !dbg !2577
  store %struct.QueueDefinition* %15, %struct.QueueDefinition** %xSelectedMemberExternal, align 8, !dbg !2578
  br label %if.end, !dbg !2579

if.end:                                           ; preds = %if.then14, %if.then10
  br label %if.end16, !dbg !2580

if.end16:                                         ; preds = %if.end, %if.then6
  br label %if.end17, !dbg !2581

if.end17:                                         ; preds = %if.end16, %if.then
  br label %if.end18, !dbg !2582

if.end18:                                         ; preds = %if.end17, %land.end
  %16 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xSelectedMemberExternal, align 8, !dbg !2583
  ret %struct.QueueDefinition* %16, !dbg !2584
}

declare dso_local %struct.QueueDefinition* @xQueueSelectFromSet(%struct.QueueDefinition*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueAddToSetImpl(%struct.QueueDefinition* %xQueueOrSemaphore, %struct.QueueDefinition* %xQueueSet) #0 section "privileged_functions" !dbg !2585 {
entry:
  %xQueueOrSemaphore.addr = alloca %struct.QueueDefinition*, align 8
  %xQueueSet.addr = alloca %struct.QueueDefinition*, align 8
  %xReturn = alloca i64, align 8
  %xInternalQueueSetMemberHandle = alloca %struct.QueueDefinition*, align 8
  %xInternalQueueSetHandle = alloca %struct.QueueDefinition*, align 8
  %lIndexQueueSet = alloca i32, align 4
  %lIndexQueueSetMember = alloca i32, align 4
  store %struct.QueueDefinition* %xQueueOrSemaphore, %struct.QueueDefinition** %xQueueOrSemaphore.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueueOrSemaphore.addr, metadata !2588, metadata !DIExpression()), !dbg !2589
  store %struct.QueueDefinition* %xQueueSet, %struct.QueueDefinition** %xQueueSet.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueueSet.addr, metadata !2590, metadata !DIExpression()), !dbg !2591
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !2592, metadata !DIExpression()), !dbg !2593
  store i64 0, i64* %xReturn, align 8, !dbg !2593
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueSetMemberHandle, metadata !2594, metadata !DIExpression()), !dbg !2595
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueSetMemberHandle, align 8, !dbg !2595
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueSetHandle, metadata !2596, metadata !DIExpression()), !dbg !2597
  call void @llvm.dbg.declare(metadata i32* %lIndexQueueSet, metadata !2598, metadata !DIExpression()), !dbg !2599
  call void @llvm.dbg.declare(metadata i32* %lIndexQueueSetMember, metadata !2600, metadata !DIExpression()), !dbg !2601
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueueSet.addr, align 8, !dbg !2602
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2603
  store i32 %1, i32* %lIndexQueueSet, align 4, !dbg !2604
  %2 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueueOrSemaphore.addr, align 8, !dbg !2605
  %3 = ptrtoint %struct.QueueDefinition* %2 to i32, !dbg !2606
  store i32 %3, i32* %lIndexQueueSetMember, align 4, !dbg !2607
  %4 = load i32, i32* %lIndexQueueSet, align 4, !dbg !2608
  %cmp = icmp sge i32 %4, 1, !dbg !2608
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2608

land.rhs:                                         ; preds = %entry
  %5 = load i32, i32* %lIndexQueueSet, align 4, !dbg !2608
  %cmp1 = icmp slt i32 %5, 257, !dbg !2608
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %6 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2610
  %land.ext = zext i1 %6 to i32, !dbg !2608
  %conv = sext i32 %land.ext to i64, !dbg !2608
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2611
  br i1 %cmp2, label %land.lhs.true, label %if.end23, !dbg !2612

land.lhs.true:                                    ; preds = %land.end
  %7 = load i32, i32* %lIndexQueueSetMember, align 4, !dbg !2613
  %cmp4 = icmp sge i32 %7, 1, !dbg !2613
  br i1 %cmp4, label %land.rhs6, label %land.end9, !dbg !2613

land.rhs6:                                        ; preds = %land.lhs.true
  %8 = load i32, i32* %lIndexQueueSetMember, align 4, !dbg !2613
  %cmp7 = icmp slt i32 %8, 257, !dbg !2613
  br label %land.end9

land.end9:                                        ; preds = %land.rhs6, %land.lhs.true
  %9 = phi i1 [ false, %land.lhs.true ], [ %cmp7, %land.rhs6 ], !dbg !2610
  %land.ext10 = zext i1 %9 to i32, !dbg !2613
  %conv11 = sext i32 %land.ext10 to i64, !dbg !2613
  %cmp12 = icmp ne i64 %conv11, 0, !dbg !2614
  br i1 %cmp12, label %if.then, label %if.end23, !dbg !2615

if.then:                                          ; preds = %land.end9
  %10 = load i32, i32* %lIndexQueueSet, align 4, !dbg !2616
  %sub = sub nsw i32 %10, 1, !dbg !2616
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2616
  %11 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2616
  store %struct.QueueDefinition* %11, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !2618
  %12 = load i32, i32* %lIndexQueueSetMember, align 4, !dbg !2619
  %sub14 = sub nsw i32 %12, 1, !dbg !2619
  %call15 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub14, i32 1), !dbg !2619
  %13 = bitcast %struct.OpaqueObject* %call15 to %struct.QueueDefinition*, !dbg !2619
  store %struct.QueueDefinition* %13, %struct.QueueDefinition** %xInternalQueueSetMemberHandle, align 8, !dbg !2620
  %14 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !2621
  %cmp16 = icmp ne %struct.QueueDefinition* %14, null, !dbg !2623
  br i1 %cmp16, label %land.lhs.true18, label %if.end, !dbg !2624

land.lhs.true18:                                  ; preds = %if.then
  %15 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetMemberHandle, align 8, !dbg !2625
  %cmp19 = icmp ne %struct.QueueDefinition* %15, null, !dbg !2626
  br i1 %cmp19, label %if.then21, label %if.end, !dbg !2627

if.then21:                                        ; preds = %land.lhs.true18
  %16 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetMemberHandle, align 8, !dbg !2628
  %17 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !2630
  %call22 = call i64 @xQueueAddToSet(%struct.QueueDefinition* %16, %struct.QueueDefinition* %17), !dbg !2631
  store i64 %call22, i64* %xReturn, align 8, !dbg !2632
  br label %if.end, !dbg !2633

if.end:                                           ; preds = %if.then21, %land.lhs.true18, %if.then
  br label %if.end23, !dbg !2634

if.end23:                                         ; preds = %if.end, %land.end9, %land.end
  %18 = load i64, i64* %xReturn, align 8, !dbg !2635
  ret i64 %18, !dbg !2636
}

declare dso_local i64 @xQueueAddToSet(%struct.QueueDefinition*, %struct.QueueDefinition*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vQueueAddToRegistryImpl(%struct.QueueDefinition* %xQueue, i8* %pcName) #0 section "privileged_functions" !dbg !2637 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %pcName.addr = alloca i8*, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !2640, metadata !DIExpression()), !dbg !2641
  store i8* %pcName, i8** %pcName.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pcName.addr, metadata !2642, metadata !DIExpression()), !dbg !2643
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2644, metadata !DIExpression()), !dbg !2645
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2646, metadata !DIExpression()), !dbg !2647
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2647
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !2648
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2649
  store i32 %1, i32* %lIndex, align 4, !dbg !2650
  %2 = load i32, i32* %lIndex, align 4, !dbg !2651
  %cmp = icmp sge i32 %2, 1, !dbg !2651
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2651

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2651
  %cmp1 = icmp slt i32 %3, 257, !dbg !2651
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2653
  %land.ext = zext i1 %4 to i32, !dbg !2651
  %conv = sext i32 %land.ext to i64, !dbg !2651
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2654
  br i1 %cmp2, label %if.then, label %if.end7, !dbg !2655

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2656
  %sub = sub nsw i32 %5, 1, !dbg !2656
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2656
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2656
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2658
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2659
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2661
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !2662

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2663
  %9 = load i8*, i8** %pcName.addr, align 8, !dbg !2665
  call void @vQueueAddToRegistry(%struct.QueueDefinition* %8, i8* %9), !dbg !2666
  br label %if.end, !dbg !2667

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end7, !dbg !2668

if.end7:                                          ; preds = %if.end, %land.end
  ret void, !dbg !2669
}

declare dso_local void @vQueueAddToRegistry(%struct.QueueDefinition*, i8*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vQueueUnregisterQueueImpl(%struct.QueueDefinition* %xQueue) #0 section "privileged_functions" !dbg !2670 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !2673, metadata !DIExpression()), !dbg !2674
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2675, metadata !DIExpression()), !dbg !2676
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2677, metadata !DIExpression()), !dbg !2678
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2678
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !2679
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2680
  store i32 %1, i32* %lIndex, align 4, !dbg !2681
  %2 = load i32, i32* %lIndex, align 4, !dbg !2682
  %cmp = icmp sge i32 %2, 1, !dbg !2682
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2682

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2682
  %cmp1 = icmp slt i32 %3, 257, !dbg !2682
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2684
  %land.ext = zext i1 %4 to i32, !dbg !2682
  %conv = sext i32 %land.ext to i64, !dbg !2682
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2685
  br i1 %cmp2, label %if.then, label %if.end7, !dbg !2686

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2687
  %sub = sub nsw i32 %5, 1, !dbg !2687
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2687
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2687
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2689
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2690
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2692
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !2693

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2694
  call void @vQueueUnregisterQueue(%struct.QueueDefinition* %8), !dbg !2696
  br label %if.end, !dbg !2697

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end7, !dbg !2698

if.end7:                                          ; preds = %if.end, %land.end
  ret void, !dbg !2699
}

declare dso_local void @vQueueUnregisterQueue(%struct.QueueDefinition*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @MPU_pcQueueGetNameImpl(%struct.QueueDefinition* %xQueue) #0 section "privileged_functions" !dbg !2700 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %pcReturn = alloca i8*, align 8
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %lIndex = alloca i32, align 4
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !2703, metadata !DIExpression()), !dbg !2704
  call void @llvm.dbg.declare(metadata i8** %pcReturn, metadata !2705, metadata !DIExpression()), !dbg !2706
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2707, metadata !DIExpression()), !dbg !2708
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2708
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2709, metadata !DIExpression()), !dbg !2710
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !2711
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2712
  store i32 %1, i32* %lIndex, align 4, !dbg !2713
  %2 = load i32, i32* %lIndex, align 4, !dbg !2714
  %cmp = icmp sge i32 %2, 1, !dbg !2714
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2714

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2714
  %cmp1 = icmp slt i32 %3, 257, !dbg !2714
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2716
  %land.ext = zext i1 %4 to i32, !dbg !2714
  %conv = sext i32 %land.ext to i64, !dbg !2714
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2717
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !2718

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2719
  %sub = sub nsw i32 %5, 1, !dbg !2719
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2719
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2719
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2721
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2722
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2724
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !2725

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2726
  %call7 = call i8* @pcQueueGetName(%struct.QueueDefinition* %8), !dbg !2728
  store i8* %call7, i8** %pcReturn, align 8, !dbg !2729
  br label %if.end, !dbg !2730

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !2731

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i8*, i8** %pcReturn, align 8, !dbg !2732
  ret i8* %9, !dbg !2733
}

declare dso_local i8* @pcQueueGetName(%struct.QueueDefinition*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vQueueDelete(%struct.QueueDefinition* %xQueue) #0 section "privileged_functions" !dbg !2734 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %lIndex = alloca i32, align 4
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !2735, metadata !DIExpression()), !dbg !2736
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2737, metadata !DIExpression()), !dbg !2738
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2738
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2739, metadata !DIExpression()), !dbg !2740
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !2741
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2742
  store i32 %1, i32* %lIndex, align 4, !dbg !2743
  %2 = load i32, i32* %lIndex, align 4, !dbg !2744
  %cmp = icmp sge i32 %2, 1, !dbg !2744
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2744

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2744
  %cmp1 = icmp slt i32 %3, 257, !dbg !2744
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2746
  %land.ext = zext i1 %4 to i32, !dbg !2744
  %conv = sext i32 %land.ext to i64, !dbg !2744
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2747
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !2748

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2749
  %sub = sub nsw i32 %5, 1, !dbg !2749
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2749
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2749
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2751
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2752
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2754
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !2755

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2756
  call void @vQueueDelete(%struct.QueueDefinition* %8), !dbg !2758
  %9 = load i32, i32* %lIndex, align 4, !dbg !2759
  %sub7 = sub nsw i32 %9, 1, !dbg !2759
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %sub7), !dbg !2760
  br label %if.end, !dbg !2761

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !2762

if.end8:                                          ; preds = %if.end, %land.end
  ret void, !dbg !2763
}

declare dso_local void @vQueueDelete(%struct.QueueDefinition*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.QueueDefinition* @MPU_xQueueCreateCountingSemaphore(i64 %uxCountValue, i64 %uxInitialCount) #0 section "privileged_functions" !dbg !2764 {
entry:
  %uxCountValue.addr = alloca i64, align 8
  %uxInitialCount.addr = alloca i64, align 8
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %xExternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %lIndex = alloca i32, align 4
  store i64 %uxCountValue, i64* %uxCountValue.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxCountValue.addr, metadata !2767, metadata !DIExpression()), !dbg !2768
  store i64 %uxInitialCount, i64* %uxInitialCount.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxInitialCount.addr, metadata !2769, metadata !DIExpression()), !dbg !2770
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2771, metadata !DIExpression()), !dbg !2772
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2772
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xExternalQueueHandle, metadata !2773, metadata !DIExpression()), !dbg !2774
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2774
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2775, metadata !DIExpression()), !dbg !2776
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !2777
  store i32 %call, i32* %lIndex, align 4, !dbg !2778
  %0 = load i32, i32* %lIndex, align 4, !dbg !2779
  %cmp = icmp ne i32 %0, -1, !dbg !2781
  br i1 %cmp, label %if.then, label %if.end4, !dbg !2782

if.then:                                          ; preds = %entry
  %1 = load i64, i64* %uxCountValue.addr, align 8, !dbg !2783
  %2 = load i64, i64* %uxInitialCount.addr, align 8, !dbg !2785
  %call1 = call %struct.QueueDefinition* @xQueueCreateCountingSemaphore(i64 %1, i64 %2), !dbg !2786
  store %struct.QueueDefinition* %call1, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2787
  %3 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2788
  %cmp2 = icmp ne %struct.QueueDefinition* %3, null, !dbg !2790
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !2791

if.then3:                                         ; preds = %if.then
  %4 = load i32, i32* %lIndex, align 4, !dbg !2792
  %5 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2792
  %6 = bitcast %struct.QueueDefinition* %5 to %struct.OpaqueObject*, !dbg !2792
  call void @MPU_StoreHandleAndDataAtIndex(i32 %4, %struct.OpaqueObject* %6, i8* null, i32 1), !dbg !2792
  %7 = load i32, i32* %lIndex, align 4, !dbg !2794
  %add = add nsw i32 %7, 1, !dbg !2794
  %conv = sext i32 %add to i64, !dbg !2795
  %8 = inttoptr i64 %conv to %struct.QueueDefinition*, !dbg !2795
  store %struct.QueueDefinition* %8, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2796
  br label %if.end, !dbg !2797

if.else:                                          ; preds = %if.then
  %9 = load i32, i32* %lIndex, align 4, !dbg !2798
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %9), !dbg !2800
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  br label %if.end4, !dbg !2801

if.end4:                                          ; preds = %if.end, %entry
  %10 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2802
  ret %struct.QueueDefinition* %10, !dbg !2803
}

declare dso_local %struct.QueueDefinition* @xQueueCreateCountingSemaphore(i64, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.QueueDefinition* @MPU_xQueueCreateCountingSemaphoreStatic(i64 %uxMaxCount, i64 %uxInitialCount, %struct.xSTATIC_QUEUE* %pxStaticQueue) #0 section "privileged_functions" !dbg !2804 {
entry:
  %uxMaxCount.addr = alloca i64, align 8
  %uxInitialCount.addr = alloca i64, align 8
  %pxStaticQueue.addr = alloca %struct.xSTATIC_QUEUE*, align 8
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %xExternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %lIndex = alloca i32, align 4
  store i64 %uxMaxCount, i64* %uxMaxCount.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxMaxCount.addr, metadata !2841, metadata !DIExpression()), !dbg !2842
  store i64 %uxInitialCount, i64* %uxInitialCount.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxInitialCount.addr, metadata !2843, metadata !DIExpression()), !dbg !2844
  store %struct.xSTATIC_QUEUE* %pxStaticQueue, %struct.xSTATIC_QUEUE** %pxStaticQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xSTATIC_QUEUE** %pxStaticQueue.addr, metadata !2845, metadata !DIExpression()), !dbg !2846
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2847, metadata !DIExpression()), !dbg !2848
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2848
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xExternalQueueHandle, metadata !2849, metadata !DIExpression()), !dbg !2850
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2850
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2851, metadata !DIExpression()), !dbg !2852
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !2853
  store i32 %call, i32* %lIndex, align 4, !dbg !2854
  %0 = load i32, i32* %lIndex, align 4, !dbg !2855
  %cmp = icmp ne i32 %0, -1, !dbg !2857
  br i1 %cmp, label %if.then, label %if.end4, !dbg !2858

if.then:                                          ; preds = %entry
  %1 = load i64, i64* %uxMaxCount.addr, align 8, !dbg !2859
  %2 = load i64, i64* %uxInitialCount.addr, align 8, !dbg !2861
  %3 = load %struct.xSTATIC_QUEUE*, %struct.xSTATIC_QUEUE** %pxStaticQueue.addr, align 8, !dbg !2862
  %call1 = call %struct.QueueDefinition* @xQueueCreateCountingSemaphoreStatic(i64 %1, i64 %2, %struct.xSTATIC_QUEUE* %3), !dbg !2863
  store %struct.QueueDefinition* %call1, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2864
  %4 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2865
  %cmp2 = icmp ne %struct.QueueDefinition* %4, null, !dbg !2867
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !2868

if.then3:                                         ; preds = %if.then
  %5 = load i32, i32* %lIndex, align 4, !dbg !2869
  %6 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2869
  %7 = bitcast %struct.QueueDefinition* %6 to %struct.OpaqueObject*, !dbg !2869
  call void @MPU_StoreHandleAndDataAtIndex(i32 %5, %struct.OpaqueObject* %7, i8* null, i32 1), !dbg !2869
  %8 = load i32, i32* %lIndex, align 4, !dbg !2871
  %add = add nsw i32 %8, 1, !dbg !2871
  %conv = sext i32 %add to i64, !dbg !2872
  %9 = inttoptr i64 %conv to %struct.QueueDefinition*, !dbg !2872
  store %struct.QueueDefinition* %9, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2873
  br label %if.end, !dbg !2874

if.else:                                          ; preds = %if.then
  %10 = load i32, i32* %lIndex, align 4, !dbg !2875
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %10), !dbg !2877
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  br label %if.end4, !dbg !2878

if.end4:                                          ; preds = %if.end, %entry
  %11 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2879
  ret %struct.QueueDefinition* %11, !dbg !2880
}

declare dso_local %struct.QueueDefinition* @xQueueCreateCountingSemaphoreStatic(i64, i64, %struct.xSTATIC_QUEUE*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.QueueDefinition* @MPU_xQueueGenericCreate(i64 %uxQueueLength, i64 %uxItemSize, i8 zeroext %ucQueueType) #0 section "privileged_functions" !dbg !2881 {
entry:
  %uxQueueLength.addr = alloca i64, align 8
  %uxItemSize.addr = alloca i64, align 8
  %ucQueueType.addr = alloca i8, align 1
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %xExternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %lIndex = alloca i32, align 4
  store i64 %uxQueueLength, i64* %uxQueueLength.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxQueueLength.addr, metadata !2884, metadata !DIExpression()), !dbg !2885
  store i64 %uxItemSize, i64* %uxItemSize.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxItemSize.addr, metadata !2886, metadata !DIExpression()), !dbg !2887
  store i8 %ucQueueType, i8* %ucQueueType.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %ucQueueType.addr, metadata !2888, metadata !DIExpression()), !dbg !2889
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2890, metadata !DIExpression()), !dbg !2891
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2891
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xExternalQueueHandle, metadata !2892, metadata !DIExpression()), !dbg !2893
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2893
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2894, metadata !DIExpression()), !dbg !2895
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !2896
  store i32 %call, i32* %lIndex, align 4, !dbg !2897
  %0 = load i32, i32* %lIndex, align 4, !dbg !2898
  %cmp = icmp ne i32 %0, -1, !dbg !2900
  br i1 %cmp, label %if.then, label %if.end4, !dbg !2901

if.then:                                          ; preds = %entry
  %1 = load i64, i64* %uxQueueLength.addr, align 8, !dbg !2902
  %2 = load i64, i64* %uxItemSize.addr, align 8, !dbg !2904
  %3 = load i8, i8* %ucQueueType.addr, align 1, !dbg !2905
  %call1 = call %struct.QueueDefinition* @xQueueGenericCreate(i64 %1, i64 %2, i8 zeroext %3), !dbg !2906
  store %struct.QueueDefinition* %call1, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2907
  %4 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2908
  %cmp2 = icmp ne %struct.QueueDefinition* %4, null, !dbg !2910
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !2911

if.then3:                                         ; preds = %if.then
  %5 = load i32, i32* %lIndex, align 4, !dbg !2912
  %6 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2912
  %7 = bitcast %struct.QueueDefinition* %6 to %struct.OpaqueObject*, !dbg !2912
  call void @MPU_StoreHandleAndDataAtIndex(i32 %5, %struct.OpaqueObject* %7, i8* null, i32 1), !dbg !2912
  %8 = load i32, i32* %lIndex, align 4, !dbg !2914
  %add = add nsw i32 %8, 1, !dbg !2914
  %conv = sext i32 %add to i64, !dbg !2915
  %9 = inttoptr i64 %conv to %struct.QueueDefinition*, !dbg !2915
  store %struct.QueueDefinition* %9, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2916
  br label %if.end, !dbg !2917

if.else:                                          ; preds = %if.then
  %10 = load i32, i32* %lIndex, align 4, !dbg !2918
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %10), !dbg !2920
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  br label %if.end4, !dbg !2921

if.end4:                                          ; preds = %if.end, %entry
  %11 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2922
  ret %struct.QueueDefinition* %11, !dbg !2923
}

declare dso_local %struct.QueueDefinition* @xQueueGenericCreate(i64, i64, i8 zeroext) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.QueueDefinition* @MPU_xQueueGenericCreateStatic(i64 %uxQueueLength, i64 %uxItemSize, i8* %pucQueueStorage, %struct.xSTATIC_QUEUE* %pxStaticQueue, i8 zeroext %ucQueueType) #0 section "privileged_functions" !dbg !2924 {
entry:
  %uxQueueLength.addr = alloca i64, align 8
  %uxItemSize.addr = alloca i64, align 8
  %pucQueueStorage.addr = alloca i8*, align 8
  %pxStaticQueue.addr = alloca %struct.xSTATIC_QUEUE*, align 8
  %ucQueueType.addr = alloca i8, align 1
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %xExternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %lIndex = alloca i32, align 4
  store i64 %uxQueueLength, i64* %uxQueueLength.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxQueueLength.addr, metadata !2929, metadata !DIExpression()), !dbg !2930
  store i64 %uxItemSize, i64* %uxItemSize.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxItemSize.addr, metadata !2931, metadata !DIExpression()), !dbg !2932
  store i8* %pucQueueStorage, i8** %pucQueueStorage.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pucQueueStorage.addr, metadata !2933, metadata !DIExpression()), !dbg !2934
  store %struct.xSTATIC_QUEUE* %pxStaticQueue, %struct.xSTATIC_QUEUE** %pxStaticQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xSTATIC_QUEUE** %pxStaticQueue.addr, metadata !2935, metadata !DIExpression()), !dbg !2936
  store i8 %ucQueueType, i8* %ucQueueType.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %ucQueueType.addr, metadata !2937, metadata !DIExpression()), !dbg !2938
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2939, metadata !DIExpression()), !dbg !2940
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2940
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xExternalQueueHandle, metadata !2941, metadata !DIExpression()), !dbg !2942
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2942
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2943, metadata !DIExpression()), !dbg !2944
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !2945
  store i32 %call, i32* %lIndex, align 4, !dbg !2946
  %0 = load i32, i32* %lIndex, align 4, !dbg !2947
  %cmp = icmp ne i32 %0, -1, !dbg !2949
  br i1 %cmp, label %if.then, label %if.end4, !dbg !2950

if.then:                                          ; preds = %entry
  %1 = load i64, i64* %uxQueueLength.addr, align 8, !dbg !2951
  %2 = load i64, i64* %uxItemSize.addr, align 8, !dbg !2953
  %3 = load i8*, i8** %pucQueueStorage.addr, align 8, !dbg !2954
  %4 = load %struct.xSTATIC_QUEUE*, %struct.xSTATIC_QUEUE** %pxStaticQueue.addr, align 8, !dbg !2955
  %5 = load i8, i8* %ucQueueType.addr, align 1, !dbg !2956
  %call1 = call %struct.QueueDefinition* @xQueueGenericCreateStatic(i64 %1, i64 %2, i8* %3, %struct.xSTATIC_QUEUE* %4, i8 zeroext %5), !dbg !2957
  store %struct.QueueDefinition* %call1, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2958
  %6 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2959
  %cmp2 = icmp ne %struct.QueueDefinition* %6, null, !dbg !2961
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !2962

if.then3:                                         ; preds = %if.then
  %7 = load i32, i32* %lIndex, align 4, !dbg !2963
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2963
  %9 = bitcast %struct.QueueDefinition* %8 to %struct.OpaqueObject*, !dbg !2963
  call void @MPU_StoreHandleAndDataAtIndex(i32 %7, %struct.OpaqueObject* %9, i8* null, i32 1), !dbg !2963
  %10 = load i32, i32* %lIndex, align 4, !dbg !2965
  %add = add nsw i32 %10, 1, !dbg !2965
  %conv = sext i32 %add to i64, !dbg !2966
  %11 = inttoptr i64 %conv to %struct.QueueDefinition*, !dbg !2966
  store %struct.QueueDefinition* %11, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2967
  br label %if.end, !dbg !2968

if.else:                                          ; preds = %if.then
  %12 = load i32, i32* %lIndex, align 4, !dbg !2969
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %12), !dbg !2971
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  br label %if.end4, !dbg !2972

if.end4:                                          ; preds = %if.end, %entry
  %13 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2973
  ret %struct.QueueDefinition* %13, !dbg !2974
}

declare dso_local %struct.QueueDefinition* @xQueueGenericCreateStatic(i64, i64, i8*, %struct.xSTATIC_QUEUE*, i8 zeroext) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueGenericReset(%struct.QueueDefinition* %xQueue, i64 %xNewQueue) #0 section "privileged_functions" !dbg !2975 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %xNewQueue.addr = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %xReturn = alloca i64, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !2978, metadata !DIExpression()), !dbg !2979
  store i64 %xNewQueue, i64* %xNewQueue.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xNewQueue.addr, metadata !2980, metadata !DIExpression()), !dbg !2981
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2982, metadata !DIExpression()), !dbg !2983
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2984, metadata !DIExpression()), !dbg !2985
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2985
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !2986, metadata !DIExpression()), !dbg !2987
  store i64 0, i64* %xReturn, align 8, !dbg !2987
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !2988
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2989
  store i32 %1, i32* %lIndex, align 4, !dbg !2990
  %2 = load i32, i32* %lIndex, align 4, !dbg !2991
  %cmp = icmp sge i32 %2, 1, !dbg !2991
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2991

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2991
  %cmp1 = icmp slt i32 %3, 257, !dbg !2991
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2993
  %land.ext = zext i1 %4 to i32, !dbg !2991
  %conv = sext i32 %land.ext to i64, !dbg !2991
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2994
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !2995

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2996
  %sub = sub nsw i32 %5, 1, !dbg !2996
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2996
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2996
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2998
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2999
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !3001
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3002

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3003
  %9 = load i64, i64* %xNewQueue.addr, align 8, !dbg !3005
  %call7 = call i64 @xQueueGenericReset(%struct.QueueDefinition* %8, i64 %9), !dbg !3006
  store i64 %call7, i64* %xReturn, align 8, !dbg !3007
  br label %if.end, !dbg !3008

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3009

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !3010
  ret i64 %10, !dbg !3011
}

declare dso_local i64 @xQueueGenericReset(%struct.QueueDefinition*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.QueueDefinition* @MPU_xQueueCreateSet(i64 %uxEventQueueLength) #0 section "privileged_functions" !dbg !3012 {
entry:
  %uxEventQueueLength.addr = alloca i64, align 8
  %xInternalQueueSetHandle = alloca %struct.QueueDefinition*, align 8
  %xExternalQueueSetHandle = alloca %struct.QueueDefinition*, align 8
  %lIndex = alloca i32, align 4
  store i64 %uxEventQueueLength, i64* %uxEventQueueLength.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxEventQueueLength.addr, metadata !3015, metadata !DIExpression()), !dbg !3016
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueSetHandle, metadata !3017, metadata !DIExpression()), !dbg !3018
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !3018
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xExternalQueueSetHandle, metadata !3019, metadata !DIExpression()), !dbg !3020
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xExternalQueueSetHandle, align 8, !dbg !3020
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3021, metadata !DIExpression()), !dbg !3022
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !3023
  store i32 %call, i32* %lIndex, align 4, !dbg !3024
  %0 = load i32, i32* %lIndex, align 4, !dbg !3025
  %cmp = icmp ne i32 %0, -1, !dbg !3027
  br i1 %cmp, label %if.then, label %if.end4, !dbg !3028

if.then:                                          ; preds = %entry
  %1 = load i64, i64* %uxEventQueueLength.addr, align 8, !dbg !3029
  %call1 = call %struct.QueueDefinition* @xQueueCreateSet(i64 %1), !dbg !3031
  store %struct.QueueDefinition* %call1, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !3032
  %2 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !3033
  %cmp2 = icmp ne %struct.QueueDefinition* %2, null, !dbg !3035
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !3036

if.then3:                                         ; preds = %if.then
  %3 = load i32, i32* %lIndex, align 4, !dbg !3037
  %4 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !3037
  %5 = bitcast %struct.QueueDefinition* %4 to %struct.OpaqueObject*, !dbg !3037
  call void @MPU_StoreHandleAndDataAtIndex(i32 %3, %struct.OpaqueObject* %5, i8* null, i32 1), !dbg !3037
  %6 = load i32, i32* %lIndex, align 4, !dbg !3039
  %add = add nsw i32 %6, 1, !dbg !3039
  %conv = sext i32 %add to i64, !dbg !3040
  %7 = inttoptr i64 %conv to %struct.QueueDefinition*, !dbg !3040
  store %struct.QueueDefinition* %7, %struct.QueueDefinition** %xExternalQueueSetHandle, align 8, !dbg !3041
  br label %if.end, !dbg !3042

if.else:                                          ; preds = %if.then
  %8 = load i32, i32* %lIndex, align 4, !dbg !3043
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %8), !dbg !3045
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  br label %if.end4, !dbg !3046

if.end4:                                          ; preds = %if.end, %entry
  %9 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xExternalQueueSetHandle, align 8, !dbg !3047
  ret %struct.QueueDefinition* %9, !dbg !3048
}

declare dso_local %struct.QueueDefinition* @xQueueCreateSet(i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueRemoveFromSet(%struct.QueueDefinition* %xQueueOrSemaphore, %struct.QueueDefinition* %xQueueSet) #0 section "privileged_functions" !dbg !3049 {
entry:
  %xQueueOrSemaphore.addr = alloca %struct.QueueDefinition*, align 8
  %xQueueSet.addr = alloca %struct.QueueDefinition*, align 8
  %xReturn = alloca i64, align 8
  %xInternalQueueSetMemberHandle = alloca %struct.QueueDefinition*, align 8
  %xInternalQueueSetHandle = alloca %struct.QueueDefinition*, align 8
  %lIndexQueueSet = alloca i32, align 4
  %lIndexQueueSetMember = alloca i32, align 4
  store %struct.QueueDefinition* %xQueueOrSemaphore, %struct.QueueDefinition** %xQueueOrSemaphore.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueueOrSemaphore.addr, metadata !3050, metadata !DIExpression()), !dbg !3051
  store %struct.QueueDefinition* %xQueueSet, %struct.QueueDefinition** %xQueueSet.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueueSet.addr, metadata !3052, metadata !DIExpression()), !dbg !3053
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3054, metadata !DIExpression()), !dbg !3055
  store i64 0, i64* %xReturn, align 8, !dbg !3055
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueSetMemberHandle, metadata !3056, metadata !DIExpression()), !dbg !3057
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueSetMemberHandle, align 8, !dbg !3057
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueSetHandle, metadata !3058, metadata !DIExpression()), !dbg !3059
  call void @llvm.dbg.declare(metadata i32* %lIndexQueueSet, metadata !3060, metadata !DIExpression()), !dbg !3061
  call void @llvm.dbg.declare(metadata i32* %lIndexQueueSetMember, metadata !3062, metadata !DIExpression()), !dbg !3063
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueueSet.addr, align 8, !dbg !3064
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !3065
  store i32 %1, i32* %lIndexQueueSet, align 4, !dbg !3066
  %2 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueueOrSemaphore.addr, align 8, !dbg !3067
  %3 = ptrtoint %struct.QueueDefinition* %2 to i32, !dbg !3068
  store i32 %3, i32* %lIndexQueueSetMember, align 4, !dbg !3069
  %4 = load i32, i32* %lIndexQueueSet, align 4, !dbg !3070
  %cmp = icmp sge i32 %4, 1, !dbg !3070
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3070

land.rhs:                                         ; preds = %entry
  %5 = load i32, i32* %lIndexQueueSet, align 4, !dbg !3070
  %cmp1 = icmp slt i32 %5, 257, !dbg !3070
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %6 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3072
  %land.ext = zext i1 %6 to i32, !dbg !3070
  %conv = sext i32 %land.ext to i64, !dbg !3070
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3073
  br i1 %cmp2, label %land.lhs.true, label %if.end23, !dbg !3074

land.lhs.true:                                    ; preds = %land.end
  %7 = load i32, i32* %lIndexQueueSetMember, align 4, !dbg !3075
  %cmp4 = icmp sge i32 %7, 1, !dbg !3075
  br i1 %cmp4, label %land.rhs6, label %land.end9, !dbg !3075

land.rhs6:                                        ; preds = %land.lhs.true
  %8 = load i32, i32* %lIndexQueueSetMember, align 4, !dbg !3075
  %cmp7 = icmp slt i32 %8, 257, !dbg !3075
  br label %land.end9

land.end9:                                        ; preds = %land.rhs6, %land.lhs.true
  %9 = phi i1 [ false, %land.lhs.true ], [ %cmp7, %land.rhs6 ], !dbg !3072
  %land.ext10 = zext i1 %9 to i32, !dbg !3075
  %conv11 = sext i32 %land.ext10 to i64, !dbg !3075
  %cmp12 = icmp ne i64 %conv11, 0, !dbg !3076
  br i1 %cmp12, label %if.then, label %if.end23, !dbg !3077

if.then:                                          ; preds = %land.end9
  %10 = load i32, i32* %lIndexQueueSet, align 4, !dbg !3078
  %sub = sub nsw i32 %10, 1, !dbg !3078
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !3078
  %11 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !3078
  store %struct.QueueDefinition* %11, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !3080
  %12 = load i32, i32* %lIndexQueueSetMember, align 4, !dbg !3081
  %sub14 = sub nsw i32 %12, 1, !dbg !3081
  %call15 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub14, i32 1), !dbg !3081
  %13 = bitcast %struct.OpaqueObject* %call15 to %struct.QueueDefinition*, !dbg !3081
  store %struct.QueueDefinition* %13, %struct.QueueDefinition** %xInternalQueueSetMemberHandle, align 8, !dbg !3082
  %14 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !3083
  %cmp16 = icmp ne %struct.QueueDefinition* %14, null, !dbg !3085
  br i1 %cmp16, label %land.lhs.true18, label %if.end, !dbg !3086

land.lhs.true18:                                  ; preds = %if.then
  %15 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetMemberHandle, align 8, !dbg !3087
  %cmp19 = icmp ne %struct.QueueDefinition* %15, null, !dbg !3088
  br i1 %cmp19, label %if.then21, label %if.end, !dbg !3089

if.then21:                                        ; preds = %land.lhs.true18
  %16 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetMemberHandle, align 8, !dbg !3090
  %17 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !3092
  %call22 = call i64 @xQueueRemoveFromSet(%struct.QueueDefinition* %16, %struct.QueueDefinition* %17), !dbg !3093
  store i64 %call22, i64* %xReturn, align 8, !dbg !3094
  br label %if.end, !dbg !3095

if.end:                                           ; preds = %if.then21, %land.lhs.true18, %if.then
  br label %if.end23, !dbg !3096

if.end23:                                         ; preds = %if.end, %land.end9, %land.end
  %18 = load i64, i64* %xReturn, align 8, !dbg !3097
  ret i64 %18, !dbg !3098
}

declare dso_local i64 @xQueueRemoveFromSet(%struct.QueueDefinition*, %struct.QueueDefinition*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueGenericGetStaticBuffers(%struct.QueueDefinition* %xQueue, i8** %ppucQueueStorage, %struct.xSTATIC_QUEUE** %ppxStaticQueue) #0 section "privileged_functions" !dbg !3099 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %ppucQueueStorage.addr = alloca i8**, align 8
  %ppxStaticQueue.addr = alloca %struct.xSTATIC_QUEUE**, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %xReturn = alloca i64, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !3104, metadata !DIExpression()), !dbg !3105
  store i8** %ppucQueueStorage, i8*** %ppucQueueStorage.addr, align 8
  call void @llvm.dbg.declare(metadata i8*** %ppucQueueStorage.addr, metadata !3106, metadata !DIExpression()), !dbg !3107
  store %struct.xSTATIC_QUEUE** %ppxStaticQueue, %struct.xSTATIC_QUEUE*** %ppxStaticQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xSTATIC_QUEUE*** %ppxStaticQueue.addr, metadata !3108, metadata !DIExpression()), !dbg !3109
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3110, metadata !DIExpression()), !dbg !3111
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !3112, metadata !DIExpression()), !dbg !3113
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3113
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3114, metadata !DIExpression()), !dbg !3115
  store i64 0, i64* %xReturn, align 8, !dbg !3115
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !3116
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !3117
  store i32 %1, i32* %lIndex, align 4, !dbg !3118
  %2 = load i32, i32* %lIndex, align 4, !dbg !3119
  %cmp = icmp sge i32 %2, 1, !dbg !3119
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3119

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3119
  %cmp1 = icmp slt i32 %3, 257, !dbg !3119
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3121
  %land.ext = zext i1 %4 to i32, !dbg !3119
  %conv = sext i32 %land.ext to i64, !dbg !3119
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3122
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3123

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3124
  %sub = sub nsw i32 %5, 1, !dbg !3124
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !3124
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !3124
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3126
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3127
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !3129
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3130

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3131
  %9 = load i8**, i8*** %ppucQueueStorage.addr, align 8, !dbg !3133
  %10 = load %struct.xSTATIC_QUEUE**, %struct.xSTATIC_QUEUE*** %ppxStaticQueue.addr, align 8, !dbg !3134
  %call7 = call i64 @xQueueGenericGetStaticBuffers(%struct.QueueDefinition* %8, i8** %9, %struct.xSTATIC_QUEUE** %10), !dbg !3135
  store i64 %call7, i64* %xReturn, align 8, !dbg !3136
  br label %if.end, !dbg !3137

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3138

if.end8:                                          ; preds = %if.end, %land.end
  %11 = load i64, i64* %xReturn, align 8, !dbg !3139
  ret i64 %11, !dbg !3140
}

declare dso_local i64 @xQueueGenericGetStaticBuffers(%struct.QueueDefinition*, i8**, %struct.xSTATIC_QUEUE**) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueGenericSendFromISR(%struct.QueueDefinition* %xQueue, i8* %pvItemToQueue, i64* %pxHigherPriorityTaskWoken, i64 %xCopyPosition) #0 section "privileged_functions" !dbg !3141 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %pvItemToQueue.addr = alloca i8*, align 8
  %pxHigherPriorityTaskWoken.addr = alloca i64*, align 8
  %xCopyPosition.addr = alloca i64, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !3146, metadata !DIExpression()), !dbg !3147
  store i8* %pvItemToQueue, i8** %pvItemToQueue.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvItemToQueue.addr, metadata !3148, metadata !DIExpression()), !dbg !3149
  store i64* %pxHigherPriorityTaskWoken, i64** %pxHigherPriorityTaskWoken.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxHigherPriorityTaskWoken.addr, metadata !3150, metadata !DIExpression()), !dbg !3151
  store i64 %xCopyPosition, i64* %xCopyPosition.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xCopyPosition.addr, metadata !3152, metadata !DIExpression()), !dbg !3153
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3154, metadata !DIExpression()), !dbg !3155
  store i64 0, i64* %xReturn, align 8, !dbg !3155
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3156, metadata !DIExpression()), !dbg !3157
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !3158, metadata !DIExpression()), !dbg !3159
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3159
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !3160
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !3161
  store i32 %1, i32* %lIndex, align 4, !dbg !3162
  %2 = load i32, i32* %lIndex, align 4, !dbg !3163
  %cmp = icmp sge i32 %2, 1, !dbg !3163
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3163

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3163
  %cmp1 = icmp slt i32 %3, 257, !dbg !3163
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3165
  %land.ext = zext i1 %4 to i32, !dbg !3163
  %conv = sext i32 %land.ext to i64, !dbg !3163
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3166
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3167

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3168
  %sub = sub nsw i32 %5, 1, !dbg !3168
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !3168
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !3168
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3170
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3171
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !3173
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3174

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3175
  %9 = load i8*, i8** %pvItemToQueue.addr, align 8, !dbg !3177
  %10 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !3178
  %11 = load i64, i64* %xCopyPosition.addr, align 8, !dbg !3179
  %call7 = call i64 @xQueueGenericSendFromISR(%struct.QueueDefinition* %8, i8* %9, i64* %10, i64 %11), !dbg !3180
  store i64 %call7, i64* %xReturn, align 8, !dbg !3181
  br label %if.end, !dbg !3182

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3183

if.end8:                                          ; preds = %if.end, %land.end
  %12 = load i64, i64* %xReturn, align 8, !dbg !3184
  ret i64 %12, !dbg !3185
}

declare dso_local i64 @xQueueGenericSendFromISR(%struct.QueueDefinition*, i8*, i64*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueGiveFromISR(%struct.QueueDefinition* %xQueue, i64* %pxHigherPriorityTaskWoken) #0 section "privileged_functions" !dbg !3186 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %pxHigherPriorityTaskWoken.addr = alloca i64*, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !3189, metadata !DIExpression()), !dbg !3190
  store i64* %pxHigherPriorityTaskWoken, i64** %pxHigherPriorityTaskWoken.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxHigherPriorityTaskWoken.addr, metadata !3191, metadata !DIExpression()), !dbg !3192
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3193, metadata !DIExpression()), !dbg !3194
  store i64 0, i64* %xReturn, align 8, !dbg !3194
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3195, metadata !DIExpression()), !dbg !3196
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !3197, metadata !DIExpression()), !dbg !3198
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3198
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !3199
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !3200
  store i32 %1, i32* %lIndex, align 4, !dbg !3201
  %2 = load i32, i32* %lIndex, align 4, !dbg !3202
  %cmp = icmp sge i32 %2, 1, !dbg !3202
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3202

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3202
  %cmp1 = icmp slt i32 %3, 257, !dbg !3202
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3204
  %land.ext = zext i1 %4 to i32, !dbg !3202
  %conv = sext i32 %land.ext to i64, !dbg !3202
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3205
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3206

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3207
  %sub = sub nsw i32 %5, 1, !dbg !3207
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !3207
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !3207
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3209
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3210
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !3212
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3213

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3214
  %9 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !3216
  %call7 = call i64 @xQueueGiveFromISR(%struct.QueueDefinition* %8, i64* %9), !dbg !3217
  store i64 %call7, i64* %xReturn, align 8, !dbg !3218
  br label %if.end, !dbg !3219

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3220

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !3221
  ret i64 %10, !dbg !3222
}

declare dso_local i64 @xQueueGiveFromISR(%struct.QueueDefinition*, i64*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueuePeekFromISR(%struct.QueueDefinition* %xQueue, i8* %pvBuffer) #0 section "privileged_functions" !dbg !3223 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %pvBuffer.addr = alloca i8*, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !3226, metadata !DIExpression()), !dbg !3227
  store i8* %pvBuffer, i8** %pvBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvBuffer.addr, metadata !3228, metadata !DIExpression()), !dbg !3229
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3230, metadata !DIExpression()), !dbg !3231
  store i64 0, i64* %xReturn, align 8, !dbg !3231
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3232, metadata !DIExpression()), !dbg !3233
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !3234, metadata !DIExpression()), !dbg !3235
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3235
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !3236
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !3237
  store i32 %1, i32* %lIndex, align 4, !dbg !3238
  %2 = load i32, i32* %lIndex, align 4, !dbg !3239
  %cmp = icmp sge i32 %2, 1, !dbg !3239
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3239

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3239
  %cmp1 = icmp slt i32 %3, 257, !dbg !3239
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3241
  %land.ext = zext i1 %4 to i32, !dbg !3239
  %conv = sext i32 %land.ext to i64, !dbg !3239
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3242
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3243

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3244
  %sub = sub nsw i32 %5, 1, !dbg !3244
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !3244
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !3244
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3246
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3247
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !3249
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3250

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3251
  %9 = load i8*, i8** %pvBuffer.addr, align 8, !dbg !3253
  %call7 = call i64 @xQueuePeekFromISR(%struct.QueueDefinition* %8, i8* %9), !dbg !3254
  store i64 %call7, i64* %xReturn, align 8, !dbg !3255
  br label %if.end, !dbg !3256

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3257

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !3258
  ret i64 %10, !dbg !3259
}

declare dso_local i64 @xQueuePeekFromISR(%struct.QueueDefinition*, i8*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueReceiveFromISR(%struct.QueueDefinition* %xQueue, i8* %pvBuffer, i64* %pxHigherPriorityTaskWoken) #0 section "privileged_functions" !dbg !3260 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %pvBuffer.addr = alloca i8*, align 8
  %pxHigherPriorityTaskWoken.addr = alloca i64*, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !3263, metadata !DIExpression()), !dbg !3264
  store i8* %pvBuffer, i8** %pvBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvBuffer.addr, metadata !3265, metadata !DIExpression()), !dbg !3266
  store i64* %pxHigherPriorityTaskWoken, i64** %pxHigherPriorityTaskWoken.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxHigherPriorityTaskWoken.addr, metadata !3267, metadata !DIExpression()), !dbg !3268
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3269, metadata !DIExpression()), !dbg !3270
  store i64 0, i64* %xReturn, align 8, !dbg !3270
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3271, metadata !DIExpression()), !dbg !3272
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !3273, metadata !DIExpression()), !dbg !3274
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3274
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !3275
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !3276
  store i32 %1, i32* %lIndex, align 4, !dbg !3277
  %2 = load i32, i32* %lIndex, align 4, !dbg !3278
  %cmp = icmp sge i32 %2, 1, !dbg !3278
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3278

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3278
  %cmp1 = icmp slt i32 %3, 257, !dbg !3278
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3280
  %land.ext = zext i1 %4 to i32, !dbg !3278
  %conv = sext i32 %land.ext to i64, !dbg !3278
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3281
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3282

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3283
  %sub = sub nsw i32 %5, 1, !dbg !3283
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !3283
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !3283
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3285
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3286
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !3288
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3289

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3290
  %9 = load i8*, i8** %pvBuffer.addr, align 8, !dbg !3292
  %10 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !3293
  %call7 = call i64 @xQueueReceiveFromISR(%struct.QueueDefinition* %8, i8* %9, i64* %10), !dbg !3294
  store i64 %call7, i64* %xReturn, align 8, !dbg !3295
  br label %if.end, !dbg !3296

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3297

if.end8:                                          ; preds = %if.end, %land.end
  %11 = load i64, i64* %xReturn, align 8, !dbg !3298
  ret i64 %11, !dbg !3299
}

declare dso_local i64 @xQueueReceiveFromISR(%struct.QueueDefinition*, i8*, i64*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueIsQueueEmptyFromISR(%struct.QueueDefinition* %xQueue) #0 section "privileged_functions" !dbg !3300 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !3303, metadata !DIExpression()), !dbg !3304
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3305, metadata !DIExpression()), !dbg !3306
  store i64 0, i64* %xReturn, align 8, !dbg !3306
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3307, metadata !DIExpression()), !dbg !3308
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !3309, metadata !DIExpression()), !dbg !3310
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3310
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !3311
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !3312
  store i32 %1, i32* %lIndex, align 4, !dbg !3313
  %2 = load i32, i32* %lIndex, align 4, !dbg !3314
  %cmp = icmp sge i32 %2, 1, !dbg !3314
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3314

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3314
  %cmp1 = icmp slt i32 %3, 257, !dbg !3314
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3316
  %land.ext = zext i1 %4 to i32, !dbg !3314
  %conv = sext i32 %land.ext to i64, !dbg !3314
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3317
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3318

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3319
  %sub = sub nsw i32 %5, 1, !dbg !3319
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !3319
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !3319
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3321
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3322
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !3324
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3325

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3326
  %call7 = call i64 @xQueueIsQueueEmptyFromISR(%struct.QueueDefinition* %8), !dbg !3328
  store i64 %call7, i64* %xReturn, align 8, !dbg !3329
  br label %if.end, !dbg !3330

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3331

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !3332
  ret i64 %9, !dbg !3333
}

declare dso_local i64 @xQueueIsQueueEmptyFromISR(%struct.QueueDefinition*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueIsQueueFullFromISR(%struct.QueueDefinition* %xQueue) #0 section "privileged_functions" !dbg !3334 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !3335, metadata !DIExpression()), !dbg !3336
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3337, metadata !DIExpression()), !dbg !3338
  store i64 0, i64* %xReturn, align 8, !dbg !3338
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3339, metadata !DIExpression()), !dbg !3340
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !3341, metadata !DIExpression()), !dbg !3342
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3342
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !3343
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !3344
  store i32 %1, i32* %lIndex, align 4, !dbg !3345
  %2 = load i32, i32* %lIndex, align 4, !dbg !3346
  %cmp = icmp sge i32 %2, 1, !dbg !3346
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3346

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3346
  %cmp1 = icmp slt i32 %3, 257, !dbg !3346
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3348
  %land.ext = zext i1 %4 to i32, !dbg !3346
  %conv = sext i32 %land.ext to i64, !dbg !3346
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3349
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3350

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3351
  %sub = sub nsw i32 %5, 1, !dbg !3351
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !3351
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !3351
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3353
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3354
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !3356
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3357

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3358
  %call7 = call i64 @xQueueIsQueueFullFromISR(%struct.QueueDefinition* %8), !dbg !3360
  store i64 %call7, i64* %xReturn, align 8, !dbg !3361
  br label %if.end, !dbg !3362

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3363

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !3364
  ret i64 %9, !dbg !3365
}

declare dso_local i64 @xQueueIsQueueFullFromISR(%struct.QueueDefinition*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_uxQueueMessagesWaitingFromISR(%struct.QueueDefinition* %xQueue) #0 section "privileged_functions" !dbg !3366 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %uxReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !3367, metadata !DIExpression()), !dbg !3368
  call void @llvm.dbg.declare(metadata i64* %uxReturn, metadata !3369, metadata !DIExpression()), !dbg !3370
  store i64 0, i64* %uxReturn, align 8, !dbg !3370
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3371, metadata !DIExpression()), !dbg !3372
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !3373, metadata !DIExpression()), !dbg !3374
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3374
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !3375
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !3376
  store i32 %1, i32* %lIndex, align 4, !dbg !3377
  %2 = load i32, i32* %lIndex, align 4, !dbg !3378
  %cmp = icmp sge i32 %2, 1, !dbg !3378
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3378

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3378
  %cmp1 = icmp slt i32 %3, 257, !dbg !3378
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3380
  %land.ext = zext i1 %4 to i32, !dbg !3378
  %conv = sext i32 %land.ext to i64, !dbg !3378
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3381
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3382

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3383
  %sub = sub nsw i32 %5, 1, !dbg !3383
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !3383
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !3383
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3385
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3386
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !3388
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3389

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3390
  %call7 = call i64 @uxQueueMessagesWaitingFromISR(%struct.QueueDefinition* %8), !dbg !3392
  store i64 %call7, i64* %uxReturn, align 8, !dbg !3393
  br label %if.end, !dbg !3394

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3395

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %uxReturn, align 8, !dbg !3396
  ret i64 %9, !dbg !3397
}

declare dso_local i64 @uxQueueMessagesWaitingFromISR(%struct.QueueDefinition*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.QueueDefinition* @MPU_xQueueSelectFromSetFromISR(%struct.QueueDefinition* %xQueueSet) #0 section "privileged_functions" !dbg !3398 {
entry:
  %xQueueSet.addr = alloca %struct.QueueDefinition*, align 8
  %xInternalQueueSetHandle = alloca %struct.QueueDefinition*, align 8
  %xSelectedMemberInternal = alloca %struct.QueueDefinition*, align 8
  %xSelectedMemberExternal = alloca %struct.QueueDefinition*, align 8
  %lIndexQueueSet = alloca i32, align 4
  %lIndexSelectedMember = alloca i32, align 4
  store %struct.QueueDefinition* %xQueueSet, %struct.QueueDefinition** %xQueueSet.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueueSet.addr, metadata !3401, metadata !DIExpression()), !dbg !3402
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueSetHandle, metadata !3403, metadata !DIExpression()), !dbg !3404
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !3404
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xSelectedMemberInternal, metadata !3405, metadata !DIExpression()), !dbg !3406
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xSelectedMemberInternal, align 8, !dbg !3406
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xSelectedMemberExternal, metadata !3407, metadata !DIExpression()), !dbg !3408
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xSelectedMemberExternal, align 8, !dbg !3408
  call void @llvm.dbg.declare(metadata i32* %lIndexQueueSet, metadata !3409, metadata !DIExpression()), !dbg !3410
  call void @llvm.dbg.declare(metadata i32* %lIndexSelectedMember, metadata !3411, metadata !DIExpression()), !dbg !3412
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueueSet.addr, align 8, !dbg !3413
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !3414
  store i32 %1, i32* %lIndexQueueSet, align 4, !dbg !3415
  %2 = load i32, i32* %lIndexQueueSet, align 4, !dbg !3416
  %cmp = icmp sge i32 %2, 1, !dbg !3416
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3416

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndexQueueSet, align 4, !dbg !3416
  %cmp1 = icmp slt i32 %3, 257, !dbg !3416
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3418
  %land.ext = zext i1 %4 to i32, !dbg !3416
  %conv = sext i32 %land.ext to i64, !dbg !3416
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3419
  br i1 %cmp2, label %if.then, label %if.end18, !dbg !3420

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndexQueueSet, align 4, !dbg !3421
  %sub = sub nsw i32 %5, 1, !dbg !3421
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !3421
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !3421
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !3423
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !3424
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !3426
  br i1 %cmp4, label %if.then6, label %if.end17, !dbg !3427

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !3428
  %call7 = call %struct.QueueDefinition* @xQueueSelectFromSetFromISR(%struct.QueueDefinition* %8), !dbg !3430
  store %struct.QueueDefinition* %call7, %struct.QueueDefinition** %xSelectedMemberInternal, align 8, !dbg !3431
  %9 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xSelectedMemberInternal, align 8, !dbg !3432
  %cmp8 = icmp ne %struct.QueueDefinition* %9, null, !dbg !3434
  br i1 %cmp8, label %if.then10, label %if.end16, !dbg !3435

if.then10:                                        ; preds = %if.then6
  %10 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xSelectedMemberInternal, align 8, !dbg !3436
  %11 = bitcast %struct.QueueDefinition* %10 to %struct.OpaqueObject*, !dbg !3436
  %call11 = call i32 @MPU_GetIndexForHandle(%struct.OpaqueObject* %11, i32 1), !dbg !3436
  store i32 %call11, i32* %lIndexSelectedMember, align 4, !dbg !3438
  %12 = load i32, i32* %lIndexSelectedMember, align 4, !dbg !3439
  %cmp12 = icmp ne i32 %12, -1, !dbg !3441
  br i1 %cmp12, label %if.then14, label %if.end, !dbg !3442

if.then14:                                        ; preds = %if.then10
  %13 = load i32, i32* %lIndexSelectedMember, align 4, !dbg !3443
  %add = add nsw i32 %13, 1, !dbg !3443
  %conv15 = sext i32 %add to i64, !dbg !3445
  %14 = inttoptr i64 %conv15 to %struct.QueueDefinition*, !dbg !3445
  store %struct.QueueDefinition* %14, %struct.QueueDefinition** %xSelectedMemberExternal, align 8, !dbg !3446
  br label %if.end, !dbg !3447

if.end:                                           ; preds = %if.then14, %if.then10
  br label %if.end16, !dbg !3448

if.end16:                                         ; preds = %if.end, %if.then6
  br label %if.end17, !dbg !3449

if.end17:                                         ; preds = %if.end16, %if.then
  br label %if.end18, !dbg !3450

if.end18:                                         ; preds = %if.end17, %land.end
  %15 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xSelectedMemberExternal, align 8, !dbg !3451
  ret %struct.QueueDefinition* %15, !dbg !3452
}

declare dso_local %struct.QueueDefinition* @xQueueSelectFromSetFromISR(%struct.QueueDefinition*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @MPU_pvTimerGetTimerIDImpl(%struct.tmrTimerControl* %xTimer) #0 section "privileged_functions" !dbg !3453 {
entry:
  %xTimer.addr = alloca %struct.tmrTimerControl*, align 8
  %pvReturn = alloca i8*, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tmrTimerControl* %xTimer, %struct.tmrTimerControl** %xTimer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xTimer.addr, metadata !3457, metadata !DIExpression()), !dbg !3458
  call void @llvm.dbg.declare(metadata i8** %pvReturn, metadata !3459, metadata !DIExpression()), !dbg !3460
  store i8* null, i8** %pvReturn, align 8, !dbg !3460
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3461, metadata !DIExpression()), !dbg !3462
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3462
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3463, metadata !DIExpression()), !dbg !3464
  %0 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xTimer.addr, align 8, !dbg !3465
  %1 = ptrtoint %struct.tmrTimerControl* %0 to i32, !dbg !3466
  store i32 %1, i32* %lIndex, align 4, !dbg !3467
  %2 = load i32, i32* %lIndex, align 4, !dbg !3468
  %cmp = icmp sge i32 %2, 1, !dbg !3468
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3468

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3468
  %cmp1 = icmp slt i32 %3, 257, !dbg !3468
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3470
  %land.ext = zext i1 %4 to i32, !dbg !3468
  %conv = sext i32 %land.ext to i64, !dbg !3468
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3471
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3472

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3473
  %sub = sub nsw i32 %5, 1, !dbg !3473
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 5), !dbg !3473
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tmrTimerControl*, !dbg !3473
  store %struct.tmrTimerControl* %6, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3475
  %7 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3476
  %cmp4 = icmp ne %struct.tmrTimerControl* %7, null, !dbg !3478
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3479

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3480
  %call7 = call i8* @pvTimerGetTimerID(%struct.tmrTimerControl* %8), !dbg !3482
  store i8* %call7, i8** %pvReturn, align 8, !dbg !3483
  br label %if.end, !dbg !3484

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3485

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i8*, i8** %pvReturn, align 8, !dbg !3486
  ret i8* %9, !dbg !3487
}

declare dso_local i8* @pvTimerGetTimerID(%struct.tmrTimerControl*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTimerSetTimerIDImpl(%struct.tmrTimerControl* %xTimer, i8* %pvNewID) #0 section "privileged_functions" !dbg !3488 {
entry:
  %xTimer.addr = alloca %struct.tmrTimerControl*, align 8
  %pvNewID.addr = alloca i8*, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tmrTimerControl* %xTimer, %struct.tmrTimerControl** %xTimer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xTimer.addr, metadata !3491, metadata !DIExpression()), !dbg !3492
  store i8* %pvNewID, i8** %pvNewID.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvNewID.addr, metadata !3493, metadata !DIExpression()), !dbg !3494
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3495, metadata !DIExpression()), !dbg !3496
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3496
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3497, metadata !DIExpression()), !dbg !3498
  %0 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xTimer.addr, align 8, !dbg !3499
  %1 = ptrtoint %struct.tmrTimerControl* %0 to i32, !dbg !3500
  store i32 %1, i32* %lIndex, align 4, !dbg !3501
  %2 = load i32, i32* %lIndex, align 4, !dbg !3502
  %cmp = icmp sge i32 %2, 1, !dbg !3502
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3502

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3502
  %cmp1 = icmp slt i32 %3, 257, !dbg !3502
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3504
  %land.ext = zext i1 %4 to i32, !dbg !3502
  %conv = sext i32 %land.ext to i64, !dbg !3502
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3505
  br i1 %cmp2, label %if.then, label %if.end7, !dbg !3506

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3507
  %sub = sub nsw i32 %5, 1, !dbg !3507
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 5), !dbg !3507
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tmrTimerControl*, !dbg !3507
  store %struct.tmrTimerControl* %6, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3509
  %7 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3510
  %cmp4 = icmp ne %struct.tmrTimerControl* %7, null, !dbg !3512
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3513

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3514
  %9 = load i8*, i8** %pvNewID.addr, align 8, !dbg !3516
  call void @vTimerSetTimerID(%struct.tmrTimerControl* %8, i8* %9), !dbg !3517
  br label %if.end, !dbg !3518

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end7, !dbg !3519

if.end7:                                          ; preds = %if.end, %land.end
  ret void, !dbg !3520
}

declare dso_local void @vTimerSetTimerID(%struct.tmrTimerControl*, i8*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTimerIsTimerActiveImpl(%struct.tmrTimerControl* %xTimer) #0 section "privileged_functions" !dbg !3521 {
entry:
  %xTimer.addr = alloca %struct.tmrTimerControl*, align 8
  %xReturn = alloca i64, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tmrTimerControl* %xTimer, %struct.tmrTimerControl** %xTimer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xTimer.addr, metadata !3524, metadata !DIExpression()), !dbg !3525
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3526, metadata !DIExpression()), !dbg !3527
  store i64 0, i64* %xReturn, align 8, !dbg !3527
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3528, metadata !DIExpression()), !dbg !3529
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3529
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3530, metadata !DIExpression()), !dbg !3531
  %0 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xTimer.addr, align 8, !dbg !3532
  %1 = ptrtoint %struct.tmrTimerControl* %0 to i32, !dbg !3533
  store i32 %1, i32* %lIndex, align 4, !dbg !3534
  %2 = load i32, i32* %lIndex, align 4, !dbg !3535
  %cmp = icmp sge i32 %2, 1, !dbg !3535
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3535

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3535
  %cmp1 = icmp slt i32 %3, 257, !dbg !3535
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3537
  %land.ext = zext i1 %4 to i32, !dbg !3535
  %conv = sext i32 %land.ext to i64, !dbg !3535
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3538
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3539

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3540
  %sub = sub nsw i32 %5, 1, !dbg !3540
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 5), !dbg !3540
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tmrTimerControl*, !dbg !3540
  store %struct.tmrTimerControl* %6, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3542
  %7 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3543
  %cmp4 = icmp ne %struct.tmrTimerControl* %7, null, !dbg !3545
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3546

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3547
  %call7 = call i64 @xTimerIsTimerActive(%struct.tmrTimerControl* %8), !dbg !3549
  store i64 %call7, i64* %xReturn, align 8, !dbg !3550
  br label %if.end, !dbg !3551

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3552

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !3553
  ret i64 %9, !dbg !3554
}

declare dso_local i64 @xTimerIsTimerActive(%struct.tmrTimerControl*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.tskTaskControlBlock* @MPU_xTimerGetTimerDaemonTaskHandleImpl() #0 section "privileged_functions" !dbg !3555 {
entry:
  %xReturn = alloca %struct.tskTaskControlBlock*, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xReturn, metadata !3556, metadata !DIExpression()), !dbg !3557
  %call = call %struct.tskTaskControlBlock* @xTimerGetTimerDaemonTaskHandle(), !dbg !3558
  store %struct.tskTaskControlBlock* %call, %struct.tskTaskControlBlock** %xReturn, align 8, !dbg !3559
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xReturn, align 8, !dbg !3560
  ret %struct.tskTaskControlBlock* %0, !dbg !3561
}

declare dso_local %struct.tskTaskControlBlock* @xTimerGetTimerDaemonTaskHandle() #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTimerGenericCommandImpl(%struct.tmrTimerControl* %xTimer, i64 %xCommandID, i64 %xOptionalValue, i64* %pxHigherPriorityTaskWoken, i64 %xTicksToWait) #0 section "privileged_functions" !dbg !3562 {
entry:
  %xTimer.addr = alloca %struct.tmrTimerControl*, align 8
  %xCommandID.addr = alloca i64, align 8
  %xOptionalValue.addr = alloca i64, align 8
  %pxHigherPriorityTaskWoken.addr = alloca i64*, align 8
  %xTicksToWait.addr = alloca i64, align 8
  %xReturn = alloca i64, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  %xIsHigherPriorityTaskWokenWriteable = alloca i64, align 8
  store %struct.tmrTimerControl* %xTimer, %struct.tmrTimerControl** %xTimer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xTimer.addr, metadata !3566, metadata !DIExpression()), !dbg !3567
  store i64 %xCommandID, i64* %xCommandID.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xCommandID.addr, metadata !3568, metadata !DIExpression()), !dbg !3569
  store i64 %xOptionalValue, i64* %xOptionalValue.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xOptionalValue.addr, metadata !3570, metadata !DIExpression()), !dbg !3571
  store i64* %pxHigherPriorityTaskWoken, i64** %pxHigherPriorityTaskWoken.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxHigherPriorityTaskWoken.addr, metadata !3572, metadata !DIExpression()), !dbg !3573
  store i64 %xTicksToWait, i64* %xTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToWait.addr, metadata !3574, metadata !DIExpression()), !dbg !3575
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3576, metadata !DIExpression()), !dbg !3577
  store i64 0, i64* %xReturn, align 8, !dbg !3577
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3578, metadata !DIExpression()), !dbg !3579
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3579
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3580, metadata !DIExpression()), !dbg !3581
  call void @llvm.dbg.declare(metadata i64* %xIsHigherPriorityTaskWokenWriteable, metadata !3582, metadata !DIExpression()), !dbg !3583
  store i64 0, i64* %xIsHigherPriorityTaskWokenWriteable, align 8, !dbg !3583
  %0 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !3584
  %cmp = icmp ne i64* %0, null, !dbg !3586
  br i1 %cmp, label %if.then, label %if.end, !dbg !3587

if.then:                                          ; preds = %entry
  %1 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !3588
  %2 = bitcast i64* %1 to i8*, !dbg !3588
  %call = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %2, i32 8, i32 2), !dbg !3590
  store i64 %call, i64* %xIsHigherPriorityTaskWokenWriteable, align 8, !dbg !3591
  br label %if.end, !dbg !3592

if.end:                                           ; preds = %if.then, %entry
  %3 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !3593
  %cmp1 = icmp eq i64* %3, null, !dbg !3595
  br i1 %cmp1, label %if.then3, label %lor.lhs.false, !dbg !3596

lor.lhs.false:                                    ; preds = %if.end
  %4 = load i64, i64* %xIsHigherPriorityTaskWokenWriteable, align 8, !dbg !3597
  %cmp2 = icmp eq i64 %4, 1, !dbg !3598
  br i1 %cmp2, label %if.then3, label %if.end16, !dbg !3599

if.then3:                                         ; preds = %lor.lhs.false, %if.end
  %5 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xTimer.addr, align 8, !dbg !3600
  %6 = ptrtoint %struct.tmrTimerControl* %5 to i32, !dbg !3602
  store i32 %6, i32* %lIndex, align 4, !dbg !3603
  %7 = load i32, i32* %lIndex, align 4, !dbg !3604
  %cmp4 = icmp sge i32 %7, 1, !dbg !3604
  br i1 %cmp4, label %land.rhs, label %land.end, !dbg !3604

land.rhs:                                         ; preds = %if.then3
  %8 = load i32, i32* %lIndex, align 4, !dbg !3604
  %cmp5 = icmp slt i32 %8, 257, !dbg !3604
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.then3
  %9 = phi i1 [ false, %if.then3 ], [ %cmp5, %land.rhs ], !dbg !3606
  %land.ext = zext i1 %9 to i32, !dbg !3604
  %conv = sext i32 %land.ext to i64, !dbg !3604
  %cmp6 = icmp ne i64 %conv, 0, !dbg !3607
  br i1 %cmp6, label %if.then8, label %if.end15, !dbg !3608

if.then8:                                         ; preds = %land.end
  %10 = load i32, i32* %lIndex, align 4, !dbg !3609
  %sub = sub nsw i32 %10, 1, !dbg !3609
  %call9 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 5), !dbg !3609
  %11 = bitcast %struct.OpaqueObject* %call9 to %struct.tmrTimerControl*, !dbg !3609
  store %struct.tmrTimerControl* %11, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3611
  %12 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3612
  %cmp10 = icmp ne %struct.tmrTimerControl* %12, null, !dbg !3614
  br i1 %cmp10, label %if.then12, label %if.end14, !dbg !3615

if.then12:                                        ; preds = %if.then8
  %13 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3616
  %14 = load i64, i64* %xCommandID.addr, align 8, !dbg !3618
  %15 = load i64, i64* %xOptionalValue.addr, align 8, !dbg !3619
  %16 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !3620
  %17 = load i64, i64* %xTicksToWait.addr, align 8, !dbg !3621
  %call13 = call i64 @xTimerGenericCommand(%struct.tmrTimerControl* %13, i64 %14, i64 %15, i64* %16, i64 %17), !dbg !3622
  store i64 %call13, i64* %xReturn, align 8, !dbg !3623
  br label %if.end14, !dbg !3624

if.end14:                                         ; preds = %if.then12, %if.then8
  br label %if.end15, !dbg !3625

if.end15:                                         ; preds = %if.end14, %land.end
  br label %if.end16, !dbg !3626

if.end16:                                         ; preds = %if.end15, %lor.lhs.false
  %18 = load i64, i64* %xReturn, align 8, !dbg !3627
  ret i64 %18, !dbg !3628
}

declare dso_local i64 @xTimerGenericCommand(%struct.tmrTimerControl*, i64, i64, i64*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @MPU_pcTimerGetNameImpl(%struct.tmrTimerControl* %xTimer) #0 section "privileged_functions" !dbg !3629 {
entry:
  %xTimer.addr = alloca %struct.tmrTimerControl*, align 8
  %pcReturn = alloca i8*, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tmrTimerControl* %xTimer, %struct.tmrTimerControl** %xTimer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xTimer.addr, metadata !3632, metadata !DIExpression()), !dbg !3633
  call void @llvm.dbg.declare(metadata i8** %pcReturn, metadata !3634, metadata !DIExpression()), !dbg !3635
  store i8* null, i8** %pcReturn, align 8, !dbg !3635
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3636, metadata !DIExpression()), !dbg !3637
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3637
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3638, metadata !DIExpression()), !dbg !3639
  %0 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xTimer.addr, align 8, !dbg !3640
  %1 = ptrtoint %struct.tmrTimerControl* %0 to i32, !dbg !3641
  store i32 %1, i32* %lIndex, align 4, !dbg !3642
  %2 = load i32, i32* %lIndex, align 4, !dbg !3643
  %cmp = icmp sge i32 %2, 1, !dbg !3643
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3643

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3643
  %cmp1 = icmp slt i32 %3, 257, !dbg !3643
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3645
  %land.ext = zext i1 %4 to i32, !dbg !3643
  %conv = sext i32 %land.ext to i64, !dbg !3643
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3646
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3647

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3648
  %sub = sub nsw i32 %5, 1, !dbg !3648
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 5), !dbg !3648
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tmrTimerControl*, !dbg !3648
  store %struct.tmrTimerControl* %6, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3650
  %7 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3651
  %cmp4 = icmp ne %struct.tmrTimerControl* %7, null, !dbg !3653
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3654

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3655
  %call7 = call i8* @pcTimerGetName(%struct.tmrTimerControl* %8), !dbg !3657
  store i8* %call7, i8** %pcReturn, align 8, !dbg !3658
  br label %if.end, !dbg !3659

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3660

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i8*, i8** %pcReturn, align 8, !dbg !3661
  ret i8* %9, !dbg !3662
}

declare dso_local i8* @pcTimerGetName(%struct.tmrTimerControl*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTimerSetReloadModeImpl(%struct.tmrTimerControl* %xTimer, i64 %uxAutoReload) #0 section "privileged_functions" !dbg !3663 {
entry:
  %xTimer.addr = alloca %struct.tmrTimerControl*, align 8
  %uxAutoReload.addr = alloca i64, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tmrTimerControl* %xTimer, %struct.tmrTimerControl** %xTimer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xTimer.addr, metadata !3666, metadata !DIExpression()), !dbg !3667
  store i64 %uxAutoReload, i64* %uxAutoReload.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxAutoReload.addr, metadata !3668, metadata !DIExpression()), !dbg !3669
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3670, metadata !DIExpression()), !dbg !3671
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3671
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3672, metadata !DIExpression()), !dbg !3673
  %0 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xTimer.addr, align 8, !dbg !3674
  %1 = ptrtoint %struct.tmrTimerControl* %0 to i32, !dbg !3675
  store i32 %1, i32* %lIndex, align 4, !dbg !3676
  %2 = load i32, i32* %lIndex, align 4, !dbg !3677
  %cmp = icmp sge i32 %2, 1, !dbg !3677
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3677

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3677
  %cmp1 = icmp slt i32 %3, 257, !dbg !3677
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3679
  %land.ext = zext i1 %4 to i32, !dbg !3677
  %conv = sext i32 %land.ext to i64, !dbg !3677
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3680
  br i1 %cmp2, label %if.then, label %if.end7, !dbg !3681

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3682
  %sub = sub nsw i32 %5, 1, !dbg !3682
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 5), !dbg !3682
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tmrTimerControl*, !dbg !3682
  store %struct.tmrTimerControl* %6, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3684
  %7 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3685
  %cmp4 = icmp ne %struct.tmrTimerControl* %7, null, !dbg !3687
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3688

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3689
  %9 = load i64, i64* %uxAutoReload.addr, align 8, !dbg !3691
  call void @vTimerSetReloadMode(%struct.tmrTimerControl* %8, i64 %9), !dbg !3692
  br label %if.end, !dbg !3693

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end7, !dbg !3694

if.end7:                                          ; preds = %if.end, %land.end
  ret void, !dbg !3695
}

declare dso_local void @vTimerSetReloadMode(%struct.tmrTimerControl*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTimerGetReloadModeImpl(%struct.tmrTimerControl* %xTimer) #0 section "privileged_functions" !dbg !3696 {
entry:
  %xTimer.addr = alloca %struct.tmrTimerControl*, align 8
  %xReturn = alloca i64, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tmrTimerControl* %xTimer, %struct.tmrTimerControl** %xTimer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xTimer.addr, metadata !3697, metadata !DIExpression()), !dbg !3698
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3699, metadata !DIExpression()), !dbg !3700
  store i64 0, i64* %xReturn, align 8, !dbg !3700
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3701, metadata !DIExpression()), !dbg !3702
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3702
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3703, metadata !DIExpression()), !dbg !3704
  %0 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xTimer.addr, align 8, !dbg !3705
  %1 = ptrtoint %struct.tmrTimerControl* %0 to i32, !dbg !3706
  store i32 %1, i32* %lIndex, align 4, !dbg !3707
  %2 = load i32, i32* %lIndex, align 4, !dbg !3708
  %cmp = icmp sge i32 %2, 1, !dbg !3708
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3708

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3708
  %cmp1 = icmp slt i32 %3, 257, !dbg !3708
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3710
  %land.ext = zext i1 %4 to i32, !dbg !3708
  %conv = sext i32 %land.ext to i64, !dbg !3708
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3711
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3712

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3713
  %sub = sub nsw i32 %5, 1, !dbg !3713
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 5), !dbg !3713
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tmrTimerControl*, !dbg !3713
  store %struct.tmrTimerControl* %6, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3715
  %7 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3716
  %cmp4 = icmp ne %struct.tmrTimerControl* %7, null, !dbg !3718
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3719

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3720
  %call7 = call i64 @xTimerGetReloadMode(%struct.tmrTimerControl* %8), !dbg !3722
  store i64 %call7, i64* %xReturn, align 8, !dbg !3723
  br label %if.end, !dbg !3724

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3725

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !3726
  ret i64 %9, !dbg !3727
}

declare dso_local i64 @xTimerGetReloadMode(%struct.tmrTimerControl*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_uxTimerGetReloadModeImpl(%struct.tmrTimerControl* %xTimer) #0 section "privileged_functions" !dbg !3728 {
entry:
  %xTimer.addr = alloca %struct.tmrTimerControl*, align 8
  %uxReturn = alloca i64, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tmrTimerControl* %xTimer, %struct.tmrTimerControl** %xTimer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xTimer.addr, metadata !3731, metadata !DIExpression()), !dbg !3732
  call void @llvm.dbg.declare(metadata i64* %uxReturn, metadata !3733, metadata !DIExpression()), !dbg !3734
  store i64 0, i64* %uxReturn, align 8, !dbg !3734
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3735, metadata !DIExpression()), !dbg !3736
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3736
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3737, metadata !DIExpression()), !dbg !3738
  %0 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xTimer.addr, align 8, !dbg !3739
  %1 = ptrtoint %struct.tmrTimerControl* %0 to i32, !dbg !3740
  store i32 %1, i32* %lIndex, align 4, !dbg !3741
  %2 = load i32, i32* %lIndex, align 4, !dbg !3742
  %cmp = icmp sge i32 %2, 1, !dbg !3742
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3742

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3742
  %cmp1 = icmp slt i32 %3, 257, !dbg !3742
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3744
  %land.ext = zext i1 %4 to i32, !dbg !3742
  %conv = sext i32 %land.ext to i64, !dbg !3742
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3745
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3746

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3747
  %sub = sub nsw i32 %5, 1, !dbg !3747
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 5), !dbg !3747
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tmrTimerControl*, !dbg !3747
  store %struct.tmrTimerControl* %6, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3749
  %7 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3750
  %cmp4 = icmp ne %struct.tmrTimerControl* %7, null, !dbg !3752
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3753

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3754
  %call7 = call i64 @uxTimerGetReloadMode(%struct.tmrTimerControl* %8), !dbg !3756
  store i64 %call7, i64* %uxReturn, align 8, !dbg !3757
  br label %if.end, !dbg !3758

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3759

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %uxReturn, align 8, !dbg !3760
  ret i64 %9, !dbg !3761
}

declare dso_local i64 @uxTimerGetReloadMode(%struct.tmrTimerControl*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTimerGetPeriodImpl(%struct.tmrTimerControl* %xTimer) #0 section "privileged_functions" !dbg !3762 {
entry:
  %xTimer.addr = alloca %struct.tmrTimerControl*, align 8
  %xReturn = alloca i64, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tmrTimerControl* %xTimer, %struct.tmrTimerControl** %xTimer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xTimer.addr, metadata !3765, metadata !DIExpression()), !dbg !3766
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3767, metadata !DIExpression()), !dbg !3768
  store i64 0, i64* %xReturn, align 8, !dbg !3768
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3769, metadata !DIExpression()), !dbg !3770
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3770
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3771, metadata !DIExpression()), !dbg !3772
  %0 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xTimer.addr, align 8, !dbg !3773
  %1 = ptrtoint %struct.tmrTimerControl* %0 to i32, !dbg !3774
  store i32 %1, i32* %lIndex, align 4, !dbg !3775
  %2 = load i32, i32* %lIndex, align 4, !dbg !3776
  %cmp = icmp sge i32 %2, 1, !dbg !3776
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3776

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3776
  %cmp1 = icmp slt i32 %3, 257, !dbg !3776
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3778
  %land.ext = zext i1 %4 to i32, !dbg !3776
  %conv = sext i32 %land.ext to i64, !dbg !3776
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3779
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3780

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3781
  %sub = sub nsw i32 %5, 1, !dbg !3781
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 5), !dbg !3781
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tmrTimerControl*, !dbg !3781
  store %struct.tmrTimerControl* %6, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3783
  %7 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3784
  %cmp4 = icmp ne %struct.tmrTimerControl* %7, null, !dbg !3786
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3787

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3788
  %call7 = call i64 @xTimerGetPeriod(%struct.tmrTimerControl* %8), !dbg !3790
  store i64 %call7, i64* %xReturn, align 8, !dbg !3791
  br label %if.end, !dbg !3792

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3793

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !3794
  ret i64 %9, !dbg !3795
}

declare dso_local i64 @xTimerGetPeriod(%struct.tmrTimerControl*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTimerGetExpiryTimeImpl(%struct.tmrTimerControl* %xTimer) #0 section "privileged_functions" !dbg !3796 {
entry:
  %xTimer.addr = alloca %struct.tmrTimerControl*, align 8
  %xReturn = alloca i64, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tmrTimerControl* %xTimer, %struct.tmrTimerControl** %xTimer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xTimer.addr, metadata !3797, metadata !DIExpression()), !dbg !3798
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3799, metadata !DIExpression()), !dbg !3800
  store i64 0, i64* %xReturn, align 8, !dbg !3800
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3801, metadata !DIExpression()), !dbg !3802
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3802
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3803, metadata !DIExpression()), !dbg !3804
  %0 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xTimer.addr, align 8, !dbg !3805
  %1 = ptrtoint %struct.tmrTimerControl* %0 to i32, !dbg !3806
  store i32 %1, i32* %lIndex, align 4, !dbg !3807
  %2 = load i32, i32* %lIndex, align 4, !dbg !3808
  %cmp = icmp sge i32 %2, 1, !dbg !3808
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3808

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3808
  %cmp1 = icmp slt i32 %3, 257, !dbg !3808
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3810
  %land.ext = zext i1 %4 to i32, !dbg !3808
  %conv = sext i32 %land.ext to i64, !dbg !3808
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3811
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3812

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3813
  %sub = sub nsw i32 %5, 1, !dbg !3813
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 5), !dbg !3813
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tmrTimerControl*, !dbg !3813
  store %struct.tmrTimerControl* %6, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3815
  %7 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3816
  %cmp4 = icmp ne %struct.tmrTimerControl* %7, null, !dbg !3818
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3819

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3820
  %call7 = call i64 @xTimerGetExpiryTime(%struct.tmrTimerControl* %8), !dbg !3822
  store i64 %call7, i64* %xReturn, align 8, !dbg !3823
  br label %if.end, !dbg !3824

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3825

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !3826
  ret i64 %9, !dbg !3827
}

declare dso_local i64 @xTimerGetExpiryTime(%struct.tmrTimerControl*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.tmrTimerControl* @MPU_xTimerCreate(i8* %pcTimerName, i64 %xTimerPeriodInTicks, i64 %uxAutoReload, i8* %pvTimerID, void (%struct.tmrTimerControl*)* %pxCallbackFunction) #0 section "privileged_functions" !dbg !3828 {
entry:
  %pcTimerName.addr = alloca i8*, align 8
  %xTimerPeriodInTicks.addr = alloca i64, align 8
  %uxAutoReload.addr = alloca i64, align 8
  %pvTimerID.addr = alloca i8*, align 8
  %pxCallbackFunction.addr = alloca void (%struct.tmrTimerControl*)*, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %xExternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  store i8* %pcTimerName, i8** %pcTimerName.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pcTimerName.addr, metadata !3831, metadata !DIExpression()), !dbg !3832
  store i64 %xTimerPeriodInTicks, i64* %xTimerPeriodInTicks.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTimerPeriodInTicks.addr, metadata !3833, metadata !DIExpression()), !dbg !3834
  store i64 %uxAutoReload, i64* %uxAutoReload.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxAutoReload.addr, metadata !3835, metadata !DIExpression()), !dbg !3836
  store i8* %pvTimerID, i8** %pvTimerID.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvTimerID.addr, metadata !3837, metadata !DIExpression()), !dbg !3838
  store void (%struct.tmrTimerControl*)* %pxCallbackFunction, void (%struct.tmrTimerControl*)** %pxCallbackFunction.addr, align 8
  call void @llvm.dbg.declare(metadata void (%struct.tmrTimerControl*)** %pxCallbackFunction.addr, metadata !3839, metadata !DIExpression()), !dbg !3840
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3841, metadata !DIExpression()), !dbg !3842
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3842
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xExternalTimerHandle, metadata !3843, metadata !DIExpression()), !dbg !3844
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xExternalTimerHandle, align 8, !dbg !3844
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3845, metadata !DIExpression()), !dbg !3846
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !3847
  store i32 %call, i32* %lIndex, align 4, !dbg !3848
  %0 = load i32, i32* %lIndex, align 4, !dbg !3849
  %cmp = icmp ne i32 %0, -1, !dbg !3851
  br i1 %cmp, label %if.then, label %if.end4, !dbg !3852

if.then:                                          ; preds = %entry
  %1 = load i8*, i8** %pcTimerName.addr, align 8, !dbg !3853
  %2 = load i64, i64* %xTimerPeriodInTicks.addr, align 8, !dbg !3855
  %3 = load i64, i64* %uxAutoReload.addr, align 8, !dbg !3856
  %4 = load i8*, i8** %pvTimerID.addr, align 8, !dbg !3857
  %call1 = call %struct.tmrTimerControl* @xTimerCreate(i8* %1, i64 %2, i64 %3, i8* %4, void (%struct.tmrTimerControl*)* @MPU_TimerCallback), !dbg !3858
  store %struct.tmrTimerControl* %call1, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3859
  %5 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3860
  %cmp2 = icmp ne %struct.tmrTimerControl* %5, null, !dbg !3862
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !3863

if.then3:                                         ; preds = %if.then
  %6 = load i32, i32* %lIndex, align 4, !dbg !3864
  %7 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3864
  %8 = bitcast %struct.tmrTimerControl* %7 to %struct.OpaqueObject*, !dbg !3864
  %9 = load void (%struct.tmrTimerControl*)*, void (%struct.tmrTimerControl*)** %pxCallbackFunction.addr, align 8, !dbg !3864
  %10 = bitcast void (%struct.tmrTimerControl*)* %9 to i8*, !dbg !3864
  call void @MPU_StoreHandleAndDataAtIndex(i32 %6, %struct.OpaqueObject* %8, i8* %10, i32 5), !dbg !3864
  %11 = load i32, i32* %lIndex, align 4, !dbg !3866
  %add = add nsw i32 %11, 1, !dbg !3866
  %conv = sext i32 %add to i64, !dbg !3867
  %12 = inttoptr i64 %conv to %struct.tmrTimerControl*, !dbg !3867
  store %struct.tmrTimerControl* %12, %struct.tmrTimerControl** %xExternalTimerHandle, align 8, !dbg !3868
  br label %if.end, !dbg !3869

if.else:                                          ; preds = %if.then
  %13 = load i32, i32* %lIndex, align 4, !dbg !3870
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %13), !dbg !3872
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  br label %if.end4, !dbg !3873

if.end4:                                          ; preds = %if.end, %entry
  %14 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xExternalTimerHandle, align 8, !dbg !3874
  ret %struct.tmrTimerControl* %14, !dbg !3875
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @MPU_TimerCallback(%struct.tmrTimerControl* %xInternalHandle) #0 section "privileged_functions" !dbg !3876 {
entry:
  %xInternalHandle.addr = alloca %struct.tmrTimerControl*, align 8
  %i = alloca i32, align 4
  %lIndex = alloca i32, align 4
  %xExternalHandle = alloca %struct.tmrTimerControl*, align 8
  %pxApplicationCallBack = alloca void (%struct.tmrTimerControl*)*, align 8
  store %struct.tmrTimerControl* %xInternalHandle, %struct.tmrTimerControl** %xInternalHandle.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalHandle.addr, metadata !3877, metadata !DIExpression()), !dbg !3878
  call void @llvm.dbg.declare(metadata i32* %i, metadata !3879, metadata !DIExpression()), !dbg !3880
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3881, metadata !DIExpression()), !dbg !3882
  store i32 -1, i32* %lIndex, align 4, !dbg !3882
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xExternalHandle, metadata !3883, metadata !DIExpression()), !dbg !3884
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xExternalHandle, align 8, !dbg !3884
  call void @llvm.dbg.declare(metadata void (%struct.tmrTimerControl*)** %pxApplicationCallBack, metadata !3885, metadata !DIExpression()), !dbg !3886
  store void (%struct.tmrTimerControl*)* null, void (%struct.tmrTimerControl*)** %pxApplicationCallBack, align 8, !dbg !3886
  %0 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalHandle.addr, align 8, !dbg !3887
  %cmp = icmp ne %struct.tmrTimerControl* %0, null, !dbg !3887
  %conv = zext i1 %cmp to i32, !dbg !3887
  %cmp1 = icmp eq i32 %conv, 0, !dbg !3887
  br i1 %cmp1, label %if.then, label %if.end, !dbg !3889

if.then:                                          ; preds = %entry
  call void @vAssertCalled(i8* getelementptr inbounds ([68 x i8], [68 x i8]* @.str, i64 0, i64 0), i64 332), !dbg !3887
  br label %if.end, !dbg !3887

if.end:                                           ; preds = %if.then, %entry
  store i32 0, i32* %i, align 4, !dbg !3890
  br label %for.cond, !dbg !3892

for.cond:                                         ; preds = %for.inc, %if.end
  %1 = load i32, i32* %i, align 4, !dbg !3893
  %cmp3 = icmp slt i32 %1, 256, !dbg !3895
  br i1 %cmp3, label %for.body, label %for.end, !dbg !3896

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %i, align 4, !dbg !3897
  %idxprom = sext i32 %2 to i64, !dbg !3900
  %arrayidx = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom, !dbg !3900
  %xInternalObjectHandle = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx, i32 0, i32 0, !dbg !3901
  %3 = load %struct.OpaqueObject*, %struct.OpaqueObject** %xInternalObjectHandle, align 8, !dbg !3901
  %4 = bitcast %struct.OpaqueObject* %3 to %struct.tmrTimerControl*, !dbg !3902
  %5 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalHandle.addr, align 8, !dbg !3903
  %cmp5 = icmp eq %struct.tmrTimerControl* %4, %5, !dbg !3904
  br i1 %cmp5, label %land.lhs.true, label %if.end13, !dbg !3905

land.lhs.true:                                    ; preds = %for.body
  %6 = load i32, i32* %i, align 4, !dbg !3906
  %idxprom7 = sext i32 %6 to i64, !dbg !3907
  %arrayidx8 = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom7, !dbg !3907
  %ulKernelObjectType = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx8, i32 0, i32 1, !dbg !3908
  %7 = load i32, i32* %ulKernelObjectType, align 8, !dbg !3908
  %conv9 = zext i32 %7 to i64, !dbg !3907
  %cmp10 = icmp eq i64 %conv9, 5, !dbg !3909
  br i1 %cmp10, label %if.then12, label %if.end13, !dbg !3910

if.then12:                                        ; preds = %land.lhs.true
  %8 = load i32, i32* %i, align 4, !dbg !3911
  store i32 %8, i32* %lIndex, align 4, !dbg !3913
  br label %for.end, !dbg !3914

if.end13:                                         ; preds = %land.lhs.true, %for.body
  br label %for.inc, !dbg !3915

for.inc:                                          ; preds = %if.end13
  %9 = load i32, i32* %i, align 4, !dbg !3916
  %inc = add nsw i32 %9, 1, !dbg !3916
  store i32 %inc, i32* %i, align 4, !dbg !3916
  br label %for.cond, !dbg !3917, !llvm.loop !3918

for.end:                                          ; preds = %if.then12, %for.cond
  %10 = load i32, i32* %lIndex, align 4, !dbg !3920
  %cmp14 = icmp ne i32 %10, -1, !dbg !3920
  %conv15 = zext i1 %cmp14 to i32, !dbg !3920
  %cmp16 = icmp eq i32 %conv15, 0, !dbg !3920
  br i1 %cmp16, label %if.then18, label %if.end19, !dbg !3922

if.then18:                                        ; preds = %for.end
  call void @vAssertCalled(i8* getelementptr inbounds ([68 x i8], [68 x i8]* @.str, i64 0, i64 0), i64 344), !dbg !3920
  br label %if.end19, !dbg !3920

if.end19:                                         ; preds = %if.then18, %for.end
  %11 = load i32, i32* %lIndex, align 4, !dbg !3923
  %add = add nsw i32 %11, 1, !dbg !3923
  %conv20 = sext i32 %add to i64, !dbg !3924
  %12 = inttoptr i64 %conv20 to %struct.tmrTimerControl*, !dbg !3924
  store %struct.tmrTimerControl* %12, %struct.tmrTimerControl** %xExternalHandle, align 8, !dbg !3925
  %13 = load i32, i32* %lIndex, align 4, !dbg !3926
  %idxprom21 = sext i32 %13 to i64, !dbg !3927
  %arrayidx22 = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom21, !dbg !3927
  %pvKernelObjectData = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx22, i32 0, i32 2, !dbg !3928
  %14 = load i8*, i8** %pvKernelObjectData, align 8, !dbg !3928
  %15 = bitcast i8* %14 to void (%struct.tmrTimerControl*)*, !dbg !3929
  store void (%struct.tmrTimerControl*)* %15, void (%struct.tmrTimerControl*)** %pxApplicationCallBack, align 8, !dbg !3930
  %16 = load void (%struct.tmrTimerControl*)*, void (%struct.tmrTimerControl*)** %pxApplicationCallBack, align 8, !dbg !3931
  %17 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xExternalHandle, align 8, !dbg !3932
  call void %16(%struct.tmrTimerControl* %17), !dbg !3931
  ret void, !dbg !3933
}

declare dso_local %struct.tmrTimerControl* @xTimerCreate(i8*, i64, i64, i8*, void (%struct.tmrTimerControl*)*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.tmrTimerControl* @MPU_xTimerCreateStatic(i8* %pcTimerName, i64 %xTimerPeriodInTicks, i64 %uxAutoReload, i8* %pvTimerID, void (%struct.tmrTimerControl*)* %pxCallbackFunction, %struct.xSTATIC_TIMER* %pxTimerBuffer) #0 section "privileged_functions" !dbg !3934 {
entry:
  %pcTimerName.addr = alloca i8*, align 8
  %xTimerPeriodInTicks.addr = alloca i64, align 8
  %uxAutoReload.addr = alloca i64, align 8
  %pvTimerID.addr = alloca i8*, align 8
  %pxCallbackFunction.addr = alloca void (%struct.tmrTimerControl*)*, align 8
  %pxTimerBuffer.addr = alloca %struct.xSTATIC_TIMER*, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %xExternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  store i8* %pcTimerName, i8** %pcTimerName.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pcTimerName.addr, metadata !3948, metadata !DIExpression()), !dbg !3949
  store i64 %xTimerPeriodInTicks, i64* %xTimerPeriodInTicks.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTimerPeriodInTicks.addr, metadata !3950, metadata !DIExpression()), !dbg !3951
  store i64 %uxAutoReload, i64* %uxAutoReload.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxAutoReload.addr, metadata !3952, metadata !DIExpression()), !dbg !3953
  store i8* %pvTimerID, i8** %pvTimerID.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvTimerID.addr, metadata !3954, metadata !DIExpression()), !dbg !3955
  store void (%struct.tmrTimerControl*)* %pxCallbackFunction, void (%struct.tmrTimerControl*)** %pxCallbackFunction.addr, align 8
  call void @llvm.dbg.declare(metadata void (%struct.tmrTimerControl*)** %pxCallbackFunction.addr, metadata !3956, metadata !DIExpression()), !dbg !3957
  store %struct.xSTATIC_TIMER* %pxTimerBuffer, %struct.xSTATIC_TIMER** %pxTimerBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xSTATIC_TIMER** %pxTimerBuffer.addr, metadata !3958, metadata !DIExpression()), !dbg !3959
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3960, metadata !DIExpression()), !dbg !3961
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3961
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xExternalTimerHandle, metadata !3962, metadata !DIExpression()), !dbg !3963
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xExternalTimerHandle, align 8, !dbg !3963
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3964, metadata !DIExpression()), !dbg !3965
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !3966
  store i32 %call, i32* %lIndex, align 4, !dbg !3967
  %0 = load i32, i32* %lIndex, align 4, !dbg !3968
  %cmp = icmp ne i32 %0, -1, !dbg !3970
  br i1 %cmp, label %if.then, label %if.end4, !dbg !3971

if.then:                                          ; preds = %entry
  %1 = load i8*, i8** %pcTimerName.addr, align 8, !dbg !3972
  %2 = load i64, i64* %xTimerPeriodInTicks.addr, align 8, !dbg !3974
  %3 = load i64, i64* %uxAutoReload.addr, align 8, !dbg !3975
  %4 = load i8*, i8** %pvTimerID.addr, align 8, !dbg !3976
  %5 = load %struct.xSTATIC_TIMER*, %struct.xSTATIC_TIMER** %pxTimerBuffer.addr, align 8, !dbg !3977
  %call1 = call %struct.tmrTimerControl* @xTimerCreateStatic(i8* %1, i64 %2, i64 %3, i8* %4, void (%struct.tmrTimerControl*)* @MPU_TimerCallback, %struct.xSTATIC_TIMER* %5), !dbg !3978
  store %struct.tmrTimerControl* %call1, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3979
  %6 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3980
  %cmp2 = icmp ne %struct.tmrTimerControl* %6, null, !dbg !3982
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !3983

if.then3:                                         ; preds = %if.then
  %7 = load i32, i32* %lIndex, align 4, !dbg !3984
  %8 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3984
  %9 = bitcast %struct.tmrTimerControl* %8 to %struct.OpaqueObject*, !dbg !3984
  %10 = load void (%struct.tmrTimerControl*)*, void (%struct.tmrTimerControl*)** %pxCallbackFunction.addr, align 8, !dbg !3984
  %11 = bitcast void (%struct.tmrTimerControl*)* %10 to i8*, !dbg !3984
  call void @MPU_StoreHandleAndDataAtIndex(i32 %7, %struct.OpaqueObject* %9, i8* %11, i32 5), !dbg !3984
  %12 = load i32, i32* %lIndex, align 4, !dbg !3986
  %add = add nsw i32 %12, 1, !dbg !3986
  %conv = sext i32 %add to i64, !dbg !3987
  %13 = inttoptr i64 %conv to %struct.tmrTimerControl*, !dbg !3987
  store %struct.tmrTimerControl* %13, %struct.tmrTimerControl** %xExternalTimerHandle, align 8, !dbg !3988
  br label %if.end, !dbg !3989

if.else:                                          ; preds = %if.then
  %14 = load i32, i32* %lIndex, align 4, !dbg !3990
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %14), !dbg !3992
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  br label %if.end4, !dbg !3993

if.end4:                                          ; preds = %if.end, %entry
  %15 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xExternalTimerHandle, align 8, !dbg !3994
  ret %struct.tmrTimerControl* %15, !dbg !3995
}

declare dso_local %struct.tmrTimerControl* @xTimerCreateStatic(i8*, i64, i64, i8*, void (%struct.tmrTimerControl*)*, %struct.xSTATIC_TIMER*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTimerGetStaticBuffer(%struct.tmrTimerControl* %xTimer, %struct.xSTATIC_TIMER** %ppxTimerBuffer) #0 section "privileged_functions" !dbg !3996 {
entry:
  %xTimer.addr = alloca %struct.tmrTimerControl*, align 8
  %ppxTimerBuffer.addr = alloca %struct.xSTATIC_TIMER**, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  %xReturn = alloca i64, align 8
  store %struct.tmrTimerControl* %xTimer, %struct.tmrTimerControl** %xTimer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xTimer.addr, metadata !4000, metadata !DIExpression()), !dbg !4001
  store %struct.xSTATIC_TIMER** %ppxTimerBuffer, %struct.xSTATIC_TIMER*** %ppxTimerBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xSTATIC_TIMER*** %ppxTimerBuffer.addr, metadata !4002, metadata !DIExpression()), !dbg !4003
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !4004, metadata !DIExpression()), !dbg !4005
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !4005
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4006, metadata !DIExpression()), !dbg !4007
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4008, metadata !DIExpression()), !dbg !4009
  store i64 0, i64* %xReturn, align 8, !dbg !4009
  %0 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xTimer.addr, align 8, !dbg !4010
  %1 = ptrtoint %struct.tmrTimerControl* %0 to i32, !dbg !4011
  store i32 %1, i32* %lIndex, align 4, !dbg !4012
  %2 = load i32, i32* %lIndex, align 4, !dbg !4013
  %cmp = icmp sge i32 %2, 1, !dbg !4013
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4013

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4013
  %cmp1 = icmp slt i32 %3, 257, !dbg !4013
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4015
  %land.ext = zext i1 %4 to i32, !dbg !4013
  %conv = sext i32 %land.ext to i64, !dbg !4013
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4016
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4017

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4018
  %sub = sub nsw i32 %5, 1, !dbg !4018
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 5), !dbg !4018
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tmrTimerControl*, !dbg !4018
  store %struct.tmrTimerControl* %6, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !4020
  %7 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !4021
  %cmp4 = icmp ne %struct.tmrTimerControl* %7, null, !dbg !4023
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4024

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !4025
  %9 = load %struct.xSTATIC_TIMER**, %struct.xSTATIC_TIMER*** %ppxTimerBuffer.addr, align 8, !dbg !4027
  %call7 = call i64 @xTimerGetStaticBuffer(%struct.tmrTimerControl* %8, %struct.xSTATIC_TIMER** %9), !dbg !4028
  store i64 %call7, i64* %xReturn, align 8, !dbg !4029
  br label %if.end, !dbg !4030

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4031

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !4032
  ret i64 %10, !dbg !4033
}

declare dso_local i64 @xTimerGetStaticBuffer(%struct.tmrTimerControl*, %struct.xSTATIC_TIMER**) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xEventGroupWaitBitsImpl(%struct.EventGroupDef_t* %xEventGroup, i64 %uxBitsToWaitFor, i64 %xClearOnExit, i64 %xWaitForAllBits, i64 %xTicksToWait) #0 section "privileged_functions" !dbg !4034 {
entry:
  %xEventGroup.addr = alloca %struct.EventGroupDef_t*, align 8
  %uxBitsToWaitFor.addr = alloca i64, align 8
  %xClearOnExit.addr = alloca i64, align 8
  %xWaitForAllBits.addr = alloca i64, align 8
  %xTicksToWait.addr = alloca i64, align 8
  %xReturn = alloca i64, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.EventGroupDef_t* %xEventGroup, %struct.EventGroupDef_t** %xEventGroup.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xEventGroup.addr, metadata !4039, metadata !DIExpression()), !dbg !4040
  store i64 %uxBitsToWaitFor, i64* %uxBitsToWaitFor.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxBitsToWaitFor.addr, metadata !4041, metadata !DIExpression()), !dbg !4042
  store i64 %xClearOnExit, i64* %xClearOnExit.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xClearOnExit.addr, metadata !4043, metadata !DIExpression()), !dbg !4044
  store i64 %xWaitForAllBits, i64* %xWaitForAllBits.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xWaitForAllBits.addr, metadata !4045, metadata !DIExpression()), !dbg !4046
  store i64 %xTicksToWait, i64* %xTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToWait.addr, metadata !4047, metadata !DIExpression()), !dbg !4048
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4049, metadata !DIExpression()), !dbg !4050
  store i64 0, i64* %xReturn, align 8, !dbg !4050
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4051, metadata !DIExpression()), !dbg !4052
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4052
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4053, metadata !DIExpression()), !dbg !4054
  %0 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xEventGroup.addr, align 8, !dbg !4055
  %1 = ptrtoint %struct.EventGroupDef_t* %0 to i32, !dbg !4056
  store i32 %1, i32* %lIndex, align 4, !dbg !4057
  %2 = load i32, i32* %lIndex, align 4, !dbg !4058
  %cmp = icmp sge i32 %2, 1, !dbg !4058
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4058

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4058
  %cmp1 = icmp slt i32 %3, 257, !dbg !4058
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4060
  %land.ext = zext i1 %4 to i32, !dbg !4058
  %conv = sext i32 %land.ext to i64, !dbg !4058
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4061
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4062

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4063
  %sub = sub nsw i32 %5, 1, !dbg !4063
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 4), !dbg !4063
  %6 = bitcast %struct.OpaqueObject* %call to %struct.EventGroupDef_t*, !dbg !4063
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4065
  %7 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4066
  %cmp4 = icmp ne %struct.EventGroupDef_t* %7, null, !dbg !4068
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4069

if.then6:                                         ; preds = %if.then
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4070
  %9 = load i64, i64* %uxBitsToWaitFor.addr, align 8, !dbg !4072
  %10 = load i64, i64* %xClearOnExit.addr, align 8, !dbg !4073
  %11 = load i64, i64* %xWaitForAllBits.addr, align 8, !dbg !4074
  %12 = load i64, i64* %xTicksToWait.addr, align 8, !dbg !4075
  %call7 = call i64 @xEventGroupWaitBits(%struct.EventGroupDef_t* %8, i64 %9, i64 %10, i64 %11, i64 %12), !dbg !4076
  store i64 %call7, i64* %xReturn, align 8, !dbg !4077
  br label %if.end, !dbg !4078

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4079

if.end8:                                          ; preds = %if.end, %land.end
  %13 = load i64, i64* %xReturn, align 8, !dbg !4080
  ret i64 %13, !dbg !4081
}

declare dso_local i64 @xEventGroupWaitBits(%struct.EventGroupDef_t*, i64, i64, i64, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xEventGroupClearBitsImpl(%struct.EventGroupDef_t* %xEventGroup, i64 %uxBitsToClear) #0 section "privileged_functions" !dbg !4082 {
entry:
  %xEventGroup.addr = alloca %struct.EventGroupDef_t*, align 8
  %uxBitsToClear.addr = alloca i64, align 8
  %xReturn = alloca i64, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.EventGroupDef_t* %xEventGroup, %struct.EventGroupDef_t** %xEventGroup.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xEventGroup.addr, metadata !4085, metadata !DIExpression()), !dbg !4086
  store i64 %uxBitsToClear, i64* %uxBitsToClear.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxBitsToClear.addr, metadata !4087, metadata !DIExpression()), !dbg !4088
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4089, metadata !DIExpression()), !dbg !4090
  store i64 0, i64* %xReturn, align 8, !dbg !4090
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4091, metadata !DIExpression()), !dbg !4092
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4092
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4093, metadata !DIExpression()), !dbg !4094
  %0 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xEventGroup.addr, align 8, !dbg !4095
  %1 = ptrtoint %struct.EventGroupDef_t* %0 to i32, !dbg !4096
  store i32 %1, i32* %lIndex, align 4, !dbg !4097
  %2 = load i32, i32* %lIndex, align 4, !dbg !4098
  %cmp = icmp sge i32 %2, 1, !dbg !4098
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4098

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4098
  %cmp1 = icmp slt i32 %3, 257, !dbg !4098
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4100
  %land.ext = zext i1 %4 to i32, !dbg !4098
  %conv = sext i32 %land.ext to i64, !dbg !4098
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4101
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4102

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4103
  %sub = sub nsw i32 %5, 1, !dbg !4103
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 4), !dbg !4103
  %6 = bitcast %struct.OpaqueObject* %call to %struct.EventGroupDef_t*, !dbg !4103
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4105
  %7 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4106
  %cmp4 = icmp ne %struct.EventGroupDef_t* %7, null, !dbg !4108
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4109

if.then6:                                         ; preds = %if.then
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4110
  %9 = load i64, i64* %uxBitsToClear.addr, align 8, !dbg !4112
  %call7 = call i64 @xEventGroupClearBits(%struct.EventGroupDef_t* %8, i64 %9), !dbg !4113
  store i64 %call7, i64* %xReturn, align 8, !dbg !4114
  br label %if.end, !dbg !4115

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4116

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !4117
  ret i64 %10, !dbg !4118
}

declare dso_local i64 @xEventGroupClearBits(%struct.EventGroupDef_t*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xEventGroupSetBitsImpl(%struct.EventGroupDef_t* %xEventGroup, i64 %uxBitsToSet) #0 section "privileged_functions" !dbg !4119 {
entry:
  %xEventGroup.addr = alloca %struct.EventGroupDef_t*, align 8
  %uxBitsToSet.addr = alloca i64, align 8
  %xReturn = alloca i64, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.EventGroupDef_t* %xEventGroup, %struct.EventGroupDef_t** %xEventGroup.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xEventGroup.addr, metadata !4120, metadata !DIExpression()), !dbg !4121
  store i64 %uxBitsToSet, i64* %uxBitsToSet.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxBitsToSet.addr, metadata !4122, metadata !DIExpression()), !dbg !4123
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4124, metadata !DIExpression()), !dbg !4125
  store i64 0, i64* %xReturn, align 8, !dbg !4125
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4126, metadata !DIExpression()), !dbg !4127
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4127
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4128, metadata !DIExpression()), !dbg !4129
  %0 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xEventGroup.addr, align 8, !dbg !4130
  %1 = ptrtoint %struct.EventGroupDef_t* %0 to i32, !dbg !4131
  store i32 %1, i32* %lIndex, align 4, !dbg !4132
  %2 = load i32, i32* %lIndex, align 4, !dbg !4133
  %cmp = icmp sge i32 %2, 1, !dbg !4133
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4133

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4133
  %cmp1 = icmp slt i32 %3, 257, !dbg !4133
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4135
  %land.ext = zext i1 %4 to i32, !dbg !4133
  %conv = sext i32 %land.ext to i64, !dbg !4133
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4136
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4137

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4138
  %sub = sub nsw i32 %5, 1, !dbg !4138
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 4), !dbg !4138
  %6 = bitcast %struct.OpaqueObject* %call to %struct.EventGroupDef_t*, !dbg !4138
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4140
  %7 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4141
  %cmp4 = icmp ne %struct.EventGroupDef_t* %7, null, !dbg !4143
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4144

if.then6:                                         ; preds = %if.then
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4145
  %9 = load i64, i64* %uxBitsToSet.addr, align 8, !dbg !4147
  %call7 = call i64 @xEventGroupSetBits(%struct.EventGroupDef_t* %8, i64 %9), !dbg !4148
  store i64 %call7, i64* %xReturn, align 8, !dbg !4149
  br label %if.end, !dbg !4150

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4151

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !4152
  ret i64 %10, !dbg !4153
}

declare dso_local i64 @xEventGroupSetBits(%struct.EventGroupDef_t*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xEventGroupSyncImpl(%struct.EventGroupDef_t* %xEventGroup, i64 %uxBitsToSet, i64 %uxBitsToWaitFor, i64 %xTicksToWait) #0 section "privileged_functions" !dbg !4154 {
entry:
  %xEventGroup.addr = alloca %struct.EventGroupDef_t*, align 8
  %uxBitsToSet.addr = alloca i64, align 8
  %uxBitsToWaitFor.addr = alloca i64, align 8
  %xTicksToWait.addr = alloca i64, align 8
  %xReturn = alloca i64, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.EventGroupDef_t* %xEventGroup, %struct.EventGroupDef_t** %xEventGroup.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xEventGroup.addr, metadata !4157, metadata !DIExpression()), !dbg !4158
  store i64 %uxBitsToSet, i64* %uxBitsToSet.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxBitsToSet.addr, metadata !4159, metadata !DIExpression()), !dbg !4160
  store i64 %uxBitsToWaitFor, i64* %uxBitsToWaitFor.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxBitsToWaitFor.addr, metadata !4161, metadata !DIExpression()), !dbg !4162
  store i64 %xTicksToWait, i64* %xTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToWait.addr, metadata !4163, metadata !DIExpression()), !dbg !4164
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4165, metadata !DIExpression()), !dbg !4166
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4167, metadata !DIExpression()), !dbg !4168
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4168
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4169, metadata !DIExpression()), !dbg !4170
  %0 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xEventGroup.addr, align 8, !dbg !4171
  %1 = ptrtoint %struct.EventGroupDef_t* %0 to i32, !dbg !4172
  store i32 %1, i32* %lIndex, align 4, !dbg !4173
  %2 = load i32, i32* %lIndex, align 4, !dbg !4174
  %cmp = icmp sge i32 %2, 1, !dbg !4174
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4174

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4174
  %cmp1 = icmp slt i32 %3, 257, !dbg !4174
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4176
  %land.ext = zext i1 %4 to i32, !dbg !4174
  %conv = sext i32 %land.ext to i64, !dbg !4174
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4177
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4178

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4179
  %sub = sub nsw i32 %5, 1, !dbg !4179
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 4), !dbg !4179
  %6 = bitcast %struct.OpaqueObject* %call to %struct.EventGroupDef_t*, !dbg !4179
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4181
  %7 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4182
  %cmp4 = icmp ne %struct.EventGroupDef_t* %7, null, !dbg !4184
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4185

if.then6:                                         ; preds = %if.then
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4186
  %9 = load i64, i64* %uxBitsToSet.addr, align 8, !dbg !4188
  %10 = load i64, i64* %uxBitsToWaitFor.addr, align 8, !dbg !4189
  %11 = load i64, i64* %xTicksToWait.addr, align 8, !dbg !4190
  %call7 = call i64 @xEventGroupSync(%struct.EventGroupDef_t* %8, i64 %9, i64 %10, i64 %11), !dbg !4191
  store i64 %call7, i64* %xReturn, align 8, !dbg !4192
  br label %if.end, !dbg !4193

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4194

if.end8:                                          ; preds = %if.end, %land.end
  %12 = load i64, i64* %xReturn, align 8, !dbg !4195
  ret i64 %12, !dbg !4196
}

declare dso_local i64 @xEventGroupSync(%struct.EventGroupDef_t*, i64, i64, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_uxEventGroupGetNumberImpl(i8* %xEventGroup) #0 section "privileged_functions" !dbg !4197 {
entry:
  %xEventGroup.addr = alloca i8*, align 8
  %xReturn = alloca i64, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store i8* %xEventGroup, i8** %xEventGroup.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %xEventGroup.addr, metadata !4200, metadata !DIExpression()), !dbg !4201
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4202, metadata !DIExpression()), !dbg !4203
  store i64 0, i64* %xReturn, align 8, !dbg !4203
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4204, metadata !DIExpression()), !dbg !4205
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4205
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4206, metadata !DIExpression()), !dbg !4207
  %0 = load i8*, i8** %xEventGroup.addr, align 8, !dbg !4208
  %1 = ptrtoint i8* %0 to i32, !dbg !4209
  store i32 %1, i32* %lIndex, align 4, !dbg !4210
  %2 = load i32, i32* %lIndex, align 4, !dbg !4211
  %cmp = icmp sge i32 %2, 1, !dbg !4211
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4211

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4211
  %cmp1 = icmp slt i32 %3, 257, !dbg !4211
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4213
  %land.ext = zext i1 %4 to i32, !dbg !4211
  %conv = sext i32 %land.ext to i64, !dbg !4211
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4214
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4215

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4216
  %sub = sub nsw i32 %5, 1, !dbg !4216
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 4), !dbg !4216
  %6 = bitcast %struct.OpaqueObject* %call to %struct.EventGroupDef_t*, !dbg !4216
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4218
  %7 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4219
  %cmp4 = icmp ne %struct.EventGroupDef_t* %7, null, !dbg !4221
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4222

if.then6:                                         ; preds = %if.then
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4223
  %9 = bitcast %struct.EventGroupDef_t* %8 to i8*, !dbg !4223
  %call7 = call i64 @uxEventGroupGetNumber(i8* %9), !dbg !4225
  store i64 %call7, i64* %xReturn, align 8, !dbg !4226
  br label %if.end, !dbg !4227

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4228

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !4229
  ret i64 %10, !dbg !4230
}

declare dso_local i64 @uxEventGroupGetNumber(i8*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vEventGroupSetNumberImpl(i8* %xEventGroup, i64 %uxEventGroupNumber) #0 section "privileged_functions" !dbg !4231 {
entry:
  %xEventGroup.addr = alloca i8*, align 8
  %uxEventGroupNumber.addr = alloca i64, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store i8* %xEventGroup, i8** %xEventGroup.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %xEventGroup.addr, metadata !4234, metadata !DIExpression()), !dbg !4235
  store i64 %uxEventGroupNumber, i64* %uxEventGroupNumber.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxEventGroupNumber.addr, metadata !4236, metadata !DIExpression()), !dbg !4237
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4238, metadata !DIExpression()), !dbg !4239
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4239
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4240, metadata !DIExpression()), !dbg !4241
  %0 = load i8*, i8** %xEventGroup.addr, align 8, !dbg !4242
  %1 = ptrtoint i8* %0 to i32, !dbg !4243
  store i32 %1, i32* %lIndex, align 4, !dbg !4244
  %2 = load i32, i32* %lIndex, align 4, !dbg !4245
  %cmp = icmp sge i32 %2, 1, !dbg !4245
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4245

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4245
  %cmp1 = icmp slt i32 %3, 257, !dbg !4245
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4247
  %land.ext = zext i1 %4 to i32, !dbg !4245
  %conv = sext i32 %land.ext to i64, !dbg !4245
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4248
  br i1 %cmp2, label %if.then, label %if.end7, !dbg !4249

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4250
  %sub = sub nsw i32 %5, 1, !dbg !4250
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 4), !dbg !4250
  %6 = bitcast %struct.OpaqueObject* %call to %struct.EventGroupDef_t*, !dbg !4250
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4252
  %7 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4253
  %cmp4 = icmp ne %struct.EventGroupDef_t* %7, null, !dbg !4255
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4256

if.then6:                                         ; preds = %if.then
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4257
  %9 = bitcast %struct.EventGroupDef_t* %8 to i8*, !dbg !4257
  %10 = load i64, i64* %uxEventGroupNumber.addr, align 8, !dbg !4259
  call void @vEventGroupSetNumber(i8* %9, i64 %10), !dbg !4260
  br label %if.end, !dbg !4261

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end7, !dbg !4262

if.end7:                                          ; preds = %if.end, %land.end
  ret void, !dbg !4263
}

declare dso_local void @vEventGroupSetNumber(i8*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.EventGroupDef_t* @MPU_xEventGroupCreate() #0 section "privileged_functions" !dbg !4264 {
entry:
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %xExternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4267, metadata !DIExpression()), !dbg !4268
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4268
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xExternalEventGroupHandle, metadata !4269, metadata !DIExpression()), !dbg !4270
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xExternalEventGroupHandle, align 8, !dbg !4270
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4271, metadata !DIExpression()), !dbg !4272
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !4273
  store i32 %call, i32* %lIndex, align 4, !dbg !4274
  %0 = load i32, i32* %lIndex, align 4, !dbg !4275
  %cmp = icmp ne i32 %0, -1, !dbg !4277
  br i1 %cmp, label %if.then, label %if.end4, !dbg !4278

if.then:                                          ; preds = %entry
  %call1 = call %struct.EventGroupDef_t* @xEventGroupCreate(), !dbg !4279
  store %struct.EventGroupDef_t* %call1, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4281
  %1 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4282
  %cmp2 = icmp ne %struct.EventGroupDef_t* %1, null, !dbg !4284
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !4285

if.then3:                                         ; preds = %if.then
  %2 = load i32, i32* %lIndex, align 4, !dbg !4286
  %3 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4286
  %4 = bitcast %struct.EventGroupDef_t* %3 to %struct.OpaqueObject*, !dbg !4286
  call void @MPU_StoreHandleAndDataAtIndex(i32 %2, %struct.OpaqueObject* %4, i8* null, i32 4), !dbg !4286
  %5 = load i32, i32* %lIndex, align 4, !dbg !4288
  %add = add nsw i32 %5, 1, !dbg !4288
  %conv = sext i32 %add to i64, !dbg !4289
  %6 = inttoptr i64 %conv to %struct.EventGroupDef_t*, !dbg !4289
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xExternalEventGroupHandle, align 8, !dbg !4290
  br label %if.end, !dbg !4291

if.else:                                          ; preds = %if.then
  %7 = load i32, i32* %lIndex, align 4, !dbg !4292
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %7), !dbg !4294
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  br label %if.end4, !dbg !4295

if.end4:                                          ; preds = %if.end, %entry
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xExternalEventGroupHandle, align 8, !dbg !4296
  ret %struct.EventGroupDef_t* %8, !dbg !4297
}

declare dso_local %struct.EventGroupDef_t* @xEventGroupCreate() #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.EventGroupDef_t* @MPU_xEventGroupCreateStatic(%struct.xSTATIC_EVENT_GROUP* %pxEventGroupBuffer) #0 section "privileged_functions" !dbg !4298 {
entry:
  %pxEventGroupBuffer.addr = alloca %struct.xSTATIC_EVENT_GROUP*, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %xExternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.xSTATIC_EVENT_GROUP* %pxEventGroupBuffer, %struct.xSTATIC_EVENT_GROUP** %pxEventGroupBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xSTATIC_EVENT_GROUP** %pxEventGroupBuffer.addr, metadata !4309, metadata !DIExpression()), !dbg !4310
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4311, metadata !DIExpression()), !dbg !4312
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4312
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xExternalEventGroupHandle, metadata !4313, metadata !DIExpression()), !dbg !4314
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xExternalEventGroupHandle, align 8, !dbg !4314
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4315, metadata !DIExpression()), !dbg !4316
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !4317
  store i32 %call, i32* %lIndex, align 4, !dbg !4318
  %0 = load i32, i32* %lIndex, align 4, !dbg !4319
  %cmp = icmp ne i32 %0, -1, !dbg !4321
  br i1 %cmp, label %if.then, label %if.end4, !dbg !4322

if.then:                                          ; preds = %entry
  %1 = load %struct.xSTATIC_EVENT_GROUP*, %struct.xSTATIC_EVENT_GROUP** %pxEventGroupBuffer.addr, align 8, !dbg !4323
  %call1 = call %struct.EventGroupDef_t* @xEventGroupCreateStatic(%struct.xSTATIC_EVENT_GROUP* %1), !dbg !4325
  store %struct.EventGroupDef_t* %call1, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4326
  %2 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4327
  %cmp2 = icmp ne %struct.EventGroupDef_t* %2, null, !dbg !4329
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !4330

if.then3:                                         ; preds = %if.then
  %3 = load i32, i32* %lIndex, align 4, !dbg !4331
  %4 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4331
  %5 = bitcast %struct.EventGroupDef_t* %4 to %struct.OpaqueObject*, !dbg !4331
  call void @MPU_StoreHandleAndDataAtIndex(i32 %3, %struct.OpaqueObject* %5, i8* null, i32 4), !dbg !4331
  %6 = load i32, i32* %lIndex, align 4, !dbg !4333
  %add = add nsw i32 %6, 1, !dbg !4333
  %conv = sext i32 %add to i64, !dbg !4334
  %7 = inttoptr i64 %conv to %struct.EventGroupDef_t*, !dbg !4334
  store %struct.EventGroupDef_t* %7, %struct.EventGroupDef_t** %xExternalEventGroupHandle, align 8, !dbg !4335
  br label %if.end, !dbg !4336

if.else:                                          ; preds = %if.then
  %8 = load i32, i32* %lIndex, align 4, !dbg !4337
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %8), !dbg !4339
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  br label %if.end4, !dbg !4340

if.end4:                                          ; preds = %if.end, %entry
  %9 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xExternalEventGroupHandle, align 8, !dbg !4341
  ret %struct.EventGroupDef_t* %9, !dbg !4342
}

declare dso_local %struct.EventGroupDef_t* @xEventGroupCreateStatic(%struct.xSTATIC_EVENT_GROUP*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vEventGroupDelete(%struct.EventGroupDef_t* %xEventGroup) #0 section "privileged_functions" !dbg !4343 {
entry:
  %xEventGroup.addr = alloca %struct.EventGroupDef_t*, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.EventGroupDef_t* %xEventGroup, %struct.EventGroupDef_t** %xEventGroup.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xEventGroup.addr, metadata !4346, metadata !DIExpression()), !dbg !4347
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4348, metadata !DIExpression()), !dbg !4349
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4349
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4350, metadata !DIExpression()), !dbg !4351
  %0 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xEventGroup.addr, align 8, !dbg !4352
  %1 = ptrtoint %struct.EventGroupDef_t* %0 to i32, !dbg !4353
  store i32 %1, i32* %lIndex, align 4, !dbg !4354
  %2 = load i32, i32* %lIndex, align 4, !dbg !4355
  %cmp = icmp sge i32 %2, 1, !dbg !4355
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4355

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4355
  %cmp1 = icmp slt i32 %3, 257, !dbg !4355
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4357
  %land.ext = zext i1 %4 to i32, !dbg !4355
  %conv = sext i32 %land.ext to i64, !dbg !4355
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4358
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4359

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4360
  %sub = sub nsw i32 %5, 1, !dbg !4360
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 4), !dbg !4360
  %6 = bitcast %struct.OpaqueObject* %call to %struct.EventGroupDef_t*, !dbg !4360
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4362
  %7 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4363
  %cmp4 = icmp ne %struct.EventGroupDef_t* %7, null, !dbg !4365
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4366

if.then6:                                         ; preds = %if.then
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4367
  call void @vEventGroupDelete(%struct.EventGroupDef_t* %8), !dbg !4369
  %9 = load i32, i32* %lIndex, align 4, !dbg !4370
  %sub7 = sub nsw i32 %9, 1, !dbg !4370
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %sub7), !dbg !4371
  br label %if.end, !dbg !4372

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4373

if.end8:                                          ; preds = %if.end, %land.end
  ret void, !dbg !4374
}

declare dso_local void @vEventGroupDelete(%struct.EventGroupDef_t*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xEventGroupGetStaticBuffer(%struct.EventGroupDef_t* %xEventGroup, %struct.xSTATIC_EVENT_GROUP** %ppxEventGroupBuffer) #0 section "privileged_functions" !dbg !4375 {
entry:
  %xEventGroup.addr = alloca %struct.EventGroupDef_t*, align 8
  %ppxEventGroupBuffer.addr = alloca %struct.xSTATIC_EVENT_GROUP**, align 8
  %xReturn = alloca i64, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.EventGroupDef_t* %xEventGroup, %struct.EventGroupDef_t** %xEventGroup.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xEventGroup.addr, metadata !4379, metadata !DIExpression()), !dbg !4380
  store %struct.xSTATIC_EVENT_GROUP** %ppxEventGroupBuffer, %struct.xSTATIC_EVENT_GROUP*** %ppxEventGroupBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xSTATIC_EVENT_GROUP*** %ppxEventGroupBuffer.addr, metadata !4381, metadata !DIExpression()), !dbg !4382
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4383, metadata !DIExpression()), !dbg !4384
  store i64 0, i64* %xReturn, align 8, !dbg !4384
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4385, metadata !DIExpression()), !dbg !4386
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4386
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4387, metadata !DIExpression()), !dbg !4388
  %0 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xEventGroup.addr, align 8, !dbg !4389
  %1 = ptrtoint %struct.EventGroupDef_t* %0 to i32, !dbg !4390
  store i32 %1, i32* %lIndex, align 4, !dbg !4391
  %2 = load i32, i32* %lIndex, align 4, !dbg !4392
  %cmp = icmp sge i32 %2, 1, !dbg !4392
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4392

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4392
  %cmp1 = icmp slt i32 %3, 257, !dbg !4392
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4394
  %land.ext = zext i1 %4 to i32, !dbg !4392
  %conv = sext i32 %land.ext to i64, !dbg !4392
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4395
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4396

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4397
  %sub = sub nsw i32 %5, 1, !dbg !4397
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 4), !dbg !4397
  %6 = bitcast %struct.OpaqueObject* %call to %struct.EventGroupDef_t*, !dbg !4397
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4399
  %7 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4400
  %cmp4 = icmp ne %struct.EventGroupDef_t* %7, null, !dbg !4402
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4403

if.then6:                                         ; preds = %if.then
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4404
  %9 = load %struct.xSTATIC_EVENT_GROUP**, %struct.xSTATIC_EVENT_GROUP*** %ppxEventGroupBuffer.addr, align 8, !dbg !4406
  %call7 = call i64 @xEventGroupGetStaticBuffer(%struct.EventGroupDef_t* %8, %struct.xSTATIC_EVENT_GROUP** %9), !dbg !4407
  store i64 %call7, i64* %xReturn, align 8, !dbg !4408
  br label %if.end, !dbg !4409

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4410

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !4411
  ret i64 %10, !dbg !4412
}

declare dso_local i64 @xEventGroupGetStaticBuffer(%struct.EventGroupDef_t*, %struct.xSTATIC_EVENT_GROUP**) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xEventGroupClearBitsFromISR(%struct.EventGroupDef_t* %xEventGroup, i64 %uxBitsToClear) #0 section "privileged_functions" !dbg !4413 {
entry:
  %xEventGroup.addr = alloca %struct.EventGroupDef_t*, align 8
  %uxBitsToClear.addr = alloca i64, align 8
  %xReturn = alloca i64, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.EventGroupDef_t* %xEventGroup, %struct.EventGroupDef_t** %xEventGroup.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xEventGroup.addr, metadata !4416, metadata !DIExpression()), !dbg !4417
  store i64 %uxBitsToClear, i64* %uxBitsToClear.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxBitsToClear.addr, metadata !4418, metadata !DIExpression()), !dbg !4419
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4420, metadata !DIExpression()), !dbg !4421
  store i64 0, i64* %xReturn, align 8, !dbg !4421
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4422, metadata !DIExpression()), !dbg !4423
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4423
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4424, metadata !DIExpression()), !dbg !4425
  %0 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xEventGroup.addr, align 8, !dbg !4426
  %1 = ptrtoint %struct.EventGroupDef_t* %0 to i32, !dbg !4427
  store i32 %1, i32* %lIndex, align 4, !dbg !4428
  %2 = load i32, i32* %lIndex, align 4, !dbg !4429
  %cmp = icmp sge i32 %2, 1, !dbg !4429
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4429

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4429
  %cmp1 = icmp slt i32 %3, 257, !dbg !4429
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4431
  %land.ext = zext i1 %4 to i32, !dbg !4429
  %conv = sext i32 %land.ext to i64, !dbg !4429
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4432
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4433

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4434
  %sub = sub nsw i32 %5, 1, !dbg !4434
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 4), !dbg !4434
  %6 = bitcast %struct.OpaqueObject* %call to %struct.EventGroupDef_t*, !dbg !4434
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4436
  %7 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4437
  %cmp4 = icmp ne %struct.EventGroupDef_t* %7, null, !dbg !4439
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4440

if.then6:                                         ; preds = %if.then
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4441
  %9 = load i64, i64* %uxBitsToClear.addr, align 8, !dbg !4443
  %call7 = call i64 @xEventGroupClearBitsFromISR(%struct.EventGroupDef_t* %8, i64 %9), !dbg !4444
  store i64 %call7, i64* %xReturn, align 8, !dbg !4445
  br label %if.end, !dbg !4446

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4447

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !4448
  ret i64 %10, !dbg !4449
}

declare dso_local i64 @xEventGroupClearBitsFromISR(%struct.EventGroupDef_t*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xEventGroupSetBitsFromISR(%struct.EventGroupDef_t* %xEventGroup, i64 %uxBitsToSet, i64* %pxHigherPriorityTaskWoken) #0 section "privileged_functions" !dbg !4450 {
entry:
  %xEventGroup.addr = alloca %struct.EventGroupDef_t*, align 8
  %uxBitsToSet.addr = alloca i64, align 8
  %pxHigherPriorityTaskWoken.addr = alloca i64*, align 8
  %xReturn = alloca i64, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.EventGroupDef_t* %xEventGroup, %struct.EventGroupDef_t** %xEventGroup.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xEventGroup.addr, metadata !4453, metadata !DIExpression()), !dbg !4454
  store i64 %uxBitsToSet, i64* %uxBitsToSet.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxBitsToSet.addr, metadata !4455, metadata !DIExpression()), !dbg !4456
  store i64* %pxHigherPriorityTaskWoken, i64** %pxHigherPriorityTaskWoken.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxHigherPriorityTaskWoken.addr, metadata !4457, metadata !DIExpression()), !dbg !4458
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4459, metadata !DIExpression()), !dbg !4460
  store i64 0, i64* %xReturn, align 8, !dbg !4460
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4461, metadata !DIExpression()), !dbg !4462
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4462
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4463, metadata !DIExpression()), !dbg !4464
  %0 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xEventGroup.addr, align 8, !dbg !4465
  %1 = ptrtoint %struct.EventGroupDef_t* %0 to i32, !dbg !4466
  store i32 %1, i32* %lIndex, align 4, !dbg !4467
  %2 = load i32, i32* %lIndex, align 4, !dbg !4468
  %cmp = icmp sge i32 %2, 1, !dbg !4468
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4468

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4468
  %cmp1 = icmp slt i32 %3, 257, !dbg !4468
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4470
  %land.ext = zext i1 %4 to i32, !dbg !4468
  %conv = sext i32 %land.ext to i64, !dbg !4468
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4471
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4472

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4473
  %sub = sub nsw i32 %5, 1, !dbg !4473
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 4), !dbg !4473
  %6 = bitcast %struct.OpaqueObject* %call to %struct.EventGroupDef_t*, !dbg !4473
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4475
  %7 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4476
  %cmp4 = icmp ne %struct.EventGroupDef_t* %7, null, !dbg !4478
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4479

if.then6:                                         ; preds = %if.then
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4480
  %9 = load i64, i64* %uxBitsToSet.addr, align 8, !dbg !4482
  %10 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !4483
  %call7 = call i64 @xEventGroupSetBitsFromISR(%struct.EventGroupDef_t* %8, i64 %9, i64* %10), !dbg !4484
  store i64 %call7, i64* %xReturn, align 8, !dbg !4485
  br label %if.end, !dbg !4486

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4487

if.end8:                                          ; preds = %if.end, %land.end
  %11 = load i64, i64* %xReturn, align 8, !dbg !4488
  ret i64 %11, !dbg !4489
}

declare dso_local i64 @xEventGroupSetBitsFromISR(%struct.EventGroupDef_t*, i64, i64*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xEventGroupGetBitsFromISR(%struct.EventGroupDef_t* %xEventGroup) #0 section "privileged_functions" !dbg !4490 {
entry:
  %xEventGroup.addr = alloca %struct.EventGroupDef_t*, align 8
  %xReturn = alloca i64, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.EventGroupDef_t* %xEventGroup, %struct.EventGroupDef_t** %xEventGroup.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xEventGroup.addr, metadata !4493, metadata !DIExpression()), !dbg !4494
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4495, metadata !DIExpression()), !dbg !4496
  store i64 0, i64* %xReturn, align 8, !dbg !4496
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4497, metadata !DIExpression()), !dbg !4498
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4498
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4499, metadata !DIExpression()), !dbg !4500
  %0 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xEventGroup.addr, align 8, !dbg !4501
  %1 = ptrtoint %struct.EventGroupDef_t* %0 to i32, !dbg !4502
  store i32 %1, i32* %lIndex, align 4, !dbg !4503
  %2 = load i32, i32* %lIndex, align 4, !dbg !4504
  %cmp = icmp sge i32 %2, 1, !dbg !4504
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4504

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4504
  %cmp1 = icmp slt i32 %3, 257, !dbg !4504
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4506
  %land.ext = zext i1 %4 to i32, !dbg !4504
  %conv = sext i32 %land.ext to i64, !dbg !4504
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4507
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4508

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4509
  %sub = sub nsw i32 %5, 1, !dbg !4509
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 4), !dbg !4509
  %6 = bitcast %struct.OpaqueObject* %call to %struct.EventGroupDef_t*, !dbg !4509
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4511
  %7 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4512
  %cmp4 = icmp ne %struct.EventGroupDef_t* %7, null, !dbg !4514
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4515

if.then6:                                         ; preds = %if.then
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4516
  %call7 = call i64 @xEventGroupGetBitsFromISR(%struct.EventGroupDef_t* %8), !dbg !4518
  store i64 %call7, i64* %xReturn, align 8, !dbg !4519
  br label %if.end, !dbg !4520

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4521

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !4522
  ret i64 %9, !dbg !4523
}

declare dso_local i64 @xEventGroupGetBitsFromISR(%struct.EventGroupDef_t*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferSendImpl(%struct.StreamBufferDef_t* %xStreamBuffer, i8* %pvTxData, i64 %xDataLengthBytes, i64 %xTicksToWait) #0 section "privileged_functions" !dbg !4524 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %pvTxData.addr = alloca i8*, align 8
  %xDataLengthBytes.addr = alloca i64, align 8
  %xTicksToWait.addr = alloca i64, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  %xIsTxDataBufferReadable = alloca i64, align 8
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !4527, metadata !DIExpression()), !dbg !4528
  store i8* %pvTxData, i8** %pvTxData.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvTxData.addr, metadata !4529, metadata !DIExpression()), !dbg !4530
  store i64 %xDataLengthBytes, i64* %xDataLengthBytes.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xDataLengthBytes.addr, metadata !4531, metadata !DIExpression()), !dbg !4532
  store i64 %xTicksToWait, i64* %xTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToWait.addr, metadata !4533, metadata !DIExpression()), !dbg !4534
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4535, metadata !DIExpression()), !dbg !4536
  store i64 0, i64* %xReturn, align 8, !dbg !4536
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4537, metadata !DIExpression()), !dbg !4538
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4538
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4539, metadata !DIExpression()), !dbg !4540
  call void @llvm.dbg.declare(metadata i64* %xIsTxDataBufferReadable, metadata !4541, metadata !DIExpression()), !dbg !4542
  store i64 0, i64* %xIsTxDataBufferReadable, align 8, !dbg !4542
  %0 = load i8*, i8** %pvTxData.addr, align 8, !dbg !4543
  %1 = load i64, i64* %xDataLengthBytes.addr, align 8, !dbg !4544
  %conv = trunc i64 %1 to i32, !dbg !4544
  %call = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %0, i32 %conv, i32 1), !dbg !4545
  store i64 %call, i64* %xIsTxDataBufferReadable, align 8, !dbg !4546
  %2 = load i64, i64* %xIsTxDataBufferReadable, align 8, !dbg !4547
  %cmp = icmp eq i64 %2, 1, !dbg !4549
  br i1 %cmp, label %if.then, label %if.end16, !dbg !4550

if.then:                                          ; preds = %entry
  %3 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !4551
  %4 = ptrtoint %struct.StreamBufferDef_t* %3 to i32, !dbg !4553
  store i32 %4, i32* %lIndex, align 4, !dbg !4554
  %5 = load i32, i32* %lIndex, align 4, !dbg !4555
  %cmp2 = icmp sge i32 %5, 1, !dbg !4555
  br i1 %cmp2, label %land.rhs, label %land.end, !dbg !4555

land.rhs:                                         ; preds = %if.then
  %6 = load i32, i32* %lIndex, align 4, !dbg !4555
  %cmp4 = icmp slt i32 %6, 257, !dbg !4555
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.then
  %7 = phi i1 [ false, %if.then ], [ %cmp4, %land.rhs ], !dbg !4557
  %land.ext = zext i1 %7 to i32, !dbg !4555
  %conv6 = sext i32 %land.ext to i64, !dbg !4555
  %cmp7 = icmp ne i64 %conv6, 0, !dbg !4558
  br i1 %cmp7, label %if.then9, label %if.end15, !dbg !4559

if.then9:                                         ; preds = %land.end
  %8 = load i32, i32* %lIndex, align 4, !dbg !4560
  %sub = sub nsw i32 %8, 1, !dbg !4560
  %call10 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !4560
  %9 = bitcast %struct.OpaqueObject* %call10 to %struct.StreamBufferDef_t*, !dbg !4560
  store %struct.StreamBufferDef_t* %9, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4562
  %10 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4563
  %cmp11 = icmp ne %struct.StreamBufferDef_t* %10, null, !dbg !4565
  br i1 %cmp11, label %if.then13, label %if.end, !dbg !4566

if.then13:                                        ; preds = %if.then9
  %11 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4567
  %12 = load i8*, i8** %pvTxData.addr, align 8, !dbg !4569
  %13 = load i64, i64* %xDataLengthBytes.addr, align 8, !dbg !4570
  %14 = load i64, i64* %xTicksToWait.addr, align 8, !dbg !4571
  %call14 = call i64 @xStreamBufferSend(%struct.StreamBufferDef_t* %11, i8* %12, i64 %13, i64 %14), !dbg !4572
  store i64 %call14, i64* %xReturn, align 8, !dbg !4573
  br label %if.end, !dbg !4574

if.end:                                           ; preds = %if.then13, %if.then9
  br label %if.end15, !dbg !4575

if.end15:                                         ; preds = %if.end, %land.end
  br label %if.end16, !dbg !4576

if.end16:                                         ; preds = %if.end15, %entry
  %15 = load i64, i64* %xReturn, align 8, !dbg !4577
  ret i64 %15, !dbg !4578
}

declare dso_local i64 @xStreamBufferSend(%struct.StreamBufferDef_t*, i8*, i64, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferReceiveImpl(%struct.StreamBufferDef_t* %xStreamBuffer, i8* %pvRxData, i64 %xBufferLengthBytes, i64 %xTicksToWait) #0 section "privileged_functions" !dbg !4579 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %pvRxData.addr = alloca i8*, align 8
  %xBufferLengthBytes.addr = alloca i64, align 8
  %xTicksToWait.addr = alloca i64, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  %xIsRxDataBufferWriteable = alloca i64, align 8
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !4582, metadata !DIExpression()), !dbg !4583
  store i8* %pvRxData, i8** %pvRxData.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvRxData.addr, metadata !4584, metadata !DIExpression()), !dbg !4585
  store i64 %xBufferLengthBytes, i64* %xBufferLengthBytes.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xBufferLengthBytes.addr, metadata !4586, metadata !DIExpression()), !dbg !4587
  store i64 %xTicksToWait, i64* %xTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToWait.addr, metadata !4588, metadata !DIExpression()), !dbg !4589
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4590, metadata !DIExpression()), !dbg !4591
  store i64 0, i64* %xReturn, align 8, !dbg !4591
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4592, metadata !DIExpression()), !dbg !4593
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4593
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4594, metadata !DIExpression()), !dbg !4595
  call void @llvm.dbg.declare(metadata i64* %xIsRxDataBufferWriteable, metadata !4596, metadata !DIExpression()), !dbg !4597
  store i64 0, i64* %xIsRxDataBufferWriteable, align 8, !dbg !4597
  %0 = load i8*, i8** %pvRxData.addr, align 8, !dbg !4598
  %1 = load i64, i64* %xBufferLengthBytes.addr, align 8, !dbg !4599
  %conv = trunc i64 %1 to i32, !dbg !4599
  %call = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %0, i32 %conv, i32 2), !dbg !4600
  store i64 %call, i64* %xIsRxDataBufferWriteable, align 8, !dbg !4601
  %2 = load i64, i64* %xIsRxDataBufferWriteable, align 8, !dbg !4602
  %cmp = icmp eq i64 %2, 1, !dbg !4604
  br i1 %cmp, label %if.then, label %if.end16, !dbg !4605

if.then:                                          ; preds = %entry
  %3 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !4606
  %4 = ptrtoint %struct.StreamBufferDef_t* %3 to i32, !dbg !4608
  store i32 %4, i32* %lIndex, align 4, !dbg !4609
  %5 = load i32, i32* %lIndex, align 4, !dbg !4610
  %cmp2 = icmp sge i32 %5, 1, !dbg !4610
  br i1 %cmp2, label %land.rhs, label %land.end, !dbg !4610

land.rhs:                                         ; preds = %if.then
  %6 = load i32, i32* %lIndex, align 4, !dbg !4610
  %cmp4 = icmp slt i32 %6, 257, !dbg !4610
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.then
  %7 = phi i1 [ false, %if.then ], [ %cmp4, %land.rhs ], !dbg !4612
  %land.ext = zext i1 %7 to i32, !dbg !4610
  %conv6 = sext i32 %land.ext to i64, !dbg !4610
  %cmp7 = icmp ne i64 %conv6, 0, !dbg !4613
  br i1 %cmp7, label %if.then9, label %if.end15, !dbg !4614

if.then9:                                         ; preds = %land.end
  %8 = load i32, i32* %lIndex, align 4, !dbg !4615
  %sub = sub nsw i32 %8, 1, !dbg !4615
  %call10 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !4615
  %9 = bitcast %struct.OpaqueObject* %call10 to %struct.StreamBufferDef_t*, !dbg !4615
  store %struct.StreamBufferDef_t* %9, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4617
  %10 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4618
  %cmp11 = icmp ne %struct.StreamBufferDef_t* %10, null, !dbg !4620
  br i1 %cmp11, label %if.then13, label %if.end, !dbg !4621

if.then13:                                        ; preds = %if.then9
  %11 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4622
  %12 = load i8*, i8** %pvRxData.addr, align 8, !dbg !4624
  %13 = load i64, i64* %xBufferLengthBytes.addr, align 8, !dbg !4625
  %14 = load i64, i64* %xTicksToWait.addr, align 8, !dbg !4626
  %call14 = call i64 @xStreamBufferReceive(%struct.StreamBufferDef_t* %11, i8* %12, i64 %13, i64 %14), !dbg !4627
  store i64 %call14, i64* %xReturn, align 8, !dbg !4628
  br label %if.end, !dbg !4629

if.end:                                           ; preds = %if.then13, %if.then9
  br label %if.end15, !dbg !4630

if.end15:                                         ; preds = %if.end, %land.end
  br label %if.end16, !dbg !4631

if.end16:                                         ; preds = %if.end15, %entry
  %15 = load i64, i64* %xReturn, align 8, !dbg !4632
  ret i64 %15, !dbg !4633
}

declare dso_local i64 @xStreamBufferReceive(%struct.StreamBufferDef_t*, i8*, i64, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferIsFullImpl(%struct.StreamBufferDef_t* %xStreamBuffer) #0 section "privileged_functions" !dbg !4634 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !4637, metadata !DIExpression()), !dbg !4638
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4639, metadata !DIExpression()), !dbg !4640
  store i64 0, i64* %xReturn, align 8, !dbg !4640
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4641, metadata !DIExpression()), !dbg !4642
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4642
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4643, metadata !DIExpression()), !dbg !4644
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !4645
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !4646
  store i32 %1, i32* %lIndex, align 4, !dbg !4647
  %2 = load i32, i32* %lIndex, align 4, !dbg !4648
  %cmp = icmp sge i32 %2, 1, !dbg !4648
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4648

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4648
  %cmp1 = icmp slt i32 %3, 257, !dbg !4648
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4650
  %land.ext = zext i1 %4 to i32, !dbg !4648
  %conv = sext i32 %land.ext to i64, !dbg !4648
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4651
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4652

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4653
  %sub = sub nsw i32 %5, 1, !dbg !4653
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !4653
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !4653
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4655
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4656
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !4658
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4659

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4660
  %call7 = call i64 @xStreamBufferIsFull(%struct.StreamBufferDef_t* %8), !dbg !4662
  store i64 %call7, i64* %xReturn, align 8, !dbg !4663
  br label %if.end, !dbg !4664

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4665

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !4666
  ret i64 %9, !dbg !4667
}

declare dso_local i64 @xStreamBufferIsFull(%struct.StreamBufferDef_t*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferIsEmptyImpl(%struct.StreamBufferDef_t* %xStreamBuffer) #0 section "privileged_functions" !dbg !4668 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !4669, metadata !DIExpression()), !dbg !4670
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4671, metadata !DIExpression()), !dbg !4672
  store i64 0, i64* %xReturn, align 8, !dbg !4672
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4673, metadata !DIExpression()), !dbg !4674
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4674
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4675, metadata !DIExpression()), !dbg !4676
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !4677
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !4678
  store i32 %1, i32* %lIndex, align 4, !dbg !4679
  %2 = load i32, i32* %lIndex, align 4, !dbg !4680
  %cmp = icmp sge i32 %2, 1, !dbg !4680
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4680

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4680
  %cmp1 = icmp slt i32 %3, 257, !dbg !4680
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4682
  %land.ext = zext i1 %4 to i32, !dbg !4680
  %conv = sext i32 %land.ext to i64, !dbg !4680
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4683
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4684

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4685
  %sub = sub nsw i32 %5, 1, !dbg !4685
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !4685
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !4685
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4687
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4688
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !4690
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4691

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4692
  %call7 = call i64 @xStreamBufferIsEmpty(%struct.StreamBufferDef_t* %8), !dbg !4694
  store i64 %call7, i64* %xReturn, align 8, !dbg !4695
  br label %if.end, !dbg !4696

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4697

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !4698
  ret i64 %9, !dbg !4699
}

declare dso_local i64 @xStreamBufferIsEmpty(%struct.StreamBufferDef_t*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferSpacesAvailableImpl(%struct.StreamBufferDef_t* %xStreamBuffer) #0 section "privileged_functions" !dbg !4700 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !4703, metadata !DIExpression()), !dbg !4704
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4705, metadata !DIExpression()), !dbg !4706
  store i64 0, i64* %xReturn, align 8, !dbg !4706
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4707, metadata !DIExpression()), !dbg !4708
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4708
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4709, metadata !DIExpression()), !dbg !4710
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !4711
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !4712
  store i32 %1, i32* %lIndex, align 4, !dbg !4713
  %2 = load i32, i32* %lIndex, align 4, !dbg !4714
  %cmp = icmp sge i32 %2, 1, !dbg !4714
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4714

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4714
  %cmp1 = icmp slt i32 %3, 257, !dbg !4714
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4716
  %land.ext = zext i1 %4 to i32, !dbg !4714
  %conv = sext i32 %land.ext to i64, !dbg !4714
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4717
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4718

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4719
  %sub = sub nsw i32 %5, 1, !dbg !4719
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !4719
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !4719
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4721
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4722
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !4724
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4725

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4726
  %call7 = call i64 @xStreamBufferSpacesAvailable(%struct.StreamBufferDef_t* %8), !dbg !4728
  store i64 %call7, i64* %xReturn, align 8, !dbg !4729
  br label %if.end, !dbg !4730

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4731

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !4732
  ret i64 %9, !dbg !4733
}

declare dso_local i64 @xStreamBufferSpacesAvailable(%struct.StreamBufferDef_t*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferBytesAvailableImpl(%struct.StreamBufferDef_t* %xStreamBuffer) #0 section "privileged_functions" !dbg !4734 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !4735, metadata !DIExpression()), !dbg !4736
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4737, metadata !DIExpression()), !dbg !4738
  store i64 0, i64* %xReturn, align 8, !dbg !4738
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4739, metadata !DIExpression()), !dbg !4740
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4740
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4741, metadata !DIExpression()), !dbg !4742
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !4743
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !4744
  store i32 %1, i32* %lIndex, align 4, !dbg !4745
  %2 = load i32, i32* %lIndex, align 4, !dbg !4746
  %cmp = icmp sge i32 %2, 1, !dbg !4746
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4746

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4746
  %cmp1 = icmp slt i32 %3, 257, !dbg !4746
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4748
  %land.ext = zext i1 %4 to i32, !dbg !4746
  %conv = sext i32 %land.ext to i64, !dbg !4746
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4749
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4750

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4751
  %sub = sub nsw i32 %5, 1, !dbg !4751
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !4751
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !4751
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4753
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4754
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !4756
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4757

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4758
  %call7 = call i64 @xStreamBufferBytesAvailable(%struct.StreamBufferDef_t* %8), !dbg !4760
  store i64 %call7, i64* %xReturn, align 8, !dbg !4761
  br label %if.end, !dbg !4762

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4763

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !4764
  ret i64 %9, !dbg !4765
}

declare dso_local i64 @xStreamBufferBytesAvailable(%struct.StreamBufferDef_t*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferSetTriggerLevelImpl(%struct.StreamBufferDef_t* %xStreamBuffer, i64 %xTriggerLevel) #0 section "privileged_functions" !dbg !4766 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %xTriggerLevel.addr = alloca i64, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !4769, metadata !DIExpression()), !dbg !4770
  store i64 %xTriggerLevel, i64* %xTriggerLevel.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTriggerLevel.addr, metadata !4771, metadata !DIExpression()), !dbg !4772
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4773, metadata !DIExpression()), !dbg !4774
  store i64 0, i64* %xReturn, align 8, !dbg !4774
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4775, metadata !DIExpression()), !dbg !4776
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4776
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4777, metadata !DIExpression()), !dbg !4778
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !4779
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !4780
  store i32 %1, i32* %lIndex, align 4, !dbg !4781
  %2 = load i32, i32* %lIndex, align 4, !dbg !4782
  %cmp = icmp sge i32 %2, 1, !dbg !4782
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4782

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4782
  %cmp1 = icmp slt i32 %3, 257, !dbg !4782
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4784
  %land.ext = zext i1 %4 to i32, !dbg !4782
  %conv = sext i32 %land.ext to i64, !dbg !4782
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4785
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4786

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4787
  %sub = sub nsw i32 %5, 1, !dbg !4787
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !4787
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !4787
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4789
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4790
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !4792
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4793

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4794
  %9 = load i64, i64* %xTriggerLevel.addr, align 8, !dbg !4796
  %call7 = call i64 @xStreamBufferSetTriggerLevel(%struct.StreamBufferDef_t* %8, i64 %9), !dbg !4797
  store i64 %call7, i64* %xReturn, align 8, !dbg !4798
  br label %if.end, !dbg !4799

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4800

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !4801
  ret i64 %10, !dbg !4802
}

declare dso_local i64 @xStreamBufferSetTriggerLevel(%struct.StreamBufferDef_t*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferNextMessageLengthBytesImpl(%struct.StreamBufferDef_t* %xStreamBuffer) #0 section "privileged_functions" !dbg !4803 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !4804, metadata !DIExpression()), !dbg !4805
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4806, metadata !DIExpression()), !dbg !4807
  store i64 0, i64* %xReturn, align 8, !dbg !4807
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4808, metadata !DIExpression()), !dbg !4809
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4809
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4810, metadata !DIExpression()), !dbg !4811
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !4812
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !4813
  store i32 %1, i32* %lIndex, align 4, !dbg !4814
  %2 = load i32, i32* %lIndex, align 4, !dbg !4815
  %cmp = icmp sge i32 %2, 1, !dbg !4815
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4815

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4815
  %cmp1 = icmp slt i32 %3, 257, !dbg !4815
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4817
  %land.ext = zext i1 %4 to i32, !dbg !4815
  %conv = sext i32 %land.ext to i64, !dbg !4815
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4818
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4819

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4820
  %sub = sub nsw i32 %5, 1, !dbg !4820
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !4820
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !4820
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4822
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4823
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !4825
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4826

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4827
  %call7 = call i64 @xStreamBufferNextMessageLengthBytes(%struct.StreamBufferDef_t* %8), !dbg !4829
  store i64 %call7, i64* %xReturn, align 8, !dbg !4830
  br label %if.end, !dbg !4831

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4832

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !4833
  ret i64 %9, !dbg !4834
}

declare dso_local i64 @xStreamBufferNextMessageLengthBytes(%struct.StreamBufferDef_t*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.StreamBufferDef_t* @MPU_xStreamBufferGenericCreate(i64 %xBufferSizeBytes, i64 %xTriggerLevelBytes, i64 %xIsMessageBuffer, void (%struct.StreamBufferDef_t*, i64, i64*)* %pxSendCompletedCallback, void (%struct.StreamBufferDef_t*, i64, i64*)* %pxReceiveCompletedCallback) #0 section "privileged_functions" !dbg !4835 {
entry:
  %xBufferSizeBytes.addr = alloca i64, align 8
  %xTriggerLevelBytes.addr = alloca i64, align 8
  %xIsMessageBuffer.addr = alloca i64, align 8
  %pxSendCompletedCallback.addr = alloca void (%struct.StreamBufferDef_t*, i64, i64*)*, align 8
  %pxReceiveCompletedCallback.addr = alloca void (%struct.StreamBufferDef_t*, i64, i64*)*, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %xExternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store i64 %xBufferSizeBytes, i64* %xBufferSizeBytes.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xBufferSizeBytes.addr, metadata !4842, metadata !DIExpression()), !dbg !4843
  store i64 %xTriggerLevelBytes, i64* %xTriggerLevelBytes.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTriggerLevelBytes.addr, metadata !4844, metadata !DIExpression()), !dbg !4845
  store i64 %xIsMessageBuffer, i64* %xIsMessageBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xIsMessageBuffer.addr, metadata !4846, metadata !DIExpression()), !dbg !4847
  store void (%struct.StreamBufferDef_t*, i64, i64*)* %pxSendCompletedCallback, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxSendCompletedCallback.addr, align 8
  call void @llvm.dbg.declare(metadata void (%struct.StreamBufferDef_t*, i64, i64*)** %pxSendCompletedCallback.addr, metadata !4848, metadata !DIExpression()), !dbg !4849
  store void (%struct.StreamBufferDef_t*, i64, i64*)* %pxReceiveCompletedCallback, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxReceiveCompletedCallback.addr, align 8
  call void @llvm.dbg.declare(metadata void (%struct.StreamBufferDef_t*, i64, i64*)** %pxReceiveCompletedCallback.addr, metadata !4850, metadata !DIExpression()), !dbg !4851
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4852, metadata !DIExpression()), !dbg !4853
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4853
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xExternalStreamBufferHandle, metadata !4854, metadata !DIExpression()), !dbg !4855
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xExternalStreamBufferHandle, align 8, !dbg !4855
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4856, metadata !DIExpression()), !dbg !4857
  %0 = load void (%struct.StreamBufferDef_t*, i64, i64*)*, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxSendCompletedCallback.addr, align 8, !dbg !4858
  %cmp = icmp eq void (%struct.StreamBufferDef_t*, i64, i64*)* %0, null, !dbg !4858
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4858

land.rhs:                                         ; preds = %entry
  %1 = load void (%struct.StreamBufferDef_t*, i64, i64*)*, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxReceiveCompletedCallback.addr, align 8, !dbg !4858
  %cmp1 = icmp eq void (%struct.StreamBufferDef_t*, i64, i64*)* %1, null, !dbg !4858
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %2 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4860
  %land.ext = zext i1 %2 to i32, !dbg !4858
  %cmp2 = icmp eq i32 %land.ext, 0, !dbg !4858
  br i1 %cmp2, label %if.then, label %if.end, !dbg !4861

if.then:                                          ; preds = %land.end
  call void @vAssertCalled(i8* getelementptr inbounds ([68 x i8], [68 x i8]* @.str, i64 0, i64 0), i64 3847), !dbg !4858
  br label %if.end, !dbg !4858

if.end:                                           ; preds = %if.then, %land.end
  %3 = load void (%struct.StreamBufferDef_t*, i64, i64*)*, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxSendCompletedCallback.addr, align 8, !dbg !4862
  %cmp3 = icmp eq void (%struct.StreamBufferDef_t*, i64, i64*)* %3, null, !dbg !4864
  br i1 %cmp3, label %land.lhs.true, label %if.else13, !dbg !4865

land.lhs.true:                                    ; preds = %if.end
  %4 = load void (%struct.StreamBufferDef_t*, i64, i64*)*, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxReceiveCompletedCallback.addr, align 8, !dbg !4866
  %cmp4 = icmp eq void (%struct.StreamBufferDef_t*, i64, i64*)* %4, null, !dbg !4867
  br i1 %cmp4, label %if.then5, label %if.else13, !dbg !4868

if.then5:                                         ; preds = %land.lhs.true
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !4869
  store i32 %call, i32* %lIndex, align 4, !dbg !4871
  %5 = load i32, i32* %lIndex, align 4, !dbg !4872
  %cmp6 = icmp ne i32 %5, -1, !dbg !4874
  br i1 %cmp6, label %if.then7, label %if.end12, !dbg !4875

if.then7:                                         ; preds = %if.then5
  %6 = load i64, i64* %xBufferSizeBytes.addr, align 8, !dbg !4876
  %7 = load i64, i64* %xTriggerLevelBytes.addr, align 8, !dbg !4878
  %8 = load i64, i64* %xIsMessageBuffer.addr, align 8, !dbg !4879
  %call8 = call %struct.StreamBufferDef_t* @xStreamBufferGenericCreate(i64 %6, i64 %7, i64 %8, void (%struct.StreamBufferDef_t*, i64, i64*)* null, void (%struct.StreamBufferDef_t*, i64, i64*)* null), !dbg !4880
  store %struct.StreamBufferDef_t* %call8, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4881
  %9 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4882
  %cmp9 = icmp ne %struct.StreamBufferDef_t* %9, null, !dbg !4884
  br i1 %cmp9, label %if.then10, label %if.else, !dbg !4885

if.then10:                                        ; preds = %if.then7
  %10 = load i32, i32* %lIndex, align 4, !dbg !4886
  %11 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4886
  %12 = bitcast %struct.StreamBufferDef_t* %11 to %struct.OpaqueObject*, !dbg !4886
  call void @MPU_StoreHandleAndDataAtIndex(i32 %10, %struct.OpaqueObject* %12, i8* null, i32 3), !dbg !4886
  %13 = load i32, i32* %lIndex, align 4, !dbg !4888
  %add = add nsw i32 %13, 1, !dbg !4888
  %conv = sext i32 %add to i64, !dbg !4889
  %14 = inttoptr i64 %conv to %struct.StreamBufferDef_t*, !dbg !4889
  store %struct.StreamBufferDef_t* %14, %struct.StreamBufferDef_t** %xExternalStreamBufferHandle, align 8, !dbg !4890
  br label %if.end11, !dbg !4891

if.else:                                          ; preds = %if.then7
  %15 = load i32, i32* %lIndex, align 4, !dbg !4892
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %15), !dbg !4894
  br label %if.end11

if.end11:                                         ; preds = %if.else, %if.then10
  br label %if.end12, !dbg !4895

if.end12:                                         ; preds = %if.end11, %if.then5
  br label %if.end14, !dbg !4896

if.else13:                                        ; preds = %land.lhs.true, %if.end
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xExternalStreamBufferHandle, align 8, !dbg !4897
  br label %if.end14

if.end14:                                         ; preds = %if.else13, %if.end12
  %16 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xExternalStreamBufferHandle, align 8, !dbg !4899
  ret %struct.StreamBufferDef_t* %16, !dbg !4900
}

declare dso_local %struct.StreamBufferDef_t* @xStreamBufferGenericCreate(i64, i64, i64, void (%struct.StreamBufferDef_t*, i64, i64*)*, void (%struct.StreamBufferDef_t*, i64, i64*)*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.StreamBufferDef_t* @MPU_xStreamBufferGenericCreateStatic(i64 %xBufferSizeBytes, i64 %xTriggerLevelBytes, i64 %xIsMessageBuffer, i8* %pucStreamBufferStorageArea, %struct.xSTATIC_STREAM_BUFFER* %pxStaticStreamBuffer, void (%struct.StreamBufferDef_t*, i64, i64*)* %pxSendCompletedCallback, void (%struct.StreamBufferDef_t*, i64, i64*)* %pxReceiveCompletedCallback) #0 section "privileged_functions" !dbg !4901 {
entry:
  %xBufferSizeBytes.addr = alloca i64, align 8
  %xTriggerLevelBytes.addr = alloca i64, align 8
  %xIsMessageBuffer.addr = alloca i64, align 8
  %pucStreamBufferStorageArea.addr = alloca i8*, align 8
  %pxStaticStreamBuffer.addr = alloca %struct.xSTATIC_STREAM_BUFFER*, align 8
  %pxSendCompletedCallback.addr = alloca void (%struct.StreamBufferDef_t*, i64, i64*)*, align 8
  %pxReceiveCompletedCallback.addr = alloca void (%struct.StreamBufferDef_t*, i64, i64*)*, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %xExternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store i64 %xBufferSizeBytes, i64* %xBufferSizeBytes.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xBufferSizeBytes.addr, metadata !4916, metadata !DIExpression()), !dbg !4917
  store i64 %xTriggerLevelBytes, i64* %xTriggerLevelBytes.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTriggerLevelBytes.addr, metadata !4918, metadata !DIExpression()), !dbg !4919
  store i64 %xIsMessageBuffer, i64* %xIsMessageBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xIsMessageBuffer.addr, metadata !4920, metadata !DIExpression()), !dbg !4921
  store i8* %pucStreamBufferStorageArea, i8** %pucStreamBufferStorageArea.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pucStreamBufferStorageArea.addr, metadata !4922, metadata !DIExpression()), !dbg !4923
  store %struct.xSTATIC_STREAM_BUFFER* %pxStaticStreamBuffer, %struct.xSTATIC_STREAM_BUFFER** %pxStaticStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xSTATIC_STREAM_BUFFER** %pxStaticStreamBuffer.addr, metadata !4924, metadata !DIExpression()), !dbg !4925
  store void (%struct.StreamBufferDef_t*, i64, i64*)* %pxSendCompletedCallback, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxSendCompletedCallback.addr, align 8
  call void @llvm.dbg.declare(metadata void (%struct.StreamBufferDef_t*, i64, i64*)** %pxSendCompletedCallback.addr, metadata !4926, metadata !DIExpression()), !dbg !4927
  store void (%struct.StreamBufferDef_t*, i64, i64*)* %pxReceiveCompletedCallback, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxReceiveCompletedCallback.addr, align 8
  call void @llvm.dbg.declare(metadata void (%struct.StreamBufferDef_t*, i64, i64*)** %pxReceiveCompletedCallback.addr, metadata !4928, metadata !DIExpression()), !dbg !4929
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4930, metadata !DIExpression()), !dbg !4931
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4931
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xExternalStreamBufferHandle, metadata !4932, metadata !DIExpression()), !dbg !4933
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xExternalStreamBufferHandle, align 8, !dbg !4933
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4934, metadata !DIExpression()), !dbg !4935
  %0 = load void (%struct.StreamBufferDef_t*, i64, i64*)*, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxSendCompletedCallback.addr, align 8, !dbg !4936
  %cmp = icmp eq void (%struct.StreamBufferDef_t*, i64, i64*)* %0, null, !dbg !4936
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4936

land.rhs:                                         ; preds = %entry
  %1 = load void (%struct.StreamBufferDef_t*, i64, i64*)*, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxReceiveCompletedCallback.addr, align 8, !dbg !4936
  %cmp1 = icmp eq void (%struct.StreamBufferDef_t*, i64, i64*)* %1, null, !dbg !4936
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %2 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4938
  %land.ext = zext i1 %2 to i32, !dbg !4936
  %cmp2 = icmp eq i32 %land.ext, 0, !dbg !4936
  br i1 %cmp2, label %if.then, label %if.end, !dbg !4939

if.then:                                          ; preds = %land.end
  call void @vAssertCalled(i8* getelementptr inbounds ([68 x i8], [68 x i8]* @.str, i64 0, i64 0), i64 3904), !dbg !4936
  br label %if.end, !dbg !4936

if.end:                                           ; preds = %if.then, %land.end
  %3 = load void (%struct.StreamBufferDef_t*, i64, i64*)*, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxSendCompletedCallback.addr, align 8, !dbg !4940
  %cmp3 = icmp eq void (%struct.StreamBufferDef_t*, i64, i64*)* %3, null, !dbg !4942
  br i1 %cmp3, label %land.lhs.true, label %if.else13, !dbg !4943

land.lhs.true:                                    ; preds = %if.end
  %4 = load void (%struct.StreamBufferDef_t*, i64, i64*)*, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxReceiveCompletedCallback.addr, align 8, !dbg !4944
  %cmp4 = icmp eq void (%struct.StreamBufferDef_t*, i64, i64*)* %4, null, !dbg !4945
  br i1 %cmp4, label %if.then5, label %if.else13, !dbg !4946

if.then5:                                         ; preds = %land.lhs.true
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !4947
  store i32 %call, i32* %lIndex, align 4, !dbg !4949
  %5 = load i32, i32* %lIndex, align 4, !dbg !4950
  %cmp6 = icmp ne i32 %5, -1, !dbg !4952
  br i1 %cmp6, label %if.then7, label %if.end12, !dbg !4953

if.then7:                                         ; preds = %if.then5
  %6 = load i64, i64* %xBufferSizeBytes.addr, align 8, !dbg !4954
  %7 = load i64, i64* %xTriggerLevelBytes.addr, align 8, !dbg !4956
  %8 = load i64, i64* %xIsMessageBuffer.addr, align 8, !dbg !4957
  %9 = load i8*, i8** %pucStreamBufferStorageArea.addr, align 8, !dbg !4958
  %10 = load %struct.xSTATIC_STREAM_BUFFER*, %struct.xSTATIC_STREAM_BUFFER** %pxStaticStreamBuffer.addr, align 8, !dbg !4959
  %call8 = call %struct.StreamBufferDef_t* @xStreamBufferGenericCreateStatic(i64 %6, i64 %7, i64 %8, i8* %9, %struct.xSTATIC_STREAM_BUFFER* %10, void (%struct.StreamBufferDef_t*, i64, i64*)* null, void (%struct.StreamBufferDef_t*, i64, i64*)* null), !dbg !4960
  store %struct.StreamBufferDef_t* %call8, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4961
  %11 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4962
  %cmp9 = icmp ne %struct.StreamBufferDef_t* %11, null, !dbg !4964
  br i1 %cmp9, label %if.then10, label %if.else, !dbg !4965

if.then10:                                        ; preds = %if.then7
  %12 = load i32, i32* %lIndex, align 4, !dbg !4966
  %13 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4966
  %14 = bitcast %struct.StreamBufferDef_t* %13 to %struct.OpaqueObject*, !dbg !4966
  call void @MPU_StoreHandleAndDataAtIndex(i32 %12, %struct.OpaqueObject* %14, i8* null, i32 3), !dbg !4966
  %15 = load i32, i32* %lIndex, align 4, !dbg !4968
  %add = add nsw i32 %15, 1, !dbg !4968
  %conv = sext i32 %add to i64, !dbg !4969
  %16 = inttoptr i64 %conv to %struct.StreamBufferDef_t*, !dbg !4969
  store %struct.StreamBufferDef_t* %16, %struct.StreamBufferDef_t** %xExternalStreamBufferHandle, align 8, !dbg !4970
  br label %if.end11, !dbg !4971

if.else:                                          ; preds = %if.then7
  %17 = load i32, i32* %lIndex, align 4, !dbg !4972
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %17), !dbg !4974
  br label %if.end11

if.end11:                                         ; preds = %if.else, %if.then10
  br label %if.end12, !dbg !4975

if.end12:                                         ; preds = %if.end11, %if.then5
  br label %if.end14, !dbg !4976

if.else13:                                        ; preds = %land.lhs.true, %if.end
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xExternalStreamBufferHandle, align 8, !dbg !4977
  br label %if.end14

if.end14:                                         ; preds = %if.else13, %if.end12
  %18 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xExternalStreamBufferHandle, align 8, !dbg !4979
  ret %struct.StreamBufferDef_t* %18, !dbg !4980
}

declare dso_local %struct.StreamBufferDef_t* @xStreamBufferGenericCreateStatic(i64, i64, i64, i8*, %struct.xSTATIC_STREAM_BUFFER*, void (%struct.StreamBufferDef_t*, i64, i64*)*, void (%struct.StreamBufferDef_t*, i64, i64*)*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vStreamBufferDelete(%struct.StreamBufferDef_t* %xStreamBuffer) #0 section "privileged_functions" !dbg !4981 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !4984, metadata !DIExpression()), !dbg !4985
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4986, metadata !DIExpression()), !dbg !4987
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4987
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4988, metadata !DIExpression()), !dbg !4989
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !4990
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !4991
  store i32 %1, i32* %lIndex, align 4, !dbg !4992
  %2 = load i32, i32* %lIndex, align 4, !dbg !4993
  %cmp = icmp sge i32 %2, 1, !dbg !4993
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4993

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4993
  %cmp1 = icmp slt i32 %3, 257, !dbg !4993
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4995
  %land.ext = zext i1 %4 to i32, !dbg !4993
  %conv = sext i32 %land.ext to i64, !dbg !4993
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4996
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4997

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4998
  %sub = sub nsw i32 %5, 1, !dbg !4998
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !4998
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !4998
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5000
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5001
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !5003
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !5004

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5005
  call void @vStreamBufferDelete(%struct.StreamBufferDef_t* %8), !dbg !5007
  br label %if.end, !dbg !5008

if.end:                                           ; preds = %if.then6, %if.then
  %9 = load i32, i32* %lIndex, align 4, !dbg !5009
  %sub7 = sub nsw i32 %9, 1, !dbg !5009
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %sub7), !dbg !5010
  br label %if.end8, !dbg !5011

if.end8:                                          ; preds = %if.end, %land.end
  ret void, !dbg !5012
}

declare dso_local void @vStreamBufferDelete(%struct.StreamBufferDef_t*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferReset(%struct.StreamBufferDef_t* %xStreamBuffer) #0 section "privileged_functions" !dbg !5013 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !5014, metadata !DIExpression()), !dbg !5015
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !5016, metadata !DIExpression()), !dbg !5017
  store i64 0, i64* %xReturn, align 8, !dbg !5017
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !5018, metadata !DIExpression()), !dbg !5019
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5019
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !5020, metadata !DIExpression()), !dbg !5021
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !5022
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !5023
  store i32 %1, i32* %lIndex, align 4, !dbg !5024
  %2 = load i32, i32* %lIndex, align 4, !dbg !5025
  %cmp = icmp sge i32 %2, 1, !dbg !5025
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !5025

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !5025
  %cmp1 = icmp slt i32 %3, 257, !dbg !5025
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !5027
  %land.ext = zext i1 %4 to i32, !dbg !5025
  %conv = sext i32 %land.ext to i64, !dbg !5025
  %cmp2 = icmp ne i64 %conv, 0, !dbg !5028
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !5029

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !5030
  %sub = sub nsw i32 %5, 1, !dbg !5030
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !5030
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !5030
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5032
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5033
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !5035
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !5036

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5037
  %call7 = call i64 @xStreamBufferReset(%struct.StreamBufferDef_t* %8), !dbg !5039
  store i64 %call7, i64* %xReturn, align 8, !dbg !5040
  br label %if.end, !dbg !5041

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !5042

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !5043
  ret i64 %9, !dbg !5044
}

declare dso_local i64 @xStreamBufferReset(%struct.StreamBufferDef_t*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferGetStaticBuffers(%struct.StreamBufferDef_t* %xStreamBuffers, i8* %ppucStreamBufferStorageArea, %struct.xSTATIC_STREAM_BUFFER* %ppxStaticStreamBuffer) #0 section "privileged_functions" !dbg !5045 {
entry:
  %xStreamBuffers.addr = alloca %struct.StreamBufferDef_t*, align 8
  %ppucStreamBufferStorageArea.addr = alloca i8*, align 8
  %ppxStaticStreamBuffer.addr = alloca %struct.xSTATIC_STREAM_BUFFER*, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffers, %struct.StreamBufferDef_t** %xStreamBuffers.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffers.addr, metadata !5048, metadata !DIExpression()), !dbg !5049
  store i8* %ppucStreamBufferStorageArea, i8** %ppucStreamBufferStorageArea.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %ppucStreamBufferStorageArea.addr, metadata !5050, metadata !DIExpression()), !dbg !5051
  store %struct.xSTATIC_STREAM_BUFFER* %ppxStaticStreamBuffer, %struct.xSTATIC_STREAM_BUFFER** %ppxStaticStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xSTATIC_STREAM_BUFFER** %ppxStaticStreamBuffer.addr, metadata !5052, metadata !DIExpression()), !dbg !5053
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !5054, metadata !DIExpression()), !dbg !5055
  store i64 0, i64* %xReturn, align 8, !dbg !5055
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !5056, metadata !DIExpression()), !dbg !5057
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5057
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !5058, metadata !DIExpression()), !dbg !5059
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffers.addr, align 8, !dbg !5060
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !5061
  store i32 %1, i32* %lIndex, align 4, !dbg !5062
  %2 = load i32, i32* %lIndex, align 4, !dbg !5063
  %cmp = icmp sge i32 %2, 1, !dbg !5063
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !5063

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !5063
  %cmp1 = icmp slt i32 %3, 257, !dbg !5063
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !5065
  %land.ext = zext i1 %4 to i32, !dbg !5063
  %conv = sext i32 %land.ext to i64, !dbg !5063
  %cmp2 = icmp ne i64 %conv, 0, !dbg !5066
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !5067

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !5068
  %sub = sub nsw i32 %5, 1, !dbg !5068
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !5068
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !5068
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5070
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5071
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !5073
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !5074

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5075
  %9 = load i8*, i8** %ppucStreamBufferStorageArea.addr, align 8, !dbg !5077
  %10 = load %struct.xSTATIC_STREAM_BUFFER*, %struct.xSTATIC_STREAM_BUFFER** %ppxStaticStreamBuffer.addr, align 8, !dbg !5078
  %call7 = call i64 @MPU_xStreamBufferGetStaticBuffers(%struct.StreamBufferDef_t* %8, i8* %9, %struct.xSTATIC_STREAM_BUFFER* %10), !dbg !5079
  store i64 %call7, i64* %xReturn, align 8, !dbg !5080
  br label %if.end, !dbg !5081

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !5082

if.end8:                                          ; preds = %if.end, %land.end
  %11 = load i64, i64* %xReturn, align 8, !dbg !5083
  ret i64 %11, !dbg !5084
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferSendFromISR(%struct.StreamBufferDef_t* %xStreamBuffer, i8* %pvTxData, i64 %xDataLengthBytes, i64* %pxHigherPriorityTaskWoken) #0 section "privileged_functions" !dbg !5085 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %pvTxData.addr = alloca i8*, align 8
  %xDataLengthBytes.addr = alloca i64, align 8
  %pxHigherPriorityTaskWoken.addr = alloca i64*, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !5088, metadata !DIExpression()), !dbg !5089
  store i8* %pvTxData, i8** %pvTxData.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvTxData.addr, metadata !5090, metadata !DIExpression()), !dbg !5091
  store i64 %xDataLengthBytes, i64* %xDataLengthBytes.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xDataLengthBytes.addr, metadata !5092, metadata !DIExpression()), !dbg !5093
  store i64* %pxHigherPriorityTaskWoken, i64** %pxHigherPriorityTaskWoken.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxHigherPriorityTaskWoken.addr, metadata !5094, metadata !DIExpression()), !dbg !5095
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !5096, metadata !DIExpression()), !dbg !5097
  store i64 0, i64* %xReturn, align 8, !dbg !5097
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !5098, metadata !DIExpression()), !dbg !5099
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5099
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !5100, metadata !DIExpression()), !dbg !5101
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !5102
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !5103
  store i32 %1, i32* %lIndex, align 4, !dbg !5104
  %2 = load i32, i32* %lIndex, align 4, !dbg !5105
  %cmp = icmp sge i32 %2, 1, !dbg !5105
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !5105

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !5105
  %cmp1 = icmp slt i32 %3, 257, !dbg !5105
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !5107
  %land.ext = zext i1 %4 to i32, !dbg !5105
  %conv = sext i32 %land.ext to i64, !dbg !5105
  %cmp2 = icmp ne i64 %conv, 0, !dbg !5108
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !5109

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !5110
  %sub = sub nsw i32 %5, 1, !dbg !5110
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !5110
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !5110
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5112
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5113
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !5115
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !5116

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5117
  %9 = load i8*, i8** %pvTxData.addr, align 8, !dbg !5119
  %10 = load i64, i64* %xDataLengthBytes.addr, align 8, !dbg !5120
  %11 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !5121
  %call7 = call i64 @xStreamBufferSendFromISR(%struct.StreamBufferDef_t* %8, i8* %9, i64 %10, i64* %11), !dbg !5122
  store i64 %call7, i64* %xReturn, align 8, !dbg !5123
  br label %if.end, !dbg !5124

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !5125

if.end8:                                          ; preds = %if.end, %land.end
  %12 = load i64, i64* %xReturn, align 8, !dbg !5126
  ret i64 %12, !dbg !5127
}

declare dso_local i64 @xStreamBufferSendFromISR(%struct.StreamBufferDef_t*, i8*, i64, i64*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferReceiveFromISR(%struct.StreamBufferDef_t* %xStreamBuffer, i8* %pvRxData, i64 %xBufferLengthBytes, i64* %pxHigherPriorityTaskWoken) #0 section "privileged_functions" !dbg !5128 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %pvRxData.addr = alloca i8*, align 8
  %xBufferLengthBytes.addr = alloca i64, align 8
  %pxHigherPriorityTaskWoken.addr = alloca i64*, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !5131, metadata !DIExpression()), !dbg !5132
  store i8* %pvRxData, i8** %pvRxData.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvRxData.addr, metadata !5133, metadata !DIExpression()), !dbg !5134
  store i64 %xBufferLengthBytes, i64* %xBufferLengthBytes.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xBufferLengthBytes.addr, metadata !5135, metadata !DIExpression()), !dbg !5136
  store i64* %pxHigherPriorityTaskWoken, i64** %pxHigherPriorityTaskWoken.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxHigherPriorityTaskWoken.addr, metadata !5137, metadata !DIExpression()), !dbg !5138
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !5139, metadata !DIExpression()), !dbg !5140
  store i64 0, i64* %xReturn, align 8, !dbg !5140
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !5141, metadata !DIExpression()), !dbg !5142
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5142
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !5143, metadata !DIExpression()), !dbg !5144
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !5145
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !5146
  store i32 %1, i32* %lIndex, align 4, !dbg !5147
  %2 = load i32, i32* %lIndex, align 4, !dbg !5148
  %cmp = icmp sge i32 %2, 1, !dbg !5148
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !5148

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !5148
  %cmp1 = icmp slt i32 %3, 257, !dbg !5148
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !5150
  %land.ext = zext i1 %4 to i32, !dbg !5148
  %conv = sext i32 %land.ext to i64, !dbg !5148
  %cmp2 = icmp ne i64 %conv, 0, !dbg !5151
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !5152

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !5153
  %sub = sub nsw i32 %5, 1, !dbg !5153
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !5153
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !5153
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5155
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5156
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !5158
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !5159

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5160
  %9 = load i8*, i8** %pvRxData.addr, align 8, !dbg !5162
  %10 = load i64, i64* %xBufferLengthBytes.addr, align 8, !dbg !5163
  %11 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !5164
  %call7 = call i64 @xStreamBufferReceiveFromISR(%struct.StreamBufferDef_t* %8, i8* %9, i64 %10, i64* %11), !dbg !5165
  store i64 %call7, i64* %xReturn, align 8, !dbg !5166
  br label %if.end, !dbg !5167

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !5168

if.end8:                                          ; preds = %if.end, %land.end
  %12 = load i64, i64* %xReturn, align 8, !dbg !5169
  ret i64 %12, !dbg !5170
}

declare dso_local i64 @xStreamBufferReceiveFromISR(%struct.StreamBufferDef_t*, i8*, i64, i64*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferSendCompletedFromISR(%struct.StreamBufferDef_t* %xStreamBuffer, i64* %pxHigherPriorityTaskWoken) #0 section "privileged_functions" !dbg !5171 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %pxHigherPriorityTaskWoken.addr = alloca i64*, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !5174, metadata !DIExpression()), !dbg !5175
  store i64* %pxHigherPriorityTaskWoken, i64** %pxHigherPriorityTaskWoken.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxHigherPriorityTaskWoken.addr, metadata !5176, metadata !DIExpression()), !dbg !5177
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !5178, metadata !DIExpression()), !dbg !5179
  store i64 0, i64* %xReturn, align 8, !dbg !5179
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !5180, metadata !DIExpression()), !dbg !5181
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5181
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !5182, metadata !DIExpression()), !dbg !5183
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !5184
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !5185
  store i32 %1, i32* %lIndex, align 4, !dbg !5186
  %2 = load i32, i32* %lIndex, align 4, !dbg !5187
  %cmp = icmp sge i32 %2, 1, !dbg !5187
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !5187

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !5187
  %cmp1 = icmp slt i32 %3, 257, !dbg !5187
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !5189
  %land.ext = zext i1 %4 to i32, !dbg !5187
  %conv = sext i32 %land.ext to i64, !dbg !5187
  %cmp2 = icmp ne i64 %conv, 0, !dbg !5190
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !5191

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !5192
  %sub = sub nsw i32 %5, 1, !dbg !5192
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !5192
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !5192
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5194
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5195
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !5197
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !5198

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5199
  %9 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !5201
  %call7 = call i64 @xStreamBufferSendCompletedFromISR(%struct.StreamBufferDef_t* %8, i64* %9), !dbg !5202
  store i64 %call7, i64* %xReturn, align 8, !dbg !5203
  br label %if.end, !dbg !5204

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !5205

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !5206
  ret i64 %10, !dbg !5207
}

declare dso_local i64 @xStreamBufferSendCompletedFromISR(%struct.StreamBufferDef_t*, i64*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferReceiveCompletedFromISR(%struct.StreamBufferDef_t* %xStreamBuffer, i64* %pxHigherPriorityTaskWoken) #0 section "privileged_functions" !dbg !5208 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %pxHigherPriorityTaskWoken.addr = alloca i64*, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !5209, metadata !DIExpression()), !dbg !5210
  store i64* %pxHigherPriorityTaskWoken, i64** %pxHigherPriorityTaskWoken.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxHigherPriorityTaskWoken.addr, metadata !5211, metadata !DIExpression()), !dbg !5212
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !5213, metadata !DIExpression()), !dbg !5214
  store i64 0, i64* %xReturn, align 8, !dbg !5214
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !5215, metadata !DIExpression()), !dbg !5216
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5216
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !5217, metadata !DIExpression()), !dbg !5218
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !5219
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !5220
  store i32 %1, i32* %lIndex, align 4, !dbg !5221
  %2 = load i32, i32* %lIndex, align 4, !dbg !5222
  %cmp = icmp sge i32 %2, 1, !dbg !5222
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !5222

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !5222
  %cmp1 = icmp slt i32 %3, 257, !dbg !5222
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !5224
  %land.ext = zext i1 %4 to i32, !dbg !5222
  %conv = sext i32 %land.ext to i64, !dbg !5222
  %cmp2 = icmp ne i64 %conv, 0, !dbg !5225
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !5226

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !5227
  %sub = sub nsw i32 %5, 1, !dbg !5227
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !5227
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !5227
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5229
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5230
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !5232
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !5233

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5234
  %9 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !5236
  %call7 = call i64 @xStreamBufferReceiveCompletedFromISR(%struct.StreamBufferDef_t* %8, i64* %9), !dbg !5237
  store i64 %call7, i64* %xReturn, align 8, !dbg !5238
  br label %if.end, !dbg !5239

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !5240

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !5241
  ret i64 %10, !dbg !5242
}

declare dso_local i64 @xStreamBufferReceiveCompletedFromISR(%struct.StreamBufferDef_t*, i64*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64* @pxPortInitialiseStack(i64* %pxTopOfStack, i64* %pxEndOfStack, void (i8*)* %pxCode, i8* %pvParameters) #0 !dbg !5243 {
entry:
  %pxTopOfStack.addr = alloca i64*, align 8
  %pxEndOfStack.addr = alloca i64*, align 8
  %pxCode.addr = alloca void (i8*)*, align 8
  %pvParameters.addr = alloca i8*, align 8
  %thread = alloca %struct.THREAD*, align 8
  %xThreadAttributes = alloca %union.pthread_attr_t, align 8
  %ulStackSize = alloca i64, align 8
  %iRet = alloca i32, align 4
  store i64* %pxTopOfStack, i64** %pxTopOfStack.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxTopOfStack.addr, metadata !5246, metadata !DIExpression()), !dbg !5247
  store i64* %pxEndOfStack, i64** %pxEndOfStack.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxEndOfStack.addr, metadata !5248, metadata !DIExpression()), !dbg !5249
  store void (i8*)* %pxCode, void (i8*)** %pxCode.addr, align 8
  call void @llvm.dbg.declare(metadata void (i8*)** %pxCode.addr, metadata !5250, metadata !DIExpression()), !dbg !5251
  store i8* %pvParameters, i8** %pvParameters.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvParameters.addr, metadata !5252, metadata !DIExpression()), !dbg !5253
  call void @llvm.dbg.declare(metadata %struct.THREAD** %thread, metadata !5254, metadata !DIExpression()), !dbg !5255
  call void @llvm.dbg.declare(metadata %union.pthread_attr_t* %xThreadAttributes, metadata !5256, metadata !DIExpression()), !dbg !5265
  call void @llvm.dbg.declare(metadata i64* %ulStackSize, metadata !5266, metadata !DIExpression()), !dbg !5267
  call void @llvm.dbg.declare(metadata i32* %iRet, metadata !5268, metadata !DIExpression()), !dbg !5269
  %call = call i32 @pthread_once(i32* @hSigSetupThread, void ()* @prvSetupSignalsAndSchedulerPolicy), !dbg !5270
  %0 = load i64*, i64** %pxTopOfStack.addr, align 8, !dbg !5271
  %add.ptr = getelementptr inbounds i64, i64* %0, i64 1, !dbg !5272
  %1 = bitcast i64* %add.ptr to %struct.THREAD*, !dbg !5273
  %add.ptr1 = getelementptr inbounds %struct.THREAD, %struct.THREAD* %1, i64 -1, !dbg !5274
  store %struct.THREAD* %add.ptr1, %struct.THREAD** %thread, align 8, !dbg !5275
  %2 = load %struct.THREAD*, %struct.THREAD** %thread, align 8, !dbg !5276
  %3 = bitcast %struct.THREAD* %2 to i64*, !dbg !5277
  %add.ptr2 = getelementptr inbounds i64, i64* %3, i64 -1, !dbg !5278
  store i64* %add.ptr2, i64** %pxTopOfStack.addr, align 8, !dbg !5279
  %4 = load i64*, i64** %pxTopOfStack.addr, align 8, !dbg !5280
  %add.ptr3 = getelementptr inbounds i64, i64* %4, i64 1, !dbg !5281
  %5 = load i64*, i64** %pxEndOfStack.addr, align 8, !dbg !5282
  %sub.ptr.lhs.cast = ptrtoint i64* %add.ptr3 to i64, !dbg !5283
  %sub.ptr.rhs.cast = ptrtoint i64* %5 to i64, !dbg !5283
  %sub.ptr.sub = sub i64 %sub.ptr.lhs.cast, %sub.ptr.rhs.cast, !dbg !5283
  %sub.ptr.div = sdiv exact i64 %sub.ptr.sub, 8, !dbg !5283
  %mul = mul i64 %sub.ptr.div, 8, !dbg !5284
  store i64 %mul, i64* %ulStackSize, align 8, !dbg !5285
  %6 = load void (i8*)*, void (i8*)** %pxCode.addr, align 8, !dbg !5286
  %7 = load %struct.THREAD*, %struct.THREAD** %thread, align 8, !dbg !5287
  %pxCode4 = getelementptr inbounds %struct.THREAD, %struct.THREAD* %7, i32 0, i32 1, !dbg !5288
  store void (i8*)* %6, void (i8*)** %pxCode4, align 8, !dbg !5289
  %8 = load i8*, i8** %pvParameters.addr, align 8, !dbg !5290
  %9 = load %struct.THREAD*, %struct.THREAD** %thread, align 8, !dbg !5291
  %pvParams = getelementptr inbounds %struct.THREAD, %struct.THREAD* %9, i32 0, i32 2, !dbg !5292
  store i8* %8, i8** %pvParams, align 8, !dbg !5293
  %10 = load %struct.THREAD*, %struct.THREAD** %thread, align 8, !dbg !5294
  %xDying = getelementptr inbounds %struct.THREAD, %struct.THREAD* %10, i32 0, i32 3, !dbg !5295
  store i64 0, i64* %xDying, align 8, !dbg !5296
  %call5 = call i32 @pthread_attr_init(%union.pthread_attr_t* %xThreadAttributes) #7, !dbg !5297
  %11 = load i64*, i64** %pxEndOfStack.addr, align 8, !dbg !5298
  %12 = bitcast i64* %11 to i8*, !dbg !5298
  %13 = load i64, i64* %ulStackSize, align 8, !dbg !5299
  %call6 = call i32 @pthread_attr_setstack(%union.pthread_attr_t* %xThreadAttributes, i8* %12, i64 %13) #7, !dbg !5300
  store i32 %call6, i32* %iRet, align 4, !dbg !5301
  %14 = load i32, i32* %iRet, align 4, !dbg !5302
  %cmp = icmp ne i32 %14, 0, !dbg !5304
  br i1 %cmp, label %if.then, label %if.end, !dbg !5305

if.then:                                          ; preds = %entry
  %15 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8, !dbg !5306
  %16 = load i32, i32* %iRet, align 4, !dbg !5308
  %call7 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %15, i8* getelementptr inbounds ([88 x i8], [88 x i8]* @.str.1, i64 0, i64 0), i32 %16), !dbg !5309
  %17 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8, !dbg !5310
  %call8 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %17, i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.1.2, i64 0, i64 0)), !dbg !5311
  br label %if.end, !dbg !5312

if.end:                                           ; preds = %if.then, %entry
  %call9 = call %struct.event* @event_create(), !dbg !5313
  %18 = load %struct.THREAD*, %struct.THREAD** %thread, align 8, !dbg !5314
  %ev = getelementptr inbounds %struct.THREAD, %struct.THREAD* %18, i32 0, i32 4, !dbg !5315
  store %struct.event* %call9, %struct.event** %ev, align 8, !dbg !5316
  call void @vPortEnterCritical(), !dbg !5317
  %19 = load %struct.THREAD*, %struct.THREAD** %thread, align 8, !dbg !5318
  %pthread = getelementptr inbounds %struct.THREAD, %struct.THREAD* %19, i32 0, i32 0, !dbg !5319
  %20 = load %struct.THREAD*, %struct.THREAD** %thread, align 8, !dbg !5320
  %21 = bitcast %struct.THREAD* %20 to i8*, !dbg !5320
  %call10 = call i32 @pthread_create(i64* %pthread, %union.pthread_attr_t* %xThreadAttributes, i8* (i8*)* @prvWaitForStart, i8* %21) #7, !dbg !5321
  store i32 %call10, i32* %iRet, align 4, !dbg !5322
  %22 = load i32, i32* %iRet, align 4, !dbg !5323
  %cmp11 = icmp ne i32 %22, 0, !dbg !5325
  br i1 %cmp11, label %if.then12, label %if.end13, !dbg !5326

if.then12:                                        ; preds = %if.end
  %23 = load i32, i32* %iRet, align 4, !dbg !5327
  call void @prvFatalError(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.2, i64 0, i64 0), i32 %23) #8, !dbg !5329
  unreachable, !dbg !5329

if.end13:                                         ; preds = %if.end
  call void @vPortExitCritical(), !dbg !5330
  %24 = load i64*, i64** %pxTopOfStack.addr, align 8, !dbg !5331
  ret i64* %24, !dbg !5332
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @prvSetupSignalsAndSchedulerPolicy() #0 !dbg !5333 {
entry:
  %sigtick = alloca %struct.sigaction, align 8
  %iRet = alloca i32, align 4
  call void @llvm.dbg.declare(metadata %struct.sigaction* %sigtick, metadata !5336, metadata !DIExpression()), !dbg !5428
  call void @llvm.dbg.declare(metadata i32* %iRet, metadata !5429, metadata !DIExpression()), !dbg !5430
  %call = call i64 @pthread_self() #9, !dbg !5431
  store i64 %call, i64* @hMainThread, align 8, !dbg !5432
  %call1 = call i32 @sigfillset(%struct.__sigset_t* @xAllSignals) #7, !dbg !5433
  %call2 = call i32 @sigdelset(%struct.__sigset_t* @xAllSignals, i32 2) #7, !dbg !5434
  %call3 = call i32 @pthread_sigmask(i32 2, %struct.__sigset_t* @xAllSignals, %struct.__sigset_t* @xSchedulerOriginalSignalMask) #7, !dbg !5435
  %sa_flags = getelementptr inbounds %struct.sigaction, %struct.sigaction* %sigtick, i32 0, i32 2, !dbg !5436
  store i32 0, i32* %sa_flags, align 8, !dbg !5437
  %__sigaction_handler = getelementptr inbounds %struct.sigaction, %struct.sigaction* %sigtick, i32 0, i32 0, !dbg !5438
  %sa_handler = bitcast %union.anon.1* %__sigaction_handler to void (i32)**, !dbg !5438
  store void (i32)* @vPortSystemTickHandler, void (i32)** %sa_handler, align 8, !dbg !5439
  %sa_mask = getelementptr inbounds %struct.sigaction, %struct.sigaction* %sigtick, i32 0, i32 1, !dbg !5440
  %call4 = call i32 @sigfillset(%struct.__sigset_t* %sa_mask) #7, !dbg !5441
  %call5 = call i32 @sigaction(i32 14, %struct.sigaction* %sigtick, %struct.sigaction* null) #7, !dbg !5442
  store i32 %call5, i32* %iRet, align 4, !dbg !5443
  %0 = load i32, i32* %iRet, align 4, !dbg !5444
  %cmp = icmp eq i32 %0, -1, !dbg !5446
  br i1 %cmp, label %if.then, label %if.end, !dbg !5447

if.then:                                          ; preds = %entry
  %call6 = call i32* @__errno_location() #9, !dbg !5448
  %1 = load i32, i32* %call6, align 4, !dbg !5448
  call void @prvFatalError(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.7, i64 0, i64 0), i32 %1) #8, !dbg !5450
  unreachable, !dbg !5450

if.end:                                           ; preds = %entry
  ret void, !dbg !5451
}

declare dso_local i32 @pthread_once(i32*, void ()*) #2

; Function Attrs: nounwind
declare dso_local i32 @pthread_attr_init(%union.pthread_attr_t*) #3

; Function Attrs: nounwind
declare dso_local i32 @pthread_attr_setstack(%union.pthread_attr_t*, i8*, i64) #3

declare dso_local i32 @fprintf(%struct._IO_FILE*, i8*, ...) #2

declare dso_local %struct.event* @event_create() #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @vPortEnterCritical() #0 !dbg !5452 {
entry:
  %0 = load volatile i64, i64* @uxCriticalNesting, align 8, !dbg !5453
  %cmp = icmp eq i64 %0, 0, !dbg !5455
  br i1 %cmp, label %if.then, label %if.end, !dbg !5456

if.then:                                          ; preds = %entry
  call void @vPortDisableInterrupts(), !dbg !5457
  br label %if.end, !dbg !5459

if.end:                                           ; preds = %if.then, %entry
  %1 = load volatile i64, i64* @uxCriticalNesting, align 8, !dbg !5460
  %inc = add nsw i64 %1, 1, !dbg !5460
  store volatile i64 %inc, i64* @uxCriticalNesting, align 8, !dbg !5460
  ret void, !dbg !5461
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i8* @prvWaitForStart(i8* %pvParams) #0 !dbg !5462 {
entry:
  %pvParams.addr = alloca i8*, align 8
  %pxThread = alloca %struct.THREAD*, align 8
  store i8* %pvParams, i8** %pvParams.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvParams.addr, metadata !5465, metadata !DIExpression()), !dbg !5466
  call void @llvm.dbg.declare(metadata %struct.THREAD** %pxThread, metadata !5467, metadata !DIExpression()), !dbg !5468
  %0 = load i8*, i8** %pvParams.addr, align 8, !dbg !5469
  %1 = bitcast i8* %0 to %struct.THREAD*, !dbg !5469
  store %struct.THREAD* %1, %struct.THREAD** %pxThread, align 8, !dbg !5468
  %2 = load %struct.THREAD*, %struct.THREAD** %pxThread, align 8, !dbg !5470
  call void @prvSuspendSelf(%struct.THREAD* %2), !dbg !5471
  store volatile i64 0, i64* @uxCriticalNesting, align 8, !dbg !5472
  call void @vPortEnableInterrupts(), !dbg !5473
  %3 = load %struct.THREAD*, %struct.THREAD** %pxThread, align 8, !dbg !5474
  %pxCode = getelementptr inbounds %struct.THREAD, %struct.THREAD* %3, i32 0, i32 1, !dbg !5475
  %4 = load void (i8*)*, void (i8*)** %pxCode, align 8, !dbg !5475
  %5 = load %struct.THREAD*, %struct.THREAD** %pxThread, align 8, !dbg !5476
  %pvParams1 = getelementptr inbounds %struct.THREAD, %struct.THREAD* %5, i32 0, i32 2, !dbg !5477
  %6 = load i8*, i8** %pvParams1, align 8, !dbg !5477
  call void %4(i8* %6), !dbg !5474
  call void @vAssertCalled(i8* getelementptr inbounds ([72 x i8], [72 x i8]* @.str.6, i64 0, i64 0), i64 484), !dbg !5478
  ret i8* null, !dbg !5480
}

; Function Attrs: nounwind
declare !callback !5481 dso_local i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) #3

; Function Attrs: noinline noreturn nounwind optnone uwtable
define internal void @prvFatalError(i8* %pcCall, i32 %iErrno) #4 !dbg !5483 {
entry:
  %pcCall.addr = alloca i8*, align 8
  %iErrno.addr = alloca i32, align 4
  store i8* %pcCall, i8** %pcCall.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pcCall.addr, metadata !5486, metadata !DIExpression()), !dbg !5487
  store i32 %iErrno, i32* %iErrno.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %iErrno.addr, metadata !5488, metadata !DIExpression()), !dbg !5489
  %0 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8, !dbg !5490
  %1 = load i8*, i8** %pcCall.addr, align 8, !dbg !5491
  %2 = load i32, i32* %iErrno.addr, align 4, !dbg !5492
  %call = call i8* @strerror(i32 %2) #7, !dbg !5493
  %call1 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %0, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.3, i64 0, i64 0), i8* %1, i8* %call), !dbg !5494
  call void @abort() #10, !dbg !5495
  unreachable, !dbg !5495
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @vPortExitCritical() #0 !dbg !5496 {
entry:
  %0 = load volatile i64, i64* @uxCriticalNesting, align 8, !dbg !5497
  %dec = add nsw i64 %0, -1, !dbg !5497
  store volatile i64 %dec, i64* @uxCriticalNesting, align 8, !dbg !5497
  %1 = load volatile i64, i64* @uxCriticalNesting, align 8, !dbg !5498
  %cmp = icmp eq i64 %1, 0, !dbg !5500
  br i1 %cmp, label %if.then, label %if.end, !dbg !5501

if.then:                                          ; preds = %entry
  call void @vPortEnableInterrupts(), !dbg !5502
  br label %if.end, !dbg !5504

if.end:                                           ; preds = %if.then, %entry
  ret void, !dbg !5505
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @vPortEnableInterrupts() #0 !dbg !5506 {
entry:
  %call = call i32 @pthread_sigmask(i32 1, %struct.__sigset_t* @xAllSignals, %struct.__sigset_t* null) #7, !dbg !5507
  ret void, !dbg !5508
}

; Function Attrs: nounwind
declare dso_local i32 @pthread_sigmask(i32, %struct.__sigset_t*, %struct.__sigset_t*) #3

; Function Attrs: nounwind
declare dso_local i8* @strerror(i32) #3

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #5

; Function Attrs: noinline nounwind optnone uwtable
define internal void @prvSuspendSelf(%struct.THREAD* %thread) #0 !dbg !5509 {
entry:
  %thread.addr = alloca %struct.THREAD*, align 8
  store %struct.THREAD* %thread, %struct.THREAD** %thread.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.THREAD** %thread.addr, metadata !5512, metadata !DIExpression()), !dbg !5513
  %0 = load %struct.THREAD*, %struct.THREAD** %thread.addr, align 8, !dbg !5514
  %ev = getelementptr inbounds %struct.THREAD, %struct.THREAD* %0, i32 0, i32 4, !dbg !5515
  %1 = load %struct.event*, %struct.event** %ev, align 8, !dbg !5515
  %call = call zeroext i1 @event_wait(%struct.event* %1), !dbg !5516
  ret void, !dbg !5517
}

declare dso_local zeroext i1 @event_wait(%struct.event*) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @vPortDisableInterrupts() #0 !dbg !5518 {
entry:
  %call = call i32 @pthread_sigmask(i32 0, %struct.__sigset_t* @xAllSignals, %struct.__sigset_t* null) #7, !dbg !5519
  ret void, !dbg !5520
}

; Function Attrs: nounwind readnone
declare dso_local i64 @pthread_self() #6

; Function Attrs: nounwind
declare dso_local i32 @sigfillset(%struct.__sigset_t*) #3

; Function Attrs: nounwind
declare dso_local i32 @sigdelset(%struct.__sigset_t*, i32) #3

; Function Attrs: noinline nounwind optnone uwtable
define internal void @vPortSystemTickHandler(i32 %sig) #0 !dbg !5521 {
entry:
  %sig.addr = alloca i32, align 4
  %pxThreadToSuspend = alloca %struct.THREAD*, align 8
  %pxThreadToResume = alloca %struct.THREAD*, align 8
  store i32 %sig, i32* %sig.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %sig.addr, metadata !5522, metadata !DIExpression()), !dbg !5523
  call void @llvm.dbg.declare(metadata %struct.THREAD** %pxThreadToSuspend, metadata !5524, metadata !DIExpression()), !dbg !5525
  call void @llvm.dbg.declare(metadata %struct.THREAD** %pxThreadToResume, metadata !5526, metadata !DIExpression()), !dbg !5527
  %0 = load i32, i32* %sig.addr, align 4, !dbg !5528
  %1 = load volatile i64, i64* @uxCriticalNesting, align 8, !dbg !5529
  %inc = add nsw i64 %1, 1, !dbg !5529
  store volatile i64 %inc, i64* @uxCriticalNesting, align 8, !dbg !5529
  %call = call %struct.tskTaskControlBlock* @xTaskGetCurrentTaskHandle(), !dbg !5530
  %call1 = call %struct.THREAD* @prvGetThreadFromTask(%struct.tskTaskControlBlock* %call), !dbg !5531
  store %struct.THREAD* %call1, %struct.THREAD** %pxThreadToSuspend, align 8, !dbg !5532
  %call2 = call i64 @xTaskIncrementTick(), !dbg !5533
  call void @vTaskSwitchContext(), !dbg !5534
  %call3 = call %struct.tskTaskControlBlock* @xTaskGetCurrentTaskHandle(), !dbg !5535
  %call4 = call %struct.THREAD* @prvGetThreadFromTask(%struct.tskTaskControlBlock* %call3), !dbg !5536
  store %struct.THREAD* %call4, %struct.THREAD** %pxThreadToResume, align 8, !dbg !5537
  %2 = load %struct.THREAD*, %struct.THREAD** %pxThreadToResume, align 8, !dbg !5538
  %3 = load %struct.THREAD*, %struct.THREAD** %pxThreadToSuspend, align 8, !dbg !5539
  call void @prvSwitchThread(%struct.THREAD* %2, %struct.THREAD* %3), !dbg !5540
  %4 = load volatile i64, i64* @uxCriticalNesting, align 8, !dbg !5541
  %dec = add nsw i64 %4, -1, !dbg !5541
  store volatile i64 %dec, i64* @uxCriticalNesting, align 8, !dbg !5541
  ret void, !dbg !5542
}

; Function Attrs: nounwind
declare dso_local i32 @sigaction(i32, %struct.sigaction*, %struct.sigaction*) #3

; Function Attrs: nounwind readnone
declare dso_local i32* @__errno_location() #6

; Function Attrs: noinline nounwind optnone uwtable
define internal %struct.THREAD* @prvGetThreadFromTask(%struct.tskTaskControlBlock* %xTask) #0 !dbg !5543 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %pxTopOfStack = alloca i64*, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !5546, metadata !DIExpression()), !dbg !5547
  call void @llvm.dbg.declare(metadata i64** %pxTopOfStack, metadata !5548, metadata !DIExpression()), !dbg !5549
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !5550
  %1 = bitcast %struct.tskTaskControlBlock* %0 to i64**, !dbg !5551
  %2 = load i64*, i64** %1, align 8, !dbg !5551
  store i64* %2, i64** %pxTopOfStack, align 8, !dbg !5549
  %3 = load i64*, i64** %pxTopOfStack, align 8, !dbg !5552
  %add.ptr = getelementptr inbounds i64, i64* %3, i64 1, !dbg !5553
  %4 = bitcast i64* %add.ptr to %struct.THREAD*, !dbg !5554
  ret %struct.THREAD* %4, !dbg !5555
}

declare dso_local i64 @xTaskIncrementTick() #2

declare dso_local void @vTaskSwitchContext() #2

; Function Attrs: noinline nounwind optnone uwtable
define internal void @prvSwitchThread(%struct.THREAD* %pxThreadToResume, %struct.THREAD* %pxThreadToSuspend) #0 !dbg !5556 {
entry:
  %pxThreadToResume.addr = alloca %struct.THREAD*, align 8
  %pxThreadToSuspend.addr = alloca %struct.THREAD*, align 8
  %uxSavedCriticalNesting = alloca i64, align 8
  store %struct.THREAD* %pxThreadToResume, %struct.THREAD** %pxThreadToResume.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.THREAD** %pxThreadToResume.addr, metadata !5559, metadata !DIExpression()), !dbg !5560
  store %struct.THREAD* %pxThreadToSuspend, %struct.THREAD** %pxThreadToSuspend.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.THREAD** %pxThreadToSuspend.addr, metadata !5561, metadata !DIExpression()), !dbg !5562
  call void @llvm.dbg.declare(metadata i64* %uxSavedCriticalNesting, metadata !5563, metadata !DIExpression()), !dbg !5564
  %0 = load %struct.THREAD*, %struct.THREAD** %pxThreadToSuspend.addr, align 8, !dbg !5565
  %1 = load %struct.THREAD*, %struct.THREAD** %pxThreadToResume.addr, align 8, !dbg !5567
  %cmp = icmp ne %struct.THREAD* %0, %1, !dbg !5568
  br i1 %cmp, label %if.then, label %if.end3, !dbg !5569

if.then:                                          ; preds = %entry
  %2 = load volatile i64, i64* @uxCriticalNesting, align 8, !dbg !5570
  store i64 %2, i64* %uxSavedCriticalNesting, align 8, !dbg !5572
  %3 = load %struct.THREAD*, %struct.THREAD** %pxThreadToResume.addr, align 8, !dbg !5573
  call void @prvResumeThread(%struct.THREAD* %3), !dbg !5574
  %4 = load %struct.THREAD*, %struct.THREAD** %pxThreadToSuspend.addr, align 8, !dbg !5575
  %xDying = getelementptr inbounds %struct.THREAD, %struct.THREAD* %4, i32 0, i32 3, !dbg !5577
  %5 = load i64, i64* %xDying, align 8, !dbg !5577
  %cmp1 = icmp eq i64 %5, 1, !dbg !5578
  br i1 %cmp1, label %if.then2, label %if.end, !dbg !5579

if.then2:                                         ; preds = %if.then
  br label %if.end, !dbg !5580

if.end:                                           ; preds = %if.then2, %if.then
  %6 = load %struct.THREAD*, %struct.THREAD** %pxThreadToSuspend.addr, align 8, !dbg !5582
  call void @prvSuspendSelf(%struct.THREAD* %6), !dbg !5583
  %7 = load i64, i64* %uxSavedCriticalNesting, align 8, !dbg !5584
  store volatile i64 %7, i64* @uxCriticalNesting, align 8, !dbg !5585
  br label %if.end3, !dbg !5586

if.end3:                                          ; preds = %if.end, %entry
  ret void, !dbg !5587
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @prvResumeThread(%struct.THREAD* %xThreadId) #0 !dbg !5588 {
entry:
  %xThreadId.addr = alloca %struct.THREAD*, align 8
  store %struct.THREAD* %xThreadId, %struct.THREAD** %xThreadId.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.THREAD** %xThreadId.addr, metadata !5589, metadata !DIExpression()), !dbg !5590
  %call = call i64 @pthread_self() #9, !dbg !5591
  %0 = load %struct.THREAD*, %struct.THREAD** %xThreadId.addr, align 8, !dbg !5593
  %pthread = getelementptr inbounds %struct.THREAD, %struct.THREAD* %0, i32 0, i32 0, !dbg !5594
  %1 = load i64, i64* %pthread, align 8, !dbg !5594
  %cmp = icmp ne i64 %call, %1, !dbg !5595
  br i1 %cmp, label %if.then, label %if.end, !dbg !5596

if.then:                                          ; preds = %entry
  %2 = load %struct.THREAD*, %struct.THREAD** %xThreadId.addr, align 8, !dbg !5597
  %ev = getelementptr inbounds %struct.THREAD, %struct.THREAD* %2, i32 0, i32 4, !dbg !5599
  %3 = load %struct.event*, %struct.event** %ev, align 8, !dbg !5599
  call void @event_signal(%struct.event* %3), !dbg !5600
  br label %if.end, !dbg !5601

if.end:                                           ; preds = %if.then, %entry
  ret void, !dbg !5602
}

declare dso_local void @event_signal(%struct.event*) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @xPortStartScheduler() #0 !dbg !5603 {
entry:
  %iSignal = alloca i32, align 4
  %xSignals = alloca %struct.__sigset_t, align 8
  call void @llvm.dbg.declare(metadata i32* %iSignal, metadata !5604, metadata !DIExpression()), !dbg !5605
  call void @llvm.dbg.declare(metadata %struct.__sigset_t* %xSignals, metadata !5606, metadata !DIExpression()), !dbg !5607
  %call = call i64 @pthread_self() #9, !dbg !5608
  store i64 %call, i64* @hMainThread, align 8, !dbg !5609
  call void @prvSetupTimerInterrupt(), !dbg !5610
  %call1 = call i32 @sigemptyset(%struct.__sigset_t* %xSignals) #7, !dbg !5611
  %call2 = call i32 @sigaddset(%struct.__sigset_t* %xSignals, i32 10) #7, !dbg !5612
  %call3 = call i32 @pthread_sigmask(i32 0, %struct.__sigset_t* %xSignals, %struct.__sigset_t* null) #7, !dbg !5613
  call void @vPortStartFirstTask(), !dbg !5614
  br label %while.cond, !dbg !5615

while.cond:                                       ; preds = %while.body, %entry
  %0 = load i64, i64* @xSchedulerEnd, align 8, !dbg !5616
  %cmp = icmp ne i64 %0, 1, !dbg !5617
  br i1 %cmp, label %while.body, label %while.end, !dbg !5615

while.body:                                       ; preds = %while.cond
  %call4 = call i32 @sigwait(%struct.__sigset_t* %xSignals, i32* %iSignal), !dbg !5618
  br label %while.cond, !dbg !5615, !llvm.loop !5620

while.end:                                        ; preds = %while.cond
  %call5 = call %struct.tskTaskControlBlock* @xTaskGetIdleTaskHandle(), !dbg !5622
  %1 = bitcast %struct.tskTaskControlBlock* %call5 to i8*, !dbg !5622
  call void @vPortCancelThread(i8* %1), !dbg !5623
  %call6 = call %struct.tskTaskControlBlock* @xTimerGetTimerDaemonTaskHandle(), !dbg !5624
  %2 = bitcast %struct.tskTaskControlBlock* %call6 to i8*, !dbg !5624
  call void @vPortCancelThread(i8* %2), !dbg !5625
  %call7 = call i32 @pthread_sigmask(i32 2, %struct.__sigset_t* @xSchedulerOriginalSignalMask, %struct.__sigset_t* null) #7, !dbg !5626
  ret i64 0, !dbg !5627
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @prvSetupTimerInterrupt() #0 !dbg !5628 {
entry:
  %itimer = alloca %struct.itimerval, align 8
  %iRet = alloca i32, align 4
  call void @llvm.dbg.declare(metadata %struct.itimerval* %itimer, metadata !5629, metadata !DIExpression()), !dbg !5641
  call void @llvm.dbg.declare(metadata i32* %iRet, metadata !5642, metadata !DIExpression()), !dbg !5643
  %call = call i32 @getitimer(i32 0, %struct.itimerval* %itimer) #7, !dbg !5644
  store i32 %call, i32* %iRet, align 4, !dbg !5645
  %0 = load i32, i32* %iRet, align 4, !dbg !5646
  %cmp = icmp eq i32 %0, -1, !dbg !5648
  br i1 %cmp, label %if.then, label %if.end, !dbg !5649

if.then:                                          ; preds = %entry
  %call1 = call i32* @__errno_location() #9, !dbg !5650
  %1 = load i32, i32* %call1, align 4, !dbg !5650
  call void @prvFatalError(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.4, i64 0, i64 0), i32 %1) #8, !dbg !5652
  unreachable, !dbg !5652

if.end:                                           ; preds = %entry
  %it_interval = getelementptr inbounds %struct.itimerval, %struct.itimerval* %itimer, i32 0, i32 0, !dbg !5653
  %tv_sec = getelementptr inbounds %struct.xTIME_OUT, %struct.xTIME_OUT* %it_interval, i32 0, i32 0, !dbg !5654
  store i64 0, i64* %tv_sec, align 8, !dbg !5655
  %it_interval2 = getelementptr inbounds %struct.itimerval, %struct.itimerval* %itimer, i32 0, i32 0, !dbg !5656
  %tv_usec = getelementptr inbounds %struct.xTIME_OUT, %struct.xTIME_OUT* %it_interval2, i32 0, i32 1, !dbg !5657
  store i64 4000, i64* %tv_usec, align 8, !dbg !5658
  %it_value = getelementptr inbounds %struct.itimerval, %struct.itimerval* %itimer, i32 0, i32 1, !dbg !5659
  %tv_sec3 = getelementptr inbounds %struct.xTIME_OUT, %struct.xTIME_OUT* %it_value, i32 0, i32 0, !dbg !5660
  store i64 0, i64* %tv_sec3, align 8, !dbg !5661
  %it_value4 = getelementptr inbounds %struct.itimerval, %struct.itimerval* %itimer, i32 0, i32 1, !dbg !5662
  %tv_usec5 = getelementptr inbounds %struct.xTIME_OUT, %struct.xTIME_OUT* %it_value4, i32 0, i32 1, !dbg !5663
  store i64 4000, i64* %tv_usec5, align 8, !dbg !5664
  %call6 = call i32 @setitimer(i32 0, %struct.itimerval* %itimer, %struct.itimerval* null) #7, !dbg !5665
  store i32 %call6, i32* %iRet, align 4, !dbg !5666
  %2 = load i32, i32* %iRet, align 4, !dbg !5667
  %cmp7 = icmp eq i32 %2, -1, !dbg !5669
  br i1 %cmp7, label %if.then8, label %if.end10, !dbg !5670

if.then8:                                         ; preds = %if.end
  %call9 = call i32* @__errno_location() #9, !dbg !5671
  %3 = load i32, i32* %call9, align 4, !dbg !5671
  call void @prvFatalError(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.5, i64 0, i64 0), i32 %3) #8, !dbg !5673
  unreachable, !dbg !5673

if.end10:                                         ; preds = %if.end
  %call11 = call i64 @prvGetTimeNs(), !dbg !5674
  store i64 %call11, i64* @prvStartTimeNs, align 8, !dbg !5675
  ret void, !dbg !5676
}

; Function Attrs: nounwind
declare dso_local i32 @sigemptyset(%struct.__sigset_t*) #3

; Function Attrs: nounwind
declare dso_local i32 @sigaddset(%struct.__sigset_t*, i32) #3

; Function Attrs: noinline nounwind optnone uwtable
define internal void @vPortStartFirstTask() #0 !dbg !5677 {
entry:
  %pxFirstThread = alloca %struct.THREAD*, align 8
  call void @llvm.dbg.declare(metadata %struct.THREAD** %pxFirstThread, metadata !5678, metadata !DIExpression()), !dbg !5679
  %call = call %struct.tskTaskControlBlock* @xTaskGetCurrentTaskHandle(), !dbg !5680
  %call1 = call %struct.THREAD* @prvGetThreadFromTask(%struct.tskTaskControlBlock* %call), !dbg !5681
  store %struct.THREAD* %call1, %struct.THREAD** %pxFirstThread, align 8, !dbg !5679
  %0 = load %struct.THREAD*, %struct.THREAD** %pxFirstThread, align 8, !dbg !5682
  call void @prvResumeThread(%struct.THREAD* %0), !dbg !5683
  ret void, !dbg !5684
}

declare dso_local i32 @sigwait(%struct.__sigset_t*, i32*) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @vPortCancelThread(i8* %pxTaskToDelete) #0 !dbg !5685 {
entry:
  %pxTaskToDelete.addr = alloca i8*, align 8
  %pxThreadToCancel = alloca %struct.THREAD*, align 8
  store i8* %pxTaskToDelete, i8** %pxTaskToDelete.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pxTaskToDelete.addr, metadata !5686, metadata !DIExpression()), !dbg !5687
  call void @llvm.dbg.declare(metadata %struct.THREAD** %pxThreadToCancel, metadata !5688, metadata !DIExpression()), !dbg !5689
  %0 = load i8*, i8** %pxTaskToDelete.addr, align 8, !dbg !5690
  %1 = bitcast i8* %0 to %struct.tskTaskControlBlock*, !dbg !5690
  %call = call %struct.THREAD* @prvGetThreadFromTask(%struct.tskTaskControlBlock* %1), !dbg !5691
  store %struct.THREAD* %call, %struct.THREAD** %pxThreadToCancel, align 8, !dbg !5689
  %2 = load %struct.THREAD*, %struct.THREAD** %pxThreadToCancel, align 8, !dbg !5692
  %pthread = getelementptr inbounds %struct.THREAD, %struct.THREAD* %2, i32 0, i32 0, !dbg !5693
  %3 = load i64, i64* %pthread, align 8, !dbg !5693
  %call1 = call i32 @pthread_cancel(i64 %3), !dbg !5694
  %4 = load %struct.THREAD*, %struct.THREAD** %pxThreadToCancel, align 8, !dbg !5695
  %pthread2 = getelementptr inbounds %struct.THREAD, %struct.THREAD* %4, i32 0, i32 0, !dbg !5696
  %5 = load i64, i64* %pthread2, align 8, !dbg !5696
  %call3 = call i32 @pthread_join(i64 %5, i8** null), !dbg !5697
  %6 = load %struct.THREAD*, %struct.THREAD** %pxThreadToCancel, align 8, !dbg !5698
  %ev = getelementptr inbounds %struct.THREAD, %struct.THREAD* %6, i32 0, i32 4, !dbg !5699
  %7 = load %struct.event*, %struct.event** %ev, align 8, !dbg !5699
  call void @event_delete(%struct.event* %7), !dbg !5700
  ret void, !dbg !5701
}

declare dso_local i32 @pthread_cancel(i64) #2

declare dso_local i32 @pthread_join(i64, i8**) #2

declare dso_local void @event_delete(%struct.event*) #2

; Function Attrs: nounwind
declare dso_local i32 @getitimer(i32, %struct.itimerval*) #3

; Function Attrs: nounwind
declare dso_local i32 @setitimer(i32, %struct.itimerval*, %struct.itimerval*) #3

; Function Attrs: noinline nounwind optnone uwtable
define internal i64 @prvGetTimeNs() #0 !dbg !5702 {
entry:
  %t = alloca %struct.xTIME_OUT, align 8
  call void @llvm.dbg.declare(metadata %struct.xTIME_OUT* %t, metadata !5705, metadata !DIExpression()), !dbg !5712
  %call = call i32 @clock_gettime(i32 1, %struct.xTIME_OUT* %t) #7, !dbg !5713
  %tv_sec = getelementptr inbounds %struct.xTIME_OUT, %struct.xTIME_OUT* %t, i32 0, i32 0, !dbg !5714
  %0 = load i64, i64* %tv_sec, align 8, !dbg !5714
  %mul = mul i64 %0, 1000000000, !dbg !5715
  %tv_nsec = getelementptr inbounds %struct.xTIME_OUT, %struct.xTIME_OUT* %t, i32 0, i32 1, !dbg !5716
  %1 = load i64, i64* %tv_nsec, align 8, !dbg !5716
  %add = add i64 %mul, %1, !dbg !5717
  ret i64 %add, !dbg !5718
}

; Function Attrs: nounwind
declare dso_local i32 @clock_gettime(i32, %struct.xTIME_OUT*) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @vPortEndScheduler() #0 !dbg !5719 {
entry:
  %itimer = alloca %struct.itimerval, align 8
  %sigtick = alloca %struct.sigaction, align 8
  %xCurrentThread = alloca %struct.THREAD*, align 8
  call void @llvm.dbg.declare(metadata %struct.itimerval* %itimer, metadata !5720, metadata !DIExpression()), !dbg !5721
  call void @llvm.dbg.declare(metadata %struct.sigaction* %sigtick, metadata !5722, metadata !DIExpression()), !dbg !5723
  call void @llvm.dbg.declare(metadata %struct.THREAD** %xCurrentThread, metadata !5724, metadata !DIExpression()), !dbg !5725
  %it_value = getelementptr inbounds %struct.itimerval, %struct.itimerval* %itimer, i32 0, i32 1, !dbg !5726
  %tv_sec = getelementptr inbounds %struct.xTIME_OUT, %struct.xTIME_OUT* %it_value, i32 0, i32 0, !dbg !5727
  store i64 0, i64* %tv_sec, align 8, !dbg !5728
  %it_value1 = getelementptr inbounds %struct.itimerval, %struct.itimerval* %itimer, i32 0, i32 1, !dbg !5729
  %tv_usec = getelementptr inbounds %struct.xTIME_OUT, %struct.xTIME_OUT* %it_value1, i32 0, i32 1, !dbg !5730
  store i64 0, i64* %tv_usec, align 8, !dbg !5731
  %it_interval = getelementptr inbounds %struct.itimerval, %struct.itimerval* %itimer, i32 0, i32 0, !dbg !5732
  %tv_sec2 = getelementptr inbounds %struct.xTIME_OUT, %struct.xTIME_OUT* %it_interval, i32 0, i32 0, !dbg !5733
  store i64 0, i64* %tv_sec2, align 8, !dbg !5734
  %it_interval3 = getelementptr inbounds %struct.itimerval, %struct.itimerval* %itimer, i32 0, i32 0, !dbg !5735
  %tv_usec4 = getelementptr inbounds %struct.xTIME_OUT, %struct.xTIME_OUT* %it_interval3, i32 0, i32 1, !dbg !5736
  store i64 0, i64* %tv_usec4, align 8, !dbg !5737
  %call = call i32 @setitimer(i32 0, %struct.itimerval* %itimer, %struct.itimerval* null) #7, !dbg !5738
  %sa_flags = getelementptr inbounds %struct.sigaction, %struct.sigaction* %sigtick, i32 0, i32 2, !dbg !5739
  store i32 0, i32* %sa_flags, align 8, !dbg !5740
  %__sigaction_handler = getelementptr inbounds %struct.sigaction, %struct.sigaction* %sigtick, i32 0, i32 0, !dbg !5741
  %sa_handler = bitcast %union.anon.1* %__sigaction_handler to void (i32)**, !dbg !5741
  store void (i32)* inttoptr (i64 1 to void (i32)*), void (i32)** %sa_handler, align 8, !dbg !5742
  %sa_mask = getelementptr inbounds %struct.sigaction, %struct.sigaction* %sigtick, i32 0, i32 1, !dbg !5743
  %call5 = call i32 @sigemptyset(%struct.__sigset_t* %sa_mask) #7, !dbg !5744
  %call6 = call i32 @sigaction(i32 14, %struct.sigaction* %sigtick, %struct.sigaction* null) #7, !dbg !5745
  store i64 1, i64* @xSchedulerEnd, align 8, !dbg !5746
  %0 = load i64, i64* @hMainThread, align 8, !dbg !5747
  %call7 = call i32 @pthread_kill(i64 %0, i32 10) #7, !dbg !5748
  %call8 = call %struct.tskTaskControlBlock* @xTaskGetCurrentTaskHandle(), !dbg !5749
  %call9 = call %struct.THREAD* @prvGetThreadFromTask(%struct.tskTaskControlBlock* %call8), !dbg !5750
  store %struct.THREAD* %call9, %struct.THREAD** %xCurrentThread, align 8, !dbg !5751
  %1 = load %struct.THREAD*, %struct.THREAD** %xCurrentThread, align 8, !dbg !5752
  call void @prvSuspendSelf(%struct.THREAD* %1), !dbg !5753
  ret void, !dbg !5754
}

; Function Attrs: nounwind
declare dso_local i32 @pthread_kill(i64, i32) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @vPortYield() #0 !dbg !5755 {
entry:
  call void @vPortEnterCritical(), !dbg !5756
  call void @prvPortYieldFromISR(), !dbg !5757
  call void @vPortExitCritical(), !dbg !5758
  ret void, !dbg !5759
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @prvPortYieldFromISR() #0 !dbg !5760 {
entry:
  %xThreadToSuspend = alloca %struct.THREAD*, align 8
  %xThreadToResume = alloca %struct.THREAD*, align 8
  call void @llvm.dbg.declare(metadata %struct.THREAD** %xThreadToSuspend, metadata !5761, metadata !DIExpression()), !dbg !5762
  call void @llvm.dbg.declare(metadata %struct.THREAD** %xThreadToResume, metadata !5763, metadata !DIExpression()), !dbg !5764
  %call = call %struct.tskTaskControlBlock* @xTaskGetCurrentTaskHandle(), !dbg !5765
  %call1 = call %struct.THREAD* @prvGetThreadFromTask(%struct.tskTaskControlBlock* %call), !dbg !5766
  store %struct.THREAD* %call1, %struct.THREAD** %xThreadToSuspend, align 8, !dbg !5767
  call void @vTaskSwitchContext(), !dbg !5768
  %call2 = call %struct.tskTaskControlBlock* @xTaskGetCurrentTaskHandle(), !dbg !5769
  %call3 = call %struct.THREAD* @prvGetThreadFromTask(%struct.tskTaskControlBlock* %call2), !dbg !5770
  store %struct.THREAD* %call3, %struct.THREAD** %xThreadToResume, align 8, !dbg !5771
  %0 = load %struct.THREAD*, %struct.THREAD** %xThreadToResume, align 8, !dbg !5772
  %1 = load %struct.THREAD*, %struct.THREAD** %xThreadToSuspend, align 8, !dbg !5773
  call void @prvSwitchThread(%struct.THREAD* %0, %struct.THREAD* %1), !dbg !5774
  ret void, !dbg !5775
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @xPortSetInterruptMask() #0 !dbg !5776 {
entry:
  ret i64 0, !dbg !5777
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @vPortClearInterruptMask(i64 %uxMask) #0 !dbg !5778 {
entry:
  %uxMask.addr = alloca i64, align 8
  store i64 %uxMask, i64* %uxMask.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxMask.addr, metadata !5781, metadata !DIExpression()), !dbg !5782
  %0 = load i64, i64* %uxMask.addr, align 8, !dbg !5783
  ret void, !dbg !5784
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @vPortThreadDying(i8* %pxTaskToDelete, i64* %pxPendYield) #0 !dbg !5785 {
entry:
  %pxTaskToDelete.addr = alloca i8*, align 8
  %pxPendYield.addr = alloca i64*, align 8
  %pxThread = alloca %struct.THREAD*, align 8
  store i8* %pxTaskToDelete, i8** %pxTaskToDelete.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pxTaskToDelete.addr, metadata !5790, metadata !DIExpression()), !dbg !5791
  store i64* %pxPendYield, i64** %pxPendYield.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxPendYield.addr, metadata !5792, metadata !DIExpression()), !dbg !5793
  call void @llvm.dbg.declare(metadata %struct.THREAD** %pxThread, metadata !5794, metadata !DIExpression()), !dbg !5795
  %0 = load i8*, i8** %pxTaskToDelete.addr, align 8, !dbg !5796
  %1 = bitcast i8* %0 to %struct.tskTaskControlBlock*, !dbg !5796
  %call = call %struct.THREAD* @prvGetThreadFromTask(%struct.tskTaskControlBlock* %1), !dbg !5797
  store %struct.THREAD* %call, %struct.THREAD** %pxThread, align 8, !dbg !5795
  %2 = load i64*, i64** %pxPendYield.addr, align 8, !dbg !5798
  %3 = load %struct.THREAD*, %struct.THREAD** %pxThread, align 8, !dbg !5799
  %xDying = getelementptr inbounds %struct.THREAD, %struct.THREAD* %3, i32 0, i32 3, !dbg !5800
  store i64 1, i64* %xDying, align 8, !dbg !5801
  ret void, !dbg !5802
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @ulPortGetRunTime() #0 !dbg !5803 {
entry:
  %xTimes = alloca %struct.tms, align 8
  call void @llvm.dbg.declare(metadata %struct.tms* %xTimes, metadata !5806, metadata !DIExpression()), !dbg !5816
  %call = call i64 @times(%struct.tms* %xTimes) #7, !dbg !5817
  %tms_utime = getelementptr inbounds %struct.tms, %struct.tms* %xTimes, i32 0, i32 0, !dbg !5818
  %0 = load i64, i64* %tms_utime, align 8, !dbg !5818
  ret i64 %0, !dbg !5819
}

; Function Attrs: nounwind
declare dso_local i64 @times(%struct.tms*) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !5820 {
entry:
  %retval = alloca i32, align 4
  %xTaskToResume = alloca %struct.tskTaskControlBlock*, align 8
  store i32 0, i32* %retval, align 4
  store i8 0, i8* @isTested, align 1, !dbg !5823
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTaskToResume, metadata !5824, metadata !DIExpression()), !dbg !5825
  %0 = bitcast %struct.tskTaskControlBlock** %xTaskToResume to i8*, !dbg !5826
  call void @klee_make_symbolic_controllable(i8* %0, i64 8, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.8, i64 0, i64 0), i1 zeroext false), !dbg !5827
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToResume, align 8, !dbg !5828
  %cmp = icmp eq %struct.tskTaskControlBlock* %1, null, !dbg !5830
  br i1 %cmp, label %if.then, label %if.end, !dbg !5831

if.then:                                          ; preds = %entry
  store i32 0, i32* %retval, align 4, !dbg !5832
  br label %return, !dbg !5832

if.end:                                           ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToResume, align 8, !dbg !5833
  %call = call i32 (%struct.tskTaskControlBlock*, ...) bitcast (void (%struct.tskTaskControlBlock*)* @MPU_vTaskSuspendImpl to i32 (%struct.tskTaskControlBlock*, ...)*)(%struct.tskTaskControlBlock* %2), !dbg !5834
  store i32 0, i32* %retval, align 4, !dbg !5835
  br label %return, !dbg !5835

return:                                           ; preds = %if.end, %if.then
  %3 = load i32, i32* %retval, align 4, !dbg !5836
  ret i32 %3, !dbg !5836
}

declare dso_local void @klee_make_symbolic_controllable(i8*, i64, i8*, i1 zeroext) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @vTaskFunction1(i8* %pvParameters) #0 !dbg !5837 {
entry:
  %pvParameters.addr = alloca i8*, align 8
  store i8* %pvParameters, i8** %pvParameters.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvParameters.addr, metadata !5838, metadata !DIExpression()), !dbg !5839
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 0), !dbg !5840
  ret void, !dbg !5841
}

declare dso_local i32 @assert(...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @vTaskSuspend(%struct.tskTaskControlBlock* %xTaskToResume) #0 !dbg !5842 {
entry:
  %xTaskToResume.addr = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTaskToResume, %struct.tskTaskControlBlock** %xTaskToResume.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTaskToResume.addr, metadata !5843, metadata !DIExpression()), !dbg !5844
  %0 = load i8, i8* @isTested, align 1, !dbg !5845
  %tobool = trunc i8 %0 to i1, !dbg !5845
  %conv = zext i1 %tobool to i32, !dbg !5845
  call void (i32, ...) bitcast (void (...)* @klee_access_control_message to void (i32, ...)*)(i32 %conv), !dbg !5846
  ret void, !dbg !5847
}

declare dso_local void @klee_access_control_message(...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @portIS_TASK_PRIVILEGED() #0 !dbg !5848 {
entry:
  store i8 1, i8* @isTested, align 1, !dbg !5849
  ret void, !dbg !5850
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noinline noreturn nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind }
attributes #8 = { noreturn }
attributes #9 = { nounwind readnone }
attributes #10 = { noreturn nounwind }

!llvm.dbg.cu = !{!2, !78, !149}
!llvm.ident = !{!155, !155, !155}
!llvm.module.flags = !{!156, !157, !158}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "xKernelObjectPool", scope: !2, file: !36, line: 237, type: !67, isLocal: true, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 11.0.0 (https://github.com/llvm/llvm-project.git 60a25202a7dd1e00067fcfce512086ebf3788537)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !22, globals: !66, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "/home/klee/FreeRTOS-Kernel-10.6.0/portable/Common/mpu_wrappers_v2.c", directory: "/home/klee/FreeRTOS-Kernel-10.6.0/symbolic_execution/test_access_control")
!4 = !{!5, !15}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !6, line: 101, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "include/task.h", directory: "/home/klee/FreeRTOS-Kernel-10.6.0")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13, !14}
!9 = !DIEnumerator(name: "eRunning", value: 0, isUnsigned: true)
!10 = !DIEnumerator(name: "eReady", value: 1, isUnsigned: true)
!11 = !DIEnumerator(name: "eBlocked", value: 2, isUnsigned: true)
!12 = !DIEnumerator(name: "eSuspended", value: 3, isUnsigned: true)
!13 = !DIEnumerator(name: "eDeleted", value: 4, isUnsigned: true)
!14 = !DIEnumerator(name: "eInvalid", value: 5, isUnsigned: true)
!15 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !6, line: 112, baseType: !7, size: 32, elements: !16)
!16 = !{!17, !18, !19, !20, !21}
!17 = !DIEnumerator(name: "eNoAction", value: 0, isUnsigned: true)
!18 = !DIEnumerator(name: "eSetBits", value: 1, isUnsigned: true)
!19 = !DIEnumerator(name: "eIncrement", value: 2, isUnsigned: true)
!20 = !DIEnumerator(name: "eSetValueWithOverwrite", value: 3, isUnsigned: true)
!21 = !DIEnumerator(name: "eSetValueWithoutOverwrite", value: 4, isUnsigned: true)
!22 = !{!23, !26, !27, !32, !35, !39, !41, !45, !46, !47, !50, !54, !58, !62}
!23 = !DIDerivedType(tag: DW_TAG_typedef, name: "BaseType_t", file: !24, line: 62, baseType: !25)
!24 = !DIFile(filename: "portable/ThirdParty/GCC/Posix/portmacro.h", directory: "/home/klee/FreeRTOS-Kernel-10.6.0")
!25 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!27 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !28, line: 26, baseType: !29)
!28 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-intn.h", directory: "")
!29 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !30, line: 40, baseType: !31)
!30 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "")
!31 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!32 = !DIDerivedType(tag: DW_TAG_typedef, name: "TaskHandle_t", file: !6, line: 92, baseType: !33)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!34 = !DICompositeType(tag: DW_TAG_structure_type, name: "tskTaskControlBlock", file: !6, line: 91, flags: DIFlagFwdDecl)
!35 = !DIDerivedType(tag: DW_TAG_typedef, name: "OpaqueObjectHandle_t", file: !36, line: 69, baseType: !37)
!36 = !DIFile(filename: "portable/Common/mpu_wrappers_v2.c", directory: "/home/klee/FreeRTOS-Kernel-10.6.0")
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !38, size: 64)
!38 = !DICompositeType(tag: DW_TAG_structure_type, name: "OpaqueObject", file: !36, line: 68, flags: DIFlagFwdDecl)
!39 = !DIDerivedType(tag: DW_TAG_typedef, name: "UBaseType_t", file: !24, line: 63, baseType: !40)
!40 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!41 = !DIDerivedType(tag: DW_TAG_typedef, name: "QueueHandle_t", file: !42, line: 51, baseType: !43)
!42 = !DIFile(filename: "include/queue.h", directory: "/home/klee/FreeRTOS-Kernel-10.6.0")
!43 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !44, size: 64)
!44 = !DICompositeType(tag: DW_TAG_structure_type, name: "QueueDefinition", file: !42, line: 50, flags: DIFlagFwdDecl)
!45 = !DIDerivedType(tag: DW_TAG_typedef, name: "QueueSetHandle_t", file: !42, line: 58, baseType: !43)
!46 = !DIDerivedType(tag: DW_TAG_typedef, name: "QueueSetMemberHandle_t", file: !42, line: 65, baseType: !43)
!47 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !48, line: 26, baseType: !49)
!48 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h", directory: "")
!49 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !30, line: 41, baseType: !7)
!50 = !DIDerivedType(tag: DW_TAG_typedef, name: "TimerHandle_t", file: !51, line: 80, baseType: !52)
!51 = !DIFile(filename: "include/timers.h", directory: "/home/klee/FreeRTOS-Kernel-10.6.0")
!52 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !53, size: 64)
!53 = !DICompositeType(tag: DW_TAG_structure_type, name: "tmrTimerControl", file: !51, line: 79, flags: DIFlagFwdDecl)
!54 = !DIDerivedType(tag: DW_TAG_typedef, name: "EventGroupHandle_t", file: !55, line: 83, baseType: !56)
!55 = !DIFile(filename: "include/event_groups.h", directory: "/home/klee/FreeRTOS-Kernel-10.6.0")
!56 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !57, size: 64)
!57 = !DICompositeType(tag: DW_TAG_structure_type, name: "EventGroupDef_t", file: !55, line: 82, flags: DIFlagFwdDecl)
!58 = !DIDerivedType(tag: DW_TAG_typedef, name: "StreamBufferHandle_t", file: !59, line: 72, baseType: !60)
!59 = !DIFile(filename: "include/stream_buffer.h", directory: "/home/klee/FreeRTOS-Kernel-10.6.0")
!60 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !61, size: 64)
!61 = !DICompositeType(tag: DW_TAG_structure_type, name: "StreamBufferDef_t", file: !59, line: 71, flags: DIFlagFwdDecl)
!62 = !DIDerivedType(tag: DW_TAG_typedef, name: "TimerCallbackFunction_t", file: !51, line: 85, baseType: !63)
!63 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !64, size: 64)
!64 = !DISubroutineType(types: !65)
!65 = !{null, !50}
!66 = !{!0}
!67 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 49152, elements: !74)
!68 = !DIDerivedType(tag: DW_TAG_typedef, name: "KernelObject_t", file: !36, line: 79, baseType: !69)
!69 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "KernelObject", file: !36, line: 74, size: 192, elements: !70)
!70 = !{!71, !72, !73}
!71 = !DIDerivedType(tag: DW_TAG_member, name: "xInternalObjectHandle", scope: !69, file: !36, line: 76, baseType: !35, size: 64)
!72 = !DIDerivedType(tag: DW_TAG_member, name: "ulKernelObjectType", scope: !69, file: !36, line: 77, baseType: !47, size: 32, offset: 64)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "pvKernelObjectData", scope: !69, file: !36, line: 78, baseType: !26, size: 64, offset: 128)
!74 = !{!75}
!75 = !DISubrange(count: 256)
!76 = !DIGlobalVariableExpression(var: !77, expr: !DIExpression())
!77 = distinct !DIGlobalVariable(name: "hSigSetupThread", scope: !78, file: !90, line: 99, type: !146, isLocal: true, isDefinition: true)
!78 = distinct !DICompileUnit(language: DW_LANG_C99, file: !79, producer: "clang version 11.0.0 (https://github.com/llvm/llvm-project.git 60a25202a7dd1e00067fcfce512086ebf3788537)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !80, retainedTypes: !87, globals: !122, splitDebugInlining: false, nameTableKind: None)
!79 = !DIFile(filename: "/home/klee/FreeRTOS-Kernel-10.6.0//portable/ThirdParty/GCC/Posix/port.c", directory: "/home/klee/FreeRTOS-Kernel-10.6.0/symbolic_execution/test_access_control")
!80 = !{!81}
!81 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "__itimer_which", file: !82, line: 88, baseType: !7, size: 32, elements: !83)
!82 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/sys/time.h", directory: "")
!83 = !{!84, !85, !86}
!84 = !DIEnumerator(name: "ITIMER_REAL", value: 0, isUnsigned: true)
!85 = !DIEnumerator(name: "ITIMER_VIRTUAL", value: 1, isUnsigned: true)
!86 = !DIEnumerator(name: "ITIMER_PROF", value: 2, isUnsigned: true)
!87 = !{!88, !108, !109, !23, !111, !39, !40, !116, !119, !120, !26}
!88 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !89, size: 64)
!89 = !DIDerivedType(tag: DW_TAG_typedef, name: "Thread_t", file: !90, line: 84, baseType: !91)
!90 = !DIFile(filename: "portable/ThirdParty/GCC/Posix/port.c", directory: "/home/klee/FreeRTOS-Kernel-10.6.0")
!91 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "THREAD", file: !90, line: 77, size: 320, elements: !92)
!92 = !{!93, !96, !102, !103, !104}
!93 = !DIDerivedType(tag: DW_TAG_member, name: "pthread", scope: !91, file: !90, line: 79, baseType: !94, size: 64)
!94 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_t", file: !95, line: 27, baseType: !40)
!95 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h", directory: "")
!96 = !DIDerivedType(tag: DW_TAG_member, name: "pxCode", scope: !91, file: !90, line: 80, baseType: !97, size: 64, offset: 64)
!97 = !DIDerivedType(tag: DW_TAG_typedef, name: "TaskFunction_t", file: !98, line: 36, baseType: !99)
!98 = !DIFile(filename: "include/projdefs.h", directory: "/home/klee/FreeRTOS-Kernel-10.6.0")
!99 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !100, size: 64)
!100 = !DISubroutineType(types: !101)
!101 = !{null, !26}
!102 = !DIDerivedType(tag: DW_TAG_member, name: "pvParams", scope: !91, file: !90, line: 81, baseType: !26, size: 64, offset: 128)
!103 = !DIDerivedType(tag: DW_TAG_member, name: "xDying", scope: !91, file: !90, line: 82, baseType: !23, size: 64, offset: 192)
!104 = !DIDerivedType(tag: DW_TAG_member, name: "ev", scope: !91, file: !90, line: 83, baseType: !105, size: 64, offset: 256)
!105 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !106, size: 64)
!106 = !DICompositeType(tag: DW_TAG_structure_type, name: "event", file: !107, line: 35, flags: DIFlagFwdDecl)
!107 = !DIFile(filename: "portable/ThirdParty/GCC/Posix/utils/wait_for_event.h", directory: "/home/klee/FreeRTOS-Kernel-10.6.0")
!108 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !40, size: 64)
!109 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !110, line: 46, baseType: !40)
!110 = !DIFile(filename: "/tmp/llvm-110-install_O_D_A/lib/clang/11.0.0/include/stddef.h", directory: "")
!111 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sighandler_t", file: !112, line: 72, baseType: !113)
!112 = !DIFile(filename: "/usr/include/signal.h", directory: "")
!113 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !114, size: 64)
!114 = !DISubroutineType(types: !115)
!115 = !{null, !31}
!116 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !117, size: 64)
!117 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !118, size: 64)
!118 = !DIDerivedType(tag: DW_TAG_typedef, name: "StackType_t", file: !24, line: 61, baseType: !40)
!119 = !DIDerivedType(tag: DW_TAG_typedef, name: "TickType_t", file: !24, line: 65, baseType: !40)
!120 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !48, line: 27, baseType: !121)
!121 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !30, line: 44, baseType: !40)
!122 = !{!123, !135, !137, !76, !140, !142, !144}
!123 = !DIGlobalVariableExpression(var: !124, expr: !DIExpression())
!124 = distinct !DIGlobalVariable(name: "xAllSignals", scope: !78, file: !90, line: 100, type: !125, isLocal: true, isDefinition: true)
!125 = !DIDerivedType(tag: DW_TAG_typedef, name: "sigset_t", file: !126, line: 7, baseType: !127)
!126 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/sigset_t.h", directory: "")
!127 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sigset_t", file: !128, line: 8, baseType: !129)
!128 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h", directory: "")
!129 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !128, line: 5, size: 1024, elements: !130)
!130 = !{!131}
!131 = !DIDerivedType(tag: DW_TAG_member, name: "__val", scope: !129, file: !128, line: 7, baseType: !132, size: 1024)
!132 = !DICompositeType(tag: DW_TAG_array_type, baseType: !40, size: 1024, elements: !133)
!133 = !{!134}
!134 = !DISubrange(count: 16)
!135 = !DIGlobalVariableExpression(var: !136, expr: !DIExpression())
!136 = distinct !DIGlobalVariable(name: "xSchedulerOriginalSignalMask", scope: !78, file: !90, line: 101, type: !125, isLocal: true, isDefinition: true)
!137 = !DIGlobalVariableExpression(var: !138, expr: !DIExpression())
!138 = distinct !DIGlobalVariable(name: "uxCriticalNesting", scope: !78, file: !90, line: 103, type: !139, isLocal: true, isDefinition: true)
!139 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !25)
!140 = !DIGlobalVariableExpression(var: !141, expr: !DIExpression())
!141 = distinct !DIGlobalVariable(name: "hMainThread", scope: !78, file: !90, line: 102, type: !94, isLocal: true, isDefinition: true)
!142 = !DIGlobalVariableExpression(var: !143, expr: !DIExpression())
!143 = distinct !DIGlobalVariable(name: "xSchedulerEnd", scope: !78, file: !90, line: 106, type: !25, isLocal: true, isDefinition: true)
!144 = !DIGlobalVariableExpression(var: !145, expr: !DIExpression())
!145 = distinct !DIGlobalVariable(name: "prvStartTimeNs", scope: !78, file: !90, line: 358, type: !120, isLocal: true, isDefinition: true)
!146 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_once_t", file: !95, line: 53, baseType: !31)
!147 = !DIGlobalVariableExpression(var: !148, expr: !DIExpression())
!148 = distinct !DIGlobalVariable(name: "isTested", scope: !149, file: !150, line: 15, type: !154, isLocal: false, isDefinition: true)
!149 = distinct !DICompileUnit(language: DW_LANG_C99, file: !150, producer: "clang version 11.0.0 (https://github.com/llvm/llvm-project.git 60a25202a7dd1e00067fcfce512086ebf3788537)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !151, retainedTypes: !152, globals: !153, splitDebugInlining: false, nameTableKind: None)
!150 = !DIFile(filename: "test.c", directory: "/home/klee/FreeRTOS-Kernel-10.6.0/symbolic_execution/test_access_control")
!151 = !{}
!152 = !{!26}
!153 = !{!147}
!154 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!155 = !{!"clang version 11.0.0 (https://github.com/llvm/llvm-project.git 60a25202a7dd1e00067fcfce512086ebf3788537)"}
!156 = !{i32 7, !"Dwarf Version", i32 4}
!157 = !{i32 2, !"Debug Info Version", i32 3}
!158 = !{i32 1, !"wchar_size", i32 4}
!159 = distinct !DISubprogram(name: "MPU_xTaskDelayUntilImpl", scope: !36, file: !36, line: 363, type: !160, scopeLine: 365, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!160 = !DISubroutineType(types: !161)
!161 = !{!23, !162, !119}
!162 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !163)
!163 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !119, size: 64)
!164 = !DILocalVariable(name: "pxPreviousWakeTime", arg: 1, scope: !159, file: !36, line: 363, type: !162)
!165 = !DILocation(line: 363, column: 64, scope: !159)
!166 = !DILocalVariable(name: "xTimeIncrement", arg: 2, scope: !159, file: !36, line: 364, type: !119)
!167 = !DILocation(line: 364, column: 56, scope: !159)
!168 = !DILocalVariable(name: "xReturn", scope: !159, file: !36, line: 366, type: !23)
!169 = !DILocation(line: 366, column: 24, scope: !159)
!170 = !DILocalVariable(name: "xIsPreviousWakeTimeAccessible", scope: !159, file: !36, line: 367, type: !23)
!171 = !DILocation(line: 367, column: 24, scope: !159)
!172 = !DILocation(line: 369, column: 78, scope: !159)
!173 = !DILocation(line: 369, column: 45, scope: !159)
!174 = !DILocation(line: 369, column: 43, scope: !159)
!175 = !DILocation(line: 373, column: 17, scope: !176)
!176 = distinct !DILexicalBlock(scope: !159, file: !36, line: 373, column: 17)
!177 = !DILocation(line: 373, column: 47, scope: !176)
!178 = !DILocation(line: 373, column: 17, scope: !159)
!179 = !DILocation(line: 375, column: 44, scope: !180)
!180 = distinct !DILexicalBlock(scope: !176, file: !36, line: 374, column: 13)
!181 = !DILocation(line: 375, column: 64, scope: !180)
!182 = !DILocation(line: 375, column: 27, scope: !180)
!183 = !DILocation(line: 375, column: 25, scope: !180)
!184 = !DILocation(line: 376, column: 13, scope: !180)
!185 = !DILocation(line: 378, column: 20, scope: !159)
!186 = !DILocation(line: 378, column: 13, scope: !159)
!187 = distinct !DISubprogram(name: "MPU_xTaskAbortDelayImpl", scope: !36, file: !36, line: 388, type: !188, scopeLine: 389, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!188 = !DISubroutineType(types: !189)
!189 = !{!23, !32}
!190 = !DILocalVariable(name: "xTask", arg: 1, scope: !187, file: !36, line: 388, type: !32)
!191 = !DILocation(line: 388, column: 58, scope: !187)
!192 = !DILocalVariable(name: "xReturn", scope: !187, file: !36, line: 390, type: !23)
!193 = !DILocation(line: 390, column: 24, scope: !187)
!194 = !DILocalVariable(name: "xInternalTaskHandle", scope: !187, file: !36, line: 391, type: !32)
!195 = !DILocation(line: 391, column: 26, scope: !187)
!196 = !DILocalVariable(name: "lIndex", scope: !187, file: !36, line: 392, type: !27)
!197 = !DILocation(line: 392, column: 21, scope: !187)
!198 = !DILocation(line: 394, column: 17, scope: !199)
!199 = distinct !DILexicalBlock(scope: !187, file: !36, line: 394, column: 17)
!200 = !DILocation(line: 394, column: 23, scope: !199)
!201 = !DILocation(line: 394, column: 17, scope: !187)
!202 = !DILocation(line: 396, column: 44, scope: !203)
!203 = distinct !DILexicalBlock(scope: !199, file: !36, line: 395, column: 13)
!204 = !DILocation(line: 396, column: 27, scope: !203)
!205 = !DILocation(line: 396, column: 25, scope: !203)
!206 = !DILocation(line: 397, column: 13, scope: !203)
!207 = !DILocation(line: 400, column: 38, scope: !208)
!208 = distinct !DILexicalBlock(scope: !199, file: !36, line: 399, column: 13)
!209 = !DILocation(line: 400, column: 26, scope: !208)
!210 = !DILocation(line: 400, column: 24, scope: !208)
!211 = !DILocation(line: 402, column: 21, scope: !212)
!212 = distinct !DILexicalBlock(scope: !208, file: !36, line: 402, column: 21)
!213 = !DILocation(line: 0, scope: !212)
!214 = !DILocation(line: 402, column: 55, scope: !212)
!215 = !DILocation(line: 402, column: 21, scope: !208)
!216 = !DILocation(line: 404, column: 43, scope: !217)
!217 = distinct !DILexicalBlock(scope: !212, file: !36, line: 403, column: 17)
!218 = !DILocation(line: 404, column: 41, scope: !217)
!219 = !DILocation(line: 406, column: 25, scope: !220)
!220 = distinct !DILexicalBlock(scope: !217, file: !36, line: 406, column: 25)
!221 = !DILocation(line: 406, column: 45, scope: !220)
!222 = !DILocation(line: 406, column: 25, scope: !217)
!223 = !DILocation(line: 408, column: 52, scope: !224)
!224 = distinct !DILexicalBlock(scope: !220, file: !36, line: 407, column: 21)
!225 = !DILocation(line: 408, column: 35, scope: !224)
!226 = !DILocation(line: 408, column: 33, scope: !224)
!227 = !DILocation(line: 409, column: 21, scope: !224)
!228 = !DILocation(line: 410, column: 17, scope: !217)
!229 = !DILocation(line: 413, column: 20, scope: !187)
!230 = !DILocation(line: 413, column: 13, scope: !187)
!231 = distinct !DISubprogram(name: "MPU_GetHandleAtIndex", scope: !36, file: !36, line: 314, type: !232, scopeLine: 316, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !151)
!232 = !DISubroutineType(types: !233)
!233 = !{!35, !27, !47}
!234 = !DILocalVariable(name: "lIndex", arg: 1, scope: !231, file: !36, line: 314, type: !27)
!235 = !DILocation(line: 314, column: 63, scope: !231)
!236 = !DILocalVariable(name: "ulKernelObjectType", arg: 2, scope: !231, file: !36, line: 315, type: !47)
!237 = !DILocation(line: 315, column: 64, scope: !231)
!238 = !DILocation(line: 317, column: 9, scope: !239)
!239 = distinct !DILexicalBlock(scope: !231, file: !36, line: 317, column: 9)
!240 = !DILocation(line: 0, scope: !239)
!241 = !DILocation(line: 317, column: 9, scope: !231)
!242 = !DILocation(line: 318, column: 9, scope: !243)
!243 = distinct !DILexicalBlock(scope: !231, file: !36, line: 318, column: 9)
!244 = !DILocation(line: 318, column: 9, scope: !231)
!245 = !DILocation(line: 319, column: 35, scope: !231)
!246 = !DILocation(line: 319, column: 16, scope: !231)
!247 = !DILocation(line: 319, column: 44, scope: !231)
!248 = !DILocation(line: 319, column: 9, scope: !231)
!249 = distinct !DISubprogram(name: "MPU_vTaskDelayImpl", scope: !36, file: !36, line: 423, type: !250, scopeLine: 424, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!250 = !DISubroutineType(types: !251)
!251 = !{null, !119}
!252 = !DILocalVariable(name: "xTicksToDelay", arg: 1, scope: !249, file: !36, line: 423, type: !119)
!253 = !DILocation(line: 423, column: 45, scope: !249)
!254 = !DILocation(line: 425, column: 25, scope: !249)
!255 = !DILocation(line: 425, column: 13, scope: !249)
!256 = !DILocation(line: 426, column: 9, scope: !249)
!257 = distinct !DISubprogram(name: "MPU_uxTaskPriorityGetImpl", scope: !36, file: !36, line: 435, type: !258, scopeLine: 436, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!258 = !DISubroutineType(types: !259)
!259 = !{!39, !260}
!260 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !32)
!261 = !DILocalVariable(name: "pxTask", arg: 1, scope: !257, file: !36, line: 435, type: !260)
!262 = !DILocation(line: 435, column: 67, scope: !257)
!263 = !DILocalVariable(name: "uxReturn", scope: !257, file: !36, line: 437, type: !39)
!264 = !DILocation(line: 437, column: 25, scope: !257)
!265 = !DILocalVariable(name: "lIndex", scope: !257, file: !36, line: 438, type: !27)
!266 = !DILocation(line: 438, column: 21, scope: !257)
!267 = !DILocalVariable(name: "xInternalTaskHandle", scope: !257, file: !36, line: 439, type: !32)
!268 = !DILocation(line: 439, column: 26, scope: !257)
!269 = !DILocation(line: 441, column: 17, scope: !270)
!270 = distinct !DILexicalBlock(scope: !257, file: !36, line: 441, column: 17)
!271 = !DILocation(line: 441, column: 24, scope: !270)
!272 = !DILocation(line: 441, column: 17, scope: !257)
!273 = !DILocation(line: 443, column: 47, scope: !274)
!274 = distinct !DILexicalBlock(scope: !270, file: !36, line: 442, column: 13)
!275 = !DILocation(line: 443, column: 28, scope: !274)
!276 = !DILocation(line: 443, column: 26, scope: !274)
!277 = !DILocation(line: 444, column: 13, scope: !274)
!278 = !DILocation(line: 447, column: 38, scope: !279)
!279 = distinct !DILexicalBlock(scope: !270, file: !36, line: 446, column: 13)
!280 = !DILocation(line: 447, column: 26, scope: !279)
!281 = !DILocation(line: 447, column: 24, scope: !279)
!282 = !DILocation(line: 449, column: 21, scope: !283)
!283 = distinct !DILexicalBlock(scope: !279, file: !36, line: 449, column: 21)
!284 = !DILocation(line: 0, scope: !283)
!285 = !DILocation(line: 449, column: 55, scope: !283)
!286 = !DILocation(line: 449, column: 21, scope: !279)
!287 = !DILocation(line: 451, column: 43, scope: !288)
!288 = distinct !DILexicalBlock(scope: !283, file: !36, line: 450, column: 17)
!289 = !DILocation(line: 451, column: 41, scope: !288)
!290 = !DILocation(line: 453, column: 25, scope: !291)
!291 = distinct !DILexicalBlock(scope: !288, file: !36, line: 453, column: 25)
!292 = !DILocation(line: 453, column: 45, scope: !291)
!293 = !DILocation(line: 453, column: 25, scope: !288)
!294 = !DILocation(line: 455, column: 55, scope: !295)
!295 = distinct !DILexicalBlock(scope: !291, file: !36, line: 454, column: 21)
!296 = !DILocation(line: 455, column: 36, scope: !295)
!297 = !DILocation(line: 455, column: 34, scope: !295)
!298 = !DILocation(line: 456, column: 21, scope: !295)
!299 = !DILocation(line: 457, column: 17, scope: !288)
!300 = !DILocation(line: 460, column: 20, scope: !257)
!301 = !DILocation(line: 460, column: 13, scope: !257)
!302 = distinct !DISubprogram(name: "MPU_eTaskGetStateImpl", scope: !36, file: !36, line: 470, type: !303, scopeLine: 471, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!303 = !DISubroutineType(types: !304)
!304 = !{!305, !32}
!305 = !DIDerivedType(tag: DW_TAG_typedef, name: "eTaskState", file: !6, line: 109, baseType: !5)
!306 = !DILocalVariable(name: "pxTask", arg: 1, scope: !302, file: !36, line: 470, type: !32)
!307 = !DILocation(line: 470, column: 56, scope: !302)
!308 = !DILocalVariable(name: "eReturn", scope: !302, file: !36, line: 472, type: !305)
!309 = !DILocation(line: 472, column: 24, scope: !302)
!310 = !DILocalVariable(name: "xInternalTaskHandle", scope: !302, file: !36, line: 473, type: !32)
!311 = !DILocation(line: 473, column: 26, scope: !302)
!312 = !DILocalVariable(name: "lIndex", scope: !302, file: !36, line: 474, type: !27)
!313 = !DILocation(line: 474, column: 21, scope: !302)
!314 = !DILocation(line: 476, column: 17, scope: !315)
!315 = distinct !DILexicalBlock(scope: !302, file: !36, line: 476, column: 17)
!316 = !DILocation(line: 476, column: 24, scope: !315)
!317 = !DILocation(line: 476, column: 17, scope: !302)
!318 = !DILocation(line: 478, column: 42, scope: !319)
!319 = distinct !DILexicalBlock(scope: !315, file: !36, line: 477, column: 13)
!320 = !DILocation(line: 478, column: 27, scope: !319)
!321 = !DILocation(line: 478, column: 25, scope: !319)
!322 = !DILocation(line: 479, column: 13, scope: !319)
!323 = !DILocation(line: 482, column: 38, scope: !324)
!324 = distinct !DILexicalBlock(scope: !315, file: !36, line: 481, column: 13)
!325 = !DILocation(line: 482, column: 26, scope: !324)
!326 = !DILocation(line: 482, column: 24, scope: !324)
!327 = !DILocation(line: 484, column: 21, scope: !328)
!328 = distinct !DILexicalBlock(scope: !324, file: !36, line: 484, column: 21)
!329 = !DILocation(line: 0, scope: !328)
!330 = !DILocation(line: 484, column: 55, scope: !328)
!331 = !DILocation(line: 484, column: 21, scope: !324)
!332 = !DILocation(line: 486, column: 43, scope: !333)
!333 = distinct !DILexicalBlock(scope: !328, file: !36, line: 485, column: 17)
!334 = !DILocation(line: 486, column: 41, scope: !333)
!335 = !DILocation(line: 488, column: 25, scope: !336)
!336 = distinct !DILexicalBlock(scope: !333, file: !36, line: 488, column: 25)
!337 = !DILocation(line: 488, column: 45, scope: !336)
!338 = !DILocation(line: 488, column: 25, scope: !333)
!339 = !DILocation(line: 490, column: 50, scope: !340)
!340 = distinct !DILexicalBlock(scope: !336, file: !36, line: 489, column: 21)
!341 = !DILocation(line: 490, column: 35, scope: !340)
!342 = !DILocation(line: 490, column: 33, scope: !340)
!343 = !DILocation(line: 491, column: 21, scope: !340)
!344 = !DILocation(line: 492, column: 17, scope: !333)
!345 = !DILocation(line: 495, column: 20, scope: !302)
!346 = !DILocation(line: 495, column: 13, scope: !302)
!347 = distinct !DISubprogram(name: "MPU_vTaskGetInfoImpl", scope: !36, file: !36, line: 508, type: !348, scopeLine: 512, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!348 = !DISubroutineType(types: !349)
!349 = !{null, !32, !350, !23, !305}
!350 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !351, size: 64)
!351 = !DIDerivedType(tag: DW_TAG_typedef, name: "TaskStatus_t", file: !6, line: 174, baseType: !352)
!352 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xTASK_STATUS", file: !6, line: 159, size: 576, elements: !353)
!353 = !{!354, !355, !359, !360, !361, !362, !363, !364, !365}
!354 = !DIDerivedType(tag: DW_TAG_member, name: "xHandle", scope: !352, file: !6, line: 161, baseType: !32, size: 64)
!355 = !DIDerivedType(tag: DW_TAG_member, name: "pcTaskName", scope: !352, file: !6, line: 162, baseType: !356, size: 64, offset: 64)
!356 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !357, size: 64)
!357 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !358)
!358 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!359 = !DIDerivedType(tag: DW_TAG_member, name: "xTaskNumber", scope: !352, file: !6, line: 163, baseType: !39, size: 64, offset: 128)
!360 = !DIDerivedType(tag: DW_TAG_member, name: "eCurrentState", scope: !352, file: !6, line: 164, baseType: !305, size: 32, offset: 192)
!361 = !DIDerivedType(tag: DW_TAG_member, name: "uxCurrentPriority", scope: !352, file: !6, line: 165, baseType: !39, size: 64, offset: 256)
!362 = !DIDerivedType(tag: DW_TAG_member, name: "uxBasePriority", scope: !352, file: !6, line: 166, baseType: !39, size: 64, offset: 320)
!363 = !DIDerivedType(tag: DW_TAG_member, name: "ulRunTimeCounter", scope: !352, file: !6, line: 167, baseType: !47, size: 32, offset: 384)
!364 = !DIDerivedType(tag: DW_TAG_member, name: "pxStackBase", scope: !352, file: !6, line: 168, baseType: !117, size: 64, offset: 448)
!365 = !DIDerivedType(tag: DW_TAG_member, name: "usStackHighWaterMark", scope: !352, file: !6, line: 173, baseType: !366, size: 16, offset: 512)
!366 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !48, line: 25, baseType: !367)
!367 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !30, line: 39, baseType: !368)
!368 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!369 = !DILocalVariable(name: "xTask", arg: 1, scope: !347, file: !36, line: 508, type: !32)
!370 = !DILocation(line: 508, column: 49, scope: !347)
!371 = !DILocalVariable(name: "pxTaskStatus", arg: 2, scope: !347, file: !36, line: 509, type: !350)
!372 = !DILocation(line: 509, column: 51, scope: !347)
!373 = !DILocalVariable(name: "xGetFreeStackSpace", arg: 3, scope: !347, file: !36, line: 510, type: !23)
!374 = !DILocation(line: 510, column: 47, scope: !347)
!375 = !DILocalVariable(name: "eState", arg: 4, scope: !347, file: !36, line: 511, type: !305)
!376 = !DILocation(line: 511, column: 47, scope: !347)
!377 = !DILocalVariable(name: "lIndex", scope: !347, file: !36, line: 513, type: !27)
!378 = !DILocation(line: 513, column: 21, scope: !347)
!379 = !DILocalVariable(name: "xInternalTaskHandle", scope: !347, file: !36, line: 514, type: !32)
!380 = !DILocation(line: 514, column: 26, scope: !347)
!381 = !DILocalVariable(name: "xIsTaskStatusWriteable", scope: !347, file: !36, line: 515, type: !23)
!382 = !DILocation(line: 515, column: 24, scope: !347)
!383 = !DILocation(line: 517, column: 71, scope: !347)
!384 = !DILocation(line: 517, column: 38, scope: !347)
!385 = !DILocation(line: 517, column: 36, scope: !347)
!386 = !DILocation(line: 521, column: 17, scope: !387)
!387 = distinct !DILexicalBlock(scope: !347, file: !36, line: 521, column: 17)
!388 = !DILocation(line: 521, column: 40, scope: !387)
!389 = !DILocation(line: 521, column: 17, scope: !347)
!390 = !DILocation(line: 523, column: 21, scope: !391)
!391 = distinct !DILexicalBlock(scope: !392, file: !36, line: 523, column: 21)
!392 = distinct !DILexicalBlock(scope: !387, file: !36, line: 522, column: 13)
!393 = !DILocation(line: 523, column: 27, scope: !391)
!394 = !DILocation(line: 523, column: 21, scope: !392)
!395 = !DILocation(line: 525, column: 35, scope: !396)
!396 = distinct !DILexicalBlock(scope: !391, file: !36, line: 524, column: 17)
!397 = !DILocation(line: 525, column: 42, scope: !396)
!398 = !DILocation(line: 525, column: 56, scope: !396)
!399 = !DILocation(line: 525, column: 76, scope: !396)
!400 = !DILocation(line: 525, column: 21, scope: !396)
!401 = !DILocation(line: 526, column: 17, scope: !396)
!402 = !DILocation(line: 529, column: 42, scope: !403)
!403 = distinct !DILexicalBlock(scope: !391, file: !36, line: 528, column: 17)
!404 = !DILocation(line: 529, column: 30, scope: !403)
!405 = !DILocation(line: 529, column: 28, scope: !403)
!406 = !DILocation(line: 531, column: 25, scope: !407)
!407 = distinct !DILexicalBlock(scope: !403, file: !36, line: 531, column: 25)
!408 = !DILocation(line: 0, scope: !407)
!409 = !DILocation(line: 531, column: 59, scope: !407)
!410 = !DILocation(line: 531, column: 25, scope: !403)
!411 = !DILocation(line: 533, column: 47, scope: !412)
!412 = distinct !DILexicalBlock(scope: !407, file: !36, line: 532, column: 21)
!413 = !DILocation(line: 533, column: 45, scope: !412)
!414 = !DILocation(line: 535, column: 29, scope: !415)
!415 = distinct !DILexicalBlock(scope: !412, file: !36, line: 535, column: 29)
!416 = !DILocation(line: 535, column: 49, scope: !415)
!417 = !DILocation(line: 535, column: 29, scope: !412)
!418 = !DILocation(line: 537, column: 43, scope: !419)
!419 = distinct !DILexicalBlock(scope: !415, file: !36, line: 536, column: 25)
!420 = !DILocation(line: 537, column: 64, scope: !419)
!421 = !DILocation(line: 537, column: 78, scope: !419)
!422 = !DILocation(line: 537, column: 98, scope: !419)
!423 = !DILocation(line: 537, column: 29, scope: !419)
!424 = !DILocation(line: 538, column: 25, scope: !419)
!425 = !DILocation(line: 539, column: 21, scope: !412)
!426 = !DILocation(line: 541, column: 13, scope: !392)
!427 = !DILocation(line: 542, column: 9, scope: !347)
!428 = distinct !DISubprogram(name: "MPU_xTaskGetIdleTaskHandleImpl", scope: !36, file: !36, line: 551, type: !429, scopeLine: 552, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!429 = !DISubroutineType(types: !430)
!430 = !{!32}
!431 = !DILocalVariable(name: "xIdleTaskHandle", scope: !428, file: !36, line: 553, type: !32)
!432 = !DILocation(line: 553, column: 26, scope: !428)
!433 = !DILocation(line: 555, column: 31, scope: !428)
!434 = !DILocation(line: 555, column: 29, scope: !428)
!435 = !DILocation(line: 557, column: 20, scope: !428)
!436 = !DILocation(line: 557, column: 13, scope: !428)
!437 = distinct !DISubprogram(name: "MPU_vTaskSuspendImpl", scope: !36, file: !36, line: 567, type: !438, scopeLine: 568, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!438 = !DISubroutineType(types: !439)
!439 = !{null, !32}
!440 = !DILocalVariable(name: "pxTaskToSuspend", arg: 1, scope: !437, file: !36, line: 567, type: !32)
!441 = !DILocation(line: 567, column: 49, scope: !437)
!442 = !DILocalVariable(name: "lIndex", scope: !437, file: !36, line: 569, type: !27)
!443 = !DILocation(line: 569, column: 21, scope: !437)
!444 = !DILocalVariable(name: "xInternalTaskHandle", scope: !437, file: !36, line: 570, type: !32)
!445 = !DILocation(line: 570, column: 26, scope: !437)
!446 = !DILocation(line: 572, column: 17, scope: !447)
!447 = distinct !DILexicalBlock(scope: !437, file: !36, line: 572, column: 17)
!448 = !DILocation(line: 572, column: 33, scope: !447)
!449 = !DILocation(line: 572, column: 17, scope: !437)
!450 = !DILocation(line: 574, column: 31, scope: !451)
!451 = distinct !DILexicalBlock(scope: !447, file: !36, line: 573, column: 13)
!452 = !DILocation(line: 574, column: 17, scope: !451)
!453 = !DILocation(line: 575, column: 13, scope: !451)
!454 = !DILocation(line: 580, column: 23, scope: !455)
!455 = distinct !DILexicalBlock(scope: !456, file: !36, line: 580, column: 21)
!456 = distinct !DILexicalBlock(scope: !447, file: !36, line: 577, column: 13)
!457 = !DILocation(line: 580, column: 48, scope: !455)
!458 = !DILocation(line: 580, column: 79, scope: !455)
!459 = !DILocation(line: 580, column: 84, scope: !455)
!460 = !DILocation(line: 580, column: 109, scope: !455)
!461 = !DILocation(line: 580, column: 21, scope: !456)
!462 = !DILocation(line: 582, column: 42, scope: !463)
!463 = distinct !DILexicalBlock(scope: !455, file: !36, line: 581, column: 17)
!464 = !DILocation(line: 582, column: 30, scope: !463)
!465 = !DILocation(line: 582, column: 28, scope: !463)
!466 = !DILocation(line: 584, column: 25, scope: !467)
!467 = distinct !DILexicalBlock(scope: !463, file: !36, line: 584, column: 25)
!468 = !DILocation(line: 0, scope: !467)
!469 = !DILocation(line: 584, column: 59, scope: !467)
!470 = !DILocation(line: 584, column: 25, scope: !463)
!471 = !DILocation(line: 586, column: 47, scope: !472)
!472 = distinct !DILexicalBlock(scope: !467, file: !36, line: 585, column: 21)
!473 = !DILocation(line: 586, column: 45, scope: !472)
!474 = !DILocation(line: 588, column: 29, scope: !475)
!475 = distinct !DILexicalBlock(scope: !472, file: !36, line: 588, column: 29)
!476 = !DILocation(line: 588, column: 49, scope: !475)
!477 = !DILocation(line: 588, column: 29, scope: !472)
!478 = !DILocation(line: 590, column: 43, scope: !479)
!479 = distinct !DILexicalBlock(scope: !475, file: !36, line: 589, column: 25)
!480 = !DILocation(line: 590, column: 29, scope: !479)
!481 = !DILocation(line: 591, column: 25, scope: !479)
!482 = !DILocation(line: 592, column: 21, scope: !472)
!483 = !DILocation(line: 593, column: 17, scope: !463)
!484 = !DILocation(line: 595, column: 9, scope: !437)
!485 = distinct !DISubprogram(name: "MPU_vTaskResumeImpl", scope: !36, file: !36, line: 604, type: !438, scopeLine: 605, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!486 = !DILocalVariable(name: "pxTaskToResume", arg: 1, scope: !485, file: !36, line: 604, type: !32)
!487 = !DILocation(line: 604, column: 48, scope: !485)
!488 = !DILocalVariable(name: "lIndex", scope: !485, file: !36, line: 606, type: !27)
!489 = !DILocation(line: 606, column: 21, scope: !485)
!490 = !DILocalVariable(name: "xInternalTaskHandle", scope: !485, file: !36, line: 607, type: !32)
!491 = !DILocation(line: 607, column: 26, scope: !485)
!492 = !DILocation(line: 609, column: 34, scope: !485)
!493 = !DILocation(line: 609, column: 22, scope: !485)
!494 = !DILocation(line: 609, column: 20, scope: !485)
!495 = !DILocation(line: 611, column: 17, scope: !496)
!496 = distinct !DILexicalBlock(scope: !485, file: !36, line: 611, column: 17)
!497 = !DILocation(line: 0, scope: !496)
!498 = !DILocation(line: 611, column: 51, scope: !496)
!499 = !DILocation(line: 611, column: 17, scope: !485)
!500 = !DILocation(line: 613, column: 39, scope: !501)
!501 = distinct !DILexicalBlock(scope: !496, file: !36, line: 612, column: 13)
!502 = !DILocation(line: 613, column: 37, scope: !501)
!503 = !DILocation(line: 615, column: 21, scope: !504)
!504 = distinct !DILexicalBlock(scope: !501, file: !36, line: 615, column: 21)
!505 = !DILocation(line: 615, column: 41, scope: !504)
!506 = !DILocation(line: 615, column: 21, scope: !501)
!507 = !DILocation(line: 617, column: 34, scope: !508)
!508 = distinct !DILexicalBlock(scope: !504, file: !36, line: 616, column: 17)
!509 = !DILocation(line: 617, column: 21, scope: !508)
!510 = !DILocation(line: 618, column: 17, scope: !508)
!511 = !DILocation(line: 619, column: 13, scope: !501)
!512 = !DILocation(line: 620, column: 9, scope: !485)
!513 = distinct !DISubprogram(name: "MPU_xTaskGetTickCountImpl", scope: !36, file: !36, line: 627, type: !514, scopeLine: 628, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!514 = !DISubroutineType(types: !515)
!515 = !{!119}
!516 = !DILocalVariable(name: "xReturn", scope: !513, file: !36, line: 629, type: !119)
!517 = !DILocation(line: 629, column: 20, scope: !513)
!518 = !DILocation(line: 631, column: 19, scope: !513)
!519 = !DILocation(line: 631, column: 17, scope: !513)
!520 = !DILocation(line: 633, column: 16, scope: !513)
!521 = !DILocation(line: 633, column: 9, scope: !513)
!522 = distinct !DISubprogram(name: "MPU_uxTaskGetNumberOfTasksImpl", scope: !36, file: !36, line: 639, type: !523, scopeLine: 640, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!523 = !DISubroutineType(types: !524)
!524 = !{!39}
!525 = !DILocalVariable(name: "uxReturn", scope: !522, file: !36, line: 641, type: !39)
!526 = !DILocation(line: 641, column: 21, scope: !522)
!527 = !DILocation(line: 643, column: 20, scope: !522)
!528 = !DILocation(line: 643, column: 18, scope: !522)
!529 = !DILocation(line: 645, column: 16, scope: !522)
!530 = !DILocation(line: 645, column: 9, scope: !522)
!531 = distinct !DISubprogram(name: "MPU_pcTaskGetNameImpl", scope: !36, file: !36, line: 651, type: !532, scopeLine: 652, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!532 = !DISubroutineType(types: !533)
!533 = !{!534, !32}
!534 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !358, size: 64)
!535 = !DILocalVariable(name: "xTaskToQuery", arg: 1, scope: !531, file: !36, line: 651, type: !32)
!536 = !DILocation(line: 651, column: 48, scope: !531)
!537 = !DILocalVariable(name: "pcReturn", scope: !531, file: !36, line: 653, type: !534)
!538 = !DILocation(line: 653, column: 16, scope: !531)
!539 = !DILocalVariable(name: "lIndex", scope: !531, file: !36, line: 654, type: !27)
!540 = !DILocation(line: 654, column: 17, scope: !531)
!541 = !DILocalVariable(name: "xInternalTaskHandle", scope: !531, file: !36, line: 655, type: !32)
!542 = !DILocation(line: 655, column: 22, scope: !531)
!543 = !DILocation(line: 657, column: 13, scope: !544)
!544 = distinct !DILexicalBlock(scope: !531, file: !36, line: 657, column: 13)
!545 = !DILocation(line: 657, column: 26, scope: !544)
!546 = !DILocation(line: 657, column: 13, scope: !531)
!547 = !DILocation(line: 659, column: 39, scope: !548)
!548 = distinct !DILexicalBlock(scope: !544, file: !36, line: 658, column: 9)
!549 = !DILocation(line: 659, column: 24, scope: !548)
!550 = !DILocation(line: 659, column: 22, scope: !548)
!551 = !DILocation(line: 660, column: 9, scope: !548)
!552 = !DILocation(line: 663, column: 34, scope: !553)
!553 = distinct !DILexicalBlock(scope: !544, file: !36, line: 662, column: 9)
!554 = !DILocation(line: 663, column: 22, scope: !553)
!555 = !DILocation(line: 663, column: 20, scope: !553)
!556 = !DILocation(line: 665, column: 17, scope: !557)
!557 = distinct !DILexicalBlock(scope: !553, file: !36, line: 665, column: 17)
!558 = !DILocation(line: 0, scope: !557)
!559 = !DILocation(line: 665, column: 51, scope: !557)
!560 = !DILocation(line: 665, column: 17, scope: !553)
!561 = !DILocation(line: 667, column: 39, scope: !562)
!562 = distinct !DILexicalBlock(scope: !557, file: !36, line: 666, column: 13)
!563 = !DILocation(line: 667, column: 37, scope: !562)
!564 = !DILocation(line: 669, column: 21, scope: !565)
!565 = distinct !DILexicalBlock(scope: !562, file: !36, line: 669, column: 21)
!566 = !DILocation(line: 669, column: 41, scope: !565)
!567 = !DILocation(line: 669, column: 21, scope: !562)
!568 = !DILocation(line: 671, column: 47, scope: !569)
!569 = distinct !DILexicalBlock(scope: !565, file: !36, line: 670, column: 17)
!570 = !DILocation(line: 671, column: 32, scope: !569)
!571 = !DILocation(line: 671, column: 30, scope: !569)
!572 = !DILocation(line: 672, column: 17, scope: !569)
!573 = !DILocation(line: 673, column: 13, scope: !562)
!574 = !DILocation(line: 676, column: 16, scope: !531)
!575 = !DILocation(line: 676, column: 9, scope: !531)
!576 = distinct !DISubprogram(name: "MPU_ulTaskGetRunTimeCounterImpl", scope: !36, file: !36, line: 684, type: !577, scopeLine: 685, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!577 = !DISubroutineType(types: !578)
!578 = !{!47, !260}
!579 = !DILocalVariable(name: "xTask", arg: 1, scope: !576, file: !36, line: 684, type: !260)
!580 = !DILocation(line: 684, column: 89, scope: !576)
!581 = !DILocalVariable(name: "xReturn", scope: !576, file: !36, line: 686, type: !47)
!582 = !DILocation(line: 686, column: 41, scope: !576)
!583 = !DILocalVariable(name: "lIndex", scope: !576, file: !36, line: 687, type: !27)
!584 = !DILocation(line: 687, column: 21, scope: !576)
!585 = !DILocalVariable(name: "xInternalTaskHandle", scope: !576, file: !36, line: 688, type: !32)
!586 = !DILocation(line: 688, column: 26, scope: !576)
!587 = !DILocation(line: 690, column: 17, scope: !588)
!588 = distinct !DILexicalBlock(scope: !576, file: !36, line: 690, column: 17)
!589 = !DILocation(line: 690, column: 23, scope: !588)
!590 = !DILocation(line: 690, column: 17, scope: !576)
!591 = !DILocation(line: 692, column: 52, scope: !592)
!592 = distinct !DILexicalBlock(scope: !588, file: !36, line: 691, column: 13)
!593 = !DILocation(line: 692, column: 27, scope: !592)
!594 = !DILocation(line: 692, column: 25, scope: !592)
!595 = !DILocation(line: 693, column: 13, scope: !592)
!596 = !DILocation(line: 696, column: 38, scope: !597)
!597 = distinct !DILexicalBlock(scope: !588, file: !36, line: 695, column: 13)
!598 = !DILocation(line: 696, column: 26, scope: !597)
!599 = !DILocation(line: 696, column: 24, scope: !597)
!600 = !DILocation(line: 698, column: 21, scope: !601)
!601 = distinct !DILexicalBlock(scope: !597, file: !36, line: 698, column: 21)
!602 = !DILocation(line: 0, scope: !601)
!603 = !DILocation(line: 698, column: 55, scope: !601)
!604 = !DILocation(line: 698, column: 21, scope: !597)
!605 = !DILocation(line: 700, column: 43, scope: !606)
!606 = distinct !DILexicalBlock(scope: !601, file: !36, line: 699, column: 17)
!607 = !DILocation(line: 700, column: 41, scope: !606)
!608 = !DILocation(line: 702, column: 25, scope: !609)
!609 = distinct !DILexicalBlock(scope: !606, file: !36, line: 702, column: 25)
!610 = !DILocation(line: 702, column: 45, scope: !609)
!611 = !DILocation(line: 702, column: 25, scope: !606)
!612 = !DILocation(line: 704, column: 60, scope: !613)
!613 = distinct !DILexicalBlock(scope: !609, file: !36, line: 703, column: 21)
!614 = !DILocation(line: 704, column: 35, scope: !613)
!615 = !DILocation(line: 704, column: 33, scope: !613)
!616 = !DILocation(line: 705, column: 21, scope: !613)
!617 = !DILocation(line: 706, column: 17, scope: !606)
!618 = !DILocation(line: 709, column: 20, scope: !576)
!619 = !DILocation(line: 709, column: 13, scope: !576)
!620 = distinct !DISubprogram(name: "MPU_ulTaskGetRunTimePercentImpl", scope: !36, file: !36, line: 719, type: !577, scopeLine: 720, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!621 = !DILocalVariable(name: "xTask", arg: 1, scope: !620, file: !36, line: 719, type: !260)
!622 = !DILocation(line: 719, column: 89, scope: !620)
!623 = !DILocalVariable(name: "xReturn", scope: !620, file: !36, line: 721, type: !47)
!624 = !DILocation(line: 721, column: 41, scope: !620)
!625 = !DILocalVariable(name: "lIndex", scope: !620, file: !36, line: 722, type: !27)
!626 = !DILocation(line: 722, column: 21, scope: !620)
!627 = !DILocalVariable(name: "xInternalTaskHandle", scope: !620, file: !36, line: 723, type: !32)
!628 = !DILocation(line: 723, column: 26, scope: !620)
!629 = !DILocation(line: 725, column: 17, scope: !630)
!630 = distinct !DILexicalBlock(scope: !620, file: !36, line: 725, column: 17)
!631 = !DILocation(line: 725, column: 23, scope: !630)
!632 = !DILocation(line: 725, column: 17, scope: !620)
!633 = !DILocation(line: 727, column: 52, scope: !634)
!634 = distinct !DILexicalBlock(scope: !630, file: !36, line: 726, column: 13)
!635 = !DILocation(line: 727, column: 27, scope: !634)
!636 = !DILocation(line: 727, column: 25, scope: !634)
!637 = !DILocation(line: 728, column: 13, scope: !634)
!638 = !DILocation(line: 731, column: 38, scope: !639)
!639 = distinct !DILexicalBlock(scope: !630, file: !36, line: 730, column: 13)
!640 = !DILocation(line: 731, column: 26, scope: !639)
!641 = !DILocation(line: 731, column: 24, scope: !639)
!642 = !DILocation(line: 733, column: 21, scope: !643)
!643 = distinct !DILexicalBlock(scope: !639, file: !36, line: 733, column: 21)
!644 = !DILocation(line: 0, scope: !643)
!645 = !DILocation(line: 733, column: 55, scope: !643)
!646 = !DILocation(line: 733, column: 21, scope: !639)
!647 = !DILocation(line: 735, column: 43, scope: !648)
!648 = distinct !DILexicalBlock(scope: !643, file: !36, line: 734, column: 17)
!649 = !DILocation(line: 735, column: 41, scope: !648)
!650 = !DILocation(line: 737, column: 25, scope: !651)
!651 = distinct !DILexicalBlock(scope: !648, file: !36, line: 737, column: 25)
!652 = !DILocation(line: 737, column: 45, scope: !651)
!653 = !DILocation(line: 737, column: 25, scope: !648)
!654 = !DILocation(line: 739, column: 60, scope: !655)
!655 = distinct !DILexicalBlock(scope: !651, file: !36, line: 738, column: 21)
!656 = !DILocation(line: 739, column: 35, scope: !655)
!657 = !DILocation(line: 739, column: 33, scope: !655)
!658 = !DILocation(line: 740, column: 21, scope: !655)
!659 = !DILocation(line: 741, column: 17, scope: !648)
!660 = !DILocation(line: 744, column: 20, scope: !620)
!661 = !DILocation(line: 744, column: 13, scope: !620)
!662 = distinct !DISubprogram(name: "MPU_ulTaskGetIdleRunTimePercentImpl", scope: !36, file: !36, line: 754, type: !663, scopeLine: 755, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!663 = !DISubroutineType(types: !664)
!664 = !{!47}
!665 = !DILocalVariable(name: "xReturn", scope: !662, file: !36, line: 756, type: !47)
!666 = !DILocation(line: 756, column: 41, scope: !662)
!667 = !DILocation(line: 758, column: 23, scope: !662)
!668 = !DILocation(line: 758, column: 21, scope: !662)
!669 = !DILocation(line: 760, column: 20, scope: !662)
!670 = !DILocation(line: 760, column: 13, scope: !662)
!671 = distinct !DISubprogram(name: "MPU_ulTaskGetIdleRunTimeCounterImpl", scope: !36, file: !36, line: 770, type: !663, scopeLine: 771, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!672 = !DILocalVariable(name: "xReturn", scope: !671, file: !36, line: 772, type: !47)
!673 = !DILocation(line: 772, column: 41, scope: !671)
!674 = !DILocation(line: 774, column: 23, scope: !671)
!675 = !DILocation(line: 774, column: 21, scope: !671)
!676 = !DILocation(line: 776, column: 20, scope: !671)
!677 = !DILocation(line: 776, column: 13, scope: !671)
!678 = distinct !DISubprogram(name: "MPU_vTaskSetApplicationTaskTagImpl", scope: !36, file: !36, line: 787, type: !679, scopeLine: 789, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!679 = !DISubroutineType(types: !680)
!680 = !{null, !32, !681}
!681 = !DIDerivedType(tag: DW_TAG_typedef, name: "TaskHookFunction_t", file: !6, line: 98, baseType: !682)
!682 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !683, size: 64)
!683 = !DISubroutineType(types: !684)
!684 = !{!23, !26}
!685 = !DILocalVariable(name: "xTask", arg: 1, scope: !678, file: !36, line: 787, type: !32)
!686 = !DILocation(line: 787, column: 63, scope: !678)
!687 = !DILocalVariable(name: "pxTagValue", arg: 2, scope: !678, file: !36, line: 788, type: !681)
!688 = !DILocation(line: 788, column: 69, scope: !678)
!689 = !DILocalVariable(name: "xInternalTaskHandle", scope: !678, file: !36, line: 790, type: !32)
!690 = !DILocation(line: 790, column: 26, scope: !678)
!691 = !DILocalVariable(name: "lIndex", scope: !678, file: !36, line: 791, type: !27)
!692 = !DILocation(line: 791, column: 21, scope: !678)
!693 = !DILocation(line: 793, column: 17, scope: !694)
!694 = distinct !DILexicalBlock(scope: !678, file: !36, line: 793, column: 17)
!695 = !DILocation(line: 793, column: 23, scope: !694)
!696 = !DILocation(line: 793, column: 17, scope: !678)
!697 = !DILocation(line: 795, column: 45, scope: !698)
!698 = distinct !DILexicalBlock(scope: !694, file: !36, line: 794, column: 13)
!699 = !DILocation(line: 795, column: 52, scope: !698)
!700 = !DILocation(line: 795, column: 17, scope: !698)
!701 = !DILocation(line: 796, column: 13, scope: !698)
!702 = !DILocation(line: 799, column: 38, scope: !703)
!703 = distinct !DILexicalBlock(scope: !694, file: !36, line: 798, column: 13)
!704 = !DILocation(line: 799, column: 26, scope: !703)
!705 = !DILocation(line: 799, column: 24, scope: !703)
!706 = !DILocation(line: 801, column: 21, scope: !707)
!707 = distinct !DILexicalBlock(scope: !703, file: !36, line: 801, column: 21)
!708 = !DILocation(line: 0, scope: !707)
!709 = !DILocation(line: 801, column: 55, scope: !707)
!710 = !DILocation(line: 801, column: 21, scope: !703)
!711 = !DILocation(line: 803, column: 43, scope: !712)
!712 = distinct !DILexicalBlock(scope: !707, file: !36, line: 802, column: 17)
!713 = !DILocation(line: 803, column: 41, scope: !712)
!714 = !DILocation(line: 805, column: 25, scope: !715)
!715 = distinct !DILexicalBlock(scope: !712, file: !36, line: 805, column: 25)
!716 = !DILocation(line: 805, column: 45, scope: !715)
!717 = !DILocation(line: 805, column: 25, scope: !712)
!718 = !DILocation(line: 807, column: 53, scope: !719)
!719 = distinct !DILexicalBlock(scope: !715, file: !36, line: 806, column: 21)
!720 = !DILocation(line: 807, column: 74, scope: !719)
!721 = !DILocation(line: 807, column: 25, scope: !719)
!722 = !DILocation(line: 808, column: 21, scope: !719)
!723 = !DILocation(line: 809, column: 17, scope: !712)
!724 = !DILocation(line: 811, column: 9, scope: !678)
!725 = distinct !DISubprogram(name: "MPU_xTaskGetApplicationTaskTagImpl", scope: !36, file: !36, line: 820, type: !726, scopeLine: 821, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!726 = !DISubroutineType(types: !727)
!727 = !{!681, !32}
!728 = !DILocalVariable(name: "xTask", arg: 1, scope: !725, file: !36, line: 820, type: !32)
!729 = !DILocation(line: 820, column: 77, scope: !725)
!730 = !DILocalVariable(name: "xReturn", scope: !725, file: !36, line: 822, type: !681)
!731 = !DILocation(line: 822, column: 32, scope: !725)
!732 = !DILocalVariable(name: "lIndex", scope: !725, file: !36, line: 823, type: !27)
!733 = !DILocation(line: 823, column: 21, scope: !725)
!734 = !DILocalVariable(name: "xInternalTaskHandle", scope: !725, file: !36, line: 824, type: !32)
!735 = !DILocation(line: 824, column: 26, scope: !725)
!736 = !DILocation(line: 826, column: 17, scope: !737)
!737 = distinct !DILexicalBlock(scope: !725, file: !36, line: 826, column: 17)
!738 = !DILocation(line: 826, column: 23, scope: !737)
!739 = !DILocation(line: 826, column: 17, scope: !725)
!740 = !DILocation(line: 828, column: 55, scope: !741)
!741 = distinct !DILexicalBlock(scope: !737, file: !36, line: 827, column: 13)
!742 = !DILocation(line: 828, column: 27, scope: !741)
!743 = !DILocation(line: 828, column: 25, scope: !741)
!744 = !DILocation(line: 829, column: 13, scope: !741)
!745 = !DILocation(line: 832, column: 38, scope: !746)
!746 = distinct !DILexicalBlock(scope: !737, file: !36, line: 831, column: 13)
!747 = !DILocation(line: 832, column: 26, scope: !746)
!748 = !DILocation(line: 832, column: 24, scope: !746)
!749 = !DILocation(line: 834, column: 21, scope: !750)
!750 = distinct !DILexicalBlock(scope: !746, file: !36, line: 834, column: 21)
!751 = !DILocation(line: 0, scope: !750)
!752 = !DILocation(line: 834, column: 55, scope: !750)
!753 = !DILocation(line: 834, column: 21, scope: !746)
!754 = !DILocation(line: 836, column: 43, scope: !755)
!755 = distinct !DILexicalBlock(scope: !750, file: !36, line: 835, column: 17)
!756 = !DILocation(line: 836, column: 41, scope: !755)
!757 = !DILocation(line: 838, column: 25, scope: !758)
!758 = distinct !DILexicalBlock(scope: !755, file: !36, line: 838, column: 25)
!759 = !DILocation(line: 838, column: 45, scope: !758)
!760 = !DILocation(line: 838, column: 25, scope: !755)
!761 = !DILocation(line: 840, column: 63, scope: !762)
!762 = distinct !DILexicalBlock(scope: !758, file: !36, line: 839, column: 21)
!763 = !DILocation(line: 840, column: 35, scope: !762)
!764 = !DILocation(line: 840, column: 33, scope: !762)
!765 = !DILocation(line: 841, column: 21, scope: !762)
!766 = !DILocation(line: 842, column: 17, scope: !755)
!767 = !DILocation(line: 845, column: 20, scope: !725)
!768 = !DILocation(line: 845, column: 13, scope: !725)
!769 = distinct !DISubprogram(name: "MPU_vTaskSetThreadLocalStoragePointerImpl", scope: !36, file: !36, line: 857, type: !770, scopeLine: 860, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!770 = !DISubroutineType(types: !771)
!771 = !{null, !32, !23, !26}
!772 = !DILocalVariable(name: "xTaskToSet", arg: 1, scope: !769, file: !36, line: 857, type: !32)
!773 = !DILocation(line: 857, column: 70, scope: !769)
!774 = !DILocalVariable(name: "xIndex", arg: 2, scope: !769, file: !36, line: 858, type: !23)
!775 = !DILocation(line: 858, column: 68, scope: !769)
!776 = !DILocalVariable(name: "pvValue", arg: 3, scope: !769, file: !36, line: 859, type: !26)
!777 = !DILocation(line: 859, column: 64, scope: !769)
!778 = !DILocalVariable(name: "lIndex", scope: !769, file: !36, line: 861, type: !27)
!779 = !DILocation(line: 861, column: 21, scope: !769)
!780 = !DILocalVariable(name: "xInternalTaskHandle", scope: !769, file: !36, line: 862, type: !32)
!781 = !DILocation(line: 862, column: 26, scope: !769)
!782 = !DILocation(line: 864, column: 17, scope: !783)
!783 = distinct !DILexicalBlock(scope: !769, file: !36, line: 864, column: 17)
!784 = !DILocation(line: 864, column: 28, scope: !783)
!785 = !DILocation(line: 864, column: 17, scope: !769)
!786 = !DILocation(line: 866, column: 52, scope: !787)
!787 = distinct !DILexicalBlock(scope: !783, file: !36, line: 865, column: 13)
!788 = !DILocation(line: 866, column: 64, scope: !787)
!789 = !DILocation(line: 866, column: 72, scope: !787)
!790 = !DILocation(line: 866, column: 17, scope: !787)
!791 = !DILocation(line: 867, column: 13, scope: !787)
!792 = !DILocation(line: 870, column: 38, scope: !793)
!793 = distinct !DILexicalBlock(scope: !783, file: !36, line: 869, column: 13)
!794 = !DILocation(line: 870, column: 26, scope: !793)
!795 = !DILocation(line: 870, column: 24, scope: !793)
!796 = !DILocation(line: 872, column: 21, scope: !797)
!797 = distinct !DILexicalBlock(scope: !793, file: !36, line: 872, column: 21)
!798 = !DILocation(line: 0, scope: !797)
!799 = !DILocation(line: 872, column: 55, scope: !797)
!800 = !DILocation(line: 872, column: 21, scope: !793)
!801 = !DILocation(line: 874, column: 43, scope: !802)
!802 = distinct !DILexicalBlock(scope: !797, file: !36, line: 873, column: 17)
!803 = !DILocation(line: 874, column: 41, scope: !802)
!804 = !DILocation(line: 876, column: 25, scope: !805)
!805 = distinct !DILexicalBlock(scope: !802, file: !36, line: 876, column: 25)
!806 = !DILocation(line: 876, column: 45, scope: !805)
!807 = !DILocation(line: 876, column: 25, scope: !802)
!808 = !DILocation(line: 878, column: 60, scope: !809)
!809 = distinct !DILexicalBlock(scope: !805, file: !36, line: 877, column: 21)
!810 = !DILocation(line: 878, column: 81, scope: !809)
!811 = !DILocation(line: 878, column: 89, scope: !809)
!812 = !DILocation(line: 878, column: 25, scope: !809)
!813 = !DILocation(line: 879, column: 21, scope: !809)
!814 = !DILocation(line: 880, column: 17, scope: !802)
!815 = !DILocation(line: 882, column: 9, scope: !769)
!816 = distinct !DISubprogram(name: "MPU_pvTaskGetThreadLocalStoragePointerImpl", scope: !36, file: !36, line: 892, type: !817, scopeLine: 894, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!817 = !DISubroutineType(types: !818)
!818 = !{!26, !32, !23}
!819 = !DILocalVariable(name: "xTaskToQuery", arg: 1, scope: !816, file: !36, line: 892, type: !32)
!820 = !DILocation(line: 892, column: 73, scope: !816)
!821 = !DILocalVariable(name: "xIndex", arg: 2, scope: !816, file: !36, line: 893, type: !23)
!822 = !DILocation(line: 893, column: 71, scope: !816)
!823 = !DILocalVariable(name: "pvReturn", scope: !816, file: !36, line: 895, type: !26)
!824 = !DILocation(line: 895, column: 20, scope: !816)
!825 = !DILocalVariable(name: "lIndex", scope: !816, file: !36, line: 896, type: !27)
!826 = !DILocation(line: 896, column: 21, scope: !816)
!827 = !DILocalVariable(name: "xInternalTaskHandle", scope: !816, file: !36, line: 897, type: !32)
!828 = !DILocation(line: 897, column: 26, scope: !816)
!829 = !DILocation(line: 899, column: 17, scope: !830)
!830 = distinct !DILexicalBlock(scope: !816, file: !36, line: 899, column: 17)
!831 = !DILocation(line: 899, column: 30, scope: !830)
!832 = !DILocation(line: 899, column: 17, scope: !816)
!833 = !DILocation(line: 901, column: 64, scope: !834)
!834 = distinct !DILexicalBlock(scope: !830, file: !36, line: 900, column: 13)
!835 = !DILocation(line: 901, column: 78, scope: !834)
!836 = !DILocation(line: 901, column: 28, scope: !834)
!837 = !DILocation(line: 901, column: 26, scope: !834)
!838 = !DILocation(line: 902, column: 13, scope: !834)
!839 = !DILocation(line: 905, column: 38, scope: !840)
!840 = distinct !DILexicalBlock(scope: !830, file: !36, line: 904, column: 13)
!841 = !DILocation(line: 905, column: 26, scope: !840)
!842 = !DILocation(line: 905, column: 24, scope: !840)
!843 = !DILocation(line: 907, column: 21, scope: !844)
!844 = distinct !DILexicalBlock(scope: !840, file: !36, line: 907, column: 21)
!845 = !DILocation(line: 0, scope: !844)
!846 = !DILocation(line: 907, column: 55, scope: !844)
!847 = !DILocation(line: 907, column: 21, scope: !840)
!848 = !DILocation(line: 909, column: 43, scope: !849)
!849 = distinct !DILexicalBlock(scope: !844, file: !36, line: 908, column: 17)
!850 = !DILocation(line: 909, column: 41, scope: !849)
!851 = !DILocation(line: 911, column: 25, scope: !852)
!852 = distinct !DILexicalBlock(scope: !849, file: !36, line: 911, column: 25)
!853 = !DILocation(line: 911, column: 45, scope: !852)
!854 = !DILocation(line: 911, column: 25, scope: !849)
!855 = !DILocation(line: 913, column: 72, scope: !856)
!856 = distinct !DILexicalBlock(scope: !852, file: !36, line: 912, column: 21)
!857 = !DILocation(line: 913, column: 93, scope: !856)
!858 = !DILocation(line: 913, column: 36, scope: !856)
!859 = !DILocation(line: 913, column: 34, scope: !856)
!860 = !DILocation(line: 914, column: 21, scope: !856)
!861 = !DILocation(line: 915, column: 17, scope: !849)
!862 = !DILocation(line: 918, column: 20, scope: !816)
!863 = !DILocation(line: 918, column: 13, scope: !816)
!864 = distinct !DISubprogram(name: "MPU_uxTaskGetSystemStateImpl", scope: !36, file: !36, line: 930, type: !865, scopeLine: 933, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!865 = !DISubroutineType(types: !866)
!866 = !{!39, !350, !39, !867}
!867 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !47, size: 64)
!868 = !DILocalVariable(name: "pxTaskStatusArray", arg: 1, scope: !864, file: !36, line: 930, type: !350)
!869 = !DILocation(line: 930, column: 66, scope: !864)
!870 = !DILocalVariable(name: "uxArraySize", arg: 2, scope: !864, file: !36, line: 931, type: !39)
!871 = !DILocation(line: 931, column: 63, scope: !864)
!872 = !DILocalVariable(name: "pulTotalRunTime", arg: 3, scope: !864, file: !36, line: 932, type: !867)
!873 = !DILocation(line: 932, column: 81, scope: !864)
!874 = !DILocalVariable(name: "uxReturn", scope: !864, file: !36, line: 934, type: !39)
!875 = !DILocation(line: 934, column: 25, scope: !864)
!876 = !DILocalVariable(name: "xIsTaskStatusArrayWriteable", scope: !864, file: !36, line: 935, type: !39)
!877 = !DILocation(line: 935, column: 25, scope: !864)
!878 = !DILocalVariable(name: "xIsTotalRunTimeWriteable", scope: !864, file: !36, line: 936, type: !39)
!879 = !DILocation(line: 936, column: 25, scope: !864)
!880 = !DILocation(line: 938, column: 76, scope: !864)
!881 = !DILocation(line: 939, column: 101, scope: !864)
!882 = !DILocation(line: 939, column: 99, scope: !864)
!883 = !DILocation(line: 939, column: 76, scope: !864)
!884 = !DILocation(line: 938, column: 43, scope: !864)
!885 = !DILocation(line: 938, column: 41, scope: !864)
!886 = !DILocation(line: 942, column: 17, scope: !887)
!887 = distinct !DILexicalBlock(scope: !864, file: !36, line: 942, column: 17)
!888 = !DILocation(line: 942, column: 33, scope: !887)
!889 = !DILocation(line: 942, column: 17, scope: !864)
!890 = !DILocation(line: 944, column: 77, scope: !891)
!891 = distinct !DILexicalBlock(scope: !887, file: !36, line: 943, column: 13)
!892 = !DILocation(line: 944, column: 44, scope: !891)
!893 = !DILocation(line: 944, column: 42, scope: !891)
!894 = !DILocation(line: 947, column: 13, scope: !891)
!895 = !DILocation(line: 949, column: 19, scope: !896)
!896 = distinct !DILexicalBlock(scope: !864, file: !36, line: 949, column: 17)
!897 = !DILocation(line: 949, column: 47, scope: !896)
!898 = !DILocation(line: 949, column: 59, scope: !896)
!899 = !DILocation(line: 950, column: 21, scope: !896)
!900 = !DILocation(line: 950, column: 37, scope: !896)
!901 = !DILocation(line: 950, column: 47, scope: !896)
!902 = !DILocation(line: 950, column: 52, scope: !896)
!903 = !DILocation(line: 950, column: 77, scope: !896)
!904 = !DILocation(line: 949, column: 17, scope: !864)
!905 = !DILocation(line: 952, column: 50, scope: !906)
!906 = distinct !DILexicalBlock(scope: !896, file: !36, line: 951, column: 13)
!907 = !DILocation(line: 952, column: 69, scope: !906)
!908 = !DILocation(line: 952, column: 82, scope: !906)
!909 = !DILocation(line: 952, column: 28, scope: !906)
!910 = !DILocation(line: 952, column: 26, scope: !906)
!911 = !DILocation(line: 953, column: 13, scope: !906)
!912 = !DILocation(line: 955, column: 20, scope: !864)
!913 = !DILocation(line: 955, column: 13, scope: !864)
!914 = distinct !DISubprogram(name: "MPU_uxTaskGetStackHighWaterMarkImpl", scope: !36, file: !36, line: 965, type: !915, scopeLine: 966, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!915 = !DISubroutineType(types: !916)
!916 = !{!39, !32}
!917 = !DILocalVariable(name: "xTask", arg: 1, scope: !914, file: !36, line: 965, type: !32)
!918 = !DILocation(line: 965, column: 71, scope: !914)
!919 = !DILocalVariable(name: "uxReturn", scope: !914, file: !36, line: 967, type: !39)
!920 = !DILocation(line: 967, column: 25, scope: !914)
!921 = !DILocalVariable(name: "lIndex", scope: !914, file: !36, line: 968, type: !27)
!922 = !DILocation(line: 968, column: 21, scope: !914)
!923 = !DILocalVariable(name: "xInternalTaskHandle", scope: !914, file: !36, line: 969, type: !32)
!924 = !DILocation(line: 969, column: 26, scope: !914)
!925 = !DILocation(line: 971, column: 17, scope: !926)
!926 = distinct !DILexicalBlock(scope: !914, file: !36, line: 971, column: 17)
!927 = !DILocation(line: 971, column: 23, scope: !926)
!928 = !DILocation(line: 971, column: 17, scope: !914)
!929 = !DILocation(line: 973, column: 57, scope: !930)
!930 = distinct !DILexicalBlock(scope: !926, file: !36, line: 972, column: 13)
!931 = !DILocation(line: 973, column: 28, scope: !930)
!932 = !DILocation(line: 973, column: 26, scope: !930)
!933 = !DILocation(line: 974, column: 13, scope: !930)
!934 = !DILocation(line: 977, column: 38, scope: !935)
!935 = distinct !DILexicalBlock(scope: !926, file: !36, line: 976, column: 13)
!936 = !DILocation(line: 977, column: 26, scope: !935)
!937 = !DILocation(line: 977, column: 24, scope: !935)
!938 = !DILocation(line: 979, column: 21, scope: !939)
!939 = distinct !DILexicalBlock(scope: !935, file: !36, line: 979, column: 21)
!940 = !DILocation(line: 0, scope: !939)
!941 = !DILocation(line: 979, column: 55, scope: !939)
!942 = !DILocation(line: 979, column: 21, scope: !935)
!943 = !DILocation(line: 981, column: 43, scope: !944)
!944 = distinct !DILexicalBlock(scope: !939, file: !36, line: 980, column: 17)
!945 = !DILocation(line: 981, column: 41, scope: !944)
!946 = !DILocation(line: 983, column: 25, scope: !947)
!947 = distinct !DILexicalBlock(scope: !944, file: !36, line: 983, column: 25)
!948 = !DILocation(line: 983, column: 45, scope: !947)
!949 = !DILocation(line: 983, column: 25, scope: !944)
!950 = !DILocation(line: 985, column: 65, scope: !951)
!951 = distinct !DILexicalBlock(scope: !947, file: !36, line: 984, column: 21)
!952 = !DILocation(line: 985, column: 36, scope: !951)
!953 = !DILocation(line: 985, column: 34, scope: !951)
!954 = !DILocation(line: 986, column: 21, scope: !951)
!955 = !DILocation(line: 987, column: 17, scope: !944)
!956 = !DILocation(line: 990, column: 20, scope: !914)
!957 = !DILocation(line: 990, column: 13, scope: !914)
!958 = distinct !DISubprogram(name: "MPU_uxTaskGetStackHighWaterMark2Impl", scope: !36, file: !36, line: 1000, type: !959, scopeLine: 1001, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!959 = !DISubroutineType(types: !960)
!960 = !{!366, !32}
!961 = !DILocalVariable(name: "xTask", arg: 1, scope: !958, file: !36, line: 1000, type: !32)
!962 = !DILocation(line: 1000, column: 83, scope: !958)
!963 = !DILocalVariable(name: "uxReturn", scope: !958, file: !36, line: 1002, type: !366)
!964 = !DILocation(line: 1002, column: 36, scope: !958)
!965 = !DILocalVariable(name: "lIndex", scope: !958, file: !36, line: 1003, type: !27)
!966 = !DILocation(line: 1003, column: 21, scope: !958)
!967 = !DILocalVariable(name: "xInternalTaskHandle", scope: !958, file: !36, line: 1004, type: !32)
!968 = !DILocation(line: 1004, column: 26, scope: !958)
!969 = !DILocation(line: 1006, column: 17, scope: !970)
!970 = distinct !DILexicalBlock(scope: !958, file: !36, line: 1006, column: 17)
!971 = !DILocation(line: 1006, column: 23, scope: !970)
!972 = !DILocation(line: 1006, column: 17, scope: !958)
!973 = !DILocation(line: 1008, column: 58, scope: !974)
!974 = distinct !DILexicalBlock(scope: !970, file: !36, line: 1007, column: 13)
!975 = !DILocation(line: 1008, column: 28, scope: !974)
!976 = !DILocation(line: 1008, column: 26, scope: !974)
!977 = !DILocation(line: 1009, column: 13, scope: !974)
!978 = !DILocation(line: 1012, column: 38, scope: !979)
!979 = distinct !DILexicalBlock(scope: !970, file: !36, line: 1011, column: 13)
!980 = !DILocation(line: 1012, column: 26, scope: !979)
!981 = !DILocation(line: 1012, column: 24, scope: !979)
!982 = !DILocation(line: 1014, column: 21, scope: !983)
!983 = distinct !DILexicalBlock(scope: !979, file: !36, line: 1014, column: 21)
!984 = !DILocation(line: 0, scope: !983)
!985 = !DILocation(line: 1014, column: 55, scope: !983)
!986 = !DILocation(line: 1014, column: 21, scope: !979)
!987 = !DILocation(line: 1016, column: 43, scope: !988)
!988 = distinct !DILexicalBlock(scope: !983, file: !36, line: 1015, column: 17)
!989 = !DILocation(line: 1016, column: 41, scope: !988)
!990 = !DILocation(line: 1018, column: 25, scope: !991)
!991 = distinct !DILexicalBlock(scope: !988, file: !36, line: 1018, column: 25)
!992 = !DILocation(line: 1018, column: 45, scope: !991)
!993 = !DILocation(line: 1018, column: 25, scope: !988)
!994 = !DILocation(line: 1020, column: 66, scope: !995)
!995 = distinct !DILexicalBlock(scope: !991, file: !36, line: 1019, column: 21)
!996 = !DILocation(line: 1020, column: 36, scope: !995)
!997 = !DILocation(line: 1020, column: 34, scope: !995)
!998 = !DILocation(line: 1021, column: 21, scope: !995)
!999 = !DILocation(line: 1022, column: 17, scope: !988)
!1000 = !DILocation(line: 1025, column: 20, scope: !958)
!1001 = !DILocation(line: 1025, column: 13, scope: !958)
!1002 = distinct !DISubprogram(name: "MPU_xTaskGetCurrentTaskHandleImpl", scope: !36, file: !36, line: 1035, type: !429, scopeLine: 1036, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1003 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1002, file: !36, line: 1037, type: !32)
!1004 = !DILocation(line: 1037, column: 26, scope: !1002)
!1005 = !DILocalVariable(name: "xExternalTaskHandle", scope: !1002, file: !36, line: 1038, type: !32)
!1006 = !DILocation(line: 1038, column: 26, scope: !1002)
!1007 = !DILocalVariable(name: "lIndex", scope: !1002, file: !36, line: 1039, type: !27)
!1008 = !DILocation(line: 1039, column: 21, scope: !1002)
!1009 = !DILocation(line: 1041, column: 35, scope: !1002)
!1010 = !DILocation(line: 1041, column: 33, scope: !1002)
!1011 = !DILocation(line: 1043, column: 17, scope: !1012)
!1012 = distinct !DILexicalBlock(scope: !1002, file: !36, line: 1043, column: 17)
!1013 = !DILocation(line: 1043, column: 37, scope: !1012)
!1014 = !DILocation(line: 1043, column: 17, scope: !1002)
!1015 = !DILocation(line: 1045, column: 26, scope: !1016)
!1016 = distinct !DILexicalBlock(scope: !1012, file: !36, line: 1044, column: 13)
!1017 = !DILocation(line: 1045, column: 24, scope: !1016)
!1018 = !DILocation(line: 1047, column: 21, scope: !1019)
!1019 = distinct !DILexicalBlock(scope: !1016, file: !36, line: 1047, column: 21)
!1020 = !DILocation(line: 1047, column: 28, scope: !1019)
!1021 = !DILocation(line: 1047, column: 21, scope: !1016)
!1022 = !DILocation(line: 1049, column: 60, scope: !1023)
!1023 = distinct !DILexicalBlock(scope: !1019, file: !36, line: 1048, column: 17)
!1024 = !DILocation(line: 1049, column: 43, scope: !1023)
!1025 = !DILocation(line: 1049, column: 41, scope: !1023)
!1026 = !DILocation(line: 1050, column: 17, scope: !1023)
!1027 = !DILocation(line: 1051, column: 13, scope: !1016)
!1028 = !DILocation(line: 1053, column: 20, scope: !1002)
!1029 = !DILocation(line: 1053, column: 13, scope: !1002)
!1030 = distinct !DISubprogram(name: "MPU_GetIndexForHandle", scope: !36, file: !36, line: 281, type: !1031, scopeLine: 283, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1031 = !DISubroutineType(types: !1032)
!1032 = !{!27, !35, !47}
!1033 = !DILocalVariable(name: "xHandle", arg: 1, scope: !1030, file: !36, line: 281, type: !35)
!1034 = !DILocation(line: 281, column: 64, scope: !1030)
!1035 = !DILocalVariable(name: "ulKernelObjectType", arg: 2, scope: !1030, file: !36, line: 282, type: !47)
!1036 = !DILocation(line: 282, column: 52, scope: !1030)
!1037 = !DILocalVariable(name: "i", scope: !1030, file: !36, line: 284, type: !27)
!1038 = !DILocation(line: 284, column: 17, scope: !1030)
!1039 = !DILocalVariable(name: "lIndex", scope: !1030, file: !36, line: 284, type: !27)
!1040 = !DILocation(line: 284, column: 20, scope: !1030)
!1041 = !DILocation(line: 286, column: 9, scope: !1042)
!1042 = distinct !DILexicalBlock(scope: !1030, file: !36, line: 286, column: 9)
!1043 = !DILocation(line: 286, column: 9, scope: !1030)
!1044 = !DILocation(line: 288, column: 16, scope: !1045)
!1045 = distinct !DILexicalBlock(scope: !1030, file: !36, line: 288, column: 9)
!1046 = !DILocation(line: 288, column: 14, scope: !1045)
!1047 = !DILocation(line: 288, column: 21, scope: !1048)
!1048 = distinct !DILexicalBlock(scope: !1045, file: !36, line: 288, column: 9)
!1049 = !DILocation(line: 288, column: 23, scope: !1048)
!1050 = !DILocation(line: 288, column: 9, scope: !1045)
!1051 = !DILocation(line: 290, column: 38, scope: !1052)
!1052 = distinct !DILexicalBlock(scope: !1053, file: !36, line: 290, column: 17)
!1053 = distinct !DILexicalBlock(scope: !1048, file: !36, line: 289, column: 9)
!1054 = !DILocation(line: 290, column: 19, scope: !1052)
!1055 = !DILocation(line: 290, column: 42, scope: !1052)
!1056 = !DILocation(line: 290, column: 67, scope: !1052)
!1057 = !DILocation(line: 290, column: 64, scope: !1052)
!1058 = !DILocation(line: 290, column: 77, scope: !1052)
!1059 = !DILocation(line: 291, column: 38, scope: !1052)
!1060 = !DILocation(line: 291, column: 19, scope: !1052)
!1061 = !DILocation(line: 291, column: 42, scope: !1052)
!1062 = !DILocation(line: 291, column: 64, scope: !1052)
!1063 = !DILocation(line: 291, column: 61, scope: !1052)
!1064 = !DILocation(line: 290, column: 17, scope: !1053)
!1065 = !DILocation(line: 293, column: 26, scope: !1066)
!1066 = distinct !DILexicalBlock(scope: !1052, file: !36, line: 292, column: 13)
!1067 = !DILocation(line: 293, column: 24, scope: !1066)
!1068 = !DILocation(line: 294, column: 17, scope: !1066)
!1069 = !DILocation(line: 296, column: 9, scope: !1053)
!1070 = !DILocation(line: 288, column: 67, scope: !1048)
!1071 = !DILocation(line: 288, column: 9, scope: !1048)
!1072 = distinct !{!1072, !1050, !1073}
!1073 = !DILocation(line: 296, column: 9, scope: !1045)
!1074 = !DILocation(line: 298, column: 16, scope: !1030)
!1075 = !DILocation(line: 298, column: 9, scope: !1030)
!1076 = distinct !DISubprogram(name: "MPU_xTaskGetSchedulerStateImpl", scope: !36, file: !36, line: 1063, type: !1077, scopeLine: 1064, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1077 = !DISubroutineType(types: !1078)
!1078 = !{!23}
!1079 = !DILocalVariable(name: "xReturn", scope: !1076, file: !36, line: 1065, type: !23)
!1080 = !DILocation(line: 1065, column: 24, scope: !1076)
!1081 = !DILocation(line: 1067, column: 23, scope: !1076)
!1082 = !DILocation(line: 1067, column: 21, scope: !1076)
!1083 = !DILocation(line: 1069, column: 20, scope: !1076)
!1084 = !DILocation(line: 1069, column: 13, scope: !1076)
!1085 = distinct !DISubprogram(name: "MPU_vTaskSetTimeOutStateImpl", scope: !36, file: !36, line: 1077, type: !1086, scopeLine: 1078, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1086 = !DISubroutineType(types: !1087)
!1087 = !{null, !1088}
!1088 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1089)
!1089 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1090, size: 64)
!1090 = !DIDerivedType(tag: DW_TAG_typedef, name: "TimeOut_t", file: !6, line: 128, baseType: !1091)
!1091 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xTIME_OUT", file: !6, line: 124, size: 128, elements: !1092)
!1092 = !{!1093, !1094}
!1093 = !DIDerivedType(tag: DW_TAG_member, name: "xOverflowCount", scope: !1091, file: !6, line: 126, baseType: !23, size: 64)
!1094 = !DIDerivedType(tag: DW_TAG_member, name: "xTimeOnEntering", scope: !1091, file: !6, line: 127, baseType: !119, size: 64, offset: 64)
!1095 = !DILocalVariable(name: "pxTimeOut", arg: 1, scope: !1085, file: !36, line: 1077, type: !1088)
!1096 = !DILocation(line: 1077, column: 58, scope: !1085)
!1097 = !DILocalVariable(name: "xIsTimeOutWriteable", scope: !1085, file: !36, line: 1079, type: !23)
!1098 = !DILocation(line: 1079, column: 20, scope: !1085)
!1099 = !DILocation(line: 1081, column: 64, scope: !1085)
!1100 = !DILocation(line: 1081, column: 31, scope: !1085)
!1101 = !DILocation(line: 1081, column: 29, scope: !1085)
!1102 = !DILocation(line: 1085, column: 13, scope: !1103)
!1103 = distinct !DILexicalBlock(scope: !1085, file: !36, line: 1085, column: 13)
!1104 = !DILocation(line: 1085, column: 33, scope: !1103)
!1105 = !DILocation(line: 1085, column: 13, scope: !1085)
!1106 = !DILocation(line: 1087, column: 35, scope: !1107)
!1107 = distinct !DILexicalBlock(scope: !1103, file: !36, line: 1086, column: 9)
!1108 = !DILocation(line: 1087, column: 13, scope: !1107)
!1109 = !DILocation(line: 1088, column: 9, scope: !1107)
!1110 = !DILocation(line: 1089, column: 5, scope: !1085)
!1111 = distinct !DISubprogram(name: "MPU_xTaskCheckForTimeOutImpl", scope: !36, file: !36, line: 1095, type: !1112, scopeLine: 1097, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1112 = !DISubroutineType(types: !1113)
!1113 = !{!23, !1088, !162}
!1114 = !DILocalVariable(name: "pxTimeOut", arg: 1, scope: !1111, file: !36, line: 1095, type: !1088)
!1115 = !DILocation(line: 1095, column: 64, scope: !1111)
!1116 = !DILocalVariable(name: "pxTicksToWait", arg: 2, scope: !1111, file: !36, line: 1096, type: !162)
!1117 = !DILocation(line: 1096, column: 65, scope: !1111)
!1118 = !DILocalVariable(name: "xReturn", scope: !1111, file: !36, line: 1098, type: !23)
!1119 = !DILocation(line: 1098, column: 20, scope: !1111)
!1120 = !DILocalVariable(name: "xIsTimeOutWriteable", scope: !1111, file: !36, line: 1099, type: !23)
!1121 = !DILocation(line: 1099, column: 20, scope: !1111)
!1122 = !DILocalVariable(name: "xIsTicksToWaitWriteable", scope: !1111, file: !36, line: 1100, type: !23)
!1123 = !DILocation(line: 1100, column: 20, scope: !1111)
!1124 = !DILocation(line: 1102, column: 64, scope: !1111)
!1125 = !DILocation(line: 1102, column: 31, scope: !1111)
!1126 = !DILocation(line: 1102, column: 29, scope: !1111)
!1127 = !DILocation(line: 1105, column: 68, scope: !1111)
!1128 = !DILocation(line: 1105, column: 35, scope: !1111)
!1129 = !DILocation(line: 1105, column: 33, scope: !1111)
!1130 = !DILocation(line: 1109, column: 15, scope: !1131)
!1131 = distinct !DILexicalBlock(scope: !1111, file: !36, line: 1109, column: 13)
!1132 = !DILocation(line: 1109, column: 35, scope: !1131)
!1133 = !DILocation(line: 1109, column: 47, scope: !1131)
!1134 = !DILocation(line: 1109, column: 52, scope: !1131)
!1135 = !DILocation(line: 1109, column: 76, scope: !1131)
!1136 = !DILocation(line: 1109, column: 13, scope: !1111)
!1137 = !DILocation(line: 1111, column: 45, scope: !1138)
!1138 = distinct !DILexicalBlock(scope: !1131, file: !36, line: 1110, column: 9)
!1139 = !DILocation(line: 1111, column: 56, scope: !1138)
!1140 = !DILocation(line: 1111, column: 23, scope: !1138)
!1141 = !DILocation(line: 1111, column: 21, scope: !1138)
!1142 = !DILocation(line: 1112, column: 9, scope: !1138)
!1143 = !DILocation(line: 1114, column: 16, scope: !1111)
!1144 = !DILocation(line: 1114, column: 9, scope: !1111)
!1145 = distinct !DISubprogram(name: "MPU_xTaskGenericNotifyImpl", scope: !36, file: !36, line: 1126, type: !1146, scopeLine: 1131, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1146 = !DISubroutineType(types: !1147)
!1147 = !{!23, !32, !39, !47, !1148, !867}
!1148 = !DIDerivedType(tag: DW_TAG_typedef, name: "eNotifyAction", file: !6, line: 119, baseType: !15)
!1149 = !DILocalVariable(name: "xTaskToNotify", arg: 1, scope: !1145, file: !36, line: 1126, type: !32)
!1150 = !DILocation(line: 1126, column: 61, scope: !1145)
!1151 = !DILocalVariable(name: "uxIndexToNotify", arg: 2, scope: !1145, file: !36, line: 1127, type: !39)
!1152 = !DILocation(line: 1127, column: 60, scope: !1145)
!1153 = !DILocalVariable(name: "ulValue", arg: 3, scope: !1145, file: !36, line: 1128, type: !47)
!1154 = !DILocation(line: 1128, column: 57, scope: !1145)
!1155 = !DILocalVariable(name: "eAction", arg: 4, scope: !1145, file: !36, line: 1129, type: !1148)
!1156 = !DILocation(line: 1129, column: 62, scope: !1145)
!1157 = !DILocalVariable(name: "pulPreviousNotificationValue", arg: 5, scope: !1145, file: !36, line: 1130, type: !867)
!1158 = !DILocation(line: 1130, column: 59, scope: !1145)
!1159 = !DILocalVariable(name: "xReturn", scope: !1145, file: !36, line: 1132, type: !23)
!1160 = !DILocation(line: 1132, column: 24, scope: !1145)
!1161 = !DILocalVariable(name: "lIndex", scope: !1145, file: !36, line: 1133, type: !27)
!1162 = !DILocation(line: 1133, column: 21, scope: !1145)
!1163 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1145, file: !36, line: 1134, type: !32)
!1164 = !DILocation(line: 1134, column: 26, scope: !1145)
!1165 = !DILocalVariable(name: "xIsPreviousNotificationValueWriteable", scope: !1145, file: !36, line: 1135, type: !23)
!1166 = !DILocation(line: 1135, column: 24, scope: !1145)
!1167 = !DILocation(line: 1137, column: 17, scope: !1168)
!1168 = distinct !DILexicalBlock(scope: !1145, file: !36, line: 1137, column: 17)
!1169 = !DILocation(line: 1137, column: 46, scope: !1168)
!1170 = !DILocation(line: 1137, column: 17, scope: !1145)
!1171 = !DILocation(line: 1139, column: 90, scope: !1172)
!1172 = distinct !DILexicalBlock(scope: !1168, file: !36, line: 1138, column: 13)
!1173 = !DILocation(line: 1139, column: 57, scope: !1172)
!1174 = !DILocation(line: 1139, column: 55, scope: !1172)
!1175 = !DILocation(line: 1142, column: 13, scope: !1172)
!1176 = !DILocation(line: 1144, column: 19, scope: !1177)
!1177 = distinct !DILexicalBlock(scope: !1145, file: !36, line: 1144, column: 17)
!1178 = !DILocation(line: 1144, column: 48, scope: !1177)
!1179 = !DILocation(line: 1144, column: 58, scope: !1177)
!1180 = !DILocation(line: 1144, column: 63, scope: !1177)
!1181 = !DILocation(line: 1144, column: 101, scope: !1177)
!1182 = !DILocation(line: 1144, column: 17, scope: !1145)
!1183 = !DILocation(line: 1146, column: 38, scope: !1184)
!1184 = distinct !DILexicalBlock(scope: !1177, file: !36, line: 1145, column: 13)
!1185 = !DILocation(line: 1146, column: 26, scope: !1184)
!1186 = !DILocation(line: 1146, column: 24, scope: !1184)
!1187 = !DILocation(line: 1148, column: 21, scope: !1188)
!1188 = distinct !DILexicalBlock(scope: !1184, file: !36, line: 1148, column: 21)
!1189 = !DILocation(line: 0, scope: !1188)
!1190 = !DILocation(line: 1148, column: 55, scope: !1188)
!1191 = !DILocation(line: 1148, column: 21, scope: !1184)
!1192 = !DILocation(line: 1150, column: 43, scope: !1193)
!1193 = distinct !DILexicalBlock(scope: !1188, file: !36, line: 1149, column: 17)
!1194 = !DILocation(line: 1150, column: 41, scope: !1193)
!1195 = !DILocation(line: 1152, column: 25, scope: !1196)
!1196 = distinct !DILexicalBlock(scope: !1193, file: !36, line: 1152, column: 25)
!1197 = !DILocation(line: 1152, column: 45, scope: !1196)
!1198 = !DILocation(line: 1152, column: 25, scope: !1193)
!1199 = !DILocation(line: 1154, column: 55, scope: !1200)
!1200 = distinct !DILexicalBlock(scope: !1196, file: !36, line: 1153, column: 21)
!1201 = !DILocation(line: 1154, column: 76, scope: !1200)
!1202 = !DILocation(line: 1154, column: 93, scope: !1200)
!1203 = !DILocation(line: 1154, column: 102, scope: !1200)
!1204 = !DILocation(line: 1154, column: 111, scope: !1200)
!1205 = !DILocation(line: 1154, column: 35, scope: !1200)
!1206 = !DILocation(line: 1154, column: 33, scope: !1200)
!1207 = !DILocation(line: 1155, column: 21, scope: !1200)
!1208 = !DILocation(line: 1156, column: 17, scope: !1193)
!1209 = !DILocation(line: 1157, column: 13, scope: !1184)
!1210 = !DILocation(line: 1159, column: 20, scope: !1145)
!1211 = !DILocation(line: 1159, column: 13, scope: !1145)
!1212 = distinct !DISubprogram(name: "MPU_xTaskGenericNotifyWaitImpl", scope: !36, file: !36, line: 1173, type: !1213, scopeLine: 1178, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1213 = !DISubroutineType(types: !1214)
!1214 = !{!23, !39, !47, !47, !867, !119}
!1215 = !DILocalVariable(name: "uxIndexToWaitOn", arg: 1, scope: !1212, file: !36, line: 1173, type: !39)
!1216 = !DILocation(line: 1173, column: 64, scope: !1212)
!1217 = !DILocalVariable(name: "ulBitsToClearOnEntry", arg: 2, scope: !1212, file: !36, line: 1174, type: !47)
!1218 = !DILocation(line: 1174, column: 61, scope: !1212)
!1219 = !DILocalVariable(name: "ulBitsToClearOnExit", arg: 3, scope: !1212, file: !36, line: 1175, type: !47)
!1220 = !DILocation(line: 1175, column: 61, scope: !1212)
!1221 = !DILocalVariable(name: "pulNotificationValue", arg: 4, scope: !1212, file: !36, line: 1176, type: !867)
!1222 = !DILocation(line: 1176, column: 63, scope: !1212)
!1223 = !DILocalVariable(name: "xTicksToWait", arg: 5, scope: !1212, file: !36, line: 1177, type: !119)
!1224 = !DILocation(line: 1177, column: 63, scope: !1212)
!1225 = !DILocalVariable(name: "xReturn", scope: !1212, file: !36, line: 1179, type: !23)
!1226 = !DILocation(line: 1179, column: 24, scope: !1212)
!1227 = !DILocalVariable(name: "xIsNotificationValueWritable", scope: !1212, file: !36, line: 1180, type: !23)
!1228 = !DILocation(line: 1180, column: 24, scope: !1212)
!1229 = !DILocation(line: 1182, column: 17, scope: !1230)
!1230 = distinct !DILexicalBlock(scope: !1212, file: !36, line: 1182, column: 17)
!1231 = !DILocation(line: 1182, column: 38, scope: !1230)
!1232 = !DILocation(line: 1182, column: 17, scope: !1212)
!1233 = !DILocation(line: 1184, column: 81, scope: !1234)
!1234 = distinct !DILexicalBlock(scope: !1230, file: !36, line: 1183, column: 13)
!1235 = !DILocation(line: 1184, column: 48, scope: !1234)
!1236 = !DILocation(line: 1184, column: 46, scope: !1234)
!1237 = !DILocation(line: 1187, column: 13, scope: !1234)
!1238 = !DILocation(line: 1189, column: 19, scope: !1239)
!1239 = distinct !DILexicalBlock(scope: !1212, file: !36, line: 1189, column: 17)
!1240 = !DILocation(line: 1189, column: 40, scope: !1239)
!1241 = !DILocation(line: 1189, column: 50, scope: !1239)
!1242 = !DILocation(line: 1189, column: 55, scope: !1239)
!1243 = !DILocation(line: 1189, column: 84, scope: !1239)
!1244 = !DILocation(line: 1189, column: 17, scope: !1212)
!1245 = !DILocation(line: 1191, column: 51, scope: !1246)
!1246 = distinct !DILexicalBlock(scope: !1239, file: !36, line: 1190, column: 13)
!1247 = !DILocation(line: 1191, column: 68, scope: !1246)
!1248 = !DILocation(line: 1191, column: 90, scope: !1246)
!1249 = !DILocation(line: 1191, column: 111, scope: !1246)
!1250 = !DILocation(line: 1191, column: 133, scope: !1246)
!1251 = !DILocation(line: 1191, column: 27, scope: !1246)
!1252 = !DILocation(line: 1191, column: 25, scope: !1246)
!1253 = !DILocation(line: 1192, column: 13, scope: !1246)
!1254 = !DILocation(line: 1194, column: 20, scope: !1212)
!1255 = !DILocation(line: 1194, column: 13, scope: !1212)
!1256 = distinct !DISubprogram(name: "MPU_ulTaskGenericNotifyTakeImpl", scope: !36, file: !36, line: 1206, type: !1257, scopeLine: 1209, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1257 = !DISubroutineType(types: !1258)
!1258 = !{!47, !39, !23, !119}
!1259 = !DILocalVariable(name: "uxIndexToWaitOn", arg: 1, scope: !1256, file: !36, line: 1206, type: !39)
!1260 = !DILocation(line: 1206, column: 63, scope: !1256)
!1261 = !DILocalVariable(name: "xClearCountOnExit", arg: 2, scope: !1256, file: !36, line: 1207, type: !23)
!1262 = !DILocation(line: 1207, column: 62, scope: !1256)
!1263 = !DILocalVariable(name: "xTicksToWait", arg: 3, scope: !1256, file: !36, line: 1208, type: !119)
!1264 = !DILocation(line: 1208, column: 62, scope: !1256)
!1265 = !DILocalVariable(name: "ulReturn", scope: !1256, file: !36, line: 1210, type: !47)
!1266 = !DILocation(line: 1210, column: 22, scope: !1256)
!1267 = !DILocation(line: 1212, column: 49, scope: !1256)
!1268 = !DILocation(line: 1212, column: 66, scope: !1256)
!1269 = !DILocation(line: 1212, column: 85, scope: !1256)
!1270 = !DILocation(line: 1212, column: 24, scope: !1256)
!1271 = !DILocation(line: 1212, column: 22, scope: !1256)
!1272 = !DILocation(line: 1214, column: 20, scope: !1256)
!1273 = !DILocation(line: 1214, column: 13, scope: !1256)
!1274 = distinct !DISubprogram(name: "MPU_xTaskGenericNotifyStateClearImpl", scope: !36, file: !36, line: 1225, type: !1275, scopeLine: 1227, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1275 = !DISubroutineType(types: !1276)
!1276 = !{!23, !32, !39}
!1277 = !DILocalVariable(name: "xTask", arg: 1, scope: !1274, file: !36, line: 1225, type: !32)
!1278 = !DILocation(line: 1225, column: 71, scope: !1274)
!1279 = !DILocalVariable(name: "uxIndexToClear", arg: 2, scope: !1274, file: !36, line: 1226, type: !39)
!1280 = !DILocation(line: 1226, column: 70, scope: !1274)
!1281 = !DILocalVariable(name: "xReturn", scope: !1274, file: !36, line: 1228, type: !23)
!1282 = !DILocation(line: 1228, column: 24, scope: !1274)
!1283 = !DILocalVariable(name: "lIndex", scope: !1274, file: !36, line: 1229, type: !27)
!1284 = !DILocation(line: 1229, column: 21, scope: !1274)
!1285 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1274, file: !36, line: 1230, type: !32)
!1286 = !DILocation(line: 1230, column: 26, scope: !1274)
!1287 = !DILocation(line: 1232, column: 17, scope: !1288)
!1288 = distinct !DILexicalBlock(scope: !1274, file: !36, line: 1232, column: 17)
!1289 = !DILocation(line: 1232, column: 23, scope: !1288)
!1290 = !DILocation(line: 1232, column: 17, scope: !1274)
!1291 = !DILocation(line: 1234, column: 57, scope: !1292)
!1292 = distinct !DILexicalBlock(scope: !1288, file: !36, line: 1233, column: 13)
!1293 = !DILocation(line: 1234, column: 64, scope: !1292)
!1294 = !DILocation(line: 1234, column: 27, scope: !1292)
!1295 = !DILocation(line: 1234, column: 25, scope: !1292)
!1296 = !DILocation(line: 1235, column: 13, scope: !1292)
!1297 = !DILocation(line: 1238, column: 38, scope: !1298)
!1298 = distinct !DILexicalBlock(scope: !1288, file: !36, line: 1237, column: 13)
!1299 = !DILocation(line: 1238, column: 26, scope: !1298)
!1300 = !DILocation(line: 1238, column: 24, scope: !1298)
!1301 = !DILocation(line: 1240, column: 21, scope: !1302)
!1302 = distinct !DILexicalBlock(scope: !1298, file: !36, line: 1240, column: 21)
!1303 = !DILocation(line: 0, scope: !1302)
!1304 = !DILocation(line: 1240, column: 55, scope: !1302)
!1305 = !DILocation(line: 1240, column: 21, scope: !1298)
!1306 = !DILocation(line: 1242, column: 43, scope: !1307)
!1307 = distinct !DILexicalBlock(scope: !1302, file: !36, line: 1241, column: 17)
!1308 = !DILocation(line: 1242, column: 41, scope: !1307)
!1309 = !DILocation(line: 1244, column: 25, scope: !1310)
!1310 = distinct !DILexicalBlock(scope: !1307, file: !36, line: 1244, column: 25)
!1311 = !DILocation(line: 1244, column: 45, scope: !1310)
!1312 = !DILocation(line: 1244, column: 25, scope: !1307)
!1313 = !DILocation(line: 1246, column: 65, scope: !1314)
!1314 = distinct !DILexicalBlock(scope: !1310, file: !36, line: 1245, column: 21)
!1315 = !DILocation(line: 1246, column: 86, scope: !1314)
!1316 = !DILocation(line: 1246, column: 35, scope: !1314)
!1317 = !DILocation(line: 1246, column: 33, scope: !1314)
!1318 = !DILocation(line: 1247, column: 21, scope: !1314)
!1319 = !DILocation(line: 1248, column: 17, scope: !1307)
!1320 = !DILocation(line: 1251, column: 20, scope: !1274)
!1321 = !DILocation(line: 1251, column: 13, scope: !1274)
!1322 = distinct !DISubprogram(name: "MPU_ulTaskGenericNotifyValueClearImpl", scope: !36, file: !36, line: 1263, type: !1323, scopeLine: 1266, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1323 = !DISubroutineType(types: !1324)
!1324 = !{!47, !32, !39, !47}
!1325 = !DILocalVariable(name: "xTask", arg: 1, scope: !1322, file: !36, line: 1263, type: !32)
!1326 = !DILocation(line: 1263, column: 70, scope: !1322)
!1327 = !DILocalVariable(name: "uxIndexToClear", arg: 2, scope: !1322, file: !36, line: 1264, type: !39)
!1328 = !DILocation(line: 1264, column: 69, scope: !1322)
!1329 = !DILocalVariable(name: "ulBitsToClear", arg: 3, scope: !1322, file: !36, line: 1265, type: !47)
!1330 = !DILocation(line: 1265, column: 66, scope: !1322)
!1331 = !DILocalVariable(name: "ulReturn", scope: !1322, file: !36, line: 1267, type: !47)
!1332 = !DILocation(line: 1267, column: 22, scope: !1322)
!1333 = !DILocalVariable(name: "lIndex", scope: !1322, file: !36, line: 1268, type: !27)
!1334 = !DILocation(line: 1268, column: 21, scope: !1322)
!1335 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1322, file: !36, line: 1269, type: !32)
!1336 = !DILocation(line: 1269, column: 26, scope: !1322)
!1337 = !DILocation(line: 1271, column: 17, scope: !1338)
!1338 = distinct !DILexicalBlock(scope: !1322, file: !36, line: 1271, column: 17)
!1339 = !DILocation(line: 1271, column: 23, scope: !1338)
!1340 = !DILocation(line: 1271, column: 17, scope: !1322)
!1341 = !DILocation(line: 1273, column: 59, scope: !1342)
!1342 = distinct !DILexicalBlock(scope: !1338, file: !36, line: 1272, column: 13)
!1343 = !DILocation(line: 1273, column: 66, scope: !1342)
!1344 = !DILocation(line: 1273, column: 82, scope: !1342)
!1345 = !DILocation(line: 1273, column: 28, scope: !1342)
!1346 = !DILocation(line: 1273, column: 26, scope: !1342)
!1347 = !DILocation(line: 1274, column: 13, scope: !1342)
!1348 = !DILocation(line: 1277, column: 38, scope: !1349)
!1349 = distinct !DILexicalBlock(scope: !1338, file: !36, line: 1276, column: 13)
!1350 = !DILocation(line: 1277, column: 26, scope: !1349)
!1351 = !DILocation(line: 1277, column: 24, scope: !1349)
!1352 = !DILocation(line: 1279, column: 21, scope: !1353)
!1353 = distinct !DILexicalBlock(scope: !1349, file: !36, line: 1279, column: 21)
!1354 = !DILocation(line: 0, scope: !1353)
!1355 = !DILocation(line: 1279, column: 55, scope: !1353)
!1356 = !DILocation(line: 1279, column: 21, scope: !1349)
!1357 = !DILocation(line: 1281, column: 43, scope: !1358)
!1358 = distinct !DILexicalBlock(scope: !1353, file: !36, line: 1280, column: 17)
!1359 = !DILocation(line: 1281, column: 41, scope: !1358)
!1360 = !DILocation(line: 1283, column: 25, scope: !1361)
!1361 = distinct !DILexicalBlock(scope: !1358, file: !36, line: 1283, column: 25)
!1362 = !DILocation(line: 1283, column: 45, scope: !1361)
!1363 = !DILocation(line: 1283, column: 25, scope: !1358)
!1364 = !DILocation(line: 1285, column: 67, scope: !1365)
!1365 = distinct !DILexicalBlock(scope: !1361, file: !36, line: 1284, column: 21)
!1366 = !DILocation(line: 1285, column: 88, scope: !1365)
!1367 = !DILocation(line: 1285, column: 104, scope: !1365)
!1368 = !DILocation(line: 1285, column: 36, scope: !1365)
!1369 = !DILocation(line: 1285, column: 34, scope: !1365)
!1370 = !DILocation(line: 1286, column: 21, scope: !1365)
!1371 = !DILocation(line: 1287, column: 17, scope: !1358)
!1372 = !DILocation(line: 1290, column: 20, scope: !1322)
!1373 = !DILocation(line: 1290, column: 13, scope: !1322)
!1374 = distinct !DISubprogram(name: "MPU_xTaskCreate", scope: !36, file: !36, line: 1303, type: !1375, scopeLine: 1309, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1375 = !DISubroutineType(types: !1376)
!1376 = !{!23, !97, !1377, !366, !26, !39, !1378}
!1377 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !356)
!1378 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !32, size: 64)
!1379 = !DILocalVariable(name: "pvTaskCode", arg: 1, scope: !1374, file: !36, line: 1303, type: !97)
!1380 = !DILocation(line: 1303, column: 52, scope: !1374)
!1381 = !DILocalVariable(name: "pcName", arg: 2, scope: !1374, file: !36, line: 1304, type: !1377)
!1382 = !DILocation(line: 1304, column: 56, scope: !1374)
!1383 = !DILocalVariable(name: "usStackDepth", arg: 3, scope: !1374, file: !36, line: 1305, type: !366)
!1384 = !DILocation(line: 1305, column: 46, scope: !1374)
!1385 = !DILocalVariable(name: "pvParameters", arg: 4, scope: !1374, file: !36, line: 1306, type: !26)
!1386 = !DILocation(line: 1306, column: 44, scope: !1374)
!1387 = !DILocalVariable(name: "uxPriority", arg: 5, scope: !1374, file: !36, line: 1307, type: !39)
!1388 = !DILocation(line: 1307, column: 49, scope: !1374)
!1389 = !DILocalVariable(name: "pxCreatedTask", arg: 6, scope: !1374, file: !36, line: 1308, type: !1378)
!1390 = !DILocation(line: 1308, column: 52, scope: !1374)
!1391 = !DILocalVariable(name: "xReturn", scope: !1374, file: !36, line: 1310, type: !23)
!1392 = !DILocation(line: 1310, column: 24, scope: !1374)
!1393 = !DILocalVariable(name: "lIndex", scope: !1374, file: !36, line: 1311, type: !27)
!1394 = !DILocation(line: 1311, column: 21, scope: !1374)
!1395 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1374, file: !36, line: 1312, type: !32)
!1396 = !DILocation(line: 1312, column: 26, scope: !1374)
!1397 = !DILocation(line: 1314, column: 22, scope: !1374)
!1398 = !DILocation(line: 1314, column: 20, scope: !1374)
!1399 = !DILocation(line: 1316, column: 17, scope: !1400)
!1400 = distinct !DILexicalBlock(scope: !1374, file: !36, line: 1316, column: 17)
!1401 = !DILocation(line: 1316, column: 24, scope: !1400)
!1402 = !DILocation(line: 1316, column: 17, scope: !1374)
!1403 = !DILocation(line: 1319, column: 23, scope: !1404)
!1404 = distinct !DILexicalBlock(scope: !1405, file: !36, line: 1319, column: 21)
!1405 = distinct !DILexicalBlock(scope: !1400, file: !36, line: 1317, column: 13)
!1406 = !DILocation(line: 1319, column: 34, scope: !1404)
!1407 = !DILocation(line: 1319, column: 56, scope: !1404)
!1408 = !DILocation(line: 1319, column: 21, scope: !1405)
!1409 = !DILocation(line: 1321, column: 44, scope: !1410)
!1410 = distinct !DILexicalBlock(scope: !1404, file: !36, line: 1320, column: 17)
!1411 = !DILocation(line: 1321, column: 56, scope: !1410)
!1412 = !DILocation(line: 1321, column: 64, scope: !1410)
!1413 = !DILocation(line: 1321, column: 78, scope: !1410)
!1414 = !DILocation(line: 1321, column: 92, scope: !1410)
!1415 = !DILocation(line: 1321, column: 31, scope: !1410)
!1416 = !DILocation(line: 1321, column: 29, scope: !1410)
!1417 = !DILocation(line: 1323, column: 27, scope: !1418)
!1418 = distinct !DILexicalBlock(scope: !1410, file: !36, line: 1323, column: 25)
!1419 = !DILocation(line: 1323, column: 35, scope: !1418)
!1420 = !DILocation(line: 1323, column: 47, scope: !1418)
!1421 = !DILocation(line: 1323, column: 52, scope: !1418)
!1422 = !DILocation(line: 1323, column: 72, scope: !1418)
!1423 = !DILocation(line: 1323, column: 25, scope: !1410)
!1424 = !DILocation(line: 1325, column: 25, scope: !1425)
!1425 = distinct !DILexicalBlock(scope: !1418, file: !36, line: 1324, column: 21)
!1426 = !DILocation(line: 1327, column: 29, scope: !1427)
!1427 = distinct !DILexicalBlock(scope: !1425, file: !36, line: 1327, column: 29)
!1428 = !DILocation(line: 1327, column: 43, scope: !1427)
!1429 = !DILocation(line: 1327, column: 29, scope: !1425)
!1430 = !DILocation(line: 1329, column: 63, scope: !1431)
!1431 = distinct !DILexicalBlock(scope: !1427, file: !36, line: 1328, column: 25)
!1432 = !DILocation(line: 1329, column: 46, scope: !1431)
!1433 = !DILocation(line: 1329, column: 30, scope: !1431)
!1434 = !DILocation(line: 1329, column: 44, scope: !1431)
!1435 = !DILocation(line: 1330, column: 25, scope: !1431)
!1436 = !DILocation(line: 1331, column: 21, scope: !1425)
!1437 = !DILocation(line: 1334, column: 61, scope: !1438)
!1438 = distinct !DILexicalBlock(scope: !1418, file: !36, line: 1333, column: 21)
!1439 = !DILocation(line: 1334, column: 25, scope: !1438)
!1440 = !DILocation(line: 1336, column: 17, scope: !1410)
!1441 = !DILocation(line: 1337, column: 13, scope: !1405)
!1442 = !DILocation(line: 1339, column: 20, scope: !1374)
!1443 = !DILocation(line: 1339, column: 13, scope: !1374)
!1444 = distinct !DISubprogram(name: "MPU_GetFreeIndexInKernelObjectPool", scope: !36, file: !36, line: 240, type: !1445, scopeLine: 241, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1445 = !DISubroutineType(types: !1446)
!1446 = !{!27}
!1447 = !DILocalVariable(name: "i", scope: !1444, file: !36, line: 242, type: !27)
!1448 = !DILocation(line: 242, column: 17, scope: !1444)
!1449 = !DILocalVariable(name: "lFreeIndex", scope: !1444, file: !36, line: 242, type: !27)
!1450 = !DILocation(line: 242, column: 20, scope: !1444)
!1451 = !DILocation(line: 248, column: 9, scope: !1444)
!1452 = !DILocation(line: 250, column: 20, scope: !1453)
!1453 = distinct !DILexicalBlock(scope: !1454, file: !36, line: 250, column: 13)
!1454 = distinct !DILexicalBlock(scope: !1444, file: !36, line: 249, column: 9)
!1455 = !DILocation(line: 250, column: 18, scope: !1453)
!1456 = !DILocation(line: 250, column: 25, scope: !1457)
!1457 = distinct !DILexicalBlock(scope: !1453, file: !36, line: 250, column: 13)
!1458 = !DILocation(line: 250, column: 27, scope: !1457)
!1459 = !DILocation(line: 250, column: 13, scope: !1453)
!1460 = !DILocation(line: 252, column: 40, scope: !1461)
!1461 = distinct !DILexicalBlock(scope: !1462, file: !36, line: 252, column: 21)
!1462 = distinct !DILexicalBlock(scope: !1457, file: !36, line: 251, column: 13)
!1463 = !DILocation(line: 252, column: 21, scope: !1461)
!1464 = !DILocation(line: 252, column: 44, scope: !1461)
!1465 = !DILocation(line: 252, column: 66, scope: !1461)
!1466 = !DILocation(line: 252, column: 21, scope: !1462)
!1467 = !DILocation(line: 255, column: 40, scope: !1468)
!1468 = distinct !DILexicalBlock(scope: !1461, file: !36, line: 253, column: 17)
!1469 = !DILocation(line: 255, column: 21, scope: !1468)
!1470 = !DILocation(line: 255, column: 44, scope: !1468)
!1471 = !DILocation(line: 255, column: 66, scope: !1468)
!1472 = !DILocation(line: 256, column: 34, scope: !1468)
!1473 = !DILocation(line: 256, column: 32, scope: !1468)
!1474 = !DILocation(line: 257, column: 21, scope: !1468)
!1475 = !DILocation(line: 259, column: 13, scope: !1462)
!1476 = !DILocation(line: 250, column: 71, scope: !1457)
!1477 = !DILocation(line: 250, column: 13, scope: !1457)
!1478 = distinct !{!1478, !1459, !1479}
!1479 = !DILocation(line: 259, column: 13, scope: !1453)
!1480 = !DILocation(line: 261, column: 9, scope: !1444)
!1481 = !DILocation(line: 263, column: 16, scope: !1444)
!1482 = !DILocation(line: 263, column: 9, scope: !1444)
!1483 = distinct !DISubprogram(name: "MPU_StoreHandleAndDataAtIndex", scope: !36, file: !36, line: 302, type: !1484, scopeLine: 306, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1484 = !DISubroutineType(types: !1485)
!1485 = !{null, !27, !35, !26, !47}
!1486 = !DILocalVariable(name: "lIndex", arg: 1, scope: !1483, file: !36, line: 302, type: !27)
!1487 = !DILocation(line: 302, column: 56, scope: !1483)
!1488 = !DILocalVariable(name: "xHandle", arg: 2, scope: !1483, file: !36, line: 303, type: !35)
!1489 = !DILocation(line: 303, column: 69, scope: !1483)
!1490 = !DILocalVariable(name: "pvKernelObjectData", arg: 3, scope: !1483, file: !36, line: 304, type: !26)
!1491 = !DILocation(line: 304, column: 55, scope: !1483)
!1492 = !DILocalVariable(name: "ulKernelObjectType", arg: 4, scope: !1483, file: !36, line: 305, type: !47)
!1493 = !DILocation(line: 305, column: 57, scope: !1483)
!1494 = !DILocation(line: 307, column: 9, scope: !1495)
!1495 = distinct !DILexicalBlock(scope: !1483, file: !36, line: 307, column: 9)
!1496 = !DILocation(line: 0, scope: !1495)
!1497 = !DILocation(line: 307, column: 9, scope: !1483)
!1498 = !DILocation(line: 308, column: 61, scope: !1483)
!1499 = !DILocation(line: 308, column: 28, scope: !1483)
!1500 = !DILocation(line: 308, column: 9, scope: !1483)
!1501 = !DILocation(line: 308, column: 37, scope: !1483)
!1502 = !DILocation(line: 308, column: 59, scope: !1483)
!1503 = !DILocation(line: 309, column: 58, scope: !1483)
!1504 = !DILocation(line: 309, column: 28, scope: !1483)
!1505 = !DILocation(line: 309, column: 9, scope: !1483)
!1506 = !DILocation(line: 309, column: 37, scope: !1483)
!1507 = !DILocation(line: 309, column: 56, scope: !1483)
!1508 = !DILocation(line: 310, column: 58, scope: !1483)
!1509 = !DILocation(line: 310, column: 28, scope: !1483)
!1510 = !DILocation(line: 310, column: 9, scope: !1483)
!1511 = !DILocation(line: 310, column: 37, scope: !1483)
!1512 = !DILocation(line: 310, column: 56, scope: !1483)
!1513 = !DILocation(line: 311, column: 5, scope: !1483)
!1514 = distinct !DISubprogram(name: "MPU_SetIndexFreeInKernelObjectPool", scope: !36, file: !36, line: 267, type: !1515, scopeLine: 268, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1515 = !DISubroutineType(types: !1516)
!1516 = !{null, !27}
!1517 = !DILocalVariable(name: "lIndex", arg: 1, scope: !1514, file: !36, line: 267, type: !27)
!1518 = !DILocation(line: 267, column: 61, scope: !1514)
!1519 = !DILocation(line: 269, column: 9, scope: !1520)
!1520 = distinct !DILexicalBlock(scope: !1514, file: !36, line: 269, column: 9)
!1521 = !DILocation(line: 0, scope: !1520)
!1522 = !DILocation(line: 269, column: 9, scope: !1514)
!1523 = !DILocation(line: 271, column: 9, scope: !1514)
!1524 = !DILocation(line: 273, column: 32, scope: !1525)
!1525 = distinct !DILexicalBlock(scope: !1514, file: !36, line: 272, column: 9)
!1526 = !DILocation(line: 273, column: 13, scope: !1525)
!1527 = !DILocation(line: 273, column: 41, scope: !1525)
!1528 = !DILocation(line: 273, column: 63, scope: !1525)
!1529 = !DILocation(line: 274, column: 32, scope: !1525)
!1530 = !DILocation(line: 274, column: 13, scope: !1525)
!1531 = !DILocation(line: 274, column: 41, scope: !1525)
!1532 = !DILocation(line: 274, column: 60, scope: !1525)
!1533 = !DILocation(line: 275, column: 32, scope: !1525)
!1534 = !DILocation(line: 275, column: 13, scope: !1525)
!1535 = !DILocation(line: 275, column: 41, scope: !1525)
!1536 = !DILocation(line: 275, column: 60, scope: !1525)
!1537 = !DILocation(line: 277, column: 9, scope: !1514)
!1538 = !DILocation(line: 278, column: 5, scope: !1514)
!1539 = distinct !DISubprogram(name: "MPU_xTaskCreateStatic", scope: !36, file: !36, line: 1347, type: !1540, scopeLine: 1354, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1540 = !DISubroutineType(types: !1541)
!1541 = !{!32, !97, !1377, !1542, !1543, !39, !1544, !1545}
!1542 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !47)
!1543 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !26)
!1544 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !117)
!1545 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1546)
!1546 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1547, size: 64)
!1547 = !DIDerivedType(tag: DW_TAG_typedef, name: "StaticTask_t", file: !1548, line: 1319, baseType: !1549)
!1548 = !DIFile(filename: "include/FreeRTOS.h", directory: "/home/klee/FreeRTOS-Kernel-10.6.0")
!1549 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xSTATIC_TCB", file: !1548, line: 1271, size: 2240, elements: !1550)
!1550 = !{!1551, !1552, !1567, !1579, !1580, !1581, !1586, !1588, !1589, !1593, !1594, !1598, !1600, !1601}
!1551 = !DIDerivedType(tag: DW_TAG_member, name: "pxDummy1", scope: !1549, file: !1548, line: 1273, baseType: !26, size: 64)
!1552 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy2", scope: !1549, file: !1548, line: 1275, baseType: !1553, size: 544, offset: 64)
!1553 = !DIDerivedType(tag: DW_TAG_typedef, name: "xMPU_SETTINGS", file: !1554, line: 23, baseType: !1555)
!1554 = !DIFile(filename: "./klee_help.h", directory: "/home/klee/FreeRTOS-Kernel-10.6.0/symbolic_execution/test_access_control")
!1555 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "MPU_SETTINGS", file: !1554, line: 19, size: 544, elements: !1556)
!1556 = !{!1557, !1558}
!1557 = !DIDerivedType(tag: DW_TAG_member, name: "ulMAIR0", scope: !1555, file: !1554, line: 21, baseType: !47, size: 32)
!1558 = !DIDerivedType(tag: DW_TAG_member, name: "xRegionsSettings", scope: !1555, file: !1554, line: 22, baseType: !1559, size: 512, offset: 32)
!1559 = !DICompositeType(tag: DW_TAG_array_type, baseType: !1560, size: 512, elements: !1565)
!1560 = !DIDerivedType(tag: DW_TAG_typedef, name: "MPURegionSettings_t", file: !1554, line: 17, baseType: !1561)
!1561 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "MPURegionSettings", file: !1554, line: 13, size: 64, elements: !1562)
!1562 = !{!1563, !1564}
!1563 = !DIDerivedType(tag: DW_TAG_member, name: "ulRBAR", scope: !1561, file: !1554, line: 15, baseType: !47, size: 32)
!1564 = !DIDerivedType(tag: DW_TAG_member, name: "ulRLAR", scope: !1561, file: !1554, line: 16, baseType: !47, size: 32, offset: 32)
!1565 = !{!1566}
!1566 = !DISubrange(count: 8)
!1567 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy3", scope: !1549, file: !1548, line: 1277, baseType: !1568, size: 640, offset: 640)
!1568 = !DICompositeType(tag: DW_TAG_array_type, baseType: !1569, size: 640, elements: !1577)
!1569 = !DIDerivedType(tag: DW_TAG_typedef, name: "StaticListItem_t", file: !1548, line: 1227, baseType: !1570)
!1570 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xSTATIC_LIST_ITEM", file: !1548, line: 1216, size: 320, elements: !1571)
!1571 = !{!1572, !1573}
!1572 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy2", scope: !1570, file: !1548, line: 1221, baseType: !119, size: 64)
!1573 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy3", scope: !1570, file: !1548, line: 1222, baseType: !1574, size: 256, offset: 64)
!1574 = !DICompositeType(tag: DW_TAG_array_type, baseType: !26, size: 256, elements: !1575)
!1575 = !{!1576}
!1576 = !DISubrange(count: 4)
!1577 = !{!1578}
!1578 = !DISubrange(count: 2)
!1579 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy5", scope: !1549, file: !1548, line: 1278, baseType: !39, size: 64, offset: 1280)
!1580 = !DIDerivedType(tag: DW_TAG_member, name: "pxDummy6", scope: !1549, file: !1548, line: 1279, baseType: !26, size: 64, offset: 1344)
!1581 = !DIDerivedType(tag: DW_TAG_member, name: "ucDummy7", scope: !1549, file: !1548, line: 1280, baseType: !1582, size: 128, offset: 1408)
!1582 = !DICompositeType(tag: DW_TAG_array_type, baseType: !1583, size: 128, elements: !133)
!1583 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !48, line: 24, baseType: !1584)
!1584 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !30, line: 37, baseType: !1585)
!1585 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!1586 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy10", scope: !1549, file: !1548, line: 1288, baseType: !1587, size: 128, offset: 1536)
!1587 = !DICompositeType(tag: DW_TAG_array_type, baseType: !39, size: 128, elements: !1577)
!1588 = !DIDerivedType(tag: DW_TAG_member, name: "pxDummy14", scope: !1549, file: !1548, line: 1294, baseType: !26, size: 64, offset: 1664)
!1589 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy15", scope: !1549, file: !1548, line: 1297, baseType: !1590, size: 320, offset: 1728)
!1590 = !DICompositeType(tag: DW_TAG_array_type, baseType: !26, size: 320, elements: !1591)
!1591 = !{!1592}
!1592 = !DISubrange(count: 5)
!1593 = !DIDerivedType(tag: DW_TAG_member, name: "ulDummy16", scope: !1549, file: !1548, line: 1300, baseType: !47, size: 32, offset: 2048)
!1594 = !DIDerivedType(tag: DW_TAG_member, name: "ulDummy18", scope: !1549, file: !1548, line: 1306, baseType: !1595, size: 96, offset: 2080)
!1595 = !DICompositeType(tag: DW_TAG_array_type, baseType: !47, size: 96, elements: !1596)
!1596 = !{!1597}
!1597 = !DISubrange(count: 3)
!1598 = !DIDerivedType(tag: DW_TAG_member, name: "ucDummy19", scope: !1549, file: !1548, line: 1307, baseType: !1599, size: 24, offset: 2176)
!1599 = !DICompositeType(tag: DW_TAG_array_type, baseType: !1583, size: 24, elements: !1596)
!1600 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy20", scope: !1549, file: !1548, line: 1310, baseType: !1583, size: 8, offset: 2200)
!1601 = !DIDerivedType(tag: DW_TAG_member, name: "ucDummy21", scope: !1549, file: !1548, line: 1314, baseType: !1583, size: 8, offset: 2208)
!1602 = !DILocalVariable(name: "pxTaskCode", arg: 1, scope: !1539, file: !36, line: 1347, type: !97)
!1603 = !DILocation(line: 1347, column: 60, scope: !1539)
!1604 = !DILocalVariable(name: "pcName", arg: 2, scope: !1539, file: !36, line: 1348, type: !1377)
!1605 = !DILocation(line: 1348, column: 64, scope: !1539)
!1606 = !DILocalVariable(name: "ulStackDepth", arg: 3, scope: !1539, file: !36, line: 1349, type: !1542)
!1607 = !DILocation(line: 1349, column: 60, scope: !1539)
!1608 = !DILocalVariable(name: "pvParameters", arg: 4, scope: !1539, file: !36, line: 1350, type: !1543)
!1609 = !DILocation(line: 1350, column: 58, scope: !1539)
!1610 = !DILocalVariable(name: "uxPriority", arg: 5, scope: !1539, file: !36, line: 1351, type: !39)
!1611 = !DILocation(line: 1351, column: 57, scope: !1539)
!1612 = !DILocalVariable(name: "puxStackBuffer", arg: 6, scope: !1539, file: !36, line: 1352, type: !1544)
!1613 = !DILocation(line: 1352, column: 65, scope: !1539)
!1614 = !DILocalVariable(name: "pxTaskBuffer", arg: 7, scope: !1539, file: !36, line: 1353, type: !1545)
!1615 = !DILocation(line: 1353, column: 66, scope: !1539)
!1616 = !DILocalVariable(name: "xExternalTaskHandle", scope: !1539, file: !36, line: 1355, type: !32)
!1617 = !DILocation(line: 1355, column: 26, scope: !1539)
!1618 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1539, file: !36, line: 1356, type: !32)
!1619 = !DILocation(line: 1356, column: 26, scope: !1539)
!1620 = !DILocalVariable(name: "lIndex", scope: !1539, file: !36, line: 1357, type: !27)
!1621 = !DILocation(line: 1357, column: 21, scope: !1539)
!1622 = !DILocation(line: 1359, column: 22, scope: !1539)
!1623 = !DILocation(line: 1359, column: 20, scope: !1539)
!1624 = !DILocation(line: 1361, column: 17, scope: !1625)
!1625 = distinct !DILexicalBlock(scope: !1539, file: !36, line: 1361, column: 17)
!1626 = !DILocation(line: 1361, column: 24, scope: !1625)
!1627 = !DILocation(line: 1361, column: 17, scope: !1539)
!1628 = !DILocation(line: 1363, column: 58, scope: !1629)
!1629 = distinct !DILexicalBlock(scope: !1625, file: !36, line: 1362, column: 13)
!1630 = !DILocation(line: 1363, column: 70, scope: !1629)
!1631 = !DILocation(line: 1363, column: 78, scope: !1629)
!1632 = !DILocation(line: 1363, column: 92, scope: !1629)
!1633 = !DILocation(line: 1363, column: 106, scope: !1629)
!1634 = !DILocation(line: 1363, column: 118, scope: !1629)
!1635 = !DILocation(line: 1363, column: 134, scope: !1629)
!1636 = !DILocation(line: 1363, column: 39, scope: !1629)
!1637 = !DILocation(line: 1363, column: 37, scope: !1629)
!1638 = !DILocation(line: 1365, column: 21, scope: !1639)
!1639 = distinct !DILexicalBlock(scope: !1629, file: !36, line: 1365, column: 21)
!1640 = !DILocation(line: 1365, column: 41, scope: !1639)
!1641 = !DILocation(line: 1365, column: 21, scope: !1629)
!1642 = !DILocation(line: 1367, column: 21, scope: !1643)
!1643 = distinct !DILexicalBlock(scope: !1639, file: !36, line: 1366, column: 17)
!1644 = !DILocation(line: 1368, column: 60, scope: !1643)
!1645 = !DILocation(line: 1368, column: 43, scope: !1643)
!1646 = !DILocation(line: 1368, column: 41, scope: !1643)
!1647 = !DILocation(line: 1369, column: 17, scope: !1643)
!1648 = !DILocation(line: 1372, column: 57, scope: !1649)
!1649 = distinct !DILexicalBlock(scope: !1639, file: !36, line: 1371, column: 17)
!1650 = !DILocation(line: 1372, column: 21, scope: !1649)
!1651 = !DILocation(line: 1374, column: 13, scope: !1629)
!1652 = !DILocation(line: 1376, column: 20, scope: !1539)
!1653 = !DILocation(line: 1376, column: 13, scope: !1539)
!1654 = distinct !DISubprogram(name: "MPU_vTaskDelete", scope: !36, file: !36, line: 1384, type: !438, scopeLine: 1385, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1655 = !DILocalVariable(name: "pxTaskToDelete", arg: 1, scope: !1654, file: !36, line: 1384, type: !32)
!1656 = !DILocation(line: 1384, column: 44, scope: !1654)
!1657 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1654, file: !36, line: 1386, type: !32)
!1658 = !DILocation(line: 1386, column: 26, scope: !1654)
!1659 = !DILocalVariable(name: "lIndex", scope: !1654, file: !36, line: 1387, type: !27)
!1660 = !DILocation(line: 1387, column: 21, scope: !1654)
!1661 = !DILocation(line: 1389, column: 17, scope: !1662)
!1662 = distinct !DILexicalBlock(scope: !1654, file: !36, line: 1389, column: 17)
!1663 = !DILocation(line: 1389, column: 32, scope: !1662)
!1664 = !DILocation(line: 1389, column: 17, scope: !1654)
!1665 = !DILocation(line: 1391, column: 39, scope: !1666)
!1666 = distinct !DILexicalBlock(scope: !1662, file: !36, line: 1390, column: 13)
!1667 = !DILocation(line: 1391, column: 37, scope: !1666)
!1668 = !DILocation(line: 1392, column: 26, scope: !1666)
!1669 = !DILocation(line: 1392, column: 24, scope: !1666)
!1670 = !DILocation(line: 1394, column: 30, scope: !1666)
!1671 = !DILocation(line: 1394, column: 17, scope: !1666)
!1672 = !DILocation(line: 1396, column: 21, scope: !1673)
!1673 = distinct !DILexicalBlock(scope: !1666, file: !36, line: 1396, column: 21)
!1674 = !DILocation(line: 1396, column: 28, scope: !1673)
!1675 = !DILocation(line: 1396, column: 21, scope: !1666)
!1676 = !DILocation(line: 1398, column: 57, scope: !1677)
!1677 = distinct !DILexicalBlock(scope: !1673, file: !36, line: 1397, column: 17)
!1678 = !DILocation(line: 1398, column: 21, scope: !1677)
!1679 = !DILocation(line: 1399, column: 17, scope: !1677)
!1680 = !DILocation(line: 1400, column: 13, scope: !1666)
!1681 = !DILocation(line: 1403, column: 38, scope: !1682)
!1682 = distinct !DILexicalBlock(scope: !1662, file: !36, line: 1402, column: 13)
!1683 = !DILocation(line: 1403, column: 26, scope: !1682)
!1684 = !DILocation(line: 1403, column: 24, scope: !1682)
!1685 = !DILocation(line: 1405, column: 21, scope: !1686)
!1686 = distinct !DILexicalBlock(scope: !1682, file: !36, line: 1405, column: 21)
!1687 = !DILocation(line: 0, scope: !1686)
!1688 = !DILocation(line: 1405, column: 55, scope: !1686)
!1689 = !DILocation(line: 1405, column: 21, scope: !1682)
!1690 = !DILocation(line: 1407, column: 43, scope: !1691)
!1691 = distinct !DILexicalBlock(scope: !1686, file: !36, line: 1406, column: 17)
!1692 = !DILocation(line: 1407, column: 41, scope: !1691)
!1693 = !DILocation(line: 1409, column: 25, scope: !1694)
!1694 = distinct !DILexicalBlock(scope: !1691, file: !36, line: 1409, column: 25)
!1695 = !DILocation(line: 1409, column: 45, scope: !1694)
!1696 = !DILocation(line: 1409, column: 25, scope: !1691)
!1697 = !DILocation(line: 1411, column: 38, scope: !1698)
!1698 = distinct !DILexicalBlock(scope: !1694, file: !36, line: 1410, column: 21)
!1699 = !DILocation(line: 1411, column: 25, scope: !1698)
!1700 = !DILocation(line: 1412, column: 61, scope: !1698)
!1701 = !DILocation(line: 1412, column: 25, scope: !1698)
!1702 = !DILocation(line: 1413, column: 21, scope: !1698)
!1703 = !DILocation(line: 1414, column: 17, scope: !1691)
!1704 = !DILocation(line: 1416, column: 9, scope: !1654)
!1705 = distinct !DISubprogram(name: "MPU_vTaskPrioritySet", scope: !36, file: !36, line: 1424, type: !1706, scopeLine: 1426, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1706 = !DISubroutineType(types: !1707)
!1707 = !{null, !32, !39}
!1708 = !DILocalVariable(name: "pxTask", arg: 1, scope: !1705, file: !36, line: 1424, type: !32)
!1709 = !DILocation(line: 1424, column: 49, scope: !1705)
!1710 = !DILocalVariable(name: "uxNewPriority", arg: 2, scope: !1705, file: !36, line: 1425, type: !39)
!1711 = !DILocation(line: 1425, column: 48, scope: !1705)
!1712 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1705, file: !36, line: 1427, type: !32)
!1713 = !DILocation(line: 1427, column: 26, scope: !1705)
!1714 = !DILocalVariable(name: "lIndex", scope: !1705, file: !36, line: 1428, type: !27)
!1715 = !DILocation(line: 1428, column: 21, scope: !1705)
!1716 = !DILocation(line: 1430, column: 17, scope: !1717)
!1717 = distinct !DILexicalBlock(scope: !1705, file: !36, line: 1430, column: 17)
!1718 = !DILocation(line: 1430, column: 24, scope: !1717)
!1719 = !DILocation(line: 1430, column: 17, scope: !1705)
!1720 = !DILocation(line: 1432, column: 35, scope: !1721)
!1721 = distinct !DILexicalBlock(scope: !1717, file: !36, line: 1431, column: 13)
!1722 = !DILocation(line: 1432, column: 43, scope: !1721)
!1723 = !DILocation(line: 1432, column: 17, scope: !1721)
!1724 = !DILocation(line: 1433, column: 13, scope: !1721)
!1725 = !DILocation(line: 1436, column: 38, scope: !1726)
!1726 = distinct !DILexicalBlock(scope: !1717, file: !36, line: 1435, column: 13)
!1727 = !DILocation(line: 1436, column: 26, scope: !1726)
!1728 = !DILocation(line: 1436, column: 24, scope: !1726)
!1729 = !DILocation(line: 1438, column: 21, scope: !1730)
!1730 = distinct !DILexicalBlock(scope: !1726, file: !36, line: 1438, column: 21)
!1731 = !DILocation(line: 0, scope: !1730)
!1732 = !DILocation(line: 1438, column: 55, scope: !1730)
!1733 = !DILocation(line: 1438, column: 21, scope: !1726)
!1734 = !DILocation(line: 1440, column: 43, scope: !1735)
!1735 = distinct !DILexicalBlock(scope: !1730, file: !36, line: 1439, column: 17)
!1736 = !DILocation(line: 1440, column: 41, scope: !1735)
!1737 = !DILocation(line: 1442, column: 25, scope: !1738)
!1738 = distinct !DILexicalBlock(scope: !1735, file: !36, line: 1442, column: 25)
!1739 = !DILocation(line: 1442, column: 45, scope: !1738)
!1740 = !DILocation(line: 1442, column: 25, scope: !1735)
!1741 = !DILocation(line: 1444, column: 43, scope: !1742)
!1742 = distinct !DILexicalBlock(scope: !1738, file: !36, line: 1443, column: 21)
!1743 = !DILocation(line: 1444, column: 64, scope: !1742)
!1744 = !DILocation(line: 1444, column: 25, scope: !1742)
!1745 = !DILocation(line: 1445, column: 21, scope: !1742)
!1746 = !DILocation(line: 1446, column: 17, scope: !1735)
!1747 = !DILocation(line: 1448, column: 9, scope: !1705)
!1748 = distinct !DISubprogram(name: "MPU_xTaskGetHandle", scope: !36, file: !36, line: 1455, type: !1749, scopeLine: 1456, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1749 = !DISubroutineType(types: !1750)
!1750 = !{!32, !356}
!1751 = !DILocalVariable(name: "pcNameToQuery", arg: 1, scope: !1748, file: !36, line: 1455, type: !356)
!1752 = !DILocation(line: 1455, column: 55, scope: !1748)
!1753 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1748, file: !36, line: 1457, type: !32)
!1754 = !DILocation(line: 1457, column: 26, scope: !1748)
!1755 = !DILocalVariable(name: "xExternalTaskHandle", scope: !1748, file: !36, line: 1458, type: !32)
!1756 = !DILocation(line: 1458, column: 26, scope: !1748)
!1757 = !DILocalVariable(name: "lIndex", scope: !1748, file: !36, line: 1459, type: !27)
!1758 = !DILocation(line: 1459, column: 21, scope: !1748)
!1759 = !DILocation(line: 1461, column: 51, scope: !1748)
!1760 = !DILocation(line: 1461, column: 35, scope: !1748)
!1761 = !DILocation(line: 1461, column: 33, scope: !1748)
!1762 = !DILocation(line: 1463, column: 17, scope: !1763)
!1763 = distinct !DILexicalBlock(scope: !1748, file: !36, line: 1463, column: 17)
!1764 = !DILocation(line: 1463, column: 37, scope: !1763)
!1765 = !DILocation(line: 1463, column: 17, scope: !1748)
!1766 = !DILocation(line: 1465, column: 26, scope: !1767)
!1767 = distinct !DILexicalBlock(scope: !1763, file: !36, line: 1464, column: 13)
!1768 = !DILocation(line: 1465, column: 24, scope: !1767)
!1769 = !DILocation(line: 1467, column: 21, scope: !1770)
!1770 = distinct !DILexicalBlock(scope: !1767, file: !36, line: 1467, column: 21)
!1771 = !DILocation(line: 1467, column: 28, scope: !1770)
!1772 = !DILocation(line: 1467, column: 21, scope: !1767)
!1773 = !DILocation(line: 1469, column: 60, scope: !1774)
!1774 = distinct !DILexicalBlock(scope: !1770, file: !36, line: 1468, column: 17)
!1775 = !DILocation(line: 1469, column: 43, scope: !1774)
!1776 = !DILocation(line: 1469, column: 41, scope: !1774)
!1777 = !DILocation(line: 1470, column: 17, scope: !1774)
!1778 = !DILocation(line: 1471, column: 13, scope: !1767)
!1779 = !DILocation(line: 1473, column: 20, scope: !1748)
!1780 = !DILocation(line: 1473, column: 13, scope: !1748)
!1781 = distinct !DISubprogram(name: "MPU_xTaskCallApplicationTaskHook", scope: !36, file: !36, line: 1482, type: !1782, scopeLine: 1484, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1782 = !DISubroutineType(types: !1783)
!1783 = !{!23, !32, !26}
!1784 = !DILocalVariable(name: "xTask", arg: 1, scope: !1781, file: !36, line: 1482, type: !32)
!1785 = !DILocation(line: 1482, column: 67, scope: !1781)
!1786 = !DILocalVariable(name: "pvParameter", arg: 2, scope: !1781, file: !36, line: 1483, type: !26)
!1787 = !DILocation(line: 1483, column: 61, scope: !1781)
!1788 = !DILocalVariable(name: "xReturn", scope: !1781, file: !36, line: 1485, type: !23)
!1789 = !DILocation(line: 1485, column: 24, scope: !1781)
!1790 = !DILocalVariable(name: "lIndex", scope: !1781, file: !36, line: 1486, type: !27)
!1791 = !DILocation(line: 1486, column: 21, scope: !1781)
!1792 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1781, file: !36, line: 1487, type: !32)
!1793 = !DILocation(line: 1487, column: 26, scope: !1781)
!1794 = !DILocation(line: 1489, column: 17, scope: !1795)
!1795 = distinct !DILexicalBlock(scope: !1781, file: !36, line: 1489, column: 17)
!1796 = !DILocation(line: 1489, column: 23, scope: !1795)
!1797 = !DILocation(line: 1489, column: 17, scope: !1781)
!1798 = !DILocation(line: 1491, column: 57, scope: !1799)
!1799 = distinct !DILexicalBlock(scope: !1795, file: !36, line: 1490, column: 13)
!1800 = !DILocation(line: 1491, column: 64, scope: !1799)
!1801 = !DILocation(line: 1491, column: 27, scope: !1799)
!1802 = !DILocation(line: 1491, column: 25, scope: !1799)
!1803 = !DILocation(line: 1492, column: 13, scope: !1799)
!1804 = !DILocation(line: 1495, column: 38, scope: !1805)
!1805 = distinct !DILexicalBlock(scope: !1795, file: !36, line: 1494, column: 13)
!1806 = !DILocation(line: 1495, column: 26, scope: !1805)
!1807 = !DILocation(line: 1495, column: 24, scope: !1805)
!1808 = !DILocation(line: 1497, column: 21, scope: !1809)
!1809 = distinct !DILexicalBlock(scope: !1805, file: !36, line: 1497, column: 21)
!1810 = !DILocation(line: 0, scope: !1809)
!1811 = !DILocation(line: 1497, column: 55, scope: !1809)
!1812 = !DILocation(line: 1497, column: 21, scope: !1805)
!1813 = !DILocation(line: 1499, column: 43, scope: !1814)
!1814 = distinct !DILexicalBlock(scope: !1809, file: !36, line: 1498, column: 17)
!1815 = !DILocation(line: 1499, column: 41, scope: !1814)
!1816 = !DILocation(line: 1501, column: 25, scope: !1817)
!1817 = distinct !DILexicalBlock(scope: !1814, file: !36, line: 1501, column: 25)
!1818 = !DILocation(line: 1501, column: 45, scope: !1817)
!1819 = !DILocation(line: 1501, column: 25, scope: !1814)
!1820 = !DILocation(line: 1503, column: 65, scope: !1821)
!1821 = distinct !DILexicalBlock(scope: !1817, file: !36, line: 1502, column: 21)
!1822 = !DILocation(line: 1503, column: 86, scope: !1821)
!1823 = !DILocation(line: 1503, column: 35, scope: !1821)
!1824 = !DILocation(line: 1503, column: 33, scope: !1821)
!1825 = !DILocation(line: 1504, column: 21, scope: !1821)
!1826 = !DILocation(line: 1505, column: 17, scope: !1814)
!1827 = !DILocation(line: 1508, column: 20, scope: !1781)
!1828 = !DILocation(line: 1508, column: 13, scope: !1781)
!1829 = distinct !DISubprogram(name: "MPU_xTaskCreateRestricted", scope: !36, file: !36, line: 1516, type: !1830, scopeLine: 1518, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1830 = !DISubroutineType(types: !1831)
!1831 = !{!23, !1832, !1378}
!1832 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1833)
!1833 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1834, size: 64)
!1834 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1835)
!1835 = !DIDerivedType(tag: DW_TAG_typedef, name: "TaskParameters_t", file: !6, line: 155, baseType: !1836)
!1836 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xTASK_PARAMETERS", file: !6, line: 143, size: 576, elements: !1837)
!1837 = !{!1838, !1839, !1840, !1841, !1842, !1843, !1844, !1854}
!1838 = !DIDerivedType(tag: DW_TAG_member, name: "pvTaskCode", scope: !1836, file: !6, line: 145, baseType: !97, size: 64)
!1839 = !DIDerivedType(tag: DW_TAG_member, name: "pcName", scope: !1836, file: !6, line: 146, baseType: !356, size: 64, offset: 64)
!1840 = !DIDerivedType(tag: DW_TAG_member, name: "usStackDepth", scope: !1836, file: !6, line: 147, baseType: !366, size: 16, offset: 128)
!1841 = !DIDerivedType(tag: DW_TAG_member, name: "pvParameters", scope: !1836, file: !6, line: 148, baseType: !26, size: 64, offset: 192)
!1842 = !DIDerivedType(tag: DW_TAG_member, name: "uxPriority", scope: !1836, file: !6, line: 149, baseType: !39, size: 64, offset: 256)
!1843 = !DIDerivedType(tag: DW_TAG_member, name: "puxStackBuffer", scope: !1836, file: !6, line: 150, baseType: !117, size: 64, offset: 320)
!1844 = !DIDerivedType(tag: DW_TAG_member, name: "xRegions", scope: !1836, file: !6, line: 151, baseType: !1845, size: 128, offset: 384)
!1845 = !DICompositeType(tag: DW_TAG_array_type, baseType: !1846, size: 128, elements: !1852)
!1846 = !DIDerivedType(tag: DW_TAG_typedef, name: "MemoryRegion_t", file: !6, line: 138, baseType: !1847)
!1847 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xMEMORY_REGION", file: !6, line: 133, size: 128, elements: !1848)
!1848 = !{!1849, !1850, !1851}
!1849 = !DIDerivedType(tag: DW_TAG_member, name: "pvBaseAddress", scope: !1847, file: !6, line: 135, baseType: !26, size: 64)
!1850 = !DIDerivedType(tag: DW_TAG_member, name: "ulLengthInBytes", scope: !1847, file: !6, line: 136, baseType: !47, size: 32, offset: 64)
!1851 = !DIDerivedType(tag: DW_TAG_member, name: "ulParameters", scope: !1847, file: !6, line: 137, baseType: !47, size: 32, offset: 96)
!1852 = !{!1853}
!1853 = !DISubrange(count: 1)
!1854 = !DIDerivedType(tag: DW_TAG_member, name: "pxTaskBuffer", scope: !1836, file: !6, line: 153, baseType: !1545, size: 64, offset: 512)
!1855 = !DILocalVariable(name: "pxTaskDefinition", arg: 1, scope: !1829, file: !36, line: 1516, type: !1832)
!1856 = !DILocation(line: 1516, column: 78, scope: !1829)
!1857 = !DILocalVariable(name: "pxCreatedTask", arg: 2, scope: !1829, file: !36, line: 1517, type: !1378)
!1858 = !DILocation(line: 1517, column: 62, scope: !1829)
!1859 = !DILocalVariable(name: "xReturn", scope: !1829, file: !36, line: 1519, type: !23)
!1860 = !DILocation(line: 1519, column: 24, scope: !1829)
!1861 = !DILocalVariable(name: "lIndex", scope: !1829, file: !36, line: 1520, type: !27)
!1862 = !DILocation(line: 1520, column: 21, scope: !1829)
!1863 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1829, file: !36, line: 1521, type: !32)
!1864 = !DILocation(line: 1521, column: 26, scope: !1829)
!1865 = !DILocation(line: 1523, column: 22, scope: !1829)
!1866 = !DILocation(line: 1523, column: 20, scope: !1829)
!1867 = !DILocation(line: 1525, column: 17, scope: !1868)
!1868 = distinct !DILexicalBlock(scope: !1829, file: !36, line: 1525, column: 17)
!1869 = !DILocation(line: 1525, column: 24, scope: !1868)
!1870 = !DILocation(line: 1525, column: 17, scope: !1829)
!1871 = !DILocation(line: 1527, column: 50, scope: !1872)
!1872 = distinct !DILexicalBlock(scope: !1868, file: !36, line: 1526, column: 13)
!1873 = !DILocation(line: 1527, column: 27, scope: !1872)
!1874 = !DILocation(line: 1527, column: 25, scope: !1872)
!1875 = !DILocation(line: 1529, column: 23, scope: !1876)
!1876 = distinct !DILexicalBlock(scope: !1872, file: !36, line: 1529, column: 21)
!1877 = !DILocation(line: 1529, column: 31, scope: !1876)
!1878 = !DILocation(line: 1529, column: 43, scope: !1876)
!1879 = !DILocation(line: 1529, column: 48, scope: !1876)
!1880 = !DILocation(line: 1529, column: 68, scope: !1876)
!1881 = !DILocation(line: 1529, column: 21, scope: !1872)
!1882 = !DILocation(line: 1531, column: 21, scope: !1883)
!1883 = distinct !DILexicalBlock(scope: !1876, file: !36, line: 1530, column: 17)
!1884 = !DILocation(line: 1533, column: 25, scope: !1885)
!1885 = distinct !DILexicalBlock(scope: !1883, file: !36, line: 1533, column: 25)
!1886 = !DILocation(line: 1533, column: 39, scope: !1885)
!1887 = !DILocation(line: 1533, column: 25, scope: !1883)
!1888 = !DILocation(line: 1535, column: 59, scope: !1889)
!1889 = distinct !DILexicalBlock(scope: !1885, file: !36, line: 1534, column: 21)
!1890 = !DILocation(line: 1535, column: 42, scope: !1889)
!1891 = !DILocation(line: 1535, column: 26, scope: !1889)
!1892 = !DILocation(line: 1535, column: 40, scope: !1889)
!1893 = !DILocation(line: 1536, column: 21, scope: !1889)
!1894 = !DILocation(line: 1537, column: 17, scope: !1883)
!1895 = !DILocation(line: 1540, column: 57, scope: !1896)
!1896 = distinct !DILexicalBlock(scope: !1876, file: !36, line: 1539, column: 17)
!1897 = !DILocation(line: 1540, column: 21, scope: !1896)
!1898 = !DILocation(line: 1542, column: 13, scope: !1872)
!1899 = !DILocation(line: 1544, column: 20, scope: !1829)
!1900 = !DILocation(line: 1544, column: 13, scope: !1829)
!1901 = distinct !DISubprogram(name: "MPU_xTaskCreateRestrictedStatic", scope: !36, file: !36, line: 1552, type: !1830, scopeLine: 1554, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1902 = !DILocalVariable(name: "pxTaskDefinition", arg: 1, scope: !1901, file: !36, line: 1552, type: !1832)
!1903 = !DILocation(line: 1552, column: 84, scope: !1901)
!1904 = !DILocalVariable(name: "pxCreatedTask", arg: 2, scope: !1901, file: !36, line: 1553, type: !1378)
!1905 = !DILocation(line: 1553, column: 68, scope: !1901)
!1906 = !DILocalVariable(name: "xReturn", scope: !1901, file: !36, line: 1555, type: !23)
!1907 = !DILocation(line: 1555, column: 24, scope: !1901)
!1908 = !DILocalVariable(name: "lIndex", scope: !1901, file: !36, line: 1556, type: !27)
!1909 = !DILocation(line: 1556, column: 21, scope: !1901)
!1910 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1901, file: !36, line: 1557, type: !32)
!1911 = !DILocation(line: 1557, column: 26, scope: !1901)
!1912 = !DILocation(line: 1559, column: 22, scope: !1901)
!1913 = !DILocation(line: 1559, column: 20, scope: !1901)
!1914 = !DILocation(line: 1561, column: 17, scope: !1915)
!1915 = distinct !DILexicalBlock(scope: !1901, file: !36, line: 1561, column: 17)
!1916 = !DILocation(line: 1561, column: 24, scope: !1915)
!1917 = !DILocation(line: 1561, column: 17, scope: !1901)
!1918 = !DILocation(line: 1563, column: 56, scope: !1919)
!1919 = distinct !DILexicalBlock(scope: !1915, file: !36, line: 1562, column: 13)
!1920 = !DILocation(line: 1563, column: 27, scope: !1919)
!1921 = !DILocation(line: 1563, column: 25, scope: !1919)
!1922 = !DILocation(line: 1565, column: 23, scope: !1923)
!1923 = distinct !DILexicalBlock(scope: !1919, file: !36, line: 1565, column: 21)
!1924 = !DILocation(line: 1565, column: 31, scope: !1923)
!1925 = !DILocation(line: 1565, column: 43, scope: !1923)
!1926 = !DILocation(line: 1565, column: 48, scope: !1923)
!1927 = !DILocation(line: 1565, column: 68, scope: !1923)
!1928 = !DILocation(line: 1565, column: 21, scope: !1919)
!1929 = !DILocation(line: 1567, column: 21, scope: !1930)
!1930 = distinct !DILexicalBlock(scope: !1923, file: !36, line: 1566, column: 17)
!1931 = !DILocation(line: 1569, column: 25, scope: !1932)
!1932 = distinct !DILexicalBlock(scope: !1930, file: !36, line: 1569, column: 25)
!1933 = !DILocation(line: 1569, column: 39, scope: !1932)
!1934 = !DILocation(line: 1569, column: 25, scope: !1930)
!1935 = !DILocation(line: 1571, column: 59, scope: !1936)
!1936 = distinct !DILexicalBlock(scope: !1932, file: !36, line: 1570, column: 21)
!1937 = !DILocation(line: 1571, column: 42, scope: !1936)
!1938 = !DILocation(line: 1571, column: 26, scope: !1936)
!1939 = !DILocation(line: 1571, column: 40, scope: !1936)
!1940 = !DILocation(line: 1572, column: 21, scope: !1936)
!1941 = !DILocation(line: 1573, column: 17, scope: !1930)
!1942 = !DILocation(line: 1576, column: 57, scope: !1943)
!1943 = distinct !DILexicalBlock(scope: !1923, file: !36, line: 1575, column: 17)
!1944 = !DILocation(line: 1576, column: 21, scope: !1943)
!1945 = !DILocation(line: 1578, column: 13, scope: !1919)
!1946 = !DILocation(line: 1580, column: 20, scope: !1901)
!1947 = !DILocation(line: 1580, column: 13, scope: !1901)
!1948 = distinct !DISubprogram(name: "MPU_vTaskAllocateMPURegions", scope: !36, file: !36, line: 1586, type: !1949, scopeLine: 1588, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1949 = !DISubroutineType(types: !1950)
!1950 = !{null, !32, !1951}
!1951 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1952)
!1952 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1953, size: 64)
!1953 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1846)
!1954 = !DILocalVariable(name: "xTaskToModify", arg: 1, scope: !1948, file: !36, line: 1586, type: !32)
!1955 = !DILocation(line: 1586, column: 52, scope: !1948)
!1956 = !DILocalVariable(name: "xRegions", arg: 2, scope: !1948, file: !36, line: 1587, type: !1951)
!1957 = !DILocation(line: 1587, column: 68, scope: !1948)
!1958 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1948, file: !36, line: 1589, type: !32)
!1959 = !DILocation(line: 1589, column: 22, scope: !1948)
!1960 = !DILocalVariable(name: "lIndex", scope: !1948, file: !36, line: 1590, type: !27)
!1961 = !DILocation(line: 1590, column: 17, scope: !1948)
!1962 = !DILocation(line: 1592, column: 13, scope: !1963)
!1963 = distinct !DILexicalBlock(scope: !1948, file: !36, line: 1592, column: 13)
!1964 = !DILocation(line: 1592, column: 27, scope: !1963)
!1965 = !DILocation(line: 1592, column: 13, scope: !1948)
!1966 = !DILocation(line: 1594, column: 38, scope: !1967)
!1967 = distinct !DILexicalBlock(scope: !1963, file: !36, line: 1593, column: 9)
!1968 = !DILocation(line: 1594, column: 53, scope: !1967)
!1969 = !DILocation(line: 1594, column: 13, scope: !1967)
!1970 = !DILocation(line: 1595, column: 9, scope: !1967)
!1971 = !DILocation(line: 1598, column: 34, scope: !1972)
!1972 = distinct !DILexicalBlock(scope: !1963, file: !36, line: 1597, column: 9)
!1973 = !DILocation(line: 1598, column: 22, scope: !1972)
!1974 = !DILocation(line: 1598, column: 20, scope: !1972)
!1975 = !DILocation(line: 1600, column: 17, scope: !1976)
!1976 = distinct !DILexicalBlock(scope: !1972, file: !36, line: 1600, column: 17)
!1977 = !DILocation(line: 0, scope: !1976)
!1978 = !DILocation(line: 1600, column: 51, scope: !1976)
!1979 = !DILocation(line: 1600, column: 17, scope: !1972)
!1980 = !DILocation(line: 1602, column: 39, scope: !1981)
!1981 = distinct !DILexicalBlock(scope: !1976, file: !36, line: 1601, column: 13)
!1982 = !DILocation(line: 1602, column: 37, scope: !1981)
!1983 = !DILocation(line: 1604, column: 21, scope: !1984)
!1984 = distinct !DILexicalBlock(scope: !1981, file: !36, line: 1604, column: 21)
!1985 = !DILocation(line: 1604, column: 41, scope: !1984)
!1986 = !DILocation(line: 1604, column: 21, scope: !1981)
!1987 = !DILocation(line: 1606, column: 46, scope: !1988)
!1988 = distinct !DILexicalBlock(scope: !1984, file: !36, line: 1605, column: 17)
!1989 = !DILocation(line: 1606, column: 67, scope: !1988)
!1990 = !DILocation(line: 1606, column: 21, scope: !1988)
!1991 = !DILocation(line: 1607, column: 17, scope: !1988)
!1992 = !DILocation(line: 1608, column: 13, scope: !1981)
!1993 = !DILocation(line: 1610, column: 5, scope: !1948)
!1994 = distinct !DISubprogram(name: "MPU_xTaskGetStaticBuffers", scope: !36, file: !36, line: 1615, type: !1995, scopeLine: 1618, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!1995 = !DISubroutineType(types: !1996)
!1996 = !{!23, !32, !116, !1997}
!1997 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1546, size: 64)
!1998 = !DILocalVariable(name: "xTask", arg: 1, scope: !1994, file: !36, line: 1615, type: !32)
!1999 = !DILocation(line: 1615, column: 60, scope: !1994)
!2000 = !DILocalVariable(name: "ppuxStackBuffer", arg: 2, scope: !1994, file: !36, line: 1616, type: !116)
!2001 = !DILocation(line: 1616, column: 62, scope: !1994)
!2002 = !DILocalVariable(name: "ppxTaskBuffer", arg: 3, scope: !1994, file: !36, line: 1617, type: !1997)
!2003 = !DILocation(line: 1617, column: 63, scope: !1994)
!2004 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1994, file: !36, line: 1619, type: !32)
!2005 = !DILocation(line: 1619, column: 26, scope: !1994)
!2006 = !DILocalVariable(name: "lIndex", scope: !1994, file: !36, line: 1620, type: !27)
!2007 = !DILocation(line: 1620, column: 21, scope: !1994)
!2008 = !DILocalVariable(name: "xReturn", scope: !1994, file: !36, line: 1621, type: !23)
!2009 = !DILocation(line: 1621, column: 24, scope: !1994)
!2010 = !DILocation(line: 1623, column: 17, scope: !2011)
!2011 = distinct !DILexicalBlock(scope: !1994, file: !36, line: 1623, column: 17)
!2012 = !DILocation(line: 1623, column: 23, scope: !2011)
!2013 = !DILocation(line: 1623, column: 17, scope: !1994)
!2014 = !DILocation(line: 1625, column: 39, scope: !2015)
!2015 = distinct !DILexicalBlock(scope: !2011, file: !36, line: 1624, column: 13)
!2016 = !DILocation(line: 1625, column: 37, scope: !2015)
!2017 = !DILocation(line: 1626, column: 50, scope: !2015)
!2018 = !DILocation(line: 1626, column: 71, scope: !2015)
!2019 = !DILocation(line: 1626, column: 88, scope: !2015)
!2020 = !DILocation(line: 1626, column: 27, scope: !2015)
!2021 = !DILocation(line: 1626, column: 25, scope: !2015)
!2022 = !DILocation(line: 1627, column: 13, scope: !2015)
!2023 = !DILocation(line: 1630, column: 38, scope: !2024)
!2024 = distinct !DILexicalBlock(scope: !2011, file: !36, line: 1629, column: 13)
!2025 = !DILocation(line: 1630, column: 26, scope: !2024)
!2026 = !DILocation(line: 1630, column: 24, scope: !2024)
!2027 = !DILocation(line: 1632, column: 21, scope: !2028)
!2028 = distinct !DILexicalBlock(scope: !2024, file: !36, line: 1632, column: 21)
!2029 = !DILocation(line: 0, scope: !2028)
!2030 = !DILocation(line: 1632, column: 55, scope: !2028)
!2031 = !DILocation(line: 1632, column: 21, scope: !2024)
!2032 = !DILocation(line: 1634, column: 43, scope: !2033)
!2033 = distinct !DILexicalBlock(scope: !2028, file: !36, line: 1633, column: 17)
!2034 = !DILocation(line: 1634, column: 41, scope: !2033)
!2035 = !DILocation(line: 1636, column: 25, scope: !2036)
!2036 = distinct !DILexicalBlock(scope: !2033, file: !36, line: 1636, column: 25)
!2037 = !DILocation(line: 1636, column: 45, scope: !2036)
!2038 = !DILocation(line: 1636, column: 25, scope: !2033)
!2039 = !DILocation(line: 1638, column: 58, scope: !2040)
!2040 = distinct !DILexicalBlock(scope: !2036, file: !36, line: 1637, column: 21)
!2041 = !DILocation(line: 1638, column: 79, scope: !2040)
!2042 = !DILocation(line: 1638, column: 96, scope: !2040)
!2043 = !DILocation(line: 1638, column: 35, scope: !2040)
!2044 = !DILocation(line: 1638, column: 33, scope: !2040)
!2045 = !DILocation(line: 1639, column: 21, scope: !2040)
!2046 = !DILocation(line: 1640, column: 17, scope: !2033)
!2047 = !DILocation(line: 1643, column: 20, scope: !1994)
!2048 = !DILocation(line: 1643, column: 13, scope: !1994)
!2049 = distinct !DISubprogram(name: "MPU_uxTaskPriorityGetFromISR", scope: !36, file: !36, line: 1651, type: !258, scopeLine: 1652, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!2050 = !DILocalVariable(name: "xTask", arg: 1, scope: !2049, file: !36, line: 1651, type: !260)
!2051 = !DILocation(line: 1651, column: 70, scope: !2049)
!2052 = !DILocalVariable(name: "uxReturn", scope: !2049, file: !36, line: 1653, type: !39)
!2053 = !DILocation(line: 1653, column: 25, scope: !2049)
!2054 = !DILocalVariable(name: "lIndex", scope: !2049, file: !36, line: 1654, type: !27)
!2055 = !DILocation(line: 1654, column: 21, scope: !2049)
!2056 = !DILocalVariable(name: "xInternalTaskHandle", scope: !2049, file: !36, line: 1655, type: !32)
!2057 = !DILocation(line: 1655, column: 26, scope: !2049)
!2058 = !DILocation(line: 1657, column: 17, scope: !2059)
!2059 = distinct !DILexicalBlock(scope: !2049, file: !36, line: 1657, column: 17)
!2060 = !DILocation(line: 1657, column: 23, scope: !2059)
!2061 = !DILocation(line: 1657, column: 17, scope: !2049)
!2062 = !DILocation(line: 1659, column: 54, scope: !2063)
!2063 = distinct !DILexicalBlock(scope: !2059, file: !36, line: 1658, column: 13)
!2064 = !DILocation(line: 1659, column: 28, scope: !2063)
!2065 = !DILocation(line: 1659, column: 26, scope: !2063)
!2066 = !DILocation(line: 1660, column: 13, scope: !2063)
!2067 = !DILocation(line: 1663, column: 38, scope: !2068)
!2068 = distinct !DILexicalBlock(scope: !2059, file: !36, line: 1662, column: 13)
!2069 = !DILocation(line: 1663, column: 26, scope: !2068)
!2070 = !DILocation(line: 1663, column: 24, scope: !2068)
!2071 = !DILocation(line: 1665, column: 21, scope: !2072)
!2072 = distinct !DILexicalBlock(scope: !2068, file: !36, line: 1665, column: 21)
!2073 = !DILocation(line: 0, scope: !2072)
!2074 = !DILocation(line: 1665, column: 55, scope: !2072)
!2075 = !DILocation(line: 1665, column: 21, scope: !2068)
!2076 = !DILocation(line: 1667, column: 43, scope: !2077)
!2077 = distinct !DILexicalBlock(scope: !2072, file: !36, line: 1666, column: 17)
!2078 = !DILocation(line: 1667, column: 41, scope: !2077)
!2079 = !DILocation(line: 1669, column: 25, scope: !2080)
!2080 = distinct !DILexicalBlock(scope: !2077, file: !36, line: 1669, column: 25)
!2081 = !DILocation(line: 1669, column: 45, scope: !2080)
!2082 = !DILocation(line: 1669, column: 25, scope: !2077)
!2083 = !DILocation(line: 1671, column: 62, scope: !2084)
!2084 = distinct !DILexicalBlock(scope: !2080, file: !36, line: 1670, column: 21)
!2085 = !DILocation(line: 1671, column: 36, scope: !2084)
!2086 = !DILocation(line: 1671, column: 34, scope: !2084)
!2087 = !DILocation(line: 1672, column: 21, scope: !2084)
!2088 = !DILocation(line: 1673, column: 17, scope: !2077)
!2089 = !DILocation(line: 1676, column: 20, scope: !2049)
!2090 = !DILocation(line: 1676, column: 13, scope: !2049)
!2091 = distinct !DISubprogram(name: "MPU_xTaskResumeFromISR", scope: !36, file: !36, line: 1684, type: !188, scopeLine: 1685, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!2092 = !DILocalVariable(name: "xTaskToResume", arg: 1, scope: !2091, file: !36, line: 1684, type: !32)
!2093 = !DILocation(line: 1684, column: 57, scope: !2091)
!2094 = !DILocalVariable(name: "xReturn", scope: !2091, file: !36, line: 1686, type: !23)
!2095 = !DILocation(line: 1686, column: 24, scope: !2091)
!2096 = !DILocalVariable(name: "lIndex", scope: !2091, file: !36, line: 1687, type: !27)
!2097 = !DILocation(line: 1687, column: 21, scope: !2091)
!2098 = !DILocalVariable(name: "xInternalTaskHandle", scope: !2091, file: !36, line: 1688, type: !32)
!2099 = !DILocation(line: 1688, column: 26, scope: !2091)
!2100 = !DILocation(line: 1690, column: 34, scope: !2091)
!2101 = !DILocation(line: 1690, column: 22, scope: !2091)
!2102 = !DILocation(line: 1690, column: 20, scope: !2091)
!2103 = !DILocation(line: 1692, column: 17, scope: !2104)
!2104 = distinct !DILexicalBlock(scope: !2091, file: !36, line: 1692, column: 17)
!2105 = !DILocation(line: 0, scope: !2104)
!2106 = !DILocation(line: 1692, column: 51, scope: !2104)
!2107 = !DILocation(line: 1692, column: 17, scope: !2091)
!2108 = !DILocation(line: 1694, column: 39, scope: !2109)
!2109 = distinct !DILexicalBlock(scope: !2104, file: !36, line: 1693, column: 13)
!2110 = !DILocation(line: 1694, column: 37, scope: !2109)
!2111 = !DILocation(line: 1696, column: 21, scope: !2112)
!2112 = distinct !DILexicalBlock(scope: !2109, file: !36, line: 1696, column: 21)
!2113 = !DILocation(line: 1696, column: 41, scope: !2112)
!2114 = !DILocation(line: 1696, column: 21, scope: !2109)
!2115 = !DILocation(line: 1698, column: 51, scope: !2116)
!2116 = distinct !DILexicalBlock(scope: !2112, file: !36, line: 1697, column: 17)
!2117 = !DILocation(line: 1698, column: 31, scope: !2116)
!2118 = !DILocation(line: 1698, column: 29, scope: !2116)
!2119 = !DILocation(line: 1699, column: 17, scope: !2116)
!2120 = !DILocation(line: 1700, column: 13, scope: !2109)
!2121 = !DILocation(line: 1702, column: 20, scope: !2091)
!2122 = !DILocation(line: 1702, column: 13, scope: !2091)
!2123 = distinct !DISubprogram(name: "MPU_xTaskGetApplicationTaskTagFromISR", scope: !36, file: !36, line: 1710, type: !726, scopeLine: 1711, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!2124 = !DILocalVariable(name: "xTask", arg: 1, scope: !2123, file: !36, line: 1710, type: !32)
!2125 = !DILocation(line: 1710, column: 80, scope: !2123)
!2126 = !DILocalVariable(name: "xReturn", scope: !2123, file: !36, line: 1712, type: !681)
!2127 = !DILocation(line: 1712, column: 32, scope: !2123)
!2128 = !DILocalVariable(name: "lIndex", scope: !2123, file: !36, line: 1713, type: !27)
!2129 = !DILocation(line: 1713, column: 21, scope: !2123)
!2130 = !DILocalVariable(name: "xInternalTaskHandle", scope: !2123, file: !36, line: 1714, type: !32)
!2131 = !DILocation(line: 1714, column: 26, scope: !2123)
!2132 = !DILocation(line: 1716, column: 17, scope: !2133)
!2133 = distinct !DILexicalBlock(scope: !2123, file: !36, line: 1716, column: 17)
!2134 = !DILocation(line: 1716, column: 23, scope: !2133)
!2135 = !DILocation(line: 1716, column: 17, scope: !2123)
!2136 = !DILocation(line: 1718, column: 62, scope: !2137)
!2137 = distinct !DILexicalBlock(scope: !2133, file: !36, line: 1717, column: 13)
!2138 = !DILocation(line: 1718, column: 27, scope: !2137)
!2139 = !DILocation(line: 1718, column: 25, scope: !2137)
!2140 = !DILocation(line: 1719, column: 13, scope: !2137)
!2141 = !DILocation(line: 1722, column: 38, scope: !2142)
!2142 = distinct !DILexicalBlock(scope: !2133, file: !36, line: 1721, column: 13)
!2143 = !DILocation(line: 1722, column: 26, scope: !2142)
!2144 = !DILocation(line: 1722, column: 24, scope: !2142)
!2145 = !DILocation(line: 1724, column: 21, scope: !2146)
!2146 = distinct !DILexicalBlock(scope: !2142, file: !36, line: 1724, column: 21)
!2147 = !DILocation(line: 0, scope: !2146)
!2148 = !DILocation(line: 1724, column: 55, scope: !2146)
!2149 = !DILocation(line: 1724, column: 21, scope: !2142)
!2150 = !DILocation(line: 1726, column: 43, scope: !2151)
!2151 = distinct !DILexicalBlock(scope: !2146, file: !36, line: 1725, column: 17)
!2152 = !DILocation(line: 1726, column: 41, scope: !2151)
!2153 = !DILocation(line: 1728, column: 25, scope: !2154)
!2154 = distinct !DILexicalBlock(scope: !2151, file: !36, line: 1728, column: 25)
!2155 = !DILocation(line: 1728, column: 45, scope: !2154)
!2156 = !DILocation(line: 1728, column: 25, scope: !2151)
!2157 = !DILocation(line: 1730, column: 70, scope: !2158)
!2158 = distinct !DILexicalBlock(scope: !2154, file: !36, line: 1729, column: 21)
!2159 = !DILocation(line: 1730, column: 35, scope: !2158)
!2160 = !DILocation(line: 1730, column: 33, scope: !2158)
!2161 = !DILocation(line: 1731, column: 21, scope: !2158)
!2162 = !DILocation(line: 1732, column: 17, scope: !2151)
!2163 = !DILocation(line: 1735, column: 20, scope: !2123)
!2164 = !DILocation(line: 1735, column: 13, scope: !2123)
!2165 = distinct !DISubprogram(name: "MPU_xTaskGenericNotifyFromISR", scope: !36, file: !36, line: 1743, type: !2166, scopeLine: 1749, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!2166 = !DISubroutineType(types: !2167)
!2167 = !{!23, !32, !39, !47, !1148, !867, !2168}
!2168 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
!2169 = !DILocalVariable(name: "xTaskToNotify", arg: 1, scope: !2165, file: !36, line: 1743, type: !32)
!2170 = !DILocation(line: 1743, column: 64, scope: !2165)
!2171 = !DILocalVariable(name: "uxIndexToNotify", arg: 2, scope: !2165, file: !36, line: 1744, type: !39)
!2172 = !DILocation(line: 1744, column: 63, scope: !2165)
!2173 = !DILocalVariable(name: "ulValue", arg: 3, scope: !2165, file: !36, line: 1745, type: !47)
!2174 = !DILocation(line: 1745, column: 60, scope: !2165)
!2175 = !DILocalVariable(name: "eAction", arg: 4, scope: !2165, file: !36, line: 1746, type: !1148)
!2176 = !DILocation(line: 1746, column: 65, scope: !2165)
!2177 = !DILocalVariable(name: "pulPreviousNotificationValue", arg: 5, scope: !2165, file: !36, line: 1747, type: !867)
!2178 = !DILocation(line: 1747, column: 62, scope: !2165)
!2179 = !DILocalVariable(name: "pxHigherPriorityTaskWoken", arg: 6, scope: !2165, file: !36, line: 1748, type: !2168)
!2180 = !DILocation(line: 1748, column: 64, scope: !2165)
!2181 = !DILocalVariable(name: "xReturn", scope: !2165, file: !36, line: 1750, type: !23)
!2182 = !DILocation(line: 1750, column: 24, scope: !2165)
!2183 = !DILocalVariable(name: "lIndex", scope: !2165, file: !36, line: 1751, type: !27)
!2184 = !DILocation(line: 1751, column: 21, scope: !2165)
!2185 = !DILocalVariable(name: "xInternalTaskHandle", scope: !2165, file: !36, line: 1752, type: !32)
!2186 = !DILocation(line: 1752, column: 26, scope: !2165)
!2187 = !DILocation(line: 1754, column: 34, scope: !2165)
!2188 = !DILocation(line: 1754, column: 22, scope: !2165)
!2189 = !DILocation(line: 1754, column: 20, scope: !2165)
!2190 = !DILocation(line: 1756, column: 17, scope: !2191)
!2191 = distinct !DILexicalBlock(scope: !2165, file: !36, line: 1756, column: 17)
!2192 = !DILocation(line: 0, scope: !2191)
!2193 = !DILocation(line: 1756, column: 51, scope: !2191)
!2194 = !DILocation(line: 1756, column: 17, scope: !2165)
!2195 = !DILocation(line: 1758, column: 39, scope: !2196)
!2196 = distinct !DILexicalBlock(scope: !2191, file: !36, line: 1757, column: 13)
!2197 = !DILocation(line: 1758, column: 37, scope: !2196)
!2198 = !DILocation(line: 1760, column: 21, scope: !2199)
!2199 = distinct !DILexicalBlock(scope: !2196, file: !36, line: 1760, column: 21)
!2200 = !DILocation(line: 1760, column: 41, scope: !2199)
!2201 = !DILocation(line: 1760, column: 21, scope: !2196)
!2202 = !DILocation(line: 1762, column: 58, scope: !2203)
!2203 = distinct !DILexicalBlock(scope: !2199, file: !36, line: 1761, column: 17)
!2204 = !DILocation(line: 1762, column: 79, scope: !2203)
!2205 = !DILocation(line: 1762, column: 96, scope: !2203)
!2206 = !DILocation(line: 1762, column: 105, scope: !2203)
!2207 = !DILocation(line: 1762, column: 114, scope: !2203)
!2208 = !DILocation(line: 1762, column: 144, scope: !2203)
!2209 = !DILocation(line: 1762, column: 31, scope: !2203)
!2210 = !DILocation(line: 1762, column: 29, scope: !2203)
!2211 = !DILocation(line: 1763, column: 17, scope: !2203)
!2212 = !DILocation(line: 1764, column: 13, scope: !2196)
!2213 = !DILocation(line: 1766, column: 20, scope: !2165)
!2214 = !DILocation(line: 1766, column: 13, scope: !2165)
!2215 = distinct !DISubprogram(name: "MPU_vTaskGenericNotifyGiveFromISR", scope: !36, file: !36, line: 1774, type: !2216, scopeLine: 1777, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!2216 = !DISubroutineType(types: !2217)
!2217 = !{null, !32, !39, !2168}
!2218 = !DILocalVariable(name: "xTaskToNotify", arg: 1, scope: !2215, file: !36, line: 1774, type: !32)
!2219 = !DILocation(line: 1774, column: 62, scope: !2215)
!2220 = !DILocalVariable(name: "uxIndexToNotify", arg: 2, scope: !2215, file: !36, line: 1775, type: !39)
!2221 = !DILocation(line: 1775, column: 61, scope: !2215)
!2222 = !DILocalVariable(name: "pxHigherPriorityTaskWoken", arg: 3, scope: !2215, file: !36, line: 1776, type: !2168)
!2223 = !DILocation(line: 1776, column: 62, scope: !2215)
!2224 = !DILocalVariable(name: "lIndex", scope: !2215, file: !36, line: 1778, type: !27)
!2225 = !DILocation(line: 1778, column: 21, scope: !2215)
!2226 = !DILocalVariable(name: "xInternalTaskHandle", scope: !2215, file: !36, line: 1779, type: !32)
!2227 = !DILocation(line: 1779, column: 26, scope: !2215)
!2228 = !DILocation(line: 1781, column: 34, scope: !2215)
!2229 = !DILocation(line: 1781, column: 22, scope: !2215)
!2230 = !DILocation(line: 1781, column: 20, scope: !2215)
!2231 = !DILocation(line: 1783, column: 17, scope: !2232)
!2232 = distinct !DILexicalBlock(scope: !2215, file: !36, line: 1783, column: 17)
!2233 = !DILocation(line: 0, scope: !2232)
!2234 = !DILocation(line: 1783, column: 51, scope: !2232)
!2235 = !DILocation(line: 1783, column: 17, scope: !2215)
!2236 = !DILocation(line: 1785, column: 39, scope: !2237)
!2237 = distinct !DILexicalBlock(scope: !2232, file: !36, line: 1784, column: 13)
!2238 = !DILocation(line: 1785, column: 37, scope: !2237)
!2239 = !DILocation(line: 1787, column: 21, scope: !2240)
!2240 = distinct !DILexicalBlock(scope: !2237, file: !36, line: 1787, column: 21)
!2241 = !DILocation(line: 1787, column: 41, scope: !2240)
!2242 = !DILocation(line: 1787, column: 21, scope: !2237)
!2243 = !DILocation(line: 1789, column: 52, scope: !2244)
!2244 = distinct !DILexicalBlock(scope: !2240, file: !36, line: 1788, column: 17)
!2245 = !DILocation(line: 1789, column: 73, scope: !2244)
!2246 = !DILocation(line: 1789, column: 90, scope: !2244)
!2247 = !DILocation(line: 1789, column: 21, scope: !2244)
!2248 = !DILocation(line: 1790, column: 17, scope: !2244)
!2249 = !DILocation(line: 1791, column: 13, scope: !2237)
!2250 = !DILocation(line: 1792, column: 9, scope: !2215)
!2251 = distinct !DISubprogram(name: "MPU_xQueueGenericSendImpl", scope: !36, file: !36, line: 1805, type: !2252, scopeLine: 1809, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!2252 = !DISubroutineType(types: !2253)
!2253 = !{!23, !41, !2254, !119, !23}
!2254 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2255)
!2255 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2256, size: 64)
!2256 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!2257 = !DILocalVariable(name: "xQueue", arg: 1, scope: !2251, file: !36, line: 1805, type: !41)
!2258 = !DILocation(line: 1805, column: 57, scope: !2251)
!2259 = !DILocalVariable(name: "pvItemToQueue", arg: 2, scope: !2251, file: !36, line: 1806, type: !2254)
!2260 = !DILocation(line: 1806, column: 62, scope: !2251)
!2261 = !DILocalVariable(name: "xTicksToWait", arg: 3, scope: !2251, file: !36, line: 1807, type: !119)
!2262 = !DILocation(line: 1807, column: 54, scope: !2251)
!2263 = !DILocalVariable(name: "xCopyPosition", arg: 4, scope: !2251, file: !36, line: 1808, type: !23)
!2264 = !DILocation(line: 1808, column: 54, scope: !2251)
!2265 = !DILocalVariable(name: "lIndex", scope: !2251, file: !36, line: 1810, type: !27)
!2266 = !DILocation(line: 1810, column: 17, scope: !2251)
!2267 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2251, file: !36, line: 1811, type: !41)
!2268 = !DILocation(line: 1811, column: 23, scope: !2251)
!2269 = !DILocalVariable(name: "xReturn", scope: !2251, file: !36, line: 1812, type: !23)
!2270 = !DILocation(line: 1812, column: 20, scope: !2251)
!2271 = !DILocalVariable(name: "xIsItemToQueueReadable", scope: !2251, file: !36, line: 1813, type: !23)
!2272 = !DILocation(line: 1813, column: 20, scope: !2251)
!2273 = !DILocation(line: 1815, column: 30, scope: !2251)
!2274 = !DILocation(line: 1815, column: 18, scope: !2251)
!2275 = !DILocation(line: 1815, column: 16, scope: !2251)
!2276 = !DILocation(line: 1817, column: 13, scope: !2277)
!2277 = distinct !DILexicalBlock(scope: !2251, file: !36, line: 1817, column: 13)
!2278 = !DILocation(line: 0, scope: !2277)
!2279 = !DILocation(line: 1817, column: 47, scope: !2277)
!2280 = !DILocation(line: 1817, column: 13, scope: !2251)
!2281 = !DILocation(line: 1819, column: 36, scope: !2282)
!2282 = distinct !DILexicalBlock(scope: !2277, file: !36, line: 1818, column: 9)
!2283 = !DILocation(line: 1819, column: 34, scope: !2282)
!2284 = !DILocation(line: 1821, column: 17, scope: !2285)
!2285 = distinct !DILexicalBlock(scope: !2282, file: !36, line: 1821, column: 17)
!2286 = !DILocation(line: 1821, column: 38, scope: !2285)
!2287 = !DILocation(line: 1821, column: 17, scope: !2282)
!2288 = !DILocation(line: 1823, column: 21, scope: !2289)
!2289 = distinct !DILexicalBlock(scope: !2290, file: !36, line: 1823, column: 21)
!2290 = distinct !DILexicalBlock(scope: !2285, file: !36, line: 1822, column: 13)
!2291 = !DILocation(line: 1823, column: 35, scope: !2289)
!2292 = !DILocation(line: 1823, column: 21, scope: !2290)
!2293 = !DILocation(line: 1825, column: 79, scope: !2294)
!2294 = distinct !DILexicalBlock(scope: !2289, file: !36, line: 1824, column: 17)
!2295 = !DILocation(line: 1826, column: 104, scope: !2294)
!2296 = !DILocation(line: 1826, column: 79, scope: !2294)
!2297 = !DILocation(line: 1825, column: 46, scope: !2294)
!2298 = !DILocation(line: 1825, column: 44, scope: !2294)
!2299 = !DILocation(line: 1828, column: 17, scope: !2294)
!2300 = !DILocation(line: 1830, column: 23, scope: !2301)
!2301 = distinct !DILexicalBlock(scope: !2290, file: !36, line: 1830, column: 21)
!2302 = !DILocation(line: 1830, column: 37, scope: !2301)
!2303 = !DILocation(line: 1830, column: 47, scope: !2301)
!2304 = !DILocation(line: 1830, column: 52, scope: !2301)
!2305 = !DILocation(line: 1830, column: 75, scope: !2301)
!2306 = !DILocation(line: 1830, column: 21, scope: !2290)
!2307 = !DILocation(line: 1832, column: 50, scope: !2308)
!2308 = distinct !DILexicalBlock(scope: !2301, file: !36, line: 1831, column: 17)
!2309 = !DILocation(line: 1832, column: 72, scope: !2308)
!2310 = !DILocation(line: 1832, column: 87, scope: !2308)
!2311 = !DILocation(line: 1832, column: 101, scope: !2308)
!2312 = !DILocation(line: 1832, column: 31, scope: !2308)
!2313 = !DILocation(line: 1832, column: 29, scope: !2308)
!2314 = !DILocation(line: 1833, column: 17, scope: !2308)
!2315 = !DILocation(line: 1834, column: 13, scope: !2290)
!2316 = !DILocation(line: 1835, column: 9, scope: !2282)
!2317 = !DILocation(line: 1837, column: 16, scope: !2251)
!2318 = !DILocation(line: 1837, column: 9, scope: !2251)
!2319 = distinct !DISubprogram(name: "MPU_uxQueueMessagesWaitingImpl", scope: !36, file: !36, line: 1843, type: !2320, scopeLine: 1844, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!2320 = !DISubroutineType(types: !2321)
!2321 = !{!39, !2322}
!2322 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !41)
!2323 = !DILocalVariable(name: "pxQueue", arg: 1, scope: !2319, file: !36, line: 1843, type: !2322)
!2324 = !DILocation(line: 1843, column: 69, scope: !2319)
!2325 = !DILocalVariable(name: "lIndex", scope: !2319, file: !36, line: 1845, type: !27)
!2326 = !DILocation(line: 1845, column: 17, scope: !2319)
!2327 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2319, file: !36, line: 1846, type: !41)
!2328 = !DILocation(line: 1846, column: 23, scope: !2319)
!2329 = !DILocalVariable(name: "uxReturn", scope: !2319, file: !36, line: 1847, type: !39)
!2330 = !DILocation(line: 1847, column: 21, scope: !2319)
!2331 = !DILocation(line: 1849, column: 30, scope: !2319)
!2332 = !DILocation(line: 1849, column: 18, scope: !2319)
!2333 = !DILocation(line: 1849, column: 16, scope: !2319)
!2334 = !DILocation(line: 1851, column: 13, scope: !2335)
!2335 = distinct !DILexicalBlock(scope: !2319, file: !36, line: 1851, column: 13)
!2336 = !DILocation(line: 0, scope: !2335)
!2337 = !DILocation(line: 1851, column: 47, scope: !2335)
!2338 = !DILocation(line: 1851, column: 13, scope: !2319)
!2339 = !DILocation(line: 1853, column: 36, scope: !2340)
!2340 = distinct !DILexicalBlock(scope: !2335, file: !36, line: 1852, column: 9)
!2341 = !DILocation(line: 1853, column: 34, scope: !2340)
!2342 = !DILocation(line: 1855, column: 17, scope: !2343)
!2343 = distinct !DILexicalBlock(scope: !2340, file: !36, line: 1855, column: 17)
!2344 = !DILocation(line: 1855, column: 38, scope: !2343)
!2345 = !DILocation(line: 1855, column: 17, scope: !2340)
!2346 = !DILocation(line: 1857, column: 52, scope: !2347)
!2347 = distinct !DILexicalBlock(scope: !2343, file: !36, line: 1856, column: 13)
!2348 = !DILocation(line: 1857, column: 28, scope: !2347)
!2349 = !DILocation(line: 1857, column: 26, scope: !2347)
!2350 = !DILocation(line: 1858, column: 13, scope: !2347)
!2351 = !DILocation(line: 1859, column: 9, scope: !2340)
!2352 = !DILocation(line: 1861, column: 16, scope: !2319)
!2353 = !DILocation(line: 1861, column: 9, scope: !2319)
!2354 = distinct !DISubprogram(name: "MPU_uxQueueSpacesAvailableImpl", scope: !36, file: !36, line: 1867, type: !2320, scopeLine: 1868, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!2355 = !DILocalVariable(name: "xQueue", arg: 1, scope: !2354, file: !36, line: 1867, type: !2322)
!2356 = !DILocation(line: 1867, column: 69, scope: !2354)
!2357 = !DILocalVariable(name: "lIndex", scope: !2354, file: !36, line: 1869, type: !27)
!2358 = !DILocation(line: 1869, column: 17, scope: !2354)
!2359 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2354, file: !36, line: 1870, type: !41)
!2360 = !DILocation(line: 1870, column: 23, scope: !2354)
!2361 = !DILocalVariable(name: "uxReturn", scope: !2354, file: !36, line: 1871, type: !39)
!2362 = !DILocation(line: 1871, column: 21, scope: !2354)
!2363 = !DILocation(line: 1873, column: 30, scope: !2354)
!2364 = !DILocation(line: 1873, column: 18, scope: !2354)
!2365 = !DILocation(line: 1873, column: 16, scope: !2354)
!2366 = !DILocation(line: 1875, column: 13, scope: !2367)
!2367 = distinct !DILexicalBlock(scope: !2354, file: !36, line: 1875, column: 13)
!2368 = !DILocation(line: 0, scope: !2367)
!2369 = !DILocation(line: 1875, column: 47, scope: !2367)
!2370 = !DILocation(line: 1875, column: 13, scope: !2354)
!2371 = !DILocation(line: 1877, column: 36, scope: !2372)
!2372 = distinct !DILexicalBlock(scope: !2367, file: !36, line: 1876, column: 9)
!2373 = !DILocation(line: 1877, column: 34, scope: !2372)
!2374 = !DILocation(line: 1879, column: 17, scope: !2375)
!2375 = distinct !DILexicalBlock(scope: !2372, file: !36, line: 1879, column: 17)
!2376 = !DILocation(line: 1879, column: 38, scope: !2375)
!2377 = !DILocation(line: 1879, column: 17, scope: !2372)
!2378 = !DILocation(line: 1881, column: 52, scope: !2379)
!2379 = distinct !DILexicalBlock(scope: !2375, file: !36, line: 1880, column: 13)
!2380 = !DILocation(line: 1881, column: 28, scope: !2379)
!2381 = !DILocation(line: 1881, column: 26, scope: !2379)
!2382 = !DILocation(line: 1882, column: 13, scope: !2379)
!2383 = !DILocation(line: 1883, column: 9, scope: !2372)
!2384 = !DILocation(line: 1885, column: 16, scope: !2354)
!2385 = !DILocation(line: 1885, column: 9, scope: !2354)
!2386 = distinct !DISubprogram(name: "MPU_xQueueReceiveImpl", scope: !36, file: !36, line: 1893, type: !2387, scopeLine: 1896, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!2387 = !DISubroutineType(types: !2388)
!2388 = !{!23, !41, !1543, !119}
!2389 = !DILocalVariable(name: "pxQueue", arg: 1, scope: !2386, file: !36, line: 1893, type: !41)
!2390 = !DILocation(line: 1893, column: 53, scope: !2386)
!2391 = !DILocalVariable(name: "pvBuffer", arg: 2, scope: !2386, file: !36, line: 1894, type: !1543)
!2392 = !DILocation(line: 1894, column: 52, scope: !2386)
!2393 = !DILocalVariable(name: "xTicksToWait", arg: 3, scope: !2386, file: !36, line: 1895, type: !119)
!2394 = !DILocation(line: 1895, column: 50, scope: !2386)
!2395 = !DILocalVariable(name: "lIndex", scope: !2386, file: !36, line: 1897, type: !27)
!2396 = !DILocation(line: 1897, column: 17, scope: !2386)
!2397 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2386, file: !36, line: 1898, type: !41)
!2398 = !DILocation(line: 1898, column: 23, scope: !2386)
!2399 = !DILocalVariable(name: "xReturn", scope: !2386, file: !36, line: 1899, type: !23)
!2400 = !DILocation(line: 1899, column: 20, scope: !2386)
!2401 = !DILocalVariable(name: "xIsReceiveBufferWritable", scope: !2386, file: !36, line: 1900, type: !23)
!2402 = !DILocation(line: 1900, column: 20, scope: !2386)
!2403 = !DILocation(line: 1902, column: 30, scope: !2386)
!2404 = !DILocation(line: 1902, column: 18, scope: !2386)
!2405 = !DILocation(line: 1902, column: 16, scope: !2386)
!2406 = !DILocation(line: 1904, column: 13, scope: !2407)
!2407 = distinct !DILexicalBlock(scope: !2386, file: !36, line: 1904, column: 13)
!2408 = !DILocation(line: 0, scope: !2407)
!2409 = !DILocation(line: 1904, column: 47, scope: !2407)
!2410 = !DILocation(line: 1904, column: 13, scope: !2386)
!2411 = !DILocation(line: 1906, column: 36, scope: !2412)
!2412 = distinct !DILexicalBlock(scope: !2407, file: !36, line: 1905, column: 9)
!2413 = !DILocation(line: 1906, column: 34, scope: !2412)
!2414 = !DILocation(line: 1908, column: 17, scope: !2415)
!2415 = distinct !DILexicalBlock(scope: !2412, file: !36, line: 1908, column: 17)
!2416 = !DILocation(line: 1908, column: 38, scope: !2415)
!2417 = !DILocation(line: 1908, column: 17, scope: !2412)
!2418 = !DILocation(line: 1910, column: 77, scope: !2419)
!2419 = distinct !DILexicalBlock(scope: !2415, file: !36, line: 1909, column: 13)
!2420 = !DILocation(line: 1911, column: 102, scope: !2419)
!2421 = !DILocation(line: 1911, column: 77, scope: !2419)
!2422 = !DILocation(line: 1910, column: 44, scope: !2419)
!2423 = !DILocation(line: 1910, column: 42, scope: !2419)
!2424 = !DILocation(line: 1914, column: 21, scope: !2425)
!2425 = distinct !DILexicalBlock(scope: !2419, file: !36, line: 1914, column: 21)
!2426 = !DILocation(line: 1914, column: 46, scope: !2425)
!2427 = !DILocation(line: 1914, column: 21, scope: !2419)
!2428 = !DILocation(line: 1916, column: 46, scope: !2429)
!2429 = distinct !DILexicalBlock(scope: !2425, file: !36, line: 1915, column: 17)
!2430 = !DILocation(line: 1916, column: 68, scope: !2429)
!2431 = !DILocation(line: 1916, column: 78, scope: !2429)
!2432 = !DILocation(line: 1916, column: 31, scope: !2429)
!2433 = !DILocation(line: 1916, column: 29, scope: !2429)
!2434 = !DILocation(line: 1917, column: 17, scope: !2429)
!2435 = !DILocation(line: 1918, column: 13, scope: !2419)
!2436 = !DILocation(line: 1919, column: 9, scope: !2412)
!2437 = !DILocation(line: 1921, column: 16, scope: !2386)
!2438 = !DILocation(line: 1921, column: 9, scope: !2386)
!2439 = distinct !DISubprogram(name: "MPU_xQueuePeekImpl", scope: !36, file: !36, line: 1929, type: !2387, scopeLine: 1932, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!2440 = !DILocalVariable(name: "xQueue", arg: 1, scope: !2439, file: !36, line: 1929, type: !41)
!2441 = !DILocation(line: 1929, column: 50, scope: !2439)
!2442 = !DILocalVariable(name: "pvBuffer", arg: 2, scope: !2439, file: !36, line: 1930, type: !1543)
!2443 = !DILocation(line: 1930, column: 49, scope: !2439)
!2444 = !DILocalVariable(name: "xTicksToWait", arg: 3, scope: !2439, file: !36, line: 1931, type: !119)
!2445 = !DILocation(line: 1931, column: 47, scope: !2439)
!2446 = !DILocalVariable(name: "lIndex", scope: !2439, file: !36, line: 1933, type: !27)
!2447 = !DILocation(line: 1933, column: 17, scope: !2439)
!2448 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2439, file: !36, line: 1934, type: !41)
!2449 = !DILocation(line: 1934, column: 23, scope: !2439)
!2450 = !DILocalVariable(name: "xReturn", scope: !2439, file: !36, line: 1935, type: !23)
!2451 = !DILocation(line: 1935, column: 20, scope: !2439)
!2452 = !DILocalVariable(name: "xIsReceiveBufferWritable", scope: !2439, file: !36, line: 1936, type: !23)
!2453 = !DILocation(line: 1936, column: 20, scope: !2439)
!2454 = !DILocation(line: 1938, column: 30, scope: !2439)
!2455 = !DILocation(line: 1938, column: 18, scope: !2439)
!2456 = !DILocation(line: 1938, column: 16, scope: !2439)
!2457 = !DILocation(line: 1940, column: 13, scope: !2458)
!2458 = distinct !DILexicalBlock(scope: !2439, file: !36, line: 1940, column: 13)
!2459 = !DILocation(line: 0, scope: !2458)
!2460 = !DILocation(line: 1940, column: 47, scope: !2458)
!2461 = !DILocation(line: 1940, column: 13, scope: !2439)
!2462 = !DILocation(line: 1942, column: 36, scope: !2463)
!2463 = distinct !DILexicalBlock(scope: !2458, file: !36, line: 1941, column: 9)
!2464 = !DILocation(line: 1942, column: 34, scope: !2463)
!2465 = !DILocation(line: 1944, column: 17, scope: !2466)
!2466 = distinct !DILexicalBlock(scope: !2463, file: !36, line: 1944, column: 17)
!2467 = !DILocation(line: 1944, column: 38, scope: !2466)
!2468 = !DILocation(line: 1944, column: 17, scope: !2463)
!2469 = !DILocation(line: 1946, column: 77, scope: !2470)
!2470 = distinct !DILexicalBlock(scope: !2466, file: !36, line: 1945, column: 13)
!2471 = !DILocation(line: 1947, column: 102, scope: !2470)
!2472 = !DILocation(line: 1947, column: 77, scope: !2470)
!2473 = !DILocation(line: 1946, column: 44, scope: !2470)
!2474 = !DILocation(line: 1946, column: 42, scope: !2470)
!2475 = !DILocation(line: 1950, column: 21, scope: !2476)
!2476 = distinct !DILexicalBlock(scope: !2470, file: !36, line: 1950, column: 21)
!2477 = !DILocation(line: 1950, column: 46, scope: !2476)
!2478 = !DILocation(line: 1950, column: 21, scope: !2470)
!2479 = !DILocation(line: 1952, column: 43, scope: !2480)
!2480 = distinct !DILexicalBlock(scope: !2476, file: !36, line: 1951, column: 17)
!2481 = !DILocation(line: 1952, column: 65, scope: !2480)
!2482 = !DILocation(line: 1952, column: 75, scope: !2480)
!2483 = !DILocation(line: 1952, column: 31, scope: !2480)
!2484 = !DILocation(line: 1952, column: 29, scope: !2480)
!2485 = !DILocation(line: 1953, column: 17, scope: !2480)
!2486 = !DILocation(line: 1954, column: 13, scope: !2470)
!2487 = !DILocation(line: 1955, column: 9, scope: !2463)
!2488 = !DILocation(line: 1957, column: 16, scope: !2439)
!2489 = !DILocation(line: 1957, column: 9, scope: !2439)
!2490 = distinct !DISubprogram(name: "MPU_xQueueSemaphoreTakeImpl", scope: !36, file: !36, line: 1964, type: !2491, scopeLine: 1966, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!2491 = !DISubroutineType(types: !2492)
!2492 = !{!23, !41, !119}
!2493 = !DILocalVariable(name: "xQueue", arg: 1, scope: !2490, file: !36, line: 1964, type: !41)
!2494 = !DILocation(line: 1964, column: 59, scope: !2490)
!2495 = !DILocalVariable(name: "xTicksToWait", arg: 2, scope: !2490, file: !36, line: 1965, type: !119)
!2496 = !DILocation(line: 1965, column: 56, scope: !2490)
!2497 = !DILocalVariable(name: "lIndex", scope: !2490, file: !36, line: 1967, type: !27)
!2498 = !DILocation(line: 1967, column: 17, scope: !2490)
!2499 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2490, file: !36, line: 1968, type: !41)
!2500 = !DILocation(line: 1968, column: 23, scope: !2490)
!2501 = !DILocalVariable(name: "xReturn", scope: !2490, file: !36, line: 1969, type: !23)
!2502 = !DILocation(line: 1969, column: 20, scope: !2490)
!2503 = !DILocation(line: 1971, column: 30, scope: !2490)
!2504 = !DILocation(line: 1971, column: 18, scope: !2490)
!2505 = !DILocation(line: 1971, column: 16, scope: !2490)
!2506 = !DILocation(line: 1973, column: 13, scope: !2507)
!2507 = distinct !DILexicalBlock(scope: !2490, file: !36, line: 1973, column: 13)
!2508 = !DILocation(line: 0, scope: !2507)
!2509 = !DILocation(line: 1973, column: 47, scope: !2507)
!2510 = !DILocation(line: 1973, column: 13, scope: !2490)
!2511 = !DILocation(line: 1975, column: 36, scope: !2512)
!2512 = distinct !DILexicalBlock(scope: !2507, file: !36, line: 1974, column: 9)
!2513 = !DILocation(line: 1975, column: 34, scope: !2512)
!2514 = !DILocation(line: 1977, column: 17, scope: !2515)
!2515 = distinct !DILexicalBlock(scope: !2512, file: !36, line: 1977, column: 17)
!2516 = !DILocation(line: 1977, column: 38, scope: !2515)
!2517 = !DILocation(line: 1977, column: 17, scope: !2512)
!2518 = !DILocation(line: 1979, column: 48, scope: !2519)
!2519 = distinct !DILexicalBlock(scope: !2515, file: !36, line: 1978, column: 13)
!2520 = !DILocation(line: 1979, column: 70, scope: !2519)
!2521 = !DILocation(line: 1979, column: 27, scope: !2519)
!2522 = !DILocation(line: 1979, column: 25, scope: !2519)
!2523 = !DILocation(line: 1980, column: 13, scope: !2519)
!2524 = !DILocation(line: 1981, column: 9, scope: !2512)
!2525 = !DILocation(line: 1983, column: 16, scope: !2490)
!2526 = !DILocation(line: 1983, column: 9, scope: !2490)
!2527 = distinct !DISubprogram(name: "MPU_xQueueSelectFromSetImpl", scope: !36, file: !36, line: 2090, type: !2528, scopeLine: 2092, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!2528 = !DISubroutineType(types: !2529)
!2529 = !{!46, !45, !119}
!2530 = !DILocalVariable(name: "xQueueSet", arg: 1, scope: !2527, file: !36, line: 2090, type: !45)
!2531 = !DILocation(line: 2090, column: 78, scope: !2527)
!2532 = !DILocalVariable(name: "xBlockTimeTicks", arg: 2, scope: !2527, file: !36, line: 2091, type: !119)
!2533 = !DILocation(line: 2091, column: 72, scope: !2527)
!2534 = !DILocalVariable(name: "xInternalQueueSetHandle", scope: !2527, file: !36, line: 2093, type: !45)
!2535 = !DILocation(line: 2093, column: 30, scope: !2527)
!2536 = !DILocalVariable(name: "xSelectedMemberInternal", scope: !2527, file: !36, line: 2094, type: !46)
!2537 = !DILocation(line: 2094, column: 36, scope: !2527)
!2538 = !DILocalVariable(name: "xSelectedMemberExternal", scope: !2527, file: !36, line: 2095, type: !46)
!2539 = !DILocation(line: 2095, column: 36, scope: !2527)
!2540 = !DILocalVariable(name: "lIndexQueueSet", scope: !2527, file: !36, line: 2096, type: !27)
!2541 = !DILocation(line: 2096, column: 21, scope: !2527)
!2542 = !DILocalVariable(name: "lIndexSelectedMember", scope: !2527, file: !36, line: 2096, type: !27)
!2543 = !DILocation(line: 2096, column: 37, scope: !2527)
!2544 = !DILocation(line: 2098, column: 42, scope: !2527)
!2545 = !DILocation(line: 2098, column: 30, scope: !2527)
!2546 = !DILocation(line: 2098, column: 28, scope: !2527)
!2547 = !DILocation(line: 2100, column: 17, scope: !2548)
!2548 = distinct !DILexicalBlock(scope: !2527, file: !36, line: 2100, column: 17)
!2549 = !DILocation(line: 0, scope: !2548)
!2550 = !DILocation(line: 2100, column: 59, scope: !2548)
!2551 = !DILocation(line: 2100, column: 17, scope: !2527)
!2552 = !DILocation(line: 2102, column: 43, scope: !2553)
!2553 = distinct !DILexicalBlock(scope: !2548, file: !36, line: 2101, column: 13)
!2554 = !DILocation(line: 2102, column: 41, scope: !2553)
!2555 = !DILocation(line: 2104, column: 21, scope: !2556)
!2556 = distinct !DILexicalBlock(scope: !2553, file: !36, line: 2104, column: 21)
!2557 = !DILocation(line: 2104, column: 45, scope: !2556)
!2558 = !DILocation(line: 2104, column: 21, scope: !2553)
!2559 = !DILocation(line: 2106, column: 68, scope: !2560)
!2560 = distinct !DILexicalBlock(scope: !2556, file: !36, line: 2105, column: 17)
!2561 = !DILocation(line: 2106, column: 93, scope: !2560)
!2562 = !DILocation(line: 2106, column: 47, scope: !2560)
!2563 = !DILocation(line: 2106, column: 45, scope: !2560)
!2564 = !DILocation(line: 2108, column: 25, scope: !2565)
!2565 = distinct !DILexicalBlock(scope: !2560, file: !36, line: 2108, column: 25)
!2566 = !DILocation(line: 2108, column: 49, scope: !2565)
!2567 = !DILocation(line: 2108, column: 25, scope: !2560)
!2568 = !DILocation(line: 2110, column: 48, scope: !2569)
!2569 = distinct !DILexicalBlock(scope: !2565, file: !36, line: 2109, column: 21)
!2570 = !DILocation(line: 2110, column: 46, scope: !2569)
!2571 = !DILocation(line: 2112, column: 29, scope: !2572)
!2572 = distinct !DILexicalBlock(scope: !2569, file: !36, line: 2112, column: 29)
!2573 = !DILocation(line: 2112, column: 50, scope: !2572)
!2574 = !DILocation(line: 2112, column: 29, scope: !2569)
!2575 = !DILocation(line: 2114, column: 84, scope: !2576)
!2576 = distinct !DILexicalBlock(scope: !2572, file: !36, line: 2113, column: 25)
!2577 = !DILocation(line: 2114, column: 55, scope: !2576)
!2578 = !DILocation(line: 2114, column: 53, scope: !2576)
!2579 = !DILocation(line: 2115, column: 25, scope: !2576)
!2580 = !DILocation(line: 2116, column: 21, scope: !2569)
!2581 = !DILocation(line: 2117, column: 17, scope: !2560)
!2582 = !DILocation(line: 2118, column: 13, scope: !2553)
!2583 = !DILocation(line: 2120, column: 20, scope: !2527)
!2584 = !DILocation(line: 2120, column: 13, scope: !2527)
!2585 = distinct !DISubprogram(name: "MPU_xQueueAddToSetImpl", scope: !36, file: !36, line: 2131, type: !2586, scopeLine: 2133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!2586 = !DISubroutineType(types: !2587)
!2587 = !{!23, !46, !45}
!2588 = !DILocalVariable(name: "xQueueOrSemaphore", arg: 1, scope: !2585, file: !36, line: 2131, type: !46)
!2589 = !DILocation(line: 2131, column: 67, scope: !2585)
!2590 = !DILocalVariable(name: "xQueueSet", arg: 2, scope: !2585, file: !36, line: 2132, type: !45)
!2591 = !DILocation(line: 2132, column: 61, scope: !2585)
!2592 = !DILocalVariable(name: "xReturn", scope: !2585, file: !36, line: 2134, type: !23)
!2593 = !DILocation(line: 2134, column: 24, scope: !2585)
!2594 = !DILocalVariable(name: "xInternalQueueSetMemberHandle", scope: !2585, file: !36, line: 2135, type: !46)
!2595 = !DILocation(line: 2135, column: 36, scope: !2585)
!2596 = !DILocalVariable(name: "xInternalQueueSetHandle", scope: !2585, file: !36, line: 2136, type: !45)
!2597 = !DILocation(line: 2136, column: 30, scope: !2585)
!2598 = !DILocalVariable(name: "lIndexQueueSet", scope: !2585, file: !36, line: 2137, type: !27)
!2599 = !DILocation(line: 2137, column: 21, scope: !2585)
!2600 = !DILocalVariable(name: "lIndexQueueSetMember", scope: !2585, file: !36, line: 2137, type: !27)
!2601 = !DILocation(line: 2137, column: 37, scope: !2585)
!2602 = !DILocation(line: 2139, column: 42, scope: !2585)
!2603 = !DILocation(line: 2139, column: 30, scope: !2585)
!2604 = !DILocation(line: 2139, column: 28, scope: !2585)
!2605 = !DILocation(line: 2140, column: 48, scope: !2585)
!2606 = !DILocation(line: 2140, column: 36, scope: !2585)
!2607 = !DILocation(line: 2140, column: 34, scope: !2585)
!2608 = !DILocation(line: 2142, column: 19, scope: !2609)
!2609 = distinct !DILexicalBlock(scope: !2585, file: !36, line: 2142, column: 17)
!2610 = !DILocation(line: 0, scope: !2609)
!2611 = !DILocation(line: 2142, column: 61, scope: !2609)
!2612 = !DILocation(line: 2142, column: 74, scope: !2609)
!2613 = !DILocation(line: 2143, column: 19, scope: !2609)
!2614 = !DILocation(line: 2143, column: 67, scope: !2609)
!2615 = !DILocation(line: 2142, column: 17, scope: !2585)
!2616 = !DILocation(line: 2145, column: 43, scope: !2617)
!2617 = distinct !DILexicalBlock(scope: !2609, file: !36, line: 2144, column: 13)
!2618 = !DILocation(line: 2145, column: 41, scope: !2617)
!2619 = !DILocation(line: 2146, column: 49, scope: !2617)
!2620 = !DILocation(line: 2146, column: 47, scope: !2617)
!2621 = !DILocation(line: 2148, column: 23, scope: !2622)
!2622 = distinct !DILexicalBlock(scope: !2617, file: !36, line: 2148, column: 21)
!2623 = !DILocation(line: 2148, column: 47, scope: !2622)
!2624 = !DILocation(line: 2148, column: 57, scope: !2622)
!2625 = !DILocation(line: 2148, column: 62, scope: !2622)
!2626 = !DILocation(line: 2148, column: 92, scope: !2622)
!2627 = !DILocation(line: 2148, column: 21, scope: !2617)
!2628 = !DILocation(line: 2150, column: 47, scope: !2629)
!2629 = distinct !DILexicalBlock(scope: !2622, file: !36, line: 2149, column: 17)
!2630 = !DILocation(line: 2150, column: 78, scope: !2629)
!2631 = !DILocation(line: 2150, column: 31, scope: !2629)
!2632 = !DILocation(line: 2150, column: 29, scope: !2629)
!2633 = !DILocation(line: 2151, column: 17, scope: !2629)
!2634 = !DILocation(line: 2152, column: 13, scope: !2617)
!2635 = !DILocation(line: 2154, column: 20, scope: !2585)
!2636 = !DILocation(line: 2154, column: 13, scope: !2585)
!2637 = distinct !DISubprogram(name: "MPU_vQueueAddToRegistryImpl", scope: !36, file: !36, line: 2165, type: !2638, scopeLine: 2167, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!2638 = !DISubroutineType(types: !2639)
!2639 = !{null, !41, !356}
!2640 = !DILocalVariable(name: "xQueue", arg: 1, scope: !2637, file: !36, line: 2165, type: !41)
!2641 = !DILocation(line: 2165, column: 57, scope: !2637)
!2642 = !DILocalVariable(name: "pcName", arg: 2, scope: !2637, file: !36, line: 2166, type: !356)
!2643 = !DILocation(line: 2166, column: 56, scope: !2637)
!2644 = !DILocalVariable(name: "lIndex", scope: !2637, file: !36, line: 2168, type: !27)
!2645 = !DILocation(line: 2168, column: 21, scope: !2637)
!2646 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2637, file: !36, line: 2169, type: !41)
!2647 = !DILocation(line: 2169, column: 27, scope: !2637)
!2648 = !DILocation(line: 2171, column: 34, scope: !2637)
!2649 = !DILocation(line: 2171, column: 22, scope: !2637)
!2650 = !DILocation(line: 2171, column: 20, scope: !2637)
!2651 = !DILocation(line: 2173, column: 17, scope: !2652)
!2652 = distinct !DILexicalBlock(scope: !2637, file: !36, line: 2173, column: 17)
!2653 = !DILocation(line: 0, scope: !2652)
!2654 = !DILocation(line: 2173, column: 51, scope: !2652)
!2655 = !DILocation(line: 2173, column: 17, scope: !2637)
!2656 = !DILocation(line: 2175, column: 40, scope: !2657)
!2657 = distinct !DILexicalBlock(scope: !2652, file: !36, line: 2174, column: 13)
!2658 = !DILocation(line: 2175, column: 38, scope: !2657)
!2659 = !DILocation(line: 2177, column: 21, scope: !2660)
!2660 = distinct !DILexicalBlock(scope: !2657, file: !36, line: 2177, column: 21)
!2661 = !DILocation(line: 2177, column: 42, scope: !2660)
!2662 = !DILocation(line: 2177, column: 21, scope: !2657)
!2663 = !DILocation(line: 2179, column: 42, scope: !2664)
!2664 = distinct !DILexicalBlock(scope: !2660, file: !36, line: 2178, column: 17)
!2665 = !DILocation(line: 2179, column: 64, scope: !2664)
!2666 = !DILocation(line: 2179, column: 21, scope: !2664)
!2667 = !DILocation(line: 2180, column: 17, scope: !2664)
!2668 = !DILocation(line: 2181, column: 13, scope: !2657)
!2669 = !DILocation(line: 2182, column: 9, scope: !2637)
!2670 = distinct !DISubprogram(name: "MPU_vQueueUnregisterQueueImpl", scope: !36, file: !36, line: 2191, type: !2671, scopeLine: 2192, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!2671 = !DISubroutineType(types: !2672)
!2672 = !{null, !41}
!2673 = !DILocalVariable(name: "xQueue", arg: 1, scope: !2670, file: !36, line: 2191, type: !41)
!2674 = !DILocation(line: 2191, column: 59, scope: !2670)
!2675 = !DILocalVariable(name: "lIndex", scope: !2670, file: !36, line: 2193, type: !27)
!2676 = !DILocation(line: 2193, column: 21, scope: !2670)
!2677 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2670, file: !36, line: 2194, type: !41)
!2678 = !DILocation(line: 2194, column: 27, scope: !2670)
!2679 = !DILocation(line: 2196, column: 34, scope: !2670)
!2680 = !DILocation(line: 2196, column: 22, scope: !2670)
!2681 = !DILocation(line: 2196, column: 20, scope: !2670)
!2682 = !DILocation(line: 2198, column: 17, scope: !2683)
!2683 = distinct !DILexicalBlock(scope: !2670, file: !36, line: 2198, column: 17)
!2684 = !DILocation(line: 0, scope: !2683)
!2685 = !DILocation(line: 2198, column: 51, scope: !2683)
!2686 = !DILocation(line: 2198, column: 17, scope: !2670)
!2687 = !DILocation(line: 2200, column: 40, scope: !2688)
!2688 = distinct !DILexicalBlock(scope: !2683, file: !36, line: 2199, column: 13)
!2689 = !DILocation(line: 2200, column: 38, scope: !2688)
!2690 = !DILocation(line: 2202, column: 21, scope: !2691)
!2691 = distinct !DILexicalBlock(scope: !2688, file: !36, line: 2202, column: 21)
!2692 = !DILocation(line: 2202, column: 42, scope: !2691)
!2693 = !DILocation(line: 2202, column: 21, scope: !2688)
!2694 = !DILocation(line: 2204, column: 44, scope: !2695)
!2695 = distinct !DILexicalBlock(scope: !2691, file: !36, line: 2203, column: 17)
!2696 = !DILocation(line: 2204, column: 21, scope: !2695)
!2697 = !DILocation(line: 2205, column: 17, scope: !2695)
!2698 = !DILocation(line: 2206, column: 13, scope: !2688)
!2699 = !DILocation(line: 2207, column: 9, scope: !2670)
!2700 = distinct !DISubprogram(name: "MPU_pcQueueGetNameImpl", scope: !36, file: !36, line: 2216, type: !2701, scopeLine: 2217, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!2701 = !DISubroutineType(types: !2702)
!2702 = !{!356, !41}
!2703 = !DILocalVariable(name: "xQueue", arg: 1, scope: !2700, file: !36, line: 2216, type: !41)
!2704 = !DILocation(line: 2216, column: 60, scope: !2700)
!2705 = !DILocalVariable(name: "pcReturn", scope: !2700, file: !36, line: 2218, type: !356)
!2706 = !DILocation(line: 2218, column: 26, scope: !2700)
!2707 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2700, file: !36, line: 2219, type: !41)
!2708 = !DILocation(line: 2219, column: 27, scope: !2700)
!2709 = !DILocalVariable(name: "lIndex", scope: !2700, file: !36, line: 2220, type: !27)
!2710 = !DILocation(line: 2220, column: 21, scope: !2700)
!2711 = !DILocation(line: 2222, column: 34, scope: !2700)
!2712 = !DILocation(line: 2222, column: 22, scope: !2700)
!2713 = !DILocation(line: 2222, column: 20, scope: !2700)
!2714 = !DILocation(line: 2224, column: 17, scope: !2715)
!2715 = distinct !DILexicalBlock(scope: !2700, file: !36, line: 2224, column: 17)
!2716 = !DILocation(line: 0, scope: !2715)
!2717 = !DILocation(line: 2224, column: 51, scope: !2715)
!2718 = !DILocation(line: 2224, column: 17, scope: !2700)
!2719 = !DILocation(line: 2226, column: 40, scope: !2720)
!2720 = distinct !DILexicalBlock(scope: !2715, file: !36, line: 2225, column: 13)
!2721 = !DILocation(line: 2226, column: 38, scope: !2720)
!2722 = !DILocation(line: 2228, column: 21, scope: !2723)
!2723 = distinct !DILexicalBlock(scope: !2720, file: !36, line: 2228, column: 21)
!2724 = !DILocation(line: 2228, column: 42, scope: !2723)
!2725 = !DILocation(line: 2228, column: 21, scope: !2720)
!2726 = !DILocation(line: 2230, column: 48, scope: !2727)
!2727 = distinct !DILexicalBlock(scope: !2723, file: !36, line: 2229, column: 17)
!2728 = !DILocation(line: 2230, column: 32, scope: !2727)
!2729 = !DILocation(line: 2230, column: 30, scope: !2727)
!2730 = !DILocation(line: 2231, column: 17, scope: !2727)
!2731 = !DILocation(line: 2232, column: 13, scope: !2720)
!2732 = !DILocation(line: 2234, column: 20, scope: !2700)
!2733 = !DILocation(line: 2234, column: 13, scope: !2700)
!2734 = distinct !DISubprogram(name: "MPU_vQueueDelete", scope: !36, file: !36, line: 2245, type: !2671, scopeLine: 2246, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!2735 = !DILocalVariable(name: "xQueue", arg: 1, scope: !2734, file: !36, line: 2245, type: !41)
!2736 = !DILocation(line: 2245, column: 42, scope: !2734)
!2737 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2734, file: !36, line: 2247, type: !41)
!2738 = !DILocation(line: 2247, column: 23, scope: !2734)
!2739 = !DILocalVariable(name: "lIndex", scope: !2734, file: !36, line: 2248, type: !27)
!2740 = !DILocation(line: 2248, column: 17, scope: !2734)
!2741 = !DILocation(line: 2250, column: 30, scope: !2734)
!2742 = !DILocation(line: 2250, column: 18, scope: !2734)
!2743 = !DILocation(line: 2250, column: 16, scope: !2734)
!2744 = !DILocation(line: 2252, column: 13, scope: !2745)
!2745 = distinct !DILexicalBlock(scope: !2734, file: !36, line: 2252, column: 13)
!2746 = !DILocation(line: 0, scope: !2745)
!2747 = !DILocation(line: 2252, column: 47, scope: !2745)
!2748 = !DILocation(line: 2252, column: 13, scope: !2734)
!2749 = !DILocation(line: 2254, column: 36, scope: !2750)
!2750 = distinct !DILexicalBlock(scope: !2745, file: !36, line: 2253, column: 9)
!2751 = !DILocation(line: 2254, column: 34, scope: !2750)
!2752 = !DILocation(line: 2256, column: 17, scope: !2753)
!2753 = distinct !DILexicalBlock(scope: !2750, file: !36, line: 2256, column: 17)
!2754 = !DILocation(line: 2256, column: 38, scope: !2753)
!2755 = !DILocation(line: 2256, column: 17, scope: !2750)
!2756 = !DILocation(line: 2258, column: 31, scope: !2757)
!2757 = distinct !DILexicalBlock(scope: !2753, file: !36, line: 2257, column: 13)
!2758 = !DILocation(line: 2258, column: 17, scope: !2757)
!2759 = !DILocation(line: 2259, column: 53, scope: !2757)
!2760 = !DILocation(line: 2259, column: 17, scope: !2757)
!2761 = !DILocation(line: 2260, column: 13, scope: !2757)
!2762 = !DILocation(line: 2261, column: 9, scope: !2750)
!2763 = !DILocation(line: 2262, column: 5, scope: !2734)
!2764 = distinct !DISubprogram(name: "MPU_xQueueCreateCountingSemaphore", scope: !36, file: !36, line: 2330, type: !2765, scopeLine: 2332, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!2765 = !DISubroutineType(types: !2766)
!2766 = !{!41, !39, !39}
!2767 = !DILocalVariable(name: "uxCountValue", arg: 1, scope: !2764, file: !36, line: 2330, type: !39)
!2768 = !DILocation(line: 2330, column: 70, scope: !2764)
!2769 = !DILocalVariable(name: "uxInitialCount", arg: 2, scope: !2764, file: !36, line: 2331, type: !39)
!2770 = !DILocation(line: 2331, column: 70, scope: !2764)
!2771 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2764, file: !36, line: 2333, type: !41)
!2772 = !DILocation(line: 2333, column: 27, scope: !2764)
!2773 = !DILocalVariable(name: "xExternalQueueHandle", scope: !2764, file: !36, line: 2334, type: !41)
!2774 = !DILocation(line: 2334, column: 27, scope: !2764)
!2775 = !DILocalVariable(name: "lIndex", scope: !2764, file: !36, line: 2335, type: !27)
!2776 = !DILocation(line: 2335, column: 21, scope: !2764)
!2777 = !DILocation(line: 2337, column: 22, scope: !2764)
!2778 = !DILocation(line: 2337, column: 20, scope: !2764)
!2779 = !DILocation(line: 2339, column: 17, scope: !2780)
!2780 = distinct !DILexicalBlock(scope: !2764, file: !36, line: 2339, column: 17)
!2781 = !DILocation(line: 2339, column: 24, scope: !2780)
!2782 = !DILocation(line: 2339, column: 17, scope: !2764)
!2783 = !DILocation(line: 2341, column: 71, scope: !2784)
!2784 = distinct !DILexicalBlock(scope: !2780, file: !36, line: 2340, column: 13)
!2785 = !DILocation(line: 2341, column: 85, scope: !2784)
!2786 = !DILocation(line: 2341, column: 40, scope: !2784)
!2787 = !DILocation(line: 2341, column: 38, scope: !2784)
!2788 = !DILocation(line: 2343, column: 21, scope: !2789)
!2789 = distinct !DILexicalBlock(scope: !2784, file: !36, line: 2343, column: 21)
!2790 = !DILocation(line: 2343, column: 42, scope: !2789)
!2791 = !DILocation(line: 2343, column: 21, scope: !2784)
!2792 = !DILocation(line: 2345, column: 21, scope: !2793)
!2793 = distinct !DILexicalBlock(scope: !2789, file: !36, line: 2344, column: 17)
!2794 = !DILocation(line: 2346, column: 62, scope: !2793)
!2795 = !DILocation(line: 2346, column: 44, scope: !2793)
!2796 = !DILocation(line: 2346, column: 42, scope: !2793)
!2797 = !DILocation(line: 2347, column: 17, scope: !2793)
!2798 = !DILocation(line: 2350, column: 57, scope: !2799)
!2799 = distinct !DILexicalBlock(scope: !2789, file: !36, line: 2349, column: 17)
!2800 = !DILocation(line: 2350, column: 21, scope: !2799)
!2801 = !DILocation(line: 2352, column: 13, scope: !2784)
!2802 = !DILocation(line: 2354, column: 20, scope: !2764)
!2803 = !DILocation(line: 2354, column: 13, scope: !2764)
!2804 = distinct !DISubprogram(name: "MPU_xQueueCreateCountingSemaphoreStatic", scope: !36, file: !36, line: 2362, type: !2805, scopeLine: 2365, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!2805 = !DISubroutineType(types: !2806)
!2806 = !{!41, !2807, !2807, !2808}
!2807 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !39)
!2808 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2809, size: 64)
!2809 = !DIDerivedType(tag: DW_TAG_typedef, name: "StaticQueue_t", file: !1548, line: 1361, baseType: !2810)
!2810 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xSTATIC_QUEUE", file: !1548, line: 1335, size: 1344, elements: !2811)
!2811 = !{!2812, !2814, !2819, !2833, !2835, !2837, !2838, !2839, !2840}
!2812 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy1", scope: !2810, file: !1548, line: 1337, baseType: !2813, size: 192)
!2813 = !DICompositeType(tag: DW_TAG_array_type, baseType: !26, size: 192, elements: !1596)
!2814 = !DIDerivedType(tag: DW_TAG_member, name: "u", scope: !2810, file: !1548, line: 1343, baseType: !2815, size: 64, offset: 192)
!2815 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !2810, file: !1548, line: 1339, size: 64, elements: !2816)
!2816 = !{!2817, !2818}
!2817 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy2", scope: !2815, file: !1548, line: 1341, baseType: !26, size: 64)
!2818 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy2", scope: !2815, file: !1548, line: 1342, baseType: !39, size: 64)
!2819 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy3", scope: !2810, file: !1548, line: 1345, baseType: !2820, size: 640, offset: 256)
!2820 = !DICompositeType(tag: DW_TAG_array_type, baseType: !2821, size: 640, elements: !1577)
!2821 = !DIDerivedType(tag: DW_TAG_typedef, name: "StaticList_t", file: !1548, line: 1256, baseType: !2822)
!2822 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xSTATIC_LIST", file: !1548, line: 1245, size: 320, elements: !2823)
!2823 = !{!2824, !2825, !2826}
!2824 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy2", scope: !2822, file: !1548, line: 1250, baseType: !39, size: 64)
!2825 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy3", scope: !2822, file: !1548, line: 1251, baseType: !26, size: 64, offset: 64)
!2826 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy4", scope: !2822, file: !1548, line: 1252, baseType: !2827, size: 192, offset: 128)
!2827 = !DIDerivedType(tag: DW_TAG_typedef, name: "StaticMiniListItem_t", file: !1548, line: 1239, baseType: !2828)
!2828 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xSTATIC_MINI_LIST_ITEM", file: !1548, line: 1231, size: 192, elements: !2829)
!2829 = !{!2830, !2831}
!2830 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy2", scope: !2828, file: !1548, line: 1236, baseType: !119, size: 64)
!2831 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy3", scope: !2828, file: !1548, line: 1237, baseType: !2832, size: 128, offset: 64)
!2832 = !DICompositeType(tag: DW_TAG_array_type, baseType: !26, size: 128, elements: !1577)
!2833 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy4", scope: !2810, file: !1548, line: 1346, baseType: !2834, size: 192, offset: 896)
!2834 = !DICompositeType(tag: DW_TAG_array_type, baseType: !39, size: 192, elements: !1596)
!2835 = !DIDerivedType(tag: DW_TAG_member, name: "ucDummy5", scope: !2810, file: !1548, line: 1347, baseType: !2836, size: 16, offset: 1088)
!2836 = !DICompositeType(tag: DW_TAG_array_type, baseType: !1583, size: 16, elements: !1577)
!2837 = !DIDerivedType(tag: DW_TAG_member, name: "ucDummy6", scope: !2810, file: !1548, line: 1350, baseType: !1583, size: 8, offset: 1104)
!2838 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy7", scope: !2810, file: !1548, line: 1354, baseType: !26, size: 64, offset: 1152)
!2839 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy8", scope: !2810, file: !1548, line: 1358, baseType: !39, size: 64, offset: 1216)
!2840 = !DIDerivedType(tag: DW_TAG_member, name: "ucDummy9", scope: !2810, file: !1548, line: 1359, baseType: !1583, size: 8, offset: 1280)
!2841 = !DILocalVariable(name: "uxMaxCount", arg: 1, scope: !2804, file: !36, line: 2362, type: !2807)
!2842 = !DILocation(line: 2362, column: 82, scope: !2804)
!2843 = !DILocalVariable(name: "uxInitialCount", arg: 2, scope: !2804, file: !36, line: 2363, type: !2807)
!2844 = !DILocation(line: 2363, column: 82, scope: !2804)
!2845 = !DILocalVariable(name: "pxStaticQueue", arg: 3, scope: !2804, file: !36, line: 2364, type: !2808)
!2846 = !DILocation(line: 2364, column: 80, scope: !2804)
!2847 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2804, file: !36, line: 2366, type: !41)
!2848 = !DILocation(line: 2366, column: 27, scope: !2804)
!2849 = !DILocalVariable(name: "xExternalQueueHandle", scope: !2804, file: !36, line: 2367, type: !41)
!2850 = !DILocation(line: 2367, column: 27, scope: !2804)
!2851 = !DILocalVariable(name: "lIndex", scope: !2804, file: !36, line: 2368, type: !27)
!2852 = !DILocation(line: 2368, column: 21, scope: !2804)
!2853 = !DILocation(line: 2370, column: 22, scope: !2804)
!2854 = !DILocation(line: 2370, column: 20, scope: !2804)
!2855 = !DILocation(line: 2372, column: 17, scope: !2856)
!2856 = distinct !DILexicalBlock(scope: !2804, file: !36, line: 2372, column: 17)
!2857 = !DILocation(line: 2372, column: 24, scope: !2856)
!2858 = !DILocation(line: 2372, column: 17, scope: !2804)
!2859 = !DILocation(line: 2374, column: 77, scope: !2860)
!2860 = distinct !DILexicalBlock(scope: !2856, file: !36, line: 2373, column: 13)
!2861 = !DILocation(line: 2374, column: 89, scope: !2860)
!2862 = !DILocation(line: 2374, column: 105, scope: !2860)
!2863 = !DILocation(line: 2374, column: 40, scope: !2860)
!2864 = !DILocation(line: 2374, column: 38, scope: !2860)
!2865 = !DILocation(line: 2376, column: 21, scope: !2866)
!2866 = distinct !DILexicalBlock(scope: !2860, file: !36, line: 2376, column: 21)
!2867 = !DILocation(line: 2376, column: 42, scope: !2866)
!2868 = !DILocation(line: 2376, column: 21, scope: !2860)
!2869 = !DILocation(line: 2378, column: 21, scope: !2870)
!2870 = distinct !DILexicalBlock(scope: !2866, file: !36, line: 2377, column: 17)
!2871 = !DILocation(line: 2379, column: 62, scope: !2870)
!2872 = !DILocation(line: 2379, column: 44, scope: !2870)
!2873 = !DILocation(line: 2379, column: 42, scope: !2870)
!2874 = !DILocation(line: 2380, column: 17, scope: !2870)
!2875 = !DILocation(line: 2383, column: 57, scope: !2876)
!2876 = distinct !DILexicalBlock(scope: !2866, file: !36, line: 2382, column: 17)
!2877 = !DILocation(line: 2383, column: 21, scope: !2876)
!2878 = !DILocation(line: 2385, column: 13, scope: !2860)
!2879 = !DILocation(line: 2387, column: 20, scope: !2804)
!2880 = !DILocation(line: 2387, column: 13, scope: !2804)
!2881 = distinct !DISubprogram(name: "MPU_xQueueGenericCreate", scope: !36, file: !36, line: 2395, type: !2882, scopeLine: 2398, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!2882 = !DISubroutineType(types: !2883)
!2883 = !{!41, !39, !39, !1583}
!2884 = !DILocalVariable(name: "uxQueueLength", arg: 1, scope: !2881, file: !36, line: 2395, type: !39)
!2885 = !DILocation(line: 2395, column: 60, scope: !2881)
!2886 = !DILocalVariable(name: "uxItemSize", arg: 2, scope: !2881, file: !36, line: 2396, type: !39)
!2887 = !DILocation(line: 2396, column: 60, scope: !2881)
!2888 = !DILocalVariable(name: "ucQueueType", arg: 3, scope: !2881, file: !36, line: 2397, type: !1583)
!2889 = !DILocation(line: 2397, column: 56, scope: !2881)
!2890 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2881, file: !36, line: 2399, type: !41)
!2891 = !DILocation(line: 2399, column: 27, scope: !2881)
!2892 = !DILocalVariable(name: "xExternalQueueHandle", scope: !2881, file: !36, line: 2400, type: !41)
!2893 = !DILocation(line: 2400, column: 27, scope: !2881)
!2894 = !DILocalVariable(name: "lIndex", scope: !2881, file: !36, line: 2401, type: !27)
!2895 = !DILocation(line: 2401, column: 21, scope: !2881)
!2896 = !DILocation(line: 2403, column: 22, scope: !2881)
!2897 = !DILocation(line: 2403, column: 20, scope: !2881)
!2898 = !DILocation(line: 2405, column: 17, scope: !2899)
!2899 = distinct !DILexicalBlock(scope: !2881, file: !36, line: 2405, column: 17)
!2900 = !DILocation(line: 2405, column: 24, scope: !2899)
!2901 = !DILocation(line: 2405, column: 17, scope: !2881)
!2902 = !DILocation(line: 2407, column: 61, scope: !2903)
!2903 = distinct !DILexicalBlock(scope: !2899, file: !36, line: 2406, column: 13)
!2904 = !DILocation(line: 2407, column: 76, scope: !2903)
!2905 = !DILocation(line: 2407, column: 88, scope: !2903)
!2906 = !DILocation(line: 2407, column: 40, scope: !2903)
!2907 = !DILocation(line: 2407, column: 38, scope: !2903)
!2908 = !DILocation(line: 2409, column: 21, scope: !2909)
!2909 = distinct !DILexicalBlock(scope: !2903, file: !36, line: 2409, column: 21)
!2910 = !DILocation(line: 2409, column: 42, scope: !2909)
!2911 = !DILocation(line: 2409, column: 21, scope: !2903)
!2912 = !DILocation(line: 2411, column: 21, scope: !2913)
!2913 = distinct !DILexicalBlock(scope: !2909, file: !36, line: 2410, column: 17)
!2914 = !DILocation(line: 2412, column: 62, scope: !2913)
!2915 = !DILocation(line: 2412, column: 44, scope: !2913)
!2916 = !DILocation(line: 2412, column: 42, scope: !2913)
!2917 = !DILocation(line: 2413, column: 17, scope: !2913)
!2918 = !DILocation(line: 2416, column: 57, scope: !2919)
!2919 = distinct !DILexicalBlock(scope: !2909, file: !36, line: 2415, column: 17)
!2920 = !DILocation(line: 2416, column: 21, scope: !2919)
!2921 = !DILocation(line: 2418, column: 13, scope: !2903)
!2922 = !DILocation(line: 2420, column: 20, scope: !2881)
!2923 = !DILocation(line: 2420, column: 13, scope: !2881)
!2924 = distinct !DISubprogram(name: "MPU_xQueueGenericCreateStatic", scope: !36, file: !36, line: 2428, type: !2925, scopeLine: 2433, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!2925 = !DISubroutineType(types: !2926)
!2926 = !{!41, !2807, !2807, !2927, !2808, !2928}
!2927 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1583, size: 64)
!2928 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1583)
!2929 = !DILocalVariable(name: "uxQueueLength", arg: 1, scope: !2924, file: !36, line: 2428, type: !2807)
!2930 = !DILocation(line: 2428, column: 72, scope: !2924)
!2931 = !DILocalVariable(name: "uxItemSize", arg: 2, scope: !2924, file: !36, line: 2429, type: !2807)
!2932 = !DILocation(line: 2429, column: 72, scope: !2924)
!2933 = !DILocalVariable(name: "pucQueueStorage", arg: 3, scope: !2924, file: !36, line: 2430, type: !2927)
!2934 = !DILocation(line: 2430, column: 64, scope: !2924)
!2935 = !DILocalVariable(name: "pxStaticQueue", arg: 4, scope: !2924, file: !36, line: 2431, type: !2808)
!2936 = !DILocation(line: 2431, column: 70, scope: !2924)
!2937 = !DILocalVariable(name: "ucQueueType", arg: 5, scope: !2924, file: !36, line: 2432, type: !2928)
!2938 = !DILocation(line: 2432, column: 68, scope: !2924)
!2939 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2924, file: !36, line: 2434, type: !41)
!2940 = !DILocation(line: 2434, column: 27, scope: !2924)
!2941 = !DILocalVariable(name: "xExternalQueueHandle", scope: !2924, file: !36, line: 2435, type: !41)
!2942 = !DILocation(line: 2435, column: 27, scope: !2924)
!2943 = !DILocalVariable(name: "lIndex", scope: !2924, file: !36, line: 2436, type: !27)
!2944 = !DILocation(line: 2436, column: 21, scope: !2924)
!2945 = !DILocation(line: 2438, column: 22, scope: !2924)
!2946 = !DILocation(line: 2438, column: 20, scope: !2924)
!2947 = !DILocation(line: 2440, column: 17, scope: !2948)
!2948 = distinct !DILexicalBlock(scope: !2924, file: !36, line: 2440, column: 17)
!2949 = !DILocation(line: 2440, column: 24, scope: !2948)
!2950 = !DILocation(line: 2440, column: 17, scope: !2924)
!2951 = !DILocation(line: 2442, column: 67, scope: !2952)
!2952 = distinct !DILexicalBlock(scope: !2948, file: !36, line: 2441, column: 13)
!2953 = !DILocation(line: 2442, column: 82, scope: !2952)
!2954 = !DILocation(line: 2442, column: 94, scope: !2952)
!2955 = !DILocation(line: 2442, column: 111, scope: !2952)
!2956 = !DILocation(line: 2442, column: 126, scope: !2952)
!2957 = !DILocation(line: 2442, column: 40, scope: !2952)
!2958 = !DILocation(line: 2442, column: 38, scope: !2952)
!2959 = !DILocation(line: 2444, column: 21, scope: !2960)
!2960 = distinct !DILexicalBlock(scope: !2952, file: !36, line: 2444, column: 21)
!2961 = !DILocation(line: 2444, column: 42, scope: !2960)
!2962 = !DILocation(line: 2444, column: 21, scope: !2952)
!2963 = !DILocation(line: 2446, column: 21, scope: !2964)
!2964 = distinct !DILexicalBlock(scope: !2960, file: !36, line: 2445, column: 17)
!2965 = !DILocation(line: 2447, column: 62, scope: !2964)
!2966 = !DILocation(line: 2447, column: 44, scope: !2964)
!2967 = !DILocation(line: 2447, column: 42, scope: !2964)
!2968 = !DILocation(line: 2448, column: 17, scope: !2964)
!2969 = !DILocation(line: 2451, column: 57, scope: !2970)
!2970 = distinct !DILexicalBlock(scope: !2960, file: !36, line: 2450, column: 17)
!2971 = !DILocation(line: 2451, column: 21, scope: !2970)
!2972 = !DILocation(line: 2453, column: 13, scope: !2952)
!2973 = !DILocation(line: 2455, column: 20, scope: !2924)
!2974 = !DILocation(line: 2455, column: 13, scope: !2924)
!2975 = distinct !DISubprogram(name: "MPU_xQueueGenericReset", scope: !36, file: !36, line: 2461, type: !2976, scopeLine: 2463, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!2976 = !DISubroutineType(types: !2977)
!2977 = !{!23, !41, !23}
!2978 = !DILocalVariable(name: "xQueue", arg: 1, scope: !2975, file: !36, line: 2461, type: !41)
!2979 = !DILocation(line: 2461, column: 54, scope: !2975)
!2980 = !DILocalVariable(name: "xNewQueue", arg: 2, scope: !2975, file: !36, line: 2462, type: !23)
!2981 = !DILocation(line: 2462, column: 51, scope: !2975)
!2982 = !DILocalVariable(name: "lIndex", scope: !2975, file: !36, line: 2464, type: !27)
!2983 = !DILocation(line: 2464, column: 17, scope: !2975)
!2984 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2975, file: !36, line: 2465, type: !41)
!2985 = !DILocation(line: 2465, column: 23, scope: !2975)
!2986 = !DILocalVariable(name: "xReturn", scope: !2975, file: !36, line: 2466, type: !23)
!2987 = !DILocation(line: 2466, column: 20, scope: !2975)
!2988 = !DILocation(line: 2468, column: 31, scope: !2975)
!2989 = !DILocation(line: 2468, column: 18, scope: !2975)
!2990 = !DILocation(line: 2468, column: 16, scope: !2975)
!2991 = !DILocation(line: 2470, column: 13, scope: !2992)
!2992 = distinct !DILexicalBlock(scope: !2975, file: !36, line: 2470, column: 13)
!2993 = !DILocation(line: 0, scope: !2992)
!2994 = !DILocation(line: 2470, column: 47, scope: !2992)
!2995 = !DILocation(line: 2470, column: 13, scope: !2975)
!2996 = !DILocation(line: 2472, column: 36, scope: !2997)
!2997 = distinct !DILexicalBlock(scope: !2992, file: !36, line: 2471, column: 9)
!2998 = !DILocation(line: 2472, column: 34, scope: !2997)
!2999 = !DILocation(line: 2474, column: 17, scope: !3000)
!3000 = distinct !DILexicalBlock(scope: !2997, file: !36, line: 2474, column: 17)
!3001 = !DILocation(line: 2474, column: 38, scope: !3000)
!3002 = !DILocation(line: 2474, column: 17, scope: !2997)
!3003 = !DILocation(line: 2476, column: 47, scope: !3004)
!3004 = distinct !DILexicalBlock(scope: !3000, file: !36, line: 2475, column: 13)
!3005 = !DILocation(line: 2476, column: 69, scope: !3004)
!3006 = !DILocation(line: 2476, column: 27, scope: !3004)
!3007 = !DILocation(line: 2476, column: 25, scope: !3004)
!3008 = !DILocation(line: 2477, column: 13, scope: !3004)
!3009 = !DILocation(line: 2478, column: 9, scope: !2997)
!3010 = !DILocation(line: 2480, column: 16, scope: !2975)
!3011 = !DILocation(line: 2480, column: 9, scope: !2975)
!3012 = distinct !DISubprogram(name: "MPU_xQueueCreateSet", scope: !36, file: !36, line: 2486, type: !3013, scopeLine: 2487, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3013 = !DISubroutineType(types: !3014)
!3014 = !{!45, !39}
!3015 = !DILocalVariable(name: "uxEventQueueLength", arg: 1, scope: !3012, file: !36, line: 2486, type: !39)
!3016 = !DILocation(line: 2486, column: 59, scope: !3012)
!3017 = !DILocalVariable(name: "xInternalQueueSetHandle", scope: !3012, file: !36, line: 2488, type: !45)
!3018 = !DILocation(line: 2488, column: 30, scope: !3012)
!3019 = !DILocalVariable(name: "xExternalQueueSetHandle", scope: !3012, file: !36, line: 2489, type: !45)
!3020 = !DILocation(line: 2489, column: 30, scope: !3012)
!3021 = !DILocalVariable(name: "lIndex", scope: !3012, file: !36, line: 2490, type: !27)
!3022 = !DILocation(line: 2490, column: 21, scope: !3012)
!3023 = !DILocation(line: 2492, column: 22, scope: !3012)
!3024 = !DILocation(line: 2492, column: 20, scope: !3012)
!3025 = !DILocation(line: 2494, column: 17, scope: !3026)
!3026 = distinct !DILexicalBlock(scope: !3012, file: !36, line: 2494, column: 17)
!3027 = !DILocation(line: 2494, column: 24, scope: !3026)
!3028 = !DILocation(line: 2494, column: 17, scope: !3012)
!3029 = !DILocation(line: 2496, column: 60, scope: !3030)
!3030 = distinct !DILexicalBlock(scope: !3026, file: !36, line: 2495, column: 13)
!3031 = !DILocation(line: 2496, column: 43, scope: !3030)
!3032 = !DILocation(line: 2496, column: 41, scope: !3030)
!3033 = !DILocation(line: 2498, column: 21, scope: !3034)
!3034 = distinct !DILexicalBlock(scope: !3030, file: !36, line: 2498, column: 21)
!3035 = !DILocation(line: 2498, column: 45, scope: !3034)
!3036 = !DILocation(line: 2498, column: 21, scope: !3030)
!3037 = !DILocation(line: 2500, column: 21, scope: !3038)
!3038 = distinct !DILexicalBlock(scope: !3034, file: !36, line: 2499, column: 17)
!3039 = !DILocation(line: 2501, column: 68, scope: !3038)
!3040 = !DILocation(line: 2501, column: 47, scope: !3038)
!3041 = !DILocation(line: 2501, column: 45, scope: !3038)
!3042 = !DILocation(line: 2502, column: 17, scope: !3038)
!3043 = !DILocation(line: 2505, column: 57, scope: !3044)
!3044 = distinct !DILexicalBlock(scope: !3034, file: !36, line: 2504, column: 17)
!3045 = !DILocation(line: 2505, column: 21, scope: !3044)
!3046 = !DILocation(line: 2507, column: 13, scope: !3030)
!3047 = !DILocation(line: 2509, column: 20, scope: !3012)
!3048 = !DILocation(line: 2509, column: 13, scope: !3012)
!3049 = distinct !DISubprogram(name: "MPU_xQueueRemoveFromSet", scope: !36, file: !36, line: 2517, type: !2586, scopeLine: 2519, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3050 = !DILocalVariable(name: "xQueueOrSemaphore", arg: 1, scope: !3049, file: !36, line: 2517, type: !46)
!3051 = !DILocation(line: 2517, column: 68, scope: !3049)
!3052 = !DILocalVariable(name: "xQueueSet", arg: 2, scope: !3049, file: !36, line: 2518, type: !45)
!3053 = !DILocation(line: 2518, column: 62, scope: !3049)
!3054 = !DILocalVariable(name: "xReturn", scope: !3049, file: !36, line: 2520, type: !23)
!3055 = !DILocation(line: 2520, column: 24, scope: !3049)
!3056 = !DILocalVariable(name: "xInternalQueueSetMemberHandle", scope: !3049, file: !36, line: 2521, type: !46)
!3057 = !DILocation(line: 2521, column: 36, scope: !3049)
!3058 = !DILocalVariable(name: "xInternalQueueSetHandle", scope: !3049, file: !36, line: 2522, type: !45)
!3059 = !DILocation(line: 2522, column: 30, scope: !3049)
!3060 = !DILocalVariable(name: "lIndexQueueSet", scope: !3049, file: !36, line: 2523, type: !27)
!3061 = !DILocation(line: 2523, column: 21, scope: !3049)
!3062 = !DILocalVariable(name: "lIndexQueueSetMember", scope: !3049, file: !36, line: 2523, type: !27)
!3063 = !DILocation(line: 2523, column: 37, scope: !3049)
!3064 = !DILocation(line: 2525, column: 42, scope: !3049)
!3065 = !DILocation(line: 2525, column: 30, scope: !3049)
!3066 = !DILocation(line: 2525, column: 28, scope: !3049)
!3067 = !DILocation(line: 2526, column: 48, scope: !3049)
!3068 = !DILocation(line: 2526, column: 36, scope: !3049)
!3069 = !DILocation(line: 2526, column: 34, scope: !3049)
!3070 = !DILocation(line: 2528, column: 19, scope: !3071)
!3071 = distinct !DILexicalBlock(scope: !3049, file: !36, line: 2528, column: 17)
!3072 = !DILocation(line: 0, scope: !3071)
!3073 = !DILocation(line: 2528, column: 61, scope: !3071)
!3074 = !DILocation(line: 2528, column: 74, scope: !3071)
!3075 = !DILocation(line: 2529, column: 19, scope: !3071)
!3076 = !DILocation(line: 2529, column: 67, scope: !3071)
!3077 = !DILocation(line: 2528, column: 17, scope: !3049)
!3078 = !DILocation(line: 2531, column: 43, scope: !3079)
!3079 = distinct !DILexicalBlock(scope: !3071, file: !36, line: 2530, column: 13)
!3080 = !DILocation(line: 2531, column: 41, scope: !3079)
!3081 = !DILocation(line: 2532, column: 49, scope: !3079)
!3082 = !DILocation(line: 2532, column: 47, scope: !3079)
!3083 = !DILocation(line: 2534, column: 23, scope: !3084)
!3084 = distinct !DILexicalBlock(scope: !3079, file: !36, line: 2534, column: 21)
!3085 = !DILocation(line: 2534, column: 47, scope: !3084)
!3086 = !DILocation(line: 2534, column: 57, scope: !3084)
!3087 = !DILocation(line: 2534, column: 62, scope: !3084)
!3088 = !DILocation(line: 2534, column: 92, scope: !3084)
!3089 = !DILocation(line: 2534, column: 21, scope: !3079)
!3090 = !DILocation(line: 2536, column: 52, scope: !3091)
!3091 = distinct !DILexicalBlock(scope: !3084, file: !36, line: 2535, column: 17)
!3092 = !DILocation(line: 2536, column: 83, scope: !3091)
!3093 = !DILocation(line: 2536, column: 31, scope: !3091)
!3094 = !DILocation(line: 2536, column: 29, scope: !3091)
!3095 = !DILocation(line: 2537, column: 17, scope: !3091)
!3096 = !DILocation(line: 2538, column: 13, scope: !3079)
!3097 = !DILocation(line: 2540, column: 20, scope: !3049)
!3098 = !DILocation(line: 2540, column: 13, scope: !3049)
!3099 = distinct !DISubprogram(name: "MPU_xQueueGenericGetStaticBuffers", scope: !36, file: !36, line: 2548, type: !3100, scopeLine: 2551, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3100 = !DISubroutineType(types: !3101)
!3101 = !{!23, !41, !3102, !3103}
!3102 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2927, size: 64)
!3103 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2808, size: 64)
!3104 = !DILocalVariable(name: "xQueue", arg: 1, scope: !3099, file: !36, line: 2548, type: !41)
!3105 = !DILocation(line: 2548, column: 69, scope: !3099)
!3106 = !DILocalVariable(name: "ppucQueueStorage", arg: 2, scope: !3099, file: !36, line: 2549, type: !3102)
!3107 = !DILocation(line: 2549, column: 66, scope: !3099)
!3108 = !DILocalVariable(name: "ppxStaticQueue", arg: 3, scope: !3099, file: !36, line: 2550, type: !3103)
!3109 = !DILocation(line: 2550, column: 72, scope: !3099)
!3110 = !DILocalVariable(name: "lIndex", scope: !3099, file: !36, line: 2552, type: !27)
!3111 = !DILocation(line: 2552, column: 21, scope: !3099)
!3112 = !DILocalVariable(name: "xInternalQueueHandle", scope: !3099, file: !36, line: 2553, type: !41)
!3113 = !DILocation(line: 2553, column: 27, scope: !3099)
!3114 = !DILocalVariable(name: "xReturn", scope: !3099, file: !36, line: 2554, type: !23)
!3115 = !DILocation(line: 2554, column: 24, scope: !3099)
!3116 = !DILocation(line: 2556, column: 34, scope: !3099)
!3117 = !DILocation(line: 2556, column: 22, scope: !3099)
!3118 = !DILocation(line: 2556, column: 20, scope: !3099)
!3119 = !DILocation(line: 2558, column: 17, scope: !3120)
!3120 = distinct !DILexicalBlock(scope: !3099, file: !36, line: 2558, column: 17)
!3121 = !DILocation(line: 0, scope: !3120)
!3122 = !DILocation(line: 2558, column: 51, scope: !3120)
!3123 = !DILocation(line: 2558, column: 17, scope: !3099)
!3124 = !DILocation(line: 2560, column: 40, scope: !3125)
!3125 = distinct !DILexicalBlock(scope: !3120, file: !36, line: 2559, column: 13)
!3126 = !DILocation(line: 2560, column: 38, scope: !3125)
!3127 = !DILocation(line: 2562, column: 21, scope: !3128)
!3128 = distinct !DILexicalBlock(scope: !3125, file: !36, line: 2562, column: 21)
!3129 = !DILocation(line: 2562, column: 42, scope: !3128)
!3130 = !DILocation(line: 2562, column: 21, scope: !3125)
!3131 = !DILocation(line: 2564, column: 62, scope: !3132)
!3132 = distinct !DILexicalBlock(scope: !3128, file: !36, line: 2563, column: 17)
!3133 = !DILocation(line: 2564, column: 84, scope: !3132)
!3134 = !DILocation(line: 2564, column: 102, scope: !3132)
!3135 = !DILocation(line: 2564, column: 31, scope: !3132)
!3136 = !DILocation(line: 2564, column: 29, scope: !3132)
!3137 = !DILocation(line: 2565, column: 17, scope: !3132)
!3138 = !DILocation(line: 2566, column: 13, scope: !3125)
!3139 = !DILocation(line: 2568, column: 20, scope: !3099)
!3140 = !DILocation(line: 2568, column: 13, scope: !3099)
!3141 = distinct !DISubprogram(name: "MPU_xQueueGenericSendFromISR", scope: !36, file: !36, line: 2574, type: !3142, scopeLine: 2578, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3142 = !DISubroutineType(types: !3143)
!3143 = !{!23, !41, !2254, !3144, !3145}
!3144 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2168)
!3145 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !23)
!3146 = !DILocalVariable(name: "xQueue", arg: 1, scope: !3141, file: !36, line: 2574, type: !41)
!3147 = !DILocation(line: 2574, column: 60, scope: !3141)
!3148 = !DILocalVariable(name: "pvItemToQueue", arg: 2, scope: !3141, file: !36, line: 2575, type: !2254)
!3149 = !DILocation(line: 2575, column: 65, scope: !3141)
!3150 = !DILocalVariable(name: "pxHigherPriorityTaskWoken", arg: 3, scope: !3141, file: !36, line: 2576, type: !3144)
!3151 = !DILocation(line: 2576, column: 65, scope: !3141)
!3152 = !DILocalVariable(name: "xCopyPosition", arg: 4, scope: !3141, file: !36, line: 2577, type: !3145)
!3153 = !DILocation(line: 2577, column: 63, scope: !3141)
!3154 = !DILocalVariable(name: "xReturn", scope: !3141, file: !36, line: 2579, type: !23)
!3155 = !DILocation(line: 2579, column: 20, scope: !3141)
!3156 = !DILocalVariable(name: "lIndex", scope: !3141, file: !36, line: 2580, type: !27)
!3157 = !DILocation(line: 2580, column: 17, scope: !3141)
!3158 = !DILocalVariable(name: "xInternalQueueHandle", scope: !3141, file: !36, line: 2581, type: !41)
!3159 = !DILocation(line: 2581, column: 23, scope: !3141)
!3160 = !DILocation(line: 2583, column: 30, scope: !3141)
!3161 = !DILocation(line: 2583, column: 18, scope: !3141)
!3162 = !DILocation(line: 2583, column: 16, scope: !3141)
!3163 = !DILocation(line: 2585, column: 13, scope: !3164)
!3164 = distinct !DILexicalBlock(scope: !3141, file: !36, line: 2585, column: 13)
!3165 = !DILocation(line: 0, scope: !3164)
!3166 = !DILocation(line: 2585, column: 47, scope: !3164)
!3167 = !DILocation(line: 2585, column: 13, scope: !3141)
!3168 = !DILocation(line: 2587, column: 36, scope: !3169)
!3169 = distinct !DILexicalBlock(scope: !3164, file: !36, line: 2586, column: 9)
!3170 = !DILocation(line: 2587, column: 34, scope: !3169)
!3171 = !DILocation(line: 2589, column: 17, scope: !3172)
!3172 = distinct !DILexicalBlock(scope: !3169, file: !36, line: 2589, column: 17)
!3173 = !DILocation(line: 2589, column: 38, scope: !3172)
!3174 = !DILocation(line: 2589, column: 17, scope: !3169)
!3175 = !DILocation(line: 2591, column: 53, scope: !3176)
!3176 = distinct !DILexicalBlock(scope: !3172, file: !36, line: 2590, column: 13)
!3177 = !DILocation(line: 2591, column: 75, scope: !3176)
!3178 = !DILocation(line: 2591, column: 90, scope: !3176)
!3179 = !DILocation(line: 2591, column: 117, scope: !3176)
!3180 = !DILocation(line: 2591, column: 27, scope: !3176)
!3181 = !DILocation(line: 2591, column: 25, scope: !3176)
!3182 = !DILocation(line: 2592, column: 13, scope: !3176)
!3183 = !DILocation(line: 2593, column: 9, scope: !3169)
!3184 = !DILocation(line: 2595, column: 16, scope: !3141)
!3185 = !DILocation(line: 2595, column: 9, scope: !3141)
!3186 = distinct !DISubprogram(name: "MPU_xQueueGiveFromISR", scope: !36, file: !36, line: 2600, type: !3187, scopeLine: 2602, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3187 = !DISubroutineType(types: !3188)
!3188 = !{!23, !41, !3144}
!3189 = !DILocalVariable(name: "xQueue", arg: 1, scope: !3186, file: !36, line: 2600, type: !41)
!3190 = !DILocation(line: 2600, column: 53, scope: !3186)
!3191 = !DILocalVariable(name: "pxHigherPriorityTaskWoken", arg: 2, scope: !3186, file: !36, line: 2601, type: !3144)
!3192 = !DILocation(line: 2601, column: 58, scope: !3186)
!3193 = !DILocalVariable(name: "xReturn", scope: !3186, file: !36, line: 2603, type: !23)
!3194 = !DILocation(line: 2603, column: 20, scope: !3186)
!3195 = !DILocalVariable(name: "lIndex", scope: !3186, file: !36, line: 2604, type: !27)
!3196 = !DILocation(line: 2604, column: 17, scope: !3186)
!3197 = !DILocalVariable(name: "xInternalQueueHandle", scope: !3186, file: !36, line: 2605, type: !41)
!3198 = !DILocation(line: 2605, column: 23, scope: !3186)
!3199 = !DILocation(line: 2607, column: 30, scope: !3186)
!3200 = !DILocation(line: 2607, column: 18, scope: !3186)
!3201 = !DILocation(line: 2607, column: 16, scope: !3186)
!3202 = !DILocation(line: 2609, column: 13, scope: !3203)
!3203 = distinct !DILexicalBlock(scope: !3186, file: !36, line: 2609, column: 13)
!3204 = !DILocation(line: 0, scope: !3203)
!3205 = !DILocation(line: 2609, column: 47, scope: !3203)
!3206 = !DILocation(line: 2609, column: 13, scope: !3186)
!3207 = !DILocation(line: 2611, column: 36, scope: !3208)
!3208 = distinct !DILexicalBlock(scope: !3203, file: !36, line: 2610, column: 9)
!3209 = !DILocation(line: 2611, column: 34, scope: !3208)
!3210 = !DILocation(line: 2613, column: 17, scope: !3211)
!3211 = distinct !DILexicalBlock(scope: !3208, file: !36, line: 2613, column: 17)
!3212 = !DILocation(line: 2613, column: 38, scope: !3211)
!3213 = !DILocation(line: 2613, column: 17, scope: !3208)
!3214 = !DILocation(line: 2615, column: 46, scope: !3215)
!3215 = distinct !DILexicalBlock(scope: !3211, file: !36, line: 2614, column: 13)
!3216 = !DILocation(line: 2615, column: 68, scope: !3215)
!3217 = !DILocation(line: 2615, column: 27, scope: !3215)
!3218 = !DILocation(line: 2615, column: 25, scope: !3215)
!3219 = !DILocation(line: 2616, column: 13, scope: !3215)
!3220 = !DILocation(line: 2617, column: 9, scope: !3208)
!3221 = !DILocation(line: 2619, column: 16, scope: !3186)
!3222 = !DILocation(line: 2619, column: 9, scope: !3186)
!3223 = distinct !DISubprogram(name: "MPU_xQueuePeekFromISR", scope: !36, file: !36, line: 2624, type: !3224, scopeLine: 2626, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3224 = !DISubroutineType(types: !3225)
!3225 = !{!23, !41, !1543}
!3226 = !DILocalVariable(name: "xQueue", arg: 1, scope: !3223, file: !36, line: 2624, type: !41)
!3227 = !DILocation(line: 2624, column: 53, scope: !3223)
!3228 = !DILocalVariable(name: "pvBuffer", arg: 2, scope: !3223, file: !36, line: 2625, type: !1543)
!3229 = !DILocation(line: 2625, column: 52, scope: !3223)
!3230 = !DILocalVariable(name: "xReturn", scope: !3223, file: !36, line: 2627, type: !23)
!3231 = !DILocation(line: 2627, column: 20, scope: !3223)
!3232 = !DILocalVariable(name: "lIndex", scope: !3223, file: !36, line: 2628, type: !27)
!3233 = !DILocation(line: 2628, column: 17, scope: !3223)
!3234 = !DILocalVariable(name: "xInternalQueueHandle", scope: !3223, file: !36, line: 2629, type: !41)
!3235 = !DILocation(line: 2629, column: 23, scope: !3223)
!3236 = !DILocation(line: 2631, column: 30, scope: !3223)
!3237 = !DILocation(line: 2631, column: 18, scope: !3223)
!3238 = !DILocation(line: 2631, column: 16, scope: !3223)
!3239 = !DILocation(line: 2633, column: 13, scope: !3240)
!3240 = distinct !DILexicalBlock(scope: !3223, file: !36, line: 2633, column: 13)
!3241 = !DILocation(line: 0, scope: !3240)
!3242 = !DILocation(line: 2633, column: 47, scope: !3240)
!3243 = !DILocation(line: 2633, column: 13, scope: !3223)
!3244 = !DILocation(line: 2635, column: 36, scope: !3245)
!3245 = distinct !DILexicalBlock(scope: !3240, file: !36, line: 2634, column: 9)
!3246 = !DILocation(line: 2635, column: 34, scope: !3245)
!3247 = !DILocation(line: 2637, column: 17, scope: !3248)
!3248 = distinct !DILexicalBlock(scope: !3245, file: !36, line: 2637, column: 17)
!3249 = !DILocation(line: 2637, column: 38, scope: !3248)
!3250 = !DILocation(line: 2637, column: 17, scope: !3245)
!3251 = !DILocation(line: 2639, column: 46, scope: !3252)
!3252 = distinct !DILexicalBlock(scope: !3248, file: !36, line: 2638, column: 13)
!3253 = !DILocation(line: 2639, column: 68, scope: !3252)
!3254 = !DILocation(line: 2639, column: 27, scope: !3252)
!3255 = !DILocation(line: 2639, column: 25, scope: !3252)
!3256 = !DILocation(line: 2640, column: 13, scope: !3252)
!3257 = !DILocation(line: 2641, column: 9, scope: !3245)
!3258 = !DILocation(line: 2643, column: 16, scope: !3223)
!3259 = !DILocation(line: 2643, column: 9, scope: !3223)
!3260 = distinct !DISubprogram(name: "MPU_xQueueReceiveFromISR", scope: !36, file: !36, line: 2648, type: !3261, scopeLine: 2651, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3261 = !DISubroutineType(types: !3262)
!3262 = !{!23, !41, !1543, !3144}
!3263 = !DILocalVariable(name: "xQueue", arg: 1, scope: !3260, file: !36, line: 2648, type: !41)
!3264 = !DILocation(line: 2648, column: 56, scope: !3260)
!3265 = !DILocalVariable(name: "pvBuffer", arg: 2, scope: !3260, file: !36, line: 2649, type: !1543)
!3266 = !DILocation(line: 2649, column: 55, scope: !3260)
!3267 = !DILocalVariable(name: "pxHigherPriorityTaskWoken", arg: 3, scope: !3260, file: !36, line: 2650, type: !3144)
!3268 = !DILocation(line: 2650, column: 61, scope: !3260)
!3269 = !DILocalVariable(name: "xReturn", scope: !3260, file: !36, line: 2652, type: !23)
!3270 = !DILocation(line: 2652, column: 20, scope: !3260)
!3271 = !DILocalVariable(name: "lIndex", scope: !3260, file: !36, line: 2653, type: !27)
!3272 = !DILocation(line: 2653, column: 17, scope: !3260)
!3273 = !DILocalVariable(name: "xInternalQueueHandle", scope: !3260, file: !36, line: 2654, type: !41)
!3274 = !DILocation(line: 2654, column: 23, scope: !3260)
!3275 = !DILocation(line: 2656, column: 30, scope: !3260)
!3276 = !DILocation(line: 2656, column: 18, scope: !3260)
!3277 = !DILocation(line: 2656, column: 16, scope: !3260)
!3278 = !DILocation(line: 2658, column: 13, scope: !3279)
!3279 = distinct !DILexicalBlock(scope: !3260, file: !36, line: 2658, column: 13)
!3280 = !DILocation(line: 0, scope: !3279)
!3281 = !DILocation(line: 2658, column: 47, scope: !3279)
!3282 = !DILocation(line: 2658, column: 13, scope: !3260)
!3283 = !DILocation(line: 2660, column: 36, scope: !3284)
!3284 = distinct !DILexicalBlock(scope: !3279, file: !36, line: 2659, column: 9)
!3285 = !DILocation(line: 2660, column: 34, scope: !3284)
!3286 = !DILocation(line: 2662, column: 17, scope: !3287)
!3287 = distinct !DILexicalBlock(scope: !3284, file: !36, line: 2662, column: 17)
!3288 = !DILocation(line: 2662, column: 38, scope: !3287)
!3289 = !DILocation(line: 2662, column: 17, scope: !3284)
!3290 = !DILocation(line: 2664, column: 49, scope: !3291)
!3291 = distinct !DILexicalBlock(scope: !3287, file: !36, line: 2663, column: 13)
!3292 = !DILocation(line: 2664, column: 71, scope: !3291)
!3293 = !DILocation(line: 2664, column: 81, scope: !3291)
!3294 = !DILocation(line: 2664, column: 27, scope: !3291)
!3295 = !DILocation(line: 2664, column: 25, scope: !3291)
!3296 = !DILocation(line: 2665, column: 13, scope: !3291)
!3297 = !DILocation(line: 2666, column: 9, scope: !3284)
!3298 = !DILocation(line: 2668, column: 16, scope: !3260)
!3299 = !DILocation(line: 2668, column: 9, scope: !3260)
!3300 = distinct !DISubprogram(name: "MPU_xQueueIsQueueEmptyFromISR", scope: !36, file: !36, line: 2673, type: !3301, scopeLine: 2674, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3301 = !DISubroutineType(types: !3302)
!3302 = !{!23, !2322}
!3303 = !DILocalVariable(name: "xQueue", arg: 1, scope: !3300, file: !36, line: 2673, type: !2322)
!3304 = !DILocation(line: 2673, column: 67, scope: !3300)
!3305 = !DILocalVariable(name: "xReturn", scope: !3300, file: !36, line: 2675, type: !23)
!3306 = !DILocation(line: 2675, column: 20, scope: !3300)
!3307 = !DILocalVariable(name: "lIndex", scope: !3300, file: !36, line: 2676, type: !27)
!3308 = !DILocation(line: 2676, column: 17, scope: !3300)
!3309 = !DILocalVariable(name: "xInternalQueueHandle", scope: !3300, file: !36, line: 2677, type: !41)
!3310 = !DILocation(line: 2677, column: 23, scope: !3300)
!3311 = !DILocation(line: 2679, column: 30, scope: !3300)
!3312 = !DILocation(line: 2679, column: 18, scope: !3300)
!3313 = !DILocation(line: 2679, column: 16, scope: !3300)
!3314 = !DILocation(line: 2681, column: 13, scope: !3315)
!3315 = distinct !DILexicalBlock(scope: !3300, file: !36, line: 2681, column: 13)
!3316 = !DILocation(line: 0, scope: !3315)
!3317 = !DILocation(line: 2681, column: 47, scope: !3315)
!3318 = !DILocation(line: 2681, column: 13, scope: !3300)
!3319 = !DILocation(line: 2683, column: 36, scope: !3320)
!3320 = distinct !DILexicalBlock(scope: !3315, file: !36, line: 2682, column: 9)
!3321 = !DILocation(line: 2683, column: 34, scope: !3320)
!3322 = !DILocation(line: 2685, column: 17, scope: !3323)
!3323 = distinct !DILexicalBlock(scope: !3320, file: !36, line: 2685, column: 17)
!3324 = !DILocation(line: 2685, column: 38, scope: !3323)
!3325 = !DILocation(line: 2685, column: 17, scope: !3320)
!3326 = !DILocation(line: 2687, column: 54, scope: !3327)
!3327 = distinct !DILexicalBlock(scope: !3323, file: !36, line: 2686, column: 13)
!3328 = !DILocation(line: 2687, column: 27, scope: !3327)
!3329 = !DILocation(line: 2687, column: 25, scope: !3327)
!3330 = !DILocation(line: 2688, column: 13, scope: !3327)
!3331 = !DILocation(line: 2689, column: 9, scope: !3320)
!3332 = !DILocation(line: 2691, column: 16, scope: !3300)
!3333 = !DILocation(line: 2691, column: 9, scope: !3300)
!3334 = distinct !DISubprogram(name: "MPU_xQueueIsQueueFullFromISR", scope: !36, file: !36, line: 2695, type: !3301, scopeLine: 2696, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3335 = !DILocalVariable(name: "xQueue", arg: 1, scope: !3334, file: !36, line: 2695, type: !2322)
!3336 = !DILocation(line: 2695, column: 66, scope: !3334)
!3337 = !DILocalVariable(name: "xReturn", scope: !3334, file: !36, line: 2697, type: !23)
!3338 = !DILocation(line: 2697, column: 20, scope: !3334)
!3339 = !DILocalVariable(name: "lIndex", scope: !3334, file: !36, line: 2698, type: !27)
!3340 = !DILocation(line: 2698, column: 17, scope: !3334)
!3341 = !DILocalVariable(name: "xInternalQueueHandle", scope: !3334, file: !36, line: 2699, type: !41)
!3342 = !DILocation(line: 2699, column: 23, scope: !3334)
!3343 = !DILocation(line: 2701, column: 30, scope: !3334)
!3344 = !DILocation(line: 2701, column: 18, scope: !3334)
!3345 = !DILocation(line: 2701, column: 16, scope: !3334)
!3346 = !DILocation(line: 2703, column: 13, scope: !3347)
!3347 = distinct !DILexicalBlock(scope: !3334, file: !36, line: 2703, column: 13)
!3348 = !DILocation(line: 0, scope: !3347)
!3349 = !DILocation(line: 2703, column: 47, scope: !3347)
!3350 = !DILocation(line: 2703, column: 13, scope: !3334)
!3351 = !DILocation(line: 2705, column: 36, scope: !3352)
!3352 = distinct !DILexicalBlock(scope: !3347, file: !36, line: 2704, column: 9)
!3353 = !DILocation(line: 2705, column: 34, scope: !3352)
!3354 = !DILocation(line: 2707, column: 17, scope: !3355)
!3355 = distinct !DILexicalBlock(scope: !3352, file: !36, line: 2707, column: 17)
!3356 = !DILocation(line: 2707, column: 38, scope: !3355)
!3357 = !DILocation(line: 2707, column: 17, scope: !3352)
!3358 = !DILocation(line: 2709, column: 53, scope: !3359)
!3359 = distinct !DILexicalBlock(scope: !3355, file: !36, line: 2708, column: 13)
!3360 = !DILocation(line: 2709, column: 27, scope: !3359)
!3361 = !DILocation(line: 2709, column: 25, scope: !3359)
!3362 = !DILocation(line: 2710, column: 13, scope: !3359)
!3363 = !DILocation(line: 2711, column: 9, scope: !3352)
!3364 = !DILocation(line: 2713, column: 16, scope: !3334)
!3365 = !DILocation(line: 2713, column: 9, scope: !3334)
!3366 = distinct !DISubprogram(name: "MPU_uxQueueMessagesWaitingFromISR", scope: !36, file: !36, line: 2718, type: !2320, scopeLine: 2719, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3367 = !DILocalVariable(name: "xQueue", arg: 1, scope: !3366, file: !36, line: 2718, type: !2322)
!3368 = !DILocation(line: 2718, column: 72, scope: !3366)
!3369 = !DILocalVariable(name: "uxReturn", scope: !3366, file: !36, line: 2720, type: !39)
!3370 = !DILocation(line: 2720, column: 21, scope: !3366)
!3371 = !DILocalVariable(name: "lIndex", scope: !3366, file: !36, line: 2721, type: !27)
!3372 = !DILocation(line: 2721, column: 17, scope: !3366)
!3373 = !DILocalVariable(name: "xInternalQueueHandle", scope: !3366, file: !36, line: 2722, type: !41)
!3374 = !DILocation(line: 2722, column: 23, scope: !3366)
!3375 = !DILocation(line: 2724, column: 30, scope: !3366)
!3376 = !DILocation(line: 2724, column: 18, scope: !3366)
!3377 = !DILocation(line: 2724, column: 16, scope: !3366)
!3378 = !DILocation(line: 2726, column: 13, scope: !3379)
!3379 = distinct !DILexicalBlock(scope: !3366, file: !36, line: 2726, column: 13)
!3380 = !DILocation(line: 0, scope: !3379)
!3381 = !DILocation(line: 2726, column: 47, scope: !3379)
!3382 = !DILocation(line: 2726, column: 13, scope: !3366)
!3383 = !DILocation(line: 2728, column: 36, scope: !3384)
!3384 = distinct !DILexicalBlock(scope: !3379, file: !36, line: 2727, column: 9)
!3385 = !DILocation(line: 2728, column: 34, scope: !3384)
!3386 = !DILocation(line: 2730, column: 17, scope: !3387)
!3387 = distinct !DILexicalBlock(scope: !3384, file: !36, line: 2730, column: 17)
!3388 = !DILocation(line: 2730, column: 38, scope: !3387)
!3389 = !DILocation(line: 2730, column: 17, scope: !3384)
!3390 = !DILocation(line: 2732, column: 59, scope: !3391)
!3391 = distinct !DILexicalBlock(scope: !3387, file: !36, line: 2731, column: 13)
!3392 = !DILocation(line: 2732, column: 28, scope: !3391)
!3393 = !DILocation(line: 2732, column: 26, scope: !3391)
!3394 = !DILocation(line: 2733, column: 13, scope: !3391)
!3395 = !DILocation(line: 2734, column: 9, scope: !3384)
!3396 = !DILocation(line: 2736, column: 16, scope: !3366)
!3397 = !DILocation(line: 2736, column: 9, scope: !3366)
!3398 = distinct !DISubprogram(name: "MPU_xQueueSelectFromSetFromISR", scope: !36, file: !36, line: 2780, type: !3399, scopeLine: 2781, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3399 = !DISubroutineType(types: !3400)
!3400 = !{!46, !45}
!3401 = !DILocalVariable(name: "xQueueSet", arg: 1, scope: !3398, file: !36, line: 2780, type: !45)
!3402 = !DILocation(line: 2780, column: 81, scope: !3398)
!3403 = !DILocalVariable(name: "xInternalQueueSetHandle", scope: !3398, file: !36, line: 2782, type: !45)
!3404 = !DILocation(line: 2782, column: 30, scope: !3398)
!3405 = !DILocalVariable(name: "xSelectedMemberInternal", scope: !3398, file: !36, line: 2783, type: !46)
!3406 = !DILocation(line: 2783, column: 36, scope: !3398)
!3407 = !DILocalVariable(name: "xSelectedMemberExternal", scope: !3398, file: !36, line: 2784, type: !46)
!3408 = !DILocation(line: 2784, column: 36, scope: !3398)
!3409 = !DILocalVariable(name: "lIndexQueueSet", scope: !3398, file: !36, line: 2785, type: !27)
!3410 = !DILocation(line: 2785, column: 21, scope: !3398)
!3411 = !DILocalVariable(name: "lIndexSelectedMember", scope: !3398, file: !36, line: 2785, type: !27)
!3412 = !DILocation(line: 2785, column: 37, scope: !3398)
!3413 = !DILocation(line: 2787, column: 42, scope: !3398)
!3414 = !DILocation(line: 2787, column: 30, scope: !3398)
!3415 = !DILocation(line: 2787, column: 28, scope: !3398)
!3416 = !DILocation(line: 2789, column: 17, scope: !3417)
!3417 = distinct !DILexicalBlock(scope: !3398, file: !36, line: 2789, column: 17)
!3418 = !DILocation(line: 0, scope: !3417)
!3419 = !DILocation(line: 2789, column: 59, scope: !3417)
!3420 = !DILocation(line: 2789, column: 17, scope: !3398)
!3421 = !DILocation(line: 2791, column: 43, scope: !3422)
!3422 = distinct !DILexicalBlock(scope: !3417, file: !36, line: 2790, column: 13)
!3423 = !DILocation(line: 2791, column: 41, scope: !3422)
!3424 = !DILocation(line: 2793, column: 21, scope: !3425)
!3425 = distinct !DILexicalBlock(scope: !3422, file: !36, line: 2793, column: 21)
!3426 = !DILocation(line: 2793, column: 45, scope: !3425)
!3427 = !DILocation(line: 2793, column: 21, scope: !3422)
!3428 = !DILocation(line: 2795, column: 75, scope: !3429)
!3429 = distinct !DILexicalBlock(scope: !3425, file: !36, line: 2794, column: 17)
!3430 = !DILocation(line: 2795, column: 47, scope: !3429)
!3431 = !DILocation(line: 2795, column: 45, scope: !3429)
!3432 = !DILocation(line: 2797, column: 25, scope: !3433)
!3433 = distinct !DILexicalBlock(scope: !3429, file: !36, line: 2797, column: 25)
!3434 = !DILocation(line: 2797, column: 49, scope: !3433)
!3435 = !DILocation(line: 2797, column: 25, scope: !3429)
!3436 = !DILocation(line: 2799, column: 48, scope: !3437)
!3437 = distinct !DILexicalBlock(scope: !3433, file: !36, line: 2798, column: 21)
!3438 = !DILocation(line: 2799, column: 46, scope: !3437)
!3439 = !DILocation(line: 2801, column: 29, scope: !3440)
!3440 = distinct !DILexicalBlock(scope: !3437, file: !36, line: 2801, column: 29)
!3441 = !DILocation(line: 2801, column: 50, scope: !3440)
!3442 = !DILocation(line: 2801, column: 29, scope: !3437)
!3443 = !DILocation(line: 2803, column: 84, scope: !3444)
!3444 = distinct !DILexicalBlock(scope: !3440, file: !36, line: 2802, column: 25)
!3445 = !DILocation(line: 2803, column: 55, scope: !3444)
!3446 = !DILocation(line: 2803, column: 53, scope: !3444)
!3447 = !DILocation(line: 2804, column: 25, scope: !3444)
!3448 = !DILocation(line: 2805, column: 21, scope: !3437)
!3449 = !DILocation(line: 2806, column: 17, scope: !3429)
!3450 = !DILocation(line: 2807, column: 13, scope: !3422)
!3451 = !DILocation(line: 2809, column: 20, scope: !3398)
!3452 = !DILocation(line: 2809, column: 13, scope: !3398)
!3453 = distinct !DISubprogram(name: "MPU_pvTimerGetTimerIDImpl", scope: !36, file: !36, line: 2823, type: !3454, scopeLine: 2824, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3454 = !DISubroutineType(types: !3455)
!3455 = !{!26, !3456}
!3456 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !50)
!3457 = !DILocalVariable(name: "xTimer", arg: 1, scope: !3453, file: !36, line: 2823, type: !3456)
!3458 = !DILocation(line: 2823, column: 63, scope: !3453)
!3459 = !DILocalVariable(name: "pvReturn", scope: !3453, file: !36, line: 2825, type: !26)
!3460 = !DILocation(line: 2825, column: 20, scope: !3453)
!3461 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3453, file: !36, line: 2826, type: !50)
!3462 = !DILocation(line: 2826, column: 27, scope: !3453)
!3463 = !DILocalVariable(name: "lIndex", scope: !3453, file: !36, line: 2827, type: !27)
!3464 = !DILocation(line: 2827, column: 21, scope: !3453)
!3465 = !DILocation(line: 2829, column: 34, scope: !3453)
!3466 = !DILocation(line: 2829, column: 22, scope: !3453)
!3467 = !DILocation(line: 2829, column: 20, scope: !3453)
!3468 = !DILocation(line: 2831, column: 17, scope: !3469)
!3469 = distinct !DILexicalBlock(scope: !3453, file: !36, line: 2831, column: 17)
!3470 = !DILocation(line: 0, scope: !3469)
!3471 = !DILocation(line: 2831, column: 51, scope: !3469)
!3472 = !DILocation(line: 2831, column: 17, scope: !3453)
!3473 = !DILocation(line: 2833, column: 40, scope: !3474)
!3474 = distinct !DILexicalBlock(scope: !3469, file: !36, line: 2832, column: 13)
!3475 = !DILocation(line: 2833, column: 38, scope: !3474)
!3476 = !DILocation(line: 2835, column: 21, scope: !3477)
!3477 = distinct !DILexicalBlock(scope: !3474, file: !36, line: 2835, column: 21)
!3478 = !DILocation(line: 2835, column: 42, scope: !3477)
!3479 = !DILocation(line: 2835, column: 21, scope: !3474)
!3480 = !DILocation(line: 2837, column: 51, scope: !3481)
!3481 = distinct !DILexicalBlock(scope: !3477, file: !36, line: 2836, column: 17)
!3482 = !DILocation(line: 2837, column: 32, scope: !3481)
!3483 = !DILocation(line: 2837, column: 30, scope: !3481)
!3484 = !DILocation(line: 2838, column: 17, scope: !3481)
!3485 = !DILocation(line: 2839, column: 13, scope: !3474)
!3486 = !DILocation(line: 2841, column: 20, scope: !3453)
!3487 = !DILocation(line: 2841, column: 13, scope: !3453)
!3488 = distinct !DISubprogram(name: "MPU_vTimerSetTimerIDImpl", scope: !36, file: !36, line: 2852, type: !3489, scopeLine: 2854, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3489 = !DISubroutineType(types: !3490)
!3490 = !{null, !50, !26}
!3491 = !DILocalVariable(name: "xTimer", arg: 1, scope: !3488, file: !36, line: 2852, type: !50)
!3492 = !DILocation(line: 2852, column: 54, scope: !3488)
!3493 = !DILocalVariable(name: "pvNewID", arg: 2, scope: !3488, file: !36, line: 2853, type: !26)
!3494 = !DILocation(line: 2853, column: 47, scope: !3488)
!3495 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3488, file: !36, line: 2855, type: !50)
!3496 = !DILocation(line: 2855, column: 27, scope: !3488)
!3497 = !DILocalVariable(name: "lIndex", scope: !3488, file: !36, line: 2856, type: !27)
!3498 = !DILocation(line: 2856, column: 21, scope: !3488)
!3499 = !DILocation(line: 2858, column: 34, scope: !3488)
!3500 = !DILocation(line: 2858, column: 22, scope: !3488)
!3501 = !DILocation(line: 2858, column: 20, scope: !3488)
!3502 = !DILocation(line: 2860, column: 17, scope: !3503)
!3503 = distinct !DILexicalBlock(scope: !3488, file: !36, line: 2860, column: 17)
!3504 = !DILocation(line: 0, scope: !3503)
!3505 = !DILocation(line: 2860, column: 51, scope: !3503)
!3506 = !DILocation(line: 2860, column: 17, scope: !3488)
!3507 = !DILocation(line: 2862, column: 40, scope: !3508)
!3508 = distinct !DILexicalBlock(scope: !3503, file: !36, line: 2861, column: 13)
!3509 = !DILocation(line: 2862, column: 38, scope: !3508)
!3510 = !DILocation(line: 2864, column: 21, scope: !3511)
!3511 = distinct !DILexicalBlock(scope: !3508, file: !36, line: 2864, column: 21)
!3512 = !DILocation(line: 2864, column: 42, scope: !3511)
!3513 = !DILocation(line: 2864, column: 21, scope: !3508)
!3514 = !DILocation(line: 2866, column: 39, scope: !3515)
!3515 = distinct !DILexicalBlock(scope: !3511, file: !36, line: 2865, column: 17)
!3516 = !DILocation(line: 2866, column: 61, scope: !3515)
!3517 = !DILocation(line: 2866, column: 21, scope: !3515)
!3518 = !DILocation(line: 2867, column: 17, scope: !3515)
!3519 = !DILocation(line: 2868, column: 13, scope: !3508)
!3520 = !DILocation(line: 2869, column: 9, scope: !3488)
!3521 = distinct !DISubprogram(name: "MPU_xTimerIsTimerActiveImpl", scope: !36, file: !36, line: 2878, type: !3522, scopeLine: 2879, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3522 = !DISubroutineType(types: !3523)
!3523 = !{!23, !50}
!3524 = !DILocalVariable(name: "xTimer", arg: 1, scope: !3521, file: !36, line: 2878, type: !50)
!3525 = !DILocation(line: 2878, column: 63, scope: !3521)
!3526 = !DILocalVariable(name: "xReturn", scope: !3521, file: !36, line: 2880, type: !23)
!3527 = !DILocation(line: 2880, column: 24, scope: !3521)
!3528 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3521, file: !36, line: 2881, type: !50)
!3529 = !DILocation(line: 2881, column: 27, scope: !3521)
!3530 = !DILocalVariable(name: "lIndex", scope: !3521, file: !36, line: 2882, type: !27)
!3531 = !DILocation(line: 2882, column: 21, scope: !3521)
!3532 = !DILocation(line: 2884, column: 34, scope: !3521)
!3533 = !DILocation(line: 2884, column: 22, scope: !3521)
!3534 = !DILocation(line: 2884, column: 20, scope: !3521)
!3535 = !DILocation(line: 2886, column: 17, scope: !3536)
!3536 = distinct !DILexicalBlock(scope: !3521, file: !36, line: 2886, column: 17)
!3537 = !DILocation(line: 0, scope: !3536)
!3538 = !DILocation(line: 2886, column: 51, scope: !3536)
!3539 = !DILocation(line: 2886, column: 17, scope: !3521)
!3540 = !DILocation(line: 2888, column: 40, scope: !3541)
!3541 = distinct !DILexicalBlock(scope: !3536, file: !36, line: 2887, column: 13)
!3542 = !DILocation(line: 2888, column: 38, scope: !3541)
!3543 = !DILocation(line: 2890, column: 21, scope: !3544)
!3544 = distinct !DILexicalBlock(scope: !3541, file: !36, line: 2890, column: 21)
!3545 = !DILocation(line: 2890, column: 42, scope: !3544)
!3546 = !DILocation(line: 2890, column: 21, scope: !3541)
!3547 = !DILocation(line: 2892, column: 52, scope: !3548)
!3548 = distinct !DILexicalBlock(scope: !3544, file: !36, line: 2891, column: 17)
!3549 = !DILocation(line: 2892, column: 31, scope: !3548)
!3550 = !DILocation(line: 2892, column: 29, scope: !3548)
!3551 = !DILocation(line: 2893, column: 17, scope: !3548)
!3552 = !DILocation(line: 2894, column: 13, scope: !3541)
!3553 = !DILocation(line: 2896, column: 20, scope: !3521)
!3554 = !DILocation(line: 2896, column: 13, scope: !3521)
!3555 = distinct !DISubprogram(name: "MPU_xTimerGetTimerDaemonTaskHandleImpl", scope: !36, file: !36, line: 2906, type: !429, scopeLine: 2907, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3556 = !DILocalVariable(name: "xReturn", scope: !3555, file: !36, line: 2908, type: !32)
!3557 = !DILocation(line: 2908, column: 26, scope: !3555)
!3558 = !DILocation(line: 2910, column: 23, scope: !3555)
!3559 = !DILocation(line: 2910, column: 21, scope: !3555)
!3560 = !DILocation(line: 2912, column: 20, scope: !3555)
!3561 = !DILocation(line: 2912, column: 13, scope: !3555)
!3562 = distinct !DISubprogram(name: "MPU_xTimerGenericCommandImpl", scope: !36, file: !36, line: 2926, type: !3563, scopeLine: 2931, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3563 = !DISubroutineType(types: !3564)
!3564 = !{!23, !50, !3145, !3565, !3144, !3565}
!3565 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !119)
!3566 = !DILocalVariable(name: "xTimer", arg: 1, scope: !3562, file: !36, line: 2926, type: !50)
!3567 = !DILocation(line: 2926, column: 64, scope: !3562)
!3568 = !DILocalVariable(name: "xCommandID", arg: 2, scope: !3562, file: !36, line: 2927, type: !3145)
!3569 = !DILocation(line: 2927, column: 67, scope: !3562)
!3570 = !DILocalVariable(name: "xOptionalValue", arg: 3, scope: !3562, file: !36, line: 2928, type: !3565)
!3571 = !DILocation(line: 2928, column: 67, scope: !3562)
!3572 = !DILocalVariable(name: "pxHigherPriorityTaskWoken", arg: 4, scope: !3562, file: !36, line: 2929, type: !3144)
!3573 = !DILocation(line: 2929, column: 69, scope: !3562)
!3574 = !DILocalVariable(name: "xTicksToWait", arg: 5, scope: !3562, file: !36, line: 2930, type: !3565)
!3575 = !DILocation(line: 2930, column: 67, scope: !3562)
!3576 = !DILocalVariable(name: "xReturn", scope: !3562, file: !36, line: 2932, type: !23)
!3577 = !DILocation(line: 2932, column: 24, scope: !3562)
!3578 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3562, file: !36, line: 2933, type: !50)
!3579 = !DILocation(line: 2933, column: 27, scope: !3562)
!3580 = !DILocalVariable(name: "lIndex", scope: !3562, file: !36, line: 2934, type: !27)
!3581 = !DILocation(line: 2934, column: 21, scope: !3562)
!3582 = !DILocalVariable(name: "xIsHigherPriorityTaskWokenWriteable", scope: !3562, file: !36, line: 2935, type: !23)
!3583 = !DILocation(line: 2935, column: 24, scope: !3562)
!3584 = !DILocation(line: 2937, column: 17, scope: !3585)
!3585 = distinct !DILexicalBlock(scope: !3562, file: !36, line: 2937, column: 17)
!3586 = !DILocation(line: 2937, column: 43, scope: !3585)
!3587 = !DILocation(line: 2937, column: 17, scope: !3562)
!3588 = !DILocation(line: 2939, column: 88, scope: !3589)
!3589 = distinct !DILexicalBlock(scope: !3585, file: !36, line: 2938, column: 13)
!3590 = !DILocation(line: 2939, column: 55, scope: !3589)
!3591 = !DILocation(line: 2939, column: 53, scope: !3589)
!3592 = !DILocation(line: 2942, column: 13, scope: !3589)
!3593 = !DILocation(line: 2944, column: 19, scope: !3594)
!3594 = distinct !DILexicalBlock(scope: !3562, file: !36, line: 2944, column: 17)
!3595 = !DILocation(line: 2944, column: 45, scope: !3594)
!3596 = !DILocation(line: 2944, column: 55, scope: !3594)
!3597 = !DILocation(line: 2944, column: 60, scope: !3594)
!3598 = !DILocation(line: 2944, column: 96, scope: !3594)
!3599 = !DILocation(line: 2944, column: 17, scope: !3562)
!3600 = !DILocation(line: 2946, column: 38, scope: !3601)
!3601 = distinct !DILexicalBlock(scope: !3594, file: !36, line: 2945, column: 13)
!3602 = !DILocation(line: 2946, column: 26, scope: !3601)
!3603 = !DILocation(line: 2946, column: 24, scope: !3601)
!3604 = !DILocation(line: 2948, column: 21, scope: !3605)
!3605 = distinct !DILexicalBlock(scope: !3601, file: !36, line: 2948, column: 21)
!3606 = !DILocation(line: 0, scope: !3605)
!3607 = !DILocation(line: 2948, column: 55, scope: !3605)
!3608 = !DILocation(line: 2948, column: 21, scope: !3601)
!3609 = !DILocation(line: 2950, column: 44, scope: !3610)
!3610 = distinct !DILexicalBlock(scope: !3605, file: !36, line: 2949, column: 17)
!3611 = !DILocation(line: 2950, column: 42, scope: !3610)
!3612 = !DILocation(line: 2952, column: 25, scope: !3613)
!3613 = distinct !DILexicalBlock(scope: !3610, file: !36, line: 2952, column: 25)
!3614 = !DILocation(line: 2952, column: 46, scope: !3613)
!3615 = !DILocation(line: 2952, column: 25, scope: !3610)
!3616 = !DILocation(line: 2954, column: 57, scope: !3617)
!3617 = distinct !DILexicalBlock(scope: !3613, file: !36, line: 2953, column: 21)
!3618 = !DILocation(line: 2954, column: 79, scope: !3617)
!3619 = !DILocation(line: 2954, column: 91, scope: !3617)
!3620 = !DILocation(line: 2954, column: 107, scope: !3617)
!3621 = !DILocation(line: 2954, column: 134, scope: !3617)
!3622 = !DILocation(line: 2954, column: 35, scope: !3617)
!3623 = !DILocation(line: 2954, column: 33, scope: !3617)
!3624 = !DILocation(line: 2955, column: 21, scope: !3617)
!3625 = !DILocation(line: 2956, column: 17, scope: !3610)
!3626 = !DILocation(line: 2957, column: 13, scope: !3601)
!3627 = !DILocation(line: 2959, column: 20, scope: !3562)
!3628 = !DILocation(line: 2959, column: 13, scope: !3562)
!3629 = distinct !DISubprogram(name: "MPU_pcTimerGetNameImpl", scope: !36, file: !36, line: 2969, type: !3630, scopeLine: 2970, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3630 = !DISubroutineType(types: !3631)
!3631 = !{!356, !50}
!3632 = !DILocalVariable(name: "xTimer", arg: 1, scope: !3629, file: !36, line: 2969, type: !50)
!3633 = !DILocation(line: 2969, column: 60, scope: !3629)
!3634 = !DILocalVariable(name: "pcReturn", scope: !3629, file: !36, line: 2971, type: !356)
!3635 = !DILocation(line: 2971, column: 26, scope: !3629)
!3636 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3629, file: !36, line: 2972, type: !50)
!3637 = !DILocation(line: 2972, column: 27, scope: !3629)
!3638 = !DILocalVariable(name: "lIndex", scope: !3629, file: !36, line: 2973, type: !27)
!3639 = !DILocation(line: 2973, column: 21, scope: !3629)
!3640 = !DILocation(line: 2975, column: 34, scope: !3629)
!3641 = !DILocation(line: 2975, column: 22, scope: !3629)
!3642 = !DILocation(line: 2975, column: 20, scope: !3629)
!3643 = !DILocation(line: 2977, column: 17, scope: !3644)
!3644 = distinct !DILexicalBlock(scope: !3629, file: !36, line: 2977, column: 17)
!3645 = !DILocation(line: 0, scope: !3644)
!3646 = !DILocation(line: 2977, column: 51, scope: !3644)
!3647 = !DILocation(line: 2977, column: 17, scope: !3629)
!3648 = !DILocation(line: 2979, column: 40, scope: !3649)
!3649 = distinct !DILexicalBlock(scope: !3644, file: !36, line: 2978, column: 13)
!3650 = !DILocation(line: 2979, column: 38, scope: !3649)
!3651 = !DILocation(line: 2981, column: 21, scope: !3652)
!3652 = distinct !DILexicalBlock(scope: !3649, file: !36, line: 2981, column: 21)
!3653 = !DILocation(line: 2981, column: 42, scope: !3652)
!3654 = !DILocation(line: 2981, column: 21, scope: !3649)
!3655 = !DILocation(line: 2983, column: 48, scope: !3656)
!3656 = distinct !DILexicalBlock(scope: !3652, file: !36, line: 2982, column: 17)
!3657 = !DILocation(line: 2983, column: 32, scope: !3656)
!3658 = !DILocation(line: 2983, column: 30, scope: !3656)
!3659 = !DILocation(line: 2984, column: 17, scope: !3656)
!3660 = !DILocation(line: 2985, column: 13, scope: !3649)
!3661 = !DILocation(line: 2987, column: 20, scope: !3629)
!3662 = !DILocation(line: 2987, column: 13, scope: !3629)
!3663 = distinct !DISubprogram(name: "MPU_vTimerSetReloadModeImpl", scope: !36, file: !36, line: 2998, type: !3664, scopeLine: 3000, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3664 = !DISubroutineType(types: !3665)
!3665 = !{null, !50, !2807}
!3666 = !DILocalVariable(name: "xTimer", arg: 1, scope: !3663, file: !36, line: 2998, type: !50)
!3667 = !DILocation(line: 2998, column: 57, scope: !3663)
!3668 = !DILocalVariable(name: "uxAutoReload", arg: 2, scope: !3663, file: !36, line: 2999, type: !2807)
!3669 = !DILocation(line: 2999, column: 61, scope: !3663)
!3670 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3663, file: !36, line: 3001, type: !50)
!3671 = !DILocation(line: 3001, column: 27, scope: !3663)
!3672 = !DILocalVariable(name: "lIndex", scope: !3663, file: !36, line: 3002, type: !27)
!3673 = !DILocation(line: 3002, column: 21, scope: !3663)
!3674 = !DILocation(line: 3004, column: 34, scope: !3663)
!3675 = !DILocation(line: 3004, column: 22, scope: !3663)
!3676 = !DILocation(line: 3004, column: 20, scope: !3663)
!3677 = !DILocation(line: 3006, column: 17, scope: !3678)
!3678 = distinct !DILexicalBlock(scope: !3663, file: !36, line: 3006, column: 17)
!3679 = !DILocation(line: 0, scope: !3678)
!3680 = !DILocation(line: 3006, column: 51, scope: !3678)
!3681 = !DILocation(line: 3006, column: 17, scope: !3663)
!3682 = !DILocation(line: 3008, column: 40, scope: !3683)
!3683 = distinct !DILexicalBlock(scope: !3678, file: !36, line: 3007, column: 13)
!3684 = !DILocation(line: 3008, column: 38, scope: !3683)
!3685 = !DILocation(line: 3010, column: 21, scope: !3686)
!3686 = distinct !DILexicalBlock(scope: !3683, file: !36, line: 3010, column: 21)
!3687 = !DILocation(line: 3010, column: 42, scope: !3686)
!3688 = !DILocation(line: 3010, column: 21, scope: !3683)
!3689 = !DILocation(line: 3012, column: 42, scope: !3690)
!3690 = distinct !DILexicalBlock(scope: !3686, file: !36, line: 3011, column: 17)
!3691 = !DILocation(line: 3012, column: 64, scope: !3690)
!3692 = !DILocation(line: 3012, column: 21, scope: !3690)
!3693 = !DILocation(line: 3013, column: 17, scope: !3690)
!3694 = !DILocation(line: 3014, column: 13, scope: !3683)
!3695 = !DILocation(line: 3015, column: 9, scope: !3663)
!3696 = distinct !DISubprogram(name: "MPU_xTimerGetReloadModeImpl", scope: !36, file: !36, line: 3024, type: !3522, scopeLine: 3025, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3697 = !DILocalVariable(name: "xTimer", arg: 1, scope: !3696, file: !36, line: 3024, type: !50)
!3698 = !DILocation(line: 3024, column: 63, scope: !3696)
!3699 = !DILocalVariable(name: "xReturn", scope: !3696, file: !36, line: 3026, type: !23)
!3700 = !DILocation(line: 3026, column: 24, scope: !3696)
!3701 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3696, file: !36, line: 3027, type: !50)
!3702 = !DILocation(line: 3027, column: 27, scope: !3696)
!3703 = !DILocalVariable(name: "lIndex", scope: !3696, file: !36, line: 3028, type: !27)
!3704 = !DILocation(line: 3028, column: 21, scope: !3696)
!3705 = !DILocation(line: 3030, column: 34, scope: !3696)
!3706 = !DILocation(line: 3030, column: 22, scope: !3696)
!3707 = !DILocation(line: 3030, column: 20, scope: !3696)
!3708 = !DILocation(line: 3032, column: 17, scope: !3709)
!3709 = distinct !DILexicalBlock(scope: !3696, file: !36, line: 3032, column: 17)
!3710 = !DILocation(line: 0, scope: !3709)
!3711 = !DILocation(line: 3032, column: 51, scope: !3709)
!3712 = !DILocation(line: 3032, column: 17, scope: !3696)
!3713 = !DILocation(line: 3034, column: 40, scope: !3714)
!3714 = distinct !DILexicalBlock(scope: !3709, file: !36, line: 3033, column: 13)
!3715 = !DILocation(line: 3034, column: 38, scope: !3714)
!3716 = !DILocation(line: 3036, column: 21, scope: !3717)
!3717 = distinct !DILexicalBlock(scope: !3714, file: !36, line: 3036, column: 21)
!3718 = !DILocation(line: 3036, column: 42, scope: !3717)
!3719 = !DILocation(line: 3036, column: 21, scope: !3714)
!3720 = !DILocation(line: 3038, column: 52, scope: !3721)
!3721 = distinct !DILexicalBlock(scope: !3717, file: !36, line: 3037, column: 17)
!3722 = !DILocation(line: 3038, column: 31, scope: !3721)
!3723 = !DILocation(line: 3038, column: 29, scope: !3721)
!3724 = !DILocation(line: 3039, column: 17, scope: !3721)
!3725 = !DILocation(line: 3040, column: 13, scope: !3714)
!3726 = !DILocation(line: 3042, column: 20, scope: !3696)
!3727 = !DILocation(line: 3042, column: 13, scope: !3696)
!3728 = distinct !DISubprogram(name: "MPU_uxTimerGetReloadModeImpl", scope: !36, file: !36, line: 3052, type: !3729, scopeLine: 3053, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3729 = !DISubroutineType(types: !3730)
!3730 = !{!39, !50}
!3731 = !DILocalVariable(name: "xTimer", arg: 1, scope: !3728, file: !36, line: 3052, type: !50)
!3732 = !DILocation(line: 3052, column: 65, scope: !3728)
!3733 = !DILocalVariable(name: "uxReturn", scope: !3728, file: !36, line: 3054, type: !39)
!3734 = !DILocation(line: 3054, column: 25, scope: !3728)
!3735 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3728, file: !36, line: 3055, type: !50)
!3736 = !DILocation(line: 3055, column: 27, scope: !3728)
!3737 = !DILocalVariable(name: "lIndex", scope: !3728, file: !36, line: 3056, type: !27)
!3738 = !DILocation(line: 3056, column: 21, scope: !3728)
!3739 = !DILocation(line: 3058, column: 34, scope: !3728)
!3740 = !DILocation(line: 3058, column: 22, scope: !3728)
!3741 = !DILocation(line: 3058, column: 20, scope: !3728)
!3742 = !DILocation(line: 3060, column: 17, scope: !3743)
!3743 = distinct !DILexicalBlock(scope: !3728, file: !36, line: 3060, column: 17)
!3744 = !DILocation(line: 0, scope: !3743)
!3745 = !DILocation(line: 3060, column: 51, scope: !3743)
!3746 = !DILocation(line: 3060, column: 17, scope: !3728)
!3747 = !DILocation(line: 3062, column: 40, scope: !3748)
!3748 = distinct !DILexicalBlock(scope: !3743, file: !36, line: 3061, column: 13)
!3749 = !DILocation(line: 3062, column: 38, scope: !3748)
!3750 = !DILocation(line: 3064, column: 21, scope: !3751)
!3751 = distinct !DILexicalBlock(scope: !3748, file: !36, line: 3064, column: 21)
!3752 = !DILocation(line: 3064, column: 42, scope: !3751)
!3753 = !DILocation(line: 3064, column: 21, scope: !3748)
!3754 = !DILocation(line: 3066, column: 54, scope: !3755)
!3755 = distinct !DILexicalBlock(scope: !3751, file: !36, line: 3065, column: 17)
!3756 = !DILocation(line: 3066, column: 32, scope: !3755)
!3757 = !DILocation(line: 3066, column: 30, scope: !3755)
!3758 = !DILocation(line: 3067, column: 17, scope: !3755)
!3759 = !DILocation(line: 3068, column: 13, scope: !3748)
!3760 = !DILocation(line: 3070, column: 20, scope: !3728)
!3761 = !DILocation(line: 3070, column: 13, scope: !3728)
!3762 = distinct !DISubprogram(name: "MPU_xTimerGetPeriodImpl", scope: !36, file: !36, line: 3080, type: !3763, scopeLine: 3081, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3763 = !DISubroutineType(types: !3764)
!3764 = !{!119, !50}
!3765 = !DILocalVariable(name: "xTimer", arg: 1, scope: !3762, file: !36, line: 3080, type: !50)
!3766 = !DILocation(line: 3080, column: 59, scope: !3762)
!3767 = !DILocalVariable(name: "xReturn", scope: !3762, file: !36, line: 3082, type: !119)
!3768 = !DILocation(line: 3082, column: 24, scope: !3762)
!3769 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3762, file: !36, line: 3083, type: !50)
!3770 = !DILocation(line: 3083, column: 27, scope: !3762)
!3771 = !DILocalVariable(name: "lIndex", scope: !3762, file: !36, line: 3084, type: !27)
!3772 = !DILocation(line: 3084, column: 21, scope: !3762)
!3773 = !DILocation(line: 3086, column: 34, scope: !3762)
!3774 = !DILocation(line: 3086, column: 22, scope: !3762)
!3775 = !DILocation(line: 3086, column: 20, scope: !3762)
!3776 = !DILocation(line: 3088, column: 17, scope: !3777)
!3777 = distinct !DILexicalBlock(scope: !3762, file: !36, line: 3088, column: 17)
!3778 = !DILocation(line: 0, scope: !3777)
!3779 = !DILocation(line: 3088, column: 51, scope: !3777)
!3780 = !DILocation(line: 3088, column: 17, scope: !3762)
!3781 = !DILocation(line: 3090, column: 40, scope: !3782)
!3782 = distinct !DILexicalBlock(scope: !3777, file: !36, line: 3089, column: 13)
!3783 = !DILocation(line: 3090, column: 38, scope: !3782)
!3784 = !DILocation(line: 3092, column: 21, scope: !3785)
!3785 = distinct !DILexicalBlock(scope: !3782, file: !36, line: 3092, column: 21)
!3786 = !DILocation(line: 3092, column: 42, scope: !3785)
!3787 = !DILocation(line: 3092, column: 21, scope: !3782)
!3788 = !DILocation(line: 3094, column: 48, scope: !3789)
!3789 = distinct !DILexicalBlock(scope: !3785, file: !36, line: 3093, column: 17)
!3790 = !DILocation(line: 3094, column: 31, scope: !3789)
!3791 = !DILocation(line: 3094, column: 29, scope: !3789)
!3792 = !DILocation(line: 3095, column: 17, scope: !3789)
!3793 = !DILocation(line: 3096, column: 13, scope: !3782)
!3794 = !DILocation(line: 3098, column: 20, scope: !3762)
!3795 = !DILocation(line: 3098, column: 13, scope: !3762)
!3796 = distinct !DISubprogram(name: "MPU_xTimerGetExpiryTimeImpl", scope: !36, file: !36, line: 3108, type: !3763, scopeLine: 3109, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3797 = !DILocalVariable(name: "xTimer", arg: 1, scope: !3796, file: !36, line: 3108, type: !50)
!3798 = !DILocation(line: 3108, column: 63, scope: !3796)
!3799 = !DILocalVariable(name: "xReturn", scope: !3796, file: !36, line: 3110, type: !119)
!3800 = !DILocation(line: 3110, column: 24, scope: !3796)
!3801 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3796, file: !36, line: 3111, type: !50)
!3802 = !DILocation(line: 3111, column: 27, scope: !3796)
!3803 = !DILocalVariable(name: "lIndex", scope: !3796, file: !36, line: 3112, type: !27)
!3804 = !DILocation(line: 3112, column: 21, scope: !3796)
!3805 = !DILocation(line: 3114, column: 34, scope: !3796)
!3806 = !DILocation(line: 3114, column: 22, scope: !3796)
!3807 = !DILocation(line: 3114, column: 20, scope: !3796)
!3808 = !DILocation(line: 3116, column: 17, scope: !3809)
!3809 = distinct !DILexicalBlock(scope: !3796, file: !36, line: 3116, column: 17)
!3810 = !DILocation(line: 0, scope: !3809)
!3811 = !DILocation(line: 3116, column: 51, scope: !3809)
!3812 = !DILocation(line: 3116, column: 17, scope: !3796)
!3813 = !DILocation(line: 3118, column: 40, scope: !3814)
!3814 = distinct !DILexicalBlock(scope: !3809, file: !36, line: 3117, column: 13)
!3815 = !DILocation(line: 3118, column: 38, scope: !3814)
!3816 = !DILocation(line: 3120, column: 21, scope: !3817)
!3817 = distinct !DILexicalBlock(scope: !3814, file: !36, line: 3120, column: 21)
!3818 = !DILocation(line: 3120, column: 42, scope: !3817)
!3819 = !DILocation(line: 3120, column: 21, scope: !3814)
!3820 = !DILocation(line: 3122, column: 52, scope: !3821)
!3821 = distinct !DILexicalBlock(scope: !3817, file: !36, line: 3121, column: 17)
!3822 = !DILocation(line: 3122, column: 31, scope: !3821)
!3823 = !DILocation(line: 3122, column: 29, scope: !3821)
!3824 = !DILocation(line: 3123, column: 17, scope: !3821)
!3825 = !DILocation(line: 3124, column: 13, scope: !3814)
!3826 = !DILocation(line: 3126, column: 20, scope: !3796)
!3827 = !DILocation(line: 3126, column: 13, scope: !3796)
!3828 = distinct !DISubprogram(name: "MPU_xTimerCreate", scope: !36, file: !36, line: 3139, type: !3829, scopeLine: 3144, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3829 = !DISubroutineType(types: !3830)
!3830 = !{!50, !1377, !3565, !2807, !1543, !62}
!3831 = !DILocalVariable(name: "pcTimerName", arg: 1, scope: !3828, file: !36, line: 3139, type: !1377)
!3832 = !DILocation(line: 3139, column: 60, scope: !3828)
!3833 = !DILocalVariable(name: "xTimerPeriodInTicks", arg: 2, scope: !3828, file: !36, line: 3140, type: !3565)
!3834 = !DILocation(line: 3140, column: 58, scope: !3828)
!3835 = !DILocalVariable(name: "uxAutoReload", arg: 3, scope: !3828, file: !36, line: 3141, type: !2807)
!3836 = !DILocation(line: 3141, column: 59, scope: !3828)
!3837 = !DILocalVariable(name: "pvTimerID", arg: 4, scope: !3828, file: !36, line: 3142, type: !1543)
!3838 = !DILocation(line: 3142, column: 54, scope: !3828)
!3839 = !DILocalVariable(name: "pxCallbackFunction", arg: 5, scope: !3828, file: !36, line: 3143, type: !62)
!3840 = !DILocation(line: 3143, column: 65, scope: !3828)
!3841 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3828, file: !36, line: 3145, type: !50)
!3842 = !DILocation(line: 3145, column: 27, scope: !3828)
!3843 = !DILocalVariable(name: "xExternalTimerHandle", scope: !3828, file: !36, line: 3146, type: !50)
!3844 = !DILocation(line: 3146, column: 27, scope: !3828)
!3845 = !DILocalVariable(name: "lIndex", scope: !3828, file: !36, line: 3147, type: !27)
!3846 = !DILocation(line: 3147, column: 21, scope: !3828)
!3847 = !DILocation(line: 3149, column: 22, scope: !3828)
!3848 = !DILocation(line: 3149, column: 20, scope: !3828)
!3849 = !DILocation(line: 3151, column: 17, scope: !3850)
!3850 = distinct !DILexicalBlock(scope: !3828, file: !36, line: 3151, column: 17)
!3851 = !DILocation(line: 3151, column: 24, scope: !3850)
!3852 = !DILocation(line: 3151, column: 17, scope: !3828)
!3853 = !DILocation(line: 3153, column: 54, scope: !3854)
!3854 = distinct !DILexicalBlock(scope: !3850, file: !36, line: 3152, column: 13)
!3855 = !DILocation(line: 3153, column: 67, scope: !3854)
!3856 = !DILocation(line: 3153, column: 88, scope: !3854)
!3857 = !DILocation(line: 3153, column: 102, scope: !3854)
!3858 = !DILocation(line: 3153, column: 40, scope: !3854)
!3859 = !DILocation(line: 3153, column: 38, scope: !3854)
!3860 = !DILocation(line: 3155, column: 21, scope: !3861)
!3861 = distinct !DILexicalBlock(scope: !3854, file: !36, line: 3155, column: 21)
!3862 = !DILocation(line: 3155, column: 42, scope: !3861)
!3863 = !DILocation(line: 3155, column: 21, scope: !3854)
!3864 = !DILocation(line: 3157, column: 21, scope: !3865)
!3865 = distinct !DILexicalBlock(scope: !3861, file: !36, line: 3156, column: 17)
!3866 = !DILocation(line: 3158, column: 62, scope: !3865)
!3867 = !DILocation(line: 3158, column: 44, scope: !3865)
!3868 = !DILocation(line: 3158, column: 42, scope: !3865)
!3869 = !DILocation(line: 3159, column: 17, scope: !3865)
!3870 = !DILocation(line: 3162, column: 57, scope: !3871)
!3871 = distinct !DILexicalBlock(scope: !3861, file: !36, line: 3161, column: 17)
!3872 = !DILocation(line: 3162, column: 21, scope: !3871)
!3873 = !DILocation(line: 3164, column: 13, scope: !3854)
!3874 = !DILocation(line: 3166, column: 20, scope: !3828)
!3875 = !DILocation(line: 3166, column: 13, scope: !3828)
!3876 = distinct !DISubprogram(name: "MPU_TimerCallback", scope: !36, file: !36, line: 325, type: !64, scopeLine: 326, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3877 = !DILocalVariable(name: "xInternalHandle", arg: 1, scope: !3876, file: !36, line: 325, type: !50)
!3878 = !DILocation(line: 325, column: 54, scope: !3876)
!3879 = !DILocalVariable(name: "i", scope: !3876, file: !36, line: 327, type: !27)
!3880 = !DILocation(line: 327, column: 21, scope: !3876)
!3881 = !DILocalVariable(name: "lIndex", scope: !3876, file: !36, line: 327, type: !27)
!3882 = !DILocation(line: 327, column: 24, scope: !3876)
!3883 = !DILocalVariable(name: "xExternalHandle", scope: !3876, file: !36, line: 328, type: !50)
!3884 = !DILocation(line: 328, column: 27, scope: !3876)
!3885 = !DILocalVariable(name: "pxApplicationCallBack", scope: !3876, file: !36, line: 329, type: !62)
!3886 = !DILocation(line: 329, column: 37, scope: !3876)
!3887 = !DILocation(line: 332, column: 13, scope: !3888)
!3888 = distinct !DILexicalBlock(scope: !3876, file: !36, line: 332, column: 13)
!3889 = !DILocation(line: 332, column: 13, scope: !3876)
!3890 = !DILocation(line: 334, column: 20, scope: !3891)
!3891 = distinct !DILexicalBlock(scope: !3876, file: !36, line: 334, column: 13)
!3892 = !DILocation(line: 334, column: 18, scope: !3891)
!3893 = !DILocation(line: 334, column: 25, scope: !3894)
!3894 = distinct !DILexicalBlock(scope: !3891, file: !36, line: 334, column: 13)
!3895 = !DILocation(line: 334, column: 27, scope: !3894)
!3896 = !DILocation(line: 334, column: 13, scope: !3891)
!3897 = !DILocation(line: 336, column: 60, scope: !3898)
!3898 = distinct !DILexicalBlock(scope: !3899, file: !36, line: 336, column: 21)
!3899 = distinct !DILexicalBlock(scope: !3894, file: !36, line: 335, column: 13)
!3900 = !DILocation(line: 336, column: 41, scope: !3898)
!3901 = !DILocation(line: 336, column: 64, scope: !3898)
!3902 = !DILocation(line: 336, column: 23, scope: !3898)
!3903 = !DILocation(line: 336, column: 89, scope: !3898)
!3904 = !DILocation(line: 336, column: 86, scope: !3898)
!3905 = !DILocation(line: 336, column: 107, scope: !3898)
!3906 = !DILocation(line: 337, column: 42, scope: !3898)
!3907 = !DILocation(line: 337, column: 23, scope: !3898)
!3908 = !DILocation(line: 337, column: 46, scope: !3898)
!3909 = !DILocation(line: 337, column: 65, scope: !3898)
!3910 = !DILocation(line: 336, column: 21, scope: !3899)
!3911 = !DILocation(line: 339, column: 30, scope: !3912)
!3912 = distinct !DILexicalBlock(scope: !3898, file: !36, line: 338, column: 17)
!3913 = !DILocation(line: 339, column: 28, scope: !3912)
!3914 = !DILocation(line: 340, column: 21, scope: !3912)
!3915 = !DILocation(line: 342, column: 13, scope: !3899)
!3916 = !DILocation(line: 334, column: 71, scope: !3894)
!3917 = !DILocation(line: 334, column: 13, scope: !3894)
!3918 = distinct !{!3918, !3896, !3919}
!3919 = !DILocation(line: 342, column: 13, scope: !3891)
!3920 = !DILocation(line: 344, column: 13, scope: !3921)
!3921 = distinct !DILexicalBlock(scope: !3876, file: !36, line: 344, column: 13)
!3922 = !DILocation(line: 344, column: 13, scope: !3876)
!3923 = !DILocation(line: 345, column: 49, scope: !3876)
!3924 = !DILocation(line: 345, column: 31, scope: !3876)
!3925 = !DILocation(line: 345, column: 29, scope: !3876)
!3926 = !DILocation(line: 347, column: 84, scope: !3876)
!3927 = !DILocation(line: 347, column: 65, scope: !3876)
!3928 = !DILocation(line: 347, column: 93, scope: !3876)
!3929 = !DILocation(line: 347, column: 37, scope: !3876)
!3930 = !DILocation(line: 347, column: 35, scope: !3876)
!3931 = !DILocation(line: 348, column: 13, scope: !3876)
!3932 = !DILocation(line: 348, column: 36, scope: !3876)
!3933 = !DILocation(line: 349, column: 9, scope: !3876)
!3934 = distinct !DISubprogram(name: "MPU_xTimerCreateStatic", scope: !36, file: !36, line: 3174, type: !3935, scopeLine: 3180, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3935 = !DISubroutineType(types: !3936)
!3936 = !{!50, !1377, !3565, !2807, !1543, !62, !3937}
!3937 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3938, size: 64)
!3938 = !DIDerivedType(tag: DW_TAG_typedef, name: "StaticTimer_t", file: !1548, line: 1417, baseType: !3939)
!3939 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xSTATIC_TIMER", file: !1548, line: 1406, size: 704, elements: !3940)
!3940 = !{!3941, !3942, !3943, !3944, !3945, !3946, !3947}
!3941 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy1", scope: !3939, file: !1548, line: 1408, baseType: !26, size: 64)
!3942 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy2", scope: !3939, file: !1548, line: 1409, baseType: !1569, size: 320, offset: 64)
!3943 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy3", scope: !3939, file: !1548, line: 1410, baseType: !119, size: 64, offset: 384)
!3944 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy5", scope: !3939, file: !1548, line: 1411, baseType: !26, size: 64, offset: 448)
!3945 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy6", scope: !3939, file: !1548, line: 1412, baseType: !97, size: 64, offset: 512)
!3946 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy7", scope: !3939, file: !1548, line: 1414, baseType: !39, size: 64, offset: 576)
!3947 = !DIDerivedType(tag: DW_TAG_member, name: "ucDummy8", scope: !3939, file: !1548, line: 1416, baseType: !1583, size: 8, offset: 640)
!3948 = !DILocalVariable(name: "pcTimerName", arg: 1, scope: !3934, file: !36, line: 3174, type: !1377)
!3949 = !DILocation(line: 3174, column: 66, scope: !3934)
!3950 = !DILocalVariable(name: "xTimerPeriodInTicks", arg: 2, scope: !3934, file: !36, line: 3175, type: !3565)
!3951 = !DILocation(line: 3175, column: 64, scope: !3934)
!3952 = !DILocalVariable(name: "uxAutoReload", arg: 3, scope: !3934, file: !36, line: 3176, type: !2807)
!3953 = !DILocation(line: 3176, column: 65, scope: !3934)
!3954 = !DILocalVariable(name: "pvTimerID", arg: 4, scope: !3934, file: !36, line: 3177, type: !1543)
!3955 = !DILocation(line: 3177, column: 60, scope: !3934)
!3956 = !DILocalVariable(name: "pxCallbackFunction", arg: 5, scope: !3934, file: !36, line: 3178, type: !62)
!3957 = !DILocation(line: 3178, column: 71, scope: !3934)
!3958 = !DILocalVariable(name: "pxTimerBuffer", arg: 6, scope: !3934, file: !36, line: 3179, type: !3937)
!3959 = !DILocation(line: 3179, column: 63, scope: !3934)
!3960 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3934, file: !36, line: 3181, type: !50)
!3961 = !DILocation(line: 3181, column: 27, scope: !3934)
!3962 = !DILocalVariable(name: "xExternalTimerHandle", scope: !3934, file: !36, line: 3182, type: !50)
!3963 = !DILocation(line: 3182, column: 27, scope: !3934)
!3964 = !DILocalVariable(name: "lIndex", scope: !3934, file: !36, line: 3183, type: !27)
!3965 = !DILocation(line: 3183, column: 21, scope: !3934)
!3966 = !DILocation(line: 3185, column: 22, scope: !3934)
!3967 = !DILocation(line: 3185, column: 20, scope: !3934)
!3968 = !DILocation(line: 3187, column: 17, scope: !3969)
!3969 = distinct !DILexicalBlock(scope: !3934, file: !36, line: 3187, column: 17)
!3970 = !DILocation(line: 3187, column: 24, scope: !3969)
!3971 = !DILocation(line: 3187, column: 17, scope: !3934)
!3972 = !DILocation(line: 3189, column: 60, scope: !3973)
!3973 = distinct !DILexicalBlock(scope: !3969, file: !36, line: 3188, column: 13)
!3974 = !DILocation(line: 3189, column: 73, scope: !3973)
!3975 = !DILocation(line: 3189, column: 94, scope: !3973)
!3976 = !DILocation(line: 3189, column: 108, scope: !3973)
!3977 = !DILocation(line: 3189, column: 138, scope: !3973)
!3978 = !DILocation(line: 3189, column: 40, scope: !3973)
!3979 = !DILocation(line: 3189, column: 38, scope: !3973)
!3980 = !DILocation(line: 3191, column: 21, scope: !3981)
!3981 = distinct !DILexicalBlock(scope: !3973, file: !36, line: 3191, column: 21)
!3982 = !DILocation(line: 3191, column: 42, scope: !3981)
!3983 = !DILocation(line: 3191, column: 21, scope: !3973)
!3984 = !DILocation(line: 3193, column: 21, scope: !3985)
!3985 = distinct !DILexicalBlock(scope: !3981, file: !36, line: 3192, column: 17)
!3986 = !DILocation(line: 3194, column: 62, scope: !3985)
!3987 = !DILocation(line: 3194, column: 44, scope: !3985)
!3988 = !DILocation(line: 3194, column: 42, scope: !3985)
!3989 = !DILocation(line: 3195, column: 17, scope: !3985)
!3990 = !DILocation(line: 3198, column: 57, scope: !3991)
!3991 = distinct !DILexicalBlock(scope: !3981, file: !36, line: 3197, column: 17)
!3992 = !DILocation(line: 3198, column: 21, scope: !3991)
!3993 = !DILocation(line: 3200, column: 13, scope: !3973)
!3994 = !DILocation(line: 3202, column: 20, scope: !3934)
!3995 = !DILocation(line: 3202, column: 13, scope: !3934)
!3996 = distinct !DISubprogram(name: "MPU_xTimerGetStaticBuffer", scope: !36, file: !36, line: 3210, type: !3997, scopeLine: 3212, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!3997 = !DISubroutineType(types: !3998)
!3998 = !{!23, !50, !3999}
!3999 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3937, size: 64)
!4000 = !DILocalVariable(name: "xTimer", arg: 1, scope: !3996, file: !36, line: 3210, type: !50)
!4001 = !DILocation(line: 3210, column: 61, scope: !3996)
!4002 = !DILocalVariable(name: "ppxTimerBuffer", arg: 2, scope: !3996, file: !36, line: 3211, type: !3999)
!4003 = !DILocation(line: 3211, column: 64, scope: !3996)
!4004 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3996, file: !36, line: 3213, type: !50)
!4005 = !DILocation(line: 3213, column: 27, scope: !3996)
!4006 = !DILocalVariable(name: "lIndex", scope: !3996, file: !36, line: 3214, type: !27)
!4007 = !DILocation(line: 3214, column: 21, scope: !3996)
!4008 = !DILocalVariable(name: "xReturn", scope: !3996, file: !36, line: 3215, type: !23)
!4009 = !DILocation(line: 3215, column: 24, scope: !3996)
!4010 = !DILocation(line: 3217, column: 34, scope: !3996)
!4011 = !DILocation(line: 3217, column: 22, scope: !3996)
!4012 = !DILocation(line: 3217, column: 20, scope: !3996)
!4013 = !DILocation(line: 3219, column: 17, scope: !4014)
!4014 = distinct !DILexicalBlock(scope: !3996, file: !36, line: 3219, column: 17)
!4015 = !DILocation(line: 0, scope: !4014)
!4016 = !DILocation(line: 3219, column: 51, scope: !4014)
!4017 = !DILocation(line: 3219, column: 17, scope: !3996)
!4018 = !DILocation(line: 3221, column: 40, scope: !4019)
!4019 = distinct !DILexicalBlock(scope: !4014, file: !36, line: 3220, column: 13)
!4020 = !DILocation(line: 3221, column: 38, scope: !4019)
!4021 = !DILocation(line: 3223, column: 21, scope: !4022)
!4022 = distinct !DILexicalBlock(scope: !4019, file: !36, line: 3223, column: 21)
!4023 = !DILocation(line: 3223, column: 42, scope: !4022)
!4024 = !DILocation(line: 3223, column: 21, scope: !4019)
!4025 = !DILocation(line: 3225, column: 54, scope: !4026)
!4026 = distinct !DILexicalBlock(scope: !4022, file: !36, line: 3224, column: 17)
!4027 = !DILocation(line: 3225, column: 76, scope: !4026)
!4028 = !DILocation(line: 3225, column: 31, scope: !4026)
!4029 = !DILocation(line: 3225, column: 29, scope: !4026)
!4030 = !DILocation(line: 3226, column: 17, scope: !4026)
!4031 = !DILocation(line: 3227, column: 13, scope: !4019)
!4032 = !DILocation(line: 3229, column: 20, scope: !3996)
!4033 = !DILocation(line: 3229, column: 13, scope: !3996)
!4034 = distinct !DISubprogram(name: "MPU_xEventGroupWaitBitsImpl", scope: !36, file: !36, line: 3245, type: !4035, scopeLine: 3250, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4035 = !DISubroutineType(types: !4036)
!4036 = !{!4037, !54, !4038, !3145, !3145, !119}
!4037 = !DIDerivedType(tag: DW_TAG_typedef, name: "EventBits_t", file: !55, line: 93, baseType: !119)
!4038 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4037)
!4039 = !DILocalVariable(name: "xEventGroup", arg: 1, scope: !4034, file: !36, line: 3245, type: !54)
!4040 = !DILocation(line: 3245, column: 65, scope: !4034)
!4041 = !DILocalVariable(name: "uxBitsToWaitFor", arg: 2, scope: !4034, file: !36, line: 3246, type: !4038)
!4042 = !DILocation(line: 3246, column: 64, scope: !4034)
!4043 = !DILocalVariable(name: "xClearOnExit", arg: 3, scope: !4034, file: !36, line: 3247, type: !3145)
!4044 = !DILocation(line: 3247, column: 63, scope: !4034)
!4045 = !DILocalVariable(name: "xWaitForAllBits", arg: 4, scope: !4034, file: !36, line: 3248, type: !3145)
!4046 = !DILocation(line: 3248, column: 63, scope: !4034)
!4047 = !DILocalVariable(name: "xTicksToWait", arg: 5, scope: !4034, file: !36, line: 3249, type: !119)
!4048 = !DILocation(line: 3249, column: 57, scope: !4034)
!4049 = !DILocalVariable(name: "xReturn", scope: !4034, file: !36, line: 3251, type: !4037)
!4050 = !DILocation(line: 3251, column: 21, scope: !4034)
!4051 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4034, file: !36, line: 3252, type: !54)
!4052 = !DILocation(line: 3252, column: 28, scope: !4034)
!4053 = !DILocalVariable(name: "lIndex", scope: !4034, file: !36, line: 3253, type: !27)
!4054 = !DILocation(line: 3253, column: 17, scope: !4034)
!4055 = !DILocation(line: 3255, column: 30, scope: !4034)
!4056 = !DILocation(line: 3255, column: 18, scope: !4034)
!4057 = !DILocation(line: 3255, column: 16, scope: !4034)
!4058 = !DILocation(line: 3257, column: 13, scope: !4059)
!4059 = distinct !DILexicalBlock(scope: !4034, file: !36, line: 3257, column: 13)
!4060 = !DILocation(line: 0, scope: !4059)
!4061 = !DILocation(line: 3257, column: 47, scope: !4059)
!4062 = !DILocation(line: 3257, column: 13, scope: !4034)
!4063 = !DILocation(line: 3259, column: 41, scope: !4064)
!4064 = distinct !DILexicalBlock(scope: !4059, file: !36, line: 3258, column: 9)
!4065 = !DILocation(line: 3259, column: 39, scope: !4064)
!4066 = !DILocation(line: 3261, column: 17, scope: !4067)
!4067 = distinct !DILexicalBlock(scope: !4064, file: !36, line: 3261, column: 17)
!4068 = !DILocation(line: 3261, column: 43, scope: !4067)
!4069 = !DILocation(line: 3261, column: 17, scope: !4064)
!4070 = !DILocation(line: 3263, column: 48, scope: !4071)
!4071 = distinct !DILexicalBlock(scope: !4067, file: !36, line: 3262, column: 13)
!4072 = !DILocation(line: 3263, column: 75, scope: !4071)
!4073 = !DILocation(line: 3263, column: 92, scope: !4071)
!4074 = !DILocation(line: 3263, column: 106, scope: !4071)
!4075 = !DILocation(line: 3263, column: 123, scope: !4071)
!4076 = !DILocation(line: 3263, column: 27, scope: !4071)
!4077 = !DILocation(line: 3263, column: 25, scope: !4071)
!4078 = !DILocation(line: 3264, column: 13, scope: !4071)
!4079 = !DILocation(line: 3265, column: 9, scope: !4064)
!4080 = !DILocation(line: 3267, column: 16, scope: !4034)
!4081 = !DILocation(line: 3267, column: 9, scope: !4034)
!4082 = distinct !DISubprogram(name: "MPU_xEventGroupClearBitsImpl", scope: !36, file: !36, line: 3274, type: !4083, scopeLine: 3276, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4083 = !DISubroutineType(types: !4084)
!4084 = !{!4037, !54, !4038}
!4085 = !DILocalVariable(name: "xEventGroup", arg: 1, scope: !4082, file: !36, line: 3274, type: !54)
!4086 = !DILocation(line: 3274, column: 66, scope: !4082)
!4087 = !DILocalVariable(name: "uxBitsToClear", arg: 2, scope: !4082, file: !36, line: 3275, type: !4038)
!4088 = !DILocation(line: 3275, column: 65, scope: !4082)
!4089 = !DILocalVariable(name: "xReturn", scope: !4082, file: !36, line: 3277, type: !4037)
!4090 = !DILocation(line: 3277, column: 21, scope: !4082)
!4091 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4082, file: !36, line: 3278, type: !54)
!4092 = !DILocation(line: 3278, column: 28, scope: !4082)
!4093 = !DILocalVariable(name: "lIndex", scope: !4082, file: !36, line: 3279, type: !27)
!4094 = !DILocation(line: 3279, column: 17, scope: !4082)
!4095 = !DILocation(line: 3281, column: 30, scope: !4082)
!4096 = !DILocation(line: 3281, column: 18, scope: !4082)
!4097 = !DILocation(line: 3281, column: 16, scope: !4082)
!4098 = !DILocation(line: 3283, column: 13, scope: !4099)
!4099 = distinct !DILexicalBlock(scope: !4082, file: !36, line: 3283, column: 13)
!4100 = !DILocation(line: 0, scope: !4099)
!4101 = !DILocation(line: 3283, column: 47, scope: !4099)
!4102 = !DILocation(line: 3283, column: 13, scope: !4082)
!4103 = !DILocation(line: 3285, column: 41, scope: !4104)
!4104 = distinct !DILexicalBlock(scope: !4099, file: !36, line: 3284, column: 9)
!4105 = !DILocation(line: 3285, column: 39, scope: !4104)
!4106 = !DILocation(line: 3287, column: 17, scope: !4107)
!4107 = distinct !DILexicalBlock(scope: !4104, file: !36, line: 3287, column: 17)
!4108 = !DILocation(line: 3287, column: 43, scope: !4107)
!4109 = !DILocation(line: 3287, column: 17, scope: !4104)
!4110 = !DILocation(line: 3289, column: 49, scope: !4111)
!4111 = distinct !DILexicalBlock(scope: !4107, file: !36, line: 3288, column: 13)
!4112 = !DILocation(line: 3289, column: 76, scope: !4111)
!4113 = !DILocation(line: 3289, column: 27, scope: !4111)
!4114 = !DILocation(line: 3289, column: 25, scope: !4111)
!4115 = !DILocation(line: 3290, column: 13, scope: !4111)
!4116 = !DILocation(line: 3291, column: 9, scope: !4104)
!4117 = !DILocation(line: 3293, column: 16, scope: !4082)
!4118 = !DILocation(line: 3293, column: 9, scope: !4082)
!4119 = distinct !DISubprogram(name: "MPU_xEventGroupSetBitsImpl", scope: !36, file: !36, line: 3300, type: !4083, scopeLine: 3302, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4120 = !DILocalVariable(name: "xEventGroup", arg: 1, scope: !4119, file: !36, line: 3300, type: !54)
!4121 = !DILocation(line: 3300, column: 64, scope: !4119)
!4122 = !DILocalVariable(name: "uxBitsToSet", arg: 2, scope: !4119, file: !36, line: 3301, type: !4038)
!4123 = !DILocation(line: 3301, column: 63, scope: !4119)
!4124 = !DILocalVariable(name: "xReturn", scope: !4119, file: !36, line: 3303, type: !4037)
!4125 = !DILocation(line: 3303, column: 21, scope: !4119)
!4126 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4119, file: !36, line: 3304, type: !54)
!4127 = !DILocation(line: 3304, column: 28, scope: !4119)
!4128 = !DILocalVariable(name: "lIndex", scope: !4119, file: !36, line: 3305, type: !27)
!4129 = !DILocation(line: 3305, column: 17, scope: !4119)
!4130 = !DILocation(line: 3307, column: 30, scope: !4119)
!4131 = !DILocation(line: 3307, column: 18, scope: !4119)
!4132 = !DILocation(line: 3307, column: 16, scope: !4119)
!4133 = !DILocation(line: 3309, column: 13, scope: !4134)
!4134 = distinct !DILexicalBlock(scope: !4119, file: !36, line: 3309, column: 13)
!4135 = !DILocation(line: 0, scope: !4134)
!4136 = !DILocation(line: 3309, column: 47, scope: !4134)
!4137 = !DILocation(line: 3309, column: 13, scope: !4119)
!4138 = !DILocation(line: 3311, column: 41, scope: !4139)
!4139 = distinct !DILexicalBlock(scope: !4134, file: !36, line: 3310, column: 9)
!4140 = !DILocation(line: 3311, column: 39, scope: !4139)
!4141 = !DILocation(line: 3313, column: 17, scope: !4142)
!4142 = distinct !DILexicalBlock(scope: !4139, file: !36, line: 3313, column: 17)
!4143 = !DILocation(line: 3313, column: 43, scope: !4142)
!4144 = !DILocation(line: 3313, column: 17, scope: !4139)
!4145 = !DILocation(line: 3315, column: 47, scope: !4146)
!4146 = distinct !DILexicalBlock(scope: !4142, file: !36, line: 3314, column: 13)
!4147 = !DILocation(line: 3315, column: 74, scope: !4146)
!4148 = !DILocation(line: 3315, column: 27, scope: !4146)
!4149 = !DILocation(line: 3315, column: 25, scope: !4146)
!4150 = !DILocation(line: 3316, column: 13, scope: !4146)
!4151 = !DILocation(line: 3317, column: 9, scope: !4139)
!4152 = !DILocation(line: 3319, column: 16, scope: !4119)
!4153 = !DILocation(line: 3319, column: 9, scope: !4119)
!4154 = distinct !DISubprogram(name: "MPU_xEventGroupSyncImpl", scope: !36, file: !36, line: 3328, type: !4155, scopeLine: 3332, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4155 = !DISubroutineType(types: !4156)
!4156 = !{!4037, !54, !4038, !4038, !119}
!4157 = !DILocalVariable(name: "xEventGroup", arg: 1, scope: !4154, file: !36, line: 3328, type: !54)
!4158 = !DILocation(line: 3328, column: 61, scope: !4154)
!4159 = !DILocalVariable(name: "uxBitsToSet", arg: 2, scope: !4154, file: !36, line: 3329, type: !4038)
!4160 = !DILocation(line: 3329, column: 60, scope: !4154)
!4161 = !DILocalVariable(name: "uxBitsToWaitFor", arg: 3, scope: !4154, file: !36, line: 3330, type: !4038)
!4162 = !DILocation(line: 3330, column: 60, scope: !4154)
!4163 = !DILocalVariable(name: "xTicksToWait", arg: 4, scope: !4154, file: !36, line: 3331, type: !119)
!4164 = !DILocation(line: 3331, column: 53, scope: !4154)
!4165 = !DILocalVariable(name: "xReturn", scope: !4154, file: !36, line: 3333, type: !4037)
!4166 = !DILocation(line: 3333, column: 21, scope: !4154)
!4167 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4154, file: !36, line: 3334, type: !54)
!4168 = !DILocation(line: 3334, column: 28, scope: !4154)
!4169 = !DILocalVariable(name: "lIndex", scope: !4154, file: !36, line: 3335, type: !27)
!4170 = !DILocation(line: 3335, column: 17, scope: !4154)
!4171 = !DILocation(line: 3337, column: 30, scope: !4154)
!4172 = !DILocation(line: 3337, column: 18, scope: !4154)
!4173 = !DILocation(line: 3337, column: 16, scope: !4154)
!4174 = !DILocation(line: 3339, column: 13, scope: !4175)
!4175 = distinct !DILexicalBlock(scope: !4154, file: !36, line: 3339, column: 13)
!4176 = !DILocation(line: 0, scope: !4175)
!4177 = !DILocation(line: 3339, column: 47, scope: !4175)
!4178 = !DILocation(line: 3339, column: 13, scope: !4154)
!4179 = !DILocation(line: 3341, column: 41, scope: !4180)
!4180 = distinct !DILexicalBlock(scope: !4175, file: !36, line: 3340, column: 9)
!4181 = !DILocation(line: 3341, column: 39, scope: !4180)
!4182 = !DILocation(line: 3343, column: 17, scope: !4183)
!4183 = distinct !DILexicalBlock(scope: !4180, file: !36, line: 3343, column: 17)
!4184 = !DILocation(line: 3343, column: 43, scope: !4183)
!4185 = !DILocation(line: 3343, column: 17, scope: !4180)
!4186 = !DILocation(line: 3345, column: 44, scope: !4187)
!4187 = distinct !DILexicalBlock(scope: !4183, file: !36, line: 3344, column: 13)
!4188 = !DILocation(line: 3345, column: 71, scope: !4187)
!4189 = !DILocation(line: 3345, column: 84, scope: !4187)
!4190 = !DILocation(line: 3345, column: 101, scope: !4187)
!4191 = !DILocation(line: 3345, column: 27, scope: !4187)
!4192 = !DILocation(line: 3345, column: 25, scope: !4187)
!4193 = !DILocation(line: 3346, column: 13, scope: !4187)
!4194 = !DILocation(line: 3347, column: 9, scope: !4180)
!4195 = !DILocation(line: 3349, column: 16, scope: !4154)
!4196 = !DILocation(line: 3349, column: 9, scope: !4154)
!4197 = distinct !DISubprogram(name: "MPU_uxEventGroupGetNumberImpl", scope: !36, file: !36, line: 3357, type: !4198, scopeLine: 3358, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4198 = !DISubroutineType(types: !4199)
!4199 = !{!39, !26}
!4200 = !DILocalVariable(name: "xEventGroup", arg: 1, scope: !4197, file: !36, line: 3357, type: !26)
!4201 = !DILocation(line: 3357, column: 59, scope: !4197)
!4202 = !DILocalVariable(name: "xReturn", scope: !4197, file: !36, line: 3359, type: !39)
!4203 = !DILocation(line: 3359, column: 25, scope: !4197)
!4204 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4197, file: !36, line: 3360, type: !54)
!4205 = !DILocation(line: 3360, column: 32, scope: !4197)
!4206 = !DILocalVariable(name: "lIndex", scope: !4197, file: !36, line: 3361, type: !27)
!4207 = !DILocation(line: 3361, column: 21, scope: !4197)
!4208 = !DILocation(line: 3363, column: 34, scope: !4197)
!4209 = !DILocation(line: 3363, column: 22, scope: !4197)
!4210 = !DILocation(line: 3363, column: 20, scope: !4197)
!4211 = !DILocation(line: 3365, column: 17, scope: !4212)
!4212 = distinct !DILexicalBlock(scope: !4197, file: !36, line: 3365, column: 17)
!4213 = !DILocation(line: 0, scope: !4212)
!4214 = !DILocation(line: 3365, column: 51, scope: !4212)
!4215 = !DILocation(line: 3365, column: 17, scope: !4197)
!4216 = !DILocation(line: 3367, column: 45, scope: !4217)
!4217 = distinct !DILexicalBlock(scope: !4212, file: !36, line: 3366, column: 13)
!4218 = !DILocation(line: 3367, column: 43, scope: !4217)
!4219 = !DILocation(line: 3369, column: 21, scope: !4220)
!4220 = distinct !DILexicalBlock(scope: !4217, file: !36, line: 3369, column: 21)
!4221 = !DILocation(line: 3369, column: 47, scope: !4220)
!4222 = !DILocation(line: 3369, column: 21, scope: !4217)
!4223 = !DILocation(line: 3371, column: 54, scope: !4224)
!4224 = distinct !DILexicalBlock(scope: !4220, file: !36, line: 3370, column: 17)
!4225 = !DILocation(line: 3371, column: 31, scope: !4224)
!4226 = !DILocation(line: 3371, column: 29, scope: !4224)
!4227 = !DILocation(line: 3372, column: 17, scope: !4224)
!4228 = !DILocation(line: 3373, column: 13, scope: !4217)
!4229 = !DILocation(line: 3375, column: 20, scope: !4197)
!4230 = !DILocation(line: 3375, column: 13, scope: !4197)
!4231 = distinct !DISubprogram(name: "MPU_vEventGroupSetNumberImpl", scope: !36, file: !36, line: 3386, type: !4232, scopeLine: 3388, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4232 = !DISubroutineType(types: !4233)
!4233 = !{null, !26, !39}
!4234 = !DILocalVariable(name: "xEventGroup", arg: 1, scope: !4231, file: !36, line: 3386, type: !26)
!4235 = !DILocation(line: 3386, column: 51, scope: !4231)
!4236 = !DILocalVariable(name: "uxEventGroupNumber", arg: 2, scope: !4231, file: !36, line: 3387, type: !39)
!4237 = !DILocation(line: 3387, column: 56, scope: !4231)
!4238 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4231, file: !36, line: 3389, type: !54)
!4239 = !DILocation(line: 3389, column: 32, scope: !4231)
!4240 = !DILocalVariable(name: "lIndex", scope: !4231, file: !36, line: 3390, type: !27)
!4241 = !DILocation(line: 3390, column: 21, scope: !4231)
!4242 = !DILocation(line: 3392, column: 34, scope: !4231)
!4243 = !DILocation(line: 3392, column: 22, scope: !4231)
!4244 = !DILocation(line: 3392, column: 20, scope: !4231)
!4245 = !DILocation(line: 3394, column: 17, scope: !4246)
!4246 = distinct !DILexicalBlock(scope: !4231, file: !36, line: 3394, column: 17)
!4247 = !DILocation(line: 0, scope: !4246)
!4248 = !DILocation(line: 3394, column: 51, scope: !4246)
!4249 = !DILocation(line: 3394, column: 17, scope: !4231)
!4250 = !DILocation(line: 3396, column: 45, scope: !4251)
!4251 = distinct !DILexicalBlock(scope: !4246, file: !36, line: 3395, column: 13)
!4252 = !DILocation(line: 3396, column: 43, scope: !4251)
!4253 = !DILocation(line: 3398, column: 21, scope: !4254)
!4254 = distinct !DILexicalBlock(scope: !4251, file: !36, line: 3398, column: 21)
!4255 = !DILocation(line: 3398, column: 47, scope: !4254)
!4256 = !DILocation(line: 3398, column: 21, scope: !4251)
!4257 = !DILocation(line: 3400, column: 43, scope: !4258)
!4258 = distinct !DILexicalBlock(scope: !4254, file: !36, line: 3399, column: 17)
!4259 = !DILocation(line: 3400, column: 70, scope: !4258)
!4260 = !DILocation(line: 3400, column: 21, scope: !4258)
!4261 = !DILocation(line: 3401, column: 17, scope: !4258)
!4262 = !DILocation(line: 3402, column: 13, scope: !4251)
!4263 = !DILocation(line: 3403, column: 9, scope: !4231)
!4264 = distinct !DISubprogram(name: "MPU_xEventGroupCreate", scope: !36, file: !36, line: 3415, type: !4265, scopeLine: 3416, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4265 = !DISubroutineType(types: !4266)
!4266 = !{!54}
!4267 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4264, file: !36, line: 3417, type: !54)
!4268 = !DILocation(line: 3417, column: 32, scope: !4264)
!4269 = !DILocalVariable(name: "xExternalEventGroupHandle", scope: !4264, file: !36, line: 3418, type: !54)
!4270 = !DILocation(line: 3418, column: 32, scope: !4264)
!4271 = !DILocalVariable(name: "lIndex", scope: !4264, file: !36, line: 3419, type: !27)
!4272 = !DILocation(line: 3419, column: 21, scope: !4264)
!4273 = !DILocation(line: 3421, column: 22, scope: !4264)
!4274 = !DILocation(line: 3421, column: 20, scope: !4264)
!4275 = !DILocation(line: 3423, column: 17, scope: !4276)
!4276 = distinct !DILexicalBlock(scope: !4264, file: !36, line: 3423, column: 17)
!4277 = !DILocation(line: 3423, column: 24, scope: !4276)
!4278 = !DILocation(line: 3423, column: 17, scope: !4264)
!4279 = !DILocation(line: 3425, column: 45, scope: !4280)
!4280 = distinct !DILexicalBlock(scope: !4276, file: !36, line: 3424, column: 13)
!4281 = !DILocation(line: 3425, column: 43, scope: !4280)
!4282 = !DILocation(line: 3427, column: 21, scope: !4283)
!4283 = distinct !DILexicalBlock(scope: !4280, file: !36, line: 3427, column: 21)
!4284 = !DILocation(line: 3427, column: 47, scope: !4283)
!4285 = !DILocation(line: 3427, column: 21, scope: !4280)
!4286 = !DILocation(line: 3429, column: 21, scope: !4287)
!4287 = distinct !DILexicalBlock(scope: !4283, file: !36, line: 3428, column: 17)
!4288 = !DILocation(line: 3430, column: 72, scope: !4287)
!4289 = !DILocation(line: 3430, column: 49, scope: !4287)
!4290 = !DILocation(line: 3430, column: 47, scope: !4287)
!4291 = !DILocation(line: 3431, column: 17, scope: !4287)
!4292 = !DILocation(line: 3434, column: 57, scope: !4293)
!4293 = distinct !DILexicalBlock(scope: !4283, file: !36, line: 3433, column: 17)
!4294 = !DILocation(line: 3434, column: 21, scope: !4293)
!4295 = !DILocation(line: 3436, column: 13, scope: !4280)
!4296 = !DILocation(line: 3438, column: 20, scope: !4264)
!4297 = !DILocation(line: 3438, column: 13, scope: !4264)
!4298 = distinct !DISubprogram(name: "MPU_xEventGroupCreateStatic", scope: !36, file: !36, line: 3446, type: !4299, scopeLine: 3447, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4299 = !DISubroutineType(types: !4300)
!4300 = !{!54, !4301}
!4301 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4302, size: 64)
!4302 = !DIDerivedType(tag: DW_TAG_typedef, name: "StaticEventGroup_t", file: !1548, line: 1390, baseType: !4303)
!4303 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xSTATIC_EVENT_GROUP", file: !1548, line: 1378, size: 512, elements: !4304)
!4304 = !{!4305, !4306, !4307, !4308}
!4305 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy1", scope: !4303, file: !1548, line: 1380, baseType: !119, size: 64)
!4306 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy2", scope: !4303, file: !1548, line: 1381, baseType: !2821, size: 320, offset: 64)
!4307 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy3", scope: !4303, file: !1548, line: 1384, baseType: !39, size: 64, offset: 384)
!4308 = !DIDerivedType(tag: DW_TAG_member, name: "ucDummy4", scope: !4303, file: !1548, line: 1388, baseType: !1583, size: 8, offset: 448)
!4309 = !DILocalVariable(name: "pxEventGroupBuffer", arg: 1, scope: !4298, file: !36, line: 3446, type: !4301)
!4310 = !DILocation(line: 3446, column: 78, scope: !4298)
!4311 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4298, file: !36, line: 3448, type: !54)
!4312 = !DILocation(line: 3448, column: 32, scope: !4298)
!4313 = !DILocalVariable(name: "xExternalEventGroupHandle", scope: !4298, file: !36, line: 3449, type: !54)
!4314 = !DILocation(line: 3449, column: 32, scope: !4298)
!4315 = !DILocalVariable(name: "lIndex", scope: !4298, file: !36, line: 3450, type: !27)
!4316 = !DILocation(line: 3450, column: 21, scope: !4298)
!4317 = !DILocation(line: 3452, column: 22, scope: !4298)
!4318 = !DILocation(line: 3452, column: 20, scope: !4298)
!4319 = !DILocation(line: 3454, column: 17, scope: !4320)
!4320 = distinct !DILexicalBlock(scope: !4298, file: !36, line: 3454, column: 17)
!4321 = !DILocation(line: 3454, column: 24, scope: !4320)
!4322 = !DILocation(line: 3454, column: 17, scope: !4298)
!4323 = !DILocation(line: 3456, column: 70, scope: !4324)
!4324 = distinct !DILexicalBlock(scope: !4320, file: !36, line: 3455, column: 13)
!4325 = !DILocation(line: 3456, column: 45, scope: !4324)
!4326 = !DILocation(line: 3456, column: 43, scope: !4324)
!4327 = !DILocation(line: 3458, column: 21, scope: !4328)
!4328 = distinct !DILexicalBlock(scope: !4324, file: !36, line: 3458, column: 21)
!4329 = !DILocation(line: 3458, column: 47, scope: !4328)
!4330 = !DILocation(line: 3458, column: 21, scope: !4324)
!4331 = !DILocation(line: 3460, column: 21, scope: !4332)
!4332 = distinct !DILexicalBlock(scope: !4328, file: !36, line: 3459, column: 17)
!4333 = !DILocation(line: 3461, column: 72, scope: !4332)
!4334 = !DILocation(line: 3461, column: 49, scope: !4332)
!4335 = !DILocation(line: 3461, column: 47, scope: !4332)
!4336 = !DILocation(line: 3462, column: 17, scope: !4332)
!4337 = !DILocation(line: 3465, column: 57, scope: !4338)
!4338 = distinct !DILexicalBlock(scope: !4328, file: !36, line: 3464, column: 17)
!4339 = !DILocation(line: 3465, column: 21, scope: !4338)
!4340 = !DILocation(line: 3467, column: 13, scope: !4324)
!4341 = !DILocation(line: 3469, column: 20, scope: !4298)
!4342 = !DILocation(line: 3469, column: 13, scope: !4298)
!4343 = distinct !DISubprogram(name: "MPU_vEventGroupDelete", scope: !36, file: !36, line: 3475, type: !4344, scopeLine: 3476, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4344 = !DISubroutineType(types: !4345)
!4345 = !{null, !54}
!4346 = !DILocalVariable(name: "xEventGroup", arg: 1, scope: !4343, file: !36, line: 3475, type: !54)
!4347 = !DILocation(line: 3475, column: 52, scope: !4343)
!4348 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4343, file: !36, line: 3477, type: !54)
!4349 = !DILocation(line: 3477, column: 28, scope: !4343)
!4350 = !DILocalVariable(name: "lIndex", scope: !4343, file: !36, line: 3478, type: !27)
!4351 = !DILocation(line: 3478, column: 17, scope: !4343)
!4352 = !DILocation(line: 3480, column: 30, scope: !4343)
!4353 = !DILocation(line: 3480, column: 18, scope: !4343)
!4354 = !DILocation(line: 3480, column: 16, scope: !4343)
!4355 = !DILocation(line: 3482, column: 13, scope: !4356)
!4356 = distinct !DILexicalBlock(scope: !4343, file: !36, line: 3482, column: 13)
!4357 = !DILocation(line: 0, scope: !4356)
!4358 = !DILocation(line: 3482, column: 47, scope: !4356)
!4359 = !DILocation(line: 3482, column: 13, scope: !4343)
!4360 = !DILocation(line: 3484, column: 41, scope: !4361)
!4361 = distinct !DILexicalBlock(scope: !4356, file: !36, line: 3483, column: 9)
!4362 = !DILocation(line: 3484, column: 39, scope: !4361)
!4363 = !DILocation(line: 3486, column: 17, scope: !4364)
!4364 = distinct !DILexicalBlock(scope: !4361, file: !36, line: 3486, column: 17)
!4365 = !DILocation(line: 3486, column: 43, scope: !4364)
!4366 = !DILocation(line: 3486, column: 17, scope: !4361)
!4367 = !DILocation(line: 3488, column: 36, scope: !4368)
!4368 = distinct !DILexicalBlock(scope: !4364, file: !36, line: 3487, column: 13)
!4369 = !DILocation(line: 3488, column: 17, scope: !4368)
!4370 = !DILocation(line: 3489, column: 53, scope: !4368)
!4371 = !DILocation(line: 3489, column: 17, scope: !4368)
!4372 = !DILocation(line: 3490, column: 13, scope: !4368)
!4373 = !DILocation(line: 3491, column: 9, scope: !4361)
!4374 = !DILocation(line: 3492, column: 5, scope: !4343)
!4375 = distinct !DISubprogram(name: "MPU_xEventGroupGetStaticBuffer", scope: !36, file: !36, line: 3497, type: !4376, scopeLine: 3499, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4376 = !DISubroutineType(types: !4377)
!4377 = !{!23, !54, !4378}
!4378 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4301, size: 64)
!4379 = !DILocalVariable(name: "xEventGroup", arg: 1, scope: !4375, file: !36, line: 3497, type: !54)
!4380 = !DILocation(line: 3497, column: 71, scope: !4375)
!4381 = !DILocalVariable(name: "ppxEventGroupBuffer", arg: 2, scope: !4375, file: !36, line: 3498, type: !4378)
!4382 = !DILocation(line: 3498, column: 74, scope: !4375)
!4383 = !DILocalVariable(name: "xReturn", scope: !4375, file: !36, line: 3500, type: !23)
!4384 = !DILocation(line: 3500, column: 24, scope: !4375)
!4385 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4375, file: !36, line: 3501, type: !54)
!4386 = !DILocation(line: 3501, column: 32, scope: !4375)
!4387 = !DILocalVariable(name: "lIndex", scope: !4375, file: !36, line: 3502, type: !27)
!4388 = !DILocation(line: 3502, column: 21, scope: !4375)
!4389 = !DILocation(line: 3504, column: 34, scope: !4375)
!4390 = !DILocation(line: 3504, column: 22, scope: !4375)
!4391 = !DILocation(line: 3504, column: 20, scope: !4375)
!4392 = !DILocation(line: 3506, column: 17, scope: !4393)
!4393 = distinct !DILexicalBlock(scope: !4375, file: !36, line: 3506, column: 17)
!4394 = !DILocation(line: 0, scope: !4393)
!4395 = !DILocation(line: 3506, column: 51, scope: !4393)
!4396 = !DILocation(line: 3506, column: 17, scope: !4375)
!4397 = !DILocation(line: 3508, column: 45, scope: !4398)
!4398 = distinct !DILexicalBlock(scope: !4393, file: !36, line: 3507, column: 13)
!4399 = !DILocation(line: 3508, column: 43, scope: !4398)
!4400 = !DILocation(line: 3510, column: 21, scope: !4401)
!4401 = distinct !DILexicalBlock(scope: !4398, file: !36, line: 3510, column: 21)
!4402 = !DILocation(line: 3510, column: 47, scope: !4401)
!4403 = !DILocation(line: 3510, column: 21, scope: !4398)
!4404 = !DILocation(line: 3512, column: 59, scope: !4405)
!4405 = distinct !DILexicalBlock(scope: !4401, file: !36, line: 3511, column: 17)
!4406 = !DILocation(line: 3512, column: 86, scope: !4405)
!4407 = !DILocation(line: 3512, column: 31, scope: !4405)
!4408 = !DILocation(line: 3512, column: 29, scope: !4405)
!4409 = !DILocation(line: 3513, column: 17, scope: !4405)
!4410 = !DILocation(line: 3514, column: 13, scope: !4398)
!4411 = !DILocation(line: 3516, column: 20, scope: !4375)
!4412 = !DILocation(line: 3516, column: 13, scope: !4375)
!4413 = distinct !DISubprogram(name: "MPU_xEventGroupClearBitsFromISR", scope: !36, file: !36, line: 3524, type: !4414, scopeLine: 3526, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4414 = !DISubroutineType(types: !4415)
!4415 = !{!23, !54, !4038}
!4416 = !DILocalVariable(name: "xEventGroup", arg: 1, scope: !4413, file: !36, line: 3524, type: !54)
!4417 = !DILocation(line: 3524, column: 72, scope: !4413)
!4418 = !DILocalVariable(name: "uxBitsToClear", arg: 2, scope: !4413, file: !36, line: 3525, type: !4038)
!4419 = !DILocation(line: 3525, column: 71, scope: !4413)
!4420 = !DILocalVariable(name: "xReturn", scope: !4413, file: !36, line: 3527, type: !23)
!4421 = !DILocation(line: 3527, column: 24, scope: !4413)
!4422 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4413, file: !36, line: 3528, type: !54)
!4423 = !DILocation(line: 3528, column: 32, scope: !4413)
!4424 = !DILocalVariable(name: "lIndex", scope: !4413, file: !36, line: 3529, type: !27)
!4425 = !DILocation(line: 3529, column: 21, scope: !4413)
!4426 = !DILocation(line: 3531, column: 34, scope: !4413)
!4427 = !DILocation(line: 3531, column: 22, scope: !4413)
!4428 = !DILocation(line: 3531, column: 20, scope: !4413)
!4429 = !DILocation(line: 3533, column: 17, scope: !4430)
!4430 = distinct !DILexicalBlock(scope: !4413, file: !36, line: 3533, column: 17)
!4431 = !DILocation(line: 0, scope: !4430)
!4432 = !DILocation(line: 3533, column: 51, scope: !4430)
!4433 = !DILocation(line: 3533, column: 17, scope: !4413)
!4434 = !DILocation(line: 3535, column: 45, scope: !4435)
!4435 = distinct !DILexicalBlock(scope: !4430, file: !36, line: 3534, column: 13)
!4436 = !DILocation(line: 3535, column: 43, scope: !4435)
!4437 = !DILocation(line: 3537, column: 21, scope: !4438)
!4438 = distinct !DILexicalBlock(scope: !4435, file: !36, line: 3537, column: 21)
!4439 = !DILocation(line: 3537, column: 47, scope: !4438)
!4440 = !DILocation(line: 3537, column: 21, scope: !4435)
!4441 = !DILocation(line: 3539, column: 60, scope: !4442)
!4442 = distinct !DILexicalBlock(scope: !4438, file: !36, line: 3538, column: 17)
!4443 = !DILocation(line: 3539, column: 87, scope: !4442)
!4444 = !DILocation(line: 3539, column: 31, scope: !4442)
!4445 = !DILocation(line: 3539, column: 29, scope: !4442)
!4446 = !DILocation(line: 3540, column: 17, scope: !4442)
!4447 = !DILocation(line: 3541, column: 13, scope: !4435)
!4448 = !DILocation(line: 3543, column: 20, scope: !4413)
!4449 = !DILocation(line: 3543, column: 13, scope: !4413)
!4450 = distinct !DISubprogram(name: "MPU_xEventGroupSetBitsFromISR", scope: !36, file: !36, line: 3551, type: !4451, scopeLine: 3554, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4451 = !DISubroutineType(types: !4452)
!4452 = !{!23, !54, !4038, !2168}
!4453 = !DILocalVariable(name: "xEventGroup", arg: 1, scope: !4450, file: !36, line: 3551, type: !54)
!4454 = !DILocation(line: 3551, column: 70, scope: !4450)
!4455 = !DILocalVariable(name: "uxBitsToSet", arg: 2, scope: !4450, file: !36, line: 3552, type: !4038)
!4456 = !DILocation(line: 3552, column: 69, scope: !4450)
!4457 = !DILocalVariable(name: "pxHigherPriorityTaskWoken", arg: 3, scope: !4450, file: !36, line: 3553, type: !2168)
!4458 = !DILocation(line: 3553, column: 64, scope: !4450)
!4459 = !DILocalVariable(name: "xReturn", scope: !4450, file: !36, line: 3555, type: !23)
!4460 = !DILocation(line: 3555, column: 24, scope: !4450)
!4461 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4450, file: !36, line: 3556, type: !54)
!4462 = !DILocation(line: 3556, column: 32, scope: !4450)
!4463 = !DILocalVariable(name: "lIndex", scope: !4450, file: !36, line: 3557, type: !27)
!4464 = !DILocation(line: 3557, column: 21, scope: !4450)
!4465 = !DILocation(line: 3559, column: 34, scope: !4450)
!4466 = !DILocation(line: 3559, column: 22, scope: !4450)
!4467 = !DILocation(line: 3559, column: 20, scope: !4450)
!4468 = !DILocation(line: 3561, column: 17, scope: !4469)
!4469 = distinct !DILexicalBlock(scope: !4450, file: !36, line: 3561, column: 17)
!4470 = !DILocation(line: 0, scope: !4469)
!4471 = !DILocation(line: 3561, column: 51, scope: !4469)
!4472 = !DILocation(line: 3561, column: 17, scope: !4450)
!4473 = !DILocation(line: 3563, column: 45, scope: !4474)
!4474 = distinct !DILexicalBlock(scope: !4469, file: !36, line: 3562, column: 13)
!4475 = !DILocation(line: 3563, column: 43, scope: !4474)
!4476 = !DILocation(line: 3565, column: 21, scope: !4477)
!4477 = distinct !DILexicalBlock(scope: !4474, file: !36, line: 3565, column: 21)
!4478 = !DILocation(line: 3565, column: 47, scope: !4477)
!4479 = !DILocation(line: 3565, column: 21, scope: !4474)
!4480 = !DILocation(line: 3567, column: 58, scope: !4481)
!4481 = distinct !DILexicalBlock(scope: !4477, file: !36, line: 3566, column: 17)
!4482 = !DILocation(line: 3567, column: 85, scope: !4481)
!4483 = !DILocation(line: 3567, column: 98, scope: !4481)
!4484 = !DILocation(line: 3567, column: 31, scope: !4481)
!4485 = !DILocation(line: 3567, column: 29, scope: !4481)
!4486 = !DILocation(line: 3568, column: 17, scope: !4481)
!4487 = !DILocation(line: 3569, column: 13, scope: !4474)
!4488 = !DILocation(line: 3571, column: 20, scope: !4450)
!4489 = !DILocation(line: 3571, column: 13, scope: !4450)
!4490 = distinct !DISubprogram(name: "MPU_xEventGroupGetBitsFromISR", scope: !36, file: !36, line: 3577, type: !4491, scopeLine: 3578, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4491 = !DISubroutineType(types: !4492)
!4492 = !{!4037, !54}
!4493 = !DILocalVariable(name: "xEventGroup", arg: 1, scope: !4490, file: !36, line: 3577, type: !54)
!4494 = !DILocation(line: 3577, column: 67, scope: !4490)
!4495 = !DILocalVariable(name: "xReturn", scope: !4490, file: !36, line: 3579, type: !4037)
!4496 = !DILocation(line: 3579, column: 21, scope: !4490)
!4497 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4490, file: !36, line: 3580, type: !54)
!4498 = !DILocation(line: 3580, column: 28, scope: !4490)
!4499 = !DILocalVariable(name: "lIndex", scope: !4490, file: !36, line: 3581, type: !27)
!4500 = !DILocation(line: 3581, column: 17, scope: !4490)
!4501 = !DILocation(line: 3583, column: 30, scope: !4490)
!4502 = !DILocation(line: 3583, column: 18, scope: !4490)
!4503 = !DILocation(line: 3583, column: 16, scope: !4490)
!4504 = !DILocation(line: 3585, column: 13, scope: !4505)
!4505 = distinct !DILexicalBlock(scope: !4490, file: !36, line: 3585, column: 13)
!4506 = !DILocation(line: 0, scope: !4505)
!4507 = !DILocation(line: 3585, column: 47, scope: !4505)
!4508 = !DILocation(line: 3585, column: 13, scope: !4490)
!4509 = !DILocation(line: 3587, column: 41, scope: !4510)
!4510 = distinct !DILexicalBlock(scope: !4505, file: !36, line: 3586, column: 9)
!4511 = !DILocation(line: 3587, column: 39, scope: !4510)
!4512 = !DILocation(line: 3589, column: 17, scope: !4513)
!4513 = distinct !DILexicalBlock(scope: !4510, file: !36, line: 3589, column: 17)
!4514 = !DILocation(line: 3589, column: 43, scope: !4513)
!4515 = !DILocation(line: 3589, column: 17, scope: !4510)
!4516 = !DILocation(line: 3591, column: 54, scope: !4517)
!4517 = distinct !DILexicalBlock(scope: !4513, file: !36, line: 3590, column: 13)
!4518 = !DILocation(line: 3591, column: 27, scope: !4517)
!4519 = !DILocation(line: 3591, column: 25, scope: !4517)
!4520 = !DILocation(line: 3592, column: 13, scope: !4517)
!4521 = !DILocation(line: 3593, column: 9, scope: !4510)
!4522 = !DILocation(line: 3595, column: 16, scope: !4490)
!4523 = !DILocation(line: 3595, column: 9, scope: !4490)
!4524 = distinct !DISubprogram(name: "MPU_xStreamBufferSendImpl", scope: !36, file: !36, line: 3608, type: !4525, scopeLine: 3612, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4525 = !DISubroutineType(types: !4526)
!4526 = !{!109, !58, !2255, !109, !119}
!4527 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !4524, file: !36, line: 3608, type: !58)
!4528 = !DILocation(line: 3608, column: 60, scope: !4524)
!4529 = !DILocalVariable(name: "pvTxData", arg: 2, scope: !4524, file: !36, line: 3609, type: !2255)
!4530 = !DILocation(line: 3609, column: 52, scope: !4524)
!4531 = !DILocalVariable(name: "xDataLengthBytes", arg: 3, scope: !4524, file: !36, line: 3610, type: !109)
!4532 = !DILocation(line: 3610, column: 46, scope: !4524)
!4533 = !DILocalVariable(name: "xTicksToWait", arg: 4, scope: !4524, file: !36, line: 3611, type: !119)
!4534 = !DILocation(line: 3611, column: 50, scope: !4524)
!4535 = !DILocalVariable(name: "xReturn", scope: !4524, file: !36, line: 3613, type: !109)
!4536 = !DILocation(line: 3613, column: 16, scope: !4524)
!4537 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4524, file: !36, line: 3614, type: !58)
!4538 = !DILocation(line: 3614, column: 30, scope: !4524)
!4539 = !DILocalVariable(name: "lIndex", scope: !4524, file: !36, line: 3615, type: !27)
!4540 = !DILocation(line: 3615, column: 17, scope: !4524)
!4541 = !DILocalVariable(name: "xIsTxDataBufferReadable", scope: !4524, file: !36, line: 3616, type: !23)
!4542 = !DILocation(line: 3616, column: 20, scope: !4524)
!4543 = !DILocation(line: 3618, column: 68, scope: !4524)
!4544 = !DILocation(line: 3619, column: 68, scope: !4524)
!4545 = !DILocation(line: 3618, column: 35, scope: !4524)
!4546 = !DILocation(line: 3618, column: 33, scope: !4524)
!4547 = !DILocation(line: 3622, column: 13, scope: !4548)
!4548 = distinct !DILexicalBlock(scope: !4524, file: !36, line: 3622, column: 13)
!4549 = !DILocation(line: 3622, column: 37, scope: !4548)
!4550 = !DILocation(line: 3622, column: 13, scope: !4524)
!4551 = !DILocation(line: 3624, column: 34, scope: !4552)
!4552 = distinct !DILexicalBlock(scope: !4548, file: !36, line: 3623, column: 9)
!4553 = !DILocation(line: 3624, column: 22, scope: !4552)
!4554 = !DILocation(line: 3624, column: 20, scope: !4552)
!4555 = !DILocation(line: 3626, column: 17, scope: !4556)
!4556 = distinct !DILexicalBlock(scope: !4552, file: !36, line: 3626, column: 17)
!4557 = !DILocation(line: 0, scope: !4556)
!4558 = !DILocation(line: 3626, column: 51, scope: !4556)
!4559 = !DILocation(line: 3626, column: 17, scope: !4552)
!4560 = !DILocation(line: 3628, column: 47, scope: !4561)
!4561 = distinct !DILexicalBlock(scope: !4556, file: !36, line: 3627, column: 13)
!4562 = !DILocation(line: 3628, column: 45, scope: !4561)
!4563 = !DILocation(line: 3630, column: 21, scope: !4564)
!4564 = distinct !DILexicalBlock(scope: !4561, file: !36, line: 3630, column: 21)
!4565 = !DILocation(line: 3630, column: 49, scope: !4564)
!4566 = !DILocation(line: 3630, column: 21, scope: !4561)
!4567 = !DILocation(line: 3632, column: 50, scope: !4568)
!4568 = distinct !DILexicalBlock(scope: !4564, file: !36, line: 3631, column: 17)
!4569 = !DILocation(line: 3632, column: 79, scope: !4568)
!4570 = !DILocation(line: 3632, column: 89, scope: !4568)
!4571 = !DILocation(line: 3632, column: 107, scope: !4568)
!4572 = !DILocation(line: 3632, column: 31, scope: !4568)
!4573 = !DILocation(line: 3632, column: 29, scope: !4568)
!4574 = !DILocation(line: 3633, column: 17, scope: !4568)
!4575 = !DILocation(line: 3634, column: 13, scope: !4561)
!4576 = !DILocation(line: 3635, column: 9, scope: !4552)
!4577 = !DILocation(line: 3637, column: 16, scope: !4524)
!4578 = !DILocation(line: 3637, column: 9, scope: !4524)
!4579 = distinct !DISubprogram(name: "MPU_xStreamBufferReceiveImpl", scope: !36, file: !36, line: 3646, type: !4580, scopeLine: 3650, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4580 = !DISubroutineType(types: !4581)
!4581 = !{!109, !58, !26, !109, !119}
!4582 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !4579, file: !36, line: 3646, type: !58)
!4583 = !DILocation(line: 3646, column: 63, scope: !4579)
!4584 = !DILocalVariable(name: "pvRxData", arg: 2, scope: !4579, file: !36, line: 3647, type: !26)
!4585 = !DILocation(line: 3647, column: 49, scope: !4579)
!4586 = !DILocalVariable(name: "xBufferLengthBytes", arg: 3, scope: !4579, file: !36, line: 3648, type: !109)
!4587 = !DILocation(line: 3648, column: 49, scope: !4579)
!4588 = !DILocalVariable(name: "xTicksToWait", arg: 4, scope: !4579, file: !36, line: 3649, type: !119)
!4589 = !DILocation(line: 3649, column: 53, scope: !4579)
!4590 = !DILocalVariable(name: "xReturn", scope: !4579, file: !36, line: 3651, type: !109)
!4591 = !DILocation(line: 3651, column: 16, scope: !4579)
!4592 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4579, file: !36, line: 3652, type: !58)
!4593 = !DILocation(line: 3652, column: 30, scope: !4579)
!4594 = !DILocalVariable(name: "lIndex", scope: !4579, file: !36, line: 3653, type: !27)
!4595 = !DILocation(line: 3653, column: 17, scope: !4579)
!4596 = !DILocalVariable(name: "xIsRxDataBufferWriteable", scope: !4579, file: !36, line: 3654, type: !23)
!4597 = !DILocation(line: 3654, column: 20, scope: !4579)
!4598 = !DILocation(line: 3656, column: 69, scope: !4579)
!4599 = !DILocation(line: 3657, column: 69, scope: !4579)
!4600 = !DILocation(line: 3656, column: 36, scope: !4579)
!4601 = !DILocation(line: 3656, column: 34, scope: !4579)
!4602 = !DILocation(line: 3660, column: 13, scope: !4603)
!4603 = distinct !DILexicalBlock(scope: !4579, file: !36, line: 3660, column: 13)
!4604 = !DILocation(line: 3660, column: 38, scope: !4603)
!4605 = !DILocation(line: 3660, column: 13, scope: !4579)
!4606 = !DILocation(line: 3662, column: 34, scope: !4607)
!4607 = distinct !DILexicalBlock(scope: !4603, file: !36, line: 3661, column: 9)
!4608 = !DILocation(line: 3662, column: 22, scope: !4607)
!4609 = !DILocation(line: 3662, column: 20, scope: !4607)
!4610 = !DILocation(line: 3664, column: 17, scope: !4611)
!4611 = distinct !DILexicalBlock(scope: !4607, file: !36, line: 3664, column: 17)
!4612 = !DILocation(line: 0, scope: !4611)
!4613 = !DILocation(line: 3664, column: 51, scope: !4611)
!4614 = !DILocation(line: 3664, column: 17, scope: !4607)
!4615 = !DILocation(line: 3666, column: 47, scope: !4616)
!4616 = distinct !DILexicalBlock(scope: !4611, file: !36, line: 3665, column: 13)
!4617 = !DILocation(line: 3666, column: 45, scope: !4616)
!4618 = !DILocation(line: 3668, column: 21, scope: !4619)
!4619 = distinct !DILexicalBlock(scope: !4616, file: !36, line: 3668, column: 21)
!4620 = !DILocation(line: 3668, column: 49, scope: !4619)
!4621 = !DILocation(line: 3668, column: 21, scope: !4616)
!4622 = !DILocation(line: 3670, column: 53, scope: !4623)
!4623 = distinct !DILexicalBlock(scope: !4619, file: !36, line: 3669, column: 17)
!4624 = !DILocation(line: 3670, column: 82, scope: !4623)
!4625 = !DILocation(line: 3670, column: 92, scope: !4623)
!4626 = !DILocation(line: 3670, column: 112, scope: !4623)
!4627 = !DILocation(line: 3670, column: 31, scope: !4623)
!4628 = !DILocation(line: 3670, column: 29, scope: !4623)
!4629 = !DILocation(line: 3671, column: 17, scope: !4623)
!4630 = !DILocation(line: 3672, column: 13, scope: !4616)
!4631 = !DILocation(line: 3673, column: 9, scope: !4607)
!4632 = !DILocation(line: 3675, column: 16, scope: !4579)
!4633 = !DILocation(line: 3675, column: 9, scope: !4579)
!4634 = distinct !DISubprogram(name: "MPU_xStreamBufferIsFullImpl", scope: !36, file: !36, line: 3681, type: !4635, scopeLine: 3682, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4635 = !DISubroutineType(types: !4636)
!4636 = !{!23, !58}
!4637 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !4634, file: !36, line: 3681, type: !58)
!4638 = !DILocation(line: 3681, column: 66, scope: !4634)
!4639 = !DILocalVariable(name: "xReturn", scope: !4634, file: !36, line: 3683, type: !23)
!4640 = !DILocation(line: 3683, column: 20, scope: !4634)
!4641 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4634, file: !36, line: 3684, type: !58)
!4642 = !DILocation(line: 3684, column: 30, scope: !4634)
!4643 = !DILocalVariable(name: "lIndex", scope: !4634, file: !36, line: 3685, type: !27)
!4644 = !DILocation(line: 3685, column: 17, scope: !4634)
!4645 = !DILocation(line: 3687, column: 30, scope: !4634)
!4646 = !DILocation(line: 3687, column: 18, scope: !4634)
!4647 = !DILocation(line: 3687, column: 16, scope: !4634)
!4648 = !DILocation(line: 3689, column: 13, scope: !4649)
!4649 = distinct !DILexicalBlock(scope: !4634, file: !36, line: 3689, column: 13)
!4650 = !DILocation(line: 0, scope: !4649)
!4651 = !DILocation(line: 3689, column: 47, scope: !4649)
!4652 = !DILocation(line: 3689, column: 13, scope: !4634)
!4653 = !DILocation(line: 3691, column: 43, scope: !4654)
!4654 = distinct !DILexicalBlock(scope: !4649, file: !36, line: 3690, column: 9)
!4655 = !DILocation(line: 3691, column: 41, scope: !4654)
!4656 = !DILocation(line: 3693, column: 17, scope: !4657)
!4657 = distinct !DILexicalBlock(scope: !4654, file: !36, line: 3693, column: 17)
!4658 = !DILocation(line: 3693, column: 45, scope: !4657)
!4659 = !DILocation(line: 3693, column: 17, scope: !4654)
!4660 = !DILocation(line: 3695, column: 48, scope: !4661)
!4661 = distinct !DILexicalBlock(scope: !4657, file: !36, line: 3694, column: 13)
!4662 = !DILocation(line: 3695, column: 27, scope: !4661)
!4663 = !DILocation(line: 3695, column: 25, scope: !4661)
!4664 = !DILocation(line: 3696, column: 13, scope: !4661)
!4665 = !DILocation(line: 3697, column: 9, scope: !4654)
!4666 = !DILocation(line: 3699, column: 16, scope: !4634)
!4667 = !DILocation(line: 3699, column: 9, scope: !4634)
!4668 = distinct !DISubprogram(name: "MPU_xStreamBufferIsEmptyImpl", scope: !36, file: !36, line: 3705, type: !4635, scopeLine: 3706, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4669 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !4668, file: !36, line: 3705, type: !58)
!4670 = !DILocation(line: 3705, column: 67, scope: !4668)
!4671 = !DILocalVariable(name: "xReturn", scope: !4668, file: !36, line: 3707, type: !23)
!4672 = !DILocation(line: 3707, column: 20, scope: !4668)
!4673 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4668, file: !36, line: 3708, type: !58)
!4674 = !DILocation(line: 3708, column: 30, scope: !4668)
!4675 = !DILocalVariable(name: "lIndex", scope: !4668, file: !36, line: 3709, type: !27)
!4676 = !DILocation(line: 3709, column: 17, scope: !4668)
!4677 = !DILocation(line: 3711, column: 30, scope: !4668)
!4678 = !DILocation(line: 3711, column: 18, scope: !4668)
!4679 = !DILocation(line: 3711, column: 16, scope: !4668)
!4680 = !DILocation(line: 3713, column: 13, scope: !4681)
!4681 = distinct !DILexicalBlock(scope: !4668, file: !36, line: 3713, column: 13)
!4682 = !DILocation(line: 0, scope: !4681)
!4683 = !DILocation(line: 3713, column: 47, scope: !4681)
!4684 = !DILocation(line: 3713, column: 13, scope: !4668)
!4685 = !DILocation(line: 3715, column: 43, scope: !4686)
!4686 = distinct !DILexicalBlock(scope: !4681, file: !36, line: 3714, column: 9)
!4687 = !DILocation(line: 3715, column: 41, scope: !4686)
!4688 = !DILocation(line: 3717, column: 17, scope: !4689)
!4689 = distinct !DILexicalBlock(scope: !4686, file: !36, line: 3717, column: 17)
!4690 = !DILocation(line: 3717, column: 45, scope: !4689)
!4691 = !DILocation(line: 3717, column: 17, scope: !4686)
!4692 = !DILocation(line: 3719, column: 49, scope: !4693)
!4693 = distinct !DILexicalBlock(scope: !4689, file: !36, line: 3718, column: 13)
!4694 = !DILocation(line: 3719, column: 27, scope: !4693)
!4695 = !DILocation(line: 3719, column: 25, scope: !4693)
!4696 = !DILocation(line: 3720, column: 13, scope: !4693)
!4697 = !DILocation(line: 3721, column: 9, scope: !4686)
!4698 = !DILocation(line: 3723, column: 16, scope: !4668)
!4699 = !DILocation(line: 3723, column: 9, scope: !4668)
!4700 = distinct !DISubprogram(name: "MPU_xStreamBufferSpacesAvailableImpl", scope: !36, file: !36, line: 3729, type: !4701, scopeLine: 3730, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4701 = !DISubroutineType(types: !4702)
!4702 = !{!109, !58}
!4703 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !4700, file: !36, line: 3729, type: !58)
!4704 = !DILocation(line: 3729, column: 71, scope: !4700)
!4705 = !DILocalVariable(name: "xReturn", scope: !4700, file: !36, line: 3731, type: !109)
!4706 = !DILocation(line: 3731, column: 16, scope: !4700)
!4707 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4700, file: !36, line: 3732, type: !58)
!4708 = !DILocation(line: 3732, column: 30, scope: !4700)
!4709 = !DILocalVariable(name: "lIndex", scope: !4700, file: !36, line: 3733, type: !27)
!4710 = !DILocation(line: 3733, column: 17, scope: !4700)
!4711 = !DILocation(line: 3735, column: 30, scope: !4700)
!4712 = !DILocation(line: 3735, column: 18, scope: !4700)
!4713 = !DILocation(line: 3735, column: 16, scope: !4700)
!4714 = !DILocation(line: 3737, column: 13, scope: !4715)
!4715 = distinct !DILexicalBlock(scope: !4700, file: !36, line: 3737, column: 13)
!4716 = !DILocation(line: 0, scope: !4715)
!4717 = !DILocation(line: 3737, column: 47, scope: !4715)
!4718 = !DILocation(line: 3737, column: 13, scope: !4700)
!4719 = !DILocation(line: 3739, column: 43, scope: !4720)
!4720 = distinct !DILexicalBlock(scope: !4715, file: !36, line: 3738, column: 9)
!4721 = !DILocation(line: 3739, column: 41, scope: !4720)
!4722 = !DILocation(line: 3741, column: 17, scope: !4723)
!4723 = distinct !DILexicalBlock(scope: !4720, file: !36, line: 3741, column: 17)
!4724 = !DILocation(line: 3741, column: 45, scope: !4723)
!4725 = !DILocation(line: 3741, column: 17, scope: !4720)
!4726 = !DILocation(line: 3743, column: 57, scope: !4727)
!4727 = distinct !DILexicalBlock(scope: !4723, file: !36, line: 3742, column: 13)
!4728 = !DILocation(line: 3743, column: 27, scope: !4727)
!4729 = !DILocation(line: 3743, column: 25, scope: !4727)
!4730 = !DILocation(line: 3744, column: 13, scope: !4727)
!4731 = !DILocation(line: 3745, column: 9, scope: !4720)
!4732 = !DILocation(line: 3747, column: 16, scope: !4700)
!4733 = !DILocation(line: 3747, column: 9, scope: !4700)
!4734 = distinct !DISubprogram(name: "MPU_xStreamBufferBytesAvailableImpl", scope: !36, file: !36, line: 3753, type: !4701, scopeLine: 3754, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4735 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !4734, file: !36, line: 3753, type: !58)
!4736 = !DILocation(line: 3753, column: 70, scope: !4734)
!4737 = !DILocalVariable(name: "xReturn", scope: !4734, file: !36, line: 3755, type: !109)
!4738 = !DILocation(line: 3755, column: 16, scope: !4734)
!4739 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4734, file: !36, line: 3756, type: !58)
!4740 = !DILocation(line: 3756, column: 30, scope: !4734)
!4741 = !DILocalVariable(name: "lIndex", scope: !4734, file: !36, line: 3757, type: !27)
!4742 = !DILocation(line: 3757, column: 17, scope: !4734)
!4743 = !DILocation(line: 3759, column: 30, scope: !4734)
!4744 = !DILocation(line: 3759, column: 18, scope: !4734)
!4745 = !DILocation(line: 3759, column: 16, scope: !4734)
!4746 = !DILocation(line: 3761, column: 13, scope: !4747)
!4747 = distinct !DILexicalBlock(scope: !4734, file: !36, line: 3761, column: 13)
!4748 = !DILocation(line: 0, scope: !4747)
!4749 = !DILocation(line: 3761, column: 47, scope: !4747)
!4750 = !DILocation(line: 3761, column: 13, scope: !4734)
!4751 = !DILocation(line: 3763, column: 43, scope: !4752)
!4752 = distinct !DILexicalBlock(scope: !4747, file: !36, line: 3762, column: 9)
!4753 = !DILocation(line: 3763, column: 41, scope: !4752)
!4754 = !DILocation(line: 3765, column: 17, scope: !4755)
!4755 = distinct !DILexicalBlock(scope: !4752, file: !36, line: 3765, column: 17)
!4756 = !DILocation(line: 3765, column: 45, scope: !4755)
!4757 = !DILocation(line: 3765, column: 17, scope: !4752)
!4758 = !DILocation(line: 3767, column: 56, scope: !4759)
!4759 = distinct !DILexicalBlock(scope: !4755, file: !36, line: 3766, column: 13)
!4760 = !DILocation(line: 3767, column: 27, scope: !4759)
!4761 = !DILocation(line: 3767, column: 25, scope: !4759)
!4762 = !DILocation(line: 3768, column: 13, scope: !4759)
!4763 = !DILocation(line: 3769, column: 9, scope: !4752)
!4764 = !DILocation(line: 3771, column: 16, scope: !4734)
!4765 = !DILocation(line: 3771, column: 9, scope: !4734)
!4766 = distinct !DISubprogram(name: "MPU_xStreamBufferSetTriggerLevelImpl", scope: !36, file: !36, line: 3778, type: !4767, scopeLine: 3780, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4767 = !DISubroutineType(types: !4768)
!4768 = !{!23, !58, !109}
!4769 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !4766, file: !36, line: 3778, type: !58)
!4770 = !DILocation(line: 3778, column: 75, scope: !4766)
!4771 = !DILocalVariable(name: "xTriggerLevel", arg: 2, scope: !4766, file: !36, line: 3779, type: !109)
!4772 = !DILocation(line: 3779, column: 61, scope: !4766)
!4773 = !DILocalVariable(name: "xReturn", scope: !4766, file: !36, line: 3781, type: !23)
!4774 = !DILocation(line: 3781, column: 20, scope: !4766)
!4775 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4766, file: !36, line: 3782, type: !58)
!4776 = !DILocation(line: 3782, column: 30, scope: !4766)
!4777 = !DILocalVariable(name: "lIndex", scope: !4766, file: !36, line: 3783, type: !27)
!4778 = !DILocation(line: 3783, column: 17, scope: !4766)
!4779 = !DILocation(line: 3785, column: 30, scope: !4766)
!4780 = !DILocation(line: 3785, column: 18, scope: !4766)
!4781 = !DILocation(line: 3785, column: 16, scope: !4766)
!4782 = !DILocation(line: 3787, column: 13, scope: !4783)
!4783 = distinct !DILexicalBlock(scope: !4766, file: !36, line: 3787, column: 13)
!4784 = !DILocation(line: 0, scope: !4783)
!4785 = !DILocation(line: 3787, column: 47, scope: !4783)
!4786 = !DILocation(line: 3787, column: 13, scope: !4766)
!4787 = !DILocation(line: 3789, column: 43, scope: !4788)
!4788 = distinct !DILexicalBlock(scope: !4783, file: !36, line: 3788, column: 9)
!4789 = !DILocation(line: 3789, column: 41, scope: !4788)
!4790 = !DILocation(line: 3791, column: 17, scope: !4791)
!4791 = distinct !DILexicalBlock(scope: !4788, file: !36, line: 3791, column: 17)
!4792 = !DILocation(line: 3791, column: 45, scope: !4791)
!4793 = !DILocation(line: 3791, column: 17, scope: !4788)
!4794 = !DILocation(line: 3793, column: 57, scope: !4795)
!4795 = distinct !DILexicalBlock(scope: !4791, file: !36, line: 3792, column: 13)
!4796 = !DILocation(line: 3793, column: 86, scope: !4795)
!4797 = !DILocation(line: 3793, column: 27, scope: !4795)
!4798 = !DILocation(line: 3793, column: 25, scope: !4795)
!4799 = !DILocation(line: 3794, column: 13, scope: !4795)
!4800 = !DILocation(line: 3795, column: 9, scope: !4788)
!4801 = !DILocation(line: 3797, column: 16, scope: !4766)
!4802 = !DILocation(line: 3797, column: 9, scope: !4766)
!4803 = distinct !DISubprogram(name: "MPU_xStreamBufferNextMessageLengthBytesImpl", scope: !36, file: !36, line: 3803, type: !4701, scopeLine: 3804, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4804 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !4803, file: !36, line: 3803, type: !58)
!4805 = !DILocation(line: 3803, column: 78, scope: !4803)
!4806 = !DILocalVariable(name: "xReturn", scope: !4803, file: !36, line: 3805, type: !109)
!4807 = !DILocation(line: 3805, column: 16, scope: !4803)
!4808 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4803, file: !36, line: 3806, type: !58)
!4809 = !DILocation(line: 3806, column: 30, scope: !4803)
!4810 = !DILocalVariable(name: "lIndex", scope: !4803, file: !36, line: 3807, type: !27)
!4811 = !DILocation(line: 3807, column: 17, scope: !4803)
!4812 = !DILocation(line: 3809, column: 30, scope: !4803)
!4813 = !DILocation(line: 3809, column: 18, scope: !4803)
!4814 = !DILocation(line: 3809, column: 16, scope: !4803)
!4815 = !DILocation(line: 3811, column: 13, scope: !4816)
!4816 = distinct !DILexicalBlock(scope: !4803, file: !36, line: 3811, column: 13)
!4817 = !DILocation(line: 0, scope: !4816)
!4818 = !DILocation(line: 3811, column: 47, scope: !4816)
!4819 = !DILocation(line: 3811, column: 13, scope: !4803)
!4820 = !DILocation(line: 3813, column: 43, scope: !4821)
!4821 = distinct !DILexicalBlock(scope: !4816, file: !36, line: 3812, column: 9)
!4822 = !DILocation(line: 3813, column: 41, scope: !4821)
!4823 = !DILocation(line: 3815, column: 17, scope: !4824)
!4824 = distinct !DILexicalBlock(scope: !4821, file: !36, line: 3815, column: 17)
!4825 = !DILocation(line: 3815, column: 45, scope: !4824)
!4826 = !DILocation(line: 3815, column: 17, scope: !4821)
!4827 = !DILocation(line: 3817, column: 64, scope: !4828)
!4828 = distinct !DILexicalBlock(scope: !4824, file: !36, line: 3816, column: 13)
!4829 = !DILocation(line: 3817, column: 27, scope: !4828)
!4830 = !DILocation(line: 3817, column: 25, scope: !4828)
!4831 = !DILocation(line: 3818, column: 13, scope: !4828)
!4832 = !DILocation(line: 3819, column: 9, scope: !4821)
!4833 = !DILocation(line: 3821, column: 16, scope: !4803)
!4834 = !DILocation(line: 3821, column: 9, scope: !4803)
!4835 = distinct !DISubprogram(name: "MPU_xStreamBufferGenericCreate", scope: !36, file: !36, line: 3832, type: !4836, scopeLine: 3837, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4836 = !DISubroutineType(types: !4837)
!4837 = !{!58, !109, !109, !23, !4838, !4838}
!4838 = !DIDerivedType(tag: DW_TAG_typedef, name: "StreamBufferCallbackFunction_t", file: !59, line: 77, baseType: !4839)
!4839 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4840, size: 64)
!4840 = !DISubroutineType(types: !4841)
!4841 = !{null, !58, !23, !3144}
!4842 = !DILocalVariable(name: "xBufferSizeBytes", arg: 1, scope: !4835, file: !36, line: 3832, type: !109)
!4843 = !DILocation(line: 3832, column: 69, scope: !4835)
!4844 = !DILocalVariable(name: "xTriggerLevelBytes", arg: 2, scope: !4835, file: !36, line: 3833, type: !109)
!4845 = !DILocation(line: 3833, column: 69, scope: !4835)
!4846 = !DILocalVariable(name: "xIsMessageBuffer", arg: 3, scope: !4835, file: !36, line: 3834, type: !23)
!4847 = !DILocation(line: 3834, column: 73, scope: !4835)
!4848 = !DILocalVariable(name: "pxSendCompletedCallback", arg: 4, scope: !4835, file: !36, line: 3835, type: !4838)
!4849 = !DILocation(line: 3835, column: 93, scope: !4835)
!4850 = !DILocalVariable(name: "pxReceiveCompletedCallback", arg: 5, scope: !4835, file: !36, line: 3836, type: !4838)
!4851 = !DILocation(line: 3836, column: 93, scope: !4835)
!4852 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4835, file: !36, line: 3838, type: !58)
!4853 = !DILocation(line: 3838, column: 34, scope: !4835)
!4854 = !DILocalVariable(name: "xExternalStreamBufferHandle", scope: !4835, file: !36, line: 3839, type: !58)
!4855 = !DILocation(line: 3839, column: 34, scope: !4835)
!4856 = !DILocalVariable(name: "lIndex", scope: !4835, file: !36, line: 3840, type: !27)
!4857 = !DILocation(line: 3840, column: 21, scope: !4835)
!4858 = !DILocation(line: 3846, column: 13, scope: !4859)
!4859 = distinct !DILexicalBlock(scope: !4835, file: !36, line: 3846, column: 13)
!4860 = !DILocation(line: 0, scope: !4859)
!4861 = !DILocation(line: 3846, column: 13, scope: !4835)
!4862 = !DILocation(line: 3849, column: 19, scope: !4863)
!4863 = distinct !DILexicalBlock(scope: !4835, file: !36, line: 3849, column: 17)
!4864 = !DILocation(line: 3849, column: 43, scope: !4863)
!4865 = !DILocation(line: 3849, column: 53, scope: !4863)
!4866 = !DILocation(line: 3850, column: 19, scope: !4863)
!4867 = !DILocation(line: 3850, column: 46, scope: !4863)
!4868 = !DILocation(line: 3849, column: 17, scope: !4835)
!4869 = !DILocation(line: 3852, column: 26, scope: !4870)
!4870 = distinct !DILexicalBlock(scope: !4863, file: !36, line: 3851, column: 13)
!4871 = !DILocation(line: 3852, column: 24, scope: !4870)
!4872 = !DILocation(line: 3854, column: 21, scope: !4873)
!4873 = distinct !DILexicalBlock(scope: !4870, file: !36, line: 3854, column: 21)
!4874 = !DILocation(line: 3854, column: 28, scope: !4873)
!4875 = !DILocation(line: 3854, column: 21, scope: !4870)
!4876 = !DILocation(line: 3856, column: 79, scope: !4877)
!4877 = distinct !DILexicalBlock(scope: !4873, file: !36, line: 3855, column: 17)
!4878 = !DILocation(line: 3857, column: 79, scope: !4877)
!4879 = !DILocation(line: 3858, column: 79, scope: !4877)
!4880 = !DILocation(line: 3856, column: 51, scope: !4877)
!4881 = !DILocation(line: 3856, column: 49, scope: !4877)
!4882 = !DILocation(line: 3862, column: 25, scope: !4883)
!4883 = distinct !DILexicalBlock(scope: !4877, file: !36, line: 3862, column: 25)
!4884 = !DILocation(line: 3862, column: 53, scope: !4883)
!4885 = !DILocation(line: 3862, column: 25, scope: !4877)
!4886 = !DILocation(line: 3864, column: 25, scope: !4887)
!4887 = distinct !DILexicalBlock(scope: !4883, file: !36, line: 3863, column: 21)
!4888 = !DILocation(line: 3865, column: 80, scope: !4887)
!4889 = !DILocation(line: 3865, column: 55, scope: !4887)
!4890 = !DILocation(line: 3865, column: 53, scope: !4887)
!4891 = !DILocation(line: 3866, column: 21, scope: !4887)
!4892 = !DILocation(line: 3869, column: 61, scope: !4893)
!4893 = distinct !DILexicalBlock(scope: !4883, file: !36, line: 3868, column: 21)
!4894 = !DILocation(line: 3869, column: 25, scope: !4893)
!4895 = !DILocation(line: 3871, column: 17, scope: !4877)
!4896 = !DILocation(line: 3872, column: 13, scope: !4870)
!4897 = !DILocation(line: 3876, column: 45, scope: !4898)
!4898 = distinct !DILexicalBlock(scope: !4863, file: !36, line: 3874, column: 13)
!4899 = !DILocation(line: 3879, column: 20, scope: !4835)
!4900 = !DILocation(line: 3879, column: 13, scope: !4835)
!4901 = distinct !DISubprogram(name: "MPU_xStreamBufferGenericCreateStatic", scope: !36, file: !36, line: 3887, type: !4902, scopeLine: 3894, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4902 = !DISubroutineType(types: !4903)
!4903 = !{!58, !109, !109, !23, !4904, !4905, !4838, !4838}
!4904 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2927)
!4905 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4906)
!4906 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4907, size: 64)
!4907 = !DIDerivedType(tag: DW_TAG_typedef, name: "StaticStreamBuffer_t", file: !1548, line: 1444, baseType: !4908)
!4908 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xSTATIC_STREAM_BUFFER", file: !1548, line: 1433, size: 704, elements: !4909)
!4909 = !{!4910, !4912, !4913, !4914, !4915}
!4910 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy1", scope: !4908, file: !1548, line: 1435, baseType: !4911, size: 256)
!4911 = !DICompositeType(tag: DW_TAG_array_type, baseType: !109, size: 256, elements: !1575)
!4912 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy2", scope: !4908, file: !1548, line: 1436, baseType: !2813, size: 192, offset: 256)
!4913 = !DIDerivedType(tag: DW_TAG_member, name: "ucDummy3", scope: !4908, file: !1548, line: 1437, baseType: !1583, size: 8, offset: 448)
!4914 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy4", scope: !4908, file: !1548, line: 1439, baseType: !39, size: 64, offset: 512)
!4915 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy5", scope: !4908, file: !1548, line: 1442, baseType: !2832, size: 128, offset: 576)
!4916 = !DILocalVariable(name: "xBufferSizeBytes", arg: 1, scope: !4901, file: !36, line: 3887, type: !109)
!4917 = !DILocation(line: 3887, column: 75, scope: !4901)
!4918 = !DILocalVariable(name: "xTriggerLevelBytes", arg: 2, scope: !4901, file: !36, line: 3888, type: !109)
!4919 = !DILocation(line: 3888, column: 75, scope: !4901)
!4920 = !DILocalVariable(name: "xIsMessageBuffer", arg: 3, scope: !4901, file: !36, line: 3889, type: !23)
!4921 = !DILocation(line: 3889, column: 79, scope: !4901)
!4922 = !DILocalVariable(name: "pucStreamBufferStorageArea", arg: 4, scope: !4901, file: !36, line: 3890, type: !4904)
!4923 = !DILocation(line: 3890, column: 84, scope: !4901)
!4924 = !DILocalVariable(name: "pxStaticStreamBuffer", arg: 5, scope: !4901, file: !36, line: 3891, type: !4905)
!4925 = !DILocation(line: 3891, column: 97, scope: !4901)
!4926 = !DILocalVariable(name: "pxSendCompletedCallback", arg: 6, scope: !4901, file: !36, line: 3892, type: !4838)
!4927 = !DILocation(line: 3892, column: 99, scope: !4901)
!4928 = !DILocalVariable(name: "pxReceiveCompletedCallback", arg: 7, scope: !4901, file: !36, line: 3893, type: !4838)
!4929 = !DILocation(line: 3893, column: 99, scope: !4901)
!4930 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4901, file: !36, line: 3895, type: !58)
!4931 = !DILocation(line: 3895, column: 34, scope: !4901)
!4932 = !DILocalVariable(name: "xExternalStreamBufferHandle", scope: !4901, file: !36, line: 3896, type: !58)
!4933 = !DILocation(line: 3896, column: 34, scope: !4901)
!4934 = !DILocalVariable(name: "lIndex", scope: !4901, file: !36, line: 3897, type: !27)
!4935 = !DILocation(line: 3897, column: 21, scope: !4901)
!4936 = !DILocation(line: 3903, column: 13, scope: !4937)
!4937 = distinct !DILexicalBlock(scope: !4901, file: !36, line: 3903, column: 13)
!4938 = !DILocation(line: 0, scope: !4937)
!4939 = !DILocation(line: 3903, column: 13, scope: !4901)
!4940 = !DILocation(line: 3906, column: 19, scope: !4941)
!4941 = distinct !DILexicalBlock(scope: !4901, file: !36, line: 3906, column: 17)
!4942 = !DILocation(line: 3906, column: 43, scope: !4941)
!4943 = !DILocation(line: 3906, column: 53, scope: !4941)
!4944 = !DILocation(line: 3907, column: 19, scope: !4941)
!4945 = !DILocation(line: 3907, column: 46, scope: !4941)
!4946 = !DILocation(line: 3906, column: 17, scope: !4901)
!4947 = !DILocation(line: 3909, column: 26, scope: !4948)
!4948 = distinct !DILexicalBlock(scope: !4941, file: !36, line: 3908, column: 13)
!4949 = !DILocation(line: 3909, column: 24, scope: !4948)
!4950 = !DILocation(line: 3911, column: 21, scope: !4951)
!4951 = distinct !DILexicalBlock(scope: !4948, file: !36, line: 3911, column: 21)
!4952 = !DILocation(line: 3911, column: 28, scope: !4951)
!4953 = !DILocation(line: 3911, column: 21, scope: !4948)
!4954 = !DILocation(line: 3913, column: 85, scope: !4955)
!4955 = distinct !DILexicalBlock(scope: !4951, file: !36, line: 3912, column: 17)
!4956 = !DILocation(line: 3914, column: 85, scope: !4955)
!4957 = !DILocation(line: 3915, column: 85, scope: !4955)
!4958 = !DILocation(line: 3916, column: 85, scope: !4955)
!4959 = !DILocation(line: 3917, column: 85, scope: !4955)
!4960 = !DILocation(line: 3913, column: 51, scope: !4955)
!4961 = !DILocation(line: 3913, column: 49, scope: !4955)
!4962 = !DILocation(line: 3921, column: 25, scope: !4963)
!4963 = distinct !DILexicalBlock(scope: !4955, file: !36, line: 3921, column: 25)
!4964 = !DILocation(line: 3921, column: 53, scope: !4963)
!4965 = !DILocation(line: 3921, column: 25, scope: !4955)
!4966 = !DILocation(line: 3923, column: 25, scope: !4967)
!4967 = distinct !DILexicalBlock(scope: !4963, file: !36, line: 3922, column: 21)
!4968 = !DILocation(line: 3924, column: 80, scope: !4967)
!4969 = !DILocation(line: 3924, column: 55, scope: !4967)
!4970 = !DILocation(line: 3924, column: 53, scope: !4967)
!4971 = !DILocation(line: 3925, column: 21, scope: !4967)
!4972 = !DILocation(line: 3928, column: 61, scope: !4973)
!4973 = distinct !DILexicalBlock(scope: !4963, file: !36, line: 3927, column: 21)
!4974 = !DILocation(line: 3928, column: 25, scope: !4973)
!4975 = !DILocation(line: 3930, column: 17, scope: !4955)
!4976 = !DILocation(line: 3931, column: 13, scope: !4948)
!4977 = !DILocation(line: 3935, column: 45, scope: !4978)
!4978 = distinct !DILexicalBlock(scope: !4941, file: !36, line: 3933, column: 13)
!4979 = !DILocation(line: 3938, column: 20, scope: !4901)
!4980 = !DILocation(line: 3938, column: 13, scope: !4901)
!4981 = distinct !DISubprogram(name: "MPU_vStreamBufferDelete", scope: !36, file: !36, line: 3944, type: !4982, scopeLine: 3945, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!4982 = !DISubroutineType(types: !4983)
!4983 = !{null, !58}
!4984 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !4981, file: !36, line: 3944, type: !58)
!4985 = !DILocation(line: 3944, column: 56, scope: !4981)
!4986 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4981, file: !36, line: 3946, type: !58)
!4987 = !DILocation(line: 3946, column: 30, scope: !4981)
!4988 = !DILocalVariable(name: "lIndex", scope: !4981, file: !36, line: 3947, type: !27)
!4989 = !DILocation(line: 3947, column: 17, scope: !4981)
!4990 = !DILocation(line: 3949, column: 30, scope: !4981)
!4991 = !DILocation(line: 3949, column: 18, scope: !4981)
!4992 = !DILocation(line: 3949, column: 16, scope: !4981)
!4993 = !DILocation(line: 3951, column: 13, scope: !4994)
!4994 = distinct !DILexicalBlock(scope: !4981, file: !36, line: 3951, column: 13)
!4995 = !DILocation(line: 0, scope: !4994)
!4996 = !DILocation(line: 3951, column: 47, scope: !4994)
!4997 = !DILocation(line: 3951, column: 13, scope: !4981)
!4998 = !DILocation(line: 3953, column: 43, scope: !4999)
!4999 = distinct !DILexicalBlock(scope: !4994, file: !36, line: 3952, column: 9)
!5000 = !DILocation(line: 3953, column: 41, scope: !4999)
!5001 = !DILocation(line: 3955, column: 17, scope: !5002)
!5002 = distinct !DILexicalBlock(scope: !4999, file: !36, line: 3955, column: 17)
!5003 = !DILocation(line: 3955, column: 45, scope: !5002)
!5004 = !DILocation(line: 3955, column: 17, scope: !4999)
!5005 = !DILocation(line: 3957, column: 38, scope: !5006)
!5006 = distinct !DILexicalBlock(scope: !5002, file: !36, line: 3956, column: 13)
!5007 = !DILocation(line: 3957, column: 17, scope: !5006)
!5008 = !DILocation(line: 3958, column: 13, scope: !5006)
!5009 = !DILocation(line: 3960, column: 49, scope: !4999)
!5010 = !DILocation(line: 3960, column: 13, scope: !4999)
!5011 = !DILocation(line: 3961, column: 9, scope: !4999)
!5012 = !DILocation(line: 3962, column: 5, scope: !4981)
!5013 = distinct !DISubprogram(name: "MPU_xStreamBufferReset", scope: !36, file: !36, line: 3965, type: !4635, scopeLine: 3966, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!5014 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !5013, file: !36, line: 3965, type: !58)
!5015 = !DILocation(line: 3965, column: 61, scope: !5013)
!5016 = !DILocalVariable(name: "xReturn", scope: !5013, file: !36, line: 3967, type: !23)
!5017 = !DILocation(line: 3967, column: 20, scope: !5013)
!5018 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !5013, file: !36, line: 3968, type: !58)
!5019 = !DILocation(line: 3968, column: 30, scope: !5013)
!5020 = !DILocalVariable(name: "lIndex", scope: !5013, file: !36, line: 3969, type: !27)
!5021 = !DILocation(line: 3969, column: 17, scope: !5013)
!5022 = !DILocation(line: 3971, column: 30, scope: !5013)
!5023 = !DILocation(line: 3971, column: 18, scope: !5013)
!5024 = !DILocation(line: 3971, column: 16, scope: !5013)
!5025 = !DILocation(line: 3973, column: 13, scope: !5026)
!5026 = distinct !DILexicalBlock(scope: !5013, file: !36, line: 3973, column: 13)
!5027 = !DILocation(line: 0, scope: !5026)
!5028 = !DILocation(line: 3973, column: 47, scope: !5026)
!5029 = !DILocation(line: 3973, column: 13, scope: !5013)
!5030 = !DILocation(line: 3975, column: 43, scope: !5031)
!5031 = distinct !DILexicalBlock(scope: !5026, file: !36, line: 3974, column: 9)
!5032 = !DILocation(line: 3975, column: 41, scope: !5031)
!5033 = !DILocation(line: 3977, column: 17, scope: !5034)
!5034 = distinct !DILexicalBlock(scope: !5031, file: !36, line: 3977, column: 17)
!5035 = !DILocation(line: 3977, column: 45, scope: !5034)
!5036 = !DILocation(line: 3977, column: 17, scope: !5031)
!5037 = !DILocation(line: 3979, column: 47, scope: !5038)
!5038 = distinct !DILexicalBlock(scope: !5034, file: !36, line: 3978, column: 13)
!5039 = !DILocation(line: 3979, column: 27, scope: !5038)
!5040 = !DILocation(line: 3979, column: 25, scope: !5038)
!5041 = !DILocation(line: 3980, column: 13, scope: !5038)
!5042 = !DILocation(line: 3981, column: 9, scope: !5031)
!5043 = !DILocation(line: 3983, column: 16, scope: !5013)
!5044 = !DILocation(line: 3983, column: 9, scope: !5013)
!5045 = distinct !DISubprogram(name: "MPU_xStreamBufferGetStaticBuffers", scope: !36, file: !36, line: 3989, type: !5046, scopeLine: 3992, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!5046 = !DISubroutineType(types: !5047)
!5047 = !{!23, !58, !2927, !4906}
!5048 = !DILocalVariable(name: "xStreamBuffers", arg: 1, scope: !5045, file: !36, line: 3989, type: !58)
!5049 = !DILocation(line: 3989, column: 76, scope: !5045)
!5050 = !DILocalVariable(name: "ppucStreamBufferStorageArea", arg: 2, scope: !5045, file: !36, line: 3990, type: !2927)
!5051 = !DILocation(line: 3990, column: 65, scope: !5045)
!5052 = !DILocalVariable(name: "ppxStaticStreamBuffer", arg: 3, scope: !5045, file: !36, line: 3991, type: !4906)
!5053 = !DILocation(line: 3991, column: 78, scope: !5045)
!5054 = !DILocalVariable(name: "xReturn", scope: !5045, file: !36, line: 3993, type: !23)
!5055 = !DILocation(line: 3993, column: 24, scope: !5045)
!5056 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !5045, file: !36, line: 3994, type: !58)
!5057 = !DILocation(line: 3994, column: 34, scope: !5045)
!5058 = !DILocalVariable(name: "lIndex", scope: !5045, file: !36, line: 3995, type: !27)
!5059 = !DILocation(line: 3995, column: 21, scope: !5045)
!5060 = !DILocation(line: 3997, column: 34, scope: !5045)
!5061 = !DILocation(line: 3997, column: 22, scope: !5045)
!5062 = !DILocation(line: 3997, column: 20, scope: !5045)
!5063 = !DILocation(line: 3999, column: 17, scope: !5064)
!5064 = distinct !DILexicalBlock(scope: !5045, file: !36, line: 3999, column: 17)
!5065 = !DILocation(line: 0, scope: !5064)
!5066 = !DILocation(line: 3999, column: 51, scope: !5064)
!5067 = !DILocation(line: 3999, column: 17, scope: !5045)
!5068 = !DILocation(line: 4001, column: 47, scope: !5069)
!5069 = distinct !DILexicalBlock(scope: !5064, file: !36, line: 4000, column: 13)
!5070 = !DILocation(line: 4001, column: 45, scope: !5069)
!5071 = !DILocation(line: 4003, column: 21, scope: !5072)
!5072 = distinct !DILexicalBlock(scope: !5069, file: !36, line: 4003, column: 21)
!5073 = !DILocation(line: 4003, column: 49, scope: !5072)
!5074 = !DILocation(line: 4003, column: 21, scope: !5069)
!5075 = !DILocation(line: 4005, column: 66, scope: !5076)
!5076 = distinct !DILexicalBlock(scope: !5072, file: !36, line: 4004, column: 17)
!5077 = !DILocation(line: 4005, column: 95, scope: !5076)
!5078 = !DILocation(line: 4005, column: 124, scope: !5076)
!5079 = !DILocation(line: 4005, column: 31, scope: !5076)
!5080 = !DILocation(line: 4005, column: 29, scope: !5076)
!5081 = !DILocation(line: 4006, column: 17, scope: !5076)
!5082 = !DILocation(line: 4007, column: 13, scope: !5069)
!5083 = !DILocation(line: 4009, column: 20, scope: !5045)
!5084 = !DILocation(line: 4009, column: 13, scope: !5045)
!5085 = distinct !DISubprogram(name: "MPU_xStreamBufferSendFromISR", scope: !36, file: !36, line: 4015, type: !5086, scopeLine: 4019, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!5086 = !DISubroutineType(types: !5087)
!5087 = !{!109, !58, !2255, !109, !3144}
!5088 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !5085, file: !36, line: 4015, type: !58)
!5089 = !DILocation(line: 4015, column: 63, scope: !5085)
!5090 = !DILocalVariable(name: "pvTxData", arg: 2, scope: !5085, file: !36, line: 4016, type: !2255)
!5091 = !DILocation(line: 4016, column: 55, scope: !5085)
!5092 = !DILocalVariable(name: "xDataLengthBytes", arg: 3, scope: !5085, file: !36, line: 4017, type: !109)
!5093 = !DILocation(line: 4017, column: 49, scope: !5085)
!5094 = !DILocalVariable(name: "pxHigherPriorityTaskWoken", arg: 4, scope: !5085, file: !36, line: 4018, type: !3144)
!5095 = !DILocation(line: 4018, column: 61, scope: !5085)
!5096 = !DILocalVariable(name: "xReturn", scope: !5085, file: !36, line: 4020, type: !109)
!5097 = !DILocation(line: 4020, column: 16, scope: !5085)
!5098 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !5085, file: !36, line: 4021, type: !58)
!5099 = !DILocation(line: 4021, column: 30, scope: !5085)
!5100 = !DILocalVariable(name: "lIndex", scope: !5085, file: !36, line: 4022, type: !27)
!5101 = !DILocation(line: 4022, column: 17, scope: !5085)
!5102 = !DILocation(line: 4024, column: 30, scope: !5085)
!5103 = !DILocation(line: 4024, column: 18, scope: !5085)
!5104 = !DILocation(line: 4024, column: 16, scope: !5085)
!5105 = !DILocation(line: 4026, column: 13, scope: !5106)
!5106 = distinct !DILexicalBlock(scope: !5085, file: !36, line: 4026, column: 13)
!5107 = !DILocation(line: 0, scope: !5106)
!5108 = !DILocation(line: 4026, column: 47, scope: !5106)
!5109 = !DILocation(line: 4026, column: 13, scope: !5085)
!5110 = !DILocation(line: 4028, column: 43, scope: !5111)
!5111 = distinct !DILexicalBlock(scope: !5106, file: !36, line: 4027, column: 9)
!5112 = !DILocation(line: 4028, column: 41, scope: !5111)
!5113 = !DILocation(line: 4030, column: 17, scope: !5114)
!5114 = distinct !DILexicalBlock(scope: !5111, file: !36, line: 4030, column: 17)
!5115 = !DILocation(line: 4030, column: 45, scope: !5114)
!5116 = !DILocation(line: 4030, column: 17, scope: !5111)
!5117 = !DILocation(line: 4032, column: 53, scope: !5118)
!5118 = distinct !DILexicalBlock(scope: !5114, file: !36, line: 4031, column: 13)
!5119 = !DILocation(line: 4032, column: 82, scope: !5118)
!5120 = !DILocation(line: 4032, column: 92, scope: !5118)
!5121 = !DILocation(line: 4032, column: 110, scope: !5118)
!5122 = !DILocation(line: 4032, column: 27, scope: !5118)
!5123 = !DILocation(line: 4032, column: 25, scope: !5118)
!5124 = !DILocation(line: 4033, column: 13, scope: !5118)
!5125 = !DILocation(line: 4034, column: 9, scope: !5111)
!5126 = !DILocation(line: 4036, column: 16, scope: !5085)
!5127 = !DILocation(line: 4036, column: 9, scope: !5085)
!5128 = distinct !DISubprogram(name: "MPU_xStreamBufferReceiveFromISR", scope: !36, file: !36, line: 4040, type: !5129, scopeLine: 4044, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!5129 = !DISubroutineType(types: !5130)
!5130 = !{!109, !58, !26, !109, !3144}
!5131 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !5128, file: !36, line: 4040, type: !58)
!5132 = !DILocation(line: 4040, column: 66, scope: !5128)
!5133 = !DILocalVariable(name: "pvRxData", arg: 2, scope: !5128, file: !36, line: 4041, type: !26)
!5134 = !DILocation(line: 4041, column: 52, scope: !5128)
!5135 = !DILocalVariable(name: "xBufferLengthBytes", arg: 3, scope: !5128, file: !36, line: 4042, type: !109)
!5136 = !DILocation(line: 4042, column: 52, scope: !5128)
!5137 = !DILocalVariable(name: "pxHigherPriorityTaskWoken", arg: 4, scope: !5128, file: !36, line: 4043, type: !3144)
!5138 = !DILocation(line: 4043, column: 64, scope: !5128)
!5139 = !DILocalVariable(name: "xReturn", scope: !5128, file: !36, line: 4045, type: !109)
!5140 = !DILocation(line: 4045, column: 16, scope: !5128)
!5141 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !5128, file: !36, line: 4046, type: !58)
!5142 = !DILocation(line: 4046, column: 30, scope: !5128)
!5143 = !DILocalVariable(name: "lIndex", scope: !5128, file: !36, line: 4047, type: !27)
!5144 = !DILocation(line: 4047, column: 17, scope: !5128)
!5145 = !DILocation(line: 4049, column: 30, scope: !5128)
!5146 = !DILocation(line: 4049, column: 18, scope: !5128)
!5147 = !DILocation(line: 4049, column: 16, scope: !5128)
!5148 = !DILocation(line: 4051, column: 13, scope: !5149)
!5149 = distinct !DILexicalBlock(scope: !5128, file: !36, line: 4051, column: 13)
!5150 = !DILocation(line: 0, scope: !5149)
!5151 = !DILocation(line: 4051, column: 47, scope: !5149)
!5152 = !DILocation(line: 4051, column: 13, scope: !5128)
!5153 = !DILocation(line: 4053, column: 43, scope: !5154)
!5154 = distinct !DILexicalBlock(scope: !5149, file: !36, line: 4052, column: 9)
!5155 = !DILocation(line: 4053, column: 41, scope: !5154)
!5156 = !DILocation(line: 4055, column: 17, scope: !5157)
!5157 = distinct !DILexicalBlock(scope: !5154, file: !36, line: 4055, column: 17)
!5158 = !DILocation(line: 4055, column: 45, scope: !5157)
!5159 = !DILocation(line: 4055, column: 17, scope: !5154)
!5160 = !DILocation(line: 4057, column: 56, scope: !5161)
!5161 = distinct !DILexicalBlock(scope: !5157, file: !36, line: 4056, column: 13)
!5162 = !DILocation(line: 4057, column: 85, scope: !5161)
!5163 = !DILocation(line: 4057, column: 95, scope: !5161)
!5164 = !DILocation(line: 4057, column: 115, scope: !5161)
!5165 = !DILocation(line: 4057, column: 27, scope: !5161)
!5166 = !DILocation(line: 4057, column: 25, scope: !5161)
!5167 = !DILocation(line: 4058, column: 13, scope: !5161)
!5168 = !DILocation(line: 4059, column: 9, scope: !5154)
!5169 = !DILocation(line: 4061, column: 16, scope: !5128)
!5170 = !DILocation(line: 4061, column: 9, scope: !5128)
!5171 = distinct !DISubprogram(name: "MPU_xStreamBufferSendCompletedFromISR", scope: !36, file: !36, line: 4065, type: !5172, scopeLine: 4067, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!5172 = !DISubroutineType(types: !5173)
!5173 = !{!23, !58, !2168}
!5174 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !5171, file: !36, line: 4065, type: !58)
!5175 = !DILocation(line: 4065, column: 76, scope: !5171)
!5176 = !DILocalVariable(name: "pxHigherPriorityTaskWoken", arg: 2, scope: !5171, file: !36, line: 4066, type: !2168)
!5177 = !DILocation(line: 4066, column: 68, scope: !5171)
!5178 = !DILocalVariable(name: "xReturn", scope: !5171, file: !36, line: 4068, type: !23)
!5179 = !DILocation(line: 4068, column: 20, scope: !5171)
!5180 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !5171, file: !36, line: 4069, type: !58)
!5181 = !DILocation(line: 4069, column: 30, scope: !5171)
!5182 = !DILocalVariable(name: "lIndex", scope: !5171, file: !36, line: 4070, type: !27)
!5183 = !DILocation(line: 4070, column: 17, scope: !5171)
!5184 = !DILocation(line: 4072, column: 30, scope: !5171)
!5185 = !DILocation(line: 4072, column: 18, scope: !5171)
!5186 = !DILocation(line: 4072, column: 16, scope: !5171)
!5187 = !DILocation(line: 4074, column: 13, scope: !5188)
!5188 = distinct !DILexicalBlock(scope: !5171, file: !36, line: 4074, column: 13)
!5189 = !DILocation(line: 0, scope: !5188)
!5190 = !DILocation(line: 4074, column: 47, scope: !5188)
!5191 = !DILocation(line: 4074, column: 13, scope: !5171)
!5192 = !DILocation(line: 4076, column: 43, scope: !5193)
!5193 = distinct !DILexicalBlock(scope: !5188, file: !36, line: 4075, column: 9)
!5194 = !DILocation(line: 4076, column: 41, scope: !5193)
!5195 = !DILocation(line: 4078, column: 17, scope: !5196)
!5196 = distinct !DILexicalBlock(scope: !5193, file: !36, line: 4078, column: 17)
!5197 = !DILocation(line: 4078, column: 45, scope: !5196)
!5198 = !DILocation(line: 4078, column: 17, scope: !5193)
!5199 = !DILocation(line: 4080, column: 62, scope: !5200)
!5200 = distinct !DILexicalBlock(scope: !5196, file: !36, line: 4079, column: 13)
!5201 = !DILocation(line: 4080, column: 91, scope: !5200)
!5202 = !DILocation(line: 4080, column: 27, scope: !5200)
!5203 = !DILocation(line: 4080, column: 25, scope: !5200)
!5204 = !DILocation(line: 4081, column: 13, scope: !5200)
!5205 = !DILocation(line: 4082, column: 9, scope: !5193)
!5206 = !DILocation(line: 4084, column: 16, scope: !5171)
!5207 = !DILocation(line: 4084, column: 9, scope: !5171)
!5208 = distinct !DISubprogram(name: "MPU_xStreamBufferReceiveCompletedFromISR", scope: !36, file: !36, line: 4088, type: !5172, scopeLine: 4090, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !151)
!5209 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !5208, file: !36, line: 4088, type: !58)
!5210 = !DILocation(line: 4088, column: 79, scope: !5208)
!5211 = !DILocalVariable(name: "pxHigherPriorityTaskWoken", arg: 2, scope: !5208, file: !36, line: 4089, type: !2168)
!5212 = !DILocation(line: 4089, column: 71, scope: !5208)
!5213 = !DILocalVariable(name: "xReturn", scope: !5208, file: !36, line: 4091, type: !23)
!5214 = !DILocation(line: 4091, column: 20, scope: !5208)
!5215 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !5208, file: !36, line: 4092, type: !58)
!5216 = !DILocation(line: 4092, column: 30, scope: !5208)
!5217 = !DILocalVariable(name: "lIndex", scope: !5208, file: !36, line: 4093, type: !27)
!5218 = !DILocation(line: 4093, column: 17, scope: !5208)
!5219 = !DILocation(line: 4095, column: 30, scope: !5208)
!5220 = !DILocation(line: 4095, column: 18, scope: !5208)
!5221 = !DILocation(line: 4095, column: 16, scope: !5208)
!5222 = !DILocation(line: 4097, column: 13, scope: !5223)
!5223 = distinct !DILexicalBlock(scope: !5208, file: !36, line: 4097, column: 13)
!5224 = !DILocation(line: 0, scope: !5223)
!5225 = !DILocation(line: 4097, column: 47, scope: !5223)
!5226 = !DILocation(line: 4097, column: 13, scope: !5208)
!5227 = !DILocation(line: 4099, column: 43, scope: !5228)
!5228 = distinct !DILexicalBlock(scope: !5223, file: !36, line: 4098, column: 9)
!5229 = !DILocation(line: 4099, column: 41, scope: !5228)
!5230 = !DILocation(line: 4101, column: 17, scope: !5231)
!5231 = distinct !DILexicalBlock(scope: !5228, file: !36, line: 4101, column: 17)
!5232 = !DILocation(line: 4101, column: 45, scope: !5231)
!5233 = !DILocation(line: 4101, column: 17, scope: !5228)
!5234 = !DILocation(line: 4103, column: 65, scope: !5235)
!5235 = distinct !DILexicalBlock(scope: !5231, file: !36, line: 4102, column: 13)
!5236 = !DILocation(line: 4103, column: 94, scope: !5235)
!5237 = !DILocation(line: 4103, column: 27, scope: !5235)
!5238 = !DILocation(line: 4103, column: 25, scope: !5235)
!5239 = !DILocation(line: 4104, column: 13, scope: !5235)
!5240 = !DILocation(line: 4105, column: 9, scope: !5228)
!5241 = !DILocation(line: 4107, column: 16, scope: !5208)
!5242 = !DILocation(line: 4107, column: 9, scope: !5208)
!5243 = distinct !DISubprogram(name: "pxPortInitialiseStack", scope: !90, file: !90, line: 134, type: !5244, scopeLine: 138, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5244 = !DISubroutineType(types: !5245)
!5245 = !{!108, !117, !117, !97, !26}
!5246 = !DILocalVariable(name: "pxTopOfStack", arg: 1, scope: !5243, file: !90, line: 134, type: !117)
!5247 = !DILocation(line: 134, column: 55, scope: !5243)
!5248 = !DILocalVariable(name: "pxEndOfStack", arg: 2, scope: !5243, file: !90, line: 135, type: !117)
!5249 = !DILocation(line: 135, column: 55, scope: !5243)
!5250 = !DILocalVariable(name: "pxCode", arg: 3, scope: !5243, file: !90, line: 136, type: !97)
!5251 = !DILocation(line: 136, column: 56, scope: !5243)
!5252 = !DILocalVariable(name: "pvParameters", arg: 4, scope: !5243, file: !90, line: 137, type: !26)
!5253 = !DILocation(line: 137, column: 48, scope: !5243)
!5254 = !DILocalVariable(name: "thread", scope: !5243, file: !90, line: 139, type: !88)
!5255 = !DILocation(line: 139, column: 16, scope: !5243)
!5256 = !DILocalVariable(name: "xThreadAttributes", scope: !5243, file: !90, line: 140, type: !5257)
!5257 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_attr_t", file: !95, line: 62, baseType: !5258)
!5258 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "pthread_attr_t", file: !95, line: 56, size: 448, elements: !5259)
!5259 = !{!5260, !5264}
!5260 = !DIDerivedType(tag: DW_TAG_member, name: "__size", scope: !5258, file: !95, line: 58, baseType: !5261, size: 448)
!5261 = !DICompositeType(tag: DW_TAG_array_type, baseType: !358, size: 448, elements: !5262)
!5262 = !{!5263}
!5263 = !DISubrange(count: 56)
!5264 = !DIDerivedType(tag: DW_TAG_member, name: "__align", scope: !5258, file: !95, line: 59, baseType: !25, size: 64)
!5265 = !DILocation(line: 140, column: 20, scope: !5243)
!5266 = !DILocalVariable(name: "ulStackSize", scope: !5243, file: !90, line: 141, type: !109)
!5267 = !DILocation(line: 141, column: 12, scope: !5243)
!5268 = !DILocalVariable(name: "iRet", scope: !5243, file: !90, line: 142, type: !31)
!5269 = !DILocation(line: 142, column: 9, scope: !5243)
!5270 = !DILocation(line: 144, column: 14, scope: !5243)
!5271 = !DILocation(line: 149, column: 31, scope: !5243)
!5272 = !DILocation(line: 149, column: 44, scope: !5243)
!5273 = !DILocation(line: 149, column: 14, scope: !5243)
!5274 = !DILocation(line: 149, column: 50, scope: !5243)
!5275 = !DILocation(line: 149, column: 12, scope: !5243)
!5276 = !DILocation(line: 150, column: 41, scope: !5243)
!5277 = !DILocation(line: 150, column: 20, scope: !5243)
!5278 = !DILocation(line: 150, column: 48, scope: !5243)
!5279 = !DILocation(line: 150, column: 18, scope: !5243)
!5280 = !DILocation(line: 151, column: 31, scope: !5243)
!5281 = !DILocation(line: 151, column: 44, scope: !5243)
!5282 = !DILocation(line: 151, column: 50, scope: !5243)
!5283 = !DILocation(line: 151, column: 48, scope: !5243)
!5284 = !DILocation(line: 151, column: 65, scope: !5243)
!5285 = !DILocation(line: 151, column: 17, scope: !5243)
!5286 = !DILocation(line: 158, column: 22, scope: !5243)
!5287 = !DILocation(line: 158, column: 5, scope: !5243)
!5288 = !DILocation(line: 158, column: 13, scope: !5243)
!5289 = !DILocation(line: 158, column: 20, scope: !5243)
!5290 = !DILocation(line: 159, column: 24, scope: !5243)
!5291 = !DILocation(line: 159, column: 5, scope: !5243)
!5292 = !DILocation(line: 159, column: 13, scope: !5243)
!5293 = !DILocation(line: 159, column: 22, scope: !5243)
!5294 = !DILocation(line: 160, column: 5, scope: !5243)
!5295 = !DILocation(line: 160, column: 13, scope: !5243)
!5296 = !DILocation(line: 160, column: 20, scope: !5243)
!5297 = !DILocation(line: 162, column: 5, scope: !5243)
!5298 = !DILocation(line: 163, column: 55, scope: !5243)
!5299 = !DILocation(line: 163, column: 69, scope: !5243)
!5300 = !DILocation(line: 163, column: 12, scope: !5243)
!5301 = !DILocation(line: 163, column: 10, scope: !5243)
!5302 = !DILocation(line: 164, column: 9, scope: !5303)
!5303 = distinct !DILexicalBlock(scope: !5243, file: !90, line: 164, column: 9)
!5304 = !DILocation(line: 164, column: 14, scope: !5303)
!5305 = !DILocation(line: 164, column: 9, scope: !5243)
!5306 = !DILocation(line: 166, column: 18, scope: !5307)
!5307 = distinct !DILexicalBlock(scope: !5303, file: !90, line: 165, column: 5)
!5308 = !DILocation(line: 166, column: 118, scope: !5307)
!5309 = !DILocation(line: 166, column: 9, scope: !5307)
!5310 = !DILocation(line: 167, column: 18, scope: !5307)
!5311 = !DILocation(line: 167, column: 9, scope: !5307)
!5312 = !DILocation(line: 168, column: 5, scope: !5307)
!5313 = !DILocation(line: 170, column: 18, scope: !5243)
!5314 = !DILocation(line: 170, column: 5, scope: !5243)
!5315 = !DILocation(line: 170, column: 13, scope: !5243)
!5316 = !DILocation(line: 170, column: 16, scope: !5243)
!5317 = !DILocation(line: 172, column: 5, scope: !5243)
!5318 = !DILocation(line: 174, column: 29, scope: !5243)
!5319 = !DILocation(line: 174, column: 37, scope: !5243)
!5320 = !DILocation(line: 175, column: 45, scope: !5243)
!5321 = !DILocation(line: 174, column: 12, scope: !5243)
!5322 = !DILocation(line: 174, column: 10, scope: !5243)
!5323 = !DILocation(line: 177, column: 9, scope: !5324)
!5324 = distinct !DILexicalBlock(scope: !5243, file: !90, line: 177, column: 9)
!5325 = !DILocation(line: 177, column: 14, scope: !5324)
!5326 = !DILocation(line: 177, column: 9, scope: !5243)
!5327 = !DILocation(line: 179, column: 42, scope: !5328)
!5328 = distinct !DILexicalBlock(scope: !5324, file: !90, line: 178, column: 5)
!5329 = !DILocation(line: 179, column: 9, scope: !5328)
!5330 = !DILocation(line: 182, column: 5, scope: !5243)
!5331 = !DILocation(line: 184, column: 12, scope: !5243)
!5332 = !DILocation(line: 184, column: 5, scope: !5243)
!5333 = distinct !DISubprogram(name: "prvSetupSignalsAndSchedulerPolicy", scope: !90, file: !90, line: 549, type: !5334, scopeLine: 550, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5334 = !DISubroutineType(types: !5335)
!5335 = !{null}
!5336 = !DILocalVariable(name: "sigtick", scope: !5333, file: !90, line: 551, type: !5337)
!5337 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "sigaction", file: !5338, line: 24, size: 1216, elements: !5339)
!5338 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/sigaction.h", directory: "")
!5339 = !{!5340, !5424, !5425, !5426}
!5340 = !DIDerivedType(tag: DW_TAG_member, name: "__sigaction_handler", scope: !5337, file: !5338, line: 35, baseType: !5341, size: 64)
!5341 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !5337, file: !5338, line: 28, size: 64, elements: !5342)
!5342 = !{!5343, !5344}
!5343 = !DIDerivedType(tag: DW_TAG_member, name: "sa_handler", scope: !5341, file: !5338, line: 31, baseType: !111, size: 64)
!5344 = !DIDerivedType(tag: DW_TAG_member, name: "sa_sigaction", scope: !5341, file: !5338, line: 33, baseType: !5345, size: 64)
!5345 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5346, size: 64)
!5346 = !DISubroutineType(types: !5347)
!5347 = !{null, !31, !5348, !26}
!5348 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5349, size: 64)
!5349 = !DIDerivedType(tag: DW_TAG_typedef, name: "siginfo_t", file: !5350, line: 124, baseType: !5351)
!5350 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/siginfo_t.h", directory: "")
!5351 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !5350, line: 36, size: 1024, elements: !5352)
!5352 = !{!5353, !5354, !5355, !5356, !5357}
!5353 = !DIDerivedType(tag: DW_TAG_member, name: "si_signo", scope: !5351, file: !5350, line: 38, baseType: !31, size: 32)
!5354 = !DIDerivedType(tag: DW_TAG_member, name: "si_errno", scope: !5351, file: !5350, line: 40, baseType: !31, size: 32, offset: 32)
!5355 = !DIDerivedType(tag: DW_TAG_member, name: "si_code", scope: !5351, file: !5350, line: 42, baseType: !31, size: 32, offset: 64)
!5356 = !DIDerivedType(tag: DW_TAG_member, name: "__pad0", scope: !5351, file: !5350, line: 48, baseType: !31, size: 32, offset: 96)
!5357 = !DIDerivedType(tag: DW_TAG_member, name: "_sifields", scope: !5351, file: !5350, line: 123, baseType: !5358, size: 896, offset: 128)
!5358 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !5351, file: !5350, line: 51, size: 896, elements: !5359)
!5359 = !{!5360, !5364, !5371, !5383, !5389, !5398, !5413, !5418}
!5360 = !DIDerivedType(tag: DW_TAG_member, name: "_pad", scope: !5358, file: !5350, line: 53, baseType: !5361, size: 896)
!5361 = !DICompositeType(tag: DW_TAG_array_type, baseType: !31, size: 896, elements: !5362)
!5362 = !{!5363}
!5363 = !DISubrange(count: 28)
!5364 = !DIDerivedType(tag: DW_TAG_member, name: "_kill", scope: !5358, file: !5350, line: 60, baseType: !5365, size: 64)
!5365 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !5358, file: !5350, line: 56, size: 64, elements: !5366)
!5366 = !{!5367, !5369}
!5367 = !DIDerivedType(tag: DW_TAG_member, name: "si_pid", scope: !5365, file: !5350, line: 58, baseType: !5368, size: 32)
!5368 = !DIDerivedType(tag: DW_TAG_typedef, name: "__pid_t", file: !30, line: 142, baseType: !31)
!5369 = !DIDerivedType(tag: DW_TAG_member, name: "si_uid", scope: !5365, file: !5350, line: 59, baseType: !5370, size: 32, offset: 32)
!5370 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uid_t", file: !30, line: 134, baseType: !7)
!5371 = !DIDerivedType(tag: DW_TAG_member, name: "_timer", scope: !5358, file: !5350, line: 68, baseType: !5372, size: 128)
!5372 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !5358, file: !5350, line: 63, size: 128, elements: !5373)
!5373 = !{!5374, !5375, !5376}
!5374 = !DIDerivedType(tag: DW_TAG_member, name: "si_tid", scope: !5372, file: !5350, line: 65, baseType: !31, size: 32)
!5375 = !DIDerivedType(tag: DW_TAG_member, name: "si_overrun", scope: !5372, file: !5350, line: 66, baseType: !31, size: 32, offset: 32)
!5376 = !DIDerivedType(tag: DW_TAG_member, name: "si_sigval", scope: !5372, file: !5350, line: 67, baseType: !5377, size: 64, offset: 64)
!5377 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sigval_t", file: !5378, line: 30, baseType: !5379)
!5378 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/__sigval_t.h", directory: "")
!5379 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "sigval", file: !5378, line: 24, size: 64, elements: !5380)
!5380 = !{!5381, !5382}
!5381 = !DIDerivedType(tag: DW_TAG_member, name: "sival_int", scope: !5379, file: !5378, line: 26, baseType: !31, size: 32)
!5382 = !DIDerivedType(tag: DW_TAG_member, name: "sival_ptr", scope: !5379, file: !5378, line: 27, baseType: !26, size: 64)
!5383 = !DIDerivedType(tag: DW_TAG_member, name: "_rt", scope: !5358, file: !5350, line: 76, baseType: !5384, size: 128)
!5384 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !5358, file: !5350, line: 71, size: 128, elements: !5385)
!5385 = !{!5386, !5387, !5388}
!5386 = !DIDerivedType(tag: DW_TAG_member, name: "si_pid", scope: !5384, file: !5350, line: 73, baseType: !5368, size: 32)
!5387 = !DIDerivedType(tag: DW_TAG_member, name: "si_uid", scope: !5384, file: !5350, line: 74, baseType: !5370, size: 32, offset: 32)
!5388 = !DIDerivedType(tag: DW_TAG_member, name: "si_sigval", scope: !5384, file: !5350, line: 75, baseType: !5377, size: 64, offset: 64)
!5389 = !DIDerivedType(tag: DW_TAG_member, name: "_sigchld", scope: !5358, file: !5350, line: 86, baseType: !5390, size: 256)
!5390 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !5358, file: !5350, line: 79, size: 256, elements: !5391)
!5391 = !{!5392, !5393, !5394, !5395, !5397}
!5392 = !DIDerivedType(tag: DW_TAG_member, name: "si_pid", scope: !5390, file: !5350, line: 81, baseType: !5368, size: 32)
!5393 = !DIDerivedType(tag: DW_TAG_member, name: "si_uid", scope: !5390, file: !5350, line: 82, baseType: !5370, size: 32, offset: 32)
!5394 = !DIDerivedType(tag: DW_TAG_member, name: "si_status", scope: !5390, file: !5350, line: 83, baseType: !31, size: 32, offset: 64)
!5395 = !DIDerivedType(tag: DW_TAG_member, name: "si_utime", scope: !5390, file: !5350, line: 84, baseType: !5396, size: 64, offset: 128)
!5396 = !DIDerivedType(tag: DW_TAG_typedef, name: "__clock_t", file: !30, line: 144, baseType: !25)
!5397 = !DIDerivedType(tag: DW_TAG_member, name: "si_stime", scope: !5390, file: !5350, line: 85, baseType: !5396, size: 64, offset: 192)
!5398 = !DIDerivedType(tag: DW_TAG_member, name: "_sigfault", scope: !5358, file: !5350, line: 105, baseType: !5399, size: 256)
!5399 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !5358, file: !5350, line: 89, size: 256, elements: !5400)
!5400 = !{!5401, !5402, !5404}
!5401 = !DIDerivedType(tag: DW_TAG_member, name: "si_addr", scope: !5399, file: !5350, line: 91, baseType: !26, size: 64)
!5402 = !DIDerivedType(tag: DW_TAG_member, name: "si_addr_lsb", scope: !5399, file: !5350, line: 93, baseType: !5403, size: 16, offset: 64)
!5403 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!5404 = !DIDerivedType(tag: DW_TAG_member, name: "_bounds", scope: !5399, file: !5350, line: 104, baseType: !5405, size: 128, offset: 128)
!5405 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !5399, file: !5350, line: 94, size: 128, elements: !5406)
!5406 = !{!5407, !5412}
!5407 = !DIDerivedType(tag: DW_TAG_member, name: "_addr_bnd", scope: !5405, file: !5350, line: 101, baseType: !5408, size: 128)
!5408 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !5405, file: !5350, line: 97, size: 128, elements: !5409)
!5409 = !{!5410, !5411}
!5410 = !DIDerivedType(tag: DW_TAG_member, name: "_lower", scope: !5408, file: !5350, line: 99, baseType: !26, size: 64)
!5411 = !DIDerivedType(tag: DW_TAG_member, name: "_upper", scope: !5408, file: !5350, line: 100, baseType: !26, size: 64, offset: 64)
!5412 = !DIDerivedType(tag: DW_TAG_member, name: "_pkey", scope: !5405, file: !5350, line: 103, baseType: !49, size: 32)
!5413 = !DIDerivedType(tag: DW_TAG_member, name: "_sigpoll", scope: !5358, file: !5350, line: 112, baseType: !5414, size: 128)
!5414 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !5358, file: !5350, line: 108, size: 128, elements: !5415)
!5415 = !{!5416, !5417}
!5416 = !DIDerivedType(tag: DW_TAG_member, name: "si_band", scope: !5414, file: !5350, line: 110, baseType: !25, size: 64)
!5417 = !DIDerivedType(tag: DW_TAG_member, name: "si_fd", scope: !5414, file: !5350, line: 111, baseType: !31, size: 32, offset: 64)
!5418 = !DIDerivedType(tag: DW_TAG_member, name: "_sigsys", scope: !5358, file: !5350, line: 121, baseType: !5419, size: 128)
!5419 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !5358, file: !5350, line: 116, size: 128, elements: !5420)
!5420 = !{!5421, !5422, !5423}
!5421 = !DIDerivedType(tag: DW_TAG_member, name: "_call_addr", scope: !5419, file: !5350, line: 118, baseType: !26, size: 64)
!5422 = !DIDerivedType(tag: DW_TAG_member, name: "_syscall", scope: !5419, file: !5350, line: 119, baseType: !31, size: 32, offset: 64)
!5423 = !DIDerivedType(tag: DW_TAG_member, name: "_arch", scope: !5419, file: !5350, line: 120, baseType: !7, size: 32, offset: 96)
!5424 = !DIDerivedType(tag: DW_TAG_member, name: "sa_mask", scope: !5337, file: !5338, line: 43, baseType: !127, size: 1024, offset: 64)
!5425 = !DIDerivedType(tag: DW_TAG_member, name: "sa_flags", scope: !5337, file: !5338, line: 46, baseType: !31, size: 32, offset: 1088)
!5426 = !DIDerivedType(tag: DW_TAG_member, name: "sa_restorer", scope: !5337, file: !5338, line: 49, baseType: !5427, size: 64, offset: 1152)
!5427 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5334, size: 64)
!5428 = !DILocation(line: 551, column: 22, scope: !5333)
!5429 = !DILocalVariable(name: "iRet", scope: !5333, file: !90, line: 552, type: !31)
!5430 = !DILocation(line: 552, column: 9, scope: !5333)
!5431 = !DILocation(line: 554, column: 19, scope: !5333)
!5432 = !DILocation(line: 554, column: 17, scope: !5333)
!5433 = !DILocation(line: 557, column: 5, scope: !5333)
!5434 = !DILocation(line: 561, column: 5, scope: !5333)
!5435 = !DILocation(line: 570, column: 14, scope: !5333)
!5436 = !DILocation(line: 574, column: 13, scope: !5333)
!5437 = !DILocation(line: 574, column: 22, scope: !5333)
!5438 = !DILocation(line: 575, column: 13, scope: !5333)
!5439 = !DILocation(line: 575, column: 24, scope: !5333)
!5440 = !DILocation(line: 576, column: 26, scope: !5333)
!5441 = !DILocation(line: 576, column: 5, scope: !5333)
!5442 = !DILocation(line: 578, column: 12, scope: !5333)
!5443 = !DILocation(line: 578, column: 10, scope: !5333)
!5444 = !DILocation(line: 580, column: 9, scope: !5445)
!5445 = distinct !DILexicalBlock(scope: !5333, file: !90, line: 580, column: 9)
!5446 = !DILocation(line: 580, column: 14, scope: !5445)
!5447 = !DILocation(line: 580, column: 9, scope: !5333)
!5448 = !DILocation(line: 582, column: 37, scope: !5449)
!5449 = distinct !DILexicalBlock(scope: !5445, file: !90, line: 581, column: 5)
!5450 = !DILocation(line: 582, column: 9, scope: !5449)
!5451 = !DILocation(line: 584, column: 1, scope: !5333)
!5452 = distinct !DISubprogram(name: "vPortEnterCritical", scope: !90, file: !90, line: 275, type: !5334, scopeLine: 276, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5453 = !DILocation(line: 277, column: 9, scope: !5454)
!5454 = distinct !DILexicalBlock(scope: !5452, file: !90, line: 277, column: 9)
!5455 = !DILocation(line: 277, column: 27, scope: !5454)
!5456 = !DILocation(line: 277, column: 9, scope: !5452)
!5457 = !DILocation(line: 279, column: 9, scope: !5458)
!5458 = distinct !DILexicalBlock(scope: !5454, file: !90, line: 278, column: 5)
!5459 = !DILocation(line: 280, column: 5, scope: !5458)
!5460 = !DILocation(line: 282, column: 22, scope: !5452)
!5461 = !DILocation(line: 283, column: 1, scope: !5452)
!5462 = distinct !DISubprogram(name: "prvWaitForStart", scope: !90, file: !90, line: 466, type: !5463, scopeLine: 467, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5463 = !DISubroutineType(types: !5464)
!5464 = !{!26, !26}
!5465 = !DILocalVariable(name: "pvParams", arg: 1, scope: !5462, file: !90, line: 466, type: !26)
!5466 = !DILocation(line: 466, column: 39, scope: !5462)
!5467 = !DILocalVariable(name: "pxThread", scope: !5462, file: !90, line: 468, type: !88)
!5468 = !DILocation(line: 468, column: 16, scope: !5462)
!5469 = !DILocation(line: 468, column: 27, scope: !5462)
!5470 = !DILocation(line: 470, column: 21, scope: !5462)
!5471 = !DILocation(line: 470, column: 5, scope: !5462)
!5472 = !DILocation(line: 473, column: 23, scope: !5462)
!5473 = !DILocation(line: 474, column: 5, scope: !5462)
!5474 = !DILocation(line: 477, column: 5, scope: !5462)
!5475 = !DILocation(line: 477, column: 15, scope: !5462)
!5476 = !DILocation(line: 477, column: 23, scope: !5462)
!5477 = !DILocation(line: 477, column: 33, scope: !5462)
!5478 = !DILocation(line: 484, column: 5, scope: !5479)
!5479 = distinct !DILexicalBlock(scope: !5462, file: !90, line: 484, column: 5)
!5480 = !DILocation(line: 486, column: 5, scope: !5462)
!5481 = !{!5482}
!5482 = !{i64 2, i64 3, i1 false}
!5483 = distinct !DISubprogram(name: "prvFatalError", scope: !90, file: !90, line: 124, type: !5484, scopeLine: 126, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5484 = !DISubroutineType(types: !5485)
!5485 = !{null, !356, !31}
!5486 = !DILocalVariable(name: "pcCall", arg: 1, scope: !5483, file: !90, line: 124, type: !356)
!5487 = !DILocation(line: 124, column: 34, scope: !5483)
!5488 = !DILocalVariable(name: "iErrno", arg: 2, scope: !5483, file: !90, line: 125, type: !31)
!5489 = !DILocation(line: 125, column: 32, scope: !5483)
!5490 = !DILocation(line: 127, column: 14, scope: !5483)
!5491 = !DILocation(line: 127, column: 34, scope: !5483)
!5492 = !DILocation(line: 127, column: 52, scope: !5483)
!5493 = !DILocation(line: 127, column: 42, scope: !5483)
!5494 = !DILocation(line: 127, column: 5, scope: !5483)
!5495 = !DILocation(line: 128, column: 5, scope: !5483)
!5496 = distinct !DISubprogram(name: "vPortExitCritical", scope: !90, file: !90, line: 286, type: !5334, scopeLine: 287, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5497 = !DILocation(line: 288, column: 22, scope: !5496)
!5498 = !DILocation(line: 291, column: 9, scope: !5499)
!5499 = distinct !DILexicalBlock(scope: !5496, file: !90, line: 291, column: 9)
!5500 = !DILocation(line: 291, column: 27, scope: !5499)
!5501 = !DILocation(line: 291, column: 9, scope: !5496)
!5502 = !DILocation(line: 293, column: 9, scope: !5503)
!5503 = distinct !DILexicalBlock(scope: !5499, file: !90, line: 292, column: 5)
!5504 = !DILocation(line: 294, column: 5, scope: !5503)
!5505 = !DILocation(line: 295, column: 1, scope: !5496)
!5506 = distinct !DISubprogram(name: "vPortEnableInterrupts", scope: !90, file: !90, line: 329, type: !5334, scopeLine: 330, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5507 = !DILocation(line: 331, column: 5, scope: !5506)
!5508 = !DILocation(line: 332, column: 1, scope: !5506)
!5509 = distinct !DISubprogram(name: "prvSuspendSelf", scope: !90, file: !90, line: 520, type: !5510, scopeLine: 521, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5510 = !DISubroutineType(types: !5511)
!5511 = !{null, !88}
!5512 = !DILocalVariable(name: "thread", arg: 1, scope: !5509, file: !90, line: 520, type: !88)
!5513 = !DILocation(line: 520, column: 40, scope: !5509)
!5514 = !DILocation(line: 535, column: 17, scope: !5509)
!5515 = !DILocation(line: 535, column: 25, scope: !5509)
!5516 = !DILocation(line: 535, column: 5, scope: !5509)
!5517 = !DILocation(line: 536, column: 1, scope: !5509)
!5518 = distinct !DISubprogram(name: "vPortDisableInterrupts", scope: !90, file: !90, line: 323, type: !5334, scopeLine: 324, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5519 = !DILocation(line: 325, column: 5, scope: !5518)
!5520 = !DILocation(line: 326, column: 1, scope: !5518)
!5521 = distinct !DISubprogram(name: "vPortSystemTickHandler", scope: !90, file: !90, line: 401, type: !114, scopeLine: 402, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5522 = !DILocalVariable(name: "sig", arg: 1, scope: !5521, file: !90, line: 401, type: !31)
!5523 = !DILocation(line: 401, column: 41, scope: !5521)
!5524 = !DILocalVariable(name: "pxThreadToSuspend", scope: !5521, file: !90, line: 403, type: !88)
!5525 = !DILocation(line: 403, column: 16, scope: !5521)
!5526 = !DILocalVariable(name: "pxThreadToResume", scope: !5521, file: !90, line: 404, type: !88)
!5527 = !DILocation(line: 404, column: 16, scope: !5521)
!5528 = !DILocation(line: 406, column: 14, scope: !5521)
!5529 = !DILocation(line: 410, column: 22, scope: !5521)
!5530 = !DILocation(line: 413, column: 51, scope: !5521)
!5531 = !DILocation(line: 413, column: 29, scope: !5521)
!5532 = !DILocation(line: 413, column: 27, scope: !5521)
!5533 = !DILocation(line: 424, column: 5, scope: !5521)
!5534 = !DILocation(line: 432, column: 9, scope: !5521)
!5535 = !DILocation(line: 434, column: 50, scope: !5521)
!5536 = !DILocation(line: 434, column: 28, scope: !5521)
!5537 = !DILocation(line: 434, column: 26, scope: !5521)
!5538 = !DILocation(line: 436, column: 26, scope: !5521)
!5539 = !DILocation(line: 436, column: 44, scope: !5521)
!5540 = !DILocation(line: 436, column: 9, scope: !5521)
!5541 = !DILocation(line: 439, column: 22, scope: !5521)
!5542 = !DILocation(line: 440, column: 1, scope: !5521)
!5543 = distinct !DISubprogram(name: "prvGetThreadFromTask", scope: !90, file: !90, line: 90, type: !5544, scopeLine: 91, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5544 = !DISubroutineType(types: !5545)
!5545 = !{!88, !32}
!5546 = !DILocalVariable(name: "xTask", arg: 1, scope: !5543, file: !90, line: 90, type: !32)
!5547 = !DILocation(line: 90, column: 61, scope: !5543)
!5548 = !DILocalVariable(name: "pxTopOfStack", scope: !5543, file: !90, line: 92, type: !117)
!5549 = !DILocation(line: 92, column: 19, scope: !5543)
!5550 = !DILocation(line: 92, column: 54, scope: !5543)
!5551 = !DILocation(line: 92, column: 34, scope: !5543)
!5552 = !DILocation(line: 94, column: 29, scope: !5543)
!5553 = !DILocation(line: 94, column: 42, scope: !5543)
!5554 = !DILocation(line: 94, column: 12, scope: !5543)
!5555 = !DILocation(line: 94, column: 5, scope: !5543)
!5556 = distinct !DISubprogram(name: "prvSwitchThread", scope: !90, file: !90, line: 490, type: !5557, scopeLine: 492, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5557 = !DISubroutineType(types: !5558)
!5558 = !{null, !88, !88}
!5559 = !DILocalVariable(name: "pxThreadToResume", arg: 1, scope: !5556, file: !90, line: 490, type: !88)
!5560 = !DILocation(line: 490, column: 41, scope: !5556)
!5561 = !DILocalVariable(name: "pxThreadToSuspend", arg: 2, scope: !5556, file: !90, line: 491, type: !88)
!5562 = !DILocation(line: 491, column: 41, scope: !5556)
!5563 = !DILocalVariable(name: "uxSavedCriticalNesting", scope: !5556, file: !90, line: 493, type: !23)
!5564 = !DILocation(line: 493, column: 16, scope: !5556)
!5565 = !DILocation(line: 495, column: 9, scope: !5566)
!5566 = distinct !DILexicalBlock(scope: !5556, file: !90, line: 495, column: 9)
!5567 = !DILocation(line: 495, column: 30, scope: !5566)
!5568 = !DILocation(line: 495, column: 27, scope: !5566)
!5569 = !DILocation(line: 495, column: 9, scope: !5556)
!5570 = !DILocation(line: 504, column: 34, scope: !5571)
!5571 = distinct !DILexicalBlock(scope: !5566, file: !90, line: 496, column: 5)
!5572 = !DILocation(line: 504, column: 32, scope: !5571)
!5573 = !DILocation(line: 506, column: 26, scope: !5571)
!5574 = !DILocation(line: 506, column: 9, scope: !5571)
!5575 = !DILocation(line: 508, column: 13, scope: !5576)
!5576 = distinct !DILexicalBlock(scope: !5571, file: !90, line: 508, column: 13)
!5577 = !DILocation(line: 508, column: 32, scope: !5576)
!5578 = !DILocation(line: 508, column: 39, scope: !5576)
!5579 = !DILocation(line: 508, column: 13, scope: !5571)
!5580 = !DILocation(line: 511, column: 9, scope: !5581)
!5581 = distinct !DILexicalBlock(scope: !5576, file: !90, line: 509, column: 9)
!5582 = !DILocation(line: 513, column: 25, scope: !5571)
!5583 = !DILocation(line: 513, column: 9, scope: !5571)
!5584 = !DILocation(line: 515, column: 29, scope: !5571)
!5585 = !DILocation(line: 515, column: 27, scope: !5571)
!5586 = !DILocation(line: 516, column: 5, scope: !5571)
!5587 = !DILocation(line: 517, column: 1, scope: !5556)
!5588 = distinct !DISubprogram(name: "prvResumeThread", scope: !90, file: !90, line: 540, type: !5510, scopeLine: 541, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5589 = !DILocalVariable(name: "xThreadId", arg: 1, scope: !5588, file: !90, line: 540, type: !88)
!5590 = !DILocation(line: 540, column: 41, scope: !5588)
!5591 = !DILocation(line: 542, column: 9, scope: !5592)
!5592 = distinct !DILexicalBlock(scope: !5588, file: !90, line: 542, column: 9)
!5593 = !DILocation(line: 542, column: 27, scope: !5592)
!5594 = !DILocation(line: 542, column: 38, scope: !5592)
!5595 = !DILocation(line: 542, column: 24, scope: !5592)
!5596 = !DILocation(line: 542, column: 9, scope: !5588)
!5597 = !DILocation(line: 544, column: 23, scope: !5598)
!5598 = distinct !DILexicalBlock(scope: !5592, file: !90, line: 543, column: 5)
!5599 = !DILocation(line: 544, column: 34, scope: !5598)
!5600 = !DILocation(line: 544, column: 9, scope: !5598)
!5601 = !DILocation(line: 545, column: 5, scope: !5598)
!5602 = !DILocation(line: 546, column: 1, scope: !5588)
!5603 = distinct !DISubprogram(name: "xPortStartScheduler", scope: !90, file: !90, line: 200, type: !1077, scopeLine: 201, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5604 = !DILocalVariable(name: "iSignal", scope: !5603, file: !90, line: 202, type: !31)
!5605 = !DILocation(line: 202, column: 9, scope: !5603)
!5606 = !DILocalVariable(name: "xSignals", scope: !5603, file: !90, line: 203, type: !125)
!5607 = !DILocation(line: 203, column: 14, scope: !5603)
!5608 = !DILocation(line: 205, column: 19, scope: !5603)
!5609 = !DILocation(line: 205, column: 17, scope: !5603)
!5610 = !DILocation(line: 209, column: 5, scope: !5603)
!5611 = !DILocation(line: 216, column: 5, scope: !5603)
!5612 = !DILocation(line: 217, column: 5, scope: !5603)
!5613 = !DILocation(line: 218, column: 14, scope: !5603)
!5614 = !DILocation(line: 221, column: 5, scope: !5603)
!5615 = !DILocation(line: 224, column: 5, scope: !5603)
!5616 = !DILocation(line: 224, column: 12, scope: !5603)
!5617 = !DILocation(line: 224, column: 26, scope: !5603)
!5618 = !DILocation(line: 226, column: 9, scope: !5619)
!5619 = distinct !DILexicalBlock(scope: !5603, file: !90, line: 225, column: 5)
!5620 = distinct !{!5620, !5615, !5621}
!5621 = !DILocation(line: 227, column: 5, scope: !5603)
!5622 = !DILocation(line: 231, column: 28, scope: !5603)
!5623 = !DILocation(line: 231, column: 9, scope: !5603)
!5624 = !DILocation(line: 236, column: 28, scope: !5603)
!5625 = !DILocation(line: 236, column: 9, scope: !5603)
!5626 = !DILocation(line: 240, column: 14, scope: !5603)
!5627 = !DILocation(line: 242, column: 5, scope: !5603)
!5628 = distinct !DISubprogram(name: "prvSetupTimerInterrupt", scope: !90, file: !90, line: 368, type: !5334, scopeLine: 369, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5629 = !DILocalVariable(name: "itimer", scope: !5628, file: !90, line: 370, type: !5630)
!5630 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "itimerval", file: !82, line: 104, size: 256, elements: !5631)
!5631 = !{!5632, !5640}
!5632 = !DIDerivedType(tag: DW_TAG_member, name: "it_interval", scope: !5630, file: !82, line: 107, baseType: !5633, size: 128)
!5633 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timeval", file: !5634, line: 8, size: 128, elements: !5635)
!5634 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h", directory: "")
!5635 = !{!5636, !5638}
!5636 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !5633, file: !5634, line: 10, baseType: !5637, size: 64)
!5637 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !30, line: 148, baseType: !25)
!5638 = !DIDerivedType(tag: DW_TAG_member, name: "tv_usec", scope: !5633, file: !5634, line: 11, baseType: !5639, size: 64, offset: 64)
!5639 = !DIDerivedType(tag: DW_TAG_typedef, name: "__suseconds_t", file: !30, line: 150, baseType: !25)
!5640 = !DIDerivedType(tag: DW_TAG_member, name: "it_value", scope: !5630, file: !82, line: 109, baseType: !5633, size: 128, offset: 128)
!5641 = !DILocation(line: 370, column: 22, scope: !5628)
!5642 = !DILocalVariable(name: "iRet", scope: !5628, file: !90, line: 371, type: !31)
!5643 = !DILocation(line: 371, column: 9, scope: !5628)
!5644 = !DILocation(line: 374, column: 12, scope: !5628)
!5645 = !DILocation(line: 374, column: 10, scope: !5628)
!5646 = !DILocation(line: 376, column: 9, scope: !5647)
!5647 = distinct !DILexicalBlock(scope: !5628, file: !90, line: 376, column: 9)
!5648 = !DILocation(line: 376, column: 14, scope: !5647)
!5649 = !DILocation(line: 376, column: 9, scope: !5628)
!5650 = !DILocation(line: 378, column: 37, scope: !5651)
!5651 = distinct !DILexicalBlock(scope: !5647, file: !90, line: 377, column: 5)
!5652 = !DILocation(line: 378, column: 9, scope: !5651)
!5653 = !DILocation(line: 382, column: 12, scope: !5628)
!5654 = !DILocation(line: 382, column: 24, scope: !5628)
!5655 = !DILocation(line: 382, column: 31, scope: !5628)
!5656 = !DILocation(line: 383, column: 12, scope: !5628)
!5657 = !DILocation(line: 383, column: 24, scope: !5628)
!5658 = !DILocation(line: 383, column: 32, scope: !5628)
!5659 = !DILocation(line: 386, column: 12, scope: !5628)
!5660 = !DILocation(line: 386, column: 21, scope: !5628)
!5661 = !DILocation(line: 386, column: 28, scope: !5628)
!5662 = !DILocation(line: 387, column: 12, scope: !5628)
!5663 = !DILocation(line: 387, column: 21, scope: !5628)
!5664 = !DILocation(line: 387, column: 29, scope: !5628)
!5665 = !DILocation(line: 390, column: 12, scope: !5628)
!5666 = !DILocation(line: 390, column: 10, scope: !5628)
!5667 = !DILocation(line: 392, column: 9, scope: !5668)
!5668 = distinct !DILexicalBlock(scope: !5628, file: !90, line: 392, column: 9)
!5669 = !DILocation(line: 392, column: 14, scope: !5668)
!5670 = !DILocation(line: 392, column: 9, scope: !5628)
!5671 = !DILocation(line: 394, column: 37, scope: !5672)
!5672 = distinct !DILexicalBlock(scope: !5668, file: !90, line: 393, column: 5)
!5673 = !DILocation(line: 394, column: 9, scope: !5672)
!5674 = !DILocation(line: 397, column: 22, scope: !5628)
!5675 = !DILocation(line: 397, column: 20, scope: !5628)
!5676 = !DILocation(line: 398, column: 1, scope: !5628)
!5677 = distinct !DISubprogram(name: "vPortStartFirstTask", scope: !90, file: !90, line: 188, type: !5334, scopeLine: 189, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5678 = !DILocalVariable(name: "pxFirstThread", scope: !5677, file: !90, line: 190, type: !88)
!5679 = !DILocation(line: 190, column: 16, scope: !5677)
!5680 = !DILocation(line: 190, column: 54, scope: !5677)
!5681 = !DILocation(line: 190, column: 32, scope: !5677)
!5682 = !DILocation(line: 193, column: 22, scope: !5677)
!5683 = !DILocation(line: 193, column: 5, scope: !5677)
!5684 = !DILocation(line: 194, column: 1, scope: !5677)
!5685 = distinct !DISubprogram(name: "vPortCancelThread", scope: !90, file: !90, line: 453, type: !100, scopeLine: 454, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5686 = !DILocalVariable(name: "pxTaskToDelete", arg: 1, scope: !5685, file: !90, line: 453, type: !26)
!5687 = !DILocation(line: 453, column: 32, scope: !5685)
!5688 = !DILocalVariable(name: "pxThreadToCancel", scope: !5685, file: !90, line: 455, type: !88)
!5689 = !DILocation(line: 455, column: 16, scope: !5685)
!5690 = !DILocation(line: 455, column: 57, scope: !5685)
!5691 = !DILocation(line: 455, column: 35, scope: !5685)
!5692 = !DILocation(line: 460, column: 21, scope: !5685)
!5693 = !DILocation(line: 460, column: 39, scope: !5685)
!5694 = !DILocation(line: 460, column: 5, scope: !5685)
!5695 = !DILocation(line: 461, column: 19, scope: !5685)
!5696 = !DILocation(line: 461, column: 37, scope: !5685)
!5697 = !DILocation(line: 461, column: 5, scope: !5685)
!5698 = !DILocation(line: 462, column: 19, scope: !5685)
!5699 = !DILocation(line: 462, column: 37, scope: !5685)
!5700 = !DILocation(line: 462, column: 5, scope: !5685)
!5701 = !DILocation(line: 463, column: 1, scope: !5685)
!5702 = distinct !DISubprogram(name: "prvGetTimeNs", scope: !90, file: !90, line: 349, type: !5703, scopeLine: 350, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5703 = !DISubroutineType(types: !5704)
!5704 = !{!120}
!5705 = !DILocalVariable(name: "t", scope: !5702, file: !90, line: 351, type: !5706)
!5706 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timespec", file: !5707, line: 9, size: 128, elements: !5708)
!5707 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h", directory: "")
!5708 = !{!5709, !5710}
!5709 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !5706, file: !5707, line: 11, baseType: !5637, size: 64)
!5710 = !DIDerivedType(tag: DW_TAG_member, name: "tv_nsec", scope: !5706, file: !5707, line: 12, baseType: !5711, size: 64, offset: 64)
!5711 = !DIDerivedType(tag: DW_TAG_typedef, name: "__syscall_slong_t", file: !30, line: 184, baseType: !25)
!5712 = !DILocation(line: 351, column: 21, scope: !5702)
!5713 = !DILocation(line: 353, column: 5, scope: !5702)
!5714 = !DILocation(line: 355, column: 26, scope: !5702)
!5715 = !DILocation(line: 355, column: 33, scope: !5702)
!5716 = !DILocation(line: 355, column: 76, scope: !5702)
!5717 = !DILocation(line: 355, column: 60, scope: !5702)
!5718 = !DILocation(line: 355, column: 5, scope: !5702)
!5719 = distinct !DISubprogram(name: "vPortEndScheduler", scope: !90, file: !90, line: 246, type: !5334, scopeLine: 247, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5720 = !DILocalVariable(name: "itimer", scope: !5719, file: !90, line: 248, type: !5630)
!5721 = !DILocation(line: 248, column: 22, scope: !5719)
!5722 = !DILocalVariable(name: "sigtick", scope: !5719, file: !90, line: 249, type: !5337)
!5723 = !DILocation(line: 249, column: 22, scope: !5719)
!5724 = !DILocalVariable(name: "xCurrentThread", scope: !5719, file: !90, line: 250, type: !88)
!5725 = !DILocation(line: 250, column: 16, scope: !5719)
!5726 = !DILocation(line: 254, column: 12, scope: !5719)
!5727 = !DILocation(line: 254, column: 21, scope: !5719)
!5728 = !DILocation(line: 254, column: 28, scope: !5719)
!5729 = !DILocation(line: 255, column: 12, scope: !5719)
!5730 = !DILocation(line: 255, column: 21, scope: !5719)
!5731 = !DILocation(line: 255, column: 29, scope: !5719)
!5732 = !DILocation(line: 257, column: 12, scope: !5719)
!5733 = !DILocation(line: 257, column: 24, scope: !5719)
!5734 = !DILocation(line: 257, column: 31, scope: !5719)
!5735 = !DILocation(line: 258, column: 12, scope: !5719)
!5736 = !DILocation(line: 258, column: 24, scope: !5719)
!5737 = !DILocation(line: 258, column: 32, scope: !5719)
!5738 = !DILocation(line: 259, column: 14, scope: !5719)
!5739 = !DILocation(line: 261, column: 13, scope: !5719)
!5740 = !DILocation(line: 261, column: 22, scope: !5719)
!5741 = !DILocation(line: 262, column: 13, scope: !5719)
!5742 = !DILocation(line: 262, column: 24, scope: !5719)
!5743 = !DILocation(line: 263, column: 27, scope: !5719)
!5744 = !DILocation(line: 263, column: 5, scope: !5719)
!5745 = !DILocation(line: 264, column: 5, scope: !5719)
!5746 = !DILocation(line: 267, column: 19, scope: !5719)
!5747 = !DILocation(line: 268, column: 28, scope: !5719)
!5748 = !DILocation(line: 268, column: 14, scope: !5719)
!5749 = !DILocation(line: 270, column: 44, scope: !5719)
!5750 = !DILocation(line: 270, column: 22, scope: !5719)
!5751 = !DILocation(line: 270, column: 20, scope: !5719)
!5752 = !DILocation(line: 271, column: 21, scope: !5719)
!5753 = !DILocation(line: 271, column: 5, scope: !5719)
!5754 = !DILocation(line: 272, column: 1, scope: !5719)
!5755 = distinct !DISubprogram(name: "vPortYield", scope: !90, file: !90, line: 313, type: !5334, scopeLine: 314, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5756 = !DILocation(line: 315, column: 5, scope: !5755)
!5757 = !DILocation(line: 317, column: 5, scope: !5755)
!5758 = !DILocation(line: 319, column: 5, scope: !5755)
!5759 = !DILocation(line: 320, column: 1, scope: !5755)
!5760 = distinct !DISubprogram(name: "prvPortYieldFromISR", scope: !90, file: !90, line: 298, type: !5334, scopeLine: 299, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5761 = !DILocalVariable(name: "xThreadToSuspend", scope: !5760, file: !90, line: 300, type: !88)
!5762 = !DILocation(line: 300, column: 16, scope: !5760)
!5763 = !DILocalVariable(name: "xThreadToResume", scope: !5760, file: !90, line: 301, type: !88)
!5764 = !DILocation(line: 301, column: 16, scope: !5760)
!5765 = !DILocation(line: 303, column: 46, scope: !5760)
!5766 = !DILocation(line: 303, column: 24, scope: !5760)
!5767 = !DILocation(line: 303, column: 22, scope: !5760)
!5768 = !DILocation(line: 305, column: 5, scope: !5760)
!5769 = !DILocation(line: 307, column: 45, scope: !5760)
!5770 = !DILocation(line: 307, column: 23, scope: !5760)
!5771 = !DILocation(line: 307, column: 21, scope: !5760)
!5772 = !DILocation(line: 309, column: 22, scope: !5760)
!5773 = !DILocation(line: 309, column: 39, scope: !5760)
!5774 = !DILocation(line: 309, column: 5, scope: !5760)
!5775 = !DILocation(line: 310, column: 1, scope: !5760)
!5776 = distinct !DISubprogram(name: "xPortSetInterruptMask", scope: !90, file: !90, line: 335, type: !523, scopeLine: 336, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5777 = !DILocation(line: 339, column: 5, scope: !5776)
!5778 = distinct !DISubprogram(name: "vPortClearInterruptMask", scope: !90, file: !90, line: 343, type: !5779, scopeLine: 344, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5779 = !DISubroutineType(types: !5780)
!5780 = !{null, !39}
!5781 = !DILocalVariable(name: "uxMask", arg: 1, scope: !5778, file: !90, line: 343, type: !39)
!5782 = !DILocation(line: 343, column: 43, scope: !5778)
!5783 = !DILocation(line: 345, column: 14, scope: !5778)
!5784 = !DILocation(line: 346, column: 1, scope: !5778)
!5785 = distinct !DISubprogram(name: "vPortThreadDying", scope: !90, file: !90, line: 443, type: !5786, scopeLine: 445, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5786 = !DISubroutineType(types: !5787)
!5787 = !{null, !26, !5788}
!5788 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5789, size: 64)
!5789 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !23)
!5790 = !DILocalVariable(name: "pxTaskToDelete", arg: 1, scope: !5785, file: !90, line: 443, type: !26)
!5791 = !DILocation(line: 443, column: 31, scope: !5785)
!5792 = !DILocalVariable(name: "pxPendYield", arg: 2, scope: !5785, file: !90, line: 444, type: !5788)
!5793 = !DILocation(line: 444, column: 46, scope: !5785)
!5794 = !DILocalVariable(name: "pxThread", scope: !5785, file: !90, line: 446, type: !88)
!5795 = !DILocation(line: 446, column: 16, scope: !5785)
!5796 = !DILocation(line: 446, column: 49, scope: !5785)
!5797 = !DILocation(line: 446, column: 27, scope: !5785)
!5798 = !DILocation(line: 448, column: 14, scope: !5785)
!5799 = !DILocation(line: 450, column: 5, scope: !5785)
!5800 = !DILocation(line: 450, column: 15, scope: !5785)
!5801 = !DILocation(line: 450, column: 22, scope: !5785)
!5802 = !DILocation(line: 451, column: 1, scope: !5785)
!5803 = distinct !DISubprogram(name: "ulPortGetRunTime", scope: !90, file: !90, line: 587, type: !5804, scopeLine: 588, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !78, retainedNodes: !151)
!5804 = !DISubroutineType(types: !5805)
!5805 = !{!40}
!5806 = !DILocalVariable(name: "xTimes", scope: !5803, file: !90, line: 589, type: !5807)
!5807 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tms", file: !5808, line: 32, size: 256, elements: !5809)
!5808 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/sys/times.h", directory: "")
!5809 = !{!5810, !5813, !5814, !5815}
!5810 = !DIDerivedType(tag: DW_TAG_member, name: "tms_utime", scope: !5807, file: !5808, line: 34, baseType: !5811, size: 64)
!5811 = !DIDerivedType(tag: DW_TAG_typedef, name: "clock_t", file: !5812, line: 7, baseType: !5396)
!5812 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/clock_t.h", directory: "")
!5813 = !DIDerivedType(tag: DW_TAG_member, name: "tms_stime", scope: !5807, file: !5808, line: 35, baseType: !5811, size: 64, offset: 64)
!5814 = !DIDerivedType(tag: DW_TAG_member, name: "tms_cutime", scope: !5807, file: !5808, line: 37, baseType: !5811, size: 64, offset: 128)
!5815 = !DIDerivedType(tag: DW_TAG_member, name: "tms_cstime", scope: !5807, file: !5808, line: 38, baseType: !5811, size: 64, offset: 192)
!5816 = !DILocation(line: 589, column: 16, scope: !5803)
!5817 = !DILocation(line: 591, column: 5, scope: !5803)
!5818 = !DILocation(line: 593, column: 37, scope: !5803)
!5819 = !DILocation(line: 593, column: 5, scope: !5803)
!5820 = distinct !DISubprogram(name: "main", scope: !150, file: !150, line: 16, type: !5821, scopeLine: 17, spFlags: DISPFlagDefinition, unit: !149, retainedNodes: !151)
!5821 = !DISubroutineType(types: !5822)
!5822 = !{!31}
!5823 = !DILocation(line: 18, column: 10, scope: !5820)
!5824 = !DILocalVariable(name: "xTaskToResume", scope: !5820, file: !150, line: 19, type: !32)
!5825 = !DILocation(line: 19, column: 14, scope: !5820)
!5826 = !DILocation(line: 20, column: 33, scope: !5820)
!5827 = !DILocation(line: 20, column: 1, scope: !5820)
!5828 = !DILocation(line: 21, column: 4, scope: !5829)
!5829 = distinct !DILexicalBlock(scope: !5820, file: !150, line: 21, column: 4)
!5830 = !DILocation(line: 21, column: 18, scope: !5829)
!5831 = !DILocation(line: 21, column: 4, scope: !5820)
!5832 = !DILocation(line: 21, column: 27, scope: !5829)
!5833 = !DILocation(line: 22, column: 22, scope: !5820)
!5834 = !DILocation(line: 22, column: 1, scope: !5820)
!5835 = !DILocation(line: 23, column: 1, scope: !5820)
!5836 = !DILocation(line: 24, column: 1, scope: !5820)
!5837 = distinct !DISubprogram(name: "vTaskFunction1", scope: !150, file: !150, line: 25, type: !100, scopeLine: 26, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !149, retainedNodes: !151)
!5838 = !DILocalVariable(name: "pvParameters", arg: 1, scope: !5837, file: !150, line: 25, type: !26)
!5839 = !DILocation(line: 25, column: 28, scope: !5837)
!5840 = !DILocation(line: 27, column: 5, scope: !5837)
!5841 = !DILocation(line: 28, column: 1, scope: !5837)
!5842 = distinct !DISubprogram(name: "vTaskSuspend", scope: !150, file: !150, line: 30, type: !438, scopeLine: 30, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !149, retainedNodes: !151)
!5843 = !DILocalVariable(name: "xTaskToResume", arg: 1, scope: !5842, file: !150, line: 30, type: !32)
!5844 = !DILocation(line: 30, column: 32, scope: !5842)
!5845 = !DILocation(line: 31, column: 33, scope: !5842)
!5846 = !DILocation(line: 31, column: 5, scope: !5842)
!5847 = !DILocation(line: 32, column: 1, scope: !5842)
!5848 = distinct !DISubprogram(name: "portIS_TASK_PRIVILEGED", scope: !150, file: !150, line: 34, type: !5334, scopeLine: 34, spFlags: DISPFlagDefinition, unit: !149, retainedNodes: !151)
!5849 = !DILocation(line: 35, column: 14, scope: !5848)
!5850 = !DILocation(line: 36, column: 1, scope: !5848)
