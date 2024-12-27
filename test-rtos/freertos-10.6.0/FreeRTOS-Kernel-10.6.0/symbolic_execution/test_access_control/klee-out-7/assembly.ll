; ModuleID = 'test.test.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.KernelObject = type { %struct.OpaqueObject*, i32, i8* }
%struct.OpaqueObject = type opaque
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

@.str = private unnamed_addr constant [68 x i8] c"/home/klee/FreeRTOS-Kernel-10.6.0/portable/Common/mpu_wrappers_v2.c\00", align 1
@xKernelObjectPool = internal global [256 x %struct.KernelObject] zeroinitializer, section "privileged_data", align 16, !dbg !0
@isTested = dso_local global i8 0, align 1, !dbg !76
@.str.1 = private unnamed_addr constant [14 x i8] c"xTaskToResume\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskDelayUntilImpl(i64* %pxPreviousWakeTime, i64 %xTimeIncrement) #0 section "privileged_functions" !dbg !88 {
entry:
  %pxPreviousWakeTime.addr = alloca i64*, align 8
  %xTimeIncrement.addr = alloca i64, align 8
  %xReturn = alloca i64, align 8
  %xIsPreviousWakeTimeAccessible = alloca i64, align 8
  store i64* %pxPreviousWakeTime, i64** %pxPreviousWakeTime.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxPreviousWakeTime.addr, metadata !94, metadata !DIExpression()), !dbg !95
  store i64 %xTimeIncrement, i64* %xTimeIncrement.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTimeIncrement.addr, metadata !96, metadata !DIExpression()), !dbg !97
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !98, metadata !DIExpression()), !dbg !99
  store i64 0, i64* %xReturn, align 8, !dbg !99
  call void @llvm.dbg.declare(metadata i64* %xIsPreviousWakeTimeAccessible, metadata !100, metadata !DIExpression()), !dbg !101
  store i64 0, i64* %xIsPreviousWakeTimeAccessible, align 8, !dbg !101
  %0 = load i64*, i64** %pxPreviousWakeTime.addr, align 8, !dbg !102
  %1 = bitcast i64* %0 to i8*, !dbg !102
  %call = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %1, i32 8, i32 3), !dbg !103
  store i64 %call, i64* %xIsPreviousWakeTimeAccessible, align 8, !dbg !104
  %2 = load i64, i64* %xIsPreviousWakeTimeAccessible, align 8, !dbg !105
  %cmp = icmp eq i64 %2, 1, !dbg !107
  br i1 %cmp, label %if.then, label %if.end, !dbg !108

if.then:                                          ; preds = %entry
  %3 = load i64*, i64** %pxPreviousWakeTime.addr, align 8, !dbg !109
  %4 = load i64, i64* %xTimeIncrement.addr, align 8, !dbg !111
  %call1 = call i64 @xTaskDelayUntil(i64* %3, i64 %4), !dbg !112
  store i64 %call1, i64* %xReturn, align 8, !dbg !113
  br label %if.end, !dbg !114

if.end:                                           ; preds = %if.then, %entry
  %5 = load i64, i64* %xReturn, align 8, !dbg !115
  ret i64 %5, !dbg !116
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i64 @xPortIsAuthorizedToAccessBuffer(i8*, i32, i32) #2 section "privileged_functions"

declare dso_local i64 @xTaskDelayUntil(i64*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskAbortDelayImpl(%struct.tskTaskControlBlock* %xTask) #0 section "privileged_functions" !dbg !117 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %xReturn = alloca i64, align 8
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !120, metadata !DIExpression()), !dbg !121
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !122, metadata !DIExpression()), !dbg !123
  store i64 0, i64* %xReturn, align 8, !dbg !123
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !124, metadata !DIExpression()), !dbg !125
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !125
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !126, metadata !DIExpression()), !dbg !127
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !128
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !130
  br i1 %cmp, label %if.then, label %if.else, !dbg !131

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !132
  %call = call i64 @xTaskAbortDelay(%struct.tskTaskControlBlock* %1), !dbg !134
  store i64 %call, i64* %xReturn, align 8, !dbg !135
  br label %if.end12, !dbg !136

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !137
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !139
  store i32 %3, i32* %lIndex, align 4, !dbg !140
  %4 = load i32, i32* %lIndex, align 4, !dbg !141
  %cmp1 = icmp sge i32 %4, 1, !dbg !141
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !141

land.rhs:                                         ; preds = %if.else
  %5 = load i32, i32* %lIndex, align 4, !dbg !141
  %cmp2 = icmp slt i32 %5, 257, !dbg !141
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %6 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !143
  %land.ext = zext i1 %6 to i32, !dbg !141
  %conv = sext i32 %land.ext to i64, !dbg !141
  %cmp3 = icmp ne i64 %conv, 0, !dbg !144
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !145

if.then5:                                         ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !146
  %sub = sub nsw i32 %7, 1, !dbg !146
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !146
  %8 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !146
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !148
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !149
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !151
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !152

if.then9:                                         ; preds = %if.then5
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !153
  %call10 = call i64 @xTaskAbortDelay(%struct.tskTaskControlBlock* %10), !dbg !155
  store i64 %call10, i64* %xReturn, align 8, !dbg !156
  br label %if.end, !dbg !157

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !158

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %11 = load i64, i64* %xReturn, align 8, !dbg !159
  ret i64 %11, !dbg !160
}

declare dso_local i64 @xTaskAbortDelay(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define internal %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %lIndex, i32 %ulKernelObjectType) #0 section "privileged_functions" !dbg !161 {
entry:
  %lIndex.addr = alloca i32, align 4
  %ulKernelObjectType.addr = alloca i32, align 4
  store i32 %lIndex, i32* %lIndex.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %lIndex.addr, metadata !164, metadata !DIExpression()), !dbg !165
  store i32 %ulKernelObjectType, i32* %ulKernelObjectType.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %ulKernelObjectType.addr, metadata !166, metadata !DIExpression()), !dbg !167
  %0 = load i32, i32* %lIndex.addr, align 4, !dbg !168
  %cmp = icmp sge i32 %0, 0, !dbg !168
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !168

land.rhs:                                         ; preds = %entry
  %1 = load i32, i32* %lIndex.addr, align 4, !dbg !168
  %cmp1 = icmp slt i32 %1, 256, !dbg !168
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %2 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !170
  %land.ext = zext i1 %2 to i32, !dbg !168
  %conv = sext i32 %land.ext to i64, !dbg !168
  %cmp2 = icmp ne i64 %conv, 0, !dbg !168
  %conv3 = zext i1 %cmp2 to i32, !dbg !168
  %cmp4 = icmp eq i32 %conv3, 0, !dbg !168
  br i1 %cmp4, label %if.then, label %if.end, !dbg !171

if.then:                                          ; preds = %land.end
  call void @vAssertCalled(i8* getelementptr inbounds ([68 x i8], [68 x i8]* @.str, i64 0, i64 0), i64 317), !dbg !168
  br label %if.end, !dbg !168

if.end:                                           ; preds = %if.then, %land.end
  %3 = load i32, i32* %lIndex.addr, align 4, !dbg !172
  %idxprom = sext i32 %3 to i64, !dbg !172
  %arrayidx = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom, !dbg !172
  %ulKernelObjectType6 = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx, i32 0, i32 1, !dbg !172
  %4 = load i32, i32* %ulKernelObjectType6, align 8, !dbg !172
  %5 = load i32, i32* %ulKernelObjectType.addr, align 4, !dbg !172
  %cmp7 = icmp eq i32 %4, %5, !dbg !172
  %conv8 = zext i1 %cmp7 to i32, !dbg !172
  %cmp9 = icmp eq i32 %conv8, 0, !dbg !172
  br i1 %cmp9, label %if.then11, label %if.end12, !dbg !174

if.then11:                                        ; preds = %if.end
  call void @vAssertCalled(i8* getelementptr inbounds ([68 x i8], [68 x i8]* @.str, i64 0, i64 0), i64 318), !dbg !172
  br label %if.end12, !dbg !172

if.end12:                                         ; preds = %if.then11, %if.end
  %6 = load i32, i32* %lIndex.addr, align 4, !dbg !175
  %idxprom13 = sext i32 %6 to i64, !dbg !176
  %arrayidx14 = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom13, !dbg !176
  %xInternalObjectHandle = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx14, i32 0, i32 0, !dbg !177
  %7 = load %struct.OpaqueObject*, %struct.OpaqueObject** %xInternalObjectHandle, align 8, !dbg !177
  ret %struct.OpaqueObject* %7, !dbg !178
}

declare dso_local void @vAssertCalled(i8*, i64) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTaskDelayImpl(i64 %xTicksToDelay) #0 section "privileged_functions" !dbg !179 {
entry:
  %xTicksToDelay.addr = alloca i64, align 8
  store i64 %xTicksToDelay, i64* %xTicksToDelay.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToDelay.addr, metadata !182, metadata !DIExpression()), !dbg !183
  %0 = load i64, i64* %xTicksToDelay.addr, align 8, !dbg !184
  call void @vTaskDelay(i64 %0), !dbg !185
  ret void, !dbg !186
}

declare dso_local void @vTaskDelay(i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_uxTaskPriorityGetImpl(%struct.tskTaskControlBlock* %pxTask) #0 section "privileged_functions" !dbg !187 {
entry:
  %pxTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %uxReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %pxTask, %struct.tskTaskControlBlock** %pxTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %pxTask.addr, metadata !191, metadata !DIExpression()), !dbg !192
  call void @llvm.dbg.declare(metadata i64* %uxReturn, metadata !193, metadata !DIExpression()), !dbg !194
  store i64 5, i64* %uxReturn, align 8, !dbg !194
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !195, metadata !DIExpression()), !dbg !196
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !197, metadata !DIExpression()), !dbg !198
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !198
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTask.addr, align 8, !dbg !199
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !201
  br i1 %cmp, label %if.then, label %if.else, !dbg !202

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTask.addr, align 8, !dbg !203
  %call = call i64 @uxTaskPriorityGet(%struct.tskTaskControlBlock* %1), !dbg !205
  store i64 %call, i64* %uxReturn, align 8, !dbg !206
  br label %if.end12, !dbg !207

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTask.addr, align 8, !dbg !208
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !210
  store i32 %3, i32* %lIndex, align 4, !dbg !211
  %4 = load i32, i32* %lIndex, align 4, !dbg !212
  %cmp1 = icmp sge i32 %4, 1, !dbg !212
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !212

land.rhs:                                         ; preds = %if.else
  %5 = load i32, i32* %lIndex, align 4, !dbg !212
  %cmp2 = icmp slt i32 %5, 257, !dbg !212
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %6 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !214
  %land.ext = zext i1 %6 to i32, !dbg !212
  %conv = sext i32 %land.ext to i64, !dbg !212
  %cmp3 = icmp ne i64 %conv, 0, !dbg !215
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !216

if.then5:                                         ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !217
  %sub = sub nsw i32 %7, 1, !dbg !217
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !217
  %8 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !217
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !219
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !220
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !222
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !223

if.then9:                                         ; preds = %if.then5
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !224
  %call10 = call i64 @uxTaskPriorityGet(%struct.tskTaskControlBlock* %10), !dbg !226
  store i64 %call10, i64* %uxReturn, align 8, !dbg !227
  br label %if.end, !dbg !228

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !229

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %11 = load i64, i64* %uxReturn, align 8, !dbg !230
  ret i64 %11, !dbg !231
}

declare dso_local i64 @uxTaskPriorityGet(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MPU_eTaskGetStateImpl(%struct.tskTaskControlBlock* %pxTask) #0 section "privileged_functions" !dbg !232 {
entry:
  %pxTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %eReturn = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tskTaskControlBlock* %pxTask, %struct.tskTaskControlBlock** %pxTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %pxTask.addr, metadata !236, metadata !DIExpression()), !dbg !237
  call void @llvm.dbg.declare(metadata i32* %eReturn, metadata !238, metadata !DIExpression()), !dbg !239
  store i32 5, i32* %eReturn, align 4, !dbg !239
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !240, metadata !DIExpression()), !dbg !241
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !241
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !242, metadata !DIExpression()), !dbg !243
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTask.addr, align 8, !dbg !244
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !246
  br i1 %cmp, label %if.then, label %if.else, !dbg !247

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTask.addr, align 8, !dbg !248
  %call = call i32 @eTaskGetState(%struct.tskTaskControlBlock* %1), !dbg !250
  store i32 %call, i32* %eReturn, align 4, !dbg !251
  br label %if.end12, !dbg !252

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTask.addr, align 8, !dbg !253
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !255
  store i32 %3, i32* %lIndex, align 4, !dbg !256
  %4 = load i32, i32* %lIndex, align 4, !dbg !257
  %cmp1 = icmp sge i32 %4, 1, !dbg !257
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !257

land.rhs:                                         ; preds = %if.else
  %5 = load i32, i32* %lIndex, align 4, !dbg !257
  %cmp2 = icmp slt i32 %5, 257, !dbg !257
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %6 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !259
  %land.ext = zext i1 %6 to i32, !dbg !257
  %conv = sext i32 %land.ext to i64, !dbg !257
  %cmp3 = icmp ne i64 %conv, 0, !dbg !260
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !261

if.then5:                                         ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !262
  %sub = sub nsw i32 %7, 1, !dbg !262
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !262
  %8 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !262
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !264
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !265
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !267
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !268

if.then9:                                         ; preds = %if.then5
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !269
  %call10 = call i32 @eTaskGetState(%struct.tskTaskControlBlock* %10), !dbg !271
  store i32 %call10, i32* %eReturn, align 4, !dbg !272
  br label %if.end, !dbg !273

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !274

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %11 = load i32, i32* %eReturn, align 4, !dbg !275
  ret i32 %11, !dbg !276
}

declare dso_local i32 @eTaskGetState(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTaskGetInfoImpl(%struct.tskTaskControlBlock* %xTask, %struct.xTASK_STATUS* %pxTaskStatus, i64 %xGetFreeStackSpace, i32 %eState) #0 section "privileged_functions" !dbg !277 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %pxTaskStatus.addr = alloca %struct.xTASK_STATUS*, align 8
  %xGetFreeStackSpace.addr = alloca i64, align 8
  %eState.addr = alloca i32, align 4
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %xIsTaskStatusWriteable = alloca i64, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !301, metadata !DIExpression()), !dbg !302
  store %struct.xTASK_STATUS* %pxTaskStatus, %struct.xTASK_STATUS** %pxTaskStatus.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xTASK_STATUS** %pxTaskStatus.addr, metadata !303, metadata !DIExpression()), !dbg !304
  store i64 %xGetFreeStackSpace, i64* %xGetFreeStackSpace.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xGetFreeStackSpace.addr, metadata !305, metadata !DIExpression()), !dbg !306
  store i32 %eState, i32* %eState.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %eState.addr, metadata !307, metadata !DIExpression()), !dbg !308
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !309, metadata !DIExpression()), !dbg !310
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !311, metadata !DIExpression()), !dbg !312
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !312
  call void @llvm.dbg.declare(metadata i64* %xIsTaskStatusWriteable, metadata !313, metadata !DIExpression()), !dbg !314
  store i64 0, i64* %xIsTaskStatusWriteable, align 8, !dbg !314
  %0 = load %struct.xTASK_STATUS*, %struct.xTASK_STATUS** %pxTaskStatus.addr, align 8, !dbg !315
  %1 = bitcast %struct.xTASK_STATUS* %0 to i8*, !dbg !315
  %call = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %1, i32 72, i32 2), !dbg !316
  store i64 %call, i64* %xIsTaskStatusWriteable, align 8, !dbg !317
  %2 = load i64, i64* %xIsTaskStatusWriteable, align 8, !dbg !318
  %cmp = icmp eq i64 %2, 1, !dbg !320
  br i1 %cmp, label %if.then, label %if.end14, !dbg !321

if.then:                                          ; preds = %entry
  %3 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !322
  %cmp1 = icmp eq %struct.tskTaskControlBlock* %3, null, !dbg !325
  br i1 %cmp1, label %if.then2, label %if.else, !dbg !326

if.then2:                                         ; preds = %if.then
  %4 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !327
  %5 = load %struct.xTASK_STATUS*, %struct.xTASK_STATUS** %pxTaskStatus.addr, align 8, !dbg !329
  %6 = load i64, i64* %xGetFreeStackSpace.addr, align 8, !dbg !330
  %7 = load i32, i32* %eState.addr, align 4, !dbg !331
  call void @vTaskGetInfo(%struct.tskTaskControlBlock* %4, %struct.xTASK_STATUS* %5, i64 %6, i32 %7), !dbg !332
  br label %if.end13, !dbg !333

if.else:                                          ; preds = %if.then
  %8 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !334
  %9 = ptrtoint %struct.tskTaskControlBlock* %8 to i32, !dbg !336
  store i32 %9, i32* %lIndex, align 4, !dbg !337
  %10 = load i32, i32* %lIndex, align 4, !dbg !338
  %cmp3 = icmp sge i32 %10, 1, !dbg !338
  br i1 %cmp3, label %land.rhs, label %land.end, !dbg !338

land.rhs:                                         ; preds = %if.else
  %11 = load i32, i32* %lIndex, align 4, !dbg !338
  %cmp4 = icmp slt i32 %11, 257, !dbg !338
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %12 = phi i1 [ false, %if.else ], [ %cmp4, %land.rhs ], !dbg !340
  %land.ext = zext i1 %12 to i32, !dbg !338
  %conv = sext i32 %land.ext to i64, !dbg !338
  %cmp5 = icmp ne i64 %conv, 0, !dbg !341
  br i1 %cmp5, label %if.then7, label %if.end12, !dbg !342

if.then7:                                         ; preds = %land.end
  %13 = load i32, i32* %lIndex, align 4, !dbg !343
  %sub = sub nsw i32 %13, 1, !dbg !343
  %call8 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !343
  %14 = bitcast %struct.OpaqueObject* %call8 to %struct.tskTaskControlBlock*, !dbg !343
  store %struct.tskTaskControlBlock* %14, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !345
  %15 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !346
  %cmp9 = icmp ne %struct.tskTaskControlBlock* %15, null, !dbg !348
  br i1 %cmp9, label %if.then11, label %if.end, !dbg !349

if.then11:                                        ; preds = %if.then7
  %16 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !350
  %17 = load %struct.xTASK_STATUS*, %struct.xTASK_STATUS** %pxTaskStatus.addr, align 8, !dbg !352
  %18 = load i64, i64* %xGetFreeStackSpace.addr, align 8, !dbg !353
  %19 = load i32, i32* %eState.addr, align 4, !dbg !354
  call void @vTaskGetInfo(%struct.tskTaskControlBlock* %16, %struct.xTASK_STATUS* %17, i64 %18, i32 %19), !dbg !355
  br label %if.end, !dbg !356

if.end:                                           ; preds = %if.then11, %if.then7
  br label %if.end12, !dbg !357

if.end12:                                         ; preds = %if.end, %land.end
  br label %if.end13

if.end13:                                         ; preds = %if.end12, %if.then2
  br label %if.end14, !dbg !358

if.end14:                                         ; preds = %if.end13, %entry
  ret void, !dbg !359
}

declare dso_local void @vTaskGetInfo(%struct.tskTaskControlBlock*, %struct.xTASK_STATUS*, i64, i32) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.tskTaskControlBlock* @MPU_xTaskGetIdleTaskHandleImpl() #0 section "privileged_functions" !dbg !360 {
entry:
  %xIdleTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xIdleTaskHandle, metadata !363, metadata !DIExpression()), !dbg !364
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xIdleTaskHandle, align 8, !dbg !364
  %call = call %struct.tskTaskControlBlock* @xTaskGetIdleTaskHandle(), !dbg !365
  store %struct.tskTaskControlBlock* %call, %struct.tskTaskControlBlock** %xIdleTaskHandle, align 8, !dbg !366
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xIdleTaskHandle, align 8, !dbg !367
  ret %struct.tskTaskControlBlock* %0, !dbg !368
}

declare dso_local %struct.tskTaskControlBlock* @xTaskGetIdleTaskHandle() #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTaskSuspendImpl(%struct.tskTaskControlBlock* %pxTaskToSuspend) #0 section "privileged_functions" !dbg !369 {
entry:
  %pxTaskToSuspend.addr = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %pxTaskToSuspend, %struct.tskTaskControlBlock** %pxTaskToSuspend.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %pxTaskToSuspend.addr, metadata !372, metadata !DIExpression()), !dbg !373
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !374, metadata !DIExpression()), !dbg !375
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !376, metadata !DIExpression()), !dbg !377
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !377
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTaskToSuspend.addr, align 8, !dbg !378
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !380
  br i1 %cmp, label %if.then, label %if.else, !dbg !381

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTaskToSuspend.addr, align 8, !dbg !382
  call void @vTaskSuspend(%struct.tskTaskControlBlock* %1), !dbg !384
  br label %if.end20, !dbg !385

if.else:                                          ; preds = %entry
  %call = call i64 @xTaskGetSchedulerState(), !dbg !386
  %cmp1 = icmp eq i64 %call, 1, !dbg !389
  br i1 %cmp1, label %if.then5, label %lor.lhs.false, !dbg !390

lor.lhs.false:                                    ; preds = %if.else
  %call2 = call i32 (...) bitcast (void ()* @portIS_TASK_PRIVILEGED to i32 (...)*)(), !dbg !391
  %conv = sext i32 %call2 to i64, !dbg !391
  %cmp3 = icmp eq i64 %conv, 1, !dbg !392
  br i1 %cmp3, label %if.then5, label %if.end19, !dbg !393

if.then5:                                         ; preds = %lor.lhs.false, %if.else
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTaskToSuspend.addr, align 8, !dbg !394
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !396
  store i32 %3, i32* %lIndex, align 4, !dbg !397
  %4 = load i32, i32* %lIndex, align 4, !dbg !398
  %cmp6 = icmp sge i32 %4, 1, !dbg !398
  br i1 %cmp6, label %land.rhs, label %land.end, !dbg !398

land.rhs:                                         ; preds = %if.then5
  %5 = load i32, i32* %lIndex, align 4, !dbg !398
  %cmp8 = icmp slt i32 %5, 257, !dbg !398
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.then5
  %6 = phi i1 [ false, %if.then5 ], [ %cmp8, %land.rhs ], !dbg !400
  %land.ext = zext i1 %6 to i32, !dbg !398
  %conv10 = sext i32 %land.ext to i64, !dbg !398
  %cmp11 = icmp ne i64 %conv10, 0, !dbg !401
  br i1 %cmp11, label %if.then13, label %if.end18, !dbg !402

if.then13:                                        ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !403
  %sub = sub nsw i32 %7, 1, !dbg !403
  %call14 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !403
  %8 = bitcast %struct.OpaqueObject* %call14 to %struct.tskTaskControlBlock*, !dbg !403
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !405
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !406
  %cmp15 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !408
  br i1 %cmp15, label %if.then17, label %if.end, !dbg !409

if.then17:                                        ; preds = %if.then13
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !410
  call void @vTaskSuspend(%struct.tskTaskControlBlock* %10), !dbg !412
  br label %if.end, !dbg !413

if.end:                                           ; preds = %if.then17, %if.then13
  br label %if.end18, !dbg !414

if.end18:                                         ; preds = %if.end, %land.end
  br label %if.end19, !dbg !415

if.end19:                                         ; preds = %if.end18, %lor.lhs.false
  br label %if.end20

if.end20:                                         ; preds = %if.end19, %if.then
  ret void, !dbg !416
}

declare dso_local i64 @xTaskGetSchedulerState() #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTaskResumeImpl(%struct.tskTaskControlBlock* %pxTaskToResume) #0 section "privileged_functions" !dbg !417 {
entry:
  %pxTaskToResume.addr = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %pxTaskToResume, %struct.tskTaskControlBlock** %pxTaskToResume.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %pxTaskToResume.addr, metadata !418, metadata !DIExpression()), !dbg !419
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !420, metadata !DIExpression()), !dbg !421
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !422, metadata !DIExpression()), !dbg !423
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !423
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTaskToResume.addr, align 8, !dbg !424
  %1 = ptrtoint %struct.tskTaskControlBlock* %0 to i32, !dbg !425
  store i32 %1, i32* %lIndex, align 4, !dbg !426
  %2 = load i32, i32* %lIndex, align 4, !dbg !427
  %cmp = icmp sge i32 %2, 1, !dbg !427
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !427

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !427
  %cmp1 = icmp slt i32 %3, 257, !dbg !427
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !429
  %land.ext = zext i1 %4 to i32, !dbg !427
  %conv = sext i32 %land.ext to i64, !dbg !427
  %cmp2 = icmp ne i64 %conv, 0, !dbg !430
  br i1 %cmp2, label %if.then, label %if.end7, !dbg !431

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !432
  %sub = sub nsw i32 %5, 1, !dbg !432
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !432
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tskTaskControlBlock*, !dbg !432
  store %struct.tskTaskControlBlock* %6, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !434
  %7 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !435
  %cmp4 = icmp ne %struct.tskTaskControlBlock* %7, null, !dbg !437
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !438

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !439
  call void @vTaskResume(%struct.tskTaskControlBlock* %8), !dbg !441
  br label %if.end, !dbg !442

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end7, !dbg !443

if.end7:                                          ; preds = %if.end, %land.end
  ret void, !dbg !444
}

declare dso_local void @vTaskResume(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskGetTickCountImpl() #0 section "privileged_functions" !dbg !445 {
entry:
  %xReturn = alloca i64, align 8
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !448, metadata !DIExpression()), !dbg !449
  %call = call i64 @xTaskGetTickCount(), !dbg !450
  store i64 %call, i64* %xReturn, align 8, !dbg !451
  %0 = load i64, i64* %xReturn, align 8, !dbg !452
  ret i64 %0, !dbg !453
}

declare dso_local i64 @xTaskGetTickCount() #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_uxTaskGetNumberOfTasksImpl() #0 section "privileged_functions" !dbg !454 {
entry:
  %uxReturn = alloca i64, align 8
  call void @llvm.dbg.declare(metadata i64* %uxReturn, metadata !457, metadata !DIExpression()), !dbg !458
  %call = call i64 @uxTaskGetNumberOfTasks(), !dbg !459
  store i64 %call, i64* %uxReturn, align 8, !dbg !460
  %0 = load i64, i64* %uxReturn, align 8, !dbg !461
  ret i64 %0, !dbg !462
}

declare dso_local i64 @uxTaskGetNumberOfTasks() #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @MPU_pcTaskGetNameImpl(%struct.tskTaskControlBlock* %xTaskToQuery) #0 section "privileged_functions" !dbg !463 {
entry:
  %xTaskToQuery.addr = alloca %struct.tskTaskControlBlock*, align 8
  %pcReturn = alloca i8*, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTaskToQuery, %struct.tskTaskControlBlock** %xTaskToQuery.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTaskToQuery.addr, metadata !467, metadata !DIExpression()), !dbg !468
  call void @llvm.dbg.declare(metadata i8** %pcReturn, metadata !469, metadata !DIExpression()), !dbg !470
  store i8* null, i8** %pcReturn, align 8, !dbg !470
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !471, metadata !DIExpression()), !dbg !472
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !473, metadata !DIExpression()), !dbg !474
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !474
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToQuery.addr, align 8, !dbg !475
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !477
  br i1 %cmp, label %if.then, label %if.else, !dbg !478

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToQuery.addr, align 8, !dbg !479
  %call = call i8* @pcTaskGetName(%struct.tskTaskControlBlock* %1), !dbg !481
  store i8* %call, i8** %pcReturn, align 8, !dbg !482
  br label %if.end12, !dbg !483

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToQuery.addr, align 8, !dbg !484
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !486
  store i32 %3, i32* %lIndex, align 4, !dbg !487
  %4 = load i32, i32* %lIndex, align 4, !dbg !488
  %cmp1 = icmp sge i32 %4, 1, !dbg !488
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !488

land.rhs:                                         ; preds = %if.else
  %5 = load i32, i32* %lIndex, align 4, !dbg !488
  %cmp2 = icmp slt i32 %5, 257, !dbg !488
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %6 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !490
  %land.ext = zext i1 %6 to i32, !dbg !488
  %conv = sext i32 %land.ext to i64, !dbg !488
  %cmp3 = icmp ne i64 %conv, 0, !dbg !491
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !492

if.then5:                                         ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !493
  %sub = sub nsw i32 %7, 1, !dbg !493
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !493
  %8 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !493
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !495
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !496
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !498
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !499

if.then9:                                         ; preds = %if.then5
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !500
  %call10 = call i8* @pcTaskGetName(%struct.tskTaskControlBlock* %10), !dbg !502
  store i8* %call10, i8** %pcReturn, align 8, !dbg !503
  br label %if.end, !dbg !504

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !505

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %11 = load i8*, i8** %pcReturn, align 8, !dbg !506
  ret i8* %11, !dbg !507
}

declare dso_local i8* @pcTaskGetName(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MPU_ulTaskGetRunTimeCounterImpl(%struct.tskTaskControlBlock* %xTask) #0 section "privileged_functions" !dbg !508 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %xReturn = alloca i32, align 4
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !511, metadata !DIExpression()), !dbg !512
  call void @llvm.dbg.declare(metadata i32* %xReturn, metadata !513, metadata !DIExpression()), !dbg !514
  store i32 0, i32* %xReturn, align 4, !dbg !514
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !515, metadata !DIExpression()), !dbg !516
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !517, metadata !DIExpression()), !dbg !518
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !518
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !519
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !521
  br i1 %cmp, label %if.then, label %if.else, !dbg !522

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !523
  %call = call i32 @ulTaskGetRunTimeCounter(%struct.tskTaskControlBlock* %1), !dbg !525
  store i32 %call, i32* %xReturn, align 4, !dbg !526
  br label %if.end12, !dbg !527

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !528
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !530
  store i32 %3, i32* %lIndex, align 4, !dbg !531
  %4 = load i32, i32* %lIndex, align 4, !dbg !532
  %cmp1 = icmp sge i32 %4, 1, !dbg !532
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !532

land.rhs:                                         ; preds = %if.else
  %5 = load i32, i32* %lIndex, align 4, !dbg !532
  %cmp2 = icmp slt i32 %5, 257, !dbg !532
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %6 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !534
  %land.ext = zext i1 %6 to i32, !dbg !532
  %conv = sext i32 %land.ext to i64, !dbg !532
  %cmp3 = icmp ne i64 %conv, 0, !dbg !535
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !536

if.then5:                                         ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !537
  %sub = sub nsw i32 %7, 1, !dbg !537
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !537
  %8 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !537
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !539
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !540
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !542
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !543

if.then9:                                         ; preds = %if.then5
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !544
  %call10 = call i32 @ulTaskGetRunTimeCounter(%struct.tskTaskControlBlock* %10), !dbg !546
  store i32 %call10, i32* %xReturn, align 4, !dbg !547
  br label %if.end, !dbg !548

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !549

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %11 = load i32, i32* %xReturn, align 4, !dbg !550
  ret i32 %11, !dbg !551
}

declare dso_local i32 @ulTaskGetRunTimeCounter(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MPU_ulTaskGetRunTimePercentImpl(%struct.tskTaskControlBlock* %xTask) #0 section "privileged_functions" !dbg !552 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %xReturn = alloca i32, align 4
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !553, metadata !DIExpression()), !dbg !554
  call void @llvm.dbg.declare(metadata i32* %xReturn, metadata !555, metadata !DIExpression()), !dbg !556
  store i32 0, i32* %xReturn, align 4, !dbg !556
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !557, metadata !DIExpression()), !dbg !558
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !559, metadata !DIExpression()), !dbg !560
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !560
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !561
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !563
  br i1 %cmp, label %if.then, label %if.else, !dbg !564

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !565
  %call = call i32 @ulTaskGetRunTimePercent(%struct.tskTaskControlBlock* %1), !dbg !567
  store i32 %call, i32* %xReturn, align 4, !dbg !568
  br label %if.end12, !dbg !569

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !570
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !572
  store i32 %3, i32* %lIndex, align 4, !dbg !573
  %4 = load i32, i32* %lIndex, align 4, !dbg !574
  %cmp1 = icmp sge i32 %4, 1, !dbg !574
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !574

land.rhs:                                         ; preds = %if.else
  %5 = load i32, i32* %lIndex, align 4, !dbg !574
  %cmp2 = icmp slt i32 %5, 257, !dbg !574
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %6 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !576
  %land.ext = zext i1 %6 to i32, !dbg !574
  %conv = sext i32 %land.ext to i64, !dbg !574
  %cmp3 = icmp ne i64 %conv, 0, !dbg !577
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !578

if.then5:                                         ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !579
  %sub = sub nsw i32 %7, 1, !dbg !579
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !579
  %8 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !579
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !581
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !582
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !584
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !585

if.then9:                                         ; preds = %if.then5
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !586
  %call10 = call i32 @ulTaskGetRunTimePercent(%struct.tskTaskControlBlock* %10), !dbg !588
  store i32 %call10, i32* %xReturn, align 4, !dbg !589
  br label %if.end, !dbg !590

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !591

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %11 = load i32, i32* %xReturn, align 4, !dbg !592
  ret i32 %11, !dbg !593
}

declare dso_local i32 @ulTaskGetRunTimePercent(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MPU_ulTaskGetIdleRunTimePercentImpl() #0 section "privileged_functions" !dbg !594 {
entry:
  %xReturn = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %xReturn, metadata !597, metadata !DIExpression()), !dbg !598
  %call = call i32 @ulTaskGetIdleRunTimePercent(), !dbg !599
  store i32 %call, i32* %xReturn, align 4, !dbg !600
  %0 = load i32, i32* %xReturn, align 4, !dbg !601
  ret i32 %0, !dbg !602
}

declare dso_local i32 @ulTaskGetIdleRunTimePercent() #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MPU_ulTaskGetIdleRunTimeCounterImpl() #0 section "privileged_functions" !dbg !603 {
entry:
  %xReturn = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %xReturn, metadata !604, metadata !DIExpression()), !dbg !605
  %call = call i32 @ulTaskGetIdleRunTimeCounter(), !dbg !606
  store i32 %call, i32* %xReturn, align 4, !dbg !607
  %0 = load i32, i32* %xReturn, align 4, !dbg !608
  ret i32 %0, !dbg !609
}

declare dso_local i32 @ulTaskGetIdleRunTimeCounter() #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTaskSetApplicationTaskTagImpl(%struct.tskTaskControlBlock* %xTask, i64 (i8*)* %pxTagValue) #0 section "privileged_functions" !dbg !610 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %pxTagValue.addr = alloca i64 (i8*)*, align 8
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !617, metadata !DIExpression()), !dbg !618
  store i64 (i8*)* %pxTagValue, i64 (i8*)** %pxTagValue.addr, align 8
  call void @llvm.dbg.declare(metadata i64 (i8*)** %pxTagValue.addr, metadata !619, metadata !DIExpression()), !dbg !620
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !621, metadata !DIExpression()), !dbg !622
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !622
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !623, metadata !DIExpression()), !dbg !624
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !625
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !627
  br i1 %cmp, label %if.then, label %if.else, !dbg !628

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !629
  %2 = load i64 (i8*)*, i64 (i8*)** %pxTagValue.addr, align 8, !dbg !631
  call void @vTaskSetApplicationTaskTag(%struct.tskTaskControlBlock* %1, i64 (i8*)* %2), !dbg !632
  br label %if.end10, !dbg !633

if.else:                                          ; preds = %entry
  %3 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !634
  %4 = ptrtoint %struct.tskTaskControlBlock* %3 to i32, !dbg !636
  store i32 %4, i32* %lIndex, align 4, !dbg !637
  %5 = load i32, i32* %lIndex, align 4, !dbg !638
  %cmp1 = icmp sge i32 %5, 1, !dbg !638
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !638

land.rhs:                                         ; preds = %if.else
  %6 = load i32, i32* %lIndex, align 4, !dbg !638
  %cmp2 = icmp slt i32 %6, 257, !dbg !638
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %7 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !640
  %land.ext = zext i1 %7 to i32, !dbg !638
  %conv = sext i32 %land.ext to i64, !dbg !638
  %cmp3 = icmp ne i64 %conv, 0, !dbg !641
  br i1 %cmp3, label %if.then5, label %if.end9, !dbg !642

if.then5:                                         ; preds = %land.end
  %8 = load i32, i32* %lIndex, align 4, !dbg !643
  %sub = sub nsw i32 %8, 1, !dbg !643
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !643
  %9 = bitcast %struct.OpaqueObject* %call to %struct.tskTaskControlBlock*, !dbg !643
  store %struct.tskTaskControlBlock* %9, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !645
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !646
  %cmp6 = icmp ne %struct.tskTaskControlBlock* %10, null, !dbg !648
  br i1 %cmp6, label %if.then8, label %if.end, !dbg !649

if.then8:                                         ; preds = %if.then5
  %11 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !650
  %12 = load i64 (i8*)*, i64 (i8*)** %pxTagValue.addr, align 8, !dbg !652
  call void @vTaskSetApplicationTaskTag(%struct.tskTaskControlBlock* %11, i64 (i8*)* %12), !dbg !653
  br label %if.end, !dbg !654

if.end:                                           ; preds = %if.then8, %if.then5
  br label %if.end9, !dbg !655

if.end9:                                          ; preds = %if.end, %land.end
  br label %if.end10

if.end10:                                         ; preds = %if.end9, %if.then
  ret void, !dbg !656
}

declare dso_local void @vTaskSetApplicationTaskTag(%struct.tskTaskControlBlock*, i64 (i8*)*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 (i8*)* @MPU_xTaskGetApplicationTaskTagImpl(%struct.tskTaskControlBlock* %xTask) #0 section "privileged_functions" !dbg !657 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %xReturn = alloca i64 (i8*)*, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !660, metadata !DIExpression()), !dbg !661
  call void @llvm.dbg.declare(metadata i64 (i8*)** %xReturn, metadata !662, metadata !DIExpression()), !dbg !663
  store i64 (i8*)* null, i64 (i8*)** %xReturn, align 8, !dbg !663
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !664, metadata !DIExpression()), !dbg !665
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !666, metadata !DIExpression()), !dbg !667
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !667
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !668
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !670
  br i1 %cmp, label %if.then, label %if.else, !dbg !671

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !672
  %call = call i64 (i8*)* @xTaskGetApplicationTaskTag(%struct.tskTaskControlBlock* %1), !dbg !674
  store i64 (i8*)* %call, i64 (i8*)** %xReturn, align 8, !dbg !675
  br label %if.end12, !dbg !676

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !677
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !679
  store i32 %3, i32* %lIndex, align 4, !dbg !680
  %4 = load i32, i32* %lIndex, align 4, !dbg !681
  %cmp1 = icmp sge i32 %4, 1, !dbg !681
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !681

land.rhs:                                         ; preds = %if.else
  %5 = load i32, i32* %lIndex, align 4, !dbg !681
  %cmp2 = icmp slt i32 %5, 257, !dbg !681
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %6 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !683
  %land.ext = zext i1 %6 to i32, !dbg !681
  %conv = sext i32 %land.ext to i64, !dbg !681
  %cmp3 = icmp ne i64 %conv, 0, !dbg !684
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !685

if.then5:                                         ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !686
  %sub = sub nsw i32 %7, 1, !dbg !686
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !686
  %8 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !686
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !688
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !689
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !691
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !692

if.then9:                                         ; preds = %if.then5
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !693
  %call10 = call i64 (i8*)* @xTaskGetApplicationTaskTag(%struct.tskTaskControlBlock* %10), !dbg !695
  store i64 (i8*)* %call10, i64 (i8*)** %xReturn, align 8, !dbg !696
  br label %if.end, !dbg !697

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !698

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %11 = load i64 (i8*)*, i64 (i8*)** %xReturn, align 8, !dbg !699
  ret i64 (i8*)* %11, !dbg !700
}

declare dso_local i64 (i8*)* @xTaskGetApplicationTaskTag(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTaskSetThreadLocalStoragePointerImpl(%struct.tskTaskControlBlock* %xTaskToSet, i64 %xIndex, i8* %pvValue) #0 section "privileged_functions" !dbg !701 {
entry:
  %xTaskToSet.addr = alloca %struct.tskTaskControlBlock*, align 8
  %xIndex.addr = alloca i64, align 8
  %pvValue.addr = alloca i8*, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTaskToSet, %struct.tskTaskControlBlock** %xTaskToSet.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTaskToSet.addr, metadata !704, metadata !DIExpression()), !dbg !705
  store i64 %xIndex, i64* %xIndex.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xIndex.addr, metadata !706, metadata !DIExpression()), !dbg !707
  store i8* %pvValue, i8** %pvValue.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvValue.addr, metadata !708, metadata !DIExpression()), !dbg !709
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !710, metadata !DIExpression()), !dbg !711
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !712, metadata !DIExpression()), !dbg !713
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !713
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToSet.addr, align 8, !dbg !714
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !716
  br i1 %cmp, label %if.then, label %if.else, !dbg !717

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToSet.addr, align 8, !dbg !718
  %2 = load i64, i64* %xIndex.addr, align 8, !dbg !720
  %3 = load i8*, i8** %pvValue.addr, align 8, !dbg !721
  call void @vTaskSetThreadLocalStoragePointer(%struct.tskTaskControlBlock* %1, i64 %2, i8* %3), !dbg !722
  br label %if.end10, !dbg !723

if.else:                                          ; preds = %entry
  %4 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToSet.addr, align 8, !dbg !724
  %5 = ptrtoint %struct.tskTaskControlBlock* %4 to i32, !dbg !726
  store i32 %5, i32* %lIndex, align 4, !dbg !727
  %6 = load i32, i32* %lIndex, align 4, !dbg !728
  %cmp1 = icmp sge i32 %6, 1, !dbg !728
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !728

land.rhs:                                         ; preds = %if.else
  %7 = load i32, i32* %lIndex, align 4, !dbg !728
  %cmp2 = icmp slt i32 %7, 257, !dbg !728
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %8 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !730
  %land.ext = zext i1 %8 to i32, !dbg !728
  %conv = sext i32 %land.ext to i64, !dbg !728
  %cmp3 = icmp ne i64 %conv, 0, !dbg !731
  br i1 %cmp3, label %if.then5, label %if.end9, !dbg !732

if.then5:                                         ; preds = %land.end
  %9 = load i32, i32* %lIndex, align 4, !dbg !733
  %sub = sub nsw i32 %9, 1, !dbg !733
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !733
  %10 = bitcast %struct.OpaqueObject* %call to %struct.tskTaskControlBlock*, !dbg !733
  store %struct.tskTaskControlBlock* %10, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !735
  %11 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !736
  %cmp6 = icmp ne %struct.tskTaskControlBlock* %11, null, !dbg !738
  br i1 %cmp6, label %if.then8, label %if.end, !dbg !739

if.then8:                                         ; preds = %if.then5
  %12 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !740
  %13 = load i64, i64* %xIndex.addr, align 8, !dbg !742
  %14 = load i8*, i8** %pvValue.addr, align 8, !dbg !743
  call void @vTaskSetThreadLocalStoragePointer(%struct.tskTaskControlBlock* %12, i64 %13, i8* %14), !dbg !744
  br label %if.end, !dbg !745

if.end:                                           ; preds = %if.then8, %if.then5
  br label %if.end9, !dbg !746

if.end9:                                          ; preds = %if.end, %land.end
  br label %if.end10

if.end10:                                         ; preds = %if.end9, %if.then
  ret void, !dbg !747
}

declare dso_local void @vTaskSetThreadLocalStoragePointer(%struct.tskTaskControlBlock*, i64, i8*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @MPU_pvTaskGetThreadLocalStoragePointerImpl(%struct.tskTaskControlBlock* %xTaskToQuery, i64 %xIndex) #0 section "privileged_functions" !dbg !748 {
entry:
  %xTaskToQuery.addr = alloca %struct.tskTaskControlBlock*, align 8
  %xIndex.addr = alloca i64, align 8
  %pvReturn = alloca i8*, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTaskToQuery, %struct.tskTaskControlBlock** %xTaskToQuery.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTaskToQuery.addr, metadata !751, metadata !DIExpression()), !dbg !752
  store i64 %xIndex, i64* %xIndex.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xIndex.addr, metadata !753, metadata !DIExpression()), !dbg !754
  call void @llvm.dbg.declare(metadata i8** %pvReturn, metadata !755, metadata !DIExpression()), !dbg !756
  store i8* null, i8** %pvReturn, align 8, !dbg !756
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !757, metadata !DIExpression()), !dbg !758
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !759, metadata !DIExpression()), !dbg !760
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !760
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToQuery.addr, align 8, !dbg !761
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !763
  br i1 %cmp, label %if.then, label %if.else, !dbg !764

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToQuery.addr, align 8, !dbg !765
  %2 = load i64, i64* %xIndex.addr, align 8, !dbg !767
  %call = call i8* @pvTaskGetThreadLocalStoragePointer(%struct.tskTaskControlBlock* %1, i64 %2), !dbg !768
  store i8* %call, i8** %pvReturn, align 8, !dbg !769
  br label %if.end12, !dbg !770

if.else:                                          ; preds = %entry
  %3 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToQuery.addr, align 8, !dbg !771
  %4 = ptrtoint %struct.tskTaskControlBlock* %3 to i32, !dbg !773
  store i32 %4, i32* %lIndex, align 4, !dbg !774
  %5 = load i32, i32* %lIndex, align 4, !dbg !775
  %cmp1 = icmp sge i32 %5, 1, !dbg !775
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !775

land.rhs:                                         ; preds = %if.else
  %6 = load i32, i32* %lIndex, align 4, !dbg !775
  %cmp2 = icmp slt i32 %6, 257, !dbg !775
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %7 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !777
  %land.ext = zext i1 %7 to i32, !dbg !775
  %conv = sext i32 %land.ext to i64, !dbg !775
  %cmp3 = icmp ne i64 %conv, 0, !dbg !778
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !779

if.then5:                                         ; preds = %land.end
  %8 = load i32, i32* %lIndex, align 4, !dbg !780
  %sub = sub nsw i32 %8, 1, !dbg !780
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !780
  %9 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !780
  store %struct.tskTaskControlBlock* %9, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !782
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !783
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %10, null, !dbg !785
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !786

if.then9:                                         ; preds = %if.then5
  %11 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !787
  %12 = load i64, i64* %xIndex.addr, align 8, !dbg !789
  %call10 = call i8* @pvTaskGetThreadLocalStoragePointer(%struct.tskTaskControlBlock* %11, i64 %12), !dbg !790
  store i8* %call10, i8** %pvReturn, align 8, !dbg !791
  br label %if.end, !dbg !792

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !793

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %13 = load i8*, i8** %pvReturn, align 8, !dbg !794
  ret i8* %13, !dbg !795
}

declare dso_local i8* @pvTaskGetThreadLocalStoragePointer(%struct.tskTaskControlBlock*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_uxTaskGetSystemStateImpl(%struct.xTASK_STATUS* %pxTaskStatusArray, i64 %uxArraySize, i32* %pulTotalRunTime) #0 section "privileged_functions" !dbg !796 {
entry:
  %pxTaskStatusArray.addr = alloca %struct.xTASK_STATUS*, align 8
  %uxArraySize.addr = alloca i64, align 8
  %pulTotalRunTime.addr = alloca i32*, align 8
  %uxReturn = alloca i64, align 8
  %xIsTaskStatusArrayWriteable = alloca i64, align 8
  %xIsTotalRunTimeWriteable = alloca i64, align 8
  store %struct.xTASK_STATUS* %pxTaskStatusArray, %struct.xTASK_STATUS** %pxTaskStatusArray.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xTASK_STATUS** %pxTaskStatusArray.addr, metadata !800, metadata !DIExpression()), !dbg !801
  store i64 %uxArraySize, i64* %uxArraySize.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxArraySize.addr, metadata !802, metadata !DIExpression()), !dbg !803
  store i32* %pulTotalRunTime, i32** %pulTotalRunTime.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %pulTotalRunTime.addr, metadata !804, metadata !DIExpression()), !dbg !805
  call void @llvm.dbg.declare(metadata i64* %uxReturn, metadata !806, metadata !DIExpression()), !dbg !807
  store i64 0, i64* %uxReturn, align 8, !dbg !807
  call void @llvm.dbg.declare(metadata i64* %xIsTaskStatusArrayWriteable, metadata !808, metadata !DIExpression()), !dbg !809
  store i64 0, i64* %xIsTaskStatusArrayWriteable, align 8, !dbg !809
  call void @llvm.dbg.declare(metadata i64* %xIsTotalRunTimeWriteable, metadata !810, metadata !DIExpression()), !dbg !811
  store i64 0, i64* %xIsTotalRunTimeWriteable, align 8, !dbg !811
  %0 = load %struct.xTASK_STATUS*, %struct.xTASK_STATUS** %pxTaskStatusArray.addr, align 8, !dbg !812
  %1 = bitcast %struct.xTASK_STATUS* %0 to i8*, !dbg !812
  %2 = load i64, i64* %uxArraySize.addr, align 8, !dbg !813
  %mul = mul i64 72, %2, !dbg !814
  %conv = trunc i64 %mul to i32, !dbg !815
  %call = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %1, i32 %conv, i32 2), !dbg !816
  store i64 %call, i64* %xIsTaskStatusArrayWriteable, align 8, !dbg !817
  %3 = load i32*, i32** %pulTotalRunTime.addr, align 8, !dbg !818
  %cmp = icmp ne i32* %3, null, !dbg !820
  br i1 %cmp, label %if.then, label %if.end, !dbg !821

if.then:                                          ; preds = %entry
  %4 = load i32*, i32** %pulTotalRunTime.addr, align 8, !dbg !822
  %5 = bitcast i32* %4 to i8*, !dbg !822
  %call2 = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %5, i32 4, i32 2), !dbg !824
  store i64 %call2, i64* %xIsTotalRunTimeWriteable, align 8, !dbg !825
  br label %if.end, !dbg !826

if.end:                                           ; preds = %if.then, %entry
  %6 = load i64, i64* %xIsTaskStatusArrayWriteable, align 8, !dbg !827
  %cmp3 = icmp eq i64 %6, 1, !dbg !829
  br i1 %cmp3, label %land.lhs.true, label %if.end11, !dbg !830

land.lhs.true:                                    ; preds = %if.end
  %7 = load i32*, i32** %pulTotalRunTime.addr, align 8, !dbg !831
  %cmp5 = icmp eq i32* %7, null, !dbg !832
  br i1 %cmp5, label %if.then9, label %lor.lhs.false, !dbg !833

lor.lhs.false:                                    ; preds = %land.lhs.true
  %8 = load i64, i64* %xIsTotalRunTimeWriteable, align 8, !dbg !834
  %cmp7 = icmp eq i64 %8, 1, !dbg !835
  br i1 %cmp7, label %if.then9, label %if.end11, !dbg !836

if.then9:                                         ; preds = %lor.lhs.false, %land.lhs.true
  %9 = load %struct.xTASK_STATUS*, %struct.xTASK_STATUS** %pxTaskStatusArray.addr, align 8, !dbg !837
  %10 = load i64, i64* %uxArraySize.addr, align 8, !dbg !839
  %11 = load i32*, i32** %pulTotalRunTime.addr, align 8, !dbg !840
  %call10 = call i64 @uxTaskGetSystemState(%struct.xTASK_STATUS* %9, i64 %10, i32* %11), !dbg !841
  store i64 %call10, i64* %uxReturn, align 8, !dbg !842
  br label %if.end11, !dbg !843

if.end11:                                         ; preds = %if.then9, %lor.lhs.false, %if.end
  %12 = load i64, i64* %uxReturn, align 8, !dbg !844
  ret i64 %12, !dbg !845
}

declare dso_local i64 @uxTaskGetSystemState(%struct.xTASK_STATUS*, i64, i32*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_uxTaskGetStackHighWaterMarkImpl(%struct.tskTaskControlBlock* %xTask) #0 section "privileged_functions" !dbg !846 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %uxReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !849, metadata !DIExpression()), !dbg !850
  call void @llvm.dbg.declare(metadata i64* %uxReturn, metadata !851, metadata !DIExpression()), !dbg !852
  store i64 0, i64* %uxReturn, align 8, !dbg !852
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !853, metadata !DIExpression()), !dbg !854
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !855, metadata !DIExpression()), !dbg !856
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !856
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !857
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !859
  br i1 %cmp, label %if.then, label %if.else, !dbg !860

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !861
  %call = call i64 @uxTaskGetStackHighWaterMark(%struct.tskTaskControlBlock* %1), !dbg !863
  store i64 %call, i64* %uxReturn, align 8, !dbg !864
  br label %if.end12, !dbg !865

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !866
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !868
  store i32 %3, i32* %lIndex, align 4, !dbg !869
  %4 = load i32, i32* %lIndex, align 4, !dbg !870
  %cmp1 = icmp sge i32 %4, 1, !dbg !870
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !870

land.rhs:                                         ; preds = %if.else
  %5 = load i32, i32* %lIndex, align 4, !dbg !870
  %cmp2 = icmp slt i32 %5, 257, !dbg !870
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %6 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !872
  %land.ext = zext i1 %6 to i32, !dbg !870
  %conv = sext i32 %land.ext to i64, !dbg !870
  %cmp3 = icmp ne i64 %conv, 0, !dbg !873
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !874

if.then5:                                         ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !875
  %sub = sub nsw i32 %7, 1, !dbg !875
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !875
  %8 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !875
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !877
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !878
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !880
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !881

if.then9:                                         ; preds = %if.then5
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !882
  %call10 = call i64 @uxTaskGetStackHighWaterMark(%struct.tskTaskControlBlock* %10), !dbg !884
  store i64 %call10, i64* %uxReturn, align 8, !dbg !885
  br label %if.end, !dbg !886

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !887

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %11 = load i64, i64* %uxReturn, align 8, !dbg !888
  ret i64 %11, !dbg !889
}

declare dso_local i64 @uxTaskGetStackHighWaterMark(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i16 @MPU_uxTaskGetStackHighWaterMark2Impl(%struct.tskTaskControlBlock* %xTask) #0 section "privileged_functions" !dbg !890 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %uxReturn = alloca i16, align 2
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !893, metadata !DIExpression()), !dbg !894
  call void @llvm.dbg.declare(metadata i16* %uxReturn, metadata !895, metadata !DIExpression()), !dbg !896
  store i16 0, i16* %uxReturn, align 2, !dbg !896
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !897, metadata !DIExpression()), !dbg !898
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !899, metadata !DIExpression()), !dbg !900
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !900
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !901
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !903
  br i1 %cmp, label %if.then, label %if.else, !dbg !904

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !905
  %call = call zeroext i16 @uxTaskGetStackHighWaterMark2(%struct.tskTaskControlBlock* %1), !dbg !907
  store i16 %call, i16* %uxReturn, align 2, !dbg !908
  br label %if.end12, !dbg !909

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !910
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !912
  store i32 %3, i32* %lIndex, align 4, !dbg !913
  %4 = load i32, i32* %lIndex, align 4, !dbg !914
  %cmp1 = icmp sge i32 %4, 1, !dbg !914
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !914

land.rhs:                                         ; preds = %if.else
  %5 = load i32, i32* %lIndex, align 4, !dbg !914
  %cmp2 = icmp slt i32 %5, 257, !dbg !914
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %6 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !916
  %land.ext = zext i1 %6 to i32, !dbg !914
  %conv = sext i32 %land.ext to i64, !dbg !914
  %cmp3 = icmp ne i64 %conv, 0, !dbg !917
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !918

if.then5:                                         ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !919
  %sub = sub nsw i32 %7, 1, !dbg !919
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !919
  %8 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !919
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !921
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !922
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !924
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !925

if.then9:                                         ; preds = %if.then5
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !926
  %call10 = call zeroext i16 @uxTaskGetStackHighWaterMark2(%struct.tskTaskControlBlock* %10), !dbg !928
  store i16 %call10, i16* %uxReturn, align 2, !dbg !929
  br label %if.end, !dbg !930

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !931

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %11 = load i16, i16* %uxReturn, align 2, !dbg !932
  ret i16 %11, !dbg !933
}

declare dso_local zeroext i16 @uxTaskGetStackHighWaterMark2(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.tskTaskControlBlock* @MPU_xTaskGetCurrentTaskHandleImpl() #0 section "privileged_functions" !dbg !934 {
entry:
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %xExternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !935, metadata !DIExpression()), !dbg !936
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !936
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xExternalTaskHandle, metadata !937, metadata !DIExpression()), !dbg !938
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xExternalTaskHandle, align 8, !dbg !938
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !939, metadata !DIExpression()), !dbg !940
  %call = call %struct.tskTaskControlBlock* @xTaskGetCurrentTaskHandle(), !dbg !941
  store %struct.tskTaskControlBlock* %call, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !942
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !943
  %cmp = icmp ne %struct.tskTaskControlBlock* %0, null, !dbg !945
  br i1 %cmp, label %if.then, label %if.end4, !dbg !946

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !947
  %2 = bitcast %struct.tskTaskControlBlock* %1 to %struct.OpaqueObject*, !dbg !947
  %call1 = call i32 @MPU_GetIndexForHandle(%struct.OpaqueObject* %2, i32 2), !dbg !947
  store i32 %call1, i32* %lIndex, align 4, !dbg !949
  %3 = load i32, i32* %lIndex, align 4, !dbg !950
  %cmp2 = icmp ne i32 %3, -1, !dbg !952
  br i1 %cmp2, label %if.then3, label %if.end, !dbg !953

if.then3:                                         ; preds = %if.then
  %4 = load i32, i32* %lIndex, align 4, !dbg !954
  %add = add nsw i32 %4, 1, !dbg !954
  %conv = sext i32 %add to i64, !dbg !956
  %5 = inttoptr i64 %conv to %struct.tskTaskControlBlock*, !dbg !956
  store %struct.tskTaskControlBlock* %5, %struct.tskTaskControlBlock** %xExternalTaskHandle, align 8, !dbg !957
  br label %if.end, !dbg !958

if.end:                                           ; preds = %if.then3, %if.then
  br label %if.end4, !dbg !959

if.end4:                                          ; preds = %if.end, %entry
  %6 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xExternalTaskHandle, align 8, !dbg !960
  ret %struct.tskTaskControlBlock* %6, !dbg !961
}

declare dso_local %struct.tskTaskControlBlock* @xTaskGetCurrentTaskHandle() #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @MPU_GetIndexForHandle(%struct.OpaqueObject* %xHandle, i32 %ulKernelObjectType) #0 section "privileged_functions" !dbg !962 {
entry:
  %xHandle.addr = alloca %struct.OpaqueObject*, align 8
  %ulKernelObjectType.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %lIndex = alloca i32, align 4
  store %struct.OpaqueObject* %xHandle, %struct.OpaqueObject** %xHandle.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.OpaqueObject** %xHandle.addr, metadata !965, metadata !DIExpression()), !dbg !966
  store i32 %ulKernelObjectType, i32* %ulKernelObjectType.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %ulKernelObjectType.addr, metadata !967, metadata !DIExpression()), !dbg !968
  call void @llvm.dbg.declare(metadata i32* %i, metadata !969, metadata !DIExpression()), !dbg !970
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !971, metadata !DIExpression()), !dbg !972
  store i32 -1, i32* %lIndex, align 4, !dbg !972
  %0 = load %struct.OpaqueObject*, %struct.OpaqueObject** %xHandle.addr, align 8, !dbg !973
  %cmp = icmp ne %struct.OpaqueObject* %0, null, !dbg !973
  %conv = zext i1 %cmp to i32, !dbg !973
  %cmp1 = icmp eq i32 %conv, 0, !dbg !973
  br i1 %cmp1, label %if.then, label %if.end, !dbg !975

if.then:                                          ; preds = %entry
  call void @vAssertCalled(i8* getelementptr inbounds ([68 x i8], [68 x i8]* @.str, i64 0, i64 0), i64 286), !dbg !973
  br label %if.end, !dbg !973

if.end:                                           ; preds = %if.then, %entry
  store i32 0, i32* %i, align 4, !dbg !976
  br label %for.cond, !dbg !978

for.cond:                                         ; preds = %for.inc, %if.end
  %1 = load i32, i32* %i, align 4, !dbg !979
  %cmp3 = icmp slt i32 %1, 256, !dbg !981
  br i1 %cmp3, label %for.body, label %for.end, !dbg !982

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %i, align 4, !dbg !983
  %idxprom = sext i32 %2 to i64, !dbg !986
  %arrayidx = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom, !dbg !986
  %xInternalObjectHandle = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx, i32 0, i32 0, !dbg !987
  %3 = load %struct.OpaqueObject*, %struct.OpaqueObject** %xInternalObjectHandle, align 8, !dbg !987
  %4 = load %struct.OpaqueObject*, %struct.OpaqueObject** %xHandle.addr, align 8, !dbg !988
  %cmp5 = icmp eq %struct.OpaqueObject* %3, %4, !dbg !989
  br i1 %cmp5, label %land.lhs.true, label %if.end13, !dbg !990

land.lhs.true:                                    ; preds = %for.body
  %5 = load i32, i32* %i, align 4, !dbg !991
  %idxprom7 = sext i32 %5 to i64, !dbg !992
  %arrayidx8 = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom7, !dbg !992
  %ulKernelObjectType9 = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx8, i32 0, i32 1, !dbg !993
  %6 = load i32, i32* %ulKernelObjectType9, align 8, !dbg !993
  %7 = load i32, i32* %ulKernelObjectType.addr, align 4, !dbg !994
  %cmp10 = icmp eq i32 %6, %7, !dbg !995
  br i1 %cmp10, label %if.then12, label %if.end13, !dbg !996

if.then12:                                        ; preds = %land.lhs.true
  %8 = load i32, i32* %i, align 4, !dbg !997
  store i32 %8, i32* %lIndex, align 4, !dbg !999
  br label %for.end, !dbg !1000

if.end13:                                         ; preds = %land.lhs.true, %for.body
  br label %for.inc, !dbg !1001

for.inc:                                          ; preds = %if.end13
  %9 = load i32, i32* %i, align 4, !dbg !1002
  %inc = add nsw i32 %9, 1, !dbg !1002
  store i32 %inc, i32* %i, align 4, !dbg !1002
  br label %for.cond, !dbg !1003, !llvm.loop !1004

for.end:                                          ; preds = %if.then12, %for.cond
  %10 = load i32, i32* %lIndex, align 4, !dbg !1006
  ret i32 %10, !dbg !1007
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskGetSchedulerStateImpl() #0 section "privileged_functions" !dbg !1008 {
entry:
  %xReturn = alloca i64, align 8
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !1011, metadata !DIExpression()), !dbg !1012
  store i64 1, i64* %xReturn, align 8, !dbg !1012
  %call = call i64 @xTaskGetSchedulerState(), !dbg !1013
  store i64 %call, i64* %xReturn, align 8, !dbg !1014
  %0 = load i64, i64* %xReturn, align 8, !dbg !1015
  ret i64 %0, !dbg !1016
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTaskSetTimeOutStateImpl(%struct.xTIME_OUT* %pxTimeOut) #0 section "privileged_functions" !dbg !1017 {
entry:
  %pxTimeOut.addr = alloca %struct.xTIME_OUT*, align 8
  %xIsTimeOutWriteable = alloca i64, align 8
  store %struct.xTIME_OUT* %pxTimeOut, %struct.xTIME_OUT** %pxTimeOut.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xTIME_OUT** %pxTimeOut.addr, metadata !1027, metadata !DIExpression()), !dbg !1028
  call void @llvm.dbg.declare(metadata i64* %xIsTimeOutWriteable, metadata !1029, metadata !DIExpression()), !dbg !1030
  store i64 0, i64* %xIsTimeOutWriteable, align 8, !dbg !1030
  %0 = load %struct.xTIME_OUT*, %struct.xTIME_OUT** %pxTimeOut.addr, align 8, !dbg !1031
  %1 = bitcast %struct.xTIME_OUT* %0 to i8*, !dbg !1031
  %call = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %1, i32 16, i32 2), !dbg !1032
  store i64 %call, i64* %xIsTimeOutWriteable, align 8, !dbg !1033
  %2 = load i64, i64* %xIsTimeOutWriteable, align 8, !dbg !1034
  %cmp = icmp eq i64 %2, 1, !dbg !1036
  br i1 %cmp, label %if.then, label %if.end, !dbg !1037

if.then:                                          ; preds = %entry
  %3 = load %struct.xTIME_OUT*, %struct.xTIME_OUT** %pxTimeOut.addr, align 8, !dbg !1038
  call void @vTaskSetTimeOutState(%struct.xTIME_OUT* %3), !dbg !1040
  br label %if.end, !dbg !1041

if.end:                                           ; preds = %if.then, %entry
  ret void, !dbg !1042
}

declare dso_local void @vTaskSetTimeOutState(%struct.xTIME_OUT*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskCheckForTimeOutImpl(%struct.xTIME_OUT* %pxTimeOut, i64* %pxTicksToWait) #0 section "privileged_functions" !dbg !1043 {
entry:
  %pxTimeOut.addr = alloca %struct.xTIME_OUT*, align 8
  %pxTicksToWait.addr = alloca i64*, align 8
  %xReturn = alloca i64, align 8
  %xIsTimeOutWriteable = alloca i64, align 8
  %xIsTicksToWaitWriteable = alloca i64, align 8
  store %struct.xTIME_OUT* %pxTimeOut, %struct.xTIME_OUT** %pxTimeOut.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xTIME_OUT** %pxTimeOut.addr, metadata !1046, metadata !DIExpression()), !dbg !1047
  store i64* %pxTicksToWait, i64** %pxTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxTicksToWait.addr, metadata !1048, metadata !DIExpression()), !dbg !1049
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !1050, metadata !DIExpression()), !dbg !1051
  store i64 0, i64* %xReturn, align 8, !dbg !1051
  call void @llvm.dbg.declare(metadata i64* %xIsTimeOutWriteable, metadata !1052, metadata !DIExpression()), !dbg !1053
  store i64 0, i64* %xIsTimeOutWriteable, align 8, !dbg !1053
  call void @llvm.dbg.declare(metadata i64* %xIsTicksToWaitWriteable, metadata !1054, metadata !DIExpression()), !dbg !1055
  store i64 0, i64* %xIsTicksToWaitWriteable, align 8, !dbg !1055
  %0 = load %struct.xTIME_OUT*, %struct.xTIME_OUT** %pxTimeOut.addr, align 8, !dbg !1056
  %1 = bitcast %struct.xTIME_OUT* %0 to i8*, !dbg !1056
  %call = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %1, i32 16, i32 2), !dbg !1057
  store i64 %call, i64* %xIsTimeOutWriteable, align 8, !dbg !1058
  %2 = load i64*, i64** %pxTicksToWait.addr, align 8, !dbg !1059
  %3 = bitcast i64* %2 to i8*, !dbg !1059
  %call1 = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %3, i32 8, i32 2), !dbg !1060
  store i64 %call1, i64* %xIsTicksToWaitWriteable, align 8, !dbg !1061
  %4 = load i64, i64* %xIsTimeOutWriteable, align 8, !dbg !1062
  %cmp = icmp eq i64 %4, 1, !dbg !1064
  br i1 %cmp, label %land.lhs.true, label %if.end, !dbg !1065

land.lhs.true:                                    ; preds = %entry
  %5 = load i64, i64* %xIsTicksToWaitWriteable, align 8, !dbg !1066
  %cmp2 = icmp eq i64 %5, 1, !dbg !1067
  br i1 %cmp2, label %if.then, label %if.end, !dbg !1068

if.then:                                          ; preds = %land.lhs.true
  %6 = load %struct.xTIME_OUT*, %struct.xTIME_OUT** %pxTimeOut.addr, align 8, !dbg !1069
  %7 = load i64*, i64** %pxTicksToWait.addr, align 8, !dbg !1071
  %call3 = call i64 @xTaskCheckForTimeOut(%struct.xTIME_OUT* %6, i64* %7), !dbg !1072
  store i64 %call3, i64* %xReturn, align 8, !dbg !1073
  br label %if.end, !dbg !1074

if.end:                                           ; preds = %if.then, %land.lhs.true, %entry
  %8 = load i64, i64* %xReturn, align 8, !dbg !1075
  ret i64 %8, !dbg !1076
}

declare dso_local i64 @xTaskCheckForTimeOut(%struct.xTIME_OUT*, i64*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskGenericNotifyImpl(%struct.tskTaskControlBlock* %xTaskToNotify, i64 %uxIndexToNotify, i32 %ulValue, i32 %eAction, i32* %pulPreviousNotificationValue) #0 section "privileged_functions" !dbg !1077 {
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
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTaskToNotify.addr, metadata !1081, metadata !DIExpression()), !dbg !1082
  store i64 %uxIndexToNotify, i64* %uxIndexToNotify.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxIndexToNotify.addr, metadata !1083, metadata !DIExpression()), !dbg !1084
  store i32 %ulValue, i32* %ulValue.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %ulValue.addr, metadata !1085, metadata !DIExpression()), !dbg !1086
  store i32 %eAction, i32* %eAction.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %eAction.addr, metadata !1087, metadata !DIExpression()), !dbg !1088
  store i32* %pulPreviousNotificationValue, i32** %pulPreviousNotificationValue.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %pulPreviousNotificationValue.addr, metadata !1089, metadata !DIExpression()), !dbg !1090
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !1091, metadata !DIExpression()), !dbg !1092
  store i64 0, i64* %xReturn, align 8, !dbg !1092
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1093, metadata !DIExpression()), !dbg !1094
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1095, metadata !DIExpression()), !dbg !1096
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1096
  call void @llvm.dbg.declare(metadata i64* %xIsPreviousNotificationValueWriteable, metadata !1097, metadata !DIExpression()), !dbg !1098
  store i64 0, i64* %xIsPreviousNotificationValueWriteable, align 8, !dbg !1098
  %0 = load i32*, i32** %pulPreviousNotificationValue.addr, align 8, !dbg !1099
  %cmp = icmp ne i32* %0, null, !dbg !1101
  br i1 %cmp, label %if.then, label %if.end, !dbg !1102

if.then:                                          ; preds = %entry
  %1 = load i32*, i32** %pulPreviousNotificationValue.addr, align 8, !dbg !1103
  %2 = bitcast i32* %1 to i8*, !dbg !1103
  %call = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %2, i32 4, i32 2), !dbg !1105
  store i64 %call, i64* %xIsPreviousNotificationValueWriteable, align 8, !dbg !1106
  br label %if.end, !dbg !1107

if.end:                                           ; preds = %if.then, %entry
  %3 = load i32*, i32** %pulPreviousNotificationValue.addr, align 8, !dbg !1108
  %cmp1 = icmp eq i32* %3, null, !dbg !1110
  br i1 %cmp1, label %if.then3, label %lor.lhs.false, !dbg !1111

lor.lhs.false:                                    ; preds = %if.end
  %4 = load i64, i64* %xIsPreviousNotificationValueWriteable, align 8, !dbg !1112
  %cmp2 = icmp eq i64 %4, 1, !dbg !1113
  br i1 %cmp2, label %if.then3, label %if.end16, !dbg !1114

if.then3:                                         ; preds = %lor.lhs.false, %if.end
  %5 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToNotify.addr, align 8, !dbg !1115
  %6 = ptrtoint %struct.tskTaskControlBlock* %5 to i32, !dbg !1117
  store i32 %6, i32* %lIndex, align 4, !dbg !1118
  %7 = load i32, i32* %lIndex, align 4, !dbg !1119
  %cmp4 = icmp sge i32 %7, 1, !dbg !1119
  br i1 %cmp4, label %land.rhs, label %land.end, !dbg !1119

land.rhs:                                         ; preds = %if.then3
  %8 = load i32, i32* %lIndex, align 4, !dbg !1119
  %cmp5 = icmp slt i32 %8, 257, !dbg !1119
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.then3
  %9 = phi i1 [ false, %if.then3 ], [ %cmp5, %land.rhs ], !dbg !1121
  %land.ext = zext i1 %9 to i32, !dbg !1119
  %conv = sext i32 %land.ext to i64, !dbg !1119
  %cmp6 = icmp ne i64 %conv, 0, !dbg !1122
  br i1 %cmp6, label %if.then8, label %if.end15, !dbg !1123

if.then8:                                         ; preds = %land.end
  %10 = load i32, i32* %lIndex, align 4, !dbg !1124
  %sub = sub nsw i32 %10, 1, !dbg !1124
  %call9 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !1124
  %11 = bitcast %struct.OpaqueObject* %call9 to %struct.tskTaskControlBlock*, !dbg !1124
  store %struct.tskTaskControlBlock* %11, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1126
  %12 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1127
  %cmp10 = icmp ne %struct.tskTaskControlBlock* %12, null, !dbg !1129
  br i1 %cmp10, label %if.then12, label %if.end14, !dbg !1130

if.then12:                                        ; preds = %if.then8
  %13 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1131
  %14 = load i64, i64* %uxIndexToNotify.addr, align 8, !dbg !1133
  %15 = load i32, i32* %ulValue.addr, align 4, !dbg !1134
  %16 = load i32, i32* %eAction.addr, align 4, !dbg !1135
  %17 = load i32*, i32** %pulPreviousNotificationValue.addr, align 8, !dbg !1136
  %call13 = call i64 @xTaskGenericNotify(%struct.tskTaskControlBlock* %13, i64 %14, i32 %15, i32 %16, i32* %17), !dbg !1137
  store i64 %call13, i64* %xReturn, align 8, !dbg !1138
  br label %if.end14, !dbg !1139

if.end14:                                         ; preds = %if.then12, %if.then8
  br label %if.end15, !dbg !1140

if.end15:                                         ; preds = %if.end14, %land.end
  br label %if.end16, !dbg !1141

if.end16:                                         ; preds = %if.end15, %lor.lhs.false
  %18 = load i64, i64* %xReturn, align 8, !dbg !1142
  ret i64 %18, !dbg !1143
}

declare dso_local i64 @xTaskGenericNotify(%struct.tskTaskControlBlock*, i64, i32, i32, i32*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskGenericNotifyWaitImpl(i64 %uxIndexToWaitOn, i32 %ulBitsToClearOnEntry, i32 %ulBitsToClearOnExit, i32* %pulNotificationValue, i64 %xTicksToWait) #0 section "privileged_functions" !dbg !1144 {
entry:
  %uxIndexToWaitOn.addr = alloca i64, align 8
  %ulBitsToClearOnEntry.addr = alloca i32, align 4
  %ulBitsToClearOnExit.addr = alloca i32, align 4
  %pulNotificationValue.addr = alloca i32*, align 8
  %xTicksToWait.addr = alloca i64, align 8
  %xReturn = alloca i64, align 8
  %xIsNotificationValueWritable = alloca i64, align 8
  store i64 %uxIndexToWaitOn, i64* %uxIndexToWaitOn.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxIndexToWaitOn.addr, metadata !1147, metadata !DIExpression()), !dbg !1148
  store i32 %ulBitsToClearOnEntry, i32* %ulBitsToClearOnEntry.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %ulBitsToClearOnEntry.addr, metadata !1149, metadata !DIExpression()), !dbg !1150
  store i32 %ulBitsToClearOnExit, i32* %ulBitsToClearOnExit.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %ulBitsToClearOnExit.addr, metadata !1151, metadata !DIExpression()), !dbg !1152
  store i32* %pulNotificationValue, i32** %pulNotificationValue.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %pulNotificationValue.addr, metadata !1153, metadata !DIExpression()), !dbg !1154
  store i64 %xTicksToWait, i64* %xTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToWait.addr, metadata !1155, metadata !DIExpression()), !dbg !1156
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !1157, metadata !DIExpression()), !dbg !1158
  store i64 0, i64* %xReturn, align 8, !dbg !1158
  call void @llvm.dbg.declare(metadata i64* %xIsNotificationValueWritable, metadata !1159, metadata !DIExpression()), !dbg !1160
  store i64 0, i64* %xIsNotificationValueWritable, align 8, !dbg !1160
  %0 = load i32*, i32** %pulNotificationValue.addr, align 8, !dbg !1161
  %cmp = icmp ne i32* %0, null, !dbg !1163
  br i1 %cmp, label %if.then, label %if.end, !dbg !1164

if.then:                                          ; preds = %entry
  %1 = load i32*, i32** %pulNotificationValue.addr, align 8, !dbg !1165
  %2 = bitcast i32* %1 to i8*, !dbg !1165
  %call = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %2, i32 4, i32 2), !dbg !1167
  store i64 %call, i64* %xIsNotificationValueWritable, align 8, !dbg !1168
  br label %if.end, !dbg !1169

if.end:                                           ; preds = %if.then, %entry
  %3 = load i32*, i32** %pulNotificationValue.addr, align 8, !dbg !1170
  %cmp1 = icmp eq i32* %3, null, !dbg !1172
  br i1 %cmp1, label %if.then3, label %lor.lhs.false, !dbg !1173

lor.lhs.false:                                    ; preds = %if.end
  %4 = load i64, i64* %xIsNotificationValueWritable, align 8, !dbg !1174
  %cmp2 = icmp eq i64 %4, 1, !dbg !1175
  br i1 %cmp2, label %if.then3, label %if.end5, !dbg !1176

if.then3:                                         ; preds = %lor.lhs.false, %if.end
  %5 = load i64, i64* %uxIndexToWaitOn.addr, align 8, !dbg !1177
  %6 = load i32, i32* %ulBitsToClearOnEntry.addr, align 4, !dbg !1179
  %7 = load i32, i32* %ulBitsToClearOnExit.addr, align 4, !dbg !1180
  %8 = load i32*, i32** %pulNotificationValue.addr, align 8, !dbg !1181
  %9 = load i64, i64* %xTicksToWait.addr, align 8, !dbg !1182
  %call4 = call i64 @xTaskGenericNotifyWait(i64 %5, i32 %6, i32 %7, i32* %8, i64 %9), !dbg !1183
  store i64 %call4, i64* %xReturn, align 8, !dbg !1184
  br label %if.end5, !dbg !1185

if.end5:                                          ; preds = %if.then3, %lor.lhs.false
  %10 = load i64, i64* %xReturn, align 8, !dbg !1186
  ret i64 %10, !dbg !1187
}

declare dso_local i64 @xTaskGenericNotifyWait(i64, i32, i32, i32*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MPU_ulTaskGenericNotifyTakeImpl(i64 %uxIndexToWaitOn, i64 %xClearCountOnExit, i64 %xTicksToWait) #0 section "privileged_functions" !dbg !1188 {
entry:
  %uxIndexToWaitOn.addr = alloca i64, align 8
  %xClearCountOnExit.addr = alloca i64, align 8
  %xTicksToWait.addr = alloca i64, align 8
  %ulReturn = alloca i32, align 4
  store i64 %uxIndexToWaitOn, i64* %uxIndexToWaitOn.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxIndexToWaitOn.addr, metadata !1191, metadata !DIExpression()), !dbg !1192
  store i64 %xClearCountOnExit, i64* %xClearCountOnExit.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xClearCountOnExit.addr, metadata !1193, metadata !DIExpression()), !dbg !1194
  store i64 %xTicksToWait, i64* %xTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToWait.addr, metadata !1195, metadata !DIExpression()), !dbg !1196
  call void @llvm.dbg.declare(metadata i32* %ulReturn, metadata !1197, metadata !DIExpression()), !dbg !1198
  %0 = load i64, i64* %uxIndexToWaitOn.addr, align 8, !dbg !1199
  %1 = load i64, i64* %xClearCountOnExit.addr, align 8, !dbg !1200
  %2 = load i64, i64* %xTicksToWait.addr, align 8, !dbg !1201
  %call = call i32 @ulTaskGenericNotifyTake(i64 %0, i64 %1, i64 %2), !dbg !1202
  store i32 %call, i32* %ulReturn, align 4, !dbg !1203
  %3 = load i32, i32* %ulReturn, align 4, !dbg !1204
  ret i32 %3, !dbg !1205
}

declare dso_local i32 @ulTaskGenericNotifyTake(i64, i64, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskGenericNotifyStateClearImpl(%struct.tskTaskControlBlock* %xTask, i64 %uxIndexToClear) #0 section "privileged_functions" !dbg !1206 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %uxIndexToClear.addr = alloca i64, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !1209, metadata !DIExpression()), !dbg !1210
  store i64 %uxIndexToClear, i64* %uxIndexToClear.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxIndexToClear.addr, metadata !1211, metadata !DIExpression()), !dbg !1212
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !1213, metadata !DIExpression()), !dbg !1214
  store i64 0, i64* %xReturn, align 8, !dbg !1214
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1215, metadata !DIExpression()), !dbg !1216
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1217, metadata !DIExpression()), !dbg !1218
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1218
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !1219
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !1221
  br i1 %cmp, label %if.then, label %if.else, !dbg !1222

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !1223
  %2 = load i64, i64* %uxIndexToClear.addr, align 8, !dbg !1225
  %call = call i64 @xTaskGenericNotifyStateClear(%struct.tskTaskControlBlock* %1, i64 %2), !dbg !1226
  store i64 %call, i64* %xReturn, align 8, !dbg !1227
  br label %if.end12, !dbg !1228

if.else:                                          ; preds = %entry
  %3 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !1229
  %4 = ptrtoint %struct.tskTaskControlBlock* %3 to i32, !dbg !1231
  store i32 %4, i32* %lIndex, align 4, !dbg !1232
  %5 = load i32, i32* %lIndex, align 4, !dbg !1233
  %cmp1 = icmp sge i32 %5, 1, !dbg !1233
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !1233

land.rhs:                                         ; preds = %if.else
  %6 = load i32, i32* %lIndex, align 4, !dbg !1233
  %cmp2 = icmp slt i32 %6, 257, !dbg !1233
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %7 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !1235
  %land.ext = zext i1 %7 to i32, !dbg !1233
  %conv = sext i32 %land.ext to i64, !dbg !1233
  %cmp3 = icmp ne i64 %conv, 0, !dbg !1236
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !1237

if.then5:                                         ; preds = %land.end
  %8 = load i32, i32* %lIndex, align 4, !dbg !1238
  %sub = sub nsw i32 %8, 1, !dbg !1238
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !1238
  %9 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !1238
  store %struct.tskTaskControlBlock* %9, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1240
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1241
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %10, null, !dbg !1243
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !1244

if.then9:                                         ; preds = %if.then5
  %11 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1245
  %12 = load i64, i64* %uxIndexToClear.addr, align 8, !dbg !1247
  %call10 = call i64 @xTaskGenericNotifyStateClear(%struct.tskTaskControlBlock* %11, i64 %12), !dbg !1248
  store i64 %call10, i64* %xReturn, align 8, !dbg !1249
  br label %if.end, !dbg !1250

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !1251

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %13 = load i64, i64* %xReturn, align 8, !dbg !1252
  ret i64 %13, !dbg !1253
}

declare dso_local i64 @xTaskGenericNotifyStateClear(%struct.tskTaskControlBlock*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MPU_ulTaskGenericNotifyValueClearImpl(%struct.tskTaskControlBlock* %xTask, i64 %uxIndexToClear, i32 %ulBitsToClear) #0 section "privileged_functions" !dbg !1254 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %uxIndexToClear.addr = alloca i64, align 8
  %ulBitsToClear.addr = alloca i32, align 4
  %ulReturn = alloca i32, align 4
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !1257, metadata !DIExpression()), !dbg !1258
  store i64 %uxIndexToClear, i64* %uxIndexToClear.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxIndexToClear.addr, metadata !1259, metadata !DIExpression()), !dbg !1260
  store i32 %ulBitsToClear, i32* %ulBitsToClear.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %ulBitsToClear.addr, metadata !1261, metadata !DIExpression()), !dbg !1262
  call void @llvm.dbg.declare(metadata i32* %ulReturn, metadata !1263, metadata !DIExpression()), !dbg !1264
  store i32 0, i32* %ulReturn, align 4, !dbg !1264
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1265, metadata !DIExpression()), !dbg !1266
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1267, metadata !DIExpression()), !dbg !1268
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1268
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !1269
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !1271
  br i1 %cmp, label %if.then, label %if.else, !dbg !1272

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !1273
  %2 = load i64, i64* %uxIndexToClear.addr, align 8, !dbg !1275
  %3 = load i32, i32* %ulBitsToClear.addr, align 4, !dbg !1276
  %call = call i32 @ulTaskGenericNotifyValueClear(%struct.tskTaskControlBlock* %1, i64 %2, i32 %3), !dbg !1277
  store i32 %call, i32* %ulReturn, align 4, !dbg !1278
  br label %if.end12, !dbg !1279

if.else:                                          ; preds = %entry
  %4 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !1280
  %5 = ptrtoint %struct.tskTaskControlBlock* %4 to i32, !dbg !1282
  store i32 %5, i32* %lIndex, align 4, !dbg !1283
  %6 = load i32, i32* %lIndex, align 4, !dbg !1284
  %cmp1 = icmp sge i32 %6, 1, !dbg !1284
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !1284

land.rhs:                                         ; preds = %if.else
  %7 = load i32, i32* %lIndex, align 4, !dbg !1284
  %cmp2 = icmp slt i32 %7, 257, !dbg !1284
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %8 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !1286
  %land.ext = zext i1 %8 to i32, !dbg !1284
  %conv = sext i32 %land.ext to i64, !dbg !1284
  %cmp3 = icmp ne i64 %conv, 0, !dbg !1287
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !1288

if.then5:                                         ; preds = %land.end
  %9 = load i32, i32* %lIndex, align 4, !dbg !1289
  %sub = sub nsw i32 %9, 1, !dbg !1289
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !1289
  %10 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !1289
  store %struct.tskTaskControlBlock* %10, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1291
  %11 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1292
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %11, null, !dbg !1294
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !1295

if.then9:                                         ; preds = %if.then5
  %12 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1296
  %13 = load i64, i64* %uxIndexToClear.addr, align 8, !dbg !1298
  %14 = load i32, i32* %ulBitsToClear.addr, align 4, !dbg !1299
  %call10 = call i32 @ulTaskGenericNotifyValueClear(%struct.tskTaskControlBlock* %12, i64 %13, i32 %14), !dbg !1300
  store i32 %call10, i32* %ulReturn, align 4, !dbg !1301
  br label %if.end, !dbg !1302

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !1303

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %15 = load i32, i32* %ulReturn, align 4, !dbg !1304
  ret i32 %15, !dbg !1305
}

declare dso_local i32 @ulTaskGenericNotifyValueClear(%struct.tskTaskControlBlock*, i64, i32) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskCreate(void (i8*)* %pvTaskCode, i8* %pcName, i16 zeroext %usStackDepth, i8* %pvParameters, i64 %uxPriority, %struct.tskTaskControlBlock** %pxCreatedTask) #0 section "privileged_functions" !dbg !1306 {
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
  call void @llvm.dbg.declare(metadata void (i8*)** %pvTaskCode.addr, metadata !1316, metadata !DIExpression()), !dbg !1317
  store i8* %pcName, i8** %pcName.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pcName.addr, metadata !1318, metadata !DIExpression()), !dbg !1319
  store i16 %usStackDepth, i16* %usStackDepth.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %usStackDepth.addr, metadata !1320, metadata !DIExpression()), !dbg !1321
  store i8* %pvParameters, i8** %pvParameters.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvParameters.addr, metadata !1322, metadata !DIExpression()), !dbg !1323
  store i64 %uxPriority, i64* %uxPriority.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxPriority.addr, metadata !1324, metadata !DIExpression()), !dbg !1325
  store %struct.tskTaskControlBlock** %pxCreatedTask, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock*** %pxCreatedTask.addr, metadata !1326, metadata !DIExpression()), !dbg !1327
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !1328, metadata !DIExpression()), !dbg !1329
  store i64 0, i64* %xReturn, align 8, !dbg !1329
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1330, metadata !DIExpression()), !dbg !1331
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1332, metadata !DIExpression()), !dbg !1333
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1333
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !1334
  store i32 %call, i32* %lIndex, align 4, !dbg !1335
  %0 = load i32, i32* %lIndex, align 4, !dbg !1336
  %cmp = icmp ne i32 %0, -1, !dbg !1338
  br i1 %cmp, label %if.then, label %if.end11, !dbg !1339

if.then:                                          ; preds = %entry
  %1 = load i64, i64* %uxPriority.addr, align 8, !dbg !1340
  %and = and i64 %1, 0, !dbg !1343
  %cmp1 = icmp ne i64 %and, 0, !dbg !1344
  br i1 %cmp1, label %if.then2, label %if.end10, !dbg !1345

if.then2:                                         ; preds = %if.then
  %2 = load void (i8*)*, void (i8*)** %pvTaskCode.addr, align 8, !dbg !1346
  %3 = load i8*, i8** %pcName.addr, align 8, !dbg !1348
  %4 = load i16, i16* %usStackDepth.addr, align 2, !dbg !1349
  %5 = load i8*, i8** %pvParameters.addr, align 8, !dbg !1350
  %6 = load i64, i64* %uxPriority.addr, align 8, !dbg !1351
  %call3 = call i64 @xTaskCreate(void (i8*)* %2, i8* %3, i16 zeroext %4, i8* %5, i64 %6, %struct.tskTaskControlBlock** %xInternalTaskHandle), !dbg !1352
  store i64 %call3, i64* %xReturn, align 8, !dbg !1353
  %7 = load i64, i64* %xReturn, align 8, !dbg !1354
  %cmp4 = icmp eq i64 %7, 1, !dbg !1356
  br i1 %cmp4, label %land.lhs.true, label %if.else, !dbg !1357

land.lhs.true:                                    ; preds = %if.then2
  %8 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1358
  %cmp5 = icmp ne %struct.tskTaskControlBlock* %8, null, !dbg !1359
  br i1 %cmp5, label %if.then6, label %if.else, !dbg !1360

if.then6:                                         ; preds = %land.lhs.true
  %9 = load i32, i32* %lIndex, align 4, !dbg !1361
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1361
  %11 = bitcast %struct.tskTaskControlBlock* %10 to %struct.OpaqueObject*, !dbg !1361
  call void @MPU_StoreHandleAndDataAtIndex(i32 %9, %struct.OpaqueObject* %11, i8* null, i32 2), !dbg !1361
  %12 = load %struct.tskTaskControlBlock**, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8, !dbg !1363
  %cmp7 = icmp ne %struct.tskTaskControlBlock** %12, null, !dbg !1365
  br i1 %cmp7, label %if.then8, label %if.end, !dbg !1366

if.then8:                                         ; preds = %if.then6
  %13 = load i32, i32* %lIndex, align 4, !dbg !1367
  %add = add nsw i32 %13, 1, !dbg !1367
  %conv = sext i32 %add to i64, !dbg !1369
  %14 = inttoptr i64 %conv to %struct.tskTaskControlBlock*, !dbg !1369
  %15 = load %struct.tskTaskControlBlock**, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8, !dbg !1370
  store %struct.tskTaskControlBlock* %14, %struct.tskTaskControlBlock** %15, align 8, !dbg !1371
  br label %if.end, !dbg !1372

if.end:                                           ; preds = %if.then8, %if.then6
  br label %if.end9, !dbg !1373

if.else:                                          ; preds = %land.lhs.true, %if.then2
  %16 = load i32, i32* %lIndex, align 4, !dbg !1374
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %16), !dbg !1376
  br label %if.end9

if.end9:                                          ; preds = %if.else, %if.end
  br label %if.end10, !dbg !1377

if.end10:                                         ; preds = %if.end9, %if.then
  br label %if.end11, !dbg !1378

if.end11:                                         ; preds = %if.end10, %entry
  %17 = load i64, i64* %xReturn, align 8, !dbg !1379
  ret i64 %17, !dbg !1380
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @MPU_GetFreeIndexInKernelObjectPool() #0 section "privileged_functions" !dbg !1381 {
entry:
  %i = alloca i32, align 4
  %lFreeIndex = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %i, metadata !1384, metadata !DIExpression()), !dbg !1385
  call void @llvm.dbg.declare(metadata i32* %lFreeIndex, metadata !1386, metadata !DIExpression()), !dbg !1387
  store i32 -1, i32* %lFreeIndex, align 4, !dbg !1387
  call void @vTaskSuspendAll(), !dbg !1388
  store i32 0, i32* %i, align 4, !dbg !1389
  br label %for.cond, !dbg !1392

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !1393
  %cmp = icmp slt i32 %0, 256, !dbg !1395
  br i1 %cmp, label %for.body, label %for.end, !dbg !1396

for.body:                                         ; preds = %for.cond
  %1 = load i32, i32* %i, align 4, !dbg !1397
  %idxprom = sext i32 %1 to i64, !dbg !1400
  %arrayidx = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom, !dbg !1400
  %xInternalObjectHandle = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx, i32 0, i32 0, !dbg !1401
  %2 = load %struct.OpaqueObject*, %struct.OpaqueObject** %xInternalObjectHandle, align 8, !dbg !1401
  %cmp1 = icmp eq %struct.OpaqueObject* %2, null, !dbg !1402
  br i1 %cmp1, label %if.then, label %if.end, !dbg !1403

if.then:                                          ; preds = %for.body
  %3 = load i32, i32* %i, align 4, !dbg !1404
  %idxprom2 = sext i32 %3 to i64, !dbg !1406
  %arrayidx3 = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom2, !dbg !1406
  %xInternalObjectHandle4 = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx3, i32 0, i32 0, !dbg !1407
  store %struct.OpaqueObject* inttoptr (i64 -1 to %struct.OpaqueObject*), %struct.OpaqueObject** %xInternalObjectHandle4, align 8, !dbg !1408
  %4 = load i32, i32* %i, align 4, !dbg !1409
  store i32 %4, i32* %lFreeIndex, align 4, !dbg !1410
  br label %for.end, !dbg !1411

if.end:                                           ; preds = %for.body
  br label %for.inc, !dbg !1412

for.inc:                                          ; preds = %if.end
  %5 = load i32, i32* %i, align 4, !dbg !1413
  %inc = add nsw i32 %5, 1, !dbg !1413
  store i32 %inc, i32* %i, align 4, !dbg !1413
  br label %for.cond, !dbg !1414, !llvm.loop !1415

for.end:                                          ; preds = %if.then, %for.cond
  %call = call i64 @xTaskResumeAll(), !dbg !1417
  %6 = load i32, i32* %lFreeIndex, align 4, !dbg !1418
  ret i32 %6, !dbg !1419
}

declare dso_local i64 @xTaskCreate(void (i8*)*, i8*, i16 zeroext, i8*, i64, %struct.tskTaskControlBlock**) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define internal void @MPU_StoreHandleAndDataAtIndex(i32 %lIndex, %struct.OpaqueObject* %xHandle, i8* %pvKernelObjectData, i32 %ulKernelObjectType) #0 section "privileged_functions" !dbg !1420 {
entry:
  %lIndex.addr = alloca i32, align 4
  %xHandle.addr = alloca %struct.OpaqueObject*, align 8
  %pvKernelObjectData.addr = alloca i8*, align 8
  %ulKernelObjectType.addr = alloca i32, align 4
  store i32 %lIndex, i32* %lIndex.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %lIndex.addr, metadata !1423, metadata !DIExpression()), !dbg !1424
  store %struct.OpaqueObject* %xHandle, %struct.OpaqueObject** %xHandle.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.OpaqueObject** %xHandle.addr, metadata !1425, metadata !DIExpression()), !dbg !1426
  store i8* %pvKernelObjectData, i8** %pvKernelObjectData.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvKernelObjectData.addr, metadata !1427, metadata !DIExpression()), !dbg !1428
  store i32 %ulKernelObjectType, i32* %ulKernelObjectType.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %ulKernelObjectType.addr, metadata !1429, metadata !DIExpression()), !dbg !1430
  %0 = load i32, i32* %lIndex.addr, align 4, !dbg !1431
  %cmp = icmp sge i32 %0, 0, !dbg !1431
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !1431

land.rhs:                                         ; preds = %entry
  %1 = load i32, i32* %lIndex.addr, align 4, !dbg !1431
  %cmp1 = icmp slt i32 %1, 256, !dbg !1431
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %2 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !1433
  %land.ext = zext i1 %2 to i32, !dbg !1431
  %conv = sext i32 %land.ext to i64, !dbg !1431
  %cmp2 = icmp ne i64 %conv, 0, !dbg !1431
  %conv3 = zext i1 %cmp2 to i32, !dbg !1431
  %cmp4 = icmp eq i32 %conv3, 0, !dbg !1431
  br i1 %cmp4, label %if.then, label %if.end, !dbg !1434

if.then:                                          ; preds = %land.end
  call void @vAssertCalled(i8* getelementptr inbounds ([68 x i8], [68 x i8]* @.str, i64 0, i64 0), i64 307), !dbg !1431
  br label %if.end, !dbg !1431

if.end:                                           ; preds = %if.then, %land.end
  %3 = load %struct.OpaqueObject*, %struct.OpaqueObject** %xHandle.addr, align 8, !dbg !1435
  %4 = load i32, i32* %lIndex.addr, align 4, !dbg !1436
  %idxprom = sext i32 %4 to i64, !dbg !1437
  %arrayidx = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom, !dbg !1437
  %xInternalObjectHandle = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx, i32 0, i32 0, !dbg !1438
  store %struct.OpaqueObject* %3, %struct.OpaqueObject** %xInternalObjectHandle, align 8, !dbg !1439
  %5 = load i32, i32* %ulKernelObjectType.addr, align 4, !dbg !1440
  %6 = load i32, i32* %lIndex.addr, align 4, !dbg !1441
  %idxprom6 = sext i32 %6 to i64, !dbg !1442
  %arrayidx7 = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom6, !dbg !1442
  %ulKernelObjectType8 = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx7, i32 0, i32 1, !dbg !1443
  store i32 %5, i32* %ulKernelObjectType8, align 8, !dbg !1444
  %7 = load i8*, i8** %pvKernelObjectData.addr, align 8, !dbg !1445
  %8 = load i32, i32* %lIndex.addr, align 4, !dbg !1446
  %idxprom9 = sext i32 %8 to i64, !dbg !1447
  %arrayidx10 = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom9, !dbg !1447
  %pvKernelObjectData11 = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx10, i32 0, i32 2, !dbg !1448
  store i8* %7, i8** %pvKernelObjectData11, align 8, !dbg !1449
  ret void, !dbg !1450
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @MPU_SetIndexFreeInKernelObjectPool(i32 %lIndex) #0 section "privileged_functions" !dbg !1451 {
entry:
  %lIndex.addr = alloca i32, align 4
  store i32 %lIndex, i32* %lIndex.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %lIndex.addr, metadata !1454, metadata !DIExpression()), !dbg !1455
  %0 = load i32, i32* %lIndex.addr, align 4, !dbg !1456
  %cmp = icmp sge i32 %0, 0, !dbg !1456
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !1456

land.rhs:                                         ; preds = %entry
  %1 = load i32, i32* %lIndex.addr, align 4, !dbg !1456
  %cmp1 = icmp slt i32 %1, 256, !dbg !1456
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %2 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !1458
  %land.ext = zext i1 %2 to i32, !dbg !1456
  %conv = sext i32 %land.ext to i64, !dbg !1456
  %cmp2 = icmp ne i64 %conv, 0, !dbg !1456
  %conv3 = zext i1 %cmp2 to i32, !dbg !1456
  %cmp4 = icmp eq i32 %conv3, 0, !dbg !1456
  br i1 %cmp4, label %if.then, label %if.end, !dbg !1459

if.then:                                          ; preds = %land.end
  call void @vAssertCalled(i8* getelementptr inbounds ([68 x i8], [68 x i8]* @.str, i64 0, i64 0), i64 269), !dbg !1456
  br label %if.end, !dbg !1456

if.end:                                           ; preds = %if.then, %land.end
  call void @vPortEnterCritical(), !dbg !1460
  %3 = load i32, i32* %lIndex.addr, align 4, !dbg !1461
  %idxprom = sext i32 %3 to i64, !dbg !1463
  %arrayidx = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom, !dbg !1463
  %xInternalObjectHandle = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx, i32 0, i32 0, !dbg !1464
  store %struct.OpaqueObject* null, %struct.OpaqueObject** %xInternalObjectHandle, align 8, !dbg !1465
  %4 = load i32, i32* %lIndex.addr, align 4, !dbg !1466
  %idxprom6 = sext i32 %4 to i64, !dbg !1467
  %arrayidx7 = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom6, !dbg !1467
  %ulKernelObjectType = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx7, i32 0, i32 1, !dbg !1468
  store i32 0, i32* %ulKernelObjectType, align 8, !dbg !1469
  %5 = load i32, i32* %lIndex.addr, align 4, !dbg !1470
  %idxprom8 = sext i32 %5 to i64, !dbg !1471
  %arrayidx9 = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom8, !dbg !1471
  %pvKernelObjectData = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx9, i32 0, i32 2, !dbg !1472
  store i8* null, i8** %pvKernelObjectData, align 8, !dbg !1473
  call void @vPortExitCritical(), !dbg !1474
  ret void, !dbg !1475
}

declare dso_local void @vPortEnterCritical() #2

declare dso_local void @vPortExitCritical() #2

declare dso_local void @vTaskSuspendAll() #2 section "privileged_functions"

declare dso_local i64 @xTaskResumeAll() #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.tskTaskControlBlock* @MPU_xTaskCreateStatic(void (i8*)* %pxTaskCode, i8* %pcName, i32 %ulStackDepth, i8* %pvParameters, i64 %uxPriority, i64* %puxStackBuffer, %struct.xSTATIC_TCB* %pxTaskBuffer) #0 section "privileged_functions" !dbg !1476 {
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
  call void @llvm.dbg.declare(metadata void (i8*)** %pxTaskCode.addr, metadata !1541, metadata !DIExpression()), !dbg !1542
  store i8* %pcName, i8** %pcName.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pcName.addr, metadata !1543, metadata !DIExpression()), !dbg !1544
  store i32 %ulStackDepth, i32* %ulStackDepth.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %ulStackDepth.addr, metadata !1545, metadata !DIExpression()), !dbg !1546
  store i8* %pvParameters, i8** %pvParameters.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvParameters.addr, metadata !1547, metadata !DIExpression()), !dbg !1548
  store i64 %uxPriority, i64* %uxPriority.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxPriority.addr, metadata !1549, metadata !DIExpression()), !dbg !1550
  store i64* %puxStackBuffer, i64** %puxStackBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %puxStackBuffer.addr, metadata !1551, metadata !DIExpression()), !dbg !1552
  store %struct.xSTATIC_TCB* %pxTaskBuffer, %struct.xSTATIC_TCB** %pxTaskBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xSTATIC_TCB** %pxTaskBuffer.addr, metadata !1553, metadata !DIExpression()), !dbg !1554
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xExternalTaskHandle, metadata !1555, metadata !DIExpression()), !dbg !1556
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xExternalTaskHandle, align 8, !dbg !1556
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1557, metadata !DIExpression()), !dbg !1558
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1558
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1559, metadata !DIExpression()), !dbg !1560
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !1561
  store i32 %call, i32* %lIndex, align 4, !dbg !1562
  %0 = load i32, i32* %lIndex, align 4, !dbg !1563
  %cmp = icmp ne i32 %0, -1, !dbg !1565
  br i1 %cmp, label %if.then, label %if.end4, !dbg !1566

if.then:                                          ; preds = %entry
  %1 = load void (i8*)*, void (i8*)** %pxTaskCode.addr, align 8, !dbg !1567
  %2 = load i8*, i8** %pcName.addr, align 8, !dbg !1569
  %3 = load i32, i32* %ulStackDepth.addr, align 4, !dbg !1570
  %4 = load i8*, i8** %pvParameters.addr, align 8, !dbg !1571
  %5 = load i64, i64* %uxPriority.addr, align 8, !dbg !1572
  %6 = load i64*, i64** %puxStackBuffer.addr, align 8, !dbg !1573
  %7 = load %struct.xSTATIC_TCB*, %struct.xSTATIC_TCB** %pxTaskBuffer.addr, align 8, !dbg !1574
  %call1 = call %struct.tskTaskControlBlock* @xTaskCreateStatic(void (i8*)* %1, i8* %2, i32 %3, i8* %4, i64 %5, i64* %6, %struct.xSTATIC_TCB* %7), !dbg !1575
  store %struct.tskTaskControlBlock* %call1, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1576
  %8 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1577
  %cmp2 = icmp ne %struct.tskTaskControlBlock* %8, null, !dbg !1579
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !1580

if.then3:                                         ; preds = %if.then
  %9 = load i32, i32* %lIndex, align 4, !dbg !1581
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1581
  %11 = bitcast %struct.tskTaskControlBlock* %10 to %struct.OpaqueObject*, !dbg !1581
  call void @MPU_StoreHandleAndDataAtIndex(i32 %9, %struct.OpaqueObject* %11, i8* null, i32 2), !dbg !1581
  %12 = load i32, i32* %lIndex, align 4, !dbg !1583
  %add = add nsw i32 %12, 1, !dbg !1583
  %conv = sext i32 %add to i64, !dbg !1584
  %13 = inttoptr i64 %conv to %struct.tskTaskControlBlock*, !dbg !1584
  store %struct.tskTaskControlBlock* %13, %struct.tskTaskControlBlock** %xExternalTaskHandle, align 8, !dbg !1585
  br label %if.end, !dbg !1586

if.else:                                          ; preds = %if.then
  %14 = load i32, i32* %lIndex, align 4, !dbg !1587
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %14), !dbg !1589
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  br label %if.end4, !dbg !1590

if.end4:                                          ; preds = %if.end, %entry
  %15 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xExternalTaskHandle, align 8, !dbg !1591
  ret %struct.tskTaskControlBlock* %15, !dbg !1592
}

declare dso_local %struct.tskTaskControlBlock* @xTaskCreateStatic(void (i8*)*, i8*, i32, i8*, i64, i64*, %struct.xSTATIC_TCB*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTaskDelete(%struct.tskTaskControlBlock* %pxTaskToDelete) #0 section "privileged_functions" !dbg !1593 {
entry:
  %pxTaskToDelete.addr = alloca %struct.tskTaskControlBlock*, align 8
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tskTaskControlBlock* %pxTaskToDelete, %struct.tskTaskControlBlock** %pxTaskToDelete.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %pxTaskToDelete.addr, metadata !1594, metadata !DIExpression()), !dbg !1595
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1596, metadata !DIExpression()), !dbg !1597
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1597
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1598, metadata !DIExpression()), !dbg !1599
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTaskToDelete.addr, align 8, !dbg !1600
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !1602
  br i1 %cmp, label %if.then, label %if.else, !dbg !1603

if.then:                                          ; preds = %entry
  %call = call %struct.tskTaskControlBlock* @xTaskGetCurrentTaskHandle(), !dbg !1604
  store %struct.tskTaskControlBlock* %call, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1606
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1607
  %2 = bitcast %struct.tskTaskControlBlock* %1 to %struct.OpaqueObject*, !dbg !1607
  %call1 = call i32 @MPU_GetIndexForHandle(%struct.OpaqueObject* %2, i32 2), !dbg !1607
  store i32 %call1, i32* %lIndex, align 4, !dbg !1608
  %3 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1609
  call void @vTaskDelete(%struct.tskTaskControlBlock* %3), !dbg !1610
  %4 = load i32, i32* %lIndex, align 4, !dbg !1611
  %cmp2 = icmp ne i32 %4, -1, !dbg !1613
  br i1 %cmp2, label %if.then3, label %if.end, !dbg !1614

if.then3:                                         ; preds = %if.then
  %5 = load i32, i32* %lIndex, align 4, !dbg !1615
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %5), !dbg !1617
  br label %if.end, !dbg !1618

if.end:                                           ; preds = %if.then3, %if.then
  br label %if.end16, !dbg !1619

if.else:                                          ; preds = %entry
  %6 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTaskToDelete.addr, align 8, !dbg !1620
  %7 = ptrtoint %struct.tskTaskControlBlock* %6 to i32, !dbg !1622
  store i32 %7, i32* %lIndex, align 4, !dbg !1623
  %8 = load i32, i32* %lIndex, align 4, !dbg !1624
  %cmp4 = icmp sge i32 %8, 1, !dbg !1624
  br i1 %cmp4, label %land.rhs, label %land.end, !dbg !1624

land.rhs:                                         ; preds = %if.else
  %9 = load i32, i32* %lIndex, align 4, !dbg !1624
  %cmp5 = icmp slt i32 %9, 257, !dbg !1624
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %10 = phi i1 [ false, %if.else ], [ %cmp5, %land.rhs ], !dbg !1626
  %land.ext = zext i1 %10 to i32, !dbg !1624
  %conv = sext i32 %land.ext to i64, !dbg !1624
  %cmp6 = icmp ne i64 %conv, 0, !dbg !1627
  br i1 %cmp6, label %if.then8, label %if.end15, !dbg !1628

if.then8:                                         ; preds = %land.end
  %11 = load i32, i32* %lIndex, align 4, !dbg !1629
  %sub = sub nsw i32 %11, 1, !dbg !1629
  %call9 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !1629
  %12 = bitcast %struct.OpaqueObject* %call9 to %struct.tskTaskControlBlock*, !dbg !1629
  store %struct.tskTaskControlBlock* %12, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1631
  %13 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1632
  %cmp10 = icmp ne %struct.tskTaskControlBlock* %13, null, !dbg !1634
  br i1 %cmp10, label %if.then12, label %if.end14, !dbg !1635

if.then12:                                        ; preds = %if.then8
  %14 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1636
  call void @vTaskDelete(%struct.tskTaskControlBlock* %14), !dbg !1638
  %15 = load i32, i32* %lIndex, align 4, !dbg !1639
  %sub13 = sub nsw i32 %15, 1, !dbg !1639
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %sub13), !dbg !1640
  br label %if.end14, !dbg !1641

if.end14:                                         ; preds = %if.then12, %if.then8
  br label %if.end15, !dbg !1642

if.end15:                                         ; preds = %if.end14, %land.end
  br label %if.end16

if.end16:                                         ; preds = %if.end15, %if.end
  ret void, !dbg !1643
}

declare dso_local void @vTaskDelete(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTaskPrioritySet(%struct.tskTaskControlBlock* %pxTask, i64 %uxNewPriority) #0 section "privileged_functions" !dbg !1644 {
entry:
  %pxTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %uxNewPriority.addr = alloca i64, align 8
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tskTaskControlBlock* %pxTask, %struct.tskTaskControlBlock** %pxTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %pxTask.addr, metadata !1647, metadata !DIExpression()), !dbg !1648
  store i64 %uxNewPriority, i64* %uxNewPriority.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxNewPriority.addr, metadata !1649, metadata !DIExpression()), !dbg !1650
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1651, metadata !DIExpression()), !dbg !1652
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1652
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1653, metadata !DIExpression()), !dbg !1654
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTask.addr, align 8, !dbg !1655
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !1657
  br i1 %cmp, label %if.then, label %if.else, !dbg !1658

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTask.addr, align 8, !dbg !1659
  %2 = load i64, i64* %uxNewPriority.addr, align 8, !dbg !1661
  call void @vTaskPrioritySet(%struct.tskTaskControlBlock* %1, i64 %2), !dbg !1662
  br label %if.end10, !dbg !1663

if.else:                                          ; preds = %entry
  %3 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxTask.addr, align 8, !dbg !1664
  %4 = ptrtoint %struct.tskTaskControlBlock* %3 to i32, !dbg !1666
  store i32 %4, i32* %lIndex, align 4, !dbg !1667
  %5 = load i32, i32* %lIndex, align 4, !dbg !1668
  %cmp1 = icmp sge i32 %5, 1, !dbg !1668
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !1668

land.rhs:                                         ; preds = %if.else
  %6 = load i32, i32* %lIndex, align 4, !dbg !1668
  %cmp2 = icmp slt i32 %6, 257, !dbg !1668
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %7 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !1670
  %land.ext = zext i1 %7 to i32, !dbg !1668
  %conv = sext i32 %land.ext to i64, !dbg !1668
  %cmp3 = icmp ne i64 %conv, 0, !dbg !1671
  br i1 %cmp3, label %if.then5, label %if.end9, !dbg !1672

if.then5:                                         ; preds = %land.end
  %8 = load i32, i32* %lIndex, align 4, !dbg !1673
  %sub = sub nsw i32 %8, 1, !dbg !1673
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !1673
  %9 = bitcast %struct.OpaqueObject* %call to %struct.tskTaskControlBlock*, !dbg !1673
  store %struct.tskTaskControlBlock* %9, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1675
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1676
  %cmp6 = icmp ne %struct.tskTaskControlBlock* %10, null, !dbg !1678
  br i1 %cmp6, label %if.then8, label %if.end, !dbg !1679

if.then8:                                         ; preds = %if.then5
  %11 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1680
  %12 = load i64, i64* %uxNewPriority.addr, align 8, !dbg !1682
  call void @vTaskPrioritySet(%struct.tskTaskControlBlock* %11, i64 %12), !dbg !1683
  br label %if.end, !dbg !1684

if.end:                                           ; preds = %if.then8, %if.then5
  br label %if.end9, !dbg !1685

if.end9:                                          ; preds = %if.end, %land.end
  br label %if.end10

if.end10:                                         ; preds = %if.end9, %if.then
  ret void, !dbg !1686
}

declare dso_local void @vTaskPrioritySet(%struct.tskTaskControlBlock*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.tskTaskControlBlock* @MPU_xTaskGetHandle(i8* %pcNameToQuery) #0 section "privileged_functions" !dbg !1687 {
entry:
  %pcNameToQuery.addr = alloca i8*, align 8
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %xExternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  store i8* %pcNameToQuery, i8** %pcNameToQuery.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pcNameToQuery.addr, metadata !1690, metadata !DIExpression()), !dbg !1691
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1692, metadata !DIExpression()), !dbg !1693
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1693
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xExternalTaskHandle, metadata !1694, metadata !DIExpression()), !dbg !1695
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xExternalTaskHandle, align 8, !dbg !1695
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1696, metadata !DIExpression()), !dbg !1697
  %0 = load i8*, i8** %pcNameToQuery.addr, align 8, !dbg !1698
  %call = call %struct.tskTaskControlBlock* @xTaskGetHandle(i8* %0), !dbg !1699
  store %struct.tskTaskControlBlock* %call, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1700
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1701
  %cmp = icmp ne %struct.tskTaskControlBlock* %1, null, !dbg !1703
  br i1 %cmp, label %if.then, label %if.end4, !dbg !1704

if.then:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1705
  %3 = bitcast %struct.tskTaskControlBlock* %2 to %struct.OpaqueObject*, !dbg !1705
  %call1 = call i32 @MPU_GetIndexForHandle(%struct.OpaqueObject* %3, i32 2), !dbg !1705
  store i32 %call1, i32* %lIndex, align 4, !dbg !1707
  %4 = load i32, i32* %lIndex, align 4, !dbg !1708
  %cmp2 = icmp ne i32 %4, -1, !dbg !1710
  br i1 %cmp2, label %if.then3, label %if.end, !dbg !1711

if.then3:                                         ; preds = %if.then
  %5 = load i32, i32* %lIndex, align 4, !dbg !1712
  %add = add nsw i32 %5, 1, !dbg !1712
  %conv = sext i32 %add to i64, !dbg !1714
  %6 = inttoptr i64 %conv to %struct.tskTaskControlBlock*, !dbg !1714
  store %struct.tskTaskControlBlock* %6, %struct.tskTaskControlBlock** %xExternalTaskHandle, align 8, !dbg !1715
  br label %if.end, !dbg !1716

if.end:                                           ; preds = %if.then3, %if.then
  br label %if.end4, !dbg !1717

if.end4:                                          ; preds = %if.end, %entry
  %7 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xExternalTaskHandle, align 8, !dbg !1718
  ret %struct.tskTaskControlBlock* %7, !dbg !1719
}

declare dso_local %struct.tskTaskControlBlock* @xTaskGetHandle(i8*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskCallApplicationTaskHook(%struct.tskTaskControlBlock* %xTask, i8* %pvParameter) #0 section "privileged_functions" !dbg !1720 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %pvParameter.addr = alloca i8*, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !1723, metadata !DIExpression()), !dbg !1724
  store i8* %pvParameter, i8** %pvParameter.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvParameter.addr, metadata !1725, metadata !DIExpression()), !dbg !1726
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !1727, metadata !DIExpression()), !dbg !1728
  store i64 0, i64* %xReturn, align 8, !dbg !1728
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1729, metadata !DIExpression()), !dbg !1730
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1731, metadata !DIExpression()), !dbg !1732
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1732
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !1733
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !1735
  br i1 %cmp, label %if.then, label %if.else, !dbg !1736

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !1737
  %2 = load i8*, i8** %pvParameter.addr, align 8, !dbg !1739
  %call = call i64 @xTaskCallApplicationTaskHook(%struct.tskTaskControlBlock* %1, i8* %2), !dbg !1740
  store i64 %call, i64* %xReturn, align 8, !dbg !1741
  br label %if.end12, !dbg !1742

if.else:                                          ; preds = %entry
  %3 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !1743
  %4 = ptrtoint %struct.tskTaskControlBlock* %3 to i32, !dbg !1745
  store i32 %4, i32* %lIndex, align 4, !dbg !1746
  %5 = load i32, i32* %lIndex, align 4, !dbg !1747
  %cmp1 = icmp sge i32 %5, 1, !dbg !1747
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !1747

land.rhs:                                         ; preds = %if.else
  %6 = load i32, i32* %lIndex, align 4, !dbg !1747
  %cmp2 = icmp slt i32 %6, 257, !dbg !1747
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %7 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !1749
  %land.ext = zext i1 %7 to i32, !dbg !1747
  %conv = sext i32 %land.ext to i64, !dbg !1747
  %cmp3 = icmp ne i64 %conv, 0, !dbg !1750
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !1751

if.then5:                                         ; preds = %land.end
  %8 = load i32, i32* %lIndex, align 4, !dbg !1752
  %sub = sub nsw i32 %8, 1, !dbg !1752
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !1752
  %9 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !1752
  store %struct.tskTaskControlBlock* %9, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1754
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1755
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %10, null, !dbg !1757
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !1758

if.then9:                                         ; preds = %if.then5
  %11 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1759
  %12 = load i8*, i8** %pvParameter.addr, align 8, !dbg !1761
  %call10 = call i64 @xTaskCallApplicationTaskHook(%struct.tskTaskControlBlock* %11, i8* %12), !dbg !1762
  store i64 %call10, i64* %xReturn, align 8, !dbg !1763
  br label %if.end, !dbg !1764

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !1765

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %13 = load i64, i64* %xReturn, align 8, !dbg !1766
  ret i64 %13, !dbg !1767
}

declare dso_local i64 @xTaskCallApplicationTaskHook(%struct.tskTaskControlBlock*, i8*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskCreateRestricted(%struct.xTASK_PARAMETERS* %pxTaskDefinition, %struct.tskTaskControlBlock** %pxCreatedTask) #0 section "privileged_functions" !dbg !1768 {
entry:
  %pxTaskDefinition.addr = alloca %struct.xTASK_PARAMETERS*, align 8
  %pxCreatedTask.addr = alloca %struct.tskTaskControlBlock**, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.xTASK_PARAMETERS* %pxTaskDefinition, %struct.xTASK_PARAMETERS** %pxTaskDefinition.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xTASK_PARAMETERS** %pxTaskDefinition.addr, metadata !1794, metadata !DIExpression()), !dbg !1795
  store %struct.tskTaskControlBlock** %pxCreatedTask, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock*** %pxCreatedTask.addr, metadata !1796, metadata !DIExpression()), !dbg !1797
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !1798, metadata !DIExpression()), !dbg !1799
  store i64 0, i64* %xReturn, align 8, !dbg !1799
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1800, metadata !DIExpression()), !dbg !1801
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1802, metadata !DIExpression()), !dbg !1803
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1803
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !1804
  store i32 %call, i32* %lIndex, align 4, !dbg !1805
  %0 = load i32, i32* %lIndex, align 4, !dbg !1806
  %cmp = icmp ne i32 %0, -1, !dbg !1808
  br i1 %cmp, label %if.then, label %if.end8, !dbg !1809

if.then:                                          ; preds = %entry
  %1 = load %struct.xTASK_PARAMETERS*, %struct.xTASK_PARAMETERS** %pxTaskDefinition.addr, align 8, !dbg !1810
  %call1 = call i64 @xTaskCreateRestricted(%struct.xTASK_PARAMETERS* %1, %struct.tskTaskControlBlock** %xInternalTaskHandle), !dbg !1812
  store i64 %call1, i64* %xReturn, align 8, !dbg !1813
  %2 = load i64, i64* %xReturn, align 8, !dbg !1814
  %cmp2 = icmp eq i64 %2, 1, !dbg !1816
  br i1 %cmp2, label %land.lhs.true, label %if.else, !dbg !1817

land.lhs.true:                                    ; preds = %if.then
  %3 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1818
  %cmp3 = icmp ne %struct.tskTaskControlBlock* %3, null, !dbg !1819
  br i1 %cmp3, label %if.then4, label %if.else, !dbg !1820

if.then4:                                         ; preds = %land.lhs.true
  %4 = load i32, i32* %lIndex, align 4, !dbg !1821
  %5 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1821
  %6 = bitcast %struct.tskTaskControlBlock* %5 to %struct.OpaqueObject*, !dbg !1821
  call void @MPU_StoreHandleAndDataAtIndex(i32 %4, %struct.OpaqueObject* %6, i8* null, i32 2), !dbg !1821
  %7 = load %struct.tskTaskControlBlock**, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8, !dbg !1823
  %cmp5 = icmp ne %struct.tskTaskControlBlock** %7, null, !dbg !1825
  br i1 %cmp5, label %if.then6, label %if.end, !dbg !1826

if.then6:                                         ; preds = %if.then4
  %8 = load i32, i32* %lIndex, align 4, !dbg !1827
  %add = add nsw i32 %8, 1, !dbg !1827
  %conv = sext i32 %add to i64, !dbg !1829
  %9 = inttoptr i64 %conv to %struct.tskTaskControlBlock*, !dbg !1829
  %10 = load %struct.tskTaskControlBlock**, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8, !dbg !1830
  store %struct.tskTaskControlBlock* %9, %struct.tskTaskControlBlock** %10, align 8, !dbg !1831
  br label %if.end, !dbg !1832

if.end:                                           ; preds = %if.then6, %if.then4
  br label %if.end7, !dbg !1833

if.else:                                          ; preds = %land.lhs.true, %if.then
  %11 = load i32, i32* %lIndex, align 4, !dbg !1834
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %11), !dbg !1836
  br label %if.end7

if.end7:                                          ; preds = %if.else, %if.end
  br label %if.end8, !dbg !1837

if.end8:                                          ; preds = %if.end7, %entry
  %12 = load i64, i64* %xReturn, align 8, !dbg !1838
  ret i64 %12, !dbg !1839
}

declare dso_local i64 @xTaskCreateRestricted(%struct.xTASK_PARAMETERS*, %struct.tskTaskControlBlock**) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskCreateRestrictedStatic(%struct.xTASK_PARAMETERS* %pxTaskDefinition, %struct.tskTaskControlBlock** %pxCreatedTask) #0 section "privileged_functions" !dbg !1840 {
entry:
  %pxTaskDefinition.addr = alloca %struct.xTASK_PARAMETERS*, align 8
  %pxCreatedTask.addr = alloca %struct.tskTaskControlBlock**, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.xTASK_PARAMETERS* %pxTaskDefinition, %struct.xTASK_PARAMETERS** %pxTaskDefinition.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xTASK_PARAMETERS** %pxTaskDefinition.addr, metadata !1841, metadata !DIExpression()), !dbg !1842
  store %struct.tskTaskControlBlock** %pxCreatedTask, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock*** %pxCreatedTask.addr, metadata !1843, metadata !DIExpression()), !dbg !1844
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !1845, metadata !DIExpression()), !dbg !1846
  store i64 0, i64* %xReturn, align 8, !dbg !1846
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1847, metadata !DIExpression()), !dbg !1848
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1849, metadata !DIExpression()), !dbg !1850
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1850
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !1851
  store i32 %call, i32* %lIndex, align 4, !dbg !1852
  %0 = load i32, i32* %lIndex, align 4, !dbg !1853
  %cmp = icmp ne i32 %0, -1, !dbg !1855
  br i1 %cmp, label %if.then, label %if.end8, !dbg !1856

if.then:                                          ; preds = %entry
  %1 = load %struct.xTASK_PARAMETERS*, %struct.xTASK_PARAMETERS** %pxTaskDefinition.addr, align 8, !dbg !1857
  %call1 = call i64 @xTaskCreateRestrictedStatic(%struct.xTASK_PARAMETERS* %1, %struct.tskTaskControlBlock** %xInternalTaskHandle), !dbg !1859
  store i64 %call1, i64* %xReturn, align 8, !dbg !1860
  %2 = load i64, i64* %xReturn, align 8, !dbg !1861
  %cmp2 = icmp eq i64 %2, 1, !dbg !1863
  br i1 %cmp2, label %land.lhs.true, label %if.else, !dbg !1864

land.lhs.true:                                    ; preds = %if.then
  %3 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1865
  %cmp3 = icmp ne %struct.tskTaskControlBlock* %3, null, !dbg !1866
  br i1 %cmp3, label %if.then4, label %if.else, !dbg !1867

if.then4:                                         ; preds = %land.lhs.true
  %4 = load i32, i32* %lIndex, align 4, !dbg !1868
  %5 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1868
  %6 = bitcast %struct.tskTaskControlBlock* %5 to %struct.OpaqueObject*, !dbg !1868
  call void @MPU_StoreHandleAndDataAtIndex(i32 %4, %struct.OpaqueObject* %6, i8* null, i32 2), !dbg !1868
  %7 = load %struct.tskTaskControlBlock**, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8, !dbg !1870
  %cmp5 = icmp ne %struct.tskTaskControlBlock** %7, null, !dbg !1872
  br i1 %cmp5, label %if.then6, label %if.end, !dbg !1873

if.then6:                                         ; preds = %if.then4
  %8 = load i32, i32* %lIndex, align 4, !dbg !1874
  %add = add nsw i32 %8, 1, !dbg !1874
  %conv = sext i32 %add to i64, !dbg !1876
  %9 = inttoptr i64 %conv to %struct.tskTaskControlBlock*, !dbg !1876
  %10 = load %struct.tskTaskControlBlock**, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8, !dbg !1877
  store %struct.tskTaskControlBlock* %9, %struct.tskTaskControlBlock** %10, align 8, !dbg !1878
  br label %if.end, !dbg !1879

if.end:                                           ; preds = %if.then6, %if.then4
  br label %if.end7, !dbg !1880

if.else:                                          ; preds = %land.lhs.true, %if.then
  %11 = load i32, i32* %lIndex, align 4, !dbg !1881
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %11), !dbg !1883
  br label %if.end7

if.end7:                                          ; preds = %if.else, %if.end
  br label %if.end8, !dbg !1884

if.end8:                                          ; preds = %if.end7, %entry
  %12 = load i64, i64* %xReturn, align 8, !dbg !1885
  ret i64 %12, !dbg !1886
}

declare dso_local i64 @xTaskCreateRestrictedStatic(%struct.xTASK_PARAMETERS*, %struct.tskTaskControlBlock**) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTaskAllocateMPURegions(%struct.tskTaskControlBlock* %xTaskToModify, %struct.xMEMORY_REGION* %xRegions) #0 !dbg !1887 {
entry:
  %xTaskToModify.addr = alloca %struct.tskTaskControlBlock*, align 8
  %xRegions.addr = alloca %struct.xMEMORY_REGION*, align 8
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tskTaskControlBlock* %xTaskToModify, %struct.tskTaskControlBlock** %xTaskToModify.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTaskToModify.addr, metadata !1893, metadata !DIExpression()), !dbg !1894
  store %struct.xMEMORY_REGION* %xRegions, %struct.xMEMORY_REGION** %xRegions.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xMEMORY_REGION** %xRegions.addr, metadata !1895, metadata !DIExpression()), !dbg !1896
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1897, metadata !DIExpression()), !dbg !1898
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1898
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1899, metadata !DIExpression()), !dbg !1900
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToModify.addr, align 8, !dbg !1901
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !1903
  br i1 %cmp, label %if.then, label %if.else, !dbg !1904

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToModify.addr, align 8, !dbg !1905
  %2 = load %struct.xMEMORY_REGION*, %struct.xMEMORY_REGION** %xRegions.addr, align 8, !dbg !1907
  call void @vTaskAllocateMPURegions(%struct.tskTaskControlBlock* %1, %struct.xMEMORY_REGION* %2), !dbg !1908
  br label %if.end10, !dbg !1909

if.else:                                          ; preds = %entry
  %3 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToModify.addr, align 8, !dbg !1910
  %4 = ptrtoint %struct.tskTaskControlBlock* %3 to i32, !dbg !1912
  store i32 %4, i32* %lIndex, align 4, !dbg !1913
  %5 = load i32, i32* %lIndex, align 4, !dbg !1914
  %cmp1 = icmp sge i32 %5, 1, !dbg !1914
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !1914

land.rhs:                                         ; preds = %if.else
  %6 = load i32, i32* %lIndex, align 4, !dbg !1914
  %cmp2 = icmp slt i32 %6, 257, !dbg !1914
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %7 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !1916
  %land.ext = zext i1 %7 to i32, !dbg !1914
  %conv = sext i32 %land.ext to i64, !dbg !1914
  %cmp3 = icmp ne i64 %conv, 0, !dbg !1917
  br i1 %cmp3, label %if.then5, label %if.end9, !dbg !1918

if.then5:                                         ; preds = %land.end
  %8 = load i32, i32* %lIndex, align 4, !dbg !1919
  %sub = sub nsw i32 %8, 1, !dbg !1919
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !1919
  %9 = bitcast %struct.OpaqueObject* %call to %struct.tskTaskControlBlock*, !dbg !1919
  store %struct.tskTaskControlBlock* %9, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1921
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1922
  %cmp6 = icmp ne %struct.tskTaskControlBlock* %10, null, !dbg !1924
  br i1 %cmp6, label %if.then8, label %if.end, !dbg !1925

if.then8:                                         ; preds = %if.then5
  %11 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1926
  %12 = load %struct.xMEMORY_REGION*, %struct.xMEMORY_REGION** %xRegions.addr, align 8, !dbg !1928
  call void @vTaskAllocateMPURegions(%struct.tskTaskControlBlock* %11, %struct.xMEMORY_REGION* %12), !dbg !1929
  br label %if.end, !dbg !1930

if.end:                                           ; preds = %if.then8, %if.then5
  br label %if.end9, !dbg !1931

if.end9:                                          ; preds = %if.end, %land.end
  br label %if.end10

if.end10:                                         ; preds = %if.end9, %if.then
  ret void, !dbg !1932
}

declare dso_local void @vTaskAllocateMPURegions(%struct.tskTaskControlBlock*, %struct.xMEMORY_REGION*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskGetStaticBuffers(%struct.tskTaskControlBlock* %xTask, i64** %ppuxStackBuffer, %struct.xSTATIC_TCB** %ppxTaskBuffer) #0 section "privileged_functions" !dbg !1933 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %ppuxStackBuffer.addr = alloca i64**, align 8
  %ppxTaskBuffer.addr = alloca %struct.xSTATIC_TCB**, align 8
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  %lIndex = alloca i32, align 4
  %xReturn = alloca i64, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !1938, metadata !DIExpression()), !dbg !1939
  store i64** %ppuxStackBuffer, i64*** %ppuxStackBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata i64*** %ppuxStackBuffer.addr, metadata !1940, metadata !DIExpression()), !dbg !1941
  store %struct.xSTATIC_TCB** %ppxTaskBuffer, %struct.xSTATIC_TCB*** %ppxTaskBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xSTATIC_TCB*** %ppxTaskBuffer.addr, metadata !1942, metadata !DIExpression()), !dbg !1943
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1944, metadata !DIExpression()), !dbg !1945
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1945
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1946, metadata !DIExpression()), !dbg !1947
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !1948, metadata !DIExpression()), !dbg !1949
  store i64 0, i64* %xReturn, align 8, !dbg !1949
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !1950
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !1952
  br i1 %cmp, label %if.then, label %if.else, !dbg !1953

if.then:                                          ; preds = %entry
  %call = call %struct.tskTaskControlBlock* @xTaskGetCurrentTaskHandle(), !dbg !1954
  store %struct.tskTaskControlBlock* %call, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1956
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1957
  %2 = load i64**, i64*** %ppuxStackBuffer.addr, align 8, !dbg !1958
  %3 = load %struct.xSTATIC_TCB**, %struct.xSTATIC_TCB*** %ppxTaskBuffer.addr, align 8, !dbg !1959
  %call1 = call i64 @xTaskGetStaticBuffers(%struct.tskTaskControlBlock* %1, i64** %2, %struct.xSTATIC_TCB** %3), !dbg !1960
  store i64 %call1, i64* %xReturn, align 8, !dbg !1961
  br label %if.end13, !dbg !1962

if.else:                                          ; preds = %entry
  %4 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !1963
  %5 = ptrtoint %struct.tskTaskControlBlock* %4 to i32, !dbg !1965
  store i32 %5, i32* %lIndex, align 4, !dbg !1966
  %6 = load i32, i32* %lIndex, align 4, !dbg !1967
  %cmp2 = icmp sge i32 %6, 1, !dbg !1967
  br i1 %cmp2, label %land.rhs, label %land.end, !dbg !1967

land.rhs:                                         ; preds = %if.else
  %7 = load i32, i32* %lIndex, align 4, !dbg !1967
  %cmp3 = icmp slt i32 %7, 257, !dbg !1967
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %8 = phi i1 [ false, %if.else ], [ %cmp3, %land.rhs ], !dbg !1969
  %land.ext = zext i1 %8 to i32, !dbg !1967
  %conv = sext i32 %land.ext to i64, !dbg !1967
  %cmp4 = icmp ne i64 %conv, 0, !dbg !1970
  br i1 %cmp4, label %if.then6, label %if.end12, !dbg !1971

if.then6:                                         ; preds = %land.end
  %9 = load i32, i32* %lIndex, align 4, !dbg !1972
  %sub = sub nsw i32 %9, 1, !dbg !1972
  %call7 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !1972
  %10 = bitcast %struct.OpaqueObject* %call7 to %struct.tskTaskControlBlock*, !dbg !1972
  store %struct.tskTaskControlBlock* %10, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1974
  %11 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1975
  %cmp8 = icmp ne %struct.tskTaskControlBlock* %11, null, !dbg !1977
  br i1 %cmp8, label %if.then10, label %if.end, !dbg !1978

if.then10:                                        ; preds = %if.then6
  %12 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1979
  %13 = load i64**, i64*** %ppuxStackBuffer.addr, align 8, !dbg !1981
  %14 = load %struct.xSTATIC_TCB**, %struct.xSTATIC_TCB*** %ppxTaskBuffer.addr, align 8, !dbg !1982
  %call11 = call i64 @xTaskGetStaticBuffers(%struct.tskTaskControlBlock* %12, i64** %13, %struct.xSTATIC_TCB** %14), !dbg !1983
  store i64 %call11, i64* %xReturn, align 8, !dbg !1984
  br label %if.end, !dbg !1985

if.end:                                           ; preds = %if.then10, %if.then6
  br label %if.end12, !dbg !1986

if.end12:                                         ; preds = %if.end, %land.end
  br label %if.end13

if.end13:                                         ; preds = %if.end12, %if.then
  %15 = load i64, i64* %xReturn, align 8, !dbg !1987
  ret i64 %15, !dbg !1988
}

declare dso_local i64 @xTaskGetStaticBuffers(%struct.tskTaskControlBlock*, i64**, %struct.xSTATIC_TCB**) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_uxTaskPriorityGetFromISR(%struct.tskTaskControlBlock* %xTask) #0 section "privileged_functions" !dbg !1989 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %uxReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !1990, metadata !DIExpression()), !dbg !1991
  call void @llvm.dbg.declare(metadata i64* %uxReturn, metadata !1992, metadata !DIExpression()), !dbg !1993
  store i64 5, i64* %uxReturn, align 8, !dbg !1993
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !1994, metadata !DIExpression()), !dbg !1995
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !1996, metadata !DIExpression()), !dbg !1997
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !1997
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !1998
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !2000
  br i1 %cmp, label %if.then, label %if.else, !dbg !2001

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !2002
  %call = call i64 @uxTaskPriorityGetFromISR(%struct.tskTaskControlBlock* %1), !dbg !2004
  store i64 %call, i64* %uxReturn, align 8, !dbg !2005
  br label %if.end12, !dbg !2006

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !2007
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !2009
  store i32 %3, i32* %lIndex, align 4, !dbg !2010
  %4 = load i32, i32* %lIndex, align 4, !dbg !2011
  %cmp1 = icmp sge i32 %4, 1, !dbg !2011
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !2011

land.rhs:                                         ; preds = %if.else
  %5 = load i32, i32* %lIndex, align 4, !dbg !2011
  %cmp2 = icmp slt i32 %5, 257, !dbg !2011
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %6 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !2013
  %land.ext = zext i1 %6 to i32, !dbg !2011
  %conv = sext i32 %land.ext to i64, !dbg !2011
  %cmp3 = icmp ne i64 %conv, 0, !dbg !2014
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !2015

if.then5:                                         ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !2016
  %sub = sub nsw i32 %7, 1, !dbg !2016
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !2016
  %8 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !2016
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2018
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2019
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !2021
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !2022

if.then9:                                         ; preds = %if.then5
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2023
  %call10 = call i64 @uxTaskPriorityGetFromISR(%struct.tskTaskControlBlock* %10), !dbg !2025
  store i64 %call10, i64* %uxReturn, align 8, !dbg !2026
  br label %if.end, !dbg !2027

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !2028

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %11 = load i64, i64* %uxReturn, align 8, !dbg !2029
  ret i64 %11, !dbg !2030
}

declare dso_local i64 @uxTaskPriorityGetFromISR(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskResumeFromISR(%struct.tskTaskControlBlock* %xTaskToResume) #0 section "privileged_functions" !dbg !2031 {
entry:
  %xTaskToResume.addr = alloca %struct.tskTaskControlBlock*, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTaskToResume, %struct.tskTaskControlBlock** %xTaskToResume.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTaskToResume.addr, metadata !2032, metadata !DIExpression()), !dbg !2033
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !2034, metadata !DIExpression()), !dbg !2035
  store i64 0, i64* %xReturn, align 8, !dbg !2035
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2036, metadata !DIExpression()), !dbg !2037
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !2038, metadata !DIExpression()), !dbg !2039
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2039
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToResume.addr, align 8, !dbg !2040
  %1 = ptrtoint %struct.tskTaskControlBlock* %0 to i32, !dbg !2041
  store i32 %1, i32* %lIndex, align 4, !dbg !2042
  %2 = load i32, i32* %lIndex, align 4, !dbg !2043
  %cmp = icmp sge i32 %2, 1, !dbg !2043
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2043

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2043
  %cmp1 = icmp slt i32 %3, 257, !dbg !2043
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2045
  %land.ext = zext i1 %4 to i32, !dbg !2043
  %conv = sext i32 %land.ext to i64, !dbg !2043
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2046
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !2047

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2048
  %sub = sub nsw i32 %5, 1, !dbg !2048
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !2048
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tskTaskControlBlock*, !dbg !2048
  store %struct.tskTaskControlBlock* %6, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2050
  %7 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2051
  %cmp4 = icmp ne %struct.tskTaskControlBlock* %7, null, !dbg !2053
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !2054

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2055
  %call7 = call i64 @xTaskResumeFromISR(%struct.tskTaskControlBlock* %8), !dbg !2057
  store i64 %call7, i64* %xReturn, align 8, !dbg !2058
  br label %if.end, !dbg !2059

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !2060

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !2061
  ret i64 %9, !dbg !2062
}

declare dso_local i64 @xTaskResumeFromISR(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 (i8*)* @MPU_xTaskGetApplicationTaskTagFromISR(%struct.tskTaskControlBlock* %xTask) #0 section "privileged_functions" !dbg !2063 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %xReturn = alloca i64 (i8*)*, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !2064, metadata !DIExpression()), !dbg !2065
  call void @llvm.dbg.declare(metadata i64 (i8*)** %xReturn, metadata !2066, metadata !DIExpression()), !dbg !2067
  store i64 (i8*)* null, i64 (i8*)** %xReturn, align 8, !dbg !2067
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2068, metadata !DIExpression()), !dbg !2069
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !2070, metadata !DIExpression()), !dbg !2071
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2071
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !2072
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !2074
  br i1 %cmp, label %if.then, label %if.else, !dbg !2075

if.then:                                          ; preds = %entry
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !2076
  %call = call i64 (i8*)* @xTaskGetApplicationTaskTagFromISR(%struct.tskTaskControlBlock* %1), !dbg !2078
  store i64 (i8*)* %call, i64 (i8*)** %xReturn, align 8, !dbg !2079
  br label %if.end12, !dbg !2080

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !2081
  %3 = ptrtoint %struct.tskTaskControlBlock* %2 to i32, !dbg !2083
  store i32 %3, i32* %lIndex, align 4, !dbg !2084
  %4 = load i32, i32* %lIndex, align 4, !dbg !2085
  %cmp1 = icmp sge i32 %4, 1, !dbg !2085
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !2085

land.rhs:                                         ; preds = %if.else
  %5 = load i32, i32* %lIndex, align 4, !dbg !2085
  %cmp2 = icmp slt i32 %5, 257, !dbg !2085
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %6 = phi i1 [ false, %if.else ], [ %cmp2, %land.rhs ], !dbg !2087
  %land.ext = zext i1 %6 to i32, !dbg !2085
  %conv = sext i32 %land.ext to i64, !dbg !2085
  %cmp3 = icmp ne i64 %conv, 0, !dbg !2088
  br i1 %cmp3, label %if.then5, label %if.end11, !dbg !2089

if.then5:                                         ; preds = %land.end
  %7 = load i32, i32* %lIndex, align 4, !dbg !2090
  %sub = sub nsw i32 %7, 1, !dbg !2090
  %call6 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !2090
  %8 = bitcast %struct.OpaqueObject* %call6 to %struct.tskTaskControlBlock*, !dbg !2090
  store %struct.tskTaskControlBlock* %8, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2092
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2093
  %cmp7 = icmp ne %struct.tskTaskControlBlock* %9, null, !dbg !2095
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !2096

if.then9:                                         ; preds = %if.then5
  %10 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2097
  %call10 = call i64 (i8*)* @xTaskGetApplicationTaskTagFromISR(%struct.tskTaskControlBlock* %10), !dbg !2099
  store i64 (i8*)* %call10, i64 (i8*)** %xReturn, align 8, !dbg !2100
  br label %if.end, !dbg !2101

if.end:                                           ; preds = %if.then9, %if.then5
  br label %if.end11, !dbg !2102

if.end11:                                         ; preds = %if.end, %land.end
  br label %if.end12

if.end12:                                         ; preds = %if.end11, %if.then
  %11 = load i64 (i8*)*, i64 (i8*)** %xReturn, align 8, !dbg !2103
  ret i64 (i8*)* %11, !dbg !2104
}

declare dso_local i64 (i8*)* @xTaskGetApplicationTaskTagFromISR(%struct.tskTaskControlBlock*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTaskGenericNotifyFromISR(%struct.tskTaskControlBlock* %xTaskToNotify, i64 %uxIndexToNotify, i32 %ulValue, i32 %eAction, i32* %pulPreviousNotificationValue, i64* %pxHigherPriorityTaskWoken) #0 section "privileged_functions" !dbg !2105 {
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
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTaskToNotify.addr, metadata !2109, metadata !DIExpression()), !dbg !2110
  store i64 %uxIndexToNotify, i64* %uxIndexToNotify.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxIndexToNotify.addr, metadata !2111, metadata !DIExpression()), !dbg !2112
  store i32 %ulValue, i32* %ulValue.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %ulValue.addr, metadata !2113, metadata !DIExpression()), !dbg !2114
  store i32 %eAction, i32* %eAction.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %eAction.addr, metadata !2115, metadata !DIExpression()), !dbg !2116
  store i32* %pulPreviousNotificationValue, i32** %pulPreviousNotificationValue.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %pulPreviousNotificationValue.addr, metadata !2117, metadata !DIExpression()), !dbg !2118
  store i64* %pxHigherPriorityTaskWoken, i64** %pxHigherPriorityTaskWoken.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxHigherPriorityTaskWoken.addr, metadata !2119, metadata !DIExpression()), !dbg !2120
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !2121, metadata !DIExpression()), !dbg !2122
  store i64 0, i64* %xReturn, align 8, !dbg !2122
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2123, metadata !DIExpression()), !dbg !2124
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !2125, metadata !DIExpression()), !dbg !2126
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2126
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToNotify.addr, align 8, !dbg !2127
  %1 = ptrtoint %struct.tskTaskControlBlock* %0 to i32, !dbg !2128
  store i32 %1, i32* %lIndex, align 4, !dbg !2129
  %2 = load i32, i32* %lIndex, align 4, !dbg !2130
  %cmp = icmp sge i32 %2, 1, !dbg !2130
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2130

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2130
  %cmp1 = icmp slt i32 %3, 257, !dbg !2130
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2132
  %land.ext = zext i1 %4 to i32, !dbg !2130
  %conv = sext i32 %land.ext to i64, !dbg !2130
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2133
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !2134

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2135
  %sub = sub nsw i32 %5, 1, !dbg !2135
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !2135
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tskTaskControlBlock*, !dbg !2135
  store %struct.tskTaskControlBlock* %6, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2137
  %7 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2138
  %cmp4 = icmp ne %struct.tskTaskControlBlock* %7, null, !dbg !2140
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !2141

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2142
  %9 = load i64, i64* %uxIndexToNotify.addr, align 8, !dbg !2144
  %10 = load i32, i32* %ulValue.addr, align 4, !dbg !2145
  %11 = load i32, i32* %eAction.addr, align 4, !dbg !2146
  %12 = load i32*, i32** %pulPreviousNotificationValue.addr, align 8, !dbg !2147
  %13 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !2148
  %call7 = call i64 @xTaskGenericNotifyFromISR(%struct.tskTaskControlBlock* %8, i64 %9, i32 %10, i32 %11, i32* %12, i64* %13), !dbg !2149
  store i64 %call7, i64* %xReturn, align 8, !dbg !2150
  br label %if.end, !dbg !2151

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !2152

if.end8:                                          ; preds = %if.end, %land.end
  %14 = load i64, i64* %xReturn, align 8, !dbg !2153
  ret i64 %14, !dbg !2154
}

declare dso_local i64 @xTaskGenericNotifyFromISR(%struct.tskTaskControlBlock*, i64, i32, i32, i32*, i64*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTaskGenericNotifyGiveFromISR(%struct.tskTaskControlBlock* %xTaskToNotify, i64 %uxIndexToNotify, i64* %pxHigherPriorityTaskWoken) #0 section "privileged_functions" !dbg !2155 {
entry:
  %xTaskToNotify.addr = alloca %struct.tskTaskControlBlock*, align 8
  %uxIndexToNotify.addr = alloca i64, align 8
  %pxHigherPriorityTaskWoken.addr = alloca i64*, align 8
  %lIndex = alloca i32, align 4
  %xInternalTaskHandle = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTaskToNotify, %struct.tskTaskControlBlock** %xTaskToNotify.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTaskToNotify.addr, metadata !2158, metadata !DIExpression()), !dbg !2159
  store i64 %uxIndexToNotify, i64* %uxIndexToNotify.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxIndexToNotify.addr, metadata !2160, metadata !DIExpression()), !dbg !2161
  store i64* %pxHigherPriorityTaskWoken, i64** %pxHigherPriorityTaskWoken.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxHigherPriorityTaskWoken.addr, metadata !2162, metadata !DIExpression()), !dbg !2163
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2164, metadata !DIExpression()), !dbg !2165
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xInternalTaskHandle, metadata !2166, metadata !DIExpression()), !dbg !2167
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2167
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToNotify.addr, align 8, !dbg !2168
  %1 = ptrtoint %struct.tskTaskControlBlock* %0 to i32, !dbg !2169
  store i32 %1, i32* %lIndex, align 4, !dbg !2170
  %2 = load i32, i32* %lIndex, align 4, !dbg !2171
  %cmp = icmp sge i32 %2, 1, !dbg !2171
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2171

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2171
  %cmp1 = icmp slt i32 %3, 257, !dbg !2171
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2173
  %land.ext = zext i1 %4 to i32, !dbg !2171
  %conv = sext i32 %land.ext to i64, !dbg !2171
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2174
  br i1 %cmp2, label %if.then, label %if.end7, !dbg !2175

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2176
  %sub = sub nsw i32 %5, 1, !dbg !2176
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 2), !dbg !2176
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tskTaskControlBlock*, !dbg !2176
  store %struct.tskTaskControlBlock* %6, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2178
  %7 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2179
  %cmp4 = icmp ne %struct.tskTaskControlBlock* %7, null, !dbg !2181
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !2182

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xInternalTaskHandle, align 8, !dbg !2183
  %9 = load i64, i64* %uxIndexToNotify.addr, align 8, !dbg !2185
  %10 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !2186
  call void @vTaskGenericNotifyGiveFromISR(%struct.tskTaskControlBlock* %8, i64 %9, i64* %10), !dbg !2187
  br label %if.end, !dbg !2188

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end7, !dbg !2189

if.end7:                                          ; preds = %if.end, %land.end
  ret void, !dbg !2190
}

declare dso_local void @vTaskGenericNotifyGiveFromISR(%struct.tskTaskControlBlock*, i64, i64*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueGenericSendImpl(%struct.QueueDefinition* %xQueue, i8* %pvItemToQueue, i64 %xTicksToWait, i64 %xCopyPosition) #0 section "privileged_functions" !dbg !2191 {
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
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !2197, metadata !DIExpression()), !dbg !2198
  store i8* %pvItemToQueue, i8** %pvItemToQueue.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvItemToQueue.addr, metadata !2199, metadata !DIExpression()), !dbg !2200
  store i64 %xTicksToWait, i64* %xTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToWait.addr, metadata !2201, metadata !DIExpression()), !dbg !2202
  store i64 %xCopyPosition, i64* %xCopyPosition.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xCopyPosition.addr, metadata !2203, metadata !DIExpression()), !dbg !2204
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2205, metadata !DIExpression()), !dbg !2206
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2207, metadata !DIExpression()), !dbg !2208
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2208
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !2209, metadata !DIExpression()), !dbg !2210
  store i64 0, i64* %xReturn, align 8, !dbg !2210
  call void @llvm.dbg.declare(metadata i64* %xIsItemToQueueReadable, metadata !2211, metadata !DIExpression()), !dbg !2212
  store i64 0, i64* %xIsItemToQueueReadable, align 8, !dbg !2212
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !2213
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2214
  store i32 %1, i32* %lIndex, align 4, !dbg !2215
  %2 = load i32, i32* %lIndex, align 4, !dbg !2216
  %cmp = icmp sge i32 %2, 1, !dbg !2216
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2216

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2216
  %cmp1 = icmp slt i32 %3, 257, !dbg !2216
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2218
  %land.ext = zext i1 %4 to i32, !dbg !2216
  %conv = sext i32 %land.ext to i64, !dbg !2216
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2219
  br i1 %cmp2, label %if.then, label %if.end21, !dbg !2220

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2221
  %sub = sub nsw i32 %5, 1, !dbg !2221
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2221
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2221
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2223
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2224
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2226
  br i1 %cmp4, label %if.then6, label %if.end20, !dbg !2227

if.then6:                                         ; preds = %if.then
  %8 = load i8*, i8** %pvItemToQueue.addr, align 8, !dbg !2228
  %cmp7 = icmp ne i8* %8, null, !dbg !2231
  br i1 %cmp7, label %if.then9, label %if.end, !dbg !2232

if.then9:                                         ; preds = %if.then6
  %9 = load i8*, i8** %pvItemToQueue.addr, align 8, !dbg !2233
  %10 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2235
  %call10 = call i64 @uxQueueGetQueueItemSize(%struct.QueueDefinition* %10), !dbg !2236
  %conv11 = trunc i64 %call10 to i32, !dbg !2236
  %call12 = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %9, i32 %conv11, i32 1), !dbg !2237
  store i64 %call12, i64* %xIsItemToQueueReadable, align 8, !dbg !2238
  br label %if.end, !dbg !2239

if.end:                                           ; preds = %if.then9, %if.then6
  %11 = load i8*, i8** %pvItemToQueue.addr, align 8, !dbg !2240
  %cmp13 = icmp eq i8* %11, null, !dbg !2242
  br i1 %cmp13, label %if.then17, label %lor.lhs.false, !dbg !2243

lor.lhs.false:                                    ; preds = %if.end
  %12 = load i64, i64* %xIsItemToQueueReadable, align 8, !dbg !2244
  %cmp15 = icmp eq i64 %12, 1, !dbg !2245
  br i1 %cmp15, label %if.then17, label %if.end19, !dbg !2246

if.then17:                                        ; preds = %lor.lhs.false, %if.end
  %13 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2247
  %14 = load i8*, i8** %pvItemToQueue.addr, align 8, !dbg !2249
  %15 = load i64, i64* %xTicksToWait.addr, align 8, !dbg !2250
  %16 = load i64, i64* %xCopyPosition.addr, align 8, !dbg !2251
  %call18 = call i64 @xQueueGenericSend(%struct.QueueDefinition* %13, i8* %14, i64 %15, i64 %16), !dbg !2252
  store i64 %call18, i64* %xReturn, align 8, !dbg !2253
  br label %if.end19, !dbg !2254

if.end19:                                         ; preds = %if.then17, %lor.lhs.false
  br label %if.end20, !dbg !2255

if.end20:                                         ; preds = %if.end19, %if.then
  br label %if.end21, !dbg !2256

if.end21:                                         ; preds = %if.end20, %land.end
  %17 = load i64, i64* %xReturn, align 8, !dbg !2257
  ret i64 %17, !dbg !2258
}

declare dso_local i64 @uxQueueGetQueueItemSize(%struct.QueueDefinition*) #2 section "privileged_functions"

declare dso_local i64 @xQueueGenericSend(%struct.QueueDefinition*, i8*, i64, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_uxQueueMessagesWaitingImpl(%struct.QueueDefinition* %pxQueue) #0 section "privileged_functions" !dbg !2259 {
entry:
  %pxQueue.addr = alloca %struct.QueueDefinition*, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %uxReturn = alloca i64, align 8
  store %struct.QueueDefinition* %pxQueue, %struct.QueueDefinition** %pxQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %pxQueue.addr, metadata !2263, metadata !DIExpression()), !dbg !2264
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2265, metadata !DIExpression()), !dbg !2266
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2267, metadata !DIExpression()), !dbg !2268
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2268
  call void @llvm.dbg.declare(metadata i64* %uxReturn, metadata !2269, metadata !DIExpression()), !dbg !2270
  store i64 0, i64* %uxReturn, align 8, !dbg !2270
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %pxQueue.addr, align 8, !dbg !2271
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2272
  store i32 %1, i32* %lIndex, align 4, !dbg !2273
  %2 = load i32, i32* %lIndex, align 4, !dbg !2274
  %cmp = icmp sge i32 %2, 1, !dbg !2274
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2274

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2274
  %cmp1 = icmp slt i32 %3, 257, !dbg !2274
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2276
  %land.ext = zext i1 %4 to i32, !dbg !2274
  %conv = sext i32 %land.ext to i64, !dbg !2274
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2277
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !2278

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2279
  %sub = sub nsw i32 %5, 1, !dbg !2279
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2279
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2279
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2281
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2282
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2284
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !2285

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2286
  %call7 = call i64 @uxQueueMessagesWaiting(%struct.QueueDefinition* %8), !dbg !2288
  store i64 %call7, i64* %uxReturn, align 8, !dbg !2289
  br label %if.end, !dbg !2290

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !2291

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %uxReturn, align 8, !dbg !2292
  ret i64 %9, !dbg !2293
}

declare dso_local i64 @uxQueueMessagesWaiting(%struct.QueueDefinition*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_uxQueueSpacesAvailableImpl(%struct.QueueDefinition* %xQueue) #0 section "privileged_functions" !dbg !2294 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %uxReturn = alloca i64, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !2295, metadata !DIExpression()), !dbg !2296
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2297, metadata !DIExpression()), !dbg !2298
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2299, metadata !DIExpression()), !dbg !2300
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2300
  call void @llvm.dbg.declare(metadata i64* %uxReturn, metadata !2301, metadata !DIExpression()), !dbg !2302
  store i64 0, i64* %uxReturn, align 8, !dbg !2302
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !2303
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2304
  store i32 %1, i32* %lIndex, align 4, !dbg !2305
  %2 = load i32, i32* %lIndex, align 4, !dbg !2306
  %cmp = icmp sge i32 %2, 1, !dbg !2306
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2306

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2306
  %cmp1 = icmp slt i32 %3, 257, !dbg !2306
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2308
  %land.ext = zext i1 %4 to i32, !dbg !2306
  %conv = sext i32 %land.ext to i64, !dbg !2306
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2309
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !2310

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2311
  %sub = sub nsw i32 %5, 1, !dbg !2311
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2311
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2311
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2313
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2314
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2316
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !2317

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2318
  %call7 = call i64 @uxQueueSpacesAvailable(%struct.QueueDefinition* %8), !dbg !2320
  store i64 %call7, i64* %uxReturn, align 8, !dbg !2321
  br label %if.end, !dbg !2322

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !2323

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %uxReturn, align 8, !dbg !2324
  ret i64 %9, !dbg !2325
}

declare dso_local i64 @uxQueueSpacesAvailable(%struct.QueueDefinition*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueReceiveImpl(%struct.QueueDefinition* %pxQueue, i8* %pvBuffer, i64 %xTicksToWait) #0 section "privileged_functions" !dbg !2326 {
entry:
  %pxQueue.addr = alloca %struct.QueueDefinition*, align 8
  %pvBuffer.addr = alloca i8*, align 8
  %xTicksToWait.addr = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %xReturn = alloca i64, align 8
  %xIsReceiveBufferWritable = alloca i64, align 8
  store %struct.QueueDefinition* %pxQueue, %struct.QueueDefinition** %pxQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %pxQueue.addr, metadata !2329, metadata !DIExpression()), !dbg !2330
  store i8* %pvBuffer, i8** %pvBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvBuffer.addr, metadata !2331, metadata !DIExpression()), !dbg !2332
  store i64 %xTicksToWait, i64* %xTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToWait.addr, metadata !2333, metadata !DIExpression()), !dbg !2334
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2335, metadata !DIExpression()), !dbg !2336
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2337, metadata !DIExpression()), !dbg !2338
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2338
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !2339, metadata !DIExpression()), !dbg !2340
  store i64 0, i64* %xReturn, align 8, !dbg !2340
  call void @llvm.dbg.declare(metadata i64* %xIsReceiveBufferWritable, metadata !2341, metadata !DIExpression()), !dbg !2342
  store i64 0, i64* %xIsReceiveBufferWritable, align 8, !dbg !2342
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %pxQueue.addr, align 8, !dbg !2343
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2344
  store i32 %1, i32* %lIndex, align 4, !dbg !2345
  %2 = load i32, i32* %lIndex, align 4, !dbg !2346
  %cmp = icmp sge i32 %2, 1, !dbg !2346
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2346

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2346
  %cmp1 = icmp slt i32 %3, 257, !dbg !2346
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2348
  %land.ext = zext i1 %4 to i32, !dbg !2346
  %conv = sext i32 %land.ext to i64, !dbg !2346
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2349
  br i1 %cmp2, label %if.then, label %if.end15, !dbg !2350

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2351
  %sub = sub nsw i32 %5, 1, !dbg !2351
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2351
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2351
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2353
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2354
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2356
  br i1 %cmp4, label %if.then6, label %if.end14, !dbg !2357

if.then6:                                         ; preds = %if.then
  %8 = load i8*, i8** %pvBuffer.addr, align 8, !dbg !2358
  %9 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2360
  %call7 = call i64 @uxQueueGetQueueItemSize(%struct.QueueDefinition* %9), !dbg !2361
  %conv8 = trunc i64 %call7 to i32, !dbg !2361
  %call9 = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %8, i32 %conv8, i32 2), !dbg !2362
  store i64 %call9, i64* %xIsReceiveBufferWritable, align 8, !dbg !2363
  %10 = load i64, i64* %xIsReceiveBufferWritable, align 8, !dbg !2364
  %cmp10 = icmp eq i64 %10, 1, !dbg !2366
  br i1 %cmp10, label %if.then12, label %if.end, !dbg !2367

if.then12:                                        ; preds = %if.then6
  %11 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2368
  %12 = load i8*, i8** %pvBuffer.addr, align 8, !dbg !2370
  %13 = load i64, i64* %xTicksToWait.addr, align 8, !dbg !2371
  %call13 = call i64 @xQueueReceive(%struct.QueueDefinition* %11, i8* %12, i64 %13), !dbg !2372
  store i64 %call13, i64* %xReturn, align 8, !dbg !2373
  br label %if.end, !dbg !2374

if.end:                                           ; preds = %if.then12, %if.then6
  br label %if.end14, !dbg !2375

if.end14:                                         ; preds = %if.end, %if.then
  br label %if.end15, !dbg !2376

if.end15:                                         ; preds = %if.end14, %land.end
  %14 = load i64, i64* %xReturn, align 8, !dbg !2377
  ret i64 %14, !dbg !2378
}

declare dso_local i64 @xQueueReceive(%struct.QueueDefinition*, i8*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueuePeekImpl(%struct.QueueDefinition* %xQueue, i8* %pvBuffer, i64 %xTicksToWait) #0 section "privileged_functions" !dbg !2379 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %pvBuffer.addr = alloca i8*, align 8
  %xTicksToWait.addr = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %xReturn = alloca i64, align 8
  %xIsReceiveBufferWritable = alloca i64, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !2380, metadata !DIExpression()), !dbg !2381
  store i8* %pvBuffer, i8** %pvBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvBuffer.addr, metadata !2382, metadata !DIExpression()), !dbg !2383
  store i64 %xTicksToWait, i64* %xTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToWait.addr, metadata !2384, metadata !DIExpression()), !dbg !2385
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2386, metadata !DIExpression()), !dbg !2387
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2388, metadata !DIExpression()), !dbg !2389
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2389
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !2390, metadata !DIExpression()), !dbg !2391
  store i64 0, i64* %xReturn, align 8, !dbg !2391
  call void @llvm.dbg.declare(metadata i64* %xIsReceiveBufferWritable, metadata !2392, metadata !DIExpression()), !dbg !2393
  store i64 0, i64* %xIsReceiveBufferWritable, align 8, !dbg !2393
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !2394
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2395
  store i32 %1, i32* %lIndex, align 4, !dbg !2396
  %2 = load i32, i32* %lIndex, align 4, !dbg !2397
  %cmp = icmp sge i32 %2, 1, !dbg !2397
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2397

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2397
  %cmp1 = icmp slt i32 %3, 257, !dbg !2397
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2399
  %land.ext = zext i1 %4 to i32, !dbg !2397
  %conv = sext i32 %land.ext to i64, !dbg !2397
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2400
  br i1 %cmp2, label %if.then, label %if.end15, !dbg !2401

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2402
  %sub = sub nsw i32 %5, 1, !dbg !2402
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2402
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2402
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2404
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2405
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2407
  br i1 %cmp4, label %if.then6, label %if.end14, !dbg !2408

if.then6:                                         ; preds = %if.then
  %8 = load i8*, i8** %pvBuffer.addr, align 8, !dbg !2409
  %9 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2411
  %call7 = call i64 @uxQueueGetQueueItemSize(%struct.QueueDefinition* %9), !dbg !2412
  %conv8 = trunc i64 %call7 to i32, !dbg !2412
  %call9 = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %8, i32 %conv8, i32 2), !dbg !2413
  store i64 %call9, i64* %xIsReceiveBufferWritable, align 8, !dbg !2414
  %10 = load i64, i64* %xIsReceiveBufferWritable, align 8, !dbg !2415
  %cmp10 = icmp eq i64 %10, 1, !dbg !2417
  br i1 %cmp10, label %if.then12, label %if.end, !dbg !2418

if.then12:                                        ; preds = %if.then6
  %11 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2419
  %12 = load i8*, i8** %pvBuffer.addr, align 8, !dbg !2421
  %13 = load i64, i64* %xTicksToWait.addr, align 8, !dbg !2422
  %call13 = call i64 @xQueuePeek(%struct.QueueDefinition* %11, i8* %12, i64 %13), !dbg !2423
  store i64 %call13, i64* %xReturn, align 8, !dbg !2424
  br label %if.end, !dbg !2425

if.end:                                           ; preds = %if.then12, %if.then6
  br label %if.end14, !dbg !2426

if.end14:                                         ; preds = %if.end, %if.then
  br label %if.end15, !dbg !2427

if.end15:                                         ; preds = %if.end14, %land.end
  %14 = load i64, i64* %xReturn, align 8, !dbg !2428
  ret i64 %14, !dbg !2429
}

declare dso_local i64 @xQueuePeek(%struct.QueueDefinition*, i8*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueSemaphoreTakeImpl(%struct.QueueDefinition* %xQueue, i64 %xTicksToWait) #0 section "privileged_functions" !dbg !2430 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %xTicksToWait.addr = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %xReturn = alloca i64, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !2433, metadata !DIExpression()), !dbg !2434
  store i64 %xTicksToWait, i64* %xTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToWait.addr, metadata !2435, metadata !DIExpression()), !dbg !2436
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2437, metadata !DIExpression()), !dbg !2438
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2439, metadata !DIExpression()), !dbg !2440
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2440
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !2441, metadata !DIExpression()), !dbg !2442
  store i64 0, i64* %xReturn, align 8, !dbg !2442
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !2443
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2444
  store i32 %1, i32* %lIndex, align 4, !dbg !2445
  %2 = load i32, i32* %lIndex, align 4, !dbg !2446
  %cmp = icmp sge i32 %2, 1, !dbg !2446
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2446

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2446
  %cmp1 = icmp slt i32 %3, 257, !dbg !2446
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2448
  %land.ext = zext i1 %4 to i32, !dbg !2446
  %conv = sext i32 %land.ext to i64, !dbg !2446
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2449
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !2450

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2451
  %sub = sub nsw i32 %5, 1, !dbg !2451
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2451
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2451
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2453
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2454
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2456
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !2457

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2458
  %9 = load i64, i64* %xTicksToWait.addr, align 8, !dbg !2460
  %call7 = call i64 @xQueueSemaphoreTake(%struct.QueueDefinition* %8, i64 %9), !dbg !2461
  store i64 %call7, i64* %xReturn, align 8, !dbg !2462
  br label %if.end, !dbg !2463

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !2464

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !2465
  ret i64 %10, !dbg !2466
}

declare dso_local i64 @xQueueSemaphoreTake(%struct.QueueDefinition*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.QueueDefinition* @MPU_xQueueSelectFromSetImpl(%struct.QueueDefinition* %xQueueSet, i64 %xBlockTimeTicks) #0 section "privileged_functions" !dbg !2467 {
entry:
  %xQueueSet.addr = alloca %struct.QueueDefinition*, align 8
  %xBlockTimeTicks.addr = alloca i64, align 8
  %xInternalQueueSetHandle = alloca %struct.QueueDefinition*, align 8
  %xSelectedMemberInternal = alloca %struct.QueueDefinition*, align 8
  %xSelectedMemberExternal = alloca %struct.QueueDefinition*, align 8
  %lIndexQueueSet = alloca i32, align 4
  %lIndexSelectedMember = alloca i32, align 4
  store %struct.QueueDefinition* %xQueueSet, %struct.QueueDefinition** %xQueueSet.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueueSet.addr, metadata !2470, metadata !DIExpression()), !dbg !2471
  store i64 %xBlockTimeTicks, i64* %xBlockTimeTicks.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xBlockTimeTicks.addr, metadata !2472, metadata !DIExpression()), !dbg !2473
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueSetHandle, metadata !2474, metadata !DIExpression()), !dbg !2475
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !2475
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xSelectedMemberInternal, metadata !2476, metadata !DIExpression()), !dbg !2477
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xSelectedMemberInternal, align 8, !dbg !2477
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xSelectedMemberExternal, metadata !2478, metadata !DIExpression()), !dbg !2479
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xSelectedMemberExternal, align 8, !dbg !2479
  call void @llvm.dbg.declare(metadata i32* %lIndexQueueSet, metadata !2480, metadata !DIExpression()), !dbg !2481
  call void @llvm.dbg.declare(metadata i32* %lIndexSelectedMember, metadata !2482, metadata !DIExpression()), !dbg !2483
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueueSet.addr, align 8, !dbg !2484
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2485
  store i32 %1, i32* %lIndexQueueSet, align 4, !dbg !2486
  %2 = load i32, i32* %lIndexQueueSet, align 4, !dbg !2487
  %cmp = icmp sge i32 %2, 1, !dbg !2487
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2487

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndexQueueSet, align 4, !dbg !2487
  %cmp1 = icmp slt i32 %3, 257, !dbg !2487
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2489
  %land.ext = zext i1 %4 to i32, !dbg !2487
  %conv = sext i32 %land.ext to i64, !dbg !2487
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2490
  br i1 %cmp2, label %if.then, label %if.end18, !dbg !2491

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndexQueueSet, align 4, !dbg !2492
  %sub = sub nsw i32 %5, 1, !dbg !2492
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2492
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2492
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !2494
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !2495
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2497
  br i1 %cmp4, label %if.then6, label %if.end17, !dbg !2498

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !2499
  %9 = load i64, i64* %xBlockTimeTicks.addr, align 8, !dbg !2501
  %call7 = call %struct.QueueDefinition* @xQueueSelectFromSet(%struct.QueueDefinition* %8, i64 %9), !dbg !2502
  store %struct.QueueDefinition* %call7, %struct.QueueDefinition** %xSelectedMemberInternal, align 8, !dbg !2503
  %10 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xSelectedMemberInternal, align 8, !dbg !2504
  %cmp8 = icmp ne %struct.QueueDefinition* %10, null, !dbg !2506
  br i1 %cmp8, label %if.then10, label %if.end16, !dbg !2507

if.then10:                                        ; preds = %if.then6
  %11 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xSelectedMemberInternal, align 8, !dbg !2508
  %12 = bitcast %struct.QueueDefinition* %11 to %struct.OpaqueObject*, !dbg !2508
  %call11 = call i32 @MPU_GetIndexForHandle(%struct.OpaqueObject* %12, i32 1), !dbg !2508
  store i32 %call11, i32* %lIndexSelectedMember, align 4, !dbg !2510
  %13 = load i32, i32* %lIndexSelectedMember, align 4, !dbg !2511
  %cmp12 = icmp ne i32 %13, -1, !dbg !2513
  br i1 %cmp12, label %if.then14, label %if.end, !dbg !2514

if.then14:                                        ; preds = %if.then10
  %14 = load i32, i32* %lIndexSelectedMember, align 4, !dbg !2515
  %add = add nsw i32 %14, 1, !dbg !2515
  %conv15 = sext i32 %add to i64, !dbg !2517
  %15 = inttoptr i64 %conv15 to %struct.QueueDefinition*, !dbg !2517
  store %struct.QueueDefinition* %15, %struct.QueueDefinition** %xSelectedMemberExternal, align 8, !dbg !2518
  br label %if.end, !dbg !2519

if.end:                                           ; preds = %if.then14, %if.then10
  br label %if.end16, !dbg !2520

if.end16:                                         ; preds = %if.end, %if.then6
  br label %if.end17, !dbg !2521

if.end17:                                         ; preds = %if.end16, %if.then
  br label %if.end18, !dbg !2522

if.end18:                                         ; preds = %if.end17, %land.end
  %16 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xSelectedMemberExternal, align 8, !dbg !2523
  ret %struct.QueueDefinition* %16, !dbg !2524
}

declare dso_local %struct.QueueDefinition* @xQueueSelectFromSet(%struct.QueueDefinition*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueAddToSetImpl(%struct.QueueDefinition* %xQueueOrSemaphore, %struct.QueueDefinition* %xQueueSet) #0 section "privileged_functions" !dbg !2525 {
entry:
  %xQueueOrSemaphore.addr = alloca %struct.QueueDefinition*, align 8
  %xQueueSet.addr = alloca %struct.QueueDefinition*, align 8
  %xReturn = alloca i64, align 8
  %xInternalQueueSetMemberHandle = alloca %struct.QueueDefinition*, align 8
  %xInternalQueueSetHandle = alloca %struct.QueueDefinition*, align 8
  %lIndexQueueSet = alloca i32, align 4
  %lIndexQueueSetMember = alloca i32, align 4
  store %struct.QueueDefinition* %xQueueOrSemaphore, %struct.QueueDefinition** %xQueueOrSemaphore.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueueOrSemaphore.addr, metadata !2528, metadata !DIExpression()), !dbg !2529
  store %struct.QueueDefinition* %xQueueSet, %struct.QueueDefinition** %xQueueSet.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueueSet.addr, metadata !2530, metadata !DIExpression()), !dbg !2531
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !2532, metadata !DIExpression()), !dbg !2533
  store i64 0, i64* %xReturn, align 8, !dbg !2533
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueSetMemberHandle, metadata !2534, metadata !DIExpression()), !dbg !2535
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueSetMemberHandle, align 8, !dbg !2535
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueSetHandle, metadata !2536, metadata !DIExpression()), !dbg !2537
  call void @llvm.dbg.declare(metadata i32* %lIndexQueueSet, metadata !2538, metadata !DIExpression()), !dbg !2539
  call void @llvm.dbg.declare(metadata i32* %lIndexQueueSetMember, metadata !2540, metadata !DIExpression()), !dbg !2541
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueueSet.addr, align 8, !dbg !2542
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2543
  store i32 %1, i32* %lIndexQueueSet, align 4, !dbg !2544
  %2 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueueOrSemaphore.addr, align 8, !dbg !2545
  %3 = ptrtoint %struct.QueueDefinition* %2 to i32, !dbg !2546
  store i32 %3, i32* %lIndexQueueSetMember, align 4, !dbg !2547
  %4 = load i32, i32* %lIndexQueueSet, align 4, !dbg !2548
  %cmp = icmp sge i32 %4, 1, !dbg !2548
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2548

land.rhs:                                         ; preds = %entry
  %5 = load i32, i32* %lIndexQueueSet, align 4, !dbg !2548
  %cmp1 = icmp slt i32 %5, 257, !dbg !2548
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %6 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2550
  %land.ext = zext i1 %6 to i32, !dbg !2548
  %conv = sext i32 %land.ext to i64, !dbg !2548
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2551
  br i1 %cmp2, label %land.lhs.true, label %if.end23, !dbg !2552

land.lhs.true:                                    ; preds = %land.end
  %7 = load i32, i32* %lIndexQueueSetMember, align 4, !dbg !2553
  %cmp4 = icmp sge i32 %7, 1, !dbg !2553
  br i1 %cmp4, label %land.rhs6, label %land.end9, !dbg !2553

land.rhs6:                                        ; preds = %land.lhs.true
  %8 = load i32, i32* %lIndexQueueSetMember, align 4, !dbg !2553
  %cmp7 = icmp slt i32 %8, 257, !dbg !2553
  br label %land.end9

land.end9:                                        ; preds = %land.rhs6, %land.lhs.true
  %9 = phi i1 [ false, %land.lhs.true ], [ %cmp7, %land.rhs6 ], !dbg !2550
  %land.ext10 = zext i1 %9 to i32, !dbg !2553
  %conv11 = sext i32 %land.ext10 to i64, !dbg !2553
  %cmp12 = icmp ne i64 %conv11, 0, !dbg !2554
  br i1 %cmp12, label %if.then, label %if.end23, !dbg !2555

if.then:                                          ; preds = %land.end9
  %10 = load i32, i32* %lIndexQueueSet, align 4, !dbg !2556
  %sub = sub nsw i32 %10, 1, !dbg !2556
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2556
  %11 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2556
  store %struct.QueueDefinition* %11, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !2558
  %12 = load i32, i32* %lIndexQueueSetMember, align 4, !dbg !2559
  %sub14 = sub nsw i32 %12, 1, !dbg !2559
  %call15 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub14, i32 1), !dbg !2559
  %13 = bitcast %struct.OpaqueObject* %call15 to %struct.QueueDefinition*, !dbg !2559
  store %struct.QueueDefinition* %13, %struct.QueueDefinition** %xInternalQueueSetMemberHandle, align 8, !dbg !2560
  %14 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !2561
  %cmp16 = icmp ne %struct.QueueDefinition* %14, null, !dbg !2563
  br i1 %cmp16, label %land.lhs.true18, label %if.end, !dbg !2564

land.lhs.true18:                                  ; preds = %if.then
  %15 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetMemberHandle, align 8, !dbg !2565
  %cmp19 = icmp ne %struct.QueueDefinition* %15, null, !dbg !2566
  br i1 %cmp19, label %if.then21, label %if.end, !dbg !2567

if.then21:                                        ; preds = %land.lhs.true18
  %16 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetMemberHandle, align 8, !dbg !2568
  %17 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !2570
  %call22 = call i64 @xQueueAddToSet(%struct.QueueDefinition* %16, %struct.QueueDefinition* %17), !dbg !2571
  store i64 %call22, i64* %xReturn, align 8, !dbg !2572
  br label %if.end, !dbg !2573

if.end:                                           ; preds = %if.then21, %land.lhs.true18, %if.then
  br label %if.end23, !dbg !2574

if.end23:                                         ; preds = %if.end, %land.end9, %land.end
  %18 = load i64, i64* %xReturn, align 8, !dbg !2575
  ret i64 %18, !dbg !2576
}

declare dso_local i64 @xQueueAddToSet(%struct.QueueDefinition*, %struct.QueueDefinition*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vQueueAddToRegistryImpl(%struct.QueueDefinition* %xQueue, i8* %pcName) #0 section "privileged_functions" !dbg !2577 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %pcName.addr = alloca i8*, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !2580, metadata !DIExpression()), !dbg !2581
  store i8* %pcName, i8** %pcName.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pcName.addr, metadata !2582, metadata !DIExpression()), !dbg !2583
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2584, metadata !DIExpression()), !dbg !2585
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2586, metadata !DIExpression()), !dbg !2587
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2587
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !2588
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2589
  store i32 %1, i32* %lIndex, align 4, !dbg !2590
  %2 = load i32, i32* %lIndex, align 4, !dbg !2591
  %cmp = icmp sge i32 %2, 1, !dbg !2591
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2591

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2591
  %cmp1 = icmp slt i32 %3, 257, !dbg !2591
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2593
  %land.ext = zext i1 %4 to i32, !dbg !2591
  %conv = sext i32 %land.ext to i64, !dbg !2591
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2594
  br i1 %cmp2, label %if.then, label %if.end7, !dbg !2595

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2596
  %sub = sub nsw i32 %5, 1, !dbg !2596
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2596
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2596
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2598
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2599
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2601
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !2602

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2603
  %9 = load i8*, i8** %pcName.addr, align 8, !dbg !2605
  call void @vQueueAddToRegistry(%struct.QueueDefinition* %8, i8* %9), !dbg !2606
  br label %if.end, !dbg !2607

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end7, !dbg !2608

if.end7:                                          ; preds = %if.end, %land.end
  ret void, !dbg !2609
}

declare dso_local void @vQueueAddToRegistry(%struct.QueueDefinition*, i8*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vQueueUnregisterQueueImpl(%struct.QueueDefinition* %xQueue) #0 section "privileged_functions" !dbg !2610 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !2613, metadata !DIExpression()), !dbg !2614
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2615, metadata !DIExpression()), !dbg !2616
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2617, metadata !DIExpression()), !dbg !2618
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2618
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !2619
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2620
  store i32 %1, i32* %lIndex, align 4, !dbg !2621
  %2 = load i32, i32* %lIndex, align 4, !dbg !2622
  %cmp = icmp sge i32 %2, 1, !dbg !2622
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2622

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2622
  %cmp1 = icmp slt i32 %3, 257, !dbg !2622
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2624
  %land.ext = zext i1 %4 to i32, !dbg !2622
  %conv = sext i32 %land.ext to i64, !dbg !2622
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2625
  br i1 %cmp2, label %if.then, label %if.end7, !dbg !2626

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2627
  %sub = sub nsw i32 %5, 1, !dbg !2627
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2627
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2627
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2629
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2630
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2632
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !2633

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2634
  call void @vQueueUnregisterQueue(%struct.QueueDefinition* %8), !dbg !2636
  br label %if.end, !dbg !2637

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end7, !dbg !2638

if.end7:                                          ; preds = %if.end, %land.end
  ret void, !dbg !2639
}

declare dso_local void @vQueueUnregisterQueue(%struct.QueueDefinition*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @MPU_pcQueueGetNameImpl(%struct.QueueDefinition* %xQueue) #0 section "privileged_functions" !dbg !2640 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %pcReturn = alloca i8*, align 8
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %lIndex = alloca i32, align 4
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !2643, metadata !DIExpression()), !dbg !2644
  call void @llvm.dbg.declare(metadata i8** %pcReturn, metadata !2645, metadata !DIExpression()), !dbg !2646
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2647, metadata !DIExpression()), !dbg !2648
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2648
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2649, metadata !DIExpression()), !dbg !2650
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !2651
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2652
  store i32 %1, i32* %lIndex, align 4, !dbg !2653
  %2 = load i32, i32* %lIndex, align 4, !dbg !2654
  %cmp = icmp sge i32 %2, 1, !dbg !2654
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2654

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2654
  %cmp1 = icmp slt i32 %3, 257, !dbg !2654
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2656
  %land.ext = zext i1 %4 to i32, !dbg !2654
  %conv = sext i32 %land.ext to i64, !dbg !2654
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2657
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !2658

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2659
  %sub = sub nsw i32 %5, 1, !dbg !2659
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2659
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2659
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2661
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2662
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2664
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !2665

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2666
  %call7 = call i8* @pcQueueGetName(%struct.QueueDefinition* %8), !dbg !2668
  store i8* %call7, i8** %pcReturn, align 8, !dbg !2669
  br label %if.end, !dbg !2670

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !2671

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i8*, i8** %pcReturn, align 8, !dbg !2672
  ret i8* %9, !dbg !2673
}

declare dso_local i8* @pcQueueGetName(%struct.QueueDefinition*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vQueueDelete(%struct.QueueDefinition* %xQueue) #0 section "privileged_functions" !dbg !2674 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %lIndex = alloca i32, align 4
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !2675, metadata !DIExpression()), !dbg !2676
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2677, metadata !DIExpression()), !dbg !2678
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2678
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2679, metadata !DIExpression()), !dbg !2680
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !2681
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2682
  store i32 %1, i32* %lIndex, align 4, !dbg !2683
  %2 = load i32, i32* %lIndex, align 4, !dbg !2684
  %cmp = icmp sge i32 %2, 1, !dbg !2684
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2684

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2684
  %cmp1 = icmp slt i32 %3, 257, !dbg !2684
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2686
  %land.ext = zext i1 %4 to i32, !dbg !2684
  %conv = sext i32 %land.ext to i64, !dbg !2684
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2687
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !2688

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2689
  %sub = sub nsw i32 %5, 1, !dbg !2689
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2689
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2689
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2691
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2692
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2694
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !2695

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2696
  call void @vQueueDelete(%struct.QueueDefinition* %8), !dbg !2698
  %9 = load i32, i32* %lIndex, align 4, !dbg !2699
  %sub7 = sub nsw i32 %9, 1, !dbg !2699
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %sub7), !dbg !2700
  br label %if.end, !dbg !2701

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !2702

if.end8:                                          ; preds = %if.end, %land.end
  ret void, !dbg !2703
}

declare dso_local void @vQueueDelete(%struct.QueueDefinition*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.QueueDefinition* @MPU_xQueueCreateCountingSemaphore(i64 %uxCountValue, i64 %uxInitialCount) #0 section "privileged_functions" !dbg !2704 {
entry:
  %uxCountValue.addr = alloca i64, align 8
  %uxInitialCount.addr = alloca i64, align 8
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %xExternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %lIndex = alloca i32, align 4
  store i64 %uxCountValue, i64* %uxCountValue.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxCountValue.addr, metadata !2707, metadata !DIExpression()), !dbg !2708
  store i64 %uxInitialCount, i64* %uxInitialCount.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxInitialCount.addr, metadata !2709, metadata !DIExpression()), !dbg !2710
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2711, metadata !DIExpression()), !dbg !2712
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2712
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xExternalQueueHandle, metadata !2713, metadata !DIExpression()), !dbg !2714
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2714
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2715, metadata !DIExpression()), !dbg !2716
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !2717
  store i32 %call, i32* %lIndex, align 4, !dbg !2718
  %0 = load i32, i32* %lIndex, align 4, !dbg !2719
  %cmp = icmp ne i32 %0, -1, !dbg !2721
  br i1 %cmp, label %if.then, label %if.end4, !dbg !2722

if.then:                                          ; preds = %entry
  %1 = load i64, i64* %uxCountValue.addr, align 8, !dbg !2723
  %2 = load i64, i64* %uxInitialCount.addr, align 8, !dbg !2725
  %call1 = call %struct.QueueDefinition* @xQueueCreateCountingSemaphore(i64 %1, i64 %2), !dbg !2726
  store %struct.QueueDefinition* %call1, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2727
  %3 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2728
  %cmp2 = icmp ne %struct.QueueDefinition* %3, null, !dbg !2730
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !2731

if.then3:                                         ; preds = %if.then
  %4 = load i32, i32* %lIndex, align 4, !dbg !2732
  %5 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2732
  %6 = bitcast %struct.QueueDefinition* %5 to %struct.OpaqueObject*, !dbg !2732
  call void @MPU_StoreHandleAndDataAtIndex(i32 %4, %struct.OpaqueObject* %6, i8* null, i32 1), !dbg !2732
  %7 = load i32, i32* %lIndex, align 4, !dbg !2734
  %add = add nsw i32 %7, 1, !dbg !2734
  %conv = sext i32 %add to i64, !dbg !2735
  %8 = inttoptr i64 %conv to %struct.QueueDefinition*, !dbg !2735
  store %struct.QueueDefinition* %8, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2736
  br label %if.end, !dbg !2737

if.else:                                          ; preds = %if.then
  %9 = load i32, i32* %lIndex, align 4, !dbg !2738
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %9), !dbg !2740
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  br label %if.end4, !dbg !2741

if.end4:                                          ; preds = %if.end, %entry
  %10 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2742
  ret %struct.QueueDefinition* %10, !dbg !2743
}

declare dso_local %struct.QueueDefinition* @xQueueCreateCountingSemaphore(i64, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.QueueDefinition* @MPU_xQueueCreateCountingSemaphoreStatic(i64 %uxMaxCount, i64 %uxInitialCount, %struct.xSTATIC_QUEUE* %pxStaticQueue) #0 section "privileged_functions" !dbg !2744 {
entry:
  %uxMaxCount.addr = alloca i64, align 8
  %uxInitialCount.addr = alloca i64, align 8
  %pxStaticQueue.addr = alloca %struct.xSTATIC_QUEUE*, align 8
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %xExternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %lIndex = alloca i32, align 4
  store i64 %uxMaxCount, i64* %uxMaxCount.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxMaxCount.addr, metadata !2781, metadata !DIExpression()), !dbg !2782
  store i64 %uxInitialCount, i64* %uxInitialCount.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxInitialCount.addr, metadata !2783, metadata !DIExpression()), !dbg !2784
  store %struct.xSTATIC_QUEUE* %pxStaticQueue, %struct.xSTATIC_QUEUE** %pxStaticQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xSTATIC_QUEUE** %pxStaticQueue.addr, metadata !2785, metadata !DIExpression()), !dbg !2786
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2787, metadata !DIExpression()), !dbg !2788
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2788
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xExternalQueueHandle, metadata !2789, metadata !DIExpression()), !dbg !2790
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2790
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2791, metadata !DIExpression()), !dbg !2792
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !2793
  store i32 %call, i32* %lIndex, align 4, !dbg !2794
  %0 = load i32, i32* %lIndex, align 4, !dbg !2795
  %cmp = icmp ne i32 %0, -1, !dbg !2797
  br i1 %cmp, label %if.then, label %if.end4, !dbg !2798

if.then:                                          ; preds = %entry
  %1 = load i64, i64* %uxMaxCount.addr, align 8, !dbg !2799
  %2 = load i64, i64* %uxInitialCount.addr, align 8, !dbg !2801
  %3 = load %struct.xSTATIC_QUEUE*, %struct.xSTATIC_QUEUE** %pxStaticQueue.addr, align 8, !dbg !2802
  %call1 = call %struct.QueueDefinition* @xQueueCreateCountingSemaphoreStatic(i64 %1, i64 %2, %struct.xSTATIC_QUEUE* %3), !dbg !2803
  store %struct.QueueDefinition* %call1, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2804
  %4 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2805
  %cmp2 = icmp ne %struct.QueueDefinition* %4, null, !dbg !2807
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !2808

if.then3:                                         ; preds = %if.then
  %5 = load i32, i32* %lIndex, align 4, !dbg !2809
  %6 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2809
  %7 = bitcast %struct.QueueDefinition* %6 to %struct.OpaqueObject*, !dbg !2809
  call void @MPU_StoreHandleAndDataAtIndex(i32 %5, %struct.OpaqueObject* %7, i8* null, i32 1), !dbg !2809
  %8 = load i32, i32* %lIndex, align 4, !dbg !2811
  %add = add nsw i32 %8, 1, !dbg !2811
  %conv = sext i32 %add to i64, !dbg !2812
  %9 = inttoptr i64 %conv to %struct.QueueDefinition*, !dbg !2812
  store %struct.QueueDefinition* %9, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2813
  br label %if.end, !dbg !2814

if.else:                                          ; preds = %if.then
  %10 = load i32, i32* %lIndex, align 4, !dbg !2815
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %10), !dbg !2817
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  br label %if.end4, !dbg !2818

if.end4:                                          ; preds = %if.end, %entry
  %11 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2819
  ret %struct.QueueDefinition* %11, !dbg !2820
}

declare dso_local %struct.QueueDefinition* @xQueueCreateCountingSemaphoreStatic(i64, i64, %struct.xSTATIC_QUEUE*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.QueueDefinition* @MPU_xQueueGenericCreate(i64 %uxQueueLength, i64 %uxItemSize, i8 zeroext %ucQueueType) #0 section "privileged_functions" !dbg !2821 {
entry:
  %uxQueueLength.addr = alloca i64, align 8
  %uxItemSize.addr = alloca i64, align 8
  %ucQueueType.addr = alloca i8, align 1
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %xExternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %lIndex = alloca i32, align 4
  store i64 %uxQueueLength, i64* %uxQueueLength.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxQueueLength.addr, metadata !2824, metadata !DIExpression()), !dbg !2825
  store i64 %uxItemSize, i64* %uxItemSize.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxItemSize.addr, metadata !2826, metadata !DIExpression()), !dbg !2827
  store i8 %ucQueueType, i8* %ucQueueType.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %ucQueueType.addr, metadata !2828, metadata !DIExpression()), !dbg !2829
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2830, metadata !DIExpression()), !dbg !2831
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2831
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xExternalQueueHandle, metadata !2832, metadata !DIExpression()), !dbg !2833
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2833
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2834, metadata !DIExpression()), !dbg !2835
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !2836
  store i32 %call, i32* %lIndex, align 4, !dbg !2837
  %0 = load i32, i32* %lIndex, align 4, !dbg !2838
  %cmp = icmp ne i32 %0, -1, !dbg !2840
  br i1 %cmp, label %if.then, label %if.end4, !dbg !2841

if.then:                                          ; preds = %entry
  %1 = load i64, i64* %uxQueueLength.addr, align 8, !dbg !2842
  %2 = load i64, i64* %uxItemSize.addr, align 8, !dbg !2844
  %3 = load i8, i8* %ucQueueType.addr, align 1, !dbg !2845
  %call1 = call %struct.QueueDefinition* @xQueueGenericCreate(i64 %1, i64 %2, i8 zeroext %3), !dbg !2846
  store %struct.QueueDefinition* %call1, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2847
  %4 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2848
  %cmp2 = icmp ne %struct.QueueDefinition* %4, null, !dbg !2850
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !2851

if.then3:                                         ; preds = %if.then
  %5 = load i32, i32* %lIndex, align 4, !dbg !2852
  %6 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2852
  %7 = bitcast %struct.QueueDefinition* %6 to %struct.OpaqueObject*, !dbg !2852
  call void @MPU_StoreHandleAndDataAtIndex(i32 %5, %struct.OpaqueObject* %7, i8* null, i32 1), !dbg !2852
  %8 = load i32, i32* %lIndex, align 4, !dbg !2854
  %add = add nsw i32 %8, 1, !dbg !2854
  %conv = sext i32 %add to i64, !dbg !2855
  %9 = inttoptr i64 %conv to %struct.QueueDefinition*, !dbg !2855
  store %struct.QueueDefinition* %9, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2856
  br label %if.end, !dbg !2857

if.else:                                          ; preds = %if.then
  %10 = load i32, i32* %lIndex, align 4, !dbg !2858
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %10), !dbg !2860
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  br label %if.end4, !dbg !2861

if.end4:                                          ; preds = %if.end, %entry
  %11 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2862
  ret %struct.QueueDefinition* %11, !dbg !2863
}

declare dso_local %struct.QueueDefinition* @xQueueGenericCreate(i64, i64, i8 zeroext) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.QueueDefinition* @MPU_xQueueGenericCreateStatic(i64 %uxQueueLength, i64 %uxItemSize, i8* %pucQueueStorage, %struct.xSTATIC_QUEUE* %pxStaticQueue, i8 zeroext %ucQueueType) #0 section "privileged_functions" !dbg !2864 {
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
  call void @llvm.dbg.declare(metadata i64* %uxQueueLength.addr, metadata !2869, metadata !DIExpression()), !dbg !2870
  store i64 %uxItemSize, i64* %uxItemSize.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxItemSize.addr, metadata !2871, metadata !DIExpression()), !dbg !2872
  store i8* %pucQueueStorage, i8** %pucQueueStorage.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pucQueueStorage.addr, metadata !2873, metadata !DIExpression()), !dbg !2874
  store %struct.xSTATIC_QUEUE* %pxStaticQueue, %struct.xSTATIC_QUEUE** %pxStaticQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xSTATIC_QUEUE** %pxStaticQueue.addr, metadata !2875, metadata !DIExpression()), !dbg !2876
  store i8 %ucQueueType, i8* %ucQueueType.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %ucQueueType.addr, metadata !2877, metadata !DIExpression()), !dbg !2878
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2879, metadata !DIExpression()), !dbg !2880
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2880
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xExternalQueueHandle, metadata !2881, metadata !DIExpression()), !dbg !2882
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2882
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2883, metadata !DIExpression()), !dbg !2884
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !2885
  store i32 %call, i32* %lIndex, align 4, !dbg !2886
  %0 = load i32, i32* %lIndex, align 4, !dbg !2887
  %cmp = icmp ne i32 %0, -1, !dbg !2889
  br i1 %cmp, label %if.then, label %if.end4, !dbg !2890

if.then:                                          ; preds = %entry
  %1 = load i64, i64* %uxQueueLength.addr, align 8, !dbg !2891
  %2 = load i64, i64* %uxItemSize.addr, align 8, !dbg !2893
  %3 = load i8*, i8** %pucQueueStorage.addr, align 8, !dbg !2894
  %4 = load %struct.xSTATIC_QUEUE*, %struct.xSTATIC_QUEUE** %pxStaticQueue.addr, align 8, !dbg !2895
  %5 = load i8, i8* %ucQueueType.addr, align 1, !dbg !2896
  %call1 = call %struct.QueueDefinition* @xQueueGenericCreateStatic(i64 %1, i64 %2, i8* %3, %struct.xSTATIC_QUEUE* %4, i8 zeroext %5), !dbg !2897
  store %struct.QueueDefinition* %call1, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2898
  %6 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2899
  %cmp2 = icmp ne %struct.QueueDefinition* %6, null, !dbg !2901
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !2902

if.then3:                                         ; preds = %if.then
  %7 = load i32, i32* %lIndex, align 4, !dbg !2903
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2903
  %9 = bitcast %struct.QueueDefinition* %8 to %struct.OpaqueObject*, !dbg !2903
  call void @MPU_StoreHandleAndDataAtIndex(i32 %7, %struct.OpaqueObject* %9, i8* null, i32 1), !dbg !2903
  %10 = load i32, i32* %lIndex, align 4, !dbg !2905
  %add = add nsw i32 %10, 1, !dbg !2905
  %conv = sext i32 %add to i64, !dbg !2906
  %11 = inttoptr i64 %conv to %struct.QueueDefinition*, !dbg !2906
  store %struct.QueueDefinition* %11, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2907
  br label %if.end, !dbg !2908

if.else:                                          ; preds = %if.then
  %12 = load i32, i32* %lIndex, align 4, !dbg !2909
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %12), !dbg !2911
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  br label %if.end4, !dbg !2912

if.end4:                                          ; preds = %if.end, %entry
  %13 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xExternalQueueHandle, align 8, !dbg !2913
  ret %struct.QueueDefinition* %13, !dbg !2914
}

declare dso_local %struct.QueueDefinition* @xQueueGenericCreateStatic(i64, i64, i8*, %struct.xSTATIC_QUEUE*, i8 zeroext) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueGenericReset(%struct.QueueDefinition* %xQueue, i64 %xNewQueue) #0 section "privileged_functions" !dbg !2915 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %xNewQueue.addr = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %xReturn = alloca i64, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !2918, metadata !DIExpression()), !dbg !2919
  store i64 %xNewQueue, i64* %xNewQueue.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xNewQueue.addr, metadata !2920, metadata !DIExpression()), !dbg !2921
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2922, metadata !DIExpression()), !dbg !2923
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !2924, metadata !DIExpression()), !dbg !2925
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2925
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !2926, metadata !DIExpression()), !dbg !2927
  store i64 0, i64* %xReturn, align 8, !dbg !2927
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !2928
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !2929
  store i32 %1, i32* %lIndex, align 4, !dbg !2930
  %2 = load i32, i32* %lIndex, align 4, !dbg !2931
  %cmp = icmp sge i32 %2, 1, !dbg !2931
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !2931

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !2931
  %cmp1 = icmp slt i32 %3, 257, !dbg !2931
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !2933
  %land.ext = zext i1 %4 to i32, !dbg !2931
  %conv = sext i32 %land.ext to i64, !dbg !2931
  %cmp2 = icmp ne i64 %conv, 0, !dbg !2934
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !2935

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !2936
  %sub = sub nsw i32 %5, 1, !dbg !2936
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !2936
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !2936
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2938
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2939
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !2941
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !2942

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !2943
  %9 = load i64, i64* %xNewQueue.addr, align 8, !dbg !2945
  %call7 = call i64 @xQueueGenericReset(%struct.QueueDefinition* %8, i64 %9), !dbg !2946
  store i64 %call7, i64* %xReturn, align 8, !dbg !2947
  br label %if.end, !dbg !2948

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !2949

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !2950
  ret i64 %10, !dbg !2951
}

declare dso_local i64 @xQueueGenericReset(%struct.QueueDefinition*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.QueueDefinition* @MPU_xQueueCreateSet(i64 %uxEventQueueLength) #0 section "privileged_functions" !dbg !2952 {
entry:
  %uxEventQueueLength.addr = alloca i64, align 8
  %xInternalQueueSetHandle = alloca %struct.QueueDefinition*, align 8
  %xExternalQueueSetHandle = alloca %struct.QueueDefinition*, align 8
  %lIndex = alloca i32, align 4
  store i64 %uxEventQueueLength, i64* %uxEventQueueLength.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxEventQueueLength.addr, metadata !2955, metadata !DIExpression()), !dbg !2956
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueSetHandle, metadata !2957, metadata !DIExpression()), !dbg !2958
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !2958
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xExternalQueueSetHandle, metadata !2959, metadata !DIExpression()), !dbg !2960
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xExternalQueueSetHandle, align 8, !dbg !2960
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !2961, metadata !DIExpression()), !dbg !2962
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !2963
  store i32 %call, i32* %lIndex, align 4, !dbg !2964
  %0 = load i32, i32* %lIndex, align 4, !dbg !2965
  %cmp = icmp ne i32 %0, -1, !dbg !2967
  br i1 %cmp, label %if.then, label %if.end4, !dbg !2968

if.then:                                          ; preds = %entry
  %1 = load i64, i64* %uxEventQueueLength.addr, align 8, !dbg !2969
  %call1 = call %struct.QueueDefinition* @xQueueCreateSet(i64 %1), !dbg !2971
  store %struct.QueueDefinition* %call1, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !2972
  %2 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !2973
  %cmp2 = icmp ne %struct.QueueDefinition* %2, null, !dbg !2975
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !2976

if.then3:                                         ; preds = %if.then
  %3 = load i32, i32* %lIndex, align 4, !dbg !2977
  %4 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !2977
  %5 = bitcast %struct.QueueDefinition* %4 to %struct.OpaqueObject*, !dbg !2977
  call void @MPU_StoreHandleAndDataAtIndex(i32 %3, %struct.OpaqueObject* %5, i8* null, i32 1), !dbg !2977
  %6 = load i32, i32* %lIndex, align 4, !dbg !2979
  %add = add nsw i32 %6, 1, !dbg !2979
  %conv = sext i32 %add to i64, !dbg !2980
  %7 = inttoptr i64 %conv to %struct.QueueDefinition*, !dbg !2980
  store %struct.QueueDefinition* %7, %struct.QueueDefinition** %xExternalQueueSetHandle, align 8, !dbg !2981
  br label %if.end, !dbg !2982

if.else:                                          ; preds = %if.then
  %8 = load i32, i32* %lIndex, align 4, !dbg !2983
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %8), !dbg !2985
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  br label %if.end4, !dbg !2986

if.end4:                                          ; preds = %if.end, %entry
  %9 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xExternalQueueSetHandle, align 8, !dbg !2987
  ret %struct.QueueDefinition* %9, !dbg !2988
}

declare dso_local %struct.QueueDefinition* @xQueueCreateSet(i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueRemoveFromSet(%struct.QueueDefinition* %xQueueOrSemaphore, %struct.QueueDefinition* %xQueueSet) #0 section "privileged_functions" !dbg !2989 {
entry:
  %xQueueOrSemaphore.addr = alloca %struct.QueueDefinition*, align 8
  %xQueueSet.addr = alloca %struct.QueueDefinition*, align 8
  %xReturn = alloca i64, align 8
  %xInternalQueueSetMemberHandle = alloca %struct.QueueDefinition*, align 8
  %xInternalQueueSetHandle = alloca %struct.QueueDefinition*, align 8
  %lIndexQueueSet = alloca i32, align 4
  %lIndexQueueSetMember = alloca i32, align 4
  store %struct.QueueDefinition* %xQueueOrSemaphore, %struct.QueueDefinition** %xQueueOrSemaphore.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueueOrSemaphore.addr, metadata !2990, metadata !DIExpression()), !dbg !2991
  store %struct.QueueDefinition* %xQueueSet, %struct.QueueDefinition** %xQueueSet.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueueSet.addr, metadata !2992, metadata !DIExpression()), !dbg !2993
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !2994, metadata !DIExpression()), !dbg !2995
  store i64 0, i64* %xReturn, align 8, !dbg !2995
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueSetMemberHandle, metadata !2996, metadata !DIExpression()), !dbg !2997
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueSetMemberHandle, align 8, !dbg !2997
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueSetHandle, metadata !2998, metadata !DIExpression()), !dbg !2999
  call void @llvm.dbg.declare(metadata i32* %lIndexQueueSet, metadata !3000, metadata !DIExpression()), !dbg !3001
  call void @llvm.dbg.declare(metadata i32* %lIndexQueueSetMember, metadata !3002, metadata !DIExpression()), !dbg !3003
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueueSet.addr, align 8, !dbg !3004
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !3005
  store i32 %1, i32* %lIndexQueueSet, align 4, !dbg !3006
  %2 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueueOrSemaphore.addr, align 8, !dbg !3007
  %3 = ptrtoint %struct.QueueDefinition* %2 to i32, !dbg !3008
  store i32 %3, i32* %lIndexQueueSetMember, align 4, !dbg !3009
  %4 = load i32, i32* %lIndexQueueSet, align 4, !dbg !3010
  %cmp = icmp sge i32 %4, 1, !dbg !3010
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3010

land.rhs:                                         ; preds = %entry
  %5 = load i32, i32* %lIndexQueueSet, align 4, !dbg !3010
  %cmp1 = icmp slt i32 %5, 257, !dbg !3010
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %6 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3012
  %land.ext = zext i1 %6 to i32, !dbg !3010
  %conv = sext i32 %land.ext to i64, !dbg !3010
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3013
  br i1 %cmp2, label %land.lhs.true, label %if.end23, !dbg !3014

land.lhs.true:                                    ; preds = %land.end
  %7 = load i32, i32* %lIndexQueueSetMember, align 4, !dbg !3015
  %cmp4 = icmp sge i32 %7, 1, !dbg !3015
  br i1 %cmp4, label %land.rhs6, label %land.end9, !dbg !3015

land.rhs6:                                        ; preds = %land.lhs.true
  %8 = load i32, i32* %lIndexQueueSetMember, align 4, !dbg !3015
  %cmp7 = icmp slt i32 %8, 257, !dbg !3015
  br label %land.end9

land.end9:                                        ; preds = %land.rhs6, %land.lhs.true
  %9 = phi i1 [ false, %land.lhs.true ], [ %cmp7, %land.rhs6 ], !dbg !3012
  %land.ext10 = zext i1 %9 to i32, !dbg !3015
  %conv11 = sext i32 %land.ext10 to i64, !dbg !3015
  %cmp12 = icmp ne i64 %conv11, 0, !dbg !3016
  br i1 %cmp12, label %if.then, label %if.end23, !dbg !3017

if.then:                                          ; preds = %land.end9
  %10 = load i32, i32* %lIndexQueueSet, align 4, !dbg !3018
  %sub = sub nsw i32 %10, 1, !dbg !3018
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !3018
  %11 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !3018
  store %struct.QueueDefinition* %11, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !3020
  %12 = load i32, i32* %lIndexQueueSetMember, align 4, !dbg !3021
  %sub14 = sub nsw i32 %12, 1, !dbg !3021
  %call15 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub14, i32 1), !dbg !3021
  %13 = bitcast %struct.OpaqueObject* %call15 to %struct.QueueDefinition*, !dbg !3021
  store %struct.QueueDefinition* %13, %struct.QueueDefinition** %xInternalQueueSetMemberHandle, align 8, !dbg !3022
  %14 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !3023
  %cmp16 = icmp ne %struct.QueueDefinition* %14, null, !dbg !3025
  br i1 %cmp16, label %land.lhs.true18, label %if.end, !dbg !3026

land.lhs.true18:                                  ; preds = %if.then
  %15 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetMemberHandle, align 8, !dbg !3027
  %cmp19 = icmp ne %struct.QueueDefinition* %15, null, !dbg !3028
  br i1 %cmp19, label %if.then21, label %if.end, !dbg !3029

if.then21:                                        ; preds = %land.lhs.true18
  %16 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetMemberHandle, align 8, !dbg !3030
  %17 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !3032
  %call22 = call i64 @xQueueRemoveFromSet(%struct.QueueDefinition* %16, %struct.QueueDefinition* %17), !dbg !3033
  store i64 %call22, i64* %xReturn, align 8, !dbg !3034
  br label %if.end, !dbg !3035

if.end:                                           ; preds = %if.then21, %land.lhs.true18, %if.then
  br label %if.end23, !dbg !3036

if.end23:                                         ; preds = %if.end, %land.end9, %land.end
  %18 = load i64, i64* %xReturn, align 8, !dbg !3037
  ret i64 %18, !dbg !3038
}

declare dso_local i64 @xQueueRemoveFromSet(%struct.QueueDefinition*, %struct.QueueDefinition*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueGenericGetStaticBuffers(%struct.QueueDefinition* %xQueue, i8** %ppucQueueStorage, %struct.xSTATIC_QUEUE** %ppxStaticQueue) #0 section "privileged_functions" !dbg !3039 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %ppucQueueStorage.addr = alloca i8**, align 8
  %ppxStaticQueue.addr = alloca %struct.xSTATIC_QUEUE**, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  %xReturn = alloca i64, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !3044, metadata !DIExpression()), !dbg !3045
  store i8** %ppucQueueStorage, i8*** %ppucQueueStorage.addr, align 8
  call void @llvm.dbg.declare(metadata i8*** %ppucQueueStorage.addr, metadata !3046, metadata !DIExpression()), !dbg !3047
  store %struct.xSTATIC_QUEUE** %ppxStaticQueue, %struct.xSTATIC_QUEUE*** %ppxStaticQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xSTATIC_QUEUE*** %ppxStaticQueue.addr, metadata !3048, metadata !DIExpression()), !dbg !3049
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3050, metadata !DIExpression()), !dbg !3051
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !3052, metadata !DIExpression()), !dbg !3053
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3053
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3054, metadata !DIExpression()), !dbg !3055
  store i64 0, i64* %xReturn, align 8, !dbg !3055
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !3056
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !3057
  store i32 %1, i32* %lIndex, align 4, !dbg !3058
  %2 = load i32, i32* %lIndex, align 4, !dbg !3059
  %cmp = icmp sge i32 %2, 1, !dbg !3059
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3059

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3059
  %cmp1 = icmp slt i32 %3, 257, !dbg !3059
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3061
  %land.ext = zext i1 %4 to i32, !dbg !3059
  %conv = sext i32 %land.ext to i64, !dbg !3059
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3062
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3063

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3064
  %sub = sub nsw i32 %5, 1, !dbg !3064
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !3064
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !3064
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3066
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3067
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !3069
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3070

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3071
  %9 = load i8**, i8*** %ppucQueueStorage.addr, align 8, !dbg !3073
  %10 = load %struct.xSTATIC_QUEUE**, %struct.xSTATIC_QUEUE*** %ppxStaticQueue.addr, align 8, !dbg !3074
  %call7 = call i64 @xQueueGenericGetStaticBuffers(%struct.QueueDefinition* %8, i8** %9, %struct.xSTATIC_QUEUE** %10), !dbg !3075
  store i64 %call7, i64* %xReturn, align 8, !dbg !3076
  br label %if.end, !dbg !3077

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3078

if.end8:                                          ; preds = %if.end, %land.end
  %11 = load i64, i64* %xReturn, align 8, !dbg !3079
  ret i64 %11, !dbg !3080
}

declare dso_local i64 @xQueueGenericGetStaticBuffers(%struct.QueueDefinition*, i8**, %struct.xSTATIC_QUEUE**) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueGenericSendFromISR(%struct.QueueDefinition* %xQueue, i8* %pvItemToQueue, i64* %pxHigherPriorityTaskWoken, i64 %xCopyPosition) #0 section "privileged_functions" !dbg !3081 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %pvItemToQueue.addr = alloca i8*, align 8
  %pxHigherPriorityTaskWoken.addr = alloca i64*, align 8
  %xCopyPosition.addr = alloca i64, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !3086, metadata !DIExpression()), !dbg !3087
  store i8* %pvItemToQueue, i8** %pvItemToQueue.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvItemToQueue.addr, metadata !3088, metadata !DIExpression()), !dbg !3089
  store i64* %pxHigherPriorityTaskWoken, i64** %pxHigherPriorityTaskWoken.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxHigherPriorityTaskWoken.addr, metadata !3090, metadata !DIExpression()), !dbg !3091
  store i64 %xCopyPosition, i64* %xCopyPosition.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xCopyPosition.addr, metadata !3092, metadata !DIExpression()), !dbg !3093
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3094, metadata !DIExpression()), !dbg !3095
  store i64 0, i64* %xReturn, align 8, !dbg !3095
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3096, metadata !DIExpression()), !dbg !3097
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !3098, metadata !DIExpression()), !dbg !3099
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3099
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !3100
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !3101
  store i32 %1, i32* %lIndex, align 4, !dbg !3102
  %2 = load i32, i32* %lIndex, align 4, !dbg !3103
  %cmp = icmp sge i32 %2, 1, !dbg !3103
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3103

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3103
  %cmp1 = icmp slt i32 %3, 257, !dbg !3103
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3105
  %land.ext = zext i1 %4 to i32, !dbg !3103
  %conv = sext i32 %land.ext to i64, !dbg !3103
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3106
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3107

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3108
  %sub = sub nsw i32 %5, 1, !dbg !3108
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !3108
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !3108
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3110
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3111
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !3113
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3114

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3115
  %9 = load i8*, i8** %pvItemToQueue.addr, align 8, !dbg !3117
  %10 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !3118
  %11 = load i64, i64* %xCopyPosition.addr, align 8, !dbg !3119
  %call7 = call i64 @xQueueGenericSendFromISR(%struct.QueueDefinition* %8, i8* %9, i64* %10, i64 %11), !dbg !3120
  store i64 %call7, i64* %xReturn, align 8, !dbg !3121
  br label %if.end, !dbg !3122

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3123

if.end8:                                          ; preds = %if.end, %land.end
  %12 = load i64, i64* %xReturn, align 8, !dbg !3124
  ret i64 %12, !dbg !3125
}

declare dso_local i64 @xQueueGenericSendFromISR(%struct.QueueDefinition*, i8*, i64*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueGiveFromISR(%struct.QueueDefinition* %xQueue, i64* %pxHigherPriorityTaskWoken) #0 section "privileged_functions" !dbg !3126 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %pxHigherPriorityTaskWoken.addr = alloca i64*, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !3129, metadata !DIExpression()), !dbg !3130
  store i64* %pxHigherPriorityTaskWoken, i64** %pxHigherPriorityTaskWoken.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxHigherPriorityTaskWoken.addr, metadata !3131, metadata !DIExpression()), !dbg !3132
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3133, metadata !DIExpression()), !dbg !3134
  store i64 0, i64* %xReturn, align 8, !dbg !3134
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3135, metadata !DIExpression()), !dbg !3136
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !3137, metadata !DIExpression()), !dbg !3138
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3138
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !3139
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !3140
  store i32 %1, i32* %lIndex, align 4, !dbg !3141
  %2 = load i32, i32* %lIndex, align 4, !dbg !3142
  %cmp = icmp sge i32 %2, 1, !dbg !3142
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3142

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3142
  %cmp1 = icmp slt i32 %3, 257, !dbg !3142
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3144
  %land.ext = zext i1 %4 to i32, !dbg !3142
  %conv = sext i32 %land.ext to i64, !dbg !3142
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3145
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3146

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3147
  %sub = sub nsw i32 %5, 1, !dbg !3147
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !3147
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !3147
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3149
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3150
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !3152
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3153

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3154
  %9 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !3156
  %call7 = call i64 @xQueueGiveFromISR(%struct.QueueDefinition* %8, i64* %9), !dbg !3157
  store i64 %call7, i64* %xReturn, align 8, !dbg !3158
  br label %if.end, !dbg !3159

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3160

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !3161
  ret i64 %10, !dbg !3162
}

declare dso_local i64 @xQueueGiveFromISR(%struct.QueueDefinition*, i64*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueuePeekFromISR(%struct.QueueDefinition* %xQueue, i8* %pvBuffer) #0 section "privileged_functions" !dbg !3163 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %pvBuffer.addr = alloca i8*, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !3166, metadata !DIExpression()), !dbg !3167
  store i8* %pvBuffer, i8** %pvBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvBuffer.addr, metadata !3168, metadata !DIExpression()), !dbg !3169
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3170, metadata !DIExpression()), !dbg !3171
  store i64 0, i64* %xReturn, align 8, !dbg !3171
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3172, metadata !DIExpression()), !dbg !3173
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !3174, metadata !DIExpression()), !dbg !3175
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3175
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !3176
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !3177
  store i32 %1, i32* %lIndex, align 4, !dbg !3178
  %2 = load i32, i32* %lIndex, align 4, !dbg !3179
  %cmp = icmp sge i32 %2, 1, !dbg !3179
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3179

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3179
  %cmp1 = icmp slt i32 %3, 257, !dbg !3179
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3181
  %land.ext = zext i1 %4 to i32, !dbg !3179
  %conv = sext i32 %land.ext to i64, !dbg !3179
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3182
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3183

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3184
  %sub = sub nsw i32 %5, 1, !dbg !3184
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !3184
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !3184
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3186
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3187
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !3189
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3190

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3191
  %9 = load i8*, i8** %pvBuffer.addr, align 8, !dbg !3193
  %call7 = call i64 @xQueuePeekFromISR(%struct.QueueDefinition* %8, i8* %9), !dbg !3194
  store i64 %call7, i64* %xReturn, align 8, !dbg !3195
  br label %if.end, !dbg !3196

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3197

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !3198
  ret i64 %10, !dbg !3199
}

declare dso_local i64 @xQueuePeekFromISR(%struct.QueueDefinition*, i8*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueReceiveFromISR(%struct.QueueDefinition* %xQueue, i8* %pvBuffer, i64* %pxHigherPriorityTaskWoken) #0 section "privileged_functions" !dbg !3200 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %pvBuffer.addr = alloca i8*, align 8
  %pxHigherPriorityTaskWoken.addr = alloca i64*, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !3203, metadata !DIExpression()), !dbg !3204
  store i8* %pvBuffer, i8** %pvBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvBuffer.addr, metadata !3205, metadata !DIExpression()), !dbg !3206
  store i64* %pxHigherPriorityTaskWoken, i64** %pxHigherPriorityTaskWoken.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxHigherPriorityTaskWoken.addr, metadata !3207, metadata !DIExpression()), !dbg !3208
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3209, metadata !DIExpression()), !dbg !3210
  store i64 0, i64* %xReturn, align 8, !dbg !3210
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3211, metadata !DIExpression()), !dbg !3212
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !3213, metadata !DIExpression()), !dbg !3214
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3214
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !3215
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !3216
  store i32 %1, i32* %lIndex, align 4, !dbg !3217
  %2 = load i32, i32* %lIndex, align 4, !dbg !3218
  %cmp = icmp sge i32 %2, 1, !dbg !3218
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3218

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3218
  %cmp1 = icmp slt i32 %3, 257, !dbg !3218
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3220
  %land.ext = zext i1 %4 to i32, !dbg !3218
  %conv = sext i32 %land.ext to i64, !dbg !3218
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3221
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3222

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3223
  %sub = sub nsw i32 %5, 1, !dbg !3223
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !3223
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !3223
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3225
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3226
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !3228
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3229

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3230
  %9 = load i8*, i8** %pvBuffer.addr, align 8, !dbg !3232
  %10 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !3233
  %call7 = call i64 @xQueueReceiveFromISR(%struct.QueueDefinition* %8, i8* %9, i64* %10), !dbg !3234
  store i64 %call7, i64* %xReturn, align 8, !dbg !3235
  br label %if.end, !dbg !3236

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3237

if.end8:                                          ; preds = %if.end, %land.end
  %11 = load i64, i64* %xReturn, align 8, !dbg !3238
  ret i64 %11, !dbg !3239
}

declare dso_local i64 @xQueueReceiveFromISR(%struct.QueueDefinition*, i8*, i64*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueIsQueueEmptyFromISR(%struct.QueueDefinition* %xQueue) #0 section "privileged_functions" !dbg !3240 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !3243, metadata !DIExpression()), !dbg !3244
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3245, metadata !DIExpression()), !dbg !3246
  store i64 0, i64* %xReturn, align 8, !dbg !3246
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3247, metadata !DIExpression()), !dbg !3248
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !3249, metadata !DIExpression()), !dbg !3250
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3250
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !3251
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !3252
  store i32 %1, i32* %lIndex, align 4, !dbg !3253
  %2 = load i32, i32* %lIndex, align 4, !dbg !3254
  %cmp = icmp sge i32 %2, 1, !dbg !3254
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3254

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3254
  %cmp1 = icmp slt i32 %3, 257, !dbg !3254
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3256
  %land.ext = zext i1 %4 to i32, !dbg !3254
  %conv = sext i32 %land.ext to i64, !dbg !3254
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3257
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3258

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3259
  %sub = sub nsw i32 %5, 1, !dbg !3259
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !3259
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !3259
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3261
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3262
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !3264
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3265

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3266
  %call7 = call i64 @xQueueIsQueueEmptyFromISR(%struct.QueueDefinition* %8), !dbg !3268
  store i64 %call7, i64* %xReturn, align 8, !dbg !3269
  br label %if.end, !dbg !3270

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3271

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !3272
  ret i64 %9, !dbg !3273
}

declare dso_local i64 @xQueueIsQueueEmptyFromISR(%struct.QueueDefinition*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xQueueIsQueueFullFromISR(%struct.QueueDefinition* %xQueue) #0 section "privileged_functions" !dbg !3274 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %xReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !3275, metadata !DIExpression()), !dbg !3276
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3277, metadata !DIExpression()), !dbg !3278
  store i64 0, i64* %xReturn, align 8, !dbg !3278
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3279, metadata !DIExpression()), !dbg !3280
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !3281, metadata !DIExpression()), !dbg !3282
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3282
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !3283
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !3284
  store i32 %1, i32* %lIndex, align 4, !dbg !3285
  %2 = load i32, i32* %lIndex, align 4, !dbg !3286
  %cmp = icmp sge i32 %2, 1, !dbg !3286
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3286

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3286
  %cmp1 = icmp slt i32 %3, 257, !dbg !3286
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3288
  %land.ext = zext i1 %4 to i32, !dbg !3286
  %conv = sext i32 %land.ext to i64, !dbg !3286
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3289
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3290

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3291
  %sub = sub nsw i32 %5, 1, !dbg !3291
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !3291
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !3291
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3293
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3294
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !3296
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3297

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3298
  %call7 = call i64 @xQueueIsQueueFullFromISR(%struct.QueueDefinition* %8), !dbg !3300
  store i64 %call7, i64* %xReturn, align 8, !dbg !3301
  br label %if.end, !dbg !3302

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3303

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !3304
  ret i64 %9, !dbg !3305
}

declare dso_local i64 @xQueueIsQueueFullFromISR(%struct.QueueDefinition*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_uxQueueMessagesWaitingFromISR(%struct.QueueDefinition* %xQueue) #0 section "privileged_functions" !dbg !3306 {
entry:
  %xQueue.addr = alloca %struct.QueueDefinition*, align 8
  %uxReturn = alloca i64, align 8
  %lIndex = alloca i32, align 4
  %xInternalQueueHandle = alloca %struct.QueueDefinition*, align 8
  store %struct.QueueDefinition* %xQueue, %struct.QueueDefinition** %xQueue.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueue.addr, metadata !3307, metadata !DIExpression()), !dbg !3308
  call void @llvm.dbg.declare(metadata i64* %uxReturn, metadata !3309, metadata !DIExpression()), !dbg !3310
  store i64 0, i64* %uxReturn, align 8, !dbg !3310
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3311, metadata !DIExpression()), !dbg !3312
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueHandle, metadata !3313, metadata !DIExpression()), !dbg !3314
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3314
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueue.addr, align 8, !dbg !3315
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !3316
  store i32 %1, i32* %lIndex, align 4, !dbg !3317
  %2 = load i32, i32* %lIndex, align 4, !dbg !3318
  %cmp = icmp sge i32 %2, 1, !dbg !3318
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3318

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3318
  %cmp1 = icmp slt i32 %3, 257, !dbg !3318
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3320
  %land.ext = zext i1 %4 to i32, !dbg !3318
  %conv = sext i32 %land.ext to i64, !dbg !3318
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3321
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3322

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3323
  %sub = sub nsw i32 %5, 1, !dbg !3323
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !3323
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !3323
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3325
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3326
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !3328
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3329

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueHandle, align 8, !dbg !3330
  %call7 = call i64 @uxQueueMessagesWaitingFromISR(%struct.QueueDefinition* %8), !dbg !3332
  store i64 %call7, i64* %uxReturn, align 8, !dbg !3333
  br label %if.end, !dbg !3334

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3335

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %uxReturn, align 8, !dbg !3336
  ret i64 %9, !dbg !3337
}

declare dso_local i64 @uxQueueMessagesWaitingFromISR(%struct.QueueDefinition*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.QueueDefinition* @MPU_xQueueSelectFromSetFromISR(%struct.QueueDefinition* %xQueueSet) #0 section "privileged_functions" !dbg !3338 {
entry:
  %xQueueSet.addr = alloca %struct.QueueDefinition*, align 8
  %xInternalQueueSetHandle = alloca %struct.QueueDefinition*, align 8
  %xSelectedMemberInternal = alloca %struct.QueueDefinition*, align 8
  %xSelectedMemberExternal = alloca %struct.QueueDefinition*, align 8
  %lIndexQueueSet = alloca i32, align 4
  %lIndexSelectedMember = alloca i32, align 4
  store %struct.QueueDefinition* %xQueueSet, %struct.QueueDefinition** %xQueueSet.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xQueueSet.addr, metadata !3341, metadata !DIExpression()), !dbg !3342
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xInternalQueueSetHandle, metadata !3343, metadata !DIExpression()), !dbg !3344
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !3344
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xSelectedMemberInternal, metadata !3345, metadata !DIExpression()), !dbg !3346
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xSelectedMemberInternal, align 8, !dbg !3346
  call void @llvm.dbg.declare(metadata %struct.QueueDefinition** %xSelectedMemberExternal, metadata !3347, metadata !DIExpression()), !dbg !3348
  store %struct.QueueDefinition* null, %struct.QueueDefinition** %xSelectedMemberExternal, align 8, !dbg !3348
  call void @llvm.dbg.declare(metadata i32* %lIndexQueueSet, metadata !3349, metadata !DIExpression()), !dbg !3350
  call void @llvm.dbg.declare(metadata i32* %lIndexSelectedMember, metadata !3351, metadata !DIExpression()), !dbg !3352
  %0 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xQueueSet.addr, align 8, !dbg !3353
  %1 = ptrtoint %struct.QueueDefinition* %0 to i32, !dbg !3354
  store i32 %1, i32* %lIndexQueueSet, align 4, !dbg !3355
  %2 = load i32, i32* %lIndexQueueSet, align 4, !dbg !3356
  %cmp = icmp sge i32 %2, 1, !dbg !3356
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3356

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndexQueueSet, align 4, !dbg !3356
  %cmp1 = icmp slt i32 %3, 257, !dbg !3356
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3358
  %land.ext = zext i1 %4 to i32, !dbg !3356
  %conv = sext i32 %land.ext to i64, !dbg !3356
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3359
  br i1 %cmp2, label %if.then, label %if.end18, !dbg !3360

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndexQueueSet, align 4, !dbg !3361
  %sub = sub nsw i32 %5, 1, !dbg !3361
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 1), !dbg !3361
  %6 = bitcast %struct.OpaqueObject* %call to %struct.QueueDefinition*, !dbg !3361
  store %struct.QueueDefinition* %6, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !3363
  %7 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !3364
  %cmp4 = icmp ne %struct.QueueDefinition* %7, null, !dbg !3366
  br i1 %cmp4, label %if.then6, label %if.end17, !dbg !3367

if.then6:                                         ; preds = %if.then
  %8 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xInternalQueueSetHandle, align 8, !dbg !3368
  %call7 = call %struct.QueueDefinition* @xQueueSelectFromSetFromISR(%struct.QueueDefinition* %8), !dbg !3370
  store %struct.QueueDefinition* %call7, %struct.QueueDefinition** %xSelectedMemberInternal, align 8, !dbg !3371
  %9 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xSelectedMemberInternal, align 8, !dbg !3372
  %cmp8 = icmp ne %struct.QueueDefinition* %9, null, !dbg !3374
  br i1 %cmp8, label %if.then10, label %if.end16, !dbg !3375

if.then10:                                        ; preds = %if.then6
  %10 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xSelectedMemberInternal, align 8, !dbg !3376
  %11 = bitcast %struct.QueueDefinition* %10 to %struct.OpaqueObject*, !dbg !3376
  %call11 = call i32 @MPU_GetIndexForHandle(%struct.OpaqueObject* %11, i32 1), !dbg !3376
  store i32 %call11, i32* %lIndexSelectedMember, align 4, !dbg !3378
  %12 = load i32, i32* %lIndexSelectedMember, align 4, !dbg !3379
  %cmp12 = icmp ne i32 %12, -1, !dbg !3381
  br i1 %cmp12, label %if.then14, label %if.end, !dbg !3382

if.then14:                                        ; preds = %if.then10
  %13 = load i32, i32* %lIndexSelectedMember, align 4, !dbg !3383
  %add = add nsw i32 %13, 1, !dbg !3383
  %conv15 = sext i32 %add to i64, !dbg !3385
  %14 = inttoptr i64 %conv15 to %struct.QueueDefinition*, !dbg !3385
  store %struct.QueueDefinition* %14, %struct.QueueDefinition** %xSelectedMemberExternal, align 8, !dbg !3386
  br label %if.end, !dbg !3387

if.end:                                           ; preds = %if.then14, %if.then10
  br label %if.end16, !dbg !3388

if.end16:                                         ; preds = %if.end, %if.then6
  br label %if.end17, !dbg !3389

if.end17:                                         ; preds = %if.end16, %if.then
  br label %if.end18, !dbg !3390

if.end18:                                         ; preds = %if.end17, %land.end
  %15 = load %struct.QueueDefinition*, %struct.QueueDefinition** %xSelectedMemberExternal, align 8, !dbg !3391
  ret %struct.QueueDefinition* %15, !dbg !3392
}

declare dso_local %struct.QueueDefinition* @xQueueSelectFromSetFromISR(%struct.QueueDefinition*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @MPU_pvTimerGetTimerIDImpl(%struct.tmrTimerControl* %xTimer) #0 section "privileged_functions" !dbg !3393 {
entry:
  %xTimer.addr = alloca %struct.tmrTimerControl*, align 8
  %pvReturn = alloca i8*, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tmrTimerControl* %xTimer, %struct.tmrTimerControl** %xTimer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xTimer.addr, metadata !3397, metadata !DIExpression()), !dbg !3398
  call void @llvm.dbg.declare(metadata i8** %pvReturn, metadata !3399, metadata !DIExpression()), !dbg !3400
  store i8* null, i8** %pvReturn, align 8, !dbg !3400
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3401, metadata !DIExpression()), !dbg !3402
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3402
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3403, metadata !DIExpression()), !dbg !3404
  %0 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xTimer.addr, align 8, !dbg !3405
  %1 = ptrtoint %struct.tmrTimerControl* %0 to i32, !dbg !3406
  store i32 %1, i32* %lIndex, align 4, !dbg !3407
  %2 = load i32, i32* %lIndex, align 4, !dbg !3408
  %cmp = icmp sge i32 %2, 1, !dbg !3408
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3408

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3408
  %cmp1 = icmp slt i32 %3, 257, !dbg !3408
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3410
  %land.ext = zext i1 %4 to i32, !dbg !3408
  %conv = sext i32 %land.ext to i64, !dbg !3408
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3411
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3412

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3413
  %sub = sub nsw i32 %5, 1, !dbg !3413
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 5), !dbg !3413
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tmrTimerControl*, !dbg !3413
  store %struct.tmrTimerControl* %6, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3415
  %7 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3416
  %cmp4 = icmp ne %struct.tmrTimerControl* %7, null, !dbg !3418
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3419

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3420
  %call7 = call i8* @pvTimerGetTimerID(%struct.tmrTimerControl* %8), !dbg !3422
  store i8* %call7, i8** %pvReturn, align 8, !dbg !3423
  br label %if.end, !dbg !3424

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3425

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i8*, i8** %pvReturn, align 8, !dbg !3426
  ret i8* %9, !dbg !3427
}

declare dso_local i8* @pvTimerGetTimerID(%struct.tmrTimerControl*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTimerSetTimerIDImpl(%struct.tmrTimerControl* %xTimer, i8* %pvNewID) #0 section "privileged_functions" !dbg !3428 {
entry:
  %xTimer.addr = alloca %struct.tmrTimerControl*, align 8
  %pvNewID.addr = alloca i8*, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tmrTimerControl* %xTimer, %struct.tmrTimerControl** %xTimer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xTimer.addr, metadata !3431, metadata !DIExpression()), !dbg !3432
  store i8* %pvNewID, i8** %pvNewID.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvNewID.addr, metadata !3433, metadata !DIExpression()), !dbg !3434
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3435, metadata !DIExpression()), !dbg !3436
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3436
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3437, metadata !DIExpression()), !dbg !3438
  %0 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xTimer.addr, align 8, !dbg !3439
  %1 = ptrtoint %struct.tmrTimerControl* %0 to i32, !dbg !3440
  store i32 %1, i32* %lIndex, align 4, !dbg !3441
  %2 = load i32, i32* %lIndex, align 4, !dbg !3442
  %cmp = icmp sge i32 %2, 1, !dbg !3442
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3442

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3442
  %cmp1 = icmp slt i32 %3, 257, !dbg !3442
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3444
  %land.ext = zext i1 %4 to i32, !dbg !3442
  %conv = sext i32 %land.ext to i64, !dbg !3442
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3445
  br i1 %cmp2, label %if.then, label %if.end7, !dbg !3446

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3447
  %sub = sub nsw i32 %5, 1, !dbg !3447
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 5), !dbg !3447
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tmrTimerControl*, !dbg !3447
  store %struct.tmrTimerControl* %6, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3449
  %7 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3450
  %cmp4 = icmp ne %struct.tmrTimerControl* %7, null, !dbg !3452
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3453

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3454
  %9 = load i8*, i8** %pvNewID.addr, align 8, !dbg !3456
  call void @vTimerSetTimerID(%struct.tmrTimerControl* %8, i8* %9), !dbg !3457
  br label %if.end, !dbg !3458

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end7, !dbg !3459

if.end7:                                          ; preds = %if.end, %land.end
  ret void, !dbg !3460
}

declare dso_local void @vTimerSetTimerID(%struct.tmrTimerControl*, i8*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTimerIsTimerActiveImpl(%struct.tmrTimerControl* %xTimer) #0 section "privileged_functions" !dbg !3461 {
entry:
  %xTimer.addr = alloca %struct.tmrTimerControl*, align 8
  %xReturn = alloca i64, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tmrTimerControl* %xTimer, %struct.tmrTimerControl** %xTimer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xTimer.addr, metadata !3464, metadata !DIExpression()), !dbg !3465
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3466, metadata !DIExpression()), !dbg !3467
  store i64 0, i64* %xReturn, align 8, !dbg !3467
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3468, metadata !DIExpression()), !dbg !3469
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3469
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3470, metadata !DIExpression()), !dbg !3471
  %0 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xTimer.addr, align 8, !dbg !3472
  %1 = ptrtoint %struct.tmrTimerControl* %0 to i32, !dbg !3473
  store i32 %1, i32* %lIndex, align 4, !dbg !3474
  %2 = load i32, i32* %lIndex, align 4, !dbg !3475
  %cmp = icmp sge i32 %2, 1, !dbg !3475
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3475

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3475
  %cmp1 = icmp slt i32 %3, 257, !dbg !3475
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3477
  %land.ext = zext i1 %4 to i32, !dbg !3475
  %conv = sext i32 %land.ext to i64, !dbg !3475
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3478
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3479

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3480
  %sub = sub nsw i32 %5, 1, !dbg !3480
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 5), !dbg !3480
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tmrTimerControl*, !dbg !3480
  store %struct.tmrTimerControl* %6, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3482
  %7 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3483
  %cmp4 = icmp ne %struct.tmrTimerControl* %7, null, !dbg !3485
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3486

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3487
  %call7 = call i64 @xTimerIsTimerActive(%struct.tmrTimerControl* %8), !dbg !3489
  store i64 %call7, i64* %xReturn, align 8, !dbg !3490
  br label %if.end, !dbg !3491

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3492

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !3493
  ret i64 %9, !dbg !3494
}

declare dso_local i64 @xTimerIsTimerActive(%struct.tmrTimerControl*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.tskTaskControlBlock* @MPU_xTimerGetTimerDaemonTaskHandleImpl() #0 section "privileged_functions" !dbg !3495 {
entry:
  %xReturn = alloca %struct.tskTaskControlBlock*, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xReturn, metadata !3496, metadata !DIExpression()), !dbg !3497
  %call = call %struct.tskTaskControlBlock* @xTimerGetTimerDaemonTaskHandle(), !dbg !3498
  store %struct.tskTaskControlBlock* %call, %struct.tskTaskControlBlock** %xReturn, align 8, !dbg !3499
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xReturn, align 8, !dbg !3500
  ret %struct.tskTaskControlBlock* %0, !dbg !3501
}

declare dso_local %struct.tskTaskControlBlock* @xTimerGetTimerDaemonTaskHandle() #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTimerGenericCommandImpl(%struct.tmrTimerControl* %xTimer, i64 %xCommandID, i64 %xOptionalValue, i64* %pxHigherPriorityTaskWoken, i64 %xTicksToWait) #0 section "privileged_functions" !dbg !3502 {
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
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xTimer.addr, metadata !3506, metadata !DIExpression()), !dbg !3507
  store i64 %xCommandID, i64* %xCommandID.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xCommandID.addr, metadata !3508, metadata !DIExpression()), !dbg !3509
  store i64 %xOptionalValue, i64* %xOptionalValue.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xOptionalValue.addr, metadata !3510, metadata !DIExpression()), !dbg !3511
  store i64* %pxHigherPriorityTaskWoken, i64** %pxHigherPriorityTaskWoken.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxHigherPriorityTaskWoken.addr, metadata !3512, metadata !DIExpression()), !dbg !3513
  store i64 %xTicksToWait, i64* %xTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToWait.addr, metadata !3514, metadata !DIExpression()), !dbg !3515
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3516, metadata !DIExpression()), !dbg !3517
  store i64 0, i64* %xReturn, align 8, !dbg !3517
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3518, metadata !DIExpression()), !dbg !3519
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3519
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3520, metadata !DIExpression()), !dbg !3521
  call void @llvm.dbg.declare(metadata i64* %xIsHigherPriorityTaskWokenWriteable, metadata !3522, metadata !DIExpression()), !dbg !3523
  store i64 0, i64* %xIsHigherPriorityTaskWokenWriteable, align 8, !dbg !3523
  %0 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !3524
  %cmp = icmp ne i64* %0, null, !dbg !3526
  br i1 %cmp, label %if.then, label %if.end, !dbg !3527

if.then:                                          ; preds = %entry
  %1 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !3528
  %2 = bitcast i64* %1 to i8*, !dbg !3528
  %call = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %2, i32 8, i32 2), !dbg !3530
  store i64 %call, i64* %xIsHigherPriorityTaskWokenWriteable, align 8, !dbg !3531
  br label %if.end, !dbg !3532

if.end:                                           ; preds = %if.then, %entry
  %3 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !3533
  %cmp1 = icmp eq i64* %3, null, !dbg !3535
  br i1 %cmp1, label %if.then3, label %lor.lhs.false, !dbg !3536

lor.lhs.false:                                    ; preds = %if.end
  %4 = load i64, i64* %xIsHigherPriorityTaskWokenWriteable, align 8, !dbg !3537
  %cmp2 = icmp eq i64 %4, 1, !dbg !3538
  br i1 %cmp2, label %if.then3, label %if.end16, !dbg !3539

if.then3:                                         ; preds = %lor.lhs.false, %if.end
  %5 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xTimer.addr, align 8, !dbg !3540
  %6 = ptrtoint %struct.tmrTimerControl* %5 to i32, !dbg !3542
  store i32 %6, i32* %lIndex, align 4, !dbg !3543
  %7 = load i32, i32* %lIndex, align 4, !dbg !3544
  %cmp4 = icmp sge i32 %7, 1, !dbg !3544
  br i1 %cmp4, label %land.rhs, label %land.end, !dbg !3544

land.rhs:                                         ; preds = %if.then3
  %8 = load i32, i32* %lIndex, align 4, !dbg !3544
  %cmp5 = icmp slt i32 %8, 257, !dbg !3544
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.then3
  %9 = phi i1 [ false, %if.then3 ], [ %cmp5, %land.rhs ], !dbg !3546
  %land.ext = zext i1 %9 to i32, !dbg !3544
  %conv = sext i32 %land.ext to i64, !dbg !3544
  %cmp6 = icmp ne i64 %conv, 0, !dbg !3547
  br i1 %cmp6, label %if.then8, label %if.end15, !dbg !3548

if.then8:                                         ; preds = %land.end
  %10 = load i32, i32* %lIndex, align 4, !dbg !3549
  %sub = sub nsw i32 %10, 1, !dbg !3549
  %call9 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 5), !dbg !3549
  %11 = bitcast %struct.OpaqueObject* %call9 to %struct.tmrTimerControl*, !dbg !3549
  store %struct.tmrTimerControl* %11, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3551
  %12 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3552
  %cmp10 = icmp ne %struct.tmrTimerControl* %12, null, !dbg !3554
  br i1 %cmp10, label %if.then12, label %if.end14, !dbg !3555

if.then12:                                        ; preds = %if.then8
  %13 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3556
  %14 = load i64, i64* %xCommandID.addr, align 8, !dbg !3558
  %15 = load i64, i64* %xOptionalValue.addr, align 8, !dbg !3559
  %16 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !3560
  %17 = load i64, i64* %xTicksToWait.addr, align 8, !dbg !3561
  %call13 = call i64 @xTimerGenericCommand(%struct.tmrTimerControl* %13, i64 %14, i64 %15, i64* %16, i64 %17), !dbg !3562
  store i64 %call13, i64* %xReturn, align 8, !dbg !3563
  br label %if.end14, !dbg !3564

if.end14:                                         ; preds = %if.then12, %if.then8
  br label %if.end15, !dbg !3565

if.end15:                                         ; preds = %if.end14, %land.end
  br label %if.end16, !dbg !3566

if.end16:                                         ; preds = %if.end15, %lor.lhs.false
  %18 = load i64, i64* %xReturn, align 8, !dbg !3567
  ret i64 %18, !dbg !3568
}

declare dso_local i64 @xTimerGenericCommand(%struct.tmrTimerControl*, i64, i64, i64*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @MPU_pcTimerGetNameImpl(%struct.tmrTimerControl* %xTimer) #0 section "privileged_functions" !dbg !3569 {
entry:
  %xTimer.addr = alloca %struct.tmrTimerControl*, align 8
  %pcReturn = alloca i8*, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tmrTimerControl* %xTimer, %struct.tmrTimerControl** %xTimer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xTimer.addr, metadata !3572, metadata !DIExpression()), !dbg !3573
  call void @llvm.dbg.declare(metadata i8** %pcReturn, metadata !3574, metadata !DIExpression()), !dbg !3575
  store i8* null, i8** %pcReturn, align 8, !dbg !3575
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3576, metadata !DIExpression()), !dbg !3577
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3577
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3578, metadata !DIExpression()), !dbg !3579
  %0 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xTimer.addr, align 8, !dbg !3580
  %1 = ptrtoint %struct.tmrTimerControl* %0 to i32, !dbg !3581
  store i32 %1, i32* %lIndex, align 4, !dbg !3582
  %2 = load i32, i32* %lIndex, align 4, !dbg !3583
  %cmp = icmp sge i32 %2, 1, !dbg !3583
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3583

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3583
  %cmp1 = icmp slt i32 %3, 257, !dbg !3583
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3585
  %land.ext = zext i1 %4 to i32, !dbg !3583
  %conv = sext i32 %land.ext to i64, !dbg !3583
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3586
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3587

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3588
  %sub = sub nsw i32 %5, 1, !dbg !3588
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 5), !dbg !3588
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tmrTimerControl*, !dbg !3588
  store %struct.tmrTimerControl* %6, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3590
  %7 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3591
  %cmp4 = icmp ne %struct.tmrTimerControl* %7, null, !dbg !3593
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3594

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3595
  %call7 = call i8* @pcTimerGetName(%struct.tmrTimerControl* %8), !dbg !3597
  store i8* %call7, i8** %pcReturn, align 8, !dbg !3598
  br label %if.end, !dbg !3599

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3600

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i8*, i8** %pcReturn, align 8, !dbg !3601
  ret i8* %9, !dbg !3602
}

declare dso_local i8* @pcTimerGetName(%struct.tmrTimerControl*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vTimerSetReloadModeImpl(%struct.tmrTimerControl* %xTimer, i64 %uxAutoReload) #0 section "privileged_functions" !dbg !3603 {
entry:
  %xTimer.addr = alloca %struct.tmrTimerControl*, align 8
  %uxAutoReload.addr = alloca i64, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tmrTimerControl* %xTimer, %struct.tmrTimerControl** %xTimer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xTimer.addr, metadata !3606, metadata !DIExpression()), !dbg !3607
  store i64 %uxAutoReload, i64* %uxAutoReload.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxAutoReload.addr, metadata !3608, metadata !DIExpression()), !dbg !3609
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3610, metadata !DIExpression()), !dbg !3611
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3611
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3612, metadata !DIExpression()), !dbg !3613
  %0 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xTimer.addr, align 8, !dbg !3614
  %1 = ptrtoint %struct.tmrTimerControl* %0 to i32, !dbg !3615
  store i32 %1, i32* %lIndex, align 4, !dbg !3616
  %2 = load i32, i32* %lIndex, align 4, !dbg !3617
  %cmp = icmp sge i32 %2, 1, !dbg !3617
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3617

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3617
  %cmp1 = icmp slt i32 %3, 257, !dbg !3617
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3619
  %land.ext = zext i1 %4 to i32, !dbg !3617
  %conv = sext i32 %land.ext to i64, !dbg !3617
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3620
  br i1 %cmp2, label %if.then, label %if.end7, !dbg !3621

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3622
  %sub = sub nsw i32 %5, 1, !dbg !3622
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 5), !dbg !3622
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tmrTimerControl*, !dbg !3622
  store %struct.tmrTimerControl* %6, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3624
  %7 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3625
  %cmp4 = icmp ne %struct.tmrTimerControl* %7, null, !dbg !3627
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3628

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3629
  %9 = load i64, i64* %uxAutoReload.addr, align 8, !dbg !3631
  call void @vTimerSetReloadMode(%struct.tmrTimerControl* %8, i64 %9), !dbg !3632
  br label %if.end, !dbg !3633

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end7, !dbg !3634

if.end7:                                          ; preds = %if.end, %land.end
  ret void, !dbg !3635
}

declare dso_local void @vTimerSetReloadMode(%struct.tmrTimerControl*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTimerGetReloadModeImpl(%struct.tmrTimerControl* %xTimer) #0 section "privileged_functions" !dbg !3636 {
entry:
  %xTimer.addr = alloca %struct.tmrTimerControl*, align 8
  %xReturn = alloca i64, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tmrTimerControl* %xTimer, %struct.tmrTimerControl** %xTimer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xTimer.addr, metadata !3637, metadata !DIExpression()), !dbg !3638
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3639, metadata !DIExpression()), !dbg !3640
  store i64 0, i64* %xReturn, align 8, !dbg !3640
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3641, metadata !DIExpression()), !dbg !3642
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3642
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3643, metadata !DIExpression()), !dbg !3644
  %0 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xTimer.addr, align 8, !dbg !3645
  %1 = ptrtoint %struct.tmrTimerControl* %0 to i32, !dbg !3646
  store i32 %1, i32* %lIndex, align 4, !dbg !3647
  %2 = load i32, i32* %lIndex, align 4, !dbg !3648
  %cmp = icmp sge i32 %2, 1, !dbg !3648
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3648

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3648
  %cmp1 = icmp slt i32 %3, 257, !dbg !3648
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3650
  %land.ext = zext i1 %4 to i32, !dbg !3648
  %conv = sext i32 %land.ext to i64, !dbg !3648
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3651
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3652

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3653
  %sub = sub nsw i32 %5, 1, !dbg !3653
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 5), !dbg !3653
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tmrTimerControl*, !dbg !3653
  store %struct.tmrTimerControl* %6, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3655
  %7 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3656
  %cmp4 = icmp ne %struct.tmrTimerControl* %7, null, !dbg !3658
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3659

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3660
  %call7 = call i64 @xTimerGetReloadMode(%struct.tmrTimerControl* %8), !dbg !3662
  store i64 %call7, i64* %xReturn, align 8, !dbg !3663
  br label %if.end, !dbg !3664

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3665

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !3666
  ret i64 %9, !dbg !3667
}

declare dso_local i64 @xTimerGetReloadMode(%struct.tmrTimerControl*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_uxTimerGetReloadModeImpl(%struct.tmrTimerControl* %xTimer) #0 section "privileged_functions" !dbg !3668 {
entry:
  %xTimer.addr = alloca %struct.tmrTimerControl*, align 8
  %uxReturn = alloca i64, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tmrTimerControl* %xTimer, %struct.tmrTimerControl** %xTimer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xTimer.addr, metadata !3671, metadata !DIExpression()), !dbg !3672
  call void @llvm.dbg.declare(metadata i64* %uxReturn, metadata !3673, metadata !DIExpression()), !dbg !3674
  store i64 0, i64* %uxReturn, align 8, !dbg !3674
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3675, metadata !DIExpression()), !dbg !3676
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3676
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3677, metadata !DIExpression()), !dbg !3678
  %0 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xTimer.addr, align 8, !dbg !3679
  %1 = ptrtoint %struct.tmrTimerControl* %0 to i32, !dbg !3680
  store i32 %1, i32* %lIndex, align 4, !dbg !3681
  %2 = load i32, i32* %lIndex, align 4, !dbg !3682
  %cmp = icmp sge i32 %2, 1, !dbg !3682
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3682

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3682
  %cmp1 = icmp slt i32 %3, 257, !dbg !3682
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3684
  %land.ext = zext i1 %4 to i32, !dbg !3682
  %conv = sext i32 %land.ext to i64, !dbg !3682
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3685
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3686

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3687
  %sub = sub nsw i32 %5, 1, !dbg !3687
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 5), !dbg !3687
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tmrTimerControl*, !dbg !3687
  store %struct.tmrTimerControl* %6, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3689
  %7 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3690
  %cmp4 = icmp ne %struct.tmrTimerControl* %7, null, !dbg !3692
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3693

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3694
  %call7 = call i64 @uxTimerGetReloadMode(%struct.tmrTimerControl* %8), !dbg !3696
  store i64 %call7, i64* %uxReturn, align 8, !dbg !3697
  br label %if.end, !dbg !3698

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3699

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %uxReturn, align 8, !dbg !3700
  ret i64 %9, !dbg !3701
}

declare dso_local i64 @uxTimerGetReloadMode(%struct.tmrTimerControl*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTimerGetPeriodImpl(%struct.tmrTimerControl* %xTimer) #0 section "privileged_functions" !dbg !3702 {
entry:
  %xTimer.addr = alloca %struct.tmrTimerControl*, align 8
  %xReturn = alloca i64, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tmrTimerControl* %xTimer, %struct.tmrTimerControl** %xTimer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xTimer.addr, metadata !3705, metadata !DIExpression()), !dbg !3706
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3707, metadata !DIExpression()), !dbg !3708
  store i64 0, i64* %xReturn, align 8, !dbg !3708
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3709, metadata !DIExpression()), !dbg !3710
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3710
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3711, metadata !DIExpression()), !dbg !3712
  %0 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xTimer.addr, align 8, !dbg !3713
  %1 = ptrtoint %struct.tmrTimerControl* %0 to i32, !dbg !3714
  store i32 %1, i32* %lIndex, align 4, !dbg !3715
  %2 = load i32, i32* %lIndex, align 4, !dbg !3716
  %cmp = icmp sge i32 %2, 1, !dbg !3716
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3716

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3716
  %cmp1 = icmp slt i32 %3, 257, !dbg !3716
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3718
  %land.ext = zext i1 %4 to i32, !dbg !3716
  %conv = sext i32 %land.ext to i64, !dbg !3716
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3719
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3720

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3721
  %sub = sub nsw i32 %5, 1, !dbg !3721
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 5), !dbg !3721
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tmrTimerControl*, !dbg !3721
  store %struct.tmrTimerControl* %6, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3723
  %7 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3724
  %cmp4 = icmp ne %struct.tmrTimerControl* %7, null, !dbg !3726
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3727

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3728
  %call7 = call i64 @xTimerGetPeriod(%struct.tmrTimerControl* %8), !dbg !3730
  store i64 %call7, i64* %xReturn, align 8, !dbg !3731
  br label %if.end, !dbg !3732

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3733

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !3734
  ret i64 %9, !dbg !3735
}

declare dso_local i64 @xTimerGetPeriod(%struct.tmrTimerControl*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTimerGetExpiryTimeImpl(%struct.tmrTimerControl* %xTimer) #0 section "privileged_functions" !dbg !3736 {
entry:
  %xTimer.addr = alloca %struct.tmrTimerControl*, align 8
  %xReturn = alloca i64, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  store %struct.tmrTimerControl* %xTimer, %struct.tmrTimerControl** %xTimer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xTimer.addr, metadata !3737, metadata !DIExpression()), !dbg !3738
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3739, metadata !DIExpression()), !dbg !3740
  store i64 0, i64* %xReturn, align 8, !dbg !3740
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3741, metadata !DIExpression()), !dbg !3742
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3742
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3743, metadata !DIExpression()), !dbg !3744
  %0 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xTimer.addr, align 8, !dbg !3745
  %1 = ptrtoint %struct.tmrTimerControl* %0 to i32, !dbg !3746
  store i32 %1, i32* %lIndex, align 4, !dbg !3747
  %2 = load i32, i32* %lIndex, align 4, !dbg !3748
  %cmp = icmp sge i32 %2, 1, !dbg !3748
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3748

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3748
  %cmp1 = icmp slt i32 %3, 257, !dbg !3748
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3750
  %land.ext = zext i1 %4 to i32, !dbg !3748
  %conv = sext i32 %land.ext to i64, !dbg !3748
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3751
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3752

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3753
  %sub = sub nsw i32 %5, 1, !dbg !3753
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 5), !dbg !3753
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tmrTimerControl*, !dbg !3753
  store %struct.tmrTimerControl* %6, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3755
  %7 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3756
  %cmp4 = icmp ne %struct.tmrTimerControl* %7, null, !dbg !3758
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3759

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3760
  %call7 = call i64 @xTimerGetExpiryTime(%struct.tmrTimerControl* %8), !dbg !3762
  store i64 %call7, i64* %xReturn, align 8, !dbg !3763
  br label %if.end, !dbg !3764

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3765

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !3766
  ret i64 %9, !dbg !3767
}

declare dso_local i64 @xTimerGetExpiryTime(%struct.tmrTimerControl*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.tmrTimerControl* @MPU_xTimerCreate(i8* %pcTimerName, i64 %xTimerPeriodInTicks, i64 %uxAutoReload, i8* %pvTimerID, void (%struct.tmrTimerControl*)* %pxCallbackFunction) #0 section "privileged_functions" !dbg !3768 {
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
  call void @llvm.dbg.declare(metadata i8** %pcTimerName.addr, metadata !3771, metadata !DIExpression()), !dbg !3772
  store i64 %xTimerPeriodInTicks, i64* %xTimerPeriodInTicks.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTimerPeriodInTicks.addr, metadata !3773, metadata !DIExpression()), !dbg !3774
  store i64 %uxAutoReload, i64* %uxAutoReload.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxAutoReload.addr, metadata !3775, metadata !DIExpression()), !dbg !3776
  store i8* %pvTimerID, i8** %pvTimerID.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvTimerID.addr, metadata !3777, metadata !DIExpression()), !dbg !3778
  store void (%struct.tmrTimerControl*)* %pxCallbackFunction, void (%struct.tmrTimerControl*)** %pxCallbackFunction.addr, align 8
  call void @llvm.dbg.declare(metadata void (%struct.tmrTimerControl*)** %pxCallbackFunction.addr, metadata !3779, metadata !DIExpression()), !dbg !3780
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3781, metadata !DIExpression()), !dbg !3782
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3782
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xExternalTimerHandle, metadata !3783, metadata !DIExpression()), !dbg !3784
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xExternalTimerHandle, align 8, !dbg !3784
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3785, metadata !DIExpression()), !dbg !3786
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !3787
  store i32 %call, i32* %lIndex, align 4, !dbg !3788
  %0 = load i32, i32* %lIndex, align 4, !dbg !3789
  %cmp = icmp ne i32 %0, -1, !dbg !3791
  br i1 %cmp, label %if.then, label %if.end4, !dbg !3792

if.then:                                          ; preds = %entry
  %1 = load i8*, i8** %pcTimerName.addr, align 8, !dbg !3793
  %2 = load i64, i64* %xTimerPeriodInTicks.addr, align 8, !dbg !3795
  %3 = load i64, i64* %uxAutoReload.addr, align 8, !dbg !3796
  %4 = load i8*, i8** %pvTimerID.addr, align 8, !dbg !3797
  %call1 = call %struct.tmrTimerControl* @xTimerCreate(i8* %1, i64 %2, i64 %3, i8* %4, void (%struct.tmrTimerControl*)* @MPU_TimerCallback), !dbg !3798
  store %struct.tmrTimerControl* %call1, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3799
  %5 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3800
  %cmp2 = icmp ne %struct.tmrTimerControl* %5, null, !dbg !3802
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !3803

if.then3:                                         ; preds = %if.then
  %6 = load i32, i32* %lIndex, align 4, !dbg !3804
  %7 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3804
  %8 = bitcast %struct.tmrTimerControl* %7 to %struct.OpaqueObject*, !dbg !3804
  %9 = load void (%struct.tmrTimerControl*)*, void (%struct.tmrTimerControl*)** %pxCallbackFunction.addr, align 8, !dbg !3804
  %10 = bitcast void (%struct.tmrTimerControl*)* %9 to i8*, !dbg !3804
  call void @MPU_StoreHandleAndDataAtIndex(i32 %6, %struct.OpaqueObject* %8, i8* %10, i32 5), !dbg !3804
  %11 = load i32, i32* %lIndex, align 4, !dbg !3806
  %add = add nsw i32 %11, 1, !dbg !3806
  %conv = sext i32 %add to i64, !dbg !3807
  %12 = inttoptr i64 %conv to %struct.tmrTimerControl*, !dbg !3807
  store %struct.tmrTimerControl* %12, %struct.tmrTimerControl** %xExternalTimerHandle, align 8, !dbg !3808
  br label %if.end, !dbg !3809

if.else:                                          ; preds = %if.then
  %13 = load i32, i32* %lIndex, align 4, !dbg !3810
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %13), !dbg !3812
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  br label %if.end4, !dbg !3813

if.end4:                                          ; preds = %if.end, %entry
  %14 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xExternalTimerHandle, align 8, !dbg !3814
  ret %struct.tmrTimerControl* %14, !dbg !3815
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @MPU_TimerCallback(%struct.tmrTimerControl* %xInternalHandle) #0 section "privileged_functions" !dbg !3816 {
entry:
  %xInternalHandle.addr = alloca %struct.tmrTimerControl*, align 8
  %i = alloca i32, align 4
  %lIndex = alloca i32, align 4
  %xExternalHandle = alloca %struct.tmrTimerControl*, align 8
  %pxApplicationCallBack = alloca void (%struct.tmrTimerControl*)*, align 8
  store %struct.tmrTimerControl* %xInternalHandle, %struct.tmrTimerControl** %xInternalHandle.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalHandle.addr, metadata !3817, metadata !DIExpression()), !dbg !3818
  call void @llvm.dbg.declare(metadata i32* %i, metadata !3819, metadata !DIExpression()), !dbg !3820
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3821, metadata !DIExpression()), !dbg !3822
  store i32 -1, i32* %lIndex, align 4, !dbg !3822
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xExternalHandle, metadata !3823, metadata !DIExpression()), !dbg !3824
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xExternalHandle, align 8, !dbg !3824
  call void @llvm.dbg.declare(metadata void (%struct.tmrTimerControl*)** %pxApplicationCallBack, metadata !3825, metadata !DIExpression()), !dbg !3826
  store void (%struct.tmrTimerControl*)* null, void (%struct.tmrTimerControl*)** %pxApplicationCallBack, align 8, !dbg !3826
  %0 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalHandle.addr, align 8, !dbg !3827
  %cmp = icmp ne %struct.tmrTimerControl* %0, null, !dbg !3827
  %conv = zext i1 %cmp to i32, !dbg !3827
  %cmp1 = icmp eq i32 %conv, 0, !dbg !3827
  br i1 %cmp1, label %if.then, label %if.end, !dbg !3829

if.then:                                          ; preds = %entry
  call void @vAssertCalled(i8* getelementptr inbounds ([68 x i8], [68 x i8]* @.str, i64 0, i64 0), i64 332), !dbg !3827
  br label %if.end, !dbg !3827

if.end:                                           ; preds = %if.then, %entry
  store i32 0, i32* %i, align 4, !dbg !3830
  br label %for.cond, !dbg !3832

for.cond:                                         ; preds = %for.inc, %if.end
  %1 = load i32, i32* %i, align 4, !dbg !3833
  %cmp3 = icmp slt i32 %1, 256, !dbg !3835
  br i1 %cmp3, label %for.body, label %for.end, !dbg !3836

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %i, align 4, !dbg !3837
  %idxprom = sext i32 %2 to i64, !dbg !3840
  %arrayidx = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom, !dbg !3840
  %xInternalObjectHandle = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx, i32 0, i32 0, !dbg !3841
  %3 = load %struct.OpaqueObject*, %struct.OpaqueObject** %xInternalObjectHandle, align 8, !dbg !3841
  %4 = bitcast %struct.OpaqueObject* %3 to %struct.tmrTimerControl*, !dbg !3842
  %5 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalHandle.addr, align 8, !dbg !3843
  %cmp5 = icmp eq %struct.tmrTimerControl* %4, %5, !dbg !3844
  br i1 %cmp5, label %land.lhs.true, label %if.end13, !dbg !3845

land.lhs.true:                                    ; preds = %for.body
  %6 = load i32, i32* %i, align 4, !dbg !3846
  %idxprom7 = sext i32 %6 to i64, !dbg !3847
  %arrayidx8 = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom7, !dbg !3847
  %ulKernelObjectType = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx8, i32 0, i32 1, !dbg !3848
  %7 = load i32, i32* %ulKernelObjectType, align 8, !dbg !3848
  %conv9 = zext i32 %7 to i64, !dbg !3847
  %cmp10 = icmp eq i64 %conv9, 5, !dbg !3849
  br i1 %cmp10, label %if.then12, label %if.end13, !dbg !3850

if.then12:                                        ; preds = %land.lhs.true
  %8 = load i32, i32* %i, align 4, !dbg !3851
  store i32 %8, i32* %lIndex, align 4, !dbg !3853
  br label %for.end, !dbg !3854

if.end13:                                         ; preds = %land.lhs.true, %for.body
  br label %for.inc, !dbg !3855

for.inc:                                          ; preds = %if.end13
  %9 = load i32, i32* %i, align 4, !dbg !3856
  %inc = add nsw i32 %9, 1, !dbg !3856
  store i32 %inc, i32* %i, align 4, !dbg !3856
  br label %for.cond, !dbg !3857, !llvm.loop !3858

for.end:                                          ; preds = %if.then12, %for.cond
  %10 = load i32, i32* %lIndex, align 4, !dbg !3860
  %cmp14 = icmp ne i32 %10, -1, !dbg !3860
  %conv15 = zext i1 %cmp14 to i32, !dbg !3860
  %cmp16 = icmp eq i32 %conv15, 0, !dbg !3860
  br i1 %cmp16, label %if.then18, label %if.end19, !dbg !3862

if.then18:                                        ; preds = %for.end
  call void @vAssertCalled(i8* getelementptr inbounds ([68 x i8], [68 x i8]* @.str, i64 0, i64 0), i64 344), !dbg !3860
  br label %if.end19, !dbg !3860

if.end19:                                         ; preds = %if.then18, %for.end
  %11 = load i32, i32* %lIndex, align 4, !dbg !3863
  %add = add nsw i32 %11, 1, !dbg !3863
  %conv20 = sext i32 %add to i64, !dbg !3864
  %12 = inttoptr i64 %conv20 to %struct.tmrTimerControl*, !dbg !3864
  store %struct.tmrTimerControl* %12, %struct.tmrTimerControl** %xExternalHandle, align 8, !dbg !3865
  %13 = load i32, i32* %lIndex, align 4, !dbg !3866
  %idxprom21 = sext i32 %13 to i64, !dbg !3867
  %arrayidx22 = getelementptr inbounds [256 x %struct.KernelObject], [256 x %struct.KernelObject]* @xKernelObjectPool, i64 0, i64 %idxprom21, !dbg !3867
  %pvKernelObjectData = getelementptr inbounds %struct.KernelObject, %struct.KernelObject* %arrayidx22, i32 0, i32 2, !dbg !3868
  %14 = load i8*, i8** %pvKernelObjectData, align 8, !dbg !3868
  %15 = bitcast i8* %14 to void (%struct.tmrTimerControl*)*, !dbg !3869
  store void (%struct.tmrTimerControl*)* %15, void (%struct.tmrTimerControl*)** %pxApplicationCallBack, align 8, !dbg !3870
  %16 = load void (%struct.tmrTimerControl*)*, void (%struct.tmrTimerControl*)** %pxApplicationCallBack, align 8, !dbg !3871
  %17 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xExternalHandle, align 8, !dbg !3872
  call void %16(%struct.tmrTimerControl* %17), !dbg !3871
  ret void, !dbg !3873
}

declare dso_local %struct.tmrTimerControl* @xTimerCreate(i8*, i64, i64, i8*, void (%struct.tmrTimerControl*)*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.tmrTimerControl* @MPU_xTimerCreateStatic(i8* %pcTimerName, i64 %xTimerPeriodInTicks, i64 %uxAutoReload, i8* %pvTimerID, void (%struct.tmrTimerControl*)* %pxCallbackFunction, %struct.xSTATIC_TIMER* %pxTimerBuffer) #0 section "privileged_functions" !dbg !3874 {
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
  call void @llvm.dbg.declare(metadata i8** %pcTimerName.addr, metadata !3888, metadata !DIExpression()), !dbg !3889
  store i64 %xTimerPeriodInTicks, i64* %xTimerPeriodInTicks.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTimerPeriodInTicks.addr, metadata !3890, metadata !DIExpression()), !dbg !3891
  store i64 %uxAutoReload, i64* %uxAutoReload.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxAutoReload.addr, metadata !3892, metadata !DIExpression()), !dbg !3893
  store i8* %pvTimerID, i8** %pvTimerID.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvTimerID.addr, metadata !3894, metadata !DIExpression()), !dbg !3895
  store void (%struct.tmrTimerControl*)* %pxCallbackFunction, void (%struct.tmrTimerControl*)** %pxCallbackFunction.addr, align 8
  call void @llvm.dbg.declare(metadata void (%struct.tmrTimerControl*)** %pxCallbackFunction.addr, metadata !3896, metadata !DIExpression()), !dbg !3897
  store %struct.xSTATIC_TIMER* %pxTimerBuffer, %struct.xSTATIC_TIMER** %pxTimerBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xSTATIC_TIMER** %pxTimerBuffer.addr, metadata !3898, metadata !DIExpression()), !dbg !3899
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3900, metadata !DIExpression()), !dbg !3901
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3901
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xExternalTimerHandle, metadata !3902, metadata !DIExpression()), !dbg !3903
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xExternalTimerHandle, align 8, !dbg !3903
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3904, metadata !DIExpression()), !dbg !3905
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !3906
  store i32 %call, i32* %lIndex, align 4, !dbg !3907
  %0 = load i32, i32* %lIndex, align 4, !dbg !3908
  %cmp = icmp ne i32 %0, -1, !dbg !3910
  br i1 %cmp, label %if.then, label %if.end4, !dbg !3911

if.then:                                          ; preds = %entry
  %1 = load i8*, i8** %pcTimerName.addr, align 8, !dbg !3912
  %2 = load i64, i64* %xTimerPeriodInTicks.addr, align 8, !dbg !3914
  %3 = load i64, i64* %uxAutoReload.addr, align 8, !dbg !3915
  %4 = load i8*, i8** %pvTimerID.addr, align 8, !dbg !3916
  %5 = load %struct.xSTATIC_TIMER*, %struct.xSTATIC_TIMER** %pxTimerBuffer.addr, align 8, !dbg !3917
  %call1 = call %struct.tmrTimerControl* @xTimerCreateStatic(i8* %1, i64 %2, i64 %3, i8* %4, void (%struct.tmrTimerControl*)* @MPU_TimerCallback, %struct.xSTATIC_TIMER* %5), !dbg !3918
  store %struct.tmrTimerControl* %call1, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3919
  %6 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3920
  %cmp2 = icmp ne %struct.tmrTimerControl* %6, null, !dbg !3922
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !3923

if.then3:                                         ; preds = %if.then
  %7 = load i32, i32* %lIndex, align 4, !dbg !3924
  %8 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3924
  %9 = bitcast %struct.tmrTimerControl* %8 to %struct.OpaqueObject*, !dbg !3924
  %10 = load void (%struct.tmrTimerControl*)*, void (%struct.tmrTimerControl*)** %pxCallbackFunction.addr, align 8, !dbg !3924
  %11 = bitcast void (%struct.tmrTimerControl*)* %10 to i8*, !dbg !3924
  call void @MPU_StoreHandleAndDataAtIndex(i32 %7, %struct.OpaqueObject* %9, i8* %11, i32 5), !dbg !3924
  %12 = load i32, i32* %lIndex, align 4, !dbg !3926
  %add = add nsw i32 %12, 1, !dbg !3926
  %conv = sext i32 %add to i64, !dbg !3927
  %13 = inttoptr i64 %conv to %struct.tmrTimerControl*, !dbg !3927
  store %struct.tmrTimerControl* %13, %struct.tmrTimerControl** %xExternalTimerHandle, align 8, !dbg !3928
  br label %if.end, !dbg !3929

if.else:                                          ; preds = %if.then
  %14 = load i32, i32* %lIndex, align 4, !dbg !3930
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %14), !dbg !3932
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  br label %if.end4, !dbg !3933

if.end4:                                          ; preds = %if.end, %entry
  %15 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xExternalTimerHandle, align 8, !dbg !3934
  ret %struct.tmrTimerControl* %15, !dbg !3935
}

declare dso_local %struct.tmrTimerControl* @xTimerCreateStatic(i8*, i64, i64, i8*, void (%struct.tmrTimerControl*)*, %struct.xSTATIC_TIMER*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xTimerGetStaticBuffer(%struct.tmrTimerControl* %xTimer, %struct.xSTATIC_TIMER** %ppxTimerBuffer) #0 section "privileged_functions" !dbg !3936 {
entry:
  %xTimer.addr = alloca %struct.tmrTimerControl*, align 8
  %ppxTimerBuffer.addr = alloca %struct.xSTATIC_TIMER**, align 8
  %xInternalTimerHandle = alloca %struct.tmrTimerControl*, align 8
  %lIndex = alloca i32, align 4
  %xReturn = alloca i64, align 8
  store %struct.tmrTimerControl* %xTimer, %struct.tmrTimerControl** %xTimer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xTimer.addr, metadata !3940, metadata !DIExpression()), !dbg !3941
  store %struct.xSTATIC_TIMER** %ppxTimerBuffer, %struct.xSTATIC_TIMER*** %ppxTimerBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xSTATIC_TIMER*** %ppxTimerBuffer.addr, metadata !3942, metadata !DIExpression()), !dbg !3943
  call void @llvm.dbg.declare(metadata %struct.tmrTimerControl** %xInternalTimerHandle, metadata !3944, metadata !DIExpression()), !dbg !3945
  store %struct.tmrTimerControl* null, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3945
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3946, metadata !DIExpression()), !dbg !3947
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3948, metadata !DIExpression()), !dbg !3949
  store i64 0, i64* %xReturn, align 8, !dbg !3949
  %0 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xTimer.addr, align 8, !dbg !3950
  %1 = ptrtoint %struct.tmrTimerControl* %0 to i32, !dbg !3951
  store i32 %1, i32* %lIndex, align 4, !dbg !3952
  %2 = load i32, i32* %lIndex, align 4, !dbg !3953
  %cmp = icmp sge i32 %2, 1, !dbg !3953
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3953

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3953
  %cmp1 = icmp slt i32 %3, 257, !dbg !3953
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !3955
  %land.ext = zext i1 %4 to i32, !dbg !3953
  %conv = sext i32 %land.ext to i64, !dbg !3953
  %cmp2 = icmp ne i64 %conv, 0, !dbg !3956
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !3957

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !3958
  %sub = sub nsw i32 %5, 1, !dbg !3958
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 5), !dbg !3958
  %6 = bitcast %struct.OpaqueObject* %call to %struct.tmrTimerControl*, !dbg !3958
  store %struct.tmrTimerControl* %6, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3960
  %7 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3961
  %cmp4 = icmp ne %struct.tmrTimerControl* %7, null, !dbg !3963
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !3964

if.then6:                                         ; preds = %if.then
  %8 = load %struct.tmrTimerControl*, %struct.tmrTimerControl** %xInternalTimerHandle, align 8, !dbg !3965
  %9 = load %struct.xSTATIC_TIMER**, %struct.xSTATIC_TIMER*** %ppxTimerBuffer.addr, align 8, !dbg !3967
  %call7 = call i64 @xTimerGetStaticBuffer(%struct.tmrTimerControl* %8, %struct.xSTATIC_TIMER** %9), !dbg !3968
  store i64 %call7, i64* %xReturn, align 8, !dbg !3969
  br label %if.end, !dbg !3970

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !3971

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !3972
  ret i64 %10, !dbg !3973
}

declare dso_local i64 @xTimerGetStaticBuffer(%struct.tmrTimerControl*, %struct.xSTATIC_TIMER**) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xEventGroupWaitBitsImpl(%struct.EventGroupDef_t* %xEventGroup, i64 %uxBitsToWaitFor, i64 %xClearOnExit, i64 %xWaitForAllBits, i64 %xTicksToWait) #0 section "privileged_functions" !dbg !3974 {
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
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xEventGroup.addr, metadata !3979, metadata !DIExpression()), !dbg !3980
  store i64 %uxBitsToWaitFor, i64* %uxBitsToWaitFor.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxBitsToWaitFor.addr, metadata !3981, metadata !DIExpression()), !dbg !3982
  store i64 %xClearOnExit, i64* %xClearOnExit.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xClearOnExit.addr, metadata !3983, metadata !DIExpression()), !dbg !3984
  store i64 %xWaitForAllBits, i64* %xWaitForAllBits.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xWaitForAllBits.addr, metadata !3985, metadata !DIExpression()), !dbg !3986
  store i64 %xTicksToWait, i64* %xTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToWait.addr, metadata !3987, metadata !DIExpression()), !dbg !3988
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !3989, metadata !DIExpression()), !dbg !3990
  store i64 0, i64* %xReturn, align 8, !dbg !3990
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !3991, metadata !DIExpression()), !dbg !3992
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !3992
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !3993, metadata !DIExpression()), !dbg !3994
  %0 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xEventGroup.addr, align 8, !dbg !3995
  %1 = ptrtoint %struct.EventGroupDef_t* %0 to i32, !dbg !3996
  store i32 %1, i32* %lIndex, align 4, !dbg !3997
  %2 = load i32, i32* %lIndex, align 4, !dbg !3998
  %cmp = icmp sge i32 %2, 1, !dbg !3998
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !3998

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !3998
  %cmp1 = icmp slt i32 %3, 257, !dbg !3998
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4000
  %land.ext = zext i1 %4 to i32, !dbg !3998
  %conv = sext i32 %land.ext to i64, !dbg !3998
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4001
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4002

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4003
  %sub = sub nsw i32 %5, 1, !dbg !4003
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 4), !dbg !4003
  %6 = bitcast %struct.OpaqueObject* %call to %struct.EventGroupDef_t*, !dbg !4003
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4005
  %7 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4006
  %cmp4 = icmp ne %struct.EventGroupDef_t* %7, null, !dbg !4008
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4009

if.then6:                                         ; preds = %if.then
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4010
  %9 = load i64, i64* %uxBitsToWaitFor.addr, align 8, !dbg !4012
  %10 = load i64, i64* %xClearOnExit.addr, align 8, !dbg !4013
  %11 = load i64, i64* %xWaitForAllBits.addr, align 8, !dbg !4014
  %12 = load i64, i64* %xTicksToWait.addr, align 8, !dbg !4015
  %call7 = call i64 @xEventGroupWaitBits(%struct.EventGroupDef_t* %8, i64 %9, i64 %10, i64 %11, i64 %12), !dbg !4016
  store i64 %call7, i64* %xReturn, align 8, !dbg !4017
  br label %if.end, !dbg !4018

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4019

if.end8:                                          ; preds = %if.end, %land.end
  %13 = load i64, i64* %xReturn, align 8, !dbg !4020
  ret i64 %13, !dbg !4021
}

declare dso_local i64 @xEventGroupWaitBits(%struct.EventGroupDef_t*, i64, i64, i64, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xEventGroupClearBitsImpl(%struct.EventGroupDef_t* %xEventGroup, i64 %uxBitsToClear) #0 section "privileged_functions" !dbg !4022 {
entry:
  %xEventGroup.addr = alloca %struct.EventGroupDef_t*, align 8
  %uxBitsToClear.addr = alloca i64, align 8
  %xReturn = alloca i64, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.EventGroupDef_t* %xEventGroup, %struct.EventGroupDef_t** %xEventGroup.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xEventGroup.addr, metadata !4025, metadata !DIExpression()), !dbg !4026
  store i64 %uxBitsToClear, i64* %uxBitsToClear.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxBitsToClear.addr, metadata !4027, metadata !DIExpression()), !dbg !4028
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4029, metadata !DIExpression()), !dbg !4030
  store i64 0, i64* %xReturn, align 8, !dbg !4030
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4031, metadata !DIExpression()), !dbg !4032
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4032
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4033, metadata !DIExpression()), !dbg !4034
  %0 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xEventGroup.addr, align 8, !dbg !4035
  %1 = ptrtoint %struct.EventGroupDef_t* %0 to i32, !dbg !4036
  store i32 %1, i32* %lIndex, align 4, !dbg !4037
  %2 = load i32, i32* %lIndex, align 4, !dbg !4038
  %cmp = icmp sge i32 %2, 1, !dbg !4038
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4038

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4038
  %cmp1 = icmp slt i32 %3, 257, !dbg !4038
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4040
  %land.ext = zext i1 %4 to i32, !dbg !4038
  %conv = sext i32 %land.ext to i64, !dbg !4038
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4041
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4042

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4043
  %sub = sub nsw i32 %5, 1, !dbg !4043
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 4), !dbg !4043
  %6 = bitcast %struct.OpaqueObject* %call to %struct.EventGroupDef_t*, !dbg !4043
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4045
  %7 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4046
  %cmp4 = icmp ne %struct.EventGroupDef_t* %7, null, !dbg !4048
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4049

if.then6:                                         ; preds = %if.then
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4050
  %9 = load i64, i64* %uxBitsToClear.addr, align 8, !dbg !4052
  %call7 = call i64 @xEventGroupClearBits(%struct.EventGroupDef_t* %8, i64 %9), !dbg !4053
  store i64 %call7, i64* %xReturn, align 8, !dbg !4054
  br label %if.end, !dbg !4055

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4056

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !4057
  ret i64 %10, !dbg !4058
}

declare dso_local i64 @xEventGroupClearBits(%struct.EventGroupDef_t*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xEventGroupSetBitsImpl(%struct.EventGroupDef_t* %xEventGroup, i64 %uxBitsToSet) #0 section "privileged_functions" !dbg !4059 {
entry:
  %xEventGroup.addr = alloca %struct.EventGroupDef_t*, align 8
  %uxBitsToSet.addr = alloca i64, align 8
  %xReturn = alloca i64, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.EventGroupDef_t* %xEventGroup, %struct.EventGroupDef_t** %xEventGroup.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xEventGroup.addr, metadata !4060, metadata !DIExpression()), !dbg !4061
  store i64 %uxBitsToSet, i64* %uxBitsToSet.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxBitsToSet.addr, metadata !4062, metadata !DIExpression()), !dbg !4063
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4064, metadata !DIExpression()), !dbg !4065
  store i64 0, i64* %xReturn, align 8, !dbg !4065
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4066, metadata !DIExpression()), !dbg !4067
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4067
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4068, metadata !DIExpression()), !dbg !4069
  %0 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xEventGroup.addr, align 8, !dbg !4070
  %1 = ptrtoint %struct.EventGroupDef_t* %0 to i32, !dbg !4071
  store i32 %1, i32* %lIndex, align 4, !dbg !4072
  %2 = load i32, i32* %lIndex, align 4, !dbg !4073
  %cmp = icmp sge i32 %2, 1, !dbg !4073
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4073

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4073
  %cmp1 = icmp slt i32 %3, 257, !dbg !4073
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4075
  %land.ext = zext i1 %4 to i32, !dbg !4073
  %conv = sext i32 %land.ext to i64, !dbg !4073
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4076
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4077

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4078
  %sub = sub nsw i32 %5, 1, !dbg !4078
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 4), !dbg !4078
  %6 = bitcast %struct.OpaqueObject* %call to %struct.EventGroupDef_t*, !dbg !4078
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4080
  %7 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4081
  %cmp4 = icmp ne %struct.EventGroupDef_t* %7, null, !dbg !4083
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4084

if.then6:                                         ; preds = %if.then
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4085
  %9 = load i64, i64* %uxBitsToSet.addr, align 8, !dbg !4087
  %call7 = call i64 @xEventGroupSetBits(%struct.EventGroupDef_t* %8, i64 %9), !dbg !4088
  store i64 %call7, i64* %xReturn, align 8, !dbg !4089
  br label %if.end, !dbg !4090

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4091

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !4092
  ret i64 %10, !dbg !4093
}

declare dso_local i64 @xEventGroupSetBits(%struct.EventGroupDef_t*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xEventGroupSyncImpl(%struct.EventGroupDef_t* %xEventGroup, i64 %uxBitsToSet, i64 %uxBitsToWaitFor, i64 %xTicksToWait) #0 section "privileged_functions" !dbg !4094 {
entry:
  %xEventGroup.addr = alloca %struct.EventGroupDef_t*, align 8
  %uxBitsToSet.addr = alloca i64, align 8
  %uxBitsToWaitFor.addr = alloca i64, align 8
  %xTicksToWait.addr = alloca i64, align 8
  %xReturn = alloca i64, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.EventGroupDef_t* %xEventGroup, %struct.EventGroupDef_t** %xEventGroup.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xEventGroup.addr, metadata !4097, metadata !DIExpression()), !dbg !4098
  store i64 %uxBitsToSet, i64* %uxBitsToSet.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxBitsToSet.addr, metadata !4099, metadata !DIExpression()), !dbg !4100
  store i64 %uxBitsToWaitFor, i64* %uxBitsToWaitFor.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxBitsToWaitFor.addr, metadata !4101, metadata !DIExpression()), !dbg !4102
  store i64 %xTicksToWait, i64* %xTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToWait.addr, metadata !4103, metadata !DIExpression()), !dbg !4104
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4105, metadata !DIExpression()), !dbg !4106
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4107, metadata !DIExpression()), !dbg !4108
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4108
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4109, metadata !DIExpression()), !dbg !4110
  %0 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xEventGroup.addr, align 8, !dbg !4111
  %1 = ptrtoint %struct.EventGroupDef_t* %0 to i32, !dbg !4112
  store i32 %1, i32* %lIndex, align 4, !dbg !4113
  %2 = load i32, i32* %lIndex, align 4, !dbg !4114
  %cmp = icmp sge i32 %2, 1, !dbg !4114
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4114

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4114
  %cmp1 = icmp slt i32 %3, 257, !dbg !4114
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4116
  %land.ext = zext i1 %4 to i32, !dbg !4114
  %conv = sext i32 %land.ext to i64, !dbg !4114
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4117
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4118

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4119
  %sub = sub nsw i32 %5, 1, !dbg !4119
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 4), !dbg !4119
  %6 = bitcast %struct.OpaqueObject* %call to %struct.EventGroupDef_t*, !dbg !4119
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4121
  %7 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4122
  %cmp4 = icmp ne %struct.EventGroupDef_t* %7, null, !dbg !4124
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4125

if.then6:                                         ; preds = %if.then
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4126
  %9 = load i64, i64* %uxBitsToSet.addr, align 8, !dbg !4128
  %10 = load i64, i64* %uxBitsToWaitFor.addr, align 8, !dbg !4129
  %11 = load i64, i64* %xTicksToWait.addr, align 8, !dbg !4130
  %call7 = call i64 @xEventGroupSync(%struct.EventGroupDef_t* %8, i64 %9, i64 %10, i64 %11), !dbg !4131
  store i64 %call7, i64* %xReturn, align 8, !dbg !4132
  br label %if.end, !dbg !4133

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4134

if.end8:                                          ; preds = %if.end, %land.end
  %12 = load i64, i64* %xReturn, align 8, !dbg !4135
  ret i64 %12, !dbg !4136
}

declare dso_local i64 @xEventGroupSync(%struct.EventGroupDef_t*, i64, i64, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_uxEventGroupGetNumberImpl(i8* %xEventGroup) #0 section "privileged_functions" !dbg !4137 {
entry:
  %xEventGroup.addr = alloca i8*, align 8
  %xReturn = alloca i64, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store i8* %xEventGroup, i8** %xEventGroup.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %xEventGroup.addr, metadata !4140, metadata !DIExpression()), !dbg !4141
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4142, metadata !DIExpression()), !dbg !4143
  store i64 0, i64* %xReturn, align 8, !dbg !4143
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4144, metadata !DIExpression()), !dbg !4145
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4145
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4146, metadata !DIExpression()), !dbg !4147
  %0 = load i8*, i8** %xEventGroup.addr, align 8, !dbg !4148
  %1 = ptrtoint i8* %0 to i32, !dbg !4149
  store i32 %1, i32* %lIndex, align 4, !dbg !4150
  %2 = load i32, i32* %lIndex, align 4, !dbg !4151
  %cmp = icmp sge i32 %2, 1, !dbg !4151
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4151

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4151
  %cmp1 = icmp slt i32 %3, 257, !dbg !4151
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4153
  %land.ext = zext i1 %4 to i32, !dbg !4151
  %conv = sext i32 %land.ext to i64, !dbg !4151
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4154
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4155

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4156
  %sub = sub nsw i32 %5, 1, !dbg !4156
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 4), !dbg !4156
  %6 = bitcast %struct.OpaqueObject* %call to %struct.EventGroupDef_t*, !dbg !4156
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4158
  %7 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4159
  %cmp4 = icmp ne %struct.EventGroupDef_t* %7, null, !dbg !4161
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4162

if.then6:                                         ; preds = %if.then
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4163
  %9 = bitcast %struct.EventGroupDef_t* %8 to i8*, !dbg !4163
  %call7 = call i64 @uxEventGroupGetNumber(i8* %9), !dbg !4165
  store i64 %call7, i64* %xReturn, align 8, !dbg !4166
  br label %if.end, !dbg !4167

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4168

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !4169
  ret i64 %10, !dbg !4170
}

declare dso_local i64 @uxEventGroupGetNumber(i8*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vEventGroupSetNumberImpl(i8* %xEventGroup, i64 %uxEventGroupNumber) #0 section "privileged_functions" !dbg !4171 {
entry:
  %xEventGroup.addr = alloca i8*, align 8
  %uxEventGroupNumber.addr = alloca i64, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store i8* %xEventGroup, i8** %xEventGroup.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %xEventGroup.addr, metadata !4174, metadata !DIExpression()), !dbg !4175
  store i64 %uxEventGroupNumber, i64* %uxEventGroupNumber.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxEventGroupNumber.addr, metadata !4176, metadata !DIExpression()), !dbg !4177
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4178, metadata !DIExpression()), !dbg !4179
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4179
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4180, metadata !DIExpression()), !dbg !4181
  %0 = load i8*, i8** %xEventGroup.addr, align 8, !dbg !4182
  %1 = ptrtoint i8* %0 to i32, !dbg !4183
  store i32 %1, i32* %lIndex, align 4, !dbg !4184
  %2 = load i32, i32* %lIndex, align 4, !dbg !4185
  %cmp = icmp sge i32 %2, 1, !dbg !4185
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4185

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4185
  %cmp1 = icmp slt i32 %3, 257, !dbg !4185
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4187
  %land.ext = zext i1 %4 to i32, !dbg !4185
  %conv = sext i32 %land.ext to i64, !dbg !4185
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4188
  br i1 %cmp2, label %if.then, label %if.end7, !dbg !4189

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4190
  %sub = sub nsw i32 %5, 1, !dbg !4190
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 4), !dbg !4190
  %6 = bitcast %struct.OpaqueObject* %call to %struct.EventGroupDef_t*, !dbg !4190
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4192
  %7 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4193
  %cmp4 = icmp ne %struct.EventGroupDef_t* %7, null, !dbg !4195
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4196

if.then6:                                         ; preds = %if.then
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4197
  %9 = bitcast %struct.EventGroupDef_t* %8 to i8*, !dbg !4197
  %10 = load i64, i64* %uxEventGroupNumber.addr, align 8, !dbg !4199
  call void @vEventGroupSetNumber(i8* %9, i64 %10), !dbg !4200
  br label %if.end, !dbg !4201

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end7, !dbg !4202

if.end7:                                          ; preds = %if.end, %land.end
  ret void, !dbg !4203
}

declare dso_local void @vEventGroupSetNumber(i8*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.EventGroupDef_t* @MPU_xEventGroupCreate() #0 section "privileged_functions" !dbg !4204 {
entry:
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %xExternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4207, metadata !DIExpression()), !dbg !4208
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4208
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xExternalEventGroupHandle, metadata !4209, metadata !DIExpression()), !dbg !4210
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xExternalEventGroupHandle, align 8, !dbg !4210
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4211, metadata !DIExpression()), !dbg !4212
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !4213
  store i32 %call, i32* %lIndex, align 4, !dbg !4214
  %0 = load i32, i32* %lIndex, align 4, !dbg !4215
  %cmp = icmp ne i32 %0, -1, !dbg !4217
  br i1 %cmp, label %if.then, label %if.end4, !dbg !4218

if.then:                                          ; preds = %entry
  %call1 = call %struct.EventGroupDef_t* @xEventGroupCreate(), !dbg !4219
  store %struct.EventGroupDef_t* %call1, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4221
  %1 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4222
  %cmp2 = icmp ne %struct.EventGroupDef_t* %1, null, !dbg !4224
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !4225

if.then3:                                         ; preds = %if.then
  %2 = load i32, i32* %lIndex, align 4, !dbg !4226
  %3 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4226
  %4 = bitcast %struct.EventGroupDef_t* %3 to %struct.OpaqueObject*, !dbg !4226
  call void @MPU_StoreHandleAndDataAtIndex(i32 %2, %struct.OpaqueObject* %4, i8* null, i32 4), !dbg !4226
  %5 = load i32, i32* %lIndex, align 4, !dbg !4228
  %add = add nsw i32 %5, 1, !dbg !4228
  %conv = sext i32 %add to i64, !dbg !4229
  %6 = inttoptr i64 %conv to %struct.EventGroupDef_t*, !dbg !4229
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xExternalEventGroupHandle, align 8, !dbg !4230
  br label %if.end, !dbg !4231

if.else:                                          ; preds = %if.then
  %7 = load i32, i32* %lIndex, align 4, !dbg !4232
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %7), !dbg !4234
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  br label %if.end4, !dbg !4235

if.end4:                                          ; preds = %if.end, %entry
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xExternalEventGroupHandle, align 8, !dbg !4236
  ret %struct.EventGroupDef_t* %8, !dbg !4237
}

declare dso_local %struct.EventGroupDef_t* @xEventGroupCreate() #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.EventGroupDef_t* @MPU_xEventGroupCreateStatic(%struct.xSTATIC_EVENT_GROUP* %pxEventGroupBuffer) #0 section "privileged_functions" !dbg !4238 {
entry:
  %pxEventGroupBuffer.addr = alloca %struct.xSTATIC_EVENT_GROUP*, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %xExternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.xSTATIC_EVENT_GROUP* %pxEventGroupBuffer, %struct.xSTATIC_EVENT_GROUP** %pxEventGroupBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xSTATIC_EVENT_GROUP** %pxEventGroupBuffer.addr, metadata !4249, metadata !DIExpression()), !dbg !4250
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4251, metadata !DIExpression()), !dbg !4252
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4252
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xExternalEventGroupHandle, metadata !4253, metadata !DIExpression()), !dbg !4254
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xExternalEventGroupHandle, align 8, !dbg !4254
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4255, metadata !DIExpression()), !dbg !4256
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !4257
  store i32 %call, i32* %lIndex, align 4, !dbg !4258
  %0 = load i32, i32* %lIndex, align 4, !dbg !4259
  %cmp = icmp ne i32 %0, -1, !dbg !4261
  br i1 %cmp, label %if.then, label %if.end4, !dbg !4262

if.then:                                          ; preds = %entry
  %1 = load %struct.xSTATIC_EVENT_GROUP*, %struct.xSTATIC_EVENT_GROUP** %pxEventGroupBuffer.addr, align 8, !dbg !4263
  %call1 = call %struct.EventGroupDef_t* @xEventGroupCreateStatic(%struct.xSTATIC_EVENT_GROUP* %1), !dbg !4265
  store %struct.EventGroupDef_t* %call1, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4266
  %2 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4267
  %cmp2 = icmp ne %struct.EventGroupDef_t* %2, null, !dbg !4269
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !4270

if.then3:                                         ; preds = %if.then
  %3 = load i32, i32* %lIndex, align 4, !dbg !4271
  %4 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4271
  %5 = bitcast %struct.EventGroupDef_t* %4 to %struct.OpaqueObject*, !dbg !4271
  call void @MPU_StoreHandleAndDataAtIndex(i32 %3, %struct.OpaqueObject* %5, i8* null, i32 4), !dbg !4271
  %6 = load i32, i32* %lIndex, align 4, !dbg !4273
  %add = add nsw i32 %6, 1, !dbg !4273
  %conv = sext i32 %add to i64, !dbg !4274
  %7 = inttoptr i64 %conv to %struct.EventGroupDef_t*, !dbg !4274
  store %struct.EventGroupDef_t* %7, %struct.EventGroupDef_t** %xExternalEventGroupHandle, align 8, !dbg !4275
  br label %if.end, !dbg !4276

if.else:                                          ; preds = %if.then
  %8 = load i32, i32* %lIndex, align 4, !dbg !4277
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %8), !dbg !4279
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  br label %if.end4, !dbg !4280

if.end4:                                          ; preds = %if.end, %entry
  %9 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xExternalEventGroupHandle, align 8, !dbg !4281
  ret %struct.EventGroupDef_t* %9, !dbg !4282
}

declare dso_local %struct.EventGroupDef_t* @xEventGroupCreateStatic(%struct.xSTATIC_EVENT_GROUP*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vEventGroupDelete(%struct.EventGroupDef_t* %xEventGroup) #0 section "privileged_functions" !dbg !4283 {
entry:
  %xEventGroup.addr = alloca %struct.EventGroupDef_t*, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.EventGroupDef_t* %xEventGroup, %struct.EventGroupDef_t** %xEventGroup.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xEventGroup.addr, metadata !4286, metadata !DIExpression()), !dbg !4287
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4288, metadata !DIExpression()), !dbg !4289
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4289
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4290, metadata !DIExpression()), !dbg !4291
  %0 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xEventGroup.addr, align 8, !dbg !4292
  %1 = ptrtoint %struct.EventGroupDef_t* %0 to i32, !dbg !4293
  store i32 %1, i32* %lIndex, align 4, !dbg !4294
  %2 = load i32, i32* %lIndex, align 4, !dbg !4295
  %cmp = icmp sge i32 %2, 1, !dbg !4295
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4295

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4295
  %cmp1 = icmp slt i32 %3, 257, !dbg !4295
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4297
  %land.ext = zext i1 %4 to i32, !dbg !4295
  %conv = sext i32 %land.ext to i64, !dbg !4295
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4298
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4299

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4300
  %sub = sub nsw i32 %5, 1, !dbg !4300
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 4), !dbg !4300
  %6 = bitcast %struct.OpaqueObject* %call to %struct.EventGroupDef_t*, !dbg !4300
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4302
  %7 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4303
  %cmp4 = icmp ne %struct.EventGroupDef_t* %7, null, !dbg !4305
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4306

if.then6:                                         ; preds = %if.then
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4307
  call void @vEventGroupDelete(%struct.EventGroupDef_t* %8), !dbg !4309
  %9 = load i32, i32* %lIndex, align 4, !dbg !4310
  %sub7 = sub nsw i32 %9, 1, !dbg !4310
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %sub7), !dbg !4311
  br label %if.end, !dbg !4312

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4313

if.end8:                                          ; preds = %if.end, %land.end
  ret void, !dbg !4314
}

declare dso_local void @vEventGroupDelete(%struct.EventGroupDef_t*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xEventGroupGetStaticBuffer(%struct.EventGroupDef_t* %xEventGroup, %struct.xSTATIC_EVENT_GROUP** %ppxEventGroupBuffer) #0 section "privileged_functions" !dbg !4315 {
entry:
  %xEventGroup.addr = alloca %struct.EventGroupDef_t*, align 8
  %ppxEventGroupBuffer.addr = alloca %struct.xSTATIC_EVENT_GROUP**, align 8
  %xReturn = alloca i64, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.EventGroupDef_t* %xEventGroup, %struct.EventGroupDef_t** %xEventGroup.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xEventGroup.addr, metadata !4319, metadata !DIExpression()), !dbg !4320
  store %struct.xSTATIC_EVENT_GROUP** %ppxEventGroupBuffer, %struct.xSTATIC_EVENT_GROUP*** %ppxEventGroupBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xSTATIC_EVENT_GROUP*** %ppxEventGroupBuffer.addr, metadata !4321, metadata !DIExpression()), !dbg !4322
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4323, metadata !DIExpression()), !dbg !4324
  store i64 0, i64* %xReturn, align 8, !dbg !4324
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4325, metadata !DIExpression()), !dbg !4326
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4326
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4327, metadata !DIExpression()), !dbg !4328
  %0 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xEventGroup.addr, align 8, !dbg !4329
  %1 = ptrtoint %struct.EventGroupDef_t* %0 to i32, !dbg !4330
  store i32 %1, i32* %lIndex, align 4, !dbg !4331
  %2 = load i32, i32* %lIndex, align 4, !dbg !4332
  %cmp = icmp sge i32 %2, 1, !dbg !4332
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4332

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4332
  %cmp1 = icmp slt i32 %3, 257, !dbg !4332
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4334
  %land.ext = zext i1 %4 to i32, !dbg !4332
  %conv = sext i32 %land.ext to i64, !dbg !4332
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4335
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4336

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4337
  %sub = sub nsw i32 %5, 1, !dbg !4337
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 4), !dbg !4337
  %6 = bitcast %struct.OpaqueObject* %call to %struct.EventGroupDef_t*, !dbg !4337
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4339
  %7 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4340
  %cmp4 = icmp ne %struct.EventGroupDef_t* %7, null, !dbg !4342
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4343

if.then6:                                         ; preds = %if.then
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4344
  %9 = load %struct.xSTATIC_EVENT_GROUP**, %struct.xSTATIC_EVENT_GROUP*** %ppxEventGroupBuffer.addr, align 8, !dbg !4346
  %call7 = call i64 @xEventGroupGetStaticBuffer(%struct.EventGroupDef_t* %8, %struct.xSTATIC_EVENT_GROUP** %9), !dbg !4347
  store i64 %call7, i64* %xReturn, align 8, !dbg !4348
  br label %if.end, !dbg !4349

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4350

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !4351
  ret i64 %10, !dbg !4352
}

declare dso_local i64 @xEventGroupGetStaticBuffer(%struct.EventGroupDef_t*, %struct.xSTATIC_EVENT_GROUP**) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xEventGroupClearBitsFromISR(%struct.EventGroupDef_t* %xEventGroup, i64 %uxBitsToClear) #0 section "privileged_functions" !dbg !4353 {
entry:
  %xEventGroup.addr = alloca %struct.EventGroupDef_t*, align 8
  %uxBitsToClear.addr = alloca i64, align 8
  %xReturn = alloca i64, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.EventGroupDef_t* %xEventGroup, %struct.EventGroupDef_t** %xEventGroup.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xEventGroup.addr, metadata !4356, metadata !DIExpression()), !dbg !4357
  store i64 %uxBitsToClear, i64* %uxBitsToClear.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxBitsToClear.addr, metadata !4358, metadata !DIExpression()), !dbg !4359
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4360, metadata !DIExpression()), !dbg !4361
  store i64 0, i64* %xReturn, align 8, !dbg !4361
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4362, metadata !DIExpression()), !dbg !4363
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4363
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4364, metadata !DIExpression()), !dbg !4365
  %0 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xEventGroup.addr, align 8, !dbg !4366
  %1 = ptrtoint %struct.EventGroupDef_t* %0 to i32, !dbg !4367
  store i32 %1, i32* %lIndex, align 4, !dbg !4368
  %2 = load i32, i32* %lIndex, align 4, !dbg !4369
  %cmp = icmp sge i32 %2, 1, !dbg !4369
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4369

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4369
  %cmp1 = icmp slt i32 %3, 257, !dbg !4369
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4371
  %land.ext = zext i1 %4 to i32, !dbg !4369
  %conv = sext i32 %land.ext to i64, !dbg !4369
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4372
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4373

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4374
  %sub = sub nsw i32 %5, 1, !dbg !4374
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 4), !dbg !4374
  %6 = bitcast %struct.OpaqueObject* %call to %struct.EventGroupDef_t*, !dbg !4374
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4376
  %7 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4377
  %cmp4 = icmp ne %struct.EventGroupDef_t* %7, null, !dbg !4379
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4380

if.then6:                                         ; preds = %if.then
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4381
  %9 = load i64, i64* %uxBitsToClear.addr, align 8, !dbg !4383
  %call7 = call i64 @xEventGroupClearBitsFromISR(%struct.EventGroupDef_t* %8, i64 %9), !dbg !4384
  store i64 %call7, i64* %xReturn, align 8, !dbg !4385
  br label %if.end, !dbg !4386

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4387

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !4388
  ret i64 %10, !dbg !4389
}

declare dso_local i64 @xEventGroupClearBitsFromISR(%struct.EventGroupDef_t*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xEventGroupSetBitsFromISR(%struct.EventGroupDef_t* %xEventGroup, i64 %uxBitsToSet, i64* %pxHigherPriorityTaskWoken) #0 section "privileged_functions" !dbg !4390 {
entry:
  %xEventGroup.addr = alloca %struct.EventGroupDef_t*, align 8
  %uxBitsToSet.addr = alloca i64, align 8
  %pxHigherPriorityTaskWoken.addr = alloca i64*, align 8
  %xReturn = alloca i64, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.EventGroupDef_t* %xEventGroup, %struct.EventGroupDef_t** %xEventGroup.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xEventGroup.addr, metadata !4393, metadata !DIExpression()), !dbg !4394
  store i64 %uxBitsToSet, i64* %uxBitsToSet.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxBitsToSet.addr, metadata !4395, metadata !DIExpression()), !dbg !4396
  store i64* %pxHigherPriorityTaskWoken, i64** %pxHigherPriorityTaskWoken.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxHigherPriorityTaskWoken.addr, metadata !4397, metadata !DIExpression()), !dbg !4398
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4399, metadata !DIExpression()), !dbg !4400
  store i64 0, i64* %xReturn, align 8, !dbg !4400
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4401, metadata !DIExpression()), !dbg !4402
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4402
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4403, metadata !DIExpression()), !dbg !4404
  %0 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xEventGroup.addr, align 8, !dbg !4405
  %1 = ptrtoint %struct.EventGroupDef_t* %0 to i32, !dbg !4406
  store i32 %1, i32* %lIndex, align 4, !dbg !4407
  %2 = load i32, i32* %lIndex, align 4, !dbg !4408
  %cmp = icmp sge i32 %2, 1, !dbg !4408
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4408

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4408
  %cmp1 = icmp slt i32 %3, 257, !dbg !4408
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4410
  %land.ext = zext i1 %4 to i32, !dbg !4408
  %conv = sext i32 %land.ext to i64, !dbg !4408
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4411
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4412

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4413
  %sub = sub nsw i32 %5, 1, !dbg !4413
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 4), !dbg !4413
  %6 = bitcast %struct.OpaqueObject* %call to %struct.EventGroupDef_t*, !dbg !4413
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4415
  %7 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4416
  %cmp4 = icmp ne %struct.EventGroupDef_t* %7, null, !dbg !4418
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4419

if.then6:                                         ; preds = %if.then
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4420
  %9 = load i64, i64* %uxBitsToSet.addr, align 8, !dbg !4422
  %10 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !4423
  %call7 = call i64 @xEventGroupSetBitsFromISR(%struct.EventGroupDef_t* %8, i64 %9, i64* %10), !dbg !4424
  store i64 %call7, i64* %xReturn, align 8, !dbg !4425
  br label %if.end, !dbg !4426

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4427

if.end8:                                          ; preds = %if.end, %land.end
  %11 = load i64, i64* %xReturn, align 8, !dbg !4428
  ret i64 %11, !dbg !4429
}

declare dso_local i64 @xEventGroupSetBitsFromISR(%struct.EventGroupDef_t*, i64, i64*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xEventGroupGetBitsFromISR(%struct.EventGroupDef_t* %xEventGroup) #0 section "privileged_functions" !dbg !4430 {
entry:
  %xEventGroup.addr = alloca %struct.EventGroupDef_t*, align 8
  %xReturn = alloca i64, align 8
  %xInternalEventGroupHandle = alloca %struct.EventGroupDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.EventGroupDef_t* %xEventGroup, %struct.EventGroupDef_t** %xEventGroup.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xEventGroup.addr, metadata !4433, metadata !DIExpression()), !dbg !4434
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4435, metadata !DIExpression()), !dbg !4436
  store i64 0, i64* %xReturn, align 8, !dbg !4436
  call void @llvm.dbg.declare(metadata %struct.EventGroupDef_t** %xInternalEventGroupHandle, metadata !4437, metadata !DIExpression()), !dbg !4438
  store %struct.EventGroupDef_t* null, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4438
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4439, metadata !DIExpression()), !dbg !4440
  %0 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xEventGroup.addr, align 8, !dbg !4441
  %1 = ptrtoint %struct.EventGroupDef_t* %0 to i32, !dbg !4442
  store i32 %1, i32* %lIndex, align 4, !dbg !4443
  %2 = load i32, i32* %lIndex, align 4, !dbg !4444
  %cmp = icmp sge i32 %2, 1, !dbg !4444
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4444

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4444
  %cmp1 = icmp slt i32 %3, 257, !dbg !4444
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4446
  %land.ext = zext i1 %4 to i32, !dbg !4444
  %conv = sext i32 %land.ext to i64, !dbg !4444
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4447
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4448

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4449
  %sub = sub nsw i32 %5, 1, !dbg !4449
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 4), !dbg !4449
  %6 = bitcast %struct.OpaqueObject* %call to %struct.EventGroupDef_t*, !dbg !4449
  store %struct.EventGroupDef_t* %6, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4451
  %7 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4452
  %cmp4 = icmp ne %struct.EventGroupDef_t* %7, null, !dbg !4454
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4455

if.then6:                                         ; preds = %if.then
  %8 = load %struct.EventGroupDef_t*, %struct.EventGroupDef_t** %xInternalEventGroupHandle, align 8, !dbg !4456
  %call7 = call i64 @xEventGroupGetBitsFromISR(%struct.EventGroupDef_t* %8), !dbg !4458
  store i64 %call7, i64* %xReturn, align 8, !dbg !4459
  br label %if.end, !dbg !4460

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4461

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !4462
  ret i64 %9, !dbg !4463
}

declare dso_local i64 @xEventGroupGetBitsFromISR(%struct.EventGroupDef_t*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferSendImpl(%struct.StreamBufferDef_t* %xStreamBuffer, i8* %pvTxData, i64 %xDataLengthBytes, i64 %xTicksToWait) #0 section "privileged_functions" !dbg !4464 {
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
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !4469, metadata !DIExpression()), !dbg !4470
  store i8* %pvTxData, i8** %pvTxData.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvTxData.addr, metadata !4471, metadata !DIExpression()), !dbg !4472
  store i64 %xDataLengthBytes, i64* %xDataLengthBytes.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xDataLengthBytes.addr, metadata !4473, metadata !DIExpression()), !dbg !4474
  store i64 %xTicksToWait, i64* %xTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToWait.addr, metadata !4475, metadata !DIExpression()), !dbg !4476
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4477, metadata !DIExpression()), !dbg !4478
  store i64 0, i64* %xReturn, align 8, !dbg !4478
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4479, metadata !DIExpression()), !dbg !4480
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4480
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4481, metadata !DIExpression()), !dbg !4482
  call void @llvm.dbg.declare(metadata i64* %xIsTxDataBufferReadable, metadata !4483, metadata !DIExpression()), !dbg !4484
  store i64 0, i64* %xIsTxDataBufferReadable, align 8, !dbg !4484
  %0 = load i8*, i8** %pvTxData.addr, align 8, !dbg !4485
  %1 = load i64, i64* %xDataLengthBytes.addr, align 8, !dbg !4486
  %conv = trunc i64 %1 to i32, !dbg !4486
  %call = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %0, i32 %conv, i32 1), !dbg !4487
  store i64 %call, i64* %xIsTxDataBufferReadable, align 8, !dbg !4488
  %2 = load i64, i64* %xIsTxDataBufferReadable, align 8, !dbg !4489
  %cmp = icmp eq i64 %2, 1, !dbg !4491
  br i1 %cmp, label %if.then, label %if.end16, !dbg !4492

if.then:                                          ; preds = %entry
  %3 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !4493
  %4 = ptrtoint %struct.StreamBufferDef_t* %3 to i32, !dbg !4495
  store i32 %4, i32* %lIndex, align 4, !dbg !4496
  %5 = load i32, i32* %lIndex, align 4, !dbg !4497
  %cmp2 = icmp sge i32 %5, 1, !dbg !4497
  br i1 %cmp2, label %land.rhs, label %land.end, !dbg !4497

land.rhs:                                         ; preds = %if.then
  %6 = load i32, i32* %lIndex, align 4, !dbg !4497
  %cmp4 = icmp slt i32 %6, 257, !dbg !4497
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.then
  %7 = phi i1 [ false, %if.then ], [ %cmp4, %land.rhs ], !dbg !4499
  %land.ext = zext i1 %7 to i32, !dbg !4497
  %conv6 = sext i32 %land.ext to i64, !dbg !4497
  %cmp7 = icmp ne i64 %conv6, 0, !dbg !4500
  br i1 %cmp7, label %if.then9, label %if.end15, !dbg !4501

if.then9:                                         ; preds = %land.end
  %8 = load i32, i32* %lIndex, align 4, !dbg !4502
  %sub = sub nsw i32 %8, 1, !dbg !4502
  %call10 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !4502
  %9 = bitcast %struct.OpaqueObject* %call10 to %struct.StreamBufferDef_t*, !dbg !4502
  store %struct.StreamBufferDef_t* %9, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4504
  %10 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4505
  %cmp11 = icmp ne %struct.StreamBufferDef_t* %10, null, !dbg !4507
  br i1 %cmp11, label %if.then13, label %if.end, !dbg !4508

if.then13:                                        ; preds = %if.then9
  %11 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4509
  %12 = load i8*, i8** %pvTxData.addr, align 8, !dbg !4511
  %13 = load i64, i64* %xDataLengthBytes.addr, align 8, !dbg !4512
  %14 = load i64, i64* %xTicksToWait.addr, align 8, !dbg !4513
  %call14 = call i64 @xStreamBufferSend(%struct.StreamBufferDef_t* %11, i8* %12, i64 %13, i64 %14), !dbg !4514
  store i64 %call14, i64* %xReturn, align 8, !dbg !4515
  br label %if.end, !dbg !4516

if.end:                                           ; preds = %if.then13, %if.then9
  br label %if.end15, !dbg !4517

if.end15:                                         ; preds = %if.end, %land.end
  br label %if.end16, !dbg !4518

if.end16:                                         ; preds = %if.end15, %entry
  %15 = load i64, i64* %xReturn, align 8, !dbg !4519
  ret i64 %15, !dbg !4520
}

declare dso_local i64 @xStreamBufferSend(%struct.StreamBufferDef_t*, i8*, i64, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferReceiveImpl(%struct.StreamBufferDef_t* %xStreamBuffer, i8* %pvRxData, i64 %xBufferLengthBytes, i64 %xTicksToWait) #0 section "privileged_functions" !dbg !4521 {
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
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !4524, metadata !DIExpression()), !dbg !4525
  store i8* %pvRxData, i8** %pvRxData.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvRxData.addr, metadata !4526, metadata !DIExpression()), !dbg !4527
  store i64 %xBufferLengthBytes, i64* %xBufferLengthBytes.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xBufferLengthBytes.addr, metadata !4528, metadata !DIExpression()), !dbg !4529
  store i64 %xTicksToWait, i64* %xTicksToWait.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTicksToWait.addr, metadata !4530, metadata !DIExpression()), !dbg !4531
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4532, metadata !DIExpression()), !dbg !4533
  store i64 0, i64* %xReturn, align 8, !dbg !4533
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4534, metadata !DIExpression()), !dbg !4535
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4535
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4536, metadata !DIExpression()), !dbg !4537
  call void @llvm.dbg.declare(metadata i64* %xIsRxDataBufferWriteable, metadata !4538, metadata !DIExpression()), !dbg !4539
  store i64 0, i64* %xIsRxDataBufferWriteable, align 8, !dbg !4539
  %0 = load i8*, i8** %pvRxData.addr, align 8, !dbg !4540
  %1 = load i64, i64* %xBufferLengthBytes.addr, align 8, !dbg !4541
  %conv = trunc i64 %1 to i32, !dbg !4541
  %call = call i64 @xPortIsAuthorizedToAccessBuffer(i8* %0, i32 %conv, i32 2), !dbg !4542
  store i64 %call, i64* %xIsRxDataBufferWriteable, align 8, !dbg !4543
  %2 = load i64, i64* %xIsRxDataBufferWriteable, align 8, !dbg !4544
  %cmp = icmp eq i64 %2, 1, !dbg !4546
  br i1 %cmp, label %if.then, label %if.end16, !dbg !4547

if.then:                                          ; preds = %entry
  %3 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !4548
  %4 = ptrtoint %struct.StreamBufferDef_t* %3 to i32, !dbg !4550
  store i32 %4, i32* %lIndex, align 4, !dbg !4551
  %5 = load i32, i32* %lIndex, align 4, !dbg !4552
  %cmp2 = icmp sge i32 %5, 1, !dbg !4552
  br i1 %cmp2, label %land.rhs, label %land.end, !dbg !4552

land.rhs:                                         ; preds = %if.then
  %6 = load i32, i32* %lIndex, align 4, !dbg !4552
  %cmp4 = icmp slt i32 %6, 257, !dbg !4552
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.then
  %7 = phi i1 [ false, %if.then ], [ %cmp4, %land.rhs ], !dbg !4554
  %land.ext = zext i1 %7 to i32, !dbg !4552
  %conv6 = sext i32 %land.ext to i64, !dbg !4552
  %cmp7 = icmp ne i64 %conv6, 0, !dbg !4555
  br i1 %cmp7, label %if.then9, label %if.end15, !dbg !4556

if.then9:                                         ; preds = %land.end
  %8 = load i32, i32* %lIndex, align 4, !dbg !4557
  %sub = sub nsw i32 %8, 1, !dbg !4557
  %call10 = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !4557
  %9 = bitcast %struct.OpaqueObject* %call10 to %struct.StreamBufferDef_t*, !dbg !4557
  store %struct.StreamBufferDef_t* %9, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4559
  %10 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4560
  %cmp11 = icmp ne %struct.StreamBufferDef_t* %10, null, !dbg !4562
  br i1 %cmp11, label %if.then13, label %if.end, !dbg !4563

if.then13:                                        ; preds = %if.then9
  %11 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4564
  %12 = load i8*, i8** %pvRxData.addr, align 8, !dbg !4566
  %13 = load i64, i64* %xBufferLengthBytes.addr, align 8, !dbg !4567
  %14 = load i64, i64* %xTicksToWait.addr, align 8, !dbg !4568
  %call14 = call i64 @xStreamBufferReceive(%struct.StreamBufferDef_t* %11, i8* %12, i64 %13, i64 %14), !dbg !4569
  store i64 %call14, i64* %xReturn, align 8, !dbg !4570
  br label %if.end, !dbg !4571

if.end:                                           ; preds = %if.then13, %if.then9
  br label %if.end15, !dbg !4572

if.end15:                                         ; preds = %if.end, %land.end
  br label %if.end16, !dbg !4573

if.end16:                                         ; preds = %if.end15, %entry
  %15 = load i64, i64* %xReturn, align 8, !dbg !4574
  ret i64 %15, !dbg !4575
}

declare dso_local i64 @xStreamBufferReceive(%struct.StreamBufferDef_t*, i8*, i64, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferIsFullImpl(%struct.StreamBufferDef_t* %xStreamBuffer) #0 section "privileged_functions" !dbg !4576 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !4579, metadata !DIExpression()), !dbg !4580
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4581, metadata !DIExpression()), !dbg !4582
  store i64 0, i64* %xReturn, align 8, !dbg !4582
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4583, metadata !DIExpression()), !dbg !4584
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4584
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4585, metadata !DIExpression()), !dbg !4586
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !4587
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !4588
  store i32 %1, i32* %lIndex, align 4, !dbg !4589
  %2 = load i32, i32* %lIndex, align 4, !dbg !4590
  %cmp = icmp sge i32 %2, 1, !dbg !4590
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4590

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4590
  %cmp1 = icmp slt i32 %3, 257, !dbg !4590
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4592
  %land.ext = zext i1 %4 to i32, !dbg !4590
  %conv = sext i32 %land.ext to i64, !dbg !4590
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4593
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4594

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4595
  %sub = sub nsw i32 %5, 1, !dbg !4595
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !4595
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !4595
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4597
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4598
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !4600
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4601

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4602
  %call7 = call i64 @xStreamBufferIsFull(%struct.StreamBufferDef_t* %8), !dbg !4604
  store i64 %call7, i64* %xReturn, align 8, !dbg !4605
  br label %if.end, !dbg !4606

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4607

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !4608
  ret i64 %9, !dbg !4609
}

declare dso_local i64 @xStreamBufferIsFull(%struct.StreamBufferDef_t*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferIsEmptyImpl(%struct.StreamBufferDef_t* %xStreamBuffer) #0 section "privileged_functions" !dbg !4610 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !4611, metadata !DIExpression()), !dbg !4612
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4613, metadata !DIExpression()), !dbg !4614
  store i64 0, i64* %xReturn, align 8, !dbg !4614
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4615, metadata !DIExpression()), !dbg !4616
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4616
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4617, metadata !DIExpression()), !dbg !4618
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !4619
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !4620
  store i32 %1, i32* %lIndex, align 4, !dbg !4621
  %2 = load i32, i32* %lIndex, align 4, !dbg !4622
  %cmp = icmp sge i32 %2, 1, !dbg !4622
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4622

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4622
  %cmp1 = icmp slt i32 %3, 257, !dbg !4622
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4624
  %land.ext = zext i1 %4 to i32, !dbg !4622
  %conv = sext i32 %land.ext to i64, !dbg !4622
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4625
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4626

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4627
  %sub = sub nsw i32 %5, 1, !dbg !4627
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !4627
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !4627
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4629
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4630
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !4632
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4633

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4634
  %call7 = call i64 @xStreamBufferIsEmpty(%struct.StreamBufferDef_t* %8), !dbg !4636
  store i64 %call7, i64* %xReturn, align 8, !dbg !4637
  br label %if.end, !dbg !4638

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4639

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !4640
  ret i64 %9, !dbg !4641
}

declare dso_local i64 @xStreamBufferIsEmpty(%struct.StreamBufferDef_t*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferSpacesAvailableImpl(%struct.StreamBufferDef_t* %xStreamBuffer) #0 section "privileged_functions" !dbg !4642 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !4645, metadata !DIExpression()), !dbg !4646
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4647, metadata !DIExpression()), !dbg !4648
  store i64 0, i64* %xReturn, align 8, !dbg !4648
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4649, metadata !DIExpression()), !dbg !4650
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4650
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4651, metadata !DIExpression()), !dbg !4652
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !4653
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !4654
  store i32 %1, i32* %lIndex, align 4, !dbg !4655
  %2 = load i32, i32* %lIndex, align 4, !dbg !4656
  %cmp = icmp sge i32 %2, 1, !dbg !4656
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4656

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4656
  %cmp1 = icmp slt i32 %3, 257, !dbg !4656
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4658
  %land.ext = zext i1 %4 to i32, !dbg !4656
  %conv = sext i32 %land.ext to i64, !dbg !4656
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4659
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4660

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4661
  %sub = sub nsw i32 %5, 1, !dbg !4661
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !4661
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !4661
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4663
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4664
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !4666
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4667

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4668
  %call7 = call i64 @xStreamBufferSpacesAvailable(%struct.StreamBufferDef_t* %8), !dbg !4670
  store i64 %call7, i64* %xReturn, align 8, !dbg !4671
  br label %if.end, !dbg !4672

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4673

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !4674
  ret i64 %9, !dbg !4675
}

declare dso_local i64 @xStreamBufferSpacesAvailable(%struct.StreamBufferDef_t*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferBytesAvailableImpl(%struct.StreamBufferDef_t* %xStreamBuffer) #0 section "privileged_functions" !dbg !4676 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !4677, metadata !DIExpression()), !dbg !4678
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4679, metadata !DIExpression()), !dbg !4680
  store i64 0, i64* %xReturn, align 8, !dbg !4680
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4681, metadata !DIExpression()), !dbg !4682
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4682
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4683, metadata !DIExpression()), !dbg !4684
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !4685
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !4686
  store i32 %1, i32* %lIndex, align 4, !dbg !4687
  %2 = load i32, i32* %lIndex, align 4, !dbg !4688
  %cmp = icmp sge i32 %2, 1, !dbg !4688
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4688

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4688
  %cmp1 = icmp slt i32 %3, 257, !dbg !4688
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4690
  %land.ext = zext i1 %4 to i32, !dbg !4688
  %conv = sext i32 %land.ext to i64, !dbg !4688
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4691
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4692

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4693
  %sub = sub nsw i32 %5, 1, !dbg !4693
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !4693
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !4693
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4695
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4696
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !4698
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4699

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4700
  %call7 = call i64 @xStreamBufferBytesAvailable(%struct.StreamBufferDef_t* %8), !dbg !4702
  store i64 %call7, i64* %xReturn, align 8, !dbg !4703
  br label %if.end, !dbg !4704

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4705

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !4706
  ret i64 %9, !dbg !4707
}

declare dso_local i64 @xStreamBufferBytesAvailable(%struct.StreamBufferDef_t*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferSetTriggerLevelImpl(%struct.StreamBufferDef_t* %xStreamBuffer, i64 %xTriggerLevel) #0 section "privileged_functions" !dbg !4708 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %xTriggerLevel.addr = alloca i64, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !4711, metadata !DIExpression()), !dbg !4712
  store i64 %xTriggerLevel, i64* %xTriggerLevel.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTriggerLevel.addr, metadata !4713, metadata !DIExpression()), !dbg !4714
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4715, metadata !DIExpression()), !dbg !4716
  store i64 0, i64* %xReturn, align 8, !dbg !4716
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4717, metadata !DIExpression()), !dbg !4718
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4718
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4719, metadata !DIExpression()), !dbg !4720
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !4721
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !4722
  store i32 %1, i32* %lIndex, align 4, !dbg !4723
  %2 = load i32, i32* %lIndex, align 4, !dbg !4724
  %cmp = icmp sge i32 %2, 1, !dbg !4724
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4724

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4724
  %cmp1 = icmp slt i32 %3, 257, !dbg !4724
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4726
  %land.ext = zext i1 %4 to i32, !dbg !4724
  %conv = sext i32 %land.ext to i64, !dbg !4724
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4727
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4728

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4729
  %sub = sub nsw i32 %5, 1, !dbg !4729
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !4729
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !4729
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4731
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4732
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !4734
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4735

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4736
  %9 = load i64, i64* %xTriggerLevel.addr, align 8, !dbg !4738
  %call7 = call i64 @xStreamBufferSetTriggerLevel(%struct.StreamBufferDef_t* %8, i64 %9), !dbg !4739
  store i64 %call7, i64* %xReturn, align 8, !dbg !4740
  br label %if.end, !dbg !4741

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4742

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !4743
  ret i64 %10, !dbg !4744
}

declare dso_local i64 @xStreamBufferSetTriggerLevel(%struct.StreamBufferDef_t*, i64) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferNextMessageLengthBytesImpl(%struct.StreamBufferDef_t* %xStreamBuffer) #0 section "privileged_functions" !dbg !4745 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !4746, metadata !DIExpression()), !dbg !4747
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4748, metadata !DIExpression()), !dbg !4749
  store i64 0, i64* %xReturn, align 8, !dbg !4749
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4750, metadata !DIExpression()), !dbg !4751
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4751
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4752, metadata !DIExpression()), !dbg !4753
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !4754
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !4755
  store i32 %1, i32* %lIndex, align 4, !dbg !4756
  %2 = load i32, i32* %lIndex, align 4, !dbg !4757
  %cmp = icmp sge i32 %2, 1, !dbg !4757
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4757

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4757
  %cmp1 = icmp slt i32 %3, 257, !dbg !4757
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4759
  %land.ext = zext i1 %4 to i32, !dbg !4757
  %conv = sext i32 %land.ext to i64, !dbg !4757
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4760
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4761

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4762
  %sub = sub nsw i32 %5, 1, !dbg !4762
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !4762
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !4762
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4764
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4765
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !4767
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4768

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4769
  %call7 = call i64 @xStreamBufferNextMessageLengthBytes(%struct.StreamBufferDef_t* %8), !dbg !4771
  store i64 %call7, i64* %xReturn, align 8, !dbg !4772
  br label %if.end, !dbg !4773

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4774

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !4775
  ret i64 %9, !dbg !4776
}

declare dso_local i64 @xStreamBufferNextMessageLengthBytes(%struct.StreamBufferDef_t*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.StreamBufferDef_t* @MPU_xStreamBufferGenericCreate(i64 %xBufferSizeBytes, i64 %xTriggerLevelBytes, i64 %xIsMessageBuffer, void (%struct.StreamBufferDef_t*, i64, i64*)* %pxSendCompletedCallback, void (%struct.StreamBufferDef_t*, i64, i64*)* %pxReceiveCompletedCallback) #0 section "privileged_functions" !dbg !4777 {
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
  call void @llvm.dbg.declare(metadata i64* %xBufferSizeBytes.addr, metadata !4784, metadata !DIExpression()), !dbg !4785
  store i64 %xTriggerLevelBytes, i64* %xTriggerLevelBytes.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTriggerLevelBytes.addr, metadata !4786, metadata !DIExpression()), !dbg !4787
  store i64 %xIsMessageBuffer, i64* %xIsMessageBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xIsMessageBuffer.addr, metadata !4788, metadata !DIExpression()), !dbg !4789
  store void (%struct.StreamBufferDef_t*, i64, i64*)* %pxSendCompletedCallback, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxSendCompletedCallback.addr, align 8
  call void @llvm.dbg.declare(metadata void (%struct.StreamBufferDef_t*, i64, i64*)** %pxSendCompletedCallback.addr, metadata !4790, metadata !DIExpression()), !dbg !4791
  store void (%struct.StreamBufferDef_t*, i64, i64*)* %pxReceiveCompletedCallback, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxReceiveCompletedCallback.addr, align 8
  call void @llvm.dbg.declare(metadata void (%struct.StreamBufferDef_t*, i64, i64*)** %pxReceiveCompletedCallback.addr, metadata !4792, metadata !DIExpression()), !dbg !4793
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4794, metadata !DIExpression()), !dbg !4795
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4795
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xExternalStreamBufferHandle, metadata !4796, metadata !DIExpression()), !dbg !4797
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xExternalStreamBufferHandle, align 8, !dbg !4797
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4798, metadata !DIExpression()), !dbg !4799
  %0 = load void (%struct.StreamBufferDef_t*, i64, i64*)*, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxSendCompletedCallback.addr, align 8, !dbg !4800
  %cmp = icmp eq void (%struct.StreamBufferDef_t*, i64, i64*)* %0, null, !dbg !4800
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4800

land.rhs:                                         ; preds = %entry
  %1 = load void (%struct.StreamBufferDef_t*, i64, i64*)*, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxReceiveCompletedCallback.addr, align 8, !dbg !4800
  %cmp1 = icmp eq void (%struct.StreamBufferDef_t*, i64, i64*)* %1, null, !dbg !4800
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %2 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4802
  %land.ext = zext i1 %2 to i32, !dbg !4800
  %cmp2 = icmp eq i32 %land.ext, 0, !dbg !4800
  br i1 %cmp2, label %if.then, label %if.end, !dbg !4803

if.then:                                          ; preds = %land.end
  call void @vAssertCalled(i8* getelementptr inbounds ([68 x i8], [68 x i8]* @.str, i64 0, i64 0), i64 3847), !dbg !4800
  br label %if.end, !dbg !4800

if.end:                                           ; preds = %if.then, %land.end
  %3 = load void (%struct.StreamBufferDef_t*, i64, i64*)*, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxSendCompletedCallback.addr, align 8, !dbg !4804
  %cmp3 = icmp eq void (%struct.StreamBufferDef_t*, i64, i64*)* %3, null, !dbg !4806
  br i1 %cmp3, label %land.lhs.true, label %if.else13, !dbg !4807

land.lhs.true:                                    ; preds = %if.end
  %4 = load void (%struct.StreamBufferDef_t*, i64, i64*)*, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxReceiveCompletedCallback.addr, align 8, !dbg !4808
  %cmp4 = icmp eq void (%struct.StreamBufferDef_t*, i64, i64*)* %4, null, !dbg !4809
  br i1 %cmp4, label %if.then5, label %if.else13, !dbg !4810

if.then5:                                         ; preds = %land.lhs.true
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !4811
  store i32 %call, i32* %lIndex, align 4, !dbg !4813
  %5 = load i32, i32* %lIndex, align 4, !dbg !4814
  %cmp6 = icmp ne i32 %5, -1, !dbg !4816
  br i1 %cmp6, label %if.then7, label %if.end12, !dbg !4817

if.then7:                                         ; preds = %if.then5
  %6 = load i64, i64* %xBufferSizeBytes.addr, align 8, !dbg !4818
  %7 = load i64, i64* %xTriggerLevelBytes.addr, align 8, !dbg !4820
  %8 = load i64, i64* %xIsMessageBuffer.addr, align 8, !dbg !4821
  %call8 = call %struct.StreamBufferDef_t* @xStreamBufferGenericCreate(i64 %6, i64 %7, i64 %8, void (%struct.StreamBufferDef_t*, i64, i64*)* null, void (%struct.StreamBufferDef_t*, i64, i64*)* null), !dbg !4822
  store %struct.StreamBufferDef_t* %call8, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4823
  %9 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4824
  %cmp9 = icmp ne %struct.StreamBufferDef_t* %9, null, !dbg !4826
  br i1 %cmp9, label %if.then10, label %if.else, !dbg !4827

if.then10:                                        ; preds = %if.then7
  %10 = load i32, i32* %lIndex, align 4, !dbg !4828
  %11 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4828
  %12 = bitcast %struct.StreamBufferDef_t* %11 to %struct.OpaqueObject*, !dbg !4828
  call void @MPU_StoreHandleAndDataAtIndex(i32 %10, %struct.OpaqueObject* %12, i8* null, i32 3), !dbg !4828
  %13 = load i32, i32* %lIndex, align 4, !dbg !4830
  %add = add nsw i32 %13, 1, !dbg !4830
  %conv = sext i32 %add to i64, !dbg !4831
  %14 = inttoptr i64 %conv to %struct.StreamBufferDef_t*, !dbg !4831
  store %struct.StreamBufferDef_t* %14, %struct.StreamBufferDef_t** %xExternalStreamBufferHandle, align 8, !dbg !4832
  br label %if.end11, !dbg !4833

if.else:                                          ; preds = %if.then7
  %15 = load i32, i32* %lIndex, align 4, !dbg !4834
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %15), !dbg !4836
  br label %if.end11

if.end11:                                         ; preds = %if.else, %if.then10
  br label %if.end12, !dbg !4837

if.end12:                                         ; preds = %if.end11, %if.then5
  br label %if.end14, !dbg !4838

if.else13:                                        ; preds = %land.lhs.true, %if.end
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xExternalStreamBufferHandle, align 8, !dbg !4839
  br label %if.end14

if.end14:                                         ; preds = %if.else13, %if.end12
  %16 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xExternalStreamBufferHandle, align 8, !dbg !4841
  ret %struct.StreamBufferDef_t* %16, !dbg !4842
}

declare dso_local %struct.StreamBufferDef_t* @xStreamBufferGenericCreate(i64, i64, i64, void (%struct.StreamBufferDef_t*, i64, i64*)*, void (%struct.StreamBufferDef_t*, i64, i64*)*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.StreamBufferDef_t* @MPU_xStreamBufferGenericCreateStatic(i64 %xBufferSizeBytes, i64 %xTriggerLevelBytes, i64 %xIsMessageBuffer, i8* %pucStreamBufferStorageArea, %struct.xSTATIC_STREAM_BUFFER* %pxStaticStreamBuffer, void (%struct.StreamBufferDef_t*, i64, i64*)* %pxSendCompletedCallback, void (%struct.StreamBufferDef_t*, i64, i64*)* %pxReceiveCompletedCallback) #0 section "privileged_functions" !dbg !4843 {
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
  call void @llvm.dbg.declare(metadata i64* %xBufferSizeBytes.addr, metadata !4858, metadata !DIExpression()), !dbg !4859
  store i64 %xTriggerLevelBytes, i64* %xTriggerLevelBytes.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xTriggerLevelBytes.addr, metadata !4860, metadata !DIExpression()), !dbg !4861
  store i64 %xIsMessageBuffer, i64* %xIsMessageBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xIsMessageBuffer.addr, metadata !4862, metadata !DIExpression()), !dbg !4863
  store i8* %pucStreamBufferStorageArea, i8** %pucStreamBufferStorageArea.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pucStreamBufferStorageArea.addr, metadata !4864, metadata !DIExpression()), !dbg !4865
  store %struct.xSTATIC_STREAM_BUFFER* %pxStaticStreamBuffer, %struct.xSTATIC_STREAM_BUFFER** %pxStaticStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xSTATIC_STREAM_BUFFER** %pxStaticStreamBuffer.addr, metadata !4866, metadata !DIExpression()), !dbg !4867
  store void (%struct.StreamBufferDef_t*, i64, i64*)* %pxSendCompletedCallback, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxSendCompletedCallback.addr, align 8
  call void @llvm.dbg.declare(metadata void (%struct.StreamBufferDef_t*, i64, i64*)** %pxSendCompletedCallback.addr, metadata !4868, metadata !DIExpression()), !dbg !4869
  store void (%struct.StreamBufferDef_t*, i64, i64*)* %pxReceiveCompletedCallback, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxReceiveCompletedCallback.addr, align 8
  call void @llvm.dbg.declare(metadata void (%struct.StreamBufferDef_t*, i64, i64*)** %pxReceiveCompletedCallback.addr, metadata !4870, metadata !DIExpression()), !dbg !4871
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4872, metadata !DIExpression()), !dbg !4873
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4873
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xExternalStreamBufferHandle, metadata !4874, metadata !DIExpression()), !dbg !4875
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xExternalStreamBufferHandle, align 8, !dbg !4875
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4876, metadata !DIExpression()), !dbg !4877
  %0 = load void (%struct.StreamBufferDef_t*, i64, i64*)*, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxSendCompletedCallback.addr, align 8, !dbg !4878
  %cmp = icmp eq void (%struct.StreamBufferDef_t*, i64, i64*)* %0, null, !dbg !4878
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4878

land.rhs:                                         ; preds = %entry
  %1 = load void (%struct.StreamBufferDef_t*, i64, i64*)*, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxReceiveCompletedCallback.addr, align 8, !dbg !4878
  %cmp1 = icmp eq void (%struct.StreamBufferDef_t*, i64, i64*)* %1, null, !dbg !4878
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %2 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4880
  %land.ext = zext i1 %2 to i32, !dbg !4878
  %cmp2 = icmp eq i32 %land.ext, 0, !dbg !4878
  br i1 %cmp2, label %if.then, label %if.end, !dbg !4881

if.then:                                          ; preds = %land.end
  call void @vAssertCalled(i8* getelementptr inbounds ([68 x i8], [68 x i8]* @.str, i64 0, i64 0), i64 3904), !dbg !4878
  br label %if.end, !dbg !4878

if.end:                                           ; preds = %if.then, %land.end
  %3 = load void (%struct.StreamBufferDef_t*, i64, i64*)*, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxSendCompletedCallback.addr, align 8, !dbg !4882
  %cmp3 = icmp eq void (%struct.StreamBufferDef_t*, i64, i64*)* %3, null, !dbg !4884
  br i1 %cmp3, label %land.lhs.true, label %if.else13, !dbg !4885

land.lhs.true:                                    ; preds = %if.end
  %4 = load void (%struct.StreamBufferDef_t*, i64, i64*)*, void (%struct.StreamBufferDef_t*, i64, i64*)** %pxReceiveCompletedCallback.addr, align 8, !dbg !4886
  %cmp4 = icmp eq void (%struct.StreamBufferDef_t*, i64, i64*)* %4, null, !dbg !4887
  br i1 %cmp4, label %if.then5, label %if.else13, !dbg !4888

if.then5:                                         ; preds = %land.lhs.true
  %call = call i32 @MPU_GetFreeIndexInKernelObjectPool(), !dbg !4889
  store i32 %call, i32* %lIndex, align 4, !dbg !4891
  %5 = load i32, i32* %lIndex, align 4, !dbg !4892
  %cmp6 = icmp ne i32 %5, -1, !dbg !4894
  br i1 %cmp6, label %if.then7, label %if.end12, !dbg !4895

if.then7:                                         ; preds = %if.then5
  %6 = load i64, i64* %xBufferSizeBytes.addr, align 8, !dbg !4896
  %7 = load i64, i64* %xTriggerLevelBytes.addr, align 8, !dbg !4898
  %8 = load i64, i64* %xIsMessageBuffer.addr, align 8, !dbg !4899
  %9 = load i8*, i8** %pucStreamBufferStorageArea.addr, align 8, !dbg !4900
  %10 = load %struct.xSTATIC_STREAM_BUFFER*, %struct.xSTATIC_STREAM_BUFFER** %pxStaticStreamBuffer.addr, align 8, !dbg !4901
  %call8 = call %struct.StreamBufferDef_t* @xStreamBufferGenericCreateStatic(i64 %6, i64 %7, i64 %8, i8* %9, %struct.xSTATIC_STREAM_BUFFER* %10, void (%struct.StreamBufferDef_t*, i64, i64*)* null, void (%struct.StreamBufferDef_t*, i64, i64*)* null), !dbg !4902
  store %struct.StreamBufferDef_t* %call8, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4903
  %11 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4904
  %cmp9 = icmp ne %struct.StreamBufferDef_t* %11, null, !dbg !4906
  br i1 %cmp9, label %if.then10, label %if.else, !dbg !4907

if.then10:                                        ; preds = %if.then7
  %12 = load i32, i32* %lIndex, align 4, !dbg !4908
  %13 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4908
  %14 = bitcast %struct.StreamBufferDef_t* %13 to %struct.OpaqueObject*, !dbg !4908
  call void @MPU_StoreHandleAndDataAtIndex(i32 %12, %struct.OpaqueObject* %14, i8* null, i32 3), !dbg !4908
  %15 = load i32, i32* %lIndex, align 4, !dbg !4910
  %add = add nsw i32 %15, 1, !dbg !4910
  %conv = sext i32 %add to i64, !dbg !4911
  %16 = inttoptr i64 %conv to %struct.StreamBufferDef_t*, !dbg !4911
  store %struct.StreamBufferDef_t* %16, %struct.StreamBufferDef_t** %xExternalStreamBufferHandle, align 8, !dbg !4912
  br label %if.end11, !dbg !4913

if.else:                                          ; preds = %if.then7
  %17 = load i32, i32* %lIndex, align 4, !dbg !4914
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %17), !dbg !4916
  br label %if.end11

if.end11:                                         ; preds = %if.else, %if.then10
  br label %if.end12, !dbg !4917

if.end12:                                         ; preds = %if.end11, %if.then5
  br label %if.end14, !dbg !4918

if.else13:                                        ; preds = %land.lhs.true, %if.end
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xExternalStreamBufferHandle, align 8, !dbg !4919
  br label %if.end14

if.end14:                                         ; preds = %if.else13, %if.end12
  %18 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xExternalStreamBufferHandle, align 8, !dbg !4921
  ret %struct.StreamBufferDef_t* %18, !dbg !4922
}

declare dso_local %struct.StreamBufferDef_t* @xStreamBufferGenericCreateStatic(i64, i64, i64, i8*, %struct.xSTATIC_STREAM_BUFFER*, void (%struct.StreamBufferDef_t*, i64, i64*)*, void (%struct.StreamBufferDef_t*, i64, i64*)*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MPU_vStreamBufferDelete(%struct.StreamBufferDef_t* %xStreamBuffer) #0 section "privileged_functions" !dbg !4923 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !4926, metadata !DIExpression()), !dbg !4927
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4928, metadata !DIExpression()), !dbg !4929
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4929
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4930, metadata !DIExpression()), !dbg !4931
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !4932
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !4933
  store i32 %1, i32* %lIndex, align 4, !dbg !4934
  %2 = load i32, i32* %lIndex, align 4, !dbg !4935
  %cmp = icmp sge i32 %2, 1, !dbg !4935
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4935

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4935
  %cmp1 = icmp slt i32 %3, 257, !dbg !4935
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4937
  %land.ext = zext i1 %4 to i32, !dbg !4935
  %conv = sext i32 %land.ext to i64, !dbg !4935
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4938
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4939

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4940
  %sub = sub nsw i32 %5, 1, !dbg !4940
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !4940
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !4940
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4942
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4943
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !4945
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4946

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4947
  call void @vStreamBufferDelete(%struct.StreamBufferDef_t* %8), !dbg !4949
  br label %if.end, !dbg !4950

if.end:                                           ; preds = %if.then6, %if.then
  %9 = load i32, i32* %lIndex, align 4, !dbg !4951
  %sub7 = sub nsw i32 %9, 1, !dbg !4951
  call void @MPU_SetIndexFreeInKernelObjectPool(i32 %sub7), !dbg !4952
  br label %if.end8, !dbg !4953

if.end8:                                          ; preds = %if.end, %land.end
  ret void, !dbg !4954
}

declare dso_local void @vStreamBufferDelete(%struct.StreamBufferDef_t*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferReset(%struct.StreamBufferDef_t* %xStreamBuffer) #0 section "privileged_functions" !dbg !4955 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !4956, metadata !DIExpression()), !dbg !4957
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4958, metadata !DIExpression()), !dbg !4959
  store i64 0, i64* %xReturn, align 8, !dbg !4959
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4960, metadata !DIExpression()), !dbg !4961
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4961
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !4962, metadata !DIExpression()), !dbg !4963
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !4964
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !4965
  store i32 %1, i32* %lIndex, align 4, !dbg !4966
  %2 = load i32, i32* %lIndex, align 4, !dbg !4967
  %cmp = icmp sge i32 %2, 1, !dbg !4967
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !4967

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !4967
  %cmp1 = icmp slt i32 %3, 257, !dbg !4967
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !4969
  %land.ext = zext i1 %4 to i32, !dbg !4967
  %conv = sext i32 %land.ext to i64, !dbg !4967
  %cmp2 = icmp ne i64 %conv, 0, !dbg !4970
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !4971

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !4972
  %sub = sub nsw i32 %5, 1, !dbg !4972
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !4972
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !4972
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4974
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4975
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !4977
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !4978

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4979
  %call7 = call i64 @xStreamBufferReset(%struct.StreamBufferDef_t* %8), !dbg !4981
  store i64 %call7, i64* %xReturn, align 8, !dbg !4982
  br label %if.end, !dbg !4983

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !4984

if.end8:                                          ; preds = %if.end, %land.end
  %9 = load i64, i64* %xReturn, align 8, !dbg !4985
  ret i64 %9, !dbg !4986
}

declare dso_local i64 @xStreamBufferReset(%struct.StreamBufferDef_t*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferGetStaticBuffers(%struct.StreamBufferDef_t* %xStreamBuffers, i8* %ppucStreamBufferStorageArea, %struct.xSTATIC_STREAM_BUFFER* %ppxStaticStreamBuffer) #0 section "privileged_functions" !dbg !4987 {
entry:
  %xStreamBuffers.addr = alloca %struct.StreamBufferDef_t*, align 8
  %ppucStreamBufferStorageArea.addr = alloca i8*, align 8
  %ppxStaticStreamBuffer.addr = alloca %struct.xSTATIC_STREAM_BUFFER*, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffers, %struct.StreamBufferDef_t** %xStreamBuffers.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffers.addr, metadata !4990, metadata !DIExpression()), !dbg !4991
  store i8* %ppucStreamBufferStorageArea, i8** %ppucStreamBufferStorageArea.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %ppucStreamBufferStorageArea.addr, metadata !4992, metadata !DIExpression()), !dbg !4993
  store %struct.xSTATIC_STREAM_BUFFER* %ppxStaticStreamBuffer, %struct.xSTATIC_STREAM_BUFFER** %ppxStaticStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xSTATIC_STREAM_BUFFER** %ppxStaticStreamBuffer.addr, metadata !4994, metadata !DIExpression()), !dbg !4995
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !4996, metadata !DIExpression()), !dbg !4997
  store i64 0, i64* %xReturn, align 8, !dbg !4997
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !4998, metadata !DIExpression()), !dbg !4999
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !4999
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !5000, metadata !DIExpression()), !dbg !5001
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffers.addr, align 8, !dbg !5002
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !5003
  store i32 %1, i32* %lIndex, align 4, !dbg !5004
  %2 = load i32, i32* %lIndex, align 4, !dbg !5005
  %cmp = icmp sge i32 %2, 1, !dbg !5005
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !5005

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !5005
  %cmp1 = icmp slt i32 %3, 257, !dbg !5005
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !5007
  %land.ext = zext i1 %4 to i32, !dbg !5005
  %conv = sext i32 %land.ext to i64, !dbg !5005
  %cmp2 = icmp ne i64 %conv, 0, !dbg !5008
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !5009

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !5010
  %sub = sub nsw i32 %5, 1, !dbg !5010
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !5010
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !5010
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5012
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5013
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !5015
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !5016

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5017
  %9 = load i8*, i8** %ppucStreamBufferStorageArea.addr, align 8, !dbg !5019
  %10 = load %struct.xSTATIC_STREAM_BUFFER*, %struct.xSTATIC_STREAM_BUFFER** %ppxStaticStreamBuffer.addr, align 8, !dbg !5020
  %call7 = call i64 @MPU_xStreamBufferGetStaticBuffers(%struct.StreamBufferDef_t* %8, i8* %9, %struct.xSTATIC_STREAM_BUFFER* %10), !dbg !5021
  store i64 %call7, i64* %xReturn, align 8, !dbg !5022
  br label %if.end, !dbg !5023

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !5024

if.end8:                                          ; preds = %if.end, %land.end
  %11 = load i64, i64* %xReturn, align 8, !dbg !5025
  ret i64 %11, !dbg !5026
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferSendFromISR(%struct.StreamBufferDef_t* %xStreamBuffer, i8* %pvTxData, i64 %xDataLengthBytes, i64* %pxHigherPriorityTaskWoken) #0 section "privileged_functions" !dbg !5027 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %pvTxData.addr = alloca i8*, align 8
  %xDataLengthBytes.addr = alloca i64, align 8
  %pxHigherPriorityTaskWoken.addr = alloca i64*, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !5030, metadata !DIExpression()), !dbg !5031
  store i8* %pvTxData, i8** %pvTxData.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvTxData.addr, metadata !5032, metadata !DIExpression()), !dbg !5033
  store i64 %xDataLengthBytes, i64* %xDataLengthBytes.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xDataLengthBytes.addr, metadata !5034, metadata !DIExpression()), !dbg !5035
  store i64* %pxHigherPriorityTaskWoken, i64** %pxHigherPriorityTaskWoken.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxHigherPriorityTaskWoken.addr, metadata !5036, metadata !DIExpression()), !dbg !5037
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !5038, metadata !DIExpression()), !dbg !5039
  store i64 0, i64* %xReturn, align 8, !dbg !5039
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !5040, metadata !DIExpression()), !dbg !5041
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5041
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !5042, metadata !DIExpression()), !dbg !5043
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !5044
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !5045
  store i32 %1, i32* %lIndex, align 4, !dbg !5046
  %2 = load i32, i32* %lIndex, align 4, !dbg !5047
  %cmp = icmp sge i32 %2, 1, !dbg !5047
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !5047

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !5047
  %cmp1 = icmp slt i32 %3, 257, !dbg !5047
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !5049
  %land.ext = zext i1 %4 to i32, !dbg !5047
  %conv = sext i32 %land.ext to i64, !dbg !5047
  %cmp2 = icmp ne i64 %conv, 0, !dbg !5050
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !5051

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !5052
  %sub = sub nsw i32 %5, 1, !dbg !5052
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !5052
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !5052
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5054
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5055
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !5057
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !5058

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5059
  %9 = load i8*, i8** %pvTxData.addr, align 8, !dbg !5061
  %10 = load i64, i64* %xDataLengthBytes.addr, align 8, !dbg !5062
  %11 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !5063
  %call7 = call i64 @xStreamBufferSendFromISR(%struct.StreamBufferDef_t* %8, i8* %9, i64 %10, i64* %11), !dbg !5064
  store i64 %call7, i64* %xReturn, align 8, !dbg !5065
  br label %if.end, !dbg !5066

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !5067

if.end8:                                          ; preds = %if.end, %land.end
  %12 = load i64, i64* %xReturn, align 8, !dbg !5068
  ret i64 %12, !dbg !5069
}

declare dso_local i64 @xStreamBufferSendFromISR(%struct.StreamBufferDef_t*, i8*, i64, i64*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferReceiveFromISR(%struct.StreamBufferDef_t* %xStreamBuffer, i8* %pvRxData, i64 %xBufferLengthBytes, i64* %pxHigherPriorityTaskWoken) #0 section "privileged_functions" !dbg !5070 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %pvRxData.addr = alloca i8*, align 8
  %xBufferLengthBytes.addr = alloca i64, align 8
  %pxHigherPriorityTaskWoken.addr = alloca i64*, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !5073, metadata !DIExpression()), !dbg !5074
  store i8* %pvRxData, i8** %pvRxData.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvRxData.addr, metadata !5075, metadata !DIExpression()), !dbg !5076
  store i64 %xBufferLengthBytes, i64* %xBufferLengthBytes.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %xBufferLengthBytes.addr, metadata !5077, metadata !DIExpression()), !dbg !5078
  store i64* %pxHigherPriorityTaskWoken, i64** %pxHigherPriorityTaskWoken.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxHigherPriorityTaskWoken.addr, metadata !5079, metadata !DIExpression()), !dbg !5080
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !5081, metadata !DIExpression()), !dbg !5082
  store i64 0, i64* %xReturn, align 8, !dbg !5082
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !5083, metadata !DIExpression()), !dbg !5084
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5084
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !5085, metadata !DIExpression()), !dbg !5086
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !5087
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !5088
  store i32 %1, i32* %lIndex, align 4, !dbg !5089
  %2 = load i32, i32* %lIndex, align 4, !dbg !5090
  %cmp = icmp sge i32 %2, 1, !dbg !5090
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !5090

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !5090
  %cmp1 = icmp slt i32 %3, 257, !dbg !5090
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !5092
  %land.ext = zext i1 %4 to i32, !dbg !5090
  %conv = sext i32 %land.ext to i64, !dbg !5090
  %cmp2 = icmp ne i64 %conv, 0, !dbg !5093
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !5094

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !5095
  %sub = sub nsw i32 %5, 1, !dbg !5095
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !5095
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !5095
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5097
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5098
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !5100
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !5101

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5102
  %9 = load i8*, i8** %pvRxData.addr, align 8, !dbg !5104
  %10 = load i64, i64* %xBufferLengthBytes.addr, align 8, !dbg !5105
  %11 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !5106
  %call7 = call i64 @xStreamBufferReceiveFromISR(%struct.StreamBufferDef_t* %8, i8* %9, i64 %10, i64* %11), !dbg !5107
  store i64 %call7, i64* %xReturn, align 8, !dbg !5108
  br label %if.end, !dbg !5109

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !5110

if.end8:                                          ; preds = %if.end, %land.end
  %12 = load i64, i64* %xReturn, align 8, !dbg !5111
  ret i64 %12, !dbg !5112
}

declare dso_local i64 @xStreamBufferReceiveFromISR(%struct.StreamBufferDef_t*, i8*, i64, i64*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferSendCompletedFromISR(%struct.StreamBufferDef_t* %xStreamBuffer, i64* %pxHigherPriorityTaskWoken) #0 section "privileged_functions" !dbg !5113 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %pxHigherPriorityTaskWoken.addr = alloca i64*, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !5116, metadata !DIExpression()), !dbg !5117
  store i64* %pxHigherPriorityTaskWoken, i64** %pxHigherPriorityTaskWoken.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxHigherPriorityTaskWoken.addr, metadata !5118, metadata !DIExpression()), !dbg !5119
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !5120, metadata !DIExpression()), !dbg !5121
  store i64 0, i64* %xReturn, align 8, !dbg !5121
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !5122, metadata !DIExpression()), !dbg !5123
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5123
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !5124, metadata !DIExpression()), !dbg !5125
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !5126
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !5127
  store i32 %1, i32* %lIndex, align 4, !dbg !5128
  %2 = load i32, i32* %lIndex, align 4, !dbg !5129
  %cmp = icmp sge i32 %2, 1, !dbg !5129
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !5129

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !5129
  %cmp1 = icmp slt i32 %3, 257, !dbg !5129
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !5131
  %land.ext = zext i1 %4 to i32, !dbg !5129
  %conv = sext i32 %land.ext to i64, !dbg !5129
  %cmp2 = icmp ne i64 %conv, 0, !dbg !5132
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !5133

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !5134
  %sub = sub nsw i32 %5, 1, !dbg !5134
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !5134
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !5134
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5136
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5137
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !5139
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !5140

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5141
  %9 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !5143
  %call7 = call i64 @xStreamBufferSendCompletedFromISR(%struct.StreamBufferDef_t* %8, i64* %9), !dbg !5144
  store i64 %call7, i64* %xReturn, align 8, !dbg !5145
  br label %if.end, !dbg !5146

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !5147

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !5148
  ret i64 %10, !dbg !5149
}

declare dso_local i64 @xStreamBufferSendCompletedFromISR(%struct.StreamBufferDef_t*, i64*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @MPU_xStreamBufferReceiveCompletedFromISR(%struct.StreamBufferDef_t* %xStreamBuffer, i64* %pxHigherPriorityTaskWoken) #0 section "privileged_functions" !dbg !5150 {
entry:
  %xStreamBuffer.addr = alloca %struct.StreamBufferDef_t*, align 8
  %pxHigherPriorityTaskWoken.addr = alloca i64*, align 8
  %xReturn = alloca i64, align 8
  %xInternalStreamBufferHandle = alloca %struct.StreamBufferDef_t*, align 8
  %lIndex = alloca i32, align 4
  store %struct.StreamBufferDef_t* %xStreamBuffer, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xStreamBuffer.addr, metadata !5151, metadata !DIExpression()), !dbg !5152
  store i64* %pxHigherPriorityTaskWoken, i64** %pxHigherPriorityTaskWoken.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %pxHigherPriorityTaskWoken.addr, metadata !5153, metadata !DIExpression()), !dbg !5154
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !5155, metadata !DIExpression()), !dbg !5156
  store i64 0, i64* %xReturn, align 8, !dbg !5156
  call void @llvm.dbg.declare(metadata %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, metadata !5157, metadata !DIExpression()), !dbg !5158
  store %struct.StreamBufferDef_t* null, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5158
  call void @llvm.dbg.declare(metadata i32* %lIndex, metadata !5159, metadata !DIExpression()), !dbg !5160
  %0 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xStreamBuffer.addr, align 8, !dbg !5161
  %1 = ptrtoint %struct.StreamBufferDef_t* %0 to i32, !dbg !5162
  store i32 %1, i32* %lIndex, align 4, !dbg !5163
  %2 = load i32, i32* %lIndex, align 4, !dbg !5164
  %cmp = icmp sge i32 %2, 1, !dbg !5164
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !5164

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %lIndex, align 4, !dbg !5164
  %cmp1 = icmp slt i32 %3, 257, !dbg !5164
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !5166
  %land.ext = zext i1 %4 to i32, !dbg !5164
  %conv = sext i32 %land.ext to i64, !dbg !5164
  %cmp2 = icmp ne i64 %conv, 0, !dbg !5167
  br i1 %cmp2, label %if.then, label %if.end8, !dbg !5168

if.then:                                          ; preds = %land.end
  %5 = load i32, i32* %lIndex, align 4, !dbg !5169
  %sub = sub nsw i32 %5, 1, !dbg !5169
  %call = call %struct.OpaqueObject* @MPU_GetHandleAtIndex(i32 %sub, i32 3), !dbg !5169
  %6 = bitcast %struct.OpaqueObject* %call to %struct.StreamBufferDef_t*, !dbg !5169
  store %struct.StreamBufferDef_t* %6, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5171
  %7 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5172
  %cmp4 = icmp ne %struct.StreamBufferDef_t* %7, null, !dbg !5174
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !5175

if.then6:                                         ; preds = %if.then
  %8 = load %struct.StreamBufferDef_t*, %struct.StreamBufferDef_t** %xInternalStreamBufferHandle, align 8, !dbg !5176
  %9 = load i64*, i64** %pxHigherPriorityTaskWoken.addr, align 8, !dbg !5178
  %call7 = call i64 @xStreamBufferReceiveCompletedFromISR(%struct.StreamBufferDef_t* %8, i64* %9), !dbg !5179
  store i64 %call7, i64* %xReturn, align 8, !dbg !5180
  br label %if.end, !dbg !5181

if.end:                                           ; preds = %if.then6, %if.then
  br label %if.end8, !dbg !5182

if.end8:                                          ; preds = %if.end, %land.end
  %10 = load i64, i64* %xReturn, align 8, !dbg !5183
  ret i64 %10, !dbg !5184
}

declare dso_local i64 @xStreamBufferReceiveCompletedFromISR(%struct.StreamBufferDef_t*, i64*) #2 section "privileged_functions"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !5185 {
entry:
  %retval = alloca i32, align 4
  %xTaskToResume = alloca %struct.tskTaskControlBlock*, align 8
  store i32 0, i32* %retval, align 4
  store i8 0, i8* @isTested, align 1, !dbg !5188
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTaskToResume, metadata !5189, metadata !DIExpression()), !dbg !5190
  %0 = bitcast %struct.tskTaskControlBlock** %xTaskToResume to i8*, !dbg !5191
  call void @klee_make_symbolic_controllable(i8* %0, i64 8, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i1 zeroext false), !dbg !5192
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToResume, align 8, !dbg !5193
  %cmp = icmp eq %struct.tskTaskControlBlock* %1, null, !dbg !5195
  br i1 %cmp, label %if.then, label %if.end, !dbg !5196

if.then:                                          ; preds = %entry
  store i32 0, i32* %retval, align 4, !dbg !5197
  br label %return, !dbg !5197

if.end:                                           ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToResume, align 8, !dbg !5198
  %call = call i32 (%struct.tskTaskControlBlock*, ...) bitcast (void (%struct.tskTaskControlBlock*)* @MPU_vTaskSuspendImpl to i32 (%struct.tskTaskControlBlock*, ...)*)(%struct.tskTaskControlBlock* %2), !dbg !5199
  store i32 0, i32* %retval, align 4, !dbg !5200
  br label %return, !dbg !5200

return:                                           ; preds = %if.end, %if.then
  %3 = load i32, i32* %retval, align 4, !dbg !5201
  ret i32 %3, !dbg !5201
}

declare dso_local void @klee_make_symbolic_controllable(i8*, i64, i8*, i1 zeroext) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @vTaskFunction1(i8* %pvParameters) #0 !dbg !5202 {
entry:
  %pvParameters.addr = alloca i8*, align 8
  store i8* %pvParameters, i8** %pvParameters.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvParameters.addr, metadata !5203, metadata !DIExpression()), !dbg !5204
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 0), !dbg !5205
  ret void, !dbg !5206
}

declare dso_local i32 @assert(...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @vTaskSuspend(%struct.tskTaskControlBlock* %xTaskToResume) #0 !dbg !5207 {
entry:
  %xTaskToResume.addr = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %xTaskToResume, %struct.tskTaskControlBlock** %xTaskToResume.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTaskToResume.addr, metadata !5208, metadata !DIExpression()), !dbg !5209
  %0 = load i8, i8* @isTested, align 1, !dbg !5210
  %tobool = trunc i8 %0 to i1, !dbg !5210
  %conv = zext i1 %tobool to i32, !dbg !5210
  call void (i32, ...) bitcast (void (...)* @klee_access_control_message to void (i32, ...)*)(i32 %conv), !dbg !5211
  ret void, !dbg !5212
}

declare dso_local void @klee_access_control_message(...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @portIS_TASK_PRIVILEGED() #0 !dbg !5213 {
entry:
  store i8 1, i8* @isTested, align 1, !dbg !5216
  ret void, !dbg !5217
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2, !78}
!llvm.ident = !{!84, !84}
!llvm.module.flags = !{!85, !86, !87}

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
!77 = distinct !DIGlobalVariable(name: "isTested", scope: !78, file: !79, line: 15, type: !83, isLocal: false, isDefinition: true)
!78 = distinct !DICompileUnit(language: DW_LANG_C99, file: !79, producer: "clang version 11.0.0 (https://github.com/llvm/llvm-project.git 60a25202a7dd1e00067fcfce512086ebf3788537)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !80, retainedTypes: !81, globals: !82, splitDebugInlining: false, nameTableKind: None)
!79 = !DIFile(filename: "test.c", directory: "/home/klee/FreeRTOS-Kernel-10.6.0/symbolic_execution/test_access_control")
!80 = !{}
!81 = !{!26}
!82 = !{!76}
!83 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!84 = !{!"clang version 11.0.0 (https://github.com/llvm/llvm-project.git 60a25202a7dd1e00067fcfce512086ebf3788537)"}
!85 = !{i32 7, !"Dwarf Version", i32 4}
!86 = !{i32 2, !"Debug Info Version", i32 3}
!87 = !{i32 1, !"wchar_size", i32 4}
!88 = distinct !DISubprogram(name: "MPU_xTaskDelayUntilImpl", scope: !36, file: !36, line: 363, type: !89, scopeLine: 365, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!89 = !DISubroutineType(types: !90)
!90 = !{!23, !91, !93}
!91 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !92)
!92 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !93, size: 64)
!93 = !DIDerivedType(tag: DW_TAG_typedef, name: "TickType_t", file: !24, line: 65, baseType: !40)
!94 = !DILocalVariable(name: "pxPreviousWakeTime", arg: 1, scope: !88, file: !36, line: 363, type: !91)
!95 = !DILocation(line: 363, column: 64, scope: !88)
!96 = !DILocalVariable(name: "xTimeIncrement", arg: 2, scope: !88, file: !36, line: 364, type: !93)
!97 = !DILocation(line: 364, column: 56, scope: !88)
!98 = !DILocalVariable(name: "xReturn", scope: !88, file: !36, line: 366, type: !23)
!99 = !DILocation(line: 366, column: 24, scope: !88)
!100 = !DILocalVariable(name: "xIsPreviousWakeTimeAccessible", scope: !88, file: !36, line: 367, type: !23)
!101 = !DILocation(line: 367, column: 24, scope: !88)
!102 = !DILocation(line: 369, column: 78, scope: !88)
!103 = !DILocation(line: 369, column: 45, scope: !88)
!104 = !DILocation(line: 369, column: 43, scope: !88)
!105 = !DILocation(line: 373, column: 17, scope: !106)
!106 = distinct !DILexicalBlock(scope: !88, file: !36, line: 373, column: 17)
!107 = !DILocation(line: 373, column: 47, scope: !106)
!108 = !DILocation(line: 373, column: 17, scope: !88)
!109 = !DILocation(line: 375, column: 44, scope: !110)
!110 = distinct !DILexicalBlock(scope: !106, file: !36, line: 374, column: 13)
!111 = !DILocation(line: 375, column: 64, scope: !110)
!112 = !DILocation(line: 375, column: 27, scope: !110)
!113 = !DILocation(line: 375, column: 25, scope: !110)
!114 = !DILocation(line: 376, column: 13, scope: !110)
!115 = !DILocation(line: 378, column: 20, scope: !88)
!116 = !DILocation(line: 378, column: 13, scope: !88)
!117 = distinct !DISubprogram(name: "MPU_xTaskAbortDelayImpl", scope: !36, file: !36, line: 388, type: !118, scopeLine: 389, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!118 = !DISubroutineType(types: !119)
!119 = !{!23, !32}
!120 = !DILocalVariable(name: "xTask", arg: 1, scope: !117, file: !36, line: 388, type: !32)
!121 = !DILocation(line: 388, column: 58, scope: !117)
!122 = !DILocalVariable(name: "xReturn", scope: !117, file: !36, line: 390, type: !23)
!123 = !DILocation(line: 390, column: 24, scope: !117)
!124 = !DILocalVariable(name: "xInternalTaskHandle", scope: !117, file: !36, line: 391, type: !32)
!125 = !DILocation(line: 391, column: 26, scope: !117)
!126 = !DILocalVariable(name: "lIndex", scope: !117, file: !36, line: 392, type: !27)
!127 = !DILocation(line: 392, column: 21, scope: !117)
!128 = !DILocation(line: 394, column: 17, scope: !129)
!129 = distinct !DILexicalBlock(scope: !117, file: !36, line: 394, column: 17)
!130 = !DILocation(line: 394, column: 23, scope: !129)
!131 = !DILocation(line: 394, column: 17, scope: !117)
!132 = !DILocation(line: 396, column: 44, scope: !133)
!133 = distinct !DILexicalBlock(scope: !129, file: !36, line: 395, column: 13)
!134 = !DILocation(line: 396, column: 27, scope: !133)
!135 = !DILocation(line: 396, column: 25, scope: !133)
!136 = !DILocation(line: 397, column: 13, scope: !133)
!137 = !DILocation(line: 400, column: 38, scope: !138)
!138 = distinct !DILexicalBlock(scope: !129, file: !36, line: 399, column: 13)
!139 = !DILocation(line: 400, column: 26, scope: !138)
!140 = !DILocation(line: 400, column: 24, scope: !138)
!141 = !DILocation(line: 402, column: 21, scope: !142)
!142 = distinct !DILexicalBlock(scope: !138, file: !36, line: 402, column: 21)
!143 = !DILocation(line: 0, scope: !142)
!144 = !DILocation(line: 402, column: 55, scope: !142)
!145 = !DILocation(line: 402, column: 21, scope: !138)
!146 = !DILocation(line: 404, column: 43, scope: !147)
!147 = distinct !DILexicalBlock(scope: !142, file: !36, line: 403, column: 17)
!148 = !DILocation(line: 404, column: 41, scope: !147)
!149 = !DILocation(line: 406, column: 25, scope: !150)
!150 = distinct !DILexicalBlock(scope: !147, file: !36, line: 406, column: 25)
!151 = !DILocation(line: 406, column: 45, scope: !150)
!152 = !DILocation(line: 406, column: 25, scope: !147)
!153 = !DILocation(line: 408, column: 52, scope: !154)
!154 = distinct !DILexicalBlock(scope: !150, file: !36, line: 407, column: 21)
!155 = !DILocation(line: 408, column: 35, scope: !154)
!156 = !DILocation(line: 408, column: 33, scope: !154)
!157 = !DILocation(line: 409, column: 21, scope: !154)
!158 = !DILocation(line: 410, column: 17, scope: !147)
!159 = !DILocation(line: 413, column: 20, scope: !117)
!160 = !DILocation(line: 413, column: 13, scope: !117)
!161 = distinct !DISubprogram(name: "MPU_GetHandleAtIndex", scope: !36, file: !36, line: 314, type: !162, scopeLine: 316, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !80)
!162 = !DISubroutineType(types: !163)
!163 = !{!35, !27, !47}
!164 = !DILocalVariable(name: "lIndex", arg: 1, scope: !161, file: !36, line: 314, type: !27)
!165 = !DILocation(line: 314, column: 63, scope: !161)
!166 = !DILocalVariable(name: "ulKernelObjectType", arg: 2, scope: !161, file: !36, line: 315, type: !47)
!167 = !DILocation(line: 315, column: 64, scope: !161)
!168 = !DILocation(line: 317, column: 9, scope: !169)
!169 = distinct !DILexicalBlock(scope: !161, file: !36, line: 317, column: 9)
!170 = !DILocation(line: 0, scope: !169)
!171 = !DILocation(line: 317, column: 9, scope: !161)
!172 = !DILocation(line: 318, column: 9, scope: !173)
!173 = distinct !DILexicalBlock(scope: !161, file: !36, line: 318, column: 9)
!174 = !DILocation(line: 318, column: 9, scope: !161)
!175 = !DILocation(line: 319, column: 35, scope: !161)
!176 = !DILocation(line: 319, column: 16, scope: !161)
!177 = !DILocation(line: 319, column: 44, scope: !161)
!178 = !DILocation(line: 319, column: 9, scope: !161)
!179 = distinct !DISubprogram(name: "MPU_vTaskDelayImpl", scope: !36, file: !36, line: 423, type: !180, scopeLine: 424, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!180 = !DISubroutineType(types: !181)
!181 = !{null, !93}
!182 = !DILocalVariable(name: "xTicksToDelay", arg: 1, scope: !179, file: !36, line: 423, type: !93)
!183 = !DILocation(line: 423, column: 45, scope: !179)
!184 = !DILocation(line: 425, column: 25, scope: !179)
!185 = !DILocation(line: 425, column: 13, scope: !179)
!186 = !DILocation(line: 426, column: 9, scope: !179)
!187 = distinct !DISubprogram(name: "MPU_uxTaskPriorityGetImpl", scope: !36, file: !36, line: 435, type: !188, scopeLine: 436, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!188 = !DISubroutineType(types: !189)
!189 = !{!39, !190}
!190 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !32)
!191 = !DILocalVariable(name: "pxTask", arg: 1, scope: !187, file: !36, line: 435, type: !190)
!192 = !DILocation(line: 435, column: 67, scope: !187)
!193 = !DILocalVariable(name: "uxReturn", scope: !187, file: !36, line: 437, type: !39)
!194 = !DILocation(line: 437, column: 25, scope: !187)
!195 = !DILocalVariable(name: "lIndex", scope: !187, file: !36, line: 438, type: !27)
!196 = !DILocation(line: 438, column: 21, scope: !187)
!197 = !DILocalVariable(name: "xInternalTaskHandle", scope: !187, file: !36, line: 439, type: !32)
!198 = !DILocation(line: 439, column: 26, scope: !187)
!199 = !DILocation(line: 441, column: 17, scope: !200)
!200 = distinct !DILexicalBlock(scope: !187, file: !36, line: 441, column: 17)
!201 = !DILocation(line: 441, column: 24, scope: !200)
!202 = !DILocation(line: 441, column: 17, scope: !187)
!203 = !DILocation(line: 443, column: 47, scope: !204)
!204 = distinct !DILexicalBlock(scope: !200, file: !36, line: 442, column: 13)
!205 = !DILocation(line: 443, column: 28, scope: !204)
!206 = !DILocation(line: 443, column: 26, scope: !204)
!207 = !DILocation(line: 444, column: 13, scope: !204)
!208 = !DILocation(line: 447, column: 38, scope: !209)
!209 = distinct !DILexicalBlock(scope: !200, file: !36, line: 446, column: 13)
!210 = !DILocation(line: 447, column: 26, scope: !209)
!211 = !DILocation(line: 447, column: 24, scope: !209)
!212 = !DILocation(line: 449, column: 21, scope: !213)
!213 = distinct !DILexicalBlock(scope: !209, file: !36, line: 449, column: 21)
!214 = !DILocation(line: 0, scope: !213)
!215 = !DILocation(line: 449, column: 55, scope: !213)
!216 = !DILocation(line: 449, column: 21, scope: !209)
!217 = !DILocation(line: 451, column: 43, scope: !218)
!218 = distinct !DILexicalBlock(scope: !213, file: !36, line: 450, column: 17)
!219 = !DILocation(line: 451, column: 41, scope: !218)
!220 = !DILocation(line: 453, column: 25, scope: !221)
!221 = distinct !DILexicalBlock(scope: !218, file: !36, line: 453, column: 25)
!222 = !DILocation(line: 453, column: 45, scope: !221)
!223 = !DILocation(line: 453, column: 25, scope: !218)
!224 = !DILocation(line: 455, column: 55, scope: !225)
!225 = distinct !DILexicalBlock(scope: !221, file: !36, line: 454, column: 21)
!226 = !DILocation(line: 455, column: 36, scope: !225)
!227 = !DILocation(line: 455, column: 34, scope: !225)
!228 = !DILocation(line: 456, column: 21, scope: !225)
!229 = !DILocation(line: 457, column: 17, scope: !218)
!230 = !DILocation(line: 460, column: 20, scope: !187)
!231 = !DILocation(line: 460, column: 13, scope: !187)
!232 = distinct !DISubprogram(name: "MPU_eTaskGetStateImpl", scope: !36, file: !36, line: 470, type: !233, scopeLine: 471, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!233 = !DISubroutineType(types: !234)
!234 = !{!235, !32}
!235 = !DIDerivedType(tag: DW_TAG_typedef, name: "eTaskState", file: !6, line: 109, baseType: !5)
!236 = !DILocalVariable(name: "pxTask", arg: 1, scope: !232, file: !36, line: 470, type: !32)
!237 = !DILocation(line: 470, column: 56, scope: !232)
!238 = !DILocalVariable(name: "eReturn", scope: !232, file: !36, line: 472, type: !235)
!239 = !DILocation(line: 472, column: 24, scope: !232)
!240 = !DILocalVariable(name: "xInternalTaskHandle", scope: !232, file: !36, line: 473, type: !32)
!241 = !DILocation(line: 473, column: 26, scope: !232)
!242 = !DILocalVariable(name: "lIndex", scope: !232, file: !36, line: 474, type: !27)
!243 = !DILocation(line: 474, column: 21, scope: !232)
!244 = !DILocation(line: 476, column: 17, scope: !245)
!245 = distinct !DILexicalBlock(scope: !232, file: !36, line: 476, column: 17)
!246 = !DILocation(line: 476, column: 24, scope: !245)
!247 = !DILocation(line: 476, column: 17, scope: !232)
!248 = !DILocation(line: 478, column: 42, scope: !249)
!249 = distinct !DILexicalBlock(scope: !245, file: !36, line: 477, column: 13)
!250 = !DILocation(line: 478, column: 27, scope: !249)
!251 = !DILocation(line: 478, column: 25, scope: !249)
!252 = !DILocation(line: 479, column: 13, scope: !249)
!253 = !DILocation(line: 482, column: 38, scope: !254)
!254 = distinct !DILexicalBlock(scope: !245, file: !36, line: 481, column: 13)
!255 = !DILocation(line: 482, column: 26, scope: !254)
!256 = !DILocation(line: 482, column: 24, scope: !254)
!257 = !DILocation(line: 484, column: 21, scope: !258)
!258 = distinct !DILexicalBlock(scope: !254, file: !36, line: 484, column: 21)
!259 = !DILocation(line: 0, scope: !258)
!260 = !DILocation(line: 484, column: 55, scope: !258)
!261 = !DILocation(line: 484, column: 21, scope: !254)
!262 = !DILocation(line: 486, column: 43, scope: !263)
!263 = distinct !DILexicalBlock(scope: !258, file: !36, line: 485, column: 17)
!264 = !DILocation(line: 486, column: 41, scope: !263)
!265 = !DILocation(line: 488, column: 25, scope: !266)
!266 = distinct !DILexicalBlock(scope: !263, file: !36, line: 488, column: 25)
!267 = !DILocation(line: 488, column: 45, scope: !266)
!268 = !DILocation(line: 488, column: 25, scope: !263)
!269 = !DILocation(line: 490, column: 50, scope: !270)
!270 = distinct !DILexicalBlock(scope: !266, file: !36, line: 489, column: 21)
!271 = !DILocation(line: 490, column: 35, scope: !270)
!272 = !DILocation(line: 490, column: 33, scope: !270)
!273 = !DILocation(line: 491, column: 21, scope: !270)
!274 = !DILocation(line: 492, column: 17, scope: !263)
!275 = !DILocation(line: 495, column: 20, scope: !232)
!276 = !DILocation(line: 495, column: 13, scope: !232)
!277 = distinct !DISubprogram(name: "MPU_vTaskGetInfoImpl", scope: !36, file: !36, line: 508, type: !278, scopeLine: 512, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!278 = !DISubroutineType(types: !279)
!279 = !{null, !32, !280, !23, !235}
!280 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !281, size: 64)
!281 = !DIDerivedType(tag: DW_TAG_typedef, name: "TaskStatus_t", file: !6, line: 174, baseType: !282)
!282 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xTASK_STATUS", file: !6, line: 159, size: 576, elements: !283)
!283 = !{!284, !285, !289, !290, !291, !292, !293, !294, !297}
!284 = !DIDerivedType(tag: DW_TAG_member, name: "xHandle", scope: !282, file: !6, line: 161, baseType: !32, size: 64)
!285 = !DIDerivedType(tag: DW_TAG_member, name: "pcTaskName", scope: !282, file: !6, line: 162, baseType: !286, size: 64, offset: 64)
!286 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !287, size: 64)
!287 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !288)
!288 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!289 = !DIDerivedType(tag: DW_TAG_member, name: "xTaskNumber", scope: !282, file: !6, line: 163, baseType: !39, size: 64, offset: 128)
!290 = !DIDerivedType(tag: DW_TAG_member, name: "eCurrentState", scope: !282, file: !6, line: 164, baseType: !235, size: 32, offset: 192)
!291 = !DIDerivedType(tag: DW_TAG_member, name: "uxCurrentPriority", scope: !282, file: !6, line: 165, baseType: !39, size: 64, offset: 256)
!292 = !DIDerivedType(tag: DW_TAG_member, name: "uxBasePriority", scope: !282, file: !6, line: 166, baseType: !39, size: 64, offset: 320)
!293 = !DIDerivedType(tag: DW_TAG_member, name: "ulRunTimeCounter", scope: !282, file: !6, line: 167, baseType: !47, size: 32, offset: 384)
!294 = !DIDerivedType(tag: DW_TAG_member, name: "pxStackBase", scope: !282, file: !6, line: 168, baseType: !295, size: 64, offset: 448)
!295 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !296, size: 64)
!296 = !DIDerivedType(tag: DW_TAG_typedef, name: "StackType_t", file: !24, line: 61, baseType: !40)
!297 = !DIDerivedType(tag: DW_TAG_member, name: "usStackHighWaterMark", scope: !282, file: !6, line: 173, baseType: !298, size: 16, offset: 512)
!298 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !48, line: 25, baseType: !299)
!299 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !30, line: 39, baseType: !300)
!300 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!301 = !DILocalVariable(name: "xTask", arg: 1, scope: !277, file: !36, line: 508, type: !32)
!302 = !DILocation(line: 508, column: 49, scope: !277)
!303 = !DILocalVariable(name: "pxTaskStatus", arg: 2, scope: !277, file: !36, line: 509, type: !280)
!304 = !DILocation(line: 509, column: 51, scope: !277)
!305 = !DILocalVariable(name: "xGetFreeStackSpace", arg: 3, scope: !277, file: !36, line: 510, type: !23)
!306 = !DILocation(line: 510, column: 47, scope: !277)
!307 = !DILocalVariable(name: "eState", arg: 4, scope: !277, file: !36, line: 511, type: !235)
!308 = !DILocation(line: 511, column: 47, scope: !277)
!309 = !DILocalVariable(name: "lIndex", scope: !277, file: !36, line: 513, type: !27)
!310 = !DILocation(line: 513, column: 21, scope: !277)
!311 = !DILocalVariable(name: "xInternalTaskHandle", scope: !277, file: !36, line: 514, type: !32)
!312 = !DILocation(line: 514, column: 26, scope: !277)
!313 = !DILocalVariable(name: "xIsTaskStatusWriteable", scope: !277, file: !36, line: 515, type: !23)
!314 = !DILocation(line: 515, column: 24, scope: !277)
!315 = !DILocation(line: 517, column: 71, scope: !277)
!316 = !DILocation(line: 517, column: 38, scope: !277)
!317 = !DILocation(line: 517, column: 36, scope: !277)
!318 = !DILocation(line: 521, column: 17, scope: !319)
!319 = distinct !DILexicalBlock(scope: !277, file: !36, line: 521, column: 17)
!320 = !DILocation(line: 521, column: 40, scope: !319)
!321 = !DILocation(line: 521, column: 17, scope: !277)
!322 = !DILocation(line: 523, column: 21, scope: !323)
!323 = distinct !DILexicalBlock(scope: !324, file: !36, line: 523, column: 21)
!324 = distinct !DILexicalBlock(scope: !319, file: !36, line: 522, column: 13)
!325 = !DILocation(line: 523, column: 27, scope: !323)
!326 = !DILocation(line: 523, column: 21, scope: !324)
!327 = !DILocation(line: 525, column: 35, scope: !328)
!328 = distinct !DILexicalBlock(scope: !323, file: !36, line: 524, column: 17)
!329 = !DILocation(line: 525, column: 42, scope: !328)
!330 = !DILocation(line: 525, column: 56, scope: !328)
!331 = !DILocation(line: 525, column: 76, scope: !328)
!332 = !DILocation(line: 525, column: 21, scope: !328)
!333 = !DILocation(line: 526, column: 17, scope: !328)
!334 = !DILocation(line: 529, column: 42, scope: !335)
!335 = distinct !DILexicalBlock(scope: !323, file: !36, line: 528, column: 17)
!336 = !DILocation(line: 529, column: 30, scope: !335)
!337 = !DILocation(line: 529, column: 28, scope: !335)
!338 = !DILocation(line: 531, column: 25, scope: !339)
!339 = distinct !DILexicalBlock(scope: !335, file: !36, line: 531, column: 25)
!340 = !DILocation(line: 0, scope: !339)
!341 = !DILocation(line: 531, column: 59, scope: !339)
!342 = !DILocation(line: 531, column: 25, scope: !335)
!343 = !DILocation(line: 533, column: 47, scope: !344)
!344 = distinct !DILexicalBlock(scope: !339, file: !36, line: 532, column: 21)
!345 = !DILocation(line: 533, column: 45, scope: !344)
!346 = !DILocation(line: 535, column: 29, scope: !347)
!347 = distinct !DILexicalBlock(scope: !344, file: !36, line: 535, column: 29)
!348 = !DILocation(line: 535, column: 49, scope: !347)
!349 = !DILocation(line: 535, column: 29, scope: !344)
!350 = !DILocation(line: 537, column: 43, scope: !351)
!351 = distinct !DILexicalBlock(scope: !347, file: !36, line: 536, column: 25)
!352 = !DILocation(line: 537, column: 64, scope: !351)
!353 = !DILocation(line: 537, column: 78, scope: !351)
!354 = !DILocation(line: 537, column: 98, scope: !351)
!355 = !DILocation(line: 537, column: 29, scope: !351)
!356 = !DILocation(line: 538, column: 25, scope: !351)
!357 = !DILocation(line: 539, column: 21, scope: !344)
!358 = !DILocation(line: 541, column: 13, scope: !324)
!359 = !DILocation(line: 542, column: 9, scope: !277)
!360 = distinct !DISubprogram(name: "MPU_xTaskGetIdleTaskHandleImpl", scope: !36, file: !36, line: 551, type: !361, scopeLine: 552, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!361 = !DISubroutineType(types: !362)
!362 = !{!32}
!363 = !DILocalVariable(name: "xIdleTaskHandle", scope: !360, file: !36, line: 553, type: !32)
!364 = !DILocation(line: 553, column: 26, scope: !360)
!365 = !DILocation(line: 555, column: 31, scope: !360)
!366 = !DILocation(line: 555, column: 29, scope: !360)
!367 = !DILocation(line: 557, column: 20, scope: !360)
!368 = !DILocation(line: 557, column: 13, scope: !360)
!369 = distinct !DISubprogram(name: "MPU_vTaskSuspendImpl", scope: !36, file: !36, line: 567, type: !370, scopeLine: 568, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!370 = !DISubroutineType(types: !371)
!371 = !{null, !32}
!372 = !DILocalVariable(name: "pxTaskToSuspend", arg: 1, scope: !369, file: !36, line: 567, type: !32)
!373 = !DILocation(line: 567, column: 49, scope: !369)
!374 = !DILocalVariable(name: "lIndex", scope: !369, file: !36, line: 569, type: !27)
!375 = !DILocation(line: 569, column: 21, scope: !369)
!376 = !DILocalVariable(name: "xInternalTaskHandle", scope: !369, file: !36, line: 570, type: !32)
!377 = !DILocation(line: 570, column: 26, scope: !369)
!378 = !DILocation(line: 572, column: 17, scope: !379)
!379 = distinct !DILexicalBlock(scope: !369, file: !36, line: 572, column: 17)
!380 = !DILocation(line: 572, column: 33, scope: !379)
!381 = !DILocation(line: 572, column: 17, scope: !369)
!382 = !DILocation(line: 574, column: 31, scope: !383)
!383 = distinct !DILexicalBlock(scope: !379, file: !36, line: 573, column: 13)
!384 = !DILocation(line: 574, column: 17, scope: !383)
!385 = !DILocation(line: 575, column: 13, scope: !383)
!386 = !DILocation(line: 580, column: 23, scope: !387)
!387 = distinct !DILexicalBlock(scope: !388, file: !36, line: 580, column: 21)
!388 = distinct !DILexicalBlock(scope: !379, file: !36, line: 577, column: 13)
!389 = !DILocation(line: 580, column: 48, scope: !387)
!390 = !DILocation(line: 580, column: 79, scope: !387)
!391 = !DILocation(line: 580, column: 84, scope: !387)
!392 = !DILocation(line: 580, column: 109, scope: !387)
!393 = !DILocation(line: 580, column: 21, scope: !388)
!394 = !DILocation(line: 582, column: 42, scope: !395)
!395 = distinct !DILexicalBlock(scope: !387, file: !36, line: 581, column: 17)
!396 = !DILocation(line: 582, column: 30, scope: !395)
!397 = !DILocation(line: 582, column: 28, scope: !395)
!398 = !DILocation(line: 584, column: 25, scope: !399)
!399 = distinct !DILexicalBlock(scope: !395, file: !36, line: 584, column: 25)
!400 = !DILocation(line: 0, scope: !399)
!401 = !DILocation(line: 584, column: 59, scope: !399)
!402 = !DILocation(line: 584, column: 25, scope: !395)
!403 = !DILocation(line: 586, column: 47, scope: !404)
!404 = distinct !DILexicalBlock(scope: !399, file: !36, line: 585, column: 21)
!405 = !DILocation(line: 586, column: 45, scope: !404)
!406 = !DILocation(line: 588, column: 29, scope: !407)
!407 = distinct !DILexicalBlock(scope: !404, file: !36, line: 588, column: 29)
!408 = !DILocation(line: 588, column: 49, scope: !407)
!409 = !DILocation(line: 588, column: 29, scope: !404)
!410 = !DILocation(line: 590, column: 43, scope: !411)
!411 = distinct !DILexicalBlock(scope: !407, file: !36, line: 589, column: 25)
!412 = !DILocation(line: 590, column: 29, scope: !411)
!413 = !DILocation(line: 591, column: 25, scope: !411)
!414 = !DILocation(line: 592, column: 21, scope: !404)
!415 = !DILocation(line: 593, column: 17, scope: !395)
!416 = !DILocation(line: 595, column: 9, scope: !369)
!417 = distinct !DISubprogram(name: "MPU_vTaskResumeImpl", scope: !36, file: !36, line: 604, type: !370, scopeLine: 605, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!418 = !DILocalVariable(name: "pxTaskToResume", arg: 1, scope: !417, file: !36, line: 604, type: !32)
!419 = !DILocation(line: 604, column: 48, scope: !417)
!420 = !DILocalVariable(name: "lIndex", scope: !417, file: !36, line: 606, type: !27)
!421 = !DILocation(line: 606, column: 21, scope: !417)
!422 = !DILocalVariable(name: "xInternalTaskHandle", scope: !417, file: !36, line: 607, type: !32)
!423 = !DILocation(line: 607, column: 26, scope: !417)
!424 = !DILocation(line: 609, column: 34, scope: !417)
!425 = !DILocation(line: 609, column: 22, scope: !417)
!426 = !DILocation(line: 609, column: 20, scope: !417)
!427 = !DILocation(line: 611, column: 17, scope: !428)
!428 = distinct !DILexicalBlock(scope: !417, file: !36, line: 611, column: 17)
!429 = !DILocation(line: 0, scope: !428)
!430 = !DILocation(line: 611, column: 51, scope: !428)
!431 = !DILocation(line: 611, column: 17, scope: !417)
!432 = !DILocation(line: 613, column: 39, scope: !433)
!433 = distinct !DILexicalBlock(scope: !428, file: !36, line: 612, column: 13)
!434 = !DILocation(line: 613, column: 37, scope: !433)
!435 = !DILocation(line: 615, column: 21, scope: !436)
!436 = distinct !DILexicalBlock(scope: !433, file: !36, line: 615, column: 21)
!437 = !DILocation(line: 615, column: 41, scope: !436)
!438 = !DILocation(line: 615, column: 21, scope: !433)
!439 = !DILocation(line: 617, column: 34, scope: !440)
!440 = distinct !DILexicalBlock(scope: !436, file: !36, line: 616, column: 17)
!441 = !DILocation(line: 617, column: 21, scope: !440)
!442 = !DILocation(line: 618, column: 17, scope: !440)
!443 = !DILocation(line: 619, column: 13, scope: !433)
!444 = !DILocation(line: 620, column: 9, scope: !417)
!445 = distinct !DISubprogram(name: "MPU_xTaskGetTickCountImpl", scope: !36, file: !36, line: 627, type: !446, scopeLine: 628, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!446 = !DISubroutineType(types: !447)
!447 = !{!93}
!448 = !DILocalVariable(name: "xReturn", scope: !445, file: !36, line: 629, type: !93)
!449 = !DILocation(line: 629, column: 20, scope: !445)
!450 = !DILocation(line: 631, column: 19, scope: !445)
!451 = !DILocation(line: 631, column: 17, scope: !445)
!452 = !DILocation(line: 633, column: 16, scope: !445)
!453 = !DILocation(line: 633, column: 9, scope: !445)
!454 = distinct !DISubprogram(name: "MPU_uxTaskGetNumberOfTasksImpl", scope: !36, file: !36, line: 639, type: !455, scopeLine: 640, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!455 = !DISubroutineType(types: !456)
!456 = !{!39}
!457 = !DILocalVariable(name: "uxReturn", scope: !454, file: !36, line: 641, type: !39)
!458 = !DILocation(line: 641, column: 21, scope: !454)
!459 = !DILocation(line: 643, column: 20, scope: !454)
!460 = !DILocation(line: 643, column: 18, scope: !454)
!461 = !DILocation(line: 645, column: 16, scope: !454)
!462 = !DILocation(line: 645, column: 9, scope: !454)
!463 = distinct !DISubprogram(name: "MPU_pcTaskGetNameImpl", scope: !36, file: !36, line: 651, type: !464, scopeLine: 652, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!464 = !DISubroutineType(types: !465)
!465 = !{!466, !32}
!466 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !288, size: 64)
!467 = !DILocalVariable(name: "xTaskToQuery", arg: 1, scope: !463, file: !36, line: 651, type: !32)
!468 = !DILocation(line: 651, column: 48, scope: !463)
!469 = !DILocalVariable(name: "pcReturn", scope: !463, file: !36, line: 653, type: !466)
!470 = !DILocation(line: 653, column: 16, scope: !463)
!471 = !DILocalVariable(name: "lIndex", scope: !463, file: !36, line: 654, type: !27)
!472 = !DILocation(line: 654, column: 17, scope: !463)
!473 = !DILocalVariable(name: "xInternalTaskHandle", scope: !463, file: !36, line: 655, type: !32)
!474 = !DILocation(line: 655, column: 22, scope: !463)
!475 = !DILocation(line: 657, column: 13, scope: !476)
!476 = distinct !DILexicalBlock(scope: !463, file: !36, line: 657, column: 13)
!477 = !DILocation(line: 657, column: 26, scope: !476)
!478 = !DILocation(line: 657, column: 13, scope: !463)
!479 = !DILocation(line: 659, column: 39, scope: !480)
!480 = distinct !DILexicalBlock(scope: !476, file: !36, line: 658, column: 9)
!481 = !DILocation(line: 659, column: 24, scope: !480)
!482 = !DILocation(line: 659, column: 22, scope: !480)
!483 = !DILocation(line: 660, column: 9, scope: !480)
!484 = !DILocation(line: 663, column: 34, scope: !485)
!485 = distinct !DILexicalBlock(scope: !476, file: !36, line: 662, column: 9)
!486 = !DILocation(line: 663, column: 22, scope: !485)
!487 = !DILocation(line: 663, column: 20, scope: !485)
!488 = !DILocation(line: 665, column: 17, scope: !489)
!489 = distinct !DILexicalBlock(scope: !485, file: !36, line: 665, column: 17)
!490 = !DILocation(line: 0, scope: !489)
!491 = !DILocation(line: 665, column: 51, scope: !489)
!492 = !DILocation(line: 665, column: 17, scope: !485)
!493 = !DILocation(line: 667, column: 39, scope: !494)
!494 = distinct !DILexicalBlock(scope: !489, file: !36, line: 666, column: 13)
!495 = !DILocation(line: 667, column: 37, scope: !494)
!496 = !DILocation(line: 669, column: 21, scope: !497)
!497 = distinct !DILexicalBlock(scope: !494, file: !36, line: 669, column: 21)
!498 = !DILocation(line: 669, column: 41, scope: !497)
!499 = !DILocation(line: 669, column: 21, scope: !494)
!500 = !DILocation(line: 671, column: 47, scope: !501)
!501 = distinct !DILexicalBlock(scope: !497, file: !36, line: 670, column: 17)
!502 = !DILocation(line: 671, column: 32, scope: !501)
!503 = !DILocation(line: 671, column: 30, scope: !501)
!504 = !DILocation(line: 672, column: 17, scope: !501)
!505 = !DILocation(line: 673, column: 13, scope: !494)
!506 = !DILocation(line: 676, column: 16, scope: !463)
!507 = !DILocation(line: 676, column: 9, scope: !463)
!508 = distinct !DISubprogram(name: "MPU_ulTaskGetRunTimeCounterImpl", scope: !36, file: !36, line: 684, type: !509, scopeLine: 685, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!509 = !DISubroutineType(types: !510)
!510 = !{!47, !190}
!511 = !DILocalVariable(name: "xTask", arg: 1, scope: !508, file: !36, line: 684, type: !190)
!512 = !DILocation(line: 684, column: 89, scope: !508)
!513 = !DILocalVariable(name: "xReturn", scope: !508, file: !36, line: 686, type: !47)
!514 = !DILocation(line: 686, column: 41, scope: !508)
!515 = !DILocalVariable(name: "lIndex", scope: !508, file: !36, line: 687, type: !27)
!516 = !DILocation(line: 687, column: 21, scope: !508)
!517 = !DILocalVariable(name: "xInternalTaskHandle", scope: !508, file: !36, line: 688, type: !32)
!518 = !DILocation(line: 688, column: 26, scope: !508)
!519 = !DILocation(line: 690, column: 17, scope: !520)
!520 = distinct !DILexicalBlock(scope: !508, file: !36, line: 690, column: 17)
!521 = !DILocation(line: 690, column: 23, scope: !520)
!522 = !DILocation(line: 690, column: 17, scope: !508)
!523 = !DILocation(line: 692, column: 52, scope: !524)
!524 = distinct !DILexicalBlock(scope: !520, file: !36, line: 691, column: 13)
!525 = !DILocation(line: 692, column: 27, scope: !524)
!526 = !DILocation(line: 692, column: 25, scope: !524)
!527 = !DILocation(line: 693, column: 13, scope: !524)
!528 = !DILocation(line: 696, column: 38, scope: !529)
!529 = distinct !DILexicalBlock(scope: !520, file: !36, line: 695, column: 13)
!530 = !DILocation(line: 696, column: 26, scope: !529)
!531 = !DILocation(line: 696, column: 24, scope: !529)
!532 = !DILocation(line: 698, column: 21, scope: !533)
!533 = distinct !DILexicalBlock(scope: !529, file: !36, line: 698, column: 21)
!534 = !DILocation(line: 0, scope: !533)
!535 = !DILocation(line: 698, column: 55, scope: !533)
!536 = !DILocation(line: 698, column: 21, scope: !529)
!537 = !DILocation(line: 700, column: 43, scope: !538)
!538 = distinct !DILexicalBlock(scope: !533, file: !36, line: 699, column: 17)
!539 = !DILocation(line: 700, column: 41, scope: !538)
!540 = !DILocation(line: 702, column: 25, scope: !541)
!541 = distinct !DILexicalBlock(scope: !538, file: !36, line: 702, column: 25)
!542 = !DILocation(line: 702, column: 45, scope: !541)
!543 = !DILocation(line: 702, column: 25, scope: !538)
!544 = !DILocation(line: 704, column: 60, scope: !545)
!545 = distinct !DILexicalBlock(scope: !541, file: !36, line: 703, column: 21)
!546 = !DILocation(line: 704, column: 35, scope: !545)
!547 = !DILocation(line: 704, column: 33, scope: !545)
!548 = !DILocation(line: 705, column: 21, scope: !545)
!549 = !DILocation(line: 706, column: 17, scope: !538)
!550 = !DILocation(line: 709, column: 20, scope: !508)
!551 = !DILocation(line: 709, column: 13, scope: !508)
!552 = distinct !DISubprogram(name: "MPU_ulTaskGetRunTimePercentImpl", scope: !36, file: !36, line: 719, type: !509, scopeLine: 720, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!553 = !DILocalVariable(name: "xTask", arg: 1, scope: !552, file: !36, line: 719, type: !190)
!554 = !DILocation(line: 719, column: 89, scope: !552)
!555 = !DILocalVariable(name: "xReturn", scope: !552, file: !36, line: 721, type: !47)
!556 = !DILocation(line: 721, column: 41, scope: !552)
!557 = !DILocalVariable(name: "lIndex", scope: !552, file: !36, line: 722, type: !27)
!558 = !DILocation(line: 722, column: 21, scope: !552)
!559 = !DILocalVariable(name: "xInternalTaskHandle", scope: !552, file: !36, line: 723, type: !32)
!560 = !DILocation(line: 723, column: 26, scope: !552)
!561 = !DILocation(line: 725, column: 17, scope: !562)
!562 = distinct !DILexicalBlock(scope: !552, file: !36, line: 725, column: 17)
!563 = !DILocation(line: 725, column: 23, scope: !562)
!564 = !DILocation(line: 725, column: 17, scope: !552)
!565 = !DILocation(line: 727, column: 52, scope: !566)
!566 = distinct !DILexicalBlock(scope: !562, file: !36, line: 726, column: 13)
!567 = !DILocation(line: 727, column: 27, scope: !566)
!568 = !DILocation(line: 727, column: 25, scope: !566)
!569 = !DILocation(line: 728, column: 13, scope: !566)
!570 = !DILocation(line: 731, column: 38, scope: !571)
!571 = distinct !DILexicalBlock(scope: !562, file: !36, line: 730, column: 13)
!572 = !DILocation(line: 731, column: 26, scope: !571)
!573 = !DILocation(line: 731, column: 24, scope: !571)
!574 = !DILocation(line: 733, column: 21, scope: !575)
!575 = distinct !DILexicalBlock(scope: !571, file: !36, line: 733, column: 21)
!576 = !DILocation(line: 0, scope: !575)
!577 = !DILocation(line: 733, column: 55, scope: !575)
!578 = !DILocation(line: 733, column: 21, scope: !571)
!579 = !DILocation(line: 735, column: 43, scope: !580)
!580 = distinct !DILexicalBlock(scope: !575, file: !36, line: 734, column: 17)
!581 = !DILocation(line: 735, column: 41, scope: !580)
!582 = !DILocation(line: 737, column: 25, scope: !583)
!583 = distinct !DILexicalBlock(scope: !580, file: !36, line: 737, column: 25)
!584 = !DILocation(line: 737, column: 45, scope: !583)
!585 = !DILocation(line: 737, column: 25, scope: !580)
!586 = !DILocation(line: 739, column: 60, scope: !587)
!587 = distinct !DILexicalBlock(scope: !583, file: !36, line: 738, column: 21)
!588 = !DILocation(line: 739, column: 35, scope: !587)
!589 = !DILocation(line: 739, column: 33, scope: !587)
!590 = !DILocation(line: 740, column: 21, scope: !587)
!591 = !DILocation(line: 741, column: 17, scope: !580)
!592 = !DILocation(line: 744, column: 20, scope: !552)
!593 = !DILocation(line: 744, column: 13, scope: !552)
!594 = distinct !DISubprogram(name: "MPU_ulTaskGetIdleRunTimePercentImpl", scope: !36, file: !36, line: 754, type: !595, scopeLine: 755, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!595 = !DISubroutineType(types: !596)
!596 = !{!47}
!597 = !DILocalVariable(name: "xReturn", scope: !594, file: !36, line: 756, type: !47)
!598 = !DILocation(line: 756, column: 41, scope: !594)
!599 = !DILocation(line: 758, column: 23, scope: !594)
!600 = !DILocation(line: 758, column: 21, scope: !594)
!601 = !DILocation(line: 760, column: 20, scope: !594)
!602 = !DILocation(line: 760, column: 13, scope: !594)
!603 = distinct !DISubprogram(name: "MPU_ulTaskGetIdleRunTimeCounterImpl", scope: !36, file: !36, line: 770, type: !595, scopeLine: 771, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!604 = !DILocalVariable(name: "xReturn", scope: !603, file: !36, line: 772, type: !47)
!605 = !DILocation(line: 772, column: 41, scope: !603)
!606 = !DILocation(line: 774, column: 23, scope: !603)
!607 = !DILocation(line: 774, column: 21, scope: !603)
!608 = !DILocation(line: 776, column: 20, scope: !603)
!609 = !DILocation(line: 776, column: 13, scope: !603)
!610 = distinct !DISubprogram(name: "MPU_vTaskSetApplicationTaskTagImpl", scope: !36, file: !36, line: 787, type: !611, scopeLine: 789, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!611 = !DISubroutineType(types: !612)
!612 = !{null, !32, !613}
!613 = !DIDerivedType(tag: DW_TAG_typedef, name: "TaskHookFunction_t", file: !6, line: 98, baseType: !614)
!614 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !615, size: 64)
!615 = !DISubroutineType(types: !616)
!616 = !{!23, !26}
!617 = !DILocalVariable(name: "xTask", arg: 1, scope: !610, file: !36, line: 787, type: !32)
!618 = !DILocation(line: 787, column: 63, scope: !610)
!619 = !DILocalVariable(name: "pxTagValue", arg: 2, scope: !610, file: !36, line: 788, type: !613)
!620 = !DILocation(line: 788, column: 69, scope: !610)
!621 = !DILocalVariable(name: "xInternalTaskHandle", scope: !610, file: !36, line: 790, type: !32)
!622 = !DILocation(line: 790, column: 26, scope: !610)
!623 = !DILocalVariable(name: "lIndex", scope: !610, file: !36, line: 791, type: !27)
!624 = !DILocation(line: 791, column: 21, scope: !610)
!625 = !DILocation(line: 793, column: 17, scope: !626)
!626 = distinct !DILexicalBlock(scope: !610, file: !36, line: 793, column: 17)
!627 = !DILocation(line: 793, column: 23, scope: !626)
!628 = !DILocation(line: 793, column: 17, scope: !610)
!629 = !DILocation(line: 795, column: 45, scope: !630)
!630 = distinct !DILexicalBlock(scope: !626, file: !36, line: 794, column: 13)
!631 = !DILocation(line: 795, column: 52, scope: !630)
!632 = !DILocation(line: 795, column: 17, scope: !630)
!633 = !DILocation(line: 796, column: 13, scope: !630)
!634 = !DILocation(line: 799, column: 38, scope: !635)
!635 = distinct !DILexicalBlock(scope: !626, file: !36, line: 798, column: 13)
!636 = !DILocation(line: 799, column: 26, scope: !635)
!637 = !DILocation(line: 799, column: 24, scope: !635)
!638 = !DILocation(line: 801, column: 21, scope: !639)
!639 = distinct !DILexicalBlock(scope: !635, file: !36, line: 801, column: 21)
!640 = !DILocation(line: 0, scope: !639)
!641 = !DILocation(line: 801, column: 55, scope: !639)
!642 = !DILocation(line: 801, column: 21, scope: !635)
!643 = !DILocation(line: 803, column: 43, scope: !644)
!644 = distinct !DILexicalBlock(scope: !639, file: !36, line: 802, column: 17)
!645 = !DILocation(line: 803, column: 41, scope: !644)
!646 = !DILocation(line: 805, column: 25, scope: !647)
!647 = distinct !DILexicalBlock(scope: !644, file: !36, line: 805, column: 25)
!648 = !DILocation(line: 805, column: 45, scope: !647)
!649 = !DILocation(line: 805, column: 25, scope: !644)
!650 = !DILocation(line: 807, column: 53, scope: !651)
!651 = distinct !DILexicalBlock(scope: !647, file: !36, line: 806, column: 21)
!652 = !DILocation(line: 807, column: 74, scope: !651)
!653 = !DILocation(line: 807, column: 25, scope: !651)
!654 = !DILocation(line: 808, column: 21, scope: !651)
!655 = !DILocation(line: 809, column: 17, scope: !644)
!656 = !DILocation(line: 811, column: 9, scope: !610)
!657 = distinct !DISubprogram(name: "MPU_xTaskGetApplicationTaskTagImpl", scope: !36, file: !36, line: 820, type: !658, scopeLine: 821, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!658 = !DISubroutineType(types: !659)
!659 = !{!613, !32}
!660 = !DILocalVariable(name: "xTask", arg: 1, scope: !657, file: !36, line: 820, type: !32)
!661 = !DILocation(line: 820, column: 77, scope: !657)
!662 = !DILocalVariable(name: "xReturn", scope: !657, file: !36, line: 822, type: !613)
!663 = !DILocation(line: 822, column: 32, scope: !657)
!664 = !DILocalVariable(name: "lIndex", scope: !657, file: !36, line: 823, type: !27)
!665 = !DILocation(line: 823, column: 21, scope: !657)
!666 = !DILocalVariable(name: "xInternalTaskHandle", scope: !657, file: !36, line: 824, type: !32)
!667 = !DILocation(line: 824, column: 26, scope: !657)
!668 = !DILocation(line: 826, column: 17, scope: !669)
!669 = distinct !DILexicalBlock(scope: !657, file: !36, line: 826, column: 17)
!670 = !DILocation(line: 826, column: 23, scope: !669)
!671 = !DILocation(line: 826, column: 17, scope: !657)
!672 = !DILocation(line: 828, column: 55, scope: !673)
!673 = distinct !DILexicalBlock(scope: !669, file: !36, line: 827, column: 13)
!674 = !DILocation(line: 828, column: 27, scope: !673)
!675 = !DILocation(line: 828, column: 25, scope: !673)
!676 = !DILocation(line: 829, column: 13, scope: !673)
!677 = !DILocation(line: 832, column: 38, scope: !678)
!678 = distinct !DILexicalBlock(scope: !669, file: !36, line: 831, column: 13)
!679 = !DILocation(line: 832, column: 26, scope: !678)
!680 = !DILocation(line: 832, column: 24, scope: !678)
!681 = !DILocation(line: 834, column: 21, scope: !682)
!682 = distinct !DILexicalBlock(scope: !678, file: !36, line: 834, column: 21)
!683 = !DILocation(line: 0, scope: !682)
!684 = !DILocation(line: 834, column: 55, scope: !682)
!685 = !DILocation(line: 834, column: 21, scope: !678)
!686 = !DILocation(line: 836, column: 43, scope: !687)
!687 = distinct !DILexicalBlock(scope: !682, file: !36, line: 835, column: 17)
!688 = !DILocation(line: 836, column: 41, scope: !687)
!689 = !DILocation(line: 838, column: 25, scope: !690)
!690 = distinct !DILexicalBlock(scope: !687, file: !36, line: 838, column: 25)
!691 = !DILocation(line: 838, column: 45, scope: !690)
!692 = !DILocation(line: 838, column: 25, scope: !687)
!693 = !DILocation(line: 840, column: 63, scope: !694)
!694 = distinct !DILexicalBlock(scope: !690, file: !36, line: 839, column: 21)
!695 = !DILocation(line: 840, column: 35, scope: !694)
!696 = !DILocation(line: 840, column: 33, scope: !694)
!697 = !DILocation(line: 841, column: 21, scope: !694)
!698 = !DILocation(line: 842, column: 17, scope: !687)
!699 = !DILocation(line: 845, column: 20, scope: !657)
!700 = !DILocation(line: 845, column: 13, scope: !657)
!701 = distinct !DISubprogram(name: "MPU_vTaskSetThreadLocalStoragePointerImpl", scope: !36, file: !36, line: 857, type: !702, scopeLine: 860, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!702 = !DISubroutineType(types: !703)
!703 = !{null, !32, !23, !26}
!704 = !DILocalVariable(name: "xTaskToSet", arg: 1, scope: !701, file: !36, line: 857, type: !32)
!705 = !DILocation(line: 857, column: 70, scope: !701)
!706 = !DILocalVariable(name: "xIndex", arg: 2, scope: !701, file: !36, line: 858, type: !23)
!707 = !DILocation(line: 858, column: 68, scope: !701)
!708 = !DILocalVariable(name: "pvValue", arg: 3, scope: !701, file: !36, line: 859, type: !26)
!709 = !DILocation(line: 859, column: 64, scope: !701)
!710 = !DILocalVariable(name: "lIndex", scope: !701, file: !36, line: 861, type: !27)
!711 = !DILocation(line: 861, column: 21, scope: !701)
!712 = !DILocalVariable(name: "xInternalTaskHandle", scope: !701, file: !36, line: 862, type: !32)
!713 = !DILocation(line: 862, column: 26, scope: !701)
!714 = !DILocation(line: 864, column: 17, scope: !715)
!715 = distinct !DILexicalBlock(scope: !701, file: !36, line: 864, column: 17)
!716 = !DILocation(line: 864, column: 28, scope: !715)
!717 = !DILocation(line: 864, column: 17, scope: !701)
!718 = !DILocation(line: 866, column: 52, scope: !719)
!719 = distinct !DILexicalBlock(scope: !715, file: !36, line: 865, column: 13)
!720 = !DILocation(line: 866, column: 64, scope: !719)
!721 = !DILocation(line: 866, column: 72, scope: !719)
!722 = !DILocation(line: 866, column: 17, scope: !719)
!723 = !DILocation(line: 867, column: 13, scope: !719)
!724 = !DILocation(line: 870, column: 38, scope: !725)
!725 = distinct !DILexicalBlock(scope: !715, file: !36, line: 869, column: 13)
!726 = !DILocation(line: 870, column: 26, scope: !725)
!727 = !DILocation(line: 870, column: 24, scope: !725)
!728 = !DILocation(line: 872, column: 21, scope: !729)
!729 = distinct !DILexicalBlock(scope: !725, file: !36, line: 872, column: 21)
!730 = !DILocation(line: 0, scope: !729)
!731 = !DILocation(line: 872, column: 55, scope: !729)
!732 = !DILocation(line: 872, column: 21, scope: !725)
!733 = !DILocation(line: 874, column: 43, scope: !734)
!734 = distinct !DILexicalBlock(scope: !729, file: !36, line: 873, column: 17)
!735 = !DILocation(line: 874, column: 41, scope: !734)
!736 = !DILocation(line: 876, column: 25, scope: !737)
!737 = distinct !DILexicalBlock(scope: !734, file: !36, line: 876, column: 25)
!738 = !DILocation(line: 876, column: 45, scope: !737)
!739 = !DILocation(line: 876, column: 25, scope: !734)
!740 = !DILocation(line: 878, column: 60, scope: !741)
!741 = distinct !DILexicalBlock(scope: !737, file: !36, line: 877, column: 21)
!742 = !DILocation(line: 878, column: 81, scope: !741)
!743 = !DILocation(line: 878, column: 89, scope: !741)
!744 = !DILocation(line: 878, column: 25, scope: !741)
!745 = !DILocation(line: 879, column: 21, scope: !741)
!746 = !DILocation(line: 880, column: 17, scope: !734)
!747 = !DILocation(line: 882, column: 9, scope: !701)
!748 = distinct !DISubprogram(name: "MPU_pvTaskGetThreadLocalStoragePointerImpl", scope: !36, file: !36, line: 892, type: !749, scopeLine: 894, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!749 = !DISubroutineType(types: !750)
!750 = !{!26, !32, !23}
!751 = !DILocalVariable(name: "xTaskToQuery", arg: 1, scope: !748, file: !36, line: 892, type: !32)
!752 = !DILocation(line: 892, column: 73, scope: !748)
!753 = !DILocalVariable(name: "xIndex", arg: 2, scope: !748, file: !36, line: 893, type: !23)
!754 = !DILocation(line: 893, column: 71, scope: !748)
!755 = !DILocalVariable(name: "pvReturn", scope: !748, file: !36, line: 895, type: !26)
!756 = !DILocation(line: 895, column: 20, scope: !748)
!757 = !DILocalVariable(name: "lIndex", scope: !748, file: !36, line: 896, type: !27)
!758 = !DILocation(line: 896, column: 21, scope: !748)
!759 = !DILocalVariable(name: "xInternalTaskHandle", scope: !748, file: !36, line: 897, type: !32)
!760 = !DILocation(line: 897, column: 26, scope: !748)
!761 = !DILocation(line: 899, column: 17, scope: !762)
!762 = distinct !DILexicalBlock(scope: !748, file: !36, line: 899, column: 17)
!763 = !DILocation(line: 899, column: 30, scope: !762)
!764 = !DILocation(line: 899, column: 17, scope: !748)
!765 = !DILocation(line: 901, column: 64, scope: !766)
!766 = distinct !DILexicalBlock(scope: !762, file: !36, line: 900, column: 13)
!767 = !DILocation(line: 901, column: 78, scope: !766)
!768 = !DILocation(line: 901, column: 28, scope: !766)
!769 = !DILocation(line: 901, column: 26, scope: !766)
!770 = !DILocation(line: 902, column: 13, scope: !766)
!771 = !DILocation(line: 905, column: 38, scope: !772)
!772 = distinct !DILexicalBlock(scope: !762, file: !36, line: 904, column: 13)
!773 = !DILocation(line: 905, column: 26, scope: !772)
!774 = !DILocation(line: 905, column: 24, scope: !772)
!775 = !DILocation(line: 907, column: 21, scope: !776)
!776 = distinct !DILexicalBlock(scope: !772, file: !36, line: 907, column: 21)
!777 = !DILocation(line: 0, scope: !776)
!778 = !DILocation(line: 907, column: 55, scope: !776)
!779 = !DILocation(line: 907, column: 21, scope: !772)
!780 = !DILocation(line: 909, column: 43, scope: !781)
!781 = distinct !DILexicalBlock(scope: !776, file: !36, line: 908, column: 17)
!782 = !DILocation(line: 909, column: 41, scope: !781)
!783 = !DILocation(line: 911, column: 25, scope: !784)
!784 = distinct !DILexicalBlock(scope: !781, file: !36, line: 911, column: 25)
!785 = !DILocation(line: 911, column: 45, scope: !784)
!786 = !DILocation(line: 911, column: 25, scope: !781)
!787 = !DILocation(line: 913, column: 72, scope: !788)
!788 = distinct !DILexicalBlock(scope: !784, file: !36, line: 912, column: 21)
!789 = !DILocation(line: 913, column: 93, scope: !788)
!790 = !DILocation(line: 913, column: 36, scope: !788)
!791 = !DILocation(line: 913, column: 34, scope: !788)
!792 = !DILocation(line: 914, column: 21, scope: !788)
!793 = !DILocation(line: 915, column: 17, scope: !781)
!794 = !DILocation(line: 918, column: 20, scope: !748)
!795 = !DILocation(line: 918, column: 13, scope: !748)
!796 = distinct !DISubprogram(name: "MPU_uxTaskGetSystemStateImpl", scope: !36, file: !36, line: 930, type: !797, scopeLine: 933, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!797 = !DISubroutineType(types: !798)
!798 = !{!39, !280, !39, !799}
!799 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !47, size: 64)
!800 = !DILocalVariable(name: "pxTaskStatusArray", arg: 1, scope: !796, file: !36, line: 930, type: !280)
!801 = !DILocation(line: 930, column: 66, scope: !796)
!802 = !DILocalVariable(name: "uxArraySize", arg: 2, scope: !796, file: !36, line: 931, type: !39)
!803 = !DILocation(line: 931, column: 63, scope: !796)
!804 = !DILocalVariable(name: "pulTotalRunTime", arg: 3, scope: !796, file: !36, line: 932, type: !799)
!805 = !DILocation(line: 932, column: 81, scope: !796)
!806 = !DILocalVariable(name: "uxReturn", scope: !796, file: !36, line: 934, type: !39)
!807 = !DILocation(line: 934, column: 25, scope: !796)
!808 = !DILocalVariable(name: "xIsTaskStatusArrayWriteable", scope: !796, file: !36, line: 935, type: !39)
!809 = !DILocation(line: 935, column: 25, scope: !796)
!810 = !DILocalVariable(name: "xIsTotalRunTimeWriteable", scope: !796, file: !36, line: 936, type: !39)
!811 = !DILocation(line: 936, column: 25, scope: !796)
!812 = !DILocation(line: 938, column: 76, scope: !796)
!813 = !DILocation(line: 939, column: 101, scope: !796)
!814 = !DILocation(line: 939, column: 99, scope: !796)
!815 = !DILocation(line: 939, column: 76, scope: !796)
!816 = !DILocation(line: 938, column: 43, scope: !796)
!817 = !DILocation(line: 938, column: 41, scope: !796)
!818 = !DILocation(line: 942, column: 17, scope: !819)
!819 = distinct !DILexicalBlock(scope: !796, file: !36, line: 942, column: 17)
!820 = !DILocation(line: 942, column: 33, scope: !819)
!821 = !DILocation(line: 942, column: 17, scope: !796)
!822 = !DILocation(line: 944, column: 77, scope: !823)
!823 = distinct !DILexicalBlock(scope: !819, file: !36, line: 943, column: 13)
!824 = !DILocation(line: 944, column: 44, scope: !823)
!825 = !DILocation(line: 944, column: 42, scope: !823)
!826 = !DILocation(line: 947, column: 13, scope: !823)
!827 = !DILocation(line: 949, column: 19, scope: !828)
!828 = distinct !DILexicalBlock(scope: !796, file: !36, line: 949, column: 17)
!829 = !DILocation(line: 949, column: 47, scope: !828)
!830 = !DILocation(line: 949, column: 59, scope: !828)
!831 = !DILocation(line: 950, column: 21, scope: !828)
!832 = !DILocation(line: 950, column: 37, scope: !828)
!833 = !DILocation(line: 950, column: 47, scope: !828)
!834 = !DILocation(line: 950, column: 52, scope: !828)
!835 = !DILocation(line: 950, column: 77, scope: !828)
!836 = !DILocation(line: 949, column: 17, scope: !796)
!837 = !DILocation(line: 952, column: 50, scope: !838)
!838 = distinct !DILexicalBlock(scope: !828, file: !36, line: 951, column: 13)
!839 = !DILocation(line: 952, column: 69, scope: !838)
!840 = !DILocation(line: 952, column: 82, scope: !838)
!841 = !DILocation(line: 952, column: 28, scope: !838)
!842 = !DILocation(line: 952, column: 26, scope: !838)
!843 = !DILocation(line: 953, column: 13, scope: !838)
!844 = !DILocation(line: 955, column: 20, scope: !796)
!845 = !DILocation(line: 955, column: 13, scope: !796)
!846 = distinct !DISubprogram(name: "MPU_uxTaskGetStackHighWaterMarkImpl", scope: !36, file: !36, line: 965, type: !847, scopeLine: 966, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!847 = !DISubroutineType(types: !848)
!848 = !{!39, !32}
!849 = !DILocalVariable(name: "xTask", arg: 1, scope: !846, file: !36, line: 965, type: !32)
!850 = !DILocation(line: 965, column: 71, scope: !846)
!851 = !DILocalVariable(name: "uxReturn", scope: !846, file: !36, line: 967, type: !39)
!852 = !DILocation(line: 967, column: 25, scope: !846)
!853 = !DILocalVariable(name: "lIndex", scope: !846, file: !36, line: 968, type: !27)
!854 = !DILocation(line: 968, column: 21, scope: !846)
!855 = !DILocalVariable(name: "xInternalTaskHandle", scope: !846, file: !36, line: 969, type: !32)
!856 = !DILocation(line: 969, column: 26, scope: !846)
!857 = !DILocation(line: 971, column: 17, scope: !858)
!858 = distinct !DILexicalBlock(scope: !846, file: !36, line: 971, column: 17)
!859 = !DILocation(line: 971, column: 23, scope: !858)
!860 = !DILocation(line: 971, column: 17, scope: !846)
!861 = !DILocation(line: 973, column: 57, scope: !862)
!862 = distinct !DILexicalBlock(scope: !858, file: !36, line: 972, column: 13)
!863 = !DILocation(line: 973, column: 28, scope: !862)
!864 = !DILocation(line: 973, column: 26, scope: !862)
!865 = !DILocation(line: 974, column: 13, scope: !862)
!866 = !DILocation(line: 977, column: 38, scope: !867)
!867 = distinct !DILexicalBlock(scope: !858, file: !36, line: 976, column: 13)
!868 = !DILocation(line: 977, column: 26, scope: !867)
!869 = !DILocation(line: 977, column: 24, scope: !867)
!870 = !DILocation(line: 979, column: 21, scope: !871)
!871 = distinct !DILexicalBlock(scope: !867, file: !36, line: 979, column: 21)
!872 = !DILocation(line: 0, scope: !871)
!873 = !DILocation(line: 979, column: 55, scope: !871)
!874 = !DILocation(line: 979, column: 21, scope: !867)
!875 = !DILocation(line: 981, column: 43, scope: !876)
!876 = distinct !DILexicalBlock(scope: !871, file: !36, line: 980, column: 17)
!877 = !DILocation(line: 981, column: 41, scope: !876)
!878 = !DILocation(line: 983, column: 25, scope: !879)
!879 = distinct !DILexicalBlock(scope: !876, file: !36, line: 983, column: 25)
!880 = !DILocation(line: 983, column: 45, scope: !879)
!881 = !DILocation(line: 983, column: 25, scope: !876)
!882 = !DILocation(line: 985, column: 65, scope: !883)
!883 = distinct !DILexicalBlock(scope: !879, file: !36, line: 984, column: 21)
!884 = !DILocation(line: 985, column: 36, scope: !883)
!885 = !DILocation(line: 985, column: 34, scope: !883)
!886 = !DILocation(line: 986, column: 21, scope: !883)
!887 = !DILocation(line: 987, column: 17, scope: !876)
!888 = !DILocation(line: 990, column: 20, scope: !846)
!889 = !DILocation(line: 990, column: 13, scope: !846)
!890 = distinct !DISubprogram(name: "MPU_uxTaskGetStackHighWaterMark2Impl", scope: !36, file: !36, line: 1000, type: !891, scopeLine: 1001, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!891 = !DISubroutineType(types: !892)
!892 = !{!298, !32}
!893 = !DILocalVariable(name: "xTask", arg: 1, scope: !890, file: !36, line: 1000, type: !32)
!894 = !DILocation(line: 1000, column: 83, scope: !890)
!895 = !DILocalVariable(name: "uxReturn", scope: !890, file: !36, line: 1002, type: !298)
!896 = !DILocation(line: 1002, column: 36, scope: !890)
!897 = !DILocalVariable(name: "lIndex", scope: !890, file: !36, line: 1003, type: !27)
!898 = !DILocation(line: 1003, column: 21, scope: !890)
!899 = !DILocalVariable(name: "xInternalTaskHandle", scope: !890, file: !36, line: 1004, type: !32)
!900 = !DILocation(line: 1004, column: 26, scope: !890)
!901 = !DILocation(line: 1006, column: 17, scope: !902)
!902 = distinct !DILexicalBlock(scope: !890, file: !36, line: 1006, column: 17)
!903 = !DILocation(line: 1006, column: 23, scope: !902)
!904 = !DILocation(line: 1006, column: 17, scope: !890)
!905 = !DILocation(line: 1008, column: 58, scope: !906)
!906 = distinct !DILexicalBlock(scope: !902, file: !36, line: 1007, column: 13)
!907 = !DILocation(line: 1008, column: 28, scope: !906)
!908 = !DILocation(line: 1008, column: 26, scope: !906)
!909 = !DILocation(line: 1009, column: 13, scope: !906)
!910 = !DILocation(line: 1012, column: 38, scope: !911)
!911 = distinct !DILexicalBlock(scope: !902, file: !36, line: 1011, column: 13)
!912 = !DILocation(line: 1012, column: 26, scope: !911)
!913 = !DILocation(line: 1012, column: 24, scope: !911)
!914 = !DILocation(line: 1014, column: 21, scope: !915)
!915 = distinct !DILexicalBlock(scope: !911, file: !36, line: 1014, column: 21)
!916 = !DILocation(line: 0, scope: !915)
!917 = !DILocation(line: 1014, column: 55, scope: !915)
!918 = !DILocation(line: 1014, column: 21, scope: !911)
!919 = !DILocation(line: 1016, column: 43, scope: !920)
!920 = distinct !DILexicalBlock(scope: !915, file: !36, line: 1015, column: 17)
!921 = !DILocation(line: 1016, column: 41, scope: !920)
!922 = !DILocation(line: 1018, column: 25, scope: !923)
!923 = distinct !DILexicalBlock(scope: !920, file: !36, line: 1018, column: 25)
!924 = !DILocation(line: 1018, column: 45, scope: !923)
!925 = !DILocation(line: 1018, column: 25, scope: !920)
!926 = !DILocation(line: 1020, column: 66, scope: !927)
!927 = distinct !DILexicalBlock(scope: !923, file: !36, line: 1019, column: 21)
!928 = !DILocation(line: 1020, column: 36, scope: !927)
!929 = !DILocation(line: 1020, column: 34, scope: !927)
!930 = !DILocation(line: 1021, column: 21, scope: !927)
!931 = !DILocation(line: 1022, column: 17, scope: !920)
!932 = !DILocation(line: 1025, column: 20, scope: !890)
!933 = !DILocation(line: 1025, column: 13, scope: !890)
!934 = distinct !DISubprogram(name: "MPU_xTaskGetCurrentTaskHandleImpl", scope: !36, file: !36, line: 1035, type: !361, scopeLine: 1036, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!935 = !DILocalVariable(name: "xInternalTaskHandle", scope: !934, file: !36, line: 1037, type: !32)
!936 = !DILocation(line: 1037, column: 26, scope: !934)
!937 = !DILocalVariable(name: "xExternalTaskHandle", scope: !934, file: !36, line: 1038, type: !32)
!938 = !DILocation(line: 1038, column: 26, scope: !934)
!939 = !DILocalVariable(name: "lIndex", scope: !934, file: !36, line: 1039, type: !27)
!940 = !DILocation(line: 1039, column: 21, scope: !934)
!941 = !DILocation(line: 1041, column: 35, scope: !934)
!942 = !DILocation(line: 1041, column: 33, scope: !934)
!943 = !DILocation(line: 1043, column: 17, scope: !944)
!944 = distinct !DILexicalBlock(scope: !934, file: !36, line: 1043, column: 17)
!945 = !DILocation(line: 1043, column: 37, scope: !944)
!946 = !DILocation(line: 1043, column: 17, scope: !934)
!947 = !DILocation(line: 1045, column: 26, scope: !948)
!948 = distinct !DILexicalBlock(scope: !944, file: !36, line: 1044, column: 13)
!949 = !DILocation(line: 1045, column: 24, scope: !948)
!950 = !DILocation(line: 1047, column: 21, scope: !951)
!951 = distinct !DILexicalBlock(scope: !948, file: !36, line: 1047, column: 21)
!952 = !DILocation(line: 1047, column: 28, scope: !951)
!953 = !DILocation(line: 1047, column: 21, scope: !948)
!954 = !DILocation(line: 1049, column: 60, scope: !955)
!955 = distinct !DILexicalBlock(scope: !951, file: !36, line: 1048, column: 17)
!956 = !DILocation(line: 1049, column: 43, scope: !955)
!957 = !DILocation(line: 1049, column: 41, scope: !955)
!958 = !DILocation(line: 1050, column: 17, scope: !955)
!959 = !DILocation(line: 1051, column: 13, scope: !948)
!960 = !DILocation(line: 1053, column: 20, scope: !934)
!961 = !DILocation(line: 1053, column: 13, scope: !934)
!962 = distinct !DISubprogram(name: "MPU_GetIndexForHandle", scope: !36, file: !36, line: 281, type: !963, scopeLine: 283, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !80)
!963 = !DISubroutineType(types: !964)
!964 = !{!27, !35, !47}
!965 = !DILocalVariable(name: "xHandle", arg: 1, scope: !962, file: !36, line: 281, type: !35)
!966 = !DILocation(line: 281, column: 64, scope: !962)
!967 = !DILocalVariable(name: "ulKernelObjectType", arg: 2, scope: !962, file: !36, line: 282, type: !47)
!968 = !DILocation(line: 282, column: 52, scope: !962)
!969 = !DILocalVariable(name: "i", scope: !962, file: !36, line: 284, type: !27)
!970 = !DILocation(line: 284, column: 17, scope: !962)
!971 = !DILocalVariable(name: "lIndex", scope: !962, file: !36, line: 284, type: !27)
!972 = !DILocation(line: 284, column: 20, scope: !962)
!973 = !DILocation(line: 286, column: 9, scope: !974)
!974 = distinct !DILexicalBlock(scope: !962, file: !36, line: 286, column: 9)
!975 = !DILocation(line: 286, column: 9, scope: !962)
!976 = !DILocation(line: 288, column: 16, scope: !977)
!977 = distinct !DILexicalBlock(scope: !962, file: !36, line: 288, column: 9)
!978 = !DILocation(line: 288, column: 14, scope: !977)
!979 = !DILocation(line: 288, column: 21, scope: !980)
!980 = distinct !DILexicalBlock(scope: !977, file: !36, line: 288, column: 9)
!981 = !DILocation(line: 288, column: 23, scope: !980)
!982 = !DILocation(line: 288, column: 9, scope: !977)
!983 = !DILocation(line: 290, column: 38, scope: !984)
!984 = distinct !DILexicalBlock(scope: !985, file: !36, line: 290, column: 17)
!985 = distinct !DILexicalBlock(scope: !980, file: !36, line: 289, column: 9)
!986 = !DILocation(line: 290, column: 19, scope: !984)
!987 = !DILocation(line: 290, column: 42, scope: !984)
!988 = !DILocation(line: 290, column: 67, scope: !984)
!989 = !DILocation(line: 290, column: 64, scope: !984)
!990 = !DILocation(line: 290, column: 77, scope: !984)
!991 = !DILocation(line: 291, column: 38, scope: !984)
!992 = !DILocation(line: 291, column: 19, scope: !984)
!993 = !DILocation(line: 291, column: 42, scope: !984)
!994 = !DILocation(line: 291, column: 64, scope: !984)
!995 = !DILocation(line: 291, column: 61, scope: !984)
!996 = !DILocation(line: 290, column: 17, scope: !985)
!997 = !DILocation(line: 293, column: 26, scope: !998)
!998 = distinct !DILexicalBlock(scope: !984, file: !36, line: 292, column: 13)
!999 = !DILocation(line: 293, column: 24, scope: !998)
!1000 = !DILocation(line: 294, column: 17, scope: !998)
!1001 = !DILocation(line: 296, column: 9, scope: !985)
!1002 = !DILocation(line: 288, column: 67, scope: !980)
!1003 = !DILocation(line: 288, column: 9, scope: !980)
!1004 = distinct !{!1004, !982, !1005}
!1005 = !DILocation(line: 296, column: 9, scope: !977)
!1006 = !DILocation(line: 298, column: 16, scope: !962)
!1007 = !DILocation(line: 298, column: 9, scope: !962)
!1008 = distinct !DISubprogram(name: "MPU_xTaskGetSchedulerStateImpl", scope: !36, file: !36, line: 1063, type: !1009, scopeLine: 1064, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!1009 = !DISubroutineType(types: !1010)
!1010 = !{!23}
!1011 = !DILocalVariable(name: "xReturn", scope: !1008, file: !36, line: 1065, type: !23)
!1012 = !DILocation(line: 1065, column: 24, scope: !1008)
!1013 = !DILocation(line: 1067, column: 23, scope: !1008)
!1014 = !DILocation(line: 1067, column: 21, scope: !1008)
!1015 = !DILocation(line: 1069, column: 20, scope: !1008)
!1016 = !DILocation(line: 1069, column: 13, scope: !1008)
!1017 = distinct !DISubprogram(name: "MPU_vTaskSetTimeOutStateImpl", scope: !36, file: !36, line: 1077, type: !1018, scopeLine: 1078, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!1018 = !DISubroutineType(types: !1019)
!1019 = !{null, !1020}
!1020 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1021)
!1021 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1022, size: 64)
!1022 = !DIDerivedType(tag: DW_TAG_typedef, name: "TimeOut_t", file: !6, line: 128, baseType: !1023)
!1023 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xTIME_OUT", file: !6, line: 124, size: 128, elements: !1024)
!1024 = !{!1025, !1026}
!1025 = !DIDerivedType(tag: DW_TAG_member, name: "xOverflowCount", scope: !1023, file: !6, line: 126, baseType: !23, size: 64)
!1026 = !DIDerivedType(tag: DW_TAG_member, name: "xTimeOnEntering", scope: !1023, file: !6, line: 127, baseType: !93, size: 64, offset: 64)
!1027 = !DILocalVariable(name: "pxTimeOut", arg: 1, scope: !1017, file: !36, line: 1077, type: !1020)
!1028 = !DILocation(line: 1077, column: 58, scope: !1017)
!1029 = !DILocalVariable(name: "xIsTimeOutWriteable", scope: !1017, file: !36, line: 1079, type: !23)
!1030 = !DILocation(line: 1079, column: 20, scope: !1017)
!1031 = !DILocation(line: 1081, column: 64, scope: !1017)
!1032 = !DILocation(line: 1081, column: 31, scope: !1017)
!1033 = !DILocation(line: 1081, column: 29, scope: !1017)
!1034 = !DILocation(line: 1085, column: 13, scope: !1035)
!1035 = distinct !DILexicalBlock(scope: !1017, file: !36, line: 1085, column: 13)
!1036 = !DILocation(line: 1085, column: 33, scope: !1035)
!1037 = !DILocation(line: 1085, column: 13, scope: !1017)
!1038 = !DILocation(line: 1087, column: 35, scope: !1039)
!1039 = distinct !DILexicalBlock(scope: !1035, file: !36, line: 1086, column: 9)
!1040 = !DILocation(line: 1087, column: 13, scope: !1039)
!1041 = !DILocation(line: 1088, column: 9, scope: !1039)
!1042 = !DILocation(line: 1089, column: 5, scope: !1017)
!1043 = distinct !DISubprogram(name: "MPU_xTaskCheckForTimeOutImpl", scope: !36, file: !36, line: 1095, type: !1044, scopeLine: 1097, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!1044 = !DISubroutineType(types: !1045)
!1045 = !{!23, !1020, !91}
!1046 = !DILocalVariable(name: "pxTimeOut", arg: 1, scope: !1043, file: !36, line: 1095, type: !1020)
!1047 = !DILocation(line: 1095, column: 64, scope: !1043)
!1048 = !DILocalVariable(name: "pxTicksToWait", arg: 2, scope: !1043, file: !36, line: 1096, type: !91)
!1049 = !DILocation(line: 1096, column: 65, scope: !1043)
!1050 = !DILocalVariable(name: "xReturn", scope: !1043, file: !36, line: 1098, type: !23)
!1051 = !DILocation(line: 1098, column: 20, scope: !1043)
!1052 = !DILocalVariable(name: "xIsTimeOutWriteable", scope: !1043, file: !36, line: 1099, type: !23)
!1053 = !DILocation(line: 1099, column: 20, scope: !1043)
!1054 = !DILocalVariable(name: "xIsTicksToWaitWriteable", scope: !1043, file: !36, line: 1100, type: !23)
!1055 = !DILocation(line: 1100, column: 20, scope: !1043)
!1056 = !DILocation(line: 1102, column: 64, scope: !1043)
!1057 = !DILocation(line: 1102, column: 31, scope: !1043)
!1058 = !DILocation(line: 1102, column: 29, scope: !1043)
!1059 = !DILocation(line: 1105, column: 68, scope: !1043)
!1060 = !DILocation(line: 1105, column: 35, scope: !1043)
!1061 = !DILocation(line: 1105, column: 33, scope: !1043)
!1062 = !DILocation(line: 1109, column: 15, scope: !1063)
!1063 = distinct !DILexicalBlock(scope: !1043, file: !36, line: 1109, column: 13)
!1064 = !DILocation(line: 1109, column: 35, scope: !1063)
!1065 = !DILocation(line: 1109, column: 47, scope: !1063)
!1066 = !DILocation(line: 1109, column: 52, scope: !1063)
!1067 = !DILocation(line: 1109, column: 76, scope: !1063)
!1068 = !DILocation(line: 1109, column: 13, scope: !1043)
!1069 = !DILocation(line: 1111, column: 45, scope: !1070)
!1070 = distinct !DILexicalBlock(scope: !1063, file: !36, line: 1110, column: 9)
!1071 = !DILocation(line: 1111, column: 56, scope: !1070)
!1072 = !DILocation(line: 1111, column: 23, scope: !1070)
!1073 = !DILocation(line: 1111, column: 21, scope: !1070)
!1074 = !DILocation(line: 1112, column: 9, scope: !1070)
!1075 = !DILocation(line: 1114, column: 16, scope: !1043)
!1076 = !DILocation(line: 1114, column: 9, scope: !1043)
!1077 = distinct !DISubprogram(name: "MPU_xTaskGenericNotifyImpl", scope: !36, file: !36, line: 1126, type: !1078, scopeLine: 1131, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!1078 = !DISubroutineType(types: !1079)
!1079 = !{!23, !32, !39, !47, !1080, !799}
!1080 = !DIDerivedType(tag: DW_TAG_typedef, name: "eNotifyAction", file: !6, line: 119, baseType: !15)
!1081 = !DILocalVariable(name: "xTaskToNotify", arg: 1, scope: !1077, file: !36, line: 1126, type: !32)
!1082 = !DILocation(line: 1126, column: 61, scope: !1077)
!1083 = !DILocalVariable(name: "uxIndexToNotify", arg: 2, scope: !1077, file: !36, line: 1127, type: !39)
!1084 = !DILocation(line: 1127, column: 60, scope: !1077)
!1085 = !DILocalVariable(name: "ulValue", arg: 3, scope: !1077, file: !36, line: 1128, type: !47)
!1086 = !DILocation(line: 1128, column: 57, scope: !1077)
!1087 = !DILocalVariable(name: "eAction", arg: 4, scope: !1077, file: !36, line: 1129, type: !1080)
!1088 = !DILocation(line: 1129, column: 62, scope: !1077)
!1089 = !DILocalVariable(name: "pulPreviousNotificationValue", arg: 5, scope: !1077, file: !36, line: 1130, type: !799)
!1090 = !DILocation(line: 1130, column: 59, scope: !1077)
!1091 = !DILocalVariable(name: "xReturn", scope: !1077, file: !36, line: 1132, type: !23)
!1092 = !DILocation(line: 1132, column: 24, scope: !1077)
!1093 = !DILocalVariable(name: "lIndex", scope: !1077, file: !36, line: 1133, type: !27)
!1094 = !DILocation(line: 1133, column: 21, scope: !1077)
!1095 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1077, file: !36, line: 1134, type: !32)
!1096 = !DILocation(line: 1134, column: 26, scope: !1077)
!1097 = !DILocalVariable(name: "xIsPreviousNotificationValueWriteable", scope: !1077, file: !36, line: 1135, type: !23)
!1098 = !DILocation(line: 1135, column: 24, scope: !1077)
!1099 = !DILocation(line: 1137, column: 17, scope: !1100)
!1100 = distinct !DILexicalBlock(scope: !1077, file: !36, line: 1137, column: 17)
!1101 = !DILocation(line: 1137, column: 46, scope: !1100)
!1102 = !DILocation(line: 1137, column: 17, scope: !1077)
!1103 = !DILocation(line: 1139, column: 90, scope: !1104)
!1104 = distinct !DILexicalBlock(scope: !1100, file: !36, line: 1138, column: 13)
!1105 = !DILocation(line: 1139, column: 57, scope: !1104)
!1106 = !DILocation(line: 1139, column: 55, scope: !1104)
!1107 = !DILocation(line: 1142, column: 13, scope: !1104)
!1108 = !DILocation(line: 1144, column: 19, scope: !1109)
!1109 = distinct !DILexicalBlock(scope: !1077, file: !36, line: 1144, column: 17)
!1110 = !DILocation(line: 1144, column: 48, scope: !1109)
!1111 = !DILocation(line: 1144, column: 58, scope: !1109)
!1112 = !DILocation(line: 1144, column: 63, scope: !1109)
!1113 = !DILocation(line: 1144, column: 101, scope: !1109)
!1114 = !DILocation(line: 1144, column: 17, scope: !1077)
!1115 = !DILocation(line: 1146, column: 38, scope: !1116)
!1116 = distinct !DILexicalBlock(scope: !1109, file: !36, line: 1145, column: 13)
!1117 = !DILocation(line: 1146, column: 26, scope: !1116)
!1118 = !DILocation(line: 1146, column: 24, scope: !1116)
!1119 = !DILocation(line: 1148, column: 21, scope: !1120)
!1120 = distinct !DILexicalBlock(scope: !1116, file: !36, line: 1148, column: 21)
!1121 = !DILocation(line: 0, scope: !1120)
!1122 = !DILocation(line: 1148, column: 55, scope: !1120)
!1123 = !DILocation(line: 1148, column: 21, scope: !1116)
!1124 = !DILocation(line: 1150, column: 43, scope: !1125)
!1125 = distinct !DILexicalBlock(scope: !1120, file: !36, line: 1149, column: 17)
!1126 = !DILocation(line: 1150, column: 41, scope: !1125)
!1127 = !DILocation(line: 1152, column: 25, scope: !1128)
!1128 = distinct !DILexicalBlock(scope: !1125, file: !36, line: 1152, column: 25)
!1129 = !DILocation(line: 1152, column: 45, scope: !1128)
!1130 = !DILocation(line: 1152, column: 25, scope: !1125)
!1131 = !DILocation(line: 1154, column: 55, scope: !1132)
!1132 = distinct !DILexicalBlock(scope: !1128, file: !36, line: 1153, column: 21)
!1133 = !DILocation(line: 1154, column: 76, scope: !1132)
!1134 = !DILocation(line: 1154, column: 93, scope: !1132)
!1135 = !DILocation(line: 1154, column: 102, scope: !1132)
!1136 = !DILocation(line: 1154, column: 111, scope: !1132)
!1137 = !DILocation(line: 1154, column: 35, scope: !1132)
!1138 = !DILocation(line: 1154, column: 33, scope: !1132)
!1139 = !DILocation(line: 1155, column: 21, scope: !1132)
!1140 = !DILocation(line: 1156, column: 17, scope: !1125)
!1141 = !DILocation(line: 1157, column: 13, scope: !1116)
!1142 = !DILocation(line: 1159, column: 20, scope: !1077)
!1143 = !DILocation(line: 1159, column: 13, scope: !1077)
!1144 = distinct !DISubprogram(name: "MPU_xTaskGenericNotifyWaitImpl", scope: !36, file: !36, line: 1173, type: !1145, scopeLine: 1178, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!1145 = !DISubroutineType(types: !1146)
!1146 = !{!23, !39, !47, !47, !799, !93}
!1147 = !DILocalVariable(name: "uxIndexToWaitOn", arg: 1, scope: !1144, file: !36, line: 1173, type: !39)
!1148 = !DILocation(line: 1173, column: 64, scope: !1144)
!1149 = !DILocalVariable(name: "ulBitsToClearOnEntry", arg: 2, scope: !1144, file: !36, line: 1174, type: !47)
!1150 = !DILocation(line: 1174, column: 61, scope: !1144)
!1151 = !DILocalVariable(name: "ulBitsToClearOnExit", arg: 3, scope: !1144, file: !36, line: 1175, type: !47)
!1152 = !DILocation(line: 1175, column: 61, scope: !1144)
!1153 = !DILocalVariable(name: "pulNotificationValue", arg: 4, scope: !1144, file: !36, line: 1176, type: !799)
!1154 = !DILocation(line: 1176, column: 63, scope: !1144)
!1155 = !DILocalVariable(name: "xTicksToWait", arg: 5, scope: !1144, file: !36, line: 1177, type: !93)
!1156 = !DILocation(line: 1177, column: 63, scope: !1144)
!1157 = !DILocalVariable(name: "xReturn", scope: !1144, file: !36, line: 1179, type: !23)
!1158 = !DILocation(line: 1179, column: 24, scope: !1144)
!1159 = !DILocalVariable(name: "xIsNotificationValueWritable", scope: !1144, file: !36, line: 1180, type: !23)
!1160 = !DILocation(line: 1180, column: 24, scope: !1144)
!1161 = !DILocation(line: 1182, column: 17, scope: !1162)
!1162 = distinct !DILexicalBlock(scope: !1144, file: !36, line: 1182, column: 17)
!1163 = !DILocation(line: 1182, column: 38, scope: !1162)
!1164 = !DILocation(line: 1182, column: 17, scope: !1144)
!1165 = !DILocation(line: 1184, column: 81, scope: !1166)
!1166 = distinct !DILexicalBlock(scope: !1162, file: !36, line: 1183, column: 13)
!1167 = !DILocation(line: 1184, column: 48, scope: !1166)
!1168 = !DILocation(line: 1184, column: 46, scope: !1166)
!1169 = !DILocation(line: 1187, column: 13, scope: !1166)
!1170 = !DILocation(line: 1189, column: 19, scope: !1171)
!1171 = distinct !DILexicalBlock(scope: !1144, file: !36, line: 1189, column: 17)
!1172 = !DILocation(line: 1189, column: 40, scope: !1171)
!1173 = !DILocation(line: 1189, column: 50, scope: !1171)
!1174 = !DILocation(line: 1189, column: 55, scope: !1171)
!1175 = !DILocation(line: 1189, column: 84, scope: !1171)
!1176 = !DILocation(line: 1189, column: 17, scope: !1144)
!1177 = !DILocation(line: 1191, column: 51, scope: !1178)
!1178 = distinct !DILexicalBlock(scope: !1171, file: !36, line: 1190, column: 13)
!1179 = !DILocation(line: 1191, column: 68, scope: !1178)
!1180 = !DILocation(line: 1191, column: 90, scope: !1178)
!1181 = !DILocation(line: 1191, column: 111, scope: !1178)
!1182 = !DILocation(line: 1191, column: 133, scope: !1178)
!1183 = !DILocation(line: 1191, column: 27, scope: !1178)
!1184 = !DILocation(line: 1191, column: 25, scope: !1178)
!1185 = !DILocation(line: 1192, column: 13, scope: !1178)
!1186 = !DILocation(line: 1194, column: 20, scope: !1144)
!1187 = !DILocation(line: 1194, column: 13, scope: !1144)
!1188 = distinct !DISubprogram(name: "MPU_ulTaskGenericNotifyTakeImpl", scope: !36, file: !36, line: 1206, type: !1189, scopeLine: 1209, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!1189 = !DISubroutineType(types: !1190)
!1190 = !{!47, !39, !23, !93}
!1191 = !DILocalVariable(name: "uxIndexToWaitOn", arg: 1, scope: !1188, file: !36, line: 1206, type: !39)
!1192 = !DILocation(line: 1206, column: 63, scope: !1188)
!1193 = !DILocalVariable(name: "xClearCountOnExit", arg: 2, scope: !1188, file: !36, line: 1207, type: !23)
!1194 = !DILocation(line: 1207, column: 62, scope: !1188)
!1195 = !DILocalVariable(name: "xTicksToWait", arg: 3, scope: !1188, file: !36, line: 1208, type: !93)
!1196 = !DILocation(line: 1208, column: 62, scope: !1188)
!1197 = !DILocalVariable(name: "ulReturn", scope: !1188, file: !36, line: 1210, type: !47)
!1198 = !DILocation(line: 1210, column: 22, scope: !1188)
!1199 = !DILocation(line: 1212, column: 49, scope: !1188)
!1200 = !DILocation(line: 1212, column: 66, scope: !1188)
!1201 = !DILocation(line: 1212, column: 85, scope: !1188)
!1202 = !DILocation(line: 1212, column: 24, scope: !1188)
!1203 = !DILocation(line: 1212, column: 22, scope: !1188)
!1204 = !DILocation(line: 1214, column: 20, scope: !1188)
!1205 = !DILocation(line: 1214, column: 13, scope: !1188)
!1206 = distinct !DISubprogram(name: "MPU_xTaskGenericNotifyStateClearImpl", scope: !36, file: !36, line: 1225, type: !1207, scopeLine: 1227, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!1207 = !DISubroutineType(types: !1208)
!1208 = !{!23, !32, !39}
!1209 = !DILocalVariable(name: "xTask", arg: 1, scope: !1206, file: !36, line: 1225, type: !32)
!1210 = !DILocation(line: 1225, column: 71, scope: !1206)
!1211 = !DILocalVariable(name: "uxIndexToClear", arg: 2, scope: !1206, file: !36, line: 1226, type: !39)
!1212 = !DILocation(line: 1226, column: 70, scope: !1206)
!1213 = !DILocalVariable(name: "xReturn", scope: !1206, file: !36, line: 1228, type: !23)
!1214 = !DILocation(line: 1228, column: 24, scope: !1206)
!1215 = !DILocalVariable(name: "lIndex", scope: !1206, file: !36, line: 1229, type: !27)
!1216 = !DILocation(line: 1229, column: 21, scope: !1206)
!1217 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1206, file: !36, line: 1230, type: !32)
!1218 = !DILocation(line: 1230, column: 26, scope: !1206)
!1219 = !DILocation(line: 1232, column: 17, scope: !1220)
!1220 = distinct !DILexicalBlock(scope: !1206, file: !36, line: 1232, column: 17)
!1221 = !DILocation(line: 1232, column: 23, scope: !1220)
!1222 = !DILocation(line: 1232, column: 17, scope: !1206)
!1223 = !DILocation(line: 1234, column: 57, scope: !1224)
!1224 = distinct !DILexicalBlock(scope: !1220, file: !36, line: 1233, column: 13)
!1225 = !DILocation(line: 1234, column: 64, scope: !1224)
!1226 = !DILocation(line: 1234, column: 27, scope: !1224)
!1227 = !DILocation(line: 1234, column: 25, scope: !1224)
!1228 = !DILocation(line: 1235, column: 13, scope: !1224)
!1229 = !DILocation(line: 1238, column: 38, scope: !1230)
!1230 = distinct !DILexicalBlock(scope: !1220, file: !36, line: 1237, column: 13)
!1231 = !DILocation(line: 1238, column: 26, scope: !1230)
!1232 = !DILocation(line: 1238, column: 24, scope: !1230)
!1233 = !DILocation(line: 1240, column: 21, scope: !1234)
!1234 = distinct !DILexicalBlock(scope: !1230, file: !36, line: 1240, column: 21)
!1235 = !DILocation(line: 0, scope: !1234)
!1236 = !DILocation(line: 1240, column: 55, scope: !1234)
!1237 = !DILocation(line: 1240, column: 21, scope: !1230)
!1238 = !DILocation(line: 1242, column: 43, scope: !1239)
!1239 = distinct !DILexicalBlock(scope: !1234, file: !36, line: 1241, column: 17)
!1240 = !DILocation(line: 1242, column: 41, scope: !1239)
!1241 = !DILocation(line: 1244, column: 25, scope: !1242)
!1242 = distinct !DILexicalBlock(scope: !1239, file: !36, line: 1244, column: 25)
!1243 = !DILocation(line: 1244, column: 45, scope: !1242)
!1244 = !DILocation(line: 1244, column: 25, scope: !1239)
!1245 = !DILocation(line: 1246, column: 65, scope: !1246)
!1246 = distinct !DILexicalBlock(scope: !1242, file: !36, line: 1245, column: 21)
!1247 = !DILocation(line: 1246, column: 86, scope: !1246)
!1248 = !DILocation(line: 1246, column: 35, scope: !1246)
!1249 = !DILocation(line: 1246, column: 33, scope: !1246)
!1250 = !DILocation(line: 1247, column: 21, scope: !1246)
!1251 = !DILocation(line: 1248, column: 17, scope: !1239)
!1252 = !DILocation(line: 1251, column: 20, scope: !1206)
!1253 = !DILocation(line: 1251, column: 13, scope: !1206)
!1254 = distinct !DISubprogram(name: "MPU_ulTaskGenericNotifyValueClearImpl", scope: !36, file: !36, line: 1263, type: !1255, scopeLine: 1266, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!1255 = !DISubroutineType(types: !1256)
!1256 = !{!47, !32, !39, !47}
!1257 = !DILocalVariable(name: "xTask", arg: 1, scope: !1254, file: !36, line: 1263, type: !32)
!1258 = !DILocation(line: 1263, column: 70, scope: !1254)
!1259 = !DILocalVariable(name: "uxIndexToClear", arg: 2, scope: !1254, file: !36, line: 1264, type: !39)
!1260 = !DILocation(line: 1264, column: 69, scope: !1254)
!1261 = !DILocalVariable(name: "ulBitsToClear", arg: 3, scope: !1254, file: !36, line: 1265, type: !47)
!1262 = !DILocation(line: 1265, column: 66, scope: !1254)
!1263 = !DILocalVariable(name: "ulReturn", scope: !1254, file: !36, line: 1267, type: !47)
!1264 = !DILocation(line: 1267, column: 22, scope: !1254)
!1265 = !DILocalVariable(name: "lIndex", scope: !1254, file: !36, line: 1268, type: !27)
!1266 = !DILocation(line: 1268, column: 21, scope: !1254)
!1267 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1254, file: !36, line: 1269, type: !32)
!1268 = !DILocation(line: 1269, column: 26, scope: !1254)
!1269 = !DILocation(line: 1271, column: 17, scope: !1270)
!1270 = distinct !DILexicalBlock(scope: !1254, file: !36, line: 1271, column: 17)
!1271 = !DILocation(line: 1271, column: 23, scope: !1270)
!1272 = !DILocation(line: 1271, column: 17, scope: !1254)
!1273 = !DILocation(line: 1273, column: 59, scope: !1274)
!1274 = distinct !DILexicalBlock(scope: !1270, file: !36, line: 1272, column: 13)
!1275 = !DILocation(line: 1273, column: 66, scope: !1274)
!1276 = !DILocation(line: 1273, column: 82, scope: !1274)
!1277 = !DILocation(line: 1273, column: 28, scope: !1274)
!1278 = !DILocation(line: 1273, column: 26, scope: !1274)
!1279 = !DILocation(line: 1274, column: 13, scope: !1274)
!1280 = !DILocation(line: 1277, column: 38, scope: !1281)
!1281 = distinct !DILexicalBlock(scope: !1270, file: !36, line: 1276, column: 13)
!1282 = !DILocation(line: 1277, column: 26, scope: !1281)
!1283 = !DILocation(line: 1277, column: 24, scope: !1281)
!1284 = !DILocation(line: 1279, column: 21, scope: !1285)
!1285 = distinct !DILexicalBlock(scope: !1281, file: !36, line: 1279, column: 21)
!1286 = !DILocation(line: 0, scope: !1285)
!1287 = !DILocation(line: 1279, column: 55, scope: !1285)
!1288 = !DILocation(line: 1279, column: 21, scope: !1281)
!1289 = !DILocation(line: 1281, column: 43, scope: !1290)
!1290 = distinct !DILexicalBlock(scope: !1285, file: !36, line: 1280, column: 17)
!1291 = !DILocation(line: 1281, column: 41, scope: !1290)
!1292 = !DILocation(line: 1283, column: 25, scope: !1293)
!1293 = distinct !DILexicalBlock(scope: !1290, file: !36, line: 1283, column: 25)
!1294 = !DILocation(line: 1283, column: 45, scope: !1293)
!1295 = !DILocation(line: 1283, column: 25, scope: !1290)
!1296 = !DILocation(line: 1285, column: 67, scope: !1297)
!1297 = distinct !DILexicalBlock(scope: !1293, file: !36, line: 1284, column: 21)
!1298 = !DILocation(line: 1285, column: 88, scope: !1297)
!1299 = !DILocation(line: 1285, column: 104, scope: !1297)
!1300 = !DILocation(line: 1285, column: 36, scope: !1297)
!1301 = !DILocation(line: 1285, column: 34, scope: !1297)
!1302 = !DILocation(line: 1286, column: 21, scope: !1297)
!1303 = !DILocation(line: 1287, column: 17, scope: !1290)
!1304 = !DILocation(line: 1290, column: 20, scope: !1254)
!1305 = !DILocation(line: 1290, column: 13, scope: !1254)
!1306 = distinct !DISubprogram(name: "MPU_xTaskCreate", scope: !36, file: !36, line: 1303, type: !1307, scopeLine: 1309, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!1307 = !DISubroutineType(types: !1308)
!1308 = !{!23, !1309, !1314, !298, !26, !39, !1315}
!1309 = !DIDerivedType(tag: DW_TAG_typedef, name: "TaskFunction_t", file: !1310, line: 36, baseType: !1311)
!1310 = !DIFile(filename: "include/projdefs.h", directory: "/home/klee/FreeRTOS-Kernel-10.6.0")
!1311 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1312, size: 64)
!1312 = !DISubroutineType(types: !1313)
!1313 = !{null, !26}
!1314 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !286)
!1315 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !32, size: 64)
!1316 = !DILocalVariable(name: "pvTaskCode", arg: 1, scope: !1306, file: !36, line: 1303, type: !1309)
!1317 = !DILocation(line: 1303, column: 52, scope: !1306)
!1318 = !DILocalVariable(name: "pcName", arg: 2, scope: !1306, file: !36, line: 1304, type: !1314)
!1319 = !DILocation(line: 1304, column: 56, scope: !1306)
!1320 = !DILocalVariable(name: "usStackDepth", arg: 3, scope: !1306, file: !36, line: 1305, type: !298)
!1321 = !DILocation(line: 1305, column: 46, scope: !1306)
!1322 = !DILocalVariable(name: "pvParameters", arg: 4, scope: !1306, file: !36, line: 1306, type: !26)
!1323 = !DILocation(line: 1306, column: 44, scope: !1306)
!1324 = !DILocalVariable(name: "uxPriority", arg: 5, scope: !1306, file: !36, line: 1307, type: !39)
!1325 = !DILocation(line: 1307, column: 49, scope: !1306)
!1326 = !DILocalVariable(name: "pxCreatedTask", arg: 6, scope: !1306, file: !36, line: 1308, type: !1315)
!1327 = !DILocation(line: 1308, column: 52, scope: !1306)
!1328 = !DILocalVariable(name: "xReturn", scope: !1306, file: !36, line: 1310, type: !23)
!1329 = !DILocation(line: 1310, column: 24, scope: !1306)
!1330 = !DILocalVariable(name: "lIndex", scope: !1306, file: !36, line: 1311, type: !27)
!1331 = !DILocation(line: 1311, column: 21, scope: !1306)
!1332 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1306, file: !36, line: 1312, type: !32)
!1333 = !DILocation(line: 1312, column: 26, scope: !1306)
!1334 = !DILocation(line: 1314, column: 22, scope: !1306)
!1335 = !DILocation(line: 1314, column: 20, scope: !1306)
!1336 = !DILocation(line: 1316, column: 17, scope: !1337)
!1337 = distinct !DILexicalBlock(scope: !1306, file: !36, line: 1316, column: 17)
!1338 = !DILocation(line: 1316, column: 24, scope: !1337)
!1339 = !DILocation(line: 1316, column: 17, scope: !1306)
!1340 = !DILocation(line: 1319, column: 23, scope: !1341)
!1341 = distinct !DILexicalBlock(scope: !1342, file: !36, line: 1319, column: 21)
!1342 = distinct !DILexicalBlock(scope: !1337, file: !36, line: 1317, column: 13)
!1343 = !DILocation(line: 1319, column: 34, scope: !1341)
!1344 = !DILocation(line: 1319, column: 56, scope: !1341)
!1345 = !DILocation(line: 1319, column: 21, scope: !1342)
!1346 = !DILocation(line: 1321, column: 44, scope: !1347)
!1347 = distinct !DILexicalBlock(scope: !1341, file: !36, line: 1320, column: 17)
!1348 = !DILocation(line: 1321, column: 56, scope: !1347)
!1349 = !DILocation(line: 1321, column: 64, scope: !1347)
!1350 = !DILocation(line: 1321, column: 78, scope: !1347)
!1351 = !DILocation(line: 1321, column: 92, scope: !1347)
!1352 = !DILocation(line: 1321, column: 31, scope: !1347)
!1353 = !DILocation(line: 1321, column: 29, scope: !1347)
!1354 = !DILocation(line: 1323, column: 27, scope: !1355)
!1355 = distinct !DILexicalBlock(scope: !1347, file: !36, line: 1323, column: 25)
!1356 = !DILocation(line: 1323, column: 35, scope: !1355)
!1357 = !DILocation(line: 1323, column: 47, scope: !1355)
!1358 = !DILocation(line: 1323, column: 52, scope: !1355)
!1359 = !DILocation(line: 1323, column: 72, scope: !1355)
!1360 = !DILocation(line: 1323, column: 25, scope: !1347)
!1361 = !DILocation(line: 1325, column: 25, scope: !1362)
!1362 = distinct !DILexicalBlock(scope: !1355, file: !36, line: 1324, column: 21)
!1363 = !DILocation(line: 1327, column: 29, scope: !1364)
!1364 = distinct !DILexicalBlock(scope: !1362, file: !36, line: 1327, column: 29)
!1365 = !DILocation(line: 1327, column: 43, scope: !1364)
!1366 = !DILocation(line: 1327, column: 29, scope: !1362)
!1367 = !DILocation(line: 1329, column: 63, scope: !1368)
!1368 = distinct !DILexicalBlock(scope: !1364, file: !36, line: 1328, column: 25)
!1369 = !DILocation(line: 1329, column: 46, scope: !1368)
!1370 = !DILocation(line: 1329, column: 30, scope: !1368)
!1371 = !DILocation(line: 1329, column: 44, scope: !1368)
!1372 = !DILocation(line: 1330, column: 25, scope: !1368)
!1373 = !DILocation(line: 1331, column: 21, scope: !1362)
!1374 = !DILocation(line: 1334, column: 61, scope: !1375)
!1375 = distinct !DILexicalBlock(scope: !1355, file: !36, line: 1333, column: 21)
!1376 = !DILocation(line: 1334, column: 25, scope: !1375)
!1377 = !DILocation(line: 1336, column: 17, scope: !1347)
!1378 = !DILocation(line: 1337, column: 13, scope: !1342)
!1379 = !DILocation(line: 1339, column: 20, scope: !1306)
!1380 = !DILocation(line: 1339, column: 13, scope: !1306)
!1381 = distinct !DISubprogram(name: "MPU_GetFreeIndexInKernelObjectPool", scope: !36, file: !36, line: 240, type: !1382, scopeLine: 241, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !80)
!1382 = !DISubroutineType(types: !1383)
!1383 = !{!27}
!1384 = !DILocalVariable(name: "i", scope: !1381, file: !36, line: 242, type: !27)
!1385 = !DILocation(line: 242, column: 17, scope: !1381)
!1386 = !DILocalVariable(name: "lFreeIndex", scope: !1381, file: !36, line: 242, type: !27)
!1387 = !DILocation(line: 242, column: 20, scope: !1381)
!1388 = !DILocation(line: 248, column: 9, scope: !1381)
!1389 = !DILocation(line: 250, column: 20, scope: !1390)
!1390 = distinct !DILexicalBlock(scope: !1391, file: !36, line: 250, column: 13)
!1391 = distinct !DILexicalBlock(scope: !1381, file: !36, line: 249, column: 9)
!1392 = !DILocation(line: 250, column: 18, scope: !1390)
!1393 = !DILocation(line: 250, column: 25, scope: !1394)
!1394 = distinct !DILexicalBlock(scope: !1390, file: !36, line: 250, column: 13)
!1395 = !DILocation(line: 250, column: 27, scope: !1394)
!1396 = !DILocation(line: 250, column: 13, scope: !1390)
!1397 = !DILocation(line: 252, column: 40, scope: !1398)
!1398 = distinct !DILexicalBlock(scope: !1399, file: !36, line: 252, column: 21)
!1399 = distinct !DILexicalBlock(scope: !1394, file: !36, line: 251, column: 13)
!1400 = !DILocation(line: 252, column: 21, scope: !1398)
!1401 = !DILocation(line: 252, column: 44, scope: !1398)
!1402 = !DILocation(line: 252, column: 66, scope: !1398)
!1403 = !DILocation(line: 252, column: 21, scope: !1399)
!1404 = !DILocation(line: 255, column: 40, scope: !1405)
!1405 = distinct !DILexicalBlock(scope: !1398, file: !36, line: 253, column: 17)
!1406 = !DILocation(line: 255, column: 21, scope: !1405)
!1407 = !DILocation(line: 255, column: 44, scope: !1405)
!1408 = !DILocation(line: 255, column: 66, scope: !1405)
!1409 = !DILocation(line: 256, column: 34, scope: !1405)
!1410 = !DILocation(line: 256, column: 32, scope: !1405)
!1411 = !DILocation(line: 257, column: 21, scope: !1405)
!1412 = !DILocation(line: 259, column: 13, scope: !1399)
!1413 = !DILocation(line: 250, column: 71, scope: !1394)
!1414 = !DILocation(line: 250, column: 13, scope: !1394)
!1415 = distinct !{!1415, !1396, !1416}
!1416 = !DILocation(line: 259, column: 13, scope: !1390)
!1417 = !DILocation(line: 261, column: 9, scope: !1381)
!1418 = !DILocation(line: 263, column: 16, scope: !1381)
!1419 = !DILocation(line: 263, column: 9, scope: !1381)
!1420 = distinct !DISubprogram(name: "MPU_StoreHandleAndDataAtIndex", scope: !36, file: !36, line: 302, type: !1421, scopeLine: 306, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !80)
!1421 = !DISubroutineType(types: !1422)
!1422 = !{null, !27, !35, !26, !47}
!1423 = !DILocalVariable(name: "lIndex", arg: 1, scope: !1420, file: !36, line: 302, type: !27)
!1424 = !DILocation(line: 302, column: 56, scope: !1420)
!1425 = !DILocalVariable(name: "xHandle", arg: 2, scope: !1420, file: !36, line: 303, type: !35)
!1426 = !DILocation(line: 303, column: 69, scope: !1420)
!1427 = !DILocalVariable(name: "pvKernelObjectData", arg: 3, scope: !1420, file: !36, line: 304, type: !26)
!1428 = !DILocation(line: 304, column: 55, scope: !1420)
!1429 = !DILocalVariable(name: "ulKernelObjectType", arg: 4, scope: !1420, file: !36, line: 305, type: !47)
!1430 = !DILocation(line: 305, column: 57, scope: !1420)
!1431 = !DILocation(line: 307, column: 9, scope: !1432)
!1432 = distinct !DILexicalBlock(scope: !1420, file: !36, line: 307, column: 9)
!1433 = !DILocation(line: 0, scope: !1432)
!1434 = !DILocation(line: 307, column: 9, scope: !1420)
!1435 = !DILocation(line: 308, column: 61, scope: !1420)
!1436 = !DILocation(line: 308, column: 28, scope: !1420)
!1437 = !DILocation(line: 308, column: 9, scope: !1420)
!1438 = !DILocation(line: 308, column: 37, scope: !1420)
!1439 = !DILocation(line: 308, column: 59, scope: !1420)
!1440 = !DILocation(line: 309, column: 58, scope: !1420)
!1441 = !DILocation(line: 309, column: 28, scope: !1420)
!1442 = !DILocation(line: 309, column: 9, scope: !1420)
!1443 = !DILocation(line: 309, column: 37, scope: !1420)
!1444 = !DILocation(line: 309, column: 56, scope: !1420)
!1445 = !DILocation(line: 310, column: 58, scope: !1420)
!1446 = !DILocation(line: 310, column: 28, scope: !1420)
!1447 = !DILocation(line: 310, column: 9, scope: !1420)
!1448 = !DILocation(line: 310, column: 37, scope: !1420)
!1449 = !DILocation(line: 310, column: 56, scope: !1420)
!1450 = !DILocation(line: 311, column: 5, scope: !1420)
!1451 = distinct !DISubprogram(name: "MPU_SetIndexFreeInKernelObjectPool", scope: !36, file: !36, line: 267, type: !1452, scopeLine: 268, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !80)
!1452 = !DISubroutineType(types: !1453)
!1453 = !{null, !27}
!1454 = !DILocalVariable(name: "lIndex", arg: 1, scope: !1451, file: !36, line: 267, type: !27)
!1455 = !DILocation(line: 267, column: 61, scope: !1451)
!1456 = !DILocation(line: 269, column: 9, scope: !1457)
!1457 = distinct !DILexicalBlock(scope: !1451, file: !36, line: 269, column: 9)
!1458 = !DILocation(line: 0, scope: !1457)
!1459 = !DILocation(line: 269, column: 9, scope: !1451)
!1460 = !DILocation(line: 271, column: 9, scope: !1451)
!1461 = !DILocation(line: 273, column: 32, scope: !1462)
!1462 = distinct !DILexicalBlock(scope: !1451, file: !36, line: 272, column: 9)
!1463 = !DILocation(line: 273, column: 13, scope: !1462)
!1464 = !DILocation(line: 273, column: 41, scope: !1462)
!1465 = !DILocation(line: 273, column: 63, scope: !1462)
!1466 = !DILocation(line: 274, column: 32, scope: !1462)
!1467 = !DILocation(line: 274, column: 13, scope: !1462)
!1468 = !DILocation(line: 274, column: 41, scope: !1462)
!1469 = !DILocation(line: 274, column: 60, scope: !1462)
!1470 = !DILocation(line: 275, column: 32, scope: !1462)
!1471 = !DILocation(line: 275, column: 13, scope: !1462)
!1472 = !DILocation(line: 275, column: 41, scope: !1462)
!1473 = !DILocation(line: 275, column: 60, scope: !1462)
!1474 = !DILocation(line: 277, column: 9, scope: !1451)
!1475 = !DILocation(line: 278, column: 5, scope: !1451)
!1476 = distinct !DISubprogram(name: "MPU_xTaskCreateStatic", scope: !36, file: !36, line: 1347, type: !1477, scopeLine: 1354, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!1477 = !DISubroutineType(types: !1478)
!1478 = !{!32, !1309, !1314, !1479, !1480, !39, !1481, !1482}
!1479 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !47)
!1480 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !26)
!1481 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !295)
!1482 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1483)
!1483 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1484, size: 64)
!1484 = !DIDerivedType(tag: DW_TAG_typedef, name: "StaticTask_t", file: !1485, line: 1319, baseType: !1486)
!1485 = !DIFile(filename: "include/FreeRTOS.h", directory: "/home/klee/FreeRTOS-Kernel-10.6.0")
!1486 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xSTATIC_TCB", file: !1485, line: 1271, size: 2240, elements: !1487)
!1487 = !{!1488, !1489, !1504, !1516, !1517, !1518, !1525, !1527, !1528, !1532, !1533, !1537, !1539, !1540}
!1488 = !DIDerivedType(tag: DW_TAG_member, name: "pxDummy1", scope: !1486, file: !1485, line: 1273, baseType: !26, size: 64)
!1489 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy2", scope: !1486, file: !1485, line: 1275, baseType: !1490, size: 544, offset: 64)
!1490 = !DIDerivedType(tag: DW_TAG_typedef, name: "xMPU_SETTINGS", file: !1491, line: 23, baseType: !1492)
!1491 = !DIFile(filename: "./klee_help.h", directory: "/home/klee/FreeRTOS-Kernel-10.6.0/symbolic_execution/test_access_control")
!1492 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "MPU_SETTINGS", file: !1491, line: 19, size: 544, elements: !1493)
!1493 = !{!1494, !1495}
!1494 = !DIDerivedType(tag: DW_TAG_member, name: "ulMAIR0", scope: !1492, file: !1491, line: 21, baseType: !47, size: 32)
!1495 = !DIDerivedType(tag: DW_TAG_member, name: "xRegionsSettings", scope: !1492, file: !1491, line: 22, baseType: !1496, size: 512, offset: 32)
!1496 = !DICompositeType(tag: DW_TAG_array_type, baseType: !1497, size: 512, elements: !1502)
!1497 = !DIDerivedType(tag: DW_TAG_typedef, name: "MPURegionSettings_t", file: !1491, line: 17, baseType: !1498)
!1498 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "MPURegionSettings", file: !1491, line: 13, size: 64, elements: !1499)
!1499 = !{!1500, !1501}
!1500 = !DIDerivedType(tag: DW_TAG_member, name: "ulRBAR", scope: !1498, file: !1491, line: 15, baseType: !47, size: 32)
!1501 = !DIDerivedType(tag: DW_TAG_member, name: "ulRLAR", scope: !1498, file: !1491, line: 16, baseType: !47, size: 32, offset: 32)
!1502 = !{!1503}
!1503 = !DISubrange(count: 8)
!1504 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy3", scope: !1486, file: !1485, line: 1277, baseType: !1505, size: 640, offset: 640)
!1505 = !DICompositeType(tag: DW_TAG_array_type, baseType: !1506, size: 640, elements: !1514)
!1506 = !DIDerivedType(tag: DW_TAG_typedef, name: "StaticListItem_t", file: !1485, line: 1227, baseType: !1507)
!1507 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xSTATIC_LIST_ITEM", file: !1485, line: 1216, size: 320, elements: !1508)
!1508 = !{!1509, !1510}
!1509 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy2", scope: !1507, file: !1485, line: 1221, baseType: !93, size: 64)
!1510 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy3", scope: !1507, file: !1485, line: 1222, baseType: !1511, size: 256, offset: 64)
!1511 = !DICompositeType(tag: DW_TAG_array_type, baseType: !26, size: 256, elements: !1512)
!1512 = !{!1513}
!1513 = !DISubrange(count: 4)
!1514 = !{!1515}
!1515 = !DISubrange(count: 2)
!1516 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy5", scope: !1486, file: !1485, line: 1278, baseType: !39, size: 64, offset: 1280)
!1517 = !DIDerivedType(tag: DW_TAG_member, name: "pxDummy6", scope: !1486, file: !1485, line: 1279, baseType: !26, size: 64, offset: 1344)
!1518 = !DIDerivedType(tag: DW_TAG_member, name: "ucDummy7", scope: !1486, file: !1485, line: 1280, baseType: !1519, size: 128, offset: 1408)
!1519 = !DICompositeType(tag: DW_TAG_array_type, baseType: !1520, size: 128, elements: !1523)
!1520 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !48, line: 24, baseType: !1521)
!1521 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !30, line: 37, baseType: !1522)
!1522 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!1523 = !{!1524}
!1524 = !DISubrange(count: 16)
!1525 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy10", scope: !1486, file: !1485, line: 1288, baseType: !1526, size: 128, offset: 1536)
!1526 = !DICompositeType(tag: DW_TAG_array_type, baseType: !39, size: 128, elements: !1514)
!1527 = !DIDerivedType(tag: DW_TAG_member, name: "pxDummy14", scope: !1486, file: !1485, line: 1294, baseType: !26, size: 64, offset: 1664)
!1528 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy15", scope: !1486, file: !1485, line: 1297, baseType: !1529, size: 320, offset: 1728)
!1529 = !DICompositeType(tag: DW_TAG_array_type, baseType: !26, size: 320, elements: !1530)
!1530 = !{!1531}
!1531 = !DISubrange(count: 5)
!1532 = !DIDerivedType(tag: DW_TAG_member, name: "ulDummy16", scope: !1486, file: !1485, line: 1300, baseType: !47, size: 32, offset: 2048)
!1533 = !DIDerivedType(tag: DW_TAG_member, name: "ulDummy18", scope: !1486, file: !1485, line: 1306, baseType: !1534, size: 96, offset: 2080)
!1534 = !DICompositeType(tag: DW_TAG_array_type, baseType: !47, size: 96, elements: !1535)
!1535 = !{!1536}
!1536 = !DISubrange(count: 3)
!1537 = !DIDerivedType(tag: DW_TAG_member, name: "ucDummy19", scope: !1486, file: !1485, line: 1307, baseType: !1538, size: 24, offset: 2176)
!1538 = !DICompositeType(tag: DW_TAG_array_type, baseType: !1520, size: 24, elements: !1535)
!1539 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy20", scope: !1486, file: !1485, line: 1310, baseType: !1520, size: 8, offset: 2200)
!1540 = !DIDerivedType(tag: DW_TAG_member, name: "ucDummy21", scope: !1486, file: !1485, line: 1314, baseType: !1520, size: 8, offset: 2208)
!1541 = !DILocalVariable(name: "pxTaskCode", arg: 1, scope: !1476, file: !36, line: 1347, type: !1309)
!1542 = !DILocation(line: 1347, column: 60, scope: !1476)
!1543 = !DILocalVariable(name: "pcName", arg: 2, scope: !1476, file: !36, line: 1348, type: !1314)
!1544 = !DILocation(line: 1348, column: 64, scope: !1476)
!1545 = !DILocalVariable(name: "ulStackDepth", arg: 3, scope: !1476, file: !36, line: 1349, type: !1479)
!1546 = !DILocation(line: 1349, column: 60, scope: !1476)
!1547 = !DILocalVariable(name: "pvParameters", arg: 4, scope: !1476, file: !36, line: 1350, type: !1480)
!1548 = !DILocation(line: 1350, column: 58, scope: !1476)
!1549 = !DILocalVariable(name: "uxPriority", arg: 5, scope: !1476, file: !36, line: 1351, type: !39)
!1550 = !DILocation(line: 1351, column: 57, scope: !1476)
!1551 = !DILocalVariable(name: "puxStackBuffer", arg: 6, scope: !1476, file: !36, line: 1352, type: !1481)
!1552 = !DILocation(line: 1352, column: 65, scope: !1476)
!1553 = !DILocalVariable(name: "pxTaskBuffer", arg: 7, scope: !1476, file: !36, line: 1353, type: !1482)
!1554 = !DILocation(line: 1353, column: 66, scope: !1476)
!1555 = !DILocalVariable(name: "xExternalTaskHandle", scope: !1476, file: !36, line: 1355, type: !32)
!1556 = !DILocation(line: 1355, column: 26, scope: !1476)
!1557 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1476, file: !36, line: 1356, type: !32)
!1558 = !DILocation(line: 1356, column: 26, scope: !1476)
!1559 = !DILocalVariable(name: "lIndex", scope: !1476, file: !36, line: 1357, type: !27)
!1560 = !DILocation(line: 1357, column: 21, scope: !1476)
!1561 = !DILocation(line: 1359, column: 22, scope: !1476)
!1562 = !DILocation(line: 1359, column: 20, scope: !1476)
!1563 = !DILocation(line: 1361, column: 17, scope: !1564)
!1564 = distinct !DILexicalBlock(scope: !1476, file: !36, line: 1361, column: 17)
!1565 = !DILocation(line: 1361, column: 24, scope: !1564)
!1566 = !DILocation(line: 1361, column: 17, scope: !1476)
!1567 = !DILocation(line: 1363, column: 58, scope: !1568)
!1568 = distinct !DILexicalBlock(scope: !1564, file: !36, line: 1362, column: 13)
!1569 = !DILocation(line: 1363, column: 70, scope: !1568)
!1570 = !DILocation(line: 1363, column: 78, scope: !1568)
!1571 = !DILocation(line: 1363, column: 92, scope: !1568)
!1572 = !DILocation(line: 1363, column: 106, scope: !1568)
!1573 = !DILocation(line: 1363, column: 118, scope: !1568)
!1574 = !DILocation(line: 1363, column: 134, scope: !1568)
!1575 = !DILocation(line: 1363, column: 39, scope: !1568)
!1576 = !DILocation(line: 1363, column: 37, scope: !1568)
!1577 = !DILocation(line: 1365, column: 21, scope: !1578)
!1578 = distinct !DILexicalBlock(scope: !1568, file: !36, line: 1365, column: 21)
!1579 = !DILocation(line: 1365, column: 41, scope: !1578)
!1580 = !DILocation(line: 1365, column: 21, scope: !1568)
!1581 = !DILocation(line: 1367, column: 21, scope: !1582)
!1582 = distinct !DILexicalBlock(scope: !1578, file: !36, line: 1366, column: 17)
!1583 = !DILocation(line: 1368, column: 60, scope: !1582)
!1584 = !DILocation(line: 1368, column: 43, scope: !1582)
!1585 = !DILocation(line: 1368, column: 41, scope: !1582)
!1586 = !DILocation(line: 1369, column: 17, scope: !1582)
!1587 = !DILocation(line: 1372, column: 57, scope: !1588)
!1588 = distinct !DILexicalBlock(scope: !1578, file: !36, line: 1371, column: 17)
!1589 = !DILocation(line: 1372, column: 21, scope: !1588)
!1590 = !DILocation(line: 1374, column: 13, scope: !1568)
!1591 = !DILocation(line: 1376, column: 20, scope: !1476)
!1592 = !DILocation(line: 1376, column: 13, scope: !1476)
!1593 = distinct !DISubprogram(name: "MPU_vTaskDelete", scope: !36, file: !36, line: 1384, type: !370, scopeLine: 1385, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!1594 = !DILocalVariable(name: "pxTaskToDelete", arg: 1, scope: !1593, file: !36, line: 1384, type: !32)
!1595 = !DILocation(line: 1384, column: 44, scope: !1593)
!1596 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1593, file: !36, line: 1386, type: !32)
!1597 = !DILocation(line: 1386, column: 26, scope: !1593)
!1598 = !DILocalVariable(name: "lIndex", scope: !1593, file: !36, line: 1387, type: !27)
!1599 = !DILocation(line: 1387, column: 21, scope: !1593)
!1600 = !DILocation(line: 1389, column: 17, scope: !1601)
!1601 = distinct !DILexicalBlock(scope: !1593, file: !36, line: 1389, column: 17)
!1602 = !DILocation(line: 1389, column: 32, scope: !1601)
!1603 = !DILocation(line: 1389, column: 17, scope: !1593)
!1604 = !DILocation(line: 1391, column: 39, scope: !1605)
!1605 = distinct !DILexicalBlock(scope: !1601, file: !36, line: 1390, column: 13)
!1606 = !DILocation(line: 1391, column: 37, scope: !1605)
!1607 = !DILocation(line: 1392, column: 26, scope: !1605)
!1608 = !DILocation(line: 1392, column: 24, scope: !1605)
!1609 = !DILocation(line: 1394, column: 30, scope: !1605)
!1610 = !DILocation(line: 1394, column: 17, scope: !1605)
!1611 = !DILocation(line: 1396, column: 21, scope: !1612)
!1612 = distinct !DILexicalBlock(scope: !1605, file: !36, line: 1396, column: 21)
!1613 = !DILocation(line: 1396, column: 28, scope: !1612)
!1614 = !DILocation(line: 1396, column: 21, scope: !1605)
!1615 = !DILocation(line: 1398, column: 57, scope: !1616)
!1616 = distinct !DILexicalBlock(scope: !1612, file: !36, line: 1397, column: 17)
!1617 = !DILocation(line: 1398, column: 21, scope: !1616)
!1618 = !DILocation(line: 1399, column: 17, scope: !1616)
!1619 = !DILocation(line: 1400, column: 13, scope: !1605)
!1620 = !DILocation(line: 1403, column: 38, scope: !1621)
!1621 = distinct !DILexicalBlock(scope: !1601, file: !36, line: 1402, column: 13)
!1622 = !DILocation(line: 1403, column: 26, scope: !1621)
!1623 = !DILocation(line: 1403, column: 24, scope: !1621)
!1624 = !DILocation(line: 1405, column: 21, scope: !1625)
!1625 = distinct !DILexicalBlock(scope: !1621, file: !36, line: 1405, column: 21)
!1626 = !DILocation(line: 0, scope: !1625)
!1627 = !DILocation(line: 1405, column: 55, scope: !1625)
!1628 = !DILocation(line: 1405, column: 21, scope: !1621)
!1629 = !DILocation(line: 1407, column: 43, scope: !1630)
!1630 = distinct !DILexicalBlock(scope: !1625, file: !36, line: 1406, column: 17)
!1631 = !DILocation(line: 1407, column: 41, scope: !1630)
!1632 = !DILocation(line: 1409, column: 25, scope: !1633)
!1633 = distinct !DILexicalBlock(scope: !1630, file: !36, line: 1409, column: 25)
!1634 = !DILocation(line: 1409, column: 45, scope: !1633)
!1635 = !DILocation(line: 1409, column: 25, scope: !1630)
!1636 = !DILocation(line: 1411, column: 38, scope: !1637)
!1637 = distinct !DILexicalBlock(scope: !1633, file: !36, line: 1410, column: 21)
!1638 = !DILocation(line: 1411, column: 25, scope: !1637)
!1639 = !DILocation(line: 1412, column: 61, scope: !1637)
!1640 = !DILocation(line: 1412, column: 25, scope: !1637)
!1641 = !DILocation(line: 1413, column: 21, scope: !1637)
!1642 = !DILocation(line: 1414, column: 17, scope: !1630)
!1643 = !DILocation(line: 1416, column: 9, scope: !1593)
!1644 = distinct !DISubprogram(name: "MPU_vTaskPrioritySet", scope: !36, file: !36, line: 1424, type: !1645, scopeLine: 1426, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!1645 = !DISubroutineType(types: !1646)
!1646 = !{null, !32, !39}
!1647 = !DILocalVariable(name: "pxTask", arg: 1, scope: !1644, file: !36, line: 1424, type: !32)
!1648 = !DILocation(line: 1424, column: 49, scope: !1644)
!1649 = !DILocalVariable(name: "uxNewPriority", arg: 2, scope: !1644, file: !36, line: 1425, type: !39)
!1650 = !DILocation(line: 1425, column: 48, scope: !1644)
!1651 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1644, file: !36, line: 1427, type: !32)
!1652 = !DILocation(line: 1427, column: 26, scope: !1644)
!1653 = !DILocalVariable(name: "lIndex", scope: !1644, file: !36, line: 1428, type: !27)
!1654 = !DILocation(line: 1428, column: 21, scope: !1644)
!1655 = !DILocation(line: 1430, column: 17, scope: !1656)
!1656 = distinct !DILexicalBlock(scope: !1644, file: !36, line: 1430, column: 17)
!1657 = !DILocation(line: 1430, column: 24, scope: !1656)
!1658 = !DILocation(line: 1430, column: 17, scope: !1644)
!1659 = !DILocation(line: 1432, column: 35, scope: !1660)
!1660 = distinct !DILexicalBlock(scope: !1656, file: !36, line: 1431, column: 13)
!1661 = !DILocation(line: 1432, column: 43, scope: !1660)
!1662 = !DILocation(line: 1432, column: 17, scope: !1660)
!1663 = !DILocation(line: 1433, column: 13, scope: !1660)
!1664 = !DILocation(line: 1436, column: 38, scope: !1665)
!1665 = distinct !DILexicalBlock(scope: !1656, file: !36, line: 1435, column: 13)
!1666 = !DILocation(line: 1436, column: 26, scope: !1665)
!1667 = !DILocation(line: 1436, column: 24, scope: !1665)
!1668 = !DILocation(line: 1438, column: 21, scope: !1669)
!1669 = distinct !DILexicalBlock(scope: !1665, file: !36, line: 1438, column: 21)
!1670 = !DILocation(line: 0, scope: !1669)
!1671 = !DILocation(line: 1438, column: 55, scope: !1669)
!1672 = !DILocation(line: 1438, column: 21, scope: !1665)
!1673 = !DILocation(line: 1440, column: 43, scope: !1674)
!1674 = distinct !DILexicalBlock(scope: !1669, file: !36, line: 1439, column: 17)
!1675 = !DILocation(line: 1440, column: 41, scope: !1674)
!1676 = !DILocation(line: 1442, column: 25, scope: !1677)
!1677 = distinct !DILexicalBlock(scope: !1674, file: !36, line: 1442, column: 25)
!1678 = !DILocation(line: 1442, column: 45, scope: !1677)
!1679 = !DILocation(line: 1442, column: 25, scope: !1674)
!1680 = !DILocation(line: 1444, column: 43, scope: !1681)
!1681 = distinct !DILexicalBlock(scope: !1677, file: !36, line: 1443, column: 21)
!1682 = !DILocation(line: 1444, column: 64, scope: !1681)
!1683 = !DILocation(line: 1444, column: 25, scope: !1681)
!1684 = !DILocation(line: 1445, column: 21, scope: !1681)
!1685 = !DILocation(line: 1446, column: 17, scope: !1674)
!1686 = !DILocation(line: 1448, column: 9, scope: !1644)
!1687 = distinct !DISubprogram(name: "MPU_xTaskGetHandle", scope: !36, file: !36, line: 1455, type: !1688, scopeLine: 1456, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!1688 = !DISubroutineType(types: !1689)
!1689 = !{!32, !286}
!1690 = !DILocalVariable(name: "pcNameToQuery", arg: 1, scope: !1687, file: !36, line: 1455, type: !286)
!1691 = !DILocation(line: 1455, column: 55, scope: !1687)
!1692 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1687, file: !36, line: 1457, type: !32)
!1693 = !DILocation(line: 1457, column: 26, scope: !1687)
!1694 = !DILocalVariable(name: "xExternalTaskHandle", scope: !1687, file: !36, line: 1458, type: !32)
!1695 = !DILocation(line: 1458, column: 26, scope: !1687)
!1696 = !DILocalVariable(name: "lIndex", scope: !1687, file: !36, line: 1459, type: !27)
!1697 = !DILocation(line: 1459, column: 21, scope: !1687)
!1698 = !DILocation(line: 1461, column: 51, scope: !1687)
!1699 = !DILocation(line: 1461, column: 35, scope: !1687)
!1700 = !DILocation(line: 1461, column: 33, scope: !1687)
!1701 = !DILocation(line: 1463, column: 17, scope: !1702)
!1702 = distinct !DILexicalBlock(scope: !1687, file: !36, line: 1463, column: 17)
!1703 = !DILocation(line: 1463, column: 37, scope: !1702)
!1704 = !DILocation(line: 1463, column: 17, scope: !1687)
!1705 = !DILocation(line: 1465, column: 26, scope: !1706)
!1706 = distinct !DILexicalBlock(scope: !1702, file: !36, line: 1464, column: 13)
!1707 = !DILocation(line: 1465, column: 24, scope: !1706)
!1708 = !DILocation(line: 1467, column: 21, scope: !1709)
!1709 = distinct !DILexicalBlock(scope: !1706, file: !36, line: 1467, column: 21)
!1710 = !DILocation(line: 1467, column: 28, scope: !1709)
!1711 = !DILocation(line: 1467, column: 21, scope: !1706)
!1712 = !DILocation(line: 1469, column: 60, scope: !1713)
!1713 = distinct !DILexicalBlock(scope: !1709, file: !36, line: 1468, column: 17)
!1714 = !DILocation(line: 1469, column: 43, scope: !1713)
!1715 = !DILocation(line: 1469, column: 41, scope: !1713)
!1716 = !DILocation(line: 1470, column: 17, scope: !1713)
!1717 = !DILocation(line: 1471, column: 13, scope: !1706)
!1718 = !DILocation(line: 1473, column: 20, scope: !1687)
!1719 = !DILocation(line: 1473, column: 13, scope: !1687)
!1720 = distinct !DISubprogram(name: "MPU_xTaskCallApplicationTaskHook", scope: !36, file: !36, line: 1482, type: !1721, scopeLine: 1484, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!1721 = !DISubroutineType(types: !1722)
!1722 = !{!23, !32, !26}
!1723 = !DILocalVariable(name: "xTask", arg: 1, scope: !1720, file: !36, line: 1482, type: !32)
!1724 = !DILocation(line: 1482, column: 67, scope: !1720)
!1725 = !DILocalVariable(name: "pvParameter", arg: 2, scope: !1720, file: !36, line: 1483, type: !26)
!1726 = !DILocation(line: 1483, column: 61, scope: !1720)
!1727 = !DILocalVariable(name: "xReturn", scope: !1720, file: !36, line: 1485, type: !23)
!1728 = !DILocation(line: 1485, column: 24, scope: !1720)
!1729 = !DILocalVariable(name: "lIndex", scope: !1720, file: !36, line: 1486, type: !27)
!1730 = !DILocation(line: 1486, column: 21, scope: !1720)
!1731 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1720, file: !36, line: 1487, type: !32)
!1732 = !DILocation(line: 1487, column: 26, scope: !1720)
!1733 = !DILocation(line: 1489, column: 17, scope: !1734)
!1734 = distinct !DILexicalBlock(scope: !1720, file: !36, line: 1489, column: 17)
!1735 = !DILocation(line: 1489, column: 23, scope: !1734)
!1736 = !DILocation(line: 1489, column: 17, scope: !1720)
!1737 = !DILocation(line: 1491, column: 57, scope: !1738)
!1738 = distinct !DILexicalBlock(scope: !1734, file: !36, line: 1490, column: 13)
!1739 = !DILocation(line: 1491, column: 64, scope: !1738)
!1740 = !DILocation(line: 1491, column: 27, scope: !1738)
!1741 = !DILocation(line: 1491, column: 25, scope: !1738)
!1742 = !DILocation(line: 1492, column: 13, scope: !1738)
!1743 = !DILocation(line: 1495, column: 38, scope: !1744)
!1744 = distinct !DILexicalBlock(scope: !1734, file: !36, line: 1494, column: 13)
!1745 = !DILocation(line: 1495, column: 26, scope: !1744)
!1746 = !DILocation(line: 1495, column: 24, scope: !1744)
!1747 = !DILocation(line: 1497, column: 21, scope: !1748)
!1748 = distinct !DILexicalBlock(scope: !1744, file: !36, line: 1497, column: 21)
!1749 = !DILocation(line: 0, scope: !1748)
!1750 = !DILocation(line: 1497, column: 55, scope: !1748)
!1751 = !DILocation(line: 1497, column: 21, scope: !1744)
!1752 = !DILocation(line: 1499, column: 43, scope: !1753)
!1753 = distinct !DILexicalBlock(scope: !1748, file: !36, line: 1498, column: 17)
!1754 = !DILocation(line: 1499, column: 41, scope: !1753)
!1755 = !DILocation(line: 1501, column: 25, scope: !1756)
!1756 = distinct !DILexicalBlock(scope: !1753, file: !36, line: 1501, column: 25)
!1757 = !DILocation(line: 1501, column: 45, scope: !1756)
!1758 = !DILocation(line: 1501, column: 25, scope: !1753)
!1759 = !DILocation(line: 1503, column: 65, scope: !1760)
!1760 = distinct !DILexicalBlock(scope: !1756, file: !36, line: 1502, column: 21)
!1761 = !DILocation(line: 1503, column: 86, scope: !1760)
!1762 = !DILocation(line: 1503, column: 35, scope: !1760)
!1763 = !DILocation(line: 1503, column: 33, scope: !1760)
!1764 = !DILocation(line: 1504, column: 21, scope: !1760)
!1765 = !DILocation(line: 1505, column: 17, scope: !1753)
!1766 = !DILocation(line: 1508, column: 20, scope: !1720)
!1767 = !DILocation(line: 1508, column: 13, scope: !1720)
!1768 = distinct !DISubprogram(name: "MPU_xTaskCreateRestricted", scope: !36, file: !36, line: 1516, type: !1769, scopeLine: 1518, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!1769 = !DISubroutineType(types: !1770)
!1770 = !{!23, !1771, !1315}
!1771 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1772)
!1772 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1773, size: 64)
!1773 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1774)
!1774 = !DIDerivedType(tag: DW_TAG_typedef, name: "TaskParameters_t", file: !6, line: 155, baseType: !1775)
!1775 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xTASK_PARAMETERS", file: !6, line: 143, size: 576, elements: !1776)
!1776 = !{!1777, !1778, !1779, !1780, !1781, !1782, !1783, !1793}
!1777 = !DIDerivedType(tag: DW_TAG_member, name: "pvTaskCode", scope: !1775, file: !6, line: 145, baseType: !1309, size: 64)
!1778 = !DIDerivedType(tag: DW_TAG_member, name: "pcName", scope: !1775, file: !6, line: 146, baseType: !286, size: 64, offset: 64)
!1779 = !DIDerivedType(tag: DW_TAG_member, name: "usStackDepth", scope: !1775, file: !6, line: 147, baseType: !298, size: 16, offset: 128)
!1780 = !DIDerivedType(tag: DW_TAG_member, name: "pvParameters", scope: !1775, file: !6, line: 148, baseType: !26, size: 64, offset: 192)
!1781 = !DIDerivedType(tag: DW_TAG_member, name: "uxPriority", scope: !1775, file: !6, line: 149, baseType: !39, size: 64, offset: 256)
!1782 = !DIDerivedType(tag: DW_TAG_member, name: "puxStackBuffer", scope: !1775, file: !6, line: 150, baseType: !295, size: 64, offset: 320)
!1783 = !DIDerivedType(tag: DW_TAG_member, name: "xRegions", scope: !1775, file: !6, line: 151, baseType: !1784, size: 128, offset: 384)
!1784 = !DICompositeType(tag: DW_TAG_array_type, baseType: !1785, size: 128, elements: !1791)
!1785 = !DIDerivedType(tag: DW_TAG_typedef, name: "MemoryRegion_t", file: !6, line: 138, baseType: !1786)
!1786 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xMEMORY_REGION", file: !6, line: 133, size: 128, elements: !1787)
!1787 = !{!1788, !1789, !1790}
!1788 = !DIDerivedType(tag: DW_TAG_member, name: "pvBaseAddress", scope: !1786, file: !6, line: 135, baseType: !26, size: 64)
!1789 = !DIDerivedType(tag: DW_TAG_member, name: "ulLengthInBytes", scope: !1786, file: !6, line: 136, baseType: !47, size: 32, offset: 64)
!1790 = !DIDerivedType(tag: DW_TAG_member, name: "ulParameters", scope: !1786, file: !6, line: 137, baseType: !47, size: 32, offset: 96)
!1791 = !{!1792}
!1792 = !DISubrange(count: 1)
!1793 = !DIDerivedType(tag: DW_TAG_member, name: "pxTaskBuffer", scope: !1775, file: !6, line: 153, baseType: !1482, size: 64, offset: 512)
!1794 = !DILocalVariable(name: "pxTaskDefinition", arg: 1, scope: !1768, file: !36, line: 1516, type: !1771)
!1795 = !DILocation(line: 1516, column: 78, scope: !1768)
!1796 = !DILocalVariable(name: "pxCreatedTask", arg: 2, scope: !1768, file: !36, line: 1517, type: !1315)
!1797 = !DILocation(line: 1517, column: 62, scope: !1768)
!1798 = !DILocalVariable(name: "xReturn", scope: !1768, file: !36, line: 1519, type: !23)
!1799 = !DILocation(line: 1519, column: 24, scope: !1768)
!1800 = !DILocalVariable(name: "lIndex", scope: !1768, file: !36, line: 1520, type: !27)
!1801 = !DILocation(line: 1520, column: 21, scope: !1768)
!1802 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1768, file: !36, line: 1521, type: !32)
!1803 = !DILocation(line: 1521, column: 26, scope: !1768)
!1804 = !DILocation(line: 1523, column: 22, scope: !1768)
!1805 = !DILocation(line: 1523, column: 20, scope: !1768)
!1806 = !DILocation(line: 1525, column: 17, scope: !1807)
!1807 = distinct !DILexicalBlock(scope: !1768, file: !36, line: 1525, column: 17)
!1808 = !DILocation(line: 1525, column: 24, scope: !1807)
!1809 = !DILocation(line: 1525, column: 17, scope: !1768)
!1810 = !DILocation(line: 1527, column: 50, scope: !1811)
!1811 = distinct !DILexicalBlock(scope: !1807, file: !36, line: 1526, column: 13)
!1812 = !DILocation(line: 1527, column: 27, scope: !1811)
!1813 = !DILocation(line: 1527, column: 25, scope: !1811)
!1814 = !DILocation(line: 1529, column: 23, scope: !1815)
!1815 = distinct !DILexicalBlock(scope: !1811, file: !36, line: 1529, column: 21)
!1816 = !DILocation(line: 1529, column: 31, scope: !1815)
!1817 = !DILocation(line: 1529, column: 43, scope: !1815)
!1818 = !DILocation(line: 1529, column: 48, scope: !1815)
!1819 = !DILocation(line: 1529, column: 68, scope: !1815)
!1820 = !DILocation(line: 1529, column: 21, scope: !1811)
!1821 = !DILocation(line: 1531, column: 21, scope: !1822)
!1822 = distinct !DILexicalBlock(scope: !1815, file: !36, line: 1530, column: 17)
!1823 = !DILocation(line: 1533, column: 25, scope: !1824)
!1824 = distinct !DILexicalBlock(scope: !1822, file: !36, line: 1533, column: 25)
!1825 = !DILocation(line: 1533, column: 39, scope: !1824)
!1826 = !DILocation(line: 1533, column: 25, scope: !1822)
!1827 = !DILocation(line: 1535, column: 59, scope: !1828)
!1828 = distinct !DILexicalBlock(scope: !1824, file: !36, line: 1534, column: 21)
!1829 = !DILocation(line: 1535, column: 42, scope: !1828)
!1830 = !DILocation(line: 1535, column: 26, scope: !1828)
!1831 = !DILocation(line: 1535, column: 40, scope: !1828)
!1832 = !DILocation(line: 1536, column: 21, scope: !1828)
!1833 = !DILocation(line: 1537, column: 17, scope: !1822)
!1834 = !DILocation(line: 1540, column: 57, scope: !1835)
!1835 = distinct !DILexicalBlock(scope: !1815, file: !36, line: 1539, column: 17)
!1836 = !DILocation(line: 1540, column: 21, scope: !1835)
!1837 = !DILocation(line: 1542, column: 13, scope: !1811)
!1838 = !DILocation(line: 1544, column: 20, scope: !1768)
!1839 = !DILocation(line: 1544, column: 13, scope: !1768)
!1840 = distinct !DISubprogram(name: "MPU_xTaskCreateRestrictedStatic", scope: !36, file: !36, line: 1552, type: !1769, scopeLine: 1554, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!1841 = !DILocalVariable(name: "pxTaskDefinition", arg: 1, scope: !1840, file: !36, line: 1552, type: !1771)
!1842 = !DILocation(line: 1552, column: 84, scope: !1840)
!1843 = !DILocalVariable(name: "pxCreatedTask", arg: 2, scope: !1840, file: !36, line: 1553, type: !1315)
!1844 = !DILocation(line: 1553, column: 68, scope: !1840)
!1845 = !DILocalVariable(name: "xReturn", scope: !1840, file: !36, line: 1555, type: !23)
!1846 = !DILocation(line: 1555, column: 24, scope: !1840)
!1847 = !DILocalVariable(name: "lIndex", scope: !1840, file: !36, line: 1556, type: !27)
!1848 = !DILocation(line: 1556, column: 21, scope: !1840)
!1849 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1840, file: !36, line: 1557, type: !32)
!1850 = !DILocation(line: 1557, column: 26, scope: !1840)
!1851 = !DILocation(line: 1559, column: 22, scope: !1840)
!1852 = !DILocation(line: 1559, column: 20, scope: !1840)
!1853 = !DILocation(line: 1561, column: 17, scope: !1854)
!1854 = distinct !DILexicalBlock(scope: !1840, file: !36, line: 1561, column: 17)
!1855 = !DILocation(line: 1561, column: 24, scope: !1854)
!1856 = !DILocation(line: 1561, column: 17, scope: !1840)
!1857 = !DILocation(line: 1563, column: 56, scope: !1858)
!1858 = distinct !DILexicalBlock(scope: !1854, file: !36, line: 1562, column: 13)
!1859 = !DILocation(line: 1563, column: 27, scope: !1858)
!1860 = !DILocation(line: 1563, column: 25, scope: !1858)
!1861 = !DILocation(line: 1565, column: 23, scope: !1862)
!1862 = distinct !DILexicalBlock(scope: !1858, file: !36, line: 1565, column: 21)
!1863 = !DILocation(line: 1565, column: 31, scope: !1862)
!1864 = !DILocation(line: 1565, column: 43, scope: !1862)
!1865 = !DILocation(line: 1565, column: 48, scope: !1862)
!1866 = !DILocation(line: 1565, column: 68, scope: !1862)
!1867 = !DILocation(line: 1565, column: 21, scope: !1858)
!1868 = !DILocation(line: 1567, column: 21, scope: !1869)
!1869 = distinct !DILexicalBlock(scope: !1862, file: !36, line: 1566, column: 17)
!1870 = !DILocation(line: 1569, column: 25, scope: !1871)
!1871 = distinct !DILexicalBlock(scope: !1869, file: !36, line: 1569, column: 25)
!1872 = !DILocation(line: 1569, column: 39, scope: !1871)
!1873 = !DILocation(line: 1569, column: 25, scope: !1869)
!1874 = !DILocation(line: 1571, column: 59, scope: !1875)
!1875 = distinct !DILexicalBlock(scope: !1871, file: !36, line: 1570, column: 21)
!1876 = !DILocation(line: 1571, column: 42, scope: !1875)
!1877 = !DILocation(line: 1571, column: 26, scope: !1875)
!1878 = !DILocation(line: 1571, column: 40, scope: !1875)
!1879 = !DILocation(line: 1572, column: 21, scope: !1875)
!1880 = !DILocation(line: 1573, column: 17, scope: !1869)
!1881 = !DILocation(line: 1576, column: 57, scope: !1882)
!1882 = distinct !DILexicalBlock(scope: !1862, file: !36, line: 1575, column: 17)
!1883 = !DILocation(line: 1576, column: 21, scope: !1882)
!1884 = !DILocation(line: 1578, column: 13, scope: !1858)
!1885 = !DILocation(line: 1580, column: 20, scope: !1840)
!1886 = !DILocation(line: 1580, column: 13, scope: !1840)
!1887 = distinct !DISubprogram(name: "MPU_vTaskAllocateMPURegions", scope: !36, file: !36, line: 1586, type: !1888, scopeLine: 1588, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!1888 = !DISubroutineType(types: !1889)
!1889 = !{null, !32, !1890}
!1890 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1891)
!1891 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1892, size: 64)
!1892 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1785)
!1893 = !DILocalVariable(name: "xTaskToModify", arg: 1, scope: !1887, file: !36, line: 1586, type: !32)
!1894 = !DILocation(line: 1586, column: 52, scope: !1887)
!1895 = !DILocalVariable(name: "xRegions", arg: 2, scope: !1887, file: !36, line: 1587, type: !1890)
!1896 = !DILocation(line: 1587, column: 68, scope: !1887)
!1897 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1887, file: !36, line: 1589, type: !32)
!1898 = !DILocation(line: 1589, column: 22, scope: !1887)
!1899 = !DILocalVariable(name: "lIndex", scope: !1887, file: !36, line: 1590, type: !27)
!1900 = !DILocation(line: 1590, column: 17, scope: !1887)
!1901 = !DILocation(line: 1592, column: 13, scope: !1902)
!1902 = distinct !DILexicalBlock(scope: !1887, file: !36, line: 1592, column: 13)
!1903 = !DILocation(line: 1592, column: 27, scope: !1902)
!1904 = !DILocation(line: 1592, column: 13, scope: !1887)
!1905 = !DILocation(line: 1594, column: 38, scope: !1906)
!1906 = distinct !DILexicalBlock(scope: !1902, file: !36, line: 1593, column: 9)
!1907 = !DILocation(line: 1594, column: 53, scope: !1906)
!1908 = !DILocation(line: 1594, column: 13, scope: !1906)
!1909 = !DILocation(line: 1595, column: 9, scope: !1906)
!1910 = !DILocation(line: 1598, column: 34, scope: !1911)
!1911 = distinct !DILexicalBlock(scope: !1902, file: !36, line: 1597, column: 9)
!1912 = !DILocation(line: 1598, column: 22, scope: !1911)
!1913 = !DILocation(line: 1598, column: 20, scope: !1911)
!1914 = !DILocation(line: 1600, column: 17, scope: !1915)
!1915 = distinct !DILexicalBlock(scope: !1911, file: !36, line: 1600, column: 17)
!1916 = !DILocation(line: 0, scope: !1915)
!1917 = !DILocation(line: 1600, column: 51, scope: !1915)
!1918 = !DILocation(line: 1600, column: 17, scope: !1911)
!1919 = !DILocation(line: 1602, column: 39, scope: !1920)
!1920 = distinct !DILexicalBlock(scope: !1915, file: !36, line: 1601, column: 13)
!1921 = !DILocation(line: 1602, column: 37, scope: !1920)
!1922 = !DILocation(line: 1604, column: 21, scope: !1923)
!1923 = distinct !DILexicalBlock(scope: !1920, file: !36, line: 1604, column: 21)
!1924 = !DILocation(line: 1604, column: 41, scope: !1923)
!1925 = !DILocation(line: 1604, column: 21, scope: !1920)
!1926 = !DILocation(line: 1606, column: 46, scope: !1927)
!1927 = distinct !DILexicalBlock(scope: !1923, file: !36, line: 1605, column: 17)
!1928 = !DILocation(line: 1606, column: 67, scope: !1927)
!1929 = !DILocation(line: 1606, column: 21, scope: !1927)
!1930 = !DILocation(line: 1607, column: 17, scope: !1927)
!1931 = !DILocation(line: 1608, column: 13, scope: !1920)
!1932 = !DILocation(line: 1610, column: 5, scope: !1887)
!1933 = distinct !DISubprogram(name: "MPU_xTaskGetStaticBuffers", scope: !36, file: !36, line: 1615, type: !1934, scopeLine: 1618, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!1934 = !DISubroutineType(types: !1935)
!1935 = !{!23, !32, !1936, !1937}
!1936 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !295, size: 64)
!1937 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1483, size: 64)
!1938 = !DILocalVariable(name: "xTask", arg: 1, scope: !1933, file: !36, line: 1615, type: !32)
!1939 = !DILocation(line: 1615, column: 60, scope: !1933)
!1940 = !DILocalVariable(name: "ppuxStackBuffer", arg: 2, scope: !1933, file: !36, line: 1616, type: !1936)
!1941 = !DILocation(line: 1616, column: 62, scope: !1933)
!1942 = !DILocalVariable(name: "ppxTaskBuffer", arg: 3, scope: !1933, file: !36, line: 1617, type: !1937)
!1943 = !DILocation(line: 1617, column: 63, scope: !1933)
!1944 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1933, file: !36, line: 1619, type: !32)
!1945 = !DILocation(line: 1619, column: 26, scope: !1933)
!1946 = !DILocalVariable(name: "lIndex", scope: !1933, file: !36, line: 1620, type: !27)
!1947 = !DILocation(line: 1620, column: 21, scope: !1933)
!1948 = !DILocalVariable(name: "xReturn", scope: !1933, file: !36, line: 1621, type: !23)
!1949 = !DILocation(line: 1621, column: 24, scope: !1933)
!1950 = !DILocation(line: 1623, column: 17, scope: !1951)
!1951 = distinct !DILexicalBlock(scope: !1933, file: !36, line: 1623, column: 17)
!1952 = !DILocation(line: 1623, column: 23, scope: !1951)
!1953 = !DILocation(line: 1623, column: 17, scope: !1933)
!1954 = !DILocation(line: 1625, column: 39, scope: !1955)
!1955 = distinct !DILexicalBlock(scope: !1951, file: !36, line: 1624, column: 13)
!1956 = !DILocation(line: 1625, column: 37, scope: !1955)
!1957 = !DILocation(line: 1626, column: 50, scope: !1955)
!1958 = !DILocation(line: 1626, column: 71, scope: !1955)
!1959 = !DILocation(line: 1626, column: 88, scope: !1955)
!1960 = !DILocation(line: 1626, column: 27, scope: !1955)
!1961 = !DILocation(line: 1626, column: 25, scope: !1955)
!1962 = !DILocation(line: 1627, column: 13, scope: !1955)
!1963 = !DILocation(line: 1630, column: 38, scope: !1964)
!1964 = distinct !DILexicalBlock(scope: !1951, file: !36, line: 1629, column: 13)
!1965 = !DILocation(line: 1630, column: 26, scope: !1964)
!1966 = !DILocation(line: 1630, column: 24, scope: !1964)
!1967 = !DILocation(line: 1632, column: 21, scope: !1968)
!1968 = distinct !DILexicalBlock(scope: !1964, file: !36, line: 1632, column: 21)
!1969 = !DILocation(line: 0, scope: !1968)
!1970 = !DILocation(line: 1632, column: 55, scope: !1968)
!1971 = !DILocation(line: 1632, column: 21, scope: !1964)
!1972 = !DILocation(line: 1634, column: 43, scope: !1973)
!1973 = distinct !DILexicalBlock(scope: !1968, file: !36, line: 1633, column: 17)
!1974 = !DILocation(line: 1634, column: 41, scope: !1973)
!1975 = !DILocation(line: 1636, column: 25, scope: !1976)
!1976 = distinct !DILexicalBlock(scope: !1973, file: !36, line: 1636, column: 25)
!1977 = !DILocation(line: 1636, column: 45, scope: !1976)
!1978 = !DILocation(line: 1636, column: 25, scope: !1973)
!1979 = !DILocation(line: 1638, column: 58, scope: !1980)
!1980 = distinct !DILexicalBlock(scope: !1976, file: !36, line: 1637, column: 21)
!1981 = !DILocation(line: 1638, column: 79, scope: !1980)
!1982 = !DILocation(line: 1638, column: 96, scope: !1980)
!1983 = !DILocation(line: 1638, column: 35, scope: !1980)
!1984 = !DILocation(line: 1638, column: 33, scope: !1980)
!1985 = !DILocation(line: 1639, column: 21, scope: !1980)
!1986 = !DILocation(line: 1640, column: 17, scope: !1973)
!1987 = !DILocation(line: 1643, column: 20, scope: !1933)
!1988 = !DILocation(line: 1643, column: 13, scope: !1933)
!1989 = distinct !DISubprogram(name: "MPU_uxTaskPriorityGetFromISR", scope: !36, file: !36, line: 1651, type: !188, scopeLine: 1652, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!1990 = !DILocalVariable(name: "xTask", arg: 1, scope: !1989, file: !36, line: 1651, type: !190)
!1991 = !DILocation(line: 1651, column: 70, scope: !1989)
!1992 = !DILocalVariable(name: "uxReturn", scope: !1989, file: !36, line: 1653, type: !39)
!1993 = !DILocation(line: 1653, column: 25, scope: !1989)
!1994 = !DILocalVariable(name: "lIndex", scope: !1989, file: !36, line: 1654, type: !27)
!1995 = !DILocation(line: 1654, column: 21, scope: !1989)
!1996 = !DILocalVariable(name: "xInternalTaskHandle", scope: !1989, file: !36, line: 1655, type: !32)
!1997 = !DILocation(line: 1655, column: 26, scope: !1989)
!1998 = !DILocation(line: 1657, column: 17, scope: !1999)
!1999 = distinct !DILexicalBlock(scope: !1989, file: !36, line: 1657, column: 17)
!2000 = !DILocation(line: 1657, column: 23, scope: !1999)
!2001 = !DILocation(line: 1657, column: 17, scope: !1989)
!2002 = !DILocation(line: 1659, column: 54, scope: !2003)
!2003 = distinct !DILexicalBlock(scope: !1999, file: !36, line: 1658, column: 13)
!2004 = !DILocation(line: 1659, column: 28, scope: !2003)
!2005 = !DILocation(line: 1659, column: 26, scope: !2003)
!2006 = !DILocation(line: 1660, column: 13, scope: !2003)
!2007 = !DILocation(line: 1663, column: 38, scope: !2008)
!2008 = distinct !DILexicalBlock(scope: !1999, file: !36, line: 1662, column: 13)
!2009 = !DILocation(line: 1663, column: 26, scope: !2008)
!2010 = !DILocation(line: 1663, column: 24, scope: !2008)
!2011 = !DILocation(line: 1665, column: 21, scope: !2012)
!2012 = distinct !DILexicalBlock(scope: !2008, file: !36, line: 1665, column: 21)
!2013 = !DILocation(line: 0, scope: !2012)
!2014 = !DILocation(line: 1665, column: 55, scope: !2012)
!2015 = !DILocation(line: 1665, column: 21, scope: !2008)
!2016 = !DILocation(line: 1667, column: 43, scope: !2017)
!2017 = distinct !DILexicalBlock(scope: !2012, file: !36, line: 1666, column: 17)
!2018 = !DILocation(line: 1667, column: 41, scope: !2017)
!2019 = !DILocation(line: 1669, column: 25, scope: !2020)
!2020 = distinct !DILexicalBlock(scope: !2017, file: !36, line: 1669, column: 25)
!2021 = !DILocation(line: 1669, column: 45, scope: !2020)
!2022 = !DILocation(line: 1669, column: 25, scope: !2017)
!2023 = !DILocation(line: 1671, column: 62, scope: !2024)
!2024 = distinct !DILexicalBlock(scope: !2020, file: !36, line: 1670, column: 21)
!2025 = !DILocation(line: 1671, column: 36, scope: !2024)
!2026 = !DILocation(line: 1671, column: 34, scope: !2024)
!2027 = !DILocation(line: 1672, column: 21, scope: !2024)
!2028 = !DILocation(line: 1673, column: 17, scope: !2017)
!2029 = !DILocation(line: 1676, column: 20, scope: !1989)
!2030 = !DILocation(line: 1676, column: 13, scope: !1989)
!2031 = distinct !DISubprogram(name: "MPU_xTaskResumeFromISR", scope: !36, file: !36, line: 1684, type: !118, scopeLine: 1685, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2032 = !DILocalVariable(name: "xTaskToResume", arg: 1, scope: !2031, file: !36, line: 1684, type: !32)
!2033 = !DILocation(line: 1684, column: 57, scope: !2031)
!2034 = !DILocalVariable(name: "xReturn", scope: !2031, file: !36, line: 1686, type: !23)
!2035 = !DILocation(line: 1686, column: 24, scope: !2031)
!2036 = !DILocalVariable(name: "lIndex", scope: !2031, file: !36, line: 1687, type: !27)
!2037 = !DILocation(line: 1687, column: 21, scope: !2031)
!2038 = !DILocalVariable(name: "xInternalTaskHandle", scope: !2031, file: !36, line: 1688, type: !32)
!2039 = !DILocation(line: 1688, column: 26, scope: !2031)
!2040 = !DILocation(line: 1690, column: 34, scope: !2031)
!2041 = !DILocation(line: 1690, column: 22, scope: !2031)
!2042 = !DILocation(line: 1690, column: 20, scope: !2031)
!2043 = !DILocation(line: 1692, column: 17, scope: !2044)
!2044 = distinct !DILexicalBlock(scope: !2031, file: !36, line: 1692, column: 17)
!2045 = !DILocation(line: 0, scope: !2044)
!2046 = !DILocation(line: 1692, column: 51, scope: !2044)
!2047 = !DILocation(line: 1692, column: 17, scope: !2031)
!2048 = !DILocation(line: 1694, column: 39, scope: !2049)
!2049 = distinct !DILexicalBlock(scope: !2044, file: !36, line: 1693, column: 13)
!2050 = !DILocation(line: 1694, column: 37, scope: !2049)
!2051 = !DILocation(line: 1696, column: 21, scope: !2052)
!2052 = distinct !DILexicalBlock(scope: !2049, file: !36, line: 1696, column: 21)
!2053 = !DILocation(line: 1696, column: 41, scope: !2052)
!2054 = !DILocation(line: 1696, column: 21, scope: !2049)
!2055 = !DILocation(line: 1698, column: 51, scope: !2056)
!2056 = distinct !DILexicalBlock(scope: !2052, file: !36, line: 1697, column: 17)
!2057 = !DILocation(line: 1698, column: 31, scope: !2056)
!2058 = !DILocation(line: 1698, column: 29, scope: !2056)
!2059 = !DILocation(line: 1699, column: 17, scope: !2056)
!2060 = !DILocation(line: 1700, column: 13, scope: !2049)
!2061 = !DILocation(line: 1702, column: 20, scope: !2031)
!2062 = !DILocation(line: 1702, column: 13, scope: !2031)
!2063 = distinct !DISubprogram(name: "MPU_xTaskGetApplicationTaskTagFromISR", scope: !36, file: !36, line: 1710, type: !658, scopeLine: 1711, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2064 = !DILocalVariable(name: "xTask", arg: 1, scope: !2063, file: !36, line: 1710, type: !32)
!2065 = !DILocation(line: 1710, column: 80, scope: !2063)
!2066 = !DILocalVariable(name: "xReturn", scope: !2063, file: !36, line: 1712, type: !613)
!2067 = !DILocation(line: 1712, column: 32, scope: !2063)
!2068 = !DILocalVariable(name: "lIndex", scope: !2063, file: !36, line: 1713, type: !27)
!2069 = !DILocation(line: 1713, column: 21, scope: !2063)
!2070 = !DILocalVariable(name: "xInternalTaskHandle", scope: !2063, file: !36, line: 1714, type: !32)
!2071 = !DILocation(line: 1714, column: 26, scope: !2063)
!2072 = !DILocation(line: 1716, column: 17, scope: !2073)
!2073 = distinct !DILexicalBlock(scope: !2063, file: !36, line: 1716, column: 17)
!2074 = !DILocation(line: 1716, column: 23, scope: !2073)
!2075 = !DILocation(line: 1716, column: 17, scope: !2063)
!2076 = !DILocation(line: 1718, column: 62, scope: !2077)
!2077 = distinct !DILexicalBlock(scope: !2073, file: !36, line: 1717, column: 13)
!2078 = !DILocation(line: 1718, column: 27, scope: !2077)
!2079 = !DILocation(line: 1718, column: 25, scope: !2077)
!2080 = !DILocation(line: 1719, column: 13, scope: !2077)
!2081 = !DILocation(line: 1722, column: 38, scope: !2082)
!2082 = distinct !DILexicalBlock(scope: !2073, file: !36, line: 1721, column: 13)
!2083 = !DILocation(line: 1722, column: 26, scope: !2082)
!2084 = !DILocation(line: 1722, column: 24, scope: !2082)
!2085 = !DILocation(line: 1724, column: 21, scope: !2086)
!2086 = distinct !DILexicalBlock(scope: !2082, file: !36, line: 1724, column: 21)
!2087 = !DILocation(line: 0, scope: !2086)
!2088 = !DILocation(line: 1724, column: 55, scope: !2086)
!2089 = !DILocation(line: 1724, column: 21, scope: !2082)
!2090 = !DILocation(line: 1726, column: 43, scope: !2091)
!2091 = distinct !DILexicalBlock(scope: !2086, file: !36, line: 1725, column: 17)
!2092 = !DILocation(line: 1726, column: 41, scope: !2091)
!2093 = !DILocation(line: 1728, column: 25, scope: !2094)
!2094 = distinct !DILexicalBlock(scope: !2091, file: !36, line: 1728, column: 25)
!2095 = !DILocation(line: 1728, column: 45, scope: !2094)
!2096 = !DILocation(line: 1728, column: 25, scope: !2091)
!2097 = !DILocation(line: 1730, column: 70, scope: !2098)
!2098 = distinct !DILexicalBlock(scope: !2094, file: !36, line: 1729, column: 21)
!2099 = !DILocation(line: 1730, column: 35, scope: !2098)
!2100 = !DILocation(line: 1730, column: 33, scope: !2098)
!2101 = !DILocation(line: 1731, column: 21, scope: !2098)
!2102 = !DILocation(line: 1732, column: 17, scope: !2091)
!2103 = !DILocation(line: 1735, column: 20, scope: !2063)
!2104 = !DILocation(line: 1735, column: 13, scope: !2063)
!2105 = distinct !DISubprogram(name: "MPU_xTaskGenericNotifyFromISR", scope: !36, file: !36, line: 1743, type: !2106, scopeLine: 1749, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2106 = !DISubroutineType(types: !2107)
!2107 = !{!23, !32, !39, !47, !1080, !799, !2108}
!2108 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
!2109 = !DILocalVariable(name: "xTaskToNotify", arg: 1, scope: !2105, file: !36, line: 1743, type: !32)
!2110 = !DILocation(line: 1743, column: 64, scope: !2105)
!2111 = !DILocalVariable(name: "uxIndexToNotify", arg: 2, scope: !2105, file: !36, line: 1744, type: !39)
!2112 = !DILocation(line: 1744, column: 63, scope: !2105)
!2113 = !DILocalVariable(name: "ulValue", arg: 3, scope: !2105, file: !36, line: 1745, type: !47)
!2114 = !DILocation(line: 1745, column: 60, scope: !2105)
!2115 = !DILocalVariable(name: "eAction", arg: 4, scope: !2105, file: !36, line: 1746, type: !1080)
!2116 = !DILocation(line: 1746, column: 65, scope: !2105)
!2117 = !DILocalVariable(name: "pulPreviousNotificationValue", arg: 5, scope: !2105, file: !36, line: 1747, type: !799)
!2118 = !DILocation(line: 1747, column: 62, scope: !2105)
!2119 = !DILocalVariable(name: "pxHigherPriorityTaskWoken", arg: 6, scope: !2105, file: !36, line: 1748, type: !2108)
!2120 = !DILocation(line: 1748, column: 64, scope: !2105)
!2121 = !DILocalVariable(name: "xReturn", scope: !2105, file: !36, line: 1750, type: !23)
!2122 = !DILocation(line: 1750, column: 24, scope: !2105)
!2123 = !DILocalVariable(name: "lIndex", scope: !2105, file: !36, line: 1751, type: !27)
!2124 = !DILocation(line: 1751, column: 21, scope: !2105)
!2125 = !DILocalVariable(name: "xInternalTaskHandle", scope: !2105, file: !36, line: 1752, type: !32)
!2126 = !DILocation(line: 1752, column: 26, scope: !2105)
!2127 = !DILocation(line: 1754, column: 34, scope: !2105)
!2128 = !DILocation(line: 1754, column: 22, scope: !2105)
!2129 = !DILocation(line: 1754, column: 20, scope: !2105)
!2130 = !DILocation(line: 1756, column: 17, scope: !2131)
!2131 = distinct !DILexicalBlock(scope: !2105, file: !36, line: 1756, column: 17)
!2132 = !DILocation(line: 0, scope: !2131)
!2133 = !DILocation(line: 1756, column: 51, scope: !2131)
!2134 = !DILocation(line: 1756, column: 17, scope: !2105)
!2135 = !DILocation(line: 1758, column: 39, scope: !2136)
!2136 = distinct !DILexicalBlock(scope: !2131, file: !36, line: 1757, column: 13)
!2137 = !DILocation(line: 1758, column: 37, scope: !2136)
!2138 = !DILocation(line: 1760, column: 21, scope: !2139)
!2139 = distinct !DILexicalBlock(scope: !2136, file: !36, line: 1760, column: 21)
!2140 = !DILocation(line: 1760, column: 41, scope: !2139)
!2141 = !DILocation(line: 1760, column: 21, scope: !2136)
!2142 = !DILocation(line: 1762, column: 58, scope: !2143)
!2143 = distinct !DILexicalBlock(scope: !2139, file: !36, line: 1761, column: 17)
!2144 = !DILocation(line: 1762, column: 79, scope: !2143)
!2145 = !DILocation(line: 1762, column: 96, scope: !2143)
!2146 = !DILocation(line: 1762, column: 105, scope: !2143)
!2147 = !DILocation(line: 1762, column: 114, scope: !2143)
!2148 = !DILocation(line: 1762, column: 144, scope: !2143)
!2149 = !DILocation(line: 1762, column: 31, scope: !2143)
!2150 = !DILocation(line: 1762, column: 29, scope: !2143)
!2151 = !DILocation(line: 1763, column: 17, scope: !2143)
!2152 = !DILocation(line: 1764, column: 13, scope: !2136)
!2153 = !DILocation(line: 1766, column: 20, scope: !2105)
!2154 = !DILocation(line: 1766, column: 13, scope: !2105)
!2155 = distinct !DISubprogram(name: "MPU_vTaskGenericNotifyGiveFromISR", scope: !36, file: !36, line: 1774, type: !2156, scopeLine: 1777, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2156 = !DISubroutineType(types: !2157)
!2157 = !{null, !32, !39, !2108}
!2158 = !DILocalVariable(name: "xTaskToNotify", arg: 1, scope: !2155, file: !36, line: 1774, type: !32)
!2159 = !DILocation(line: 1774, column: 62, scope: !2155)
!2160 = !DILocalVariable(name: "uxIndexToNotify", arg: 2, scope: !2155, file: !36, line: 1775, type: !39)
!2161 = !DILocation(line: 1775, column: 61, scope: !2155)
!2162 = !DILocalVariable(name: "pxHigherPriorityTaskWoken", arg: 3, scope: !2155, file: !36, line: 1776, type: !2108)
!2163 = !DILocation(line: 1776, column: 62, scope: !2155)
!2164 = !DILocalVariable(name: "lIndex", scope: !2155, file: !36, line: 1778, type: !27)
!2165 = !DILocation(line: 1778, column: 21, scope: !2155)
!2166 = !DILocalVariable(name: "xInternalTaskHandle", scope: !2155, file: !36, line: 1779, type: !32)
!2167 = !DILocation(line: 1779, column: 26, scope: !2155)
!2168 = !DILocation(line: 1781, column: 34, scope: !2155)
!2169 = !DILocation(line: 1781, column: 22, scope: !2155)
!2170 = !DILocation(line: 1781, column: 20, scope: !2155)
!2171 = !DILocation(line: 1783, column: 17, scope: !2172)
!2172 = distinct !DILexicalBlock(scope: !2155, file: !36, line: 1783, column: 17)
!2173 = !DILocation(line: 0, scope: !2172)
!2174 = !DILocation(line: 1783, column: 51, scope: !2172)
!2175 = !DILocation(line: 1783, column: 17, scope: !2155)
!2176 = !DILocation(line: 1785, column: 39, scope: !2177)
!2177 = distinct !DILexicalBlock(scope: !2172, file: !36, line: 1784, column: 13)
!2178 = !DILocation(line: 1785, column: 37, scope: !2177)
!2179 = !DILocation(line: 1787, column: 21, scope: !2180)
!2180 = distinct !DILexicalBlock(scope: !2177, file: !36, line: 1787, column: 21)
!2181 = !DILocation(line: 1787, column: 41, scope: !2180)
!2182 = !DILocation(line: 1787, column: 21, scope: !2177)
!2183 = !DILocation(line: 1789, column: 52, scope: !2184)
!2184 = distinct !DILexicalBlock(scope: !2180, file: !36, line: 1788, column: 17)
!2185 = !DILocation(line: 1789, column: 73, scope: !2184)
!2186 = !DILocation(line: 1789, column: 90, scope: !2184)
!2187 = !DILocation(line: 1789, column: 21, scope: !2184)
!2188 = !DILocation(line: 1790, column: 17, scope: !2184)
!2189 = !DILocation(line: 1791, column: 13, scope: !2177)
!2190 = !DILocation(line: 1792, column: 9, scope: !2155)
!2191 = distinct !DISubprogram(name: "MPU_xQueueGenericSendImpl", scope: !36, file: !36, line: 1805, type: !2192, scopeLine: 1809, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2192 = !DISubroutineType(types: !2193)
!2193 = !{!23, !41, !2194, !93, !23}
!2194 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2195)
!2195 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2196, size: 64)
!2196 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!2197 = !DILocalVariable(name: "xQueue", arg: 1, scope: !2191, file: !36, line: 1805, type: !41)
!2198 = !DILocation(line: 1805, column: 57, scope: !2191)
!2199 = !DILocalVariable(name: "pvItemToQueue", arg: 2, scope: !2191, file: !36, line: 1806, type: !2194)
!2200 = !DILocation(line: 1806, column: 62, scope: !2191)
!2201 = !DILocalVariable(name: "xTicksToWait", arg: 3, scope: !2191, file: !36, line: 1807, type: !93)
!2202 = !DILocation(line: 1807, column: 54, scope: !2191)
!2203 = !DILocalVariable(name: "xCopyPosition", arg: 4, scope: !2191, file: !36, line: 1808, type: !23)
!2204 = !DILocation(line: 1808, column: 54, scope: !2191)
!2205 = !DILocalVariable(name: "lIndex", scope: !2191, file: !36, line: 1810, type: !27)
!2206 = !DILocation(line: 1810, column: 17, scope: !2191)
!2207 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2191, file: !36, line: 1811, type: !41)
!2208 = !DILocation(line: 1811, column: 23, scope: !2191)
!2209 = !DILocalVariable(name: "xReturn", scope: !2191, file: !36, line: 1812, type: !23)
!2210 = !DILocation(line: 1812, column: 20, scope: !2191)
!2211 = !DILocalVariable(name: "xIsItemToQueueReadable", scope: !2191, file: !36, line: 1813, type: !23)
!2212 = !DILocation(line: 1813, column: 20, scope: !2191)
!2213 = !DILocation(line: 1815, column: 30, scope: !2191)
!2214 = !DILocation(line: 1815, column: 18, scope: !2191)
!2215 = !DILocation(line: 1815, column: 16, scope: !2191)
!2216 = !DILocation(line: 1817, column: 13, scope: !2217)
!2217 = distinct !DILexicalBlock(scope: !2191, file: !36, line: 1817, column: 13)
!2218 = !DILocation(line: 0, scope: !2217)
!2219 = !DILocation(line: 1817, column: 47, scope: !2217)
!2220 = !DILocation(line: 1817, column: 13, scope: !2191)
!2221 = !DILocation(line: 1819, column: 36, scope: !2222)
!2222 = distinct !DILexicalBlock(scope: !2217, file: !36, line: 1818, column: 9)
!2223 = !DILocation(line: 1819, column: 34, scope: !2222)
!2224 = !DILocation(line: 1821, column: 17, scope: !2225)
!2225 = distinct !DILexicalBlock(scope: !2222, file: !36, line: 1821, column: 17)
!2226 = !DILocation(line: 1821, column: 38, scope: !2225)
!2227 = !DILocation(line: 1821, column: 17, scope: !2222)
!2228 = !DILocation(line: 1823, column: 21, scope: !2229)
!2229 = distinct !DILexicalBlock(scope: !2230, file: !36, line: 1823, column: 21)
!2230 = distinct !DILexicalBlock(scope: !2225, file: !36, line: 1822, column: 13)
!2231 = !DILocation(line: 1823, column: 35, scope: !2229)
!2232 = !DILocation(line: 1823, column: 21, scope: !2230)
!2233 = !DILocation(line: 1825, column: 79, scope: !2234)
!2234 = distinct !DILexicalBlock(scope: !2229, file: !36, line: 1824, column: 17)
!2235 = !DILocation(line: 1826, column: 104, scope: !2234)
!2236 = !DILocation(line: 1826, column: 79, scope: !2234)
!2237 = !DILocation(line: 1825, column: 46, scope: !2234)
!2238 = !DILocation(line: 1825, column: 44, scope: !2234)
!2239 = !DILocation(line: 1828, column: 17, scope: !2234)
!2240 = !DILocation(line: 1830, column: 23, scope: !2241)
!2241 = distinct !DILexicalBlock(scope: !2230, file: !36, line: 1830, column: 21)
!2242 = !DILocation(line: 1830, column: 37, scope: !2241)
!2243 = !DILocation(line: 1830, column: 47, scope: !2241)
!2244 = !DILocation(line: 1830, column: 52, scope: !2241)
!2245 = !DILocation(line: 1830, column: 75, scope: !2241)
!2246 = !DILocation(line: 1830, column: 21, scope: !2230)
!2247 = !DILocation(line: 1832, column: 50, scope: !2248)
!2248 = distinct !DILexicalBlock(scope: !2241, file: !36, line: 1831, column: 17)
!2249 = !DILocation(line: 1832, column: 72, scope: !2248)
!2250 = !DILocation(line: 1832, column: 87, scope: !2248)
!2251 = !DILocation(line: 1832, column: 101, scope: !2248)
!2252 = !DILocation(line: 1832, column: 31, scope: !2248)
!2253 = !DILocation(line: 1832, column: 29, scope: !2248)
!2254 = !DILocation(line: 1833, column: 17, scope: !2248)
!2255 = !DILocation(line: 1834, column: 13, scope: !2230)
!2256 = !DILocation(line: 1835, column: 9, scope: !2222)
!2257 = !DILocation(line: 1837, column: 16, scope: !2191)
!2258 = !DILocation(line: 1837, column: 9, scope: !2191)
!2259 = distinct !DISubprogram(name: "MPU_uxQueueMessagesWaitingImpl", scope: !36, file: !36, line: 1843, type: !2260, scopeLine: 1844, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2260 = !DISubroutineType(types: !2261)
!2261 = !{!39, !2262}
!2262 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !41)
!2263 = !DILocalVariable(name: "pxQueue", arg: 1, scope: !2259, file: !36, line: 1843, type: !2262)
!2264 = !DILocation(line: 1843, column: 69, scope: !2259)
!2265 = !DILocalVariable(name: "lIndex", scope: !2259, file: !36, line: 1845, type: !27)
!2266 = !DILocation(line: 1845, column: 17, scope: !2259)
!2267 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2259, file: !36, line: 1846, type: !41)
!2268 = !DILocation(line: 1846, column: 23, scope: !2259)
!2269 = !DILocalVariable(name: "uxReturn", scope: !2259, file: !36, line: 1847, type: !39)
!2270 = !DILocation(line: 1847, column: 21, scope: !2259)
!2271 = !DILocation(line: 1849, column: 30, scope: !2259)
!2272 = !DILocation(line: 1849, column: 18, scope: !2259)
!2273 = !DILocation(line: 1849, column: 16, scope: !2259)
!2274 = !DILocation(line: 1851, column: 13, scope: !2275)
!2275 = distinct !DILexicalBlock(scope: !2259, file: !36, line: 1851, column: 13)
!2276 = !DILocation(line: 0, scope: !2275)
!2277 = !DILocation(line: 1851, column: 47, scope: !2275)
!2278 = !DILocation(line: 1851, column: 13, scope: !2259)
!2279 = !DILocation(line: 1853, column: 36, scope: !2280)
!2280 = distinct !DILexicalBlock(scope: !2275, file: !36, line: 1852, column: 9)
!2281 = !DILocation(line: 1853, column: 34, scope: !2280)
!2282 = !DILocation(line: 1855, column: 17, scope: !2283)
!2283 = distinct !DILexicalBlock(scope: !2280, file: !36, line: 1855, column: 17)
!2284 = !DILocation(line: 1855, column: 38, scope: !2283)
!2285 = !DILocation(line: 1855, column: 17, scope: !2280)
!2286 = !DILocation(line: 1857, column: 52, scope: !2287)
!2287 = distinct !DILexicalBlock(scope: !2283, file: !36, line: 1856, column: 13)
!2288 = !DILocation(line: 1857, column: 28, scope: !2287)
!2289 = !DILocation(line: 1857, column: 26, scope: !2287)
!2290 = !DILocation(line: 1858, column: 13, scope: !2287)
!2291 = !DILocation(line: 1859, column: 9, scope: !2280)
!2292 = !DILocation(line: 1861, column: 16, scope: !2259)
!2293 = !DILocation(line: 1861, column: 9, scope: !2259)
!2294 = distinct !DISubprogram(name: "MPU_uxQueueSpacesAvailableImpl", scope: !36, file: !36, line: 1867, type: !2260, scopeLine: 1868, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2295 = !DILocalVariable(name: "xQueue", arg: 1, scope: !2294, file: !36, line: 1867, type: !2262)
!2296 = !DILocation(line: 1867, column: 69, scope: !2294)
!2297 = !DILocalVariable(name: "lIndex", scope: !2294, file: !36, line: 1869, type: !27)
!2298 = !DILocation(line: 1869, column: 17, scope: !2294)
!2299 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2294, file: !36, line: 1870, type: !41)
!2300 = !DILocation(line: 1870, column: 23, scope: !2294)
!2301 = !DILocalVariable(name: "uxReturn", scope: !2294, file: !36, line: 1871, type: !39)
!2302 = !DILocation(line: 1871, column: 21, scope: !2294)
!2303 = !DILocation(line: 1873, column: 30, scope: !2294)
!2304 = !DILocation(line: 1873, column: 18, scope: !2294)
!2305 = !DILocation(line: 1873, column: 16, scope: !2294)
!2306 = !DILocation(line: 1875, column: 13, scope: !2307)
!2307 = distinct !DILexicalBlock(scope: !2294, file: !36, line: 1875, column: 13)
!2308 = !DILocation(line: 0, scope: !2307)
!2309 = !DILocation(line: 1875, column: 47, scope: !2307)
!2310 = !DILocation(line: 1875, column: 13, scope: !2294)
!2311 = !DILocation(line: 1877, column: 36, scope: !2312)
!2312 = distinct !DILexicalBlock(scope: !2307, file: !36, line: 1876, column: 9)
!2313 = !DILocation(line: 1877, column: 34, scope: !2312)
!2314 = !DILocation(line: 1879, column: 17, scope: !2315)
!2315 = distinct !DILexicalBlock(scope: !2312, file: !36, line: 1879, column: 17)
!2316 = !DILocation(line: 1879, column: 38, scope: !2315)
!2317 = !DILocation(line: 1879, column: 17, scope: !2312)
!2318 = !DILocation(line: 1881, column: 52, scope: !2319)
!2319 = distinct !DILexicalBlock(scope: !2315, file: !36, line: 1880, column: 13)
!2320 = !DILocation(line: 1881, column: 28, scope: !2319)
!2321 = !DILocation(line: 1881, column: 26, scope: !2319)
!2322 = !DILocation(line: 1882, column: 13, scope: !2319)
!2323 = !DILocation(line: 1883, column: 9, scope: !2312)
!2324 = !DILocation(line: 1885, column: 16, scope: !2294)
!2325 = !DILocation(line: 1885, column: 9, scope: !2294)
!2326 = distinct !DISubprogram(name: "MPU_xQueueReceiveImpl", scope: !36, file: !36, line: 1893, type: !2327, scopeLine: 1896, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2327 = !DISubroutineType(types: !2328)
!2328 = !{!23, !41, !1480, !93}
!2329 = !DILocalVariable(name: "pxQueue", arg: 1, scope: !2326, file: !36, line: 1893, type: !41)
!2330 = !DILocation(line: 1893, column: 53, scope: !2326)
!2331 = !DILocalVariable(name: "pvBuffer", arg: 2, scope: !2326, file: !36, line: 1894, type: !1480)
!2332 = !DILocation(line: 1894, column: 52, scope: !2326)
!2333 = !DILocalVariable(name: "xTicksToWait", arg: 3, scope: !2326, file: !36, line: 1895, type: !93)
!2334 = !DILocation(line: 1895, column: 50, scope: !2326)
!2335 = !DILocalVariable(name: "lIndex", scope: !2326, file: !36, line: 1897, type: !27)
!2336 = !DILocation(line: 1897, column: 17, scope: !2326)
!2337 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2326, file: !36, line: 1898, type: !41)
!2338 = !DILocation(line: 1898, column: 23, scope: !2326)
!2339 = !DILocalVariable(name: "xReturn", scope: !2326, file: !36, line: 1899, type: !23)
!2340 = !DILocation(line: 1899, column: 20, scope: !2326)
!2341 = !DILocalVariable(name: "xIsReceiveBufferWritable", scope: !2326, file: !36, line: 1900, type: !23)
!2342 = !DILocation(line: 1900, column: 20, scope: !2326)
!2343 = !DILocation(line: 1902, column: 30, scope: !2326)
!2344 = !DILocation(line: 1902, column: 18, scope: !2326)
!2345 = !DILocation(line: 1902, column: 16, scope: !2326)
!2346 = !DILocation(line: 1904, column: 13, scope: !2347)
!2347 = distinct !DILexicalBlock(scope: !2326, file: !36, line: 1904, column: 13)
!2348 = !DILocation(line: 0, scope: !2347)
!2349 = !DILocation(line: 1904, column: 47, scope: !2347)
!2350 = !DILocation(line: 1904, column: 13, scope: !2326)
!2351 = !DILocation(line: 1906, column: 36, scope: !2352)
!2352 = distinct !DILexicalBlock(scope: !2347, file: !36, line: 1905, column: 9)
!2353 = !DILocation(line: 1906, column: 34, scope: !2352)
!2354 = !DILocation(line: 1908, column: 17, scope: !2355)
!2355 = distinct !DILexicalBlock(scope: !2352, file: !36, line: 1908, column: 17)
!2356 = !DILocation(line: 1908, column: 38, scope: !2355)
!2357 = !DILocation(line: 1908, column: 17, scope: !2352)
!2358 = !DILocation(line: 1910, column: 77, scope: !2359)
!2359 = distinct !DILexicalBlock(scope: !2355, file: !36, line: 1909, column: 13)
!2360 = !DILocation(line: 1911, column: 102, scope: !2359)
!2361 = !DILocation(line: 1911, column: 77, scope: !2359)
!2362 = !DILocation(line: 1910, column: 44, scope: !2359)
!2363 = !DILocation(line: 1910, column: 42, scope: !2359)
!2364 = !DILocation(line: 1914, column: 21, scope: !2365)
!2365 = distinct !DILexicalBlock(scope: !2359, file: !36, line: 1914, column: 21)
!2366 = !DILocation(line: 1914, column: 46, scope: !2365)
!2367 = !DILocation(line: 1914, column: 21, scope: !2359)
!2368 = !DILocation(line: 1916, column: 46, scope: !2369)
!2369 = distinct !DILexicalBlock(scope: !2365, file: !36, line: 1915, column: 17)
!2370 = !DILocation(line: 1916, column: 68, scope: !2369)
!2371 = !DILocation(line: 1916, column: 78, scope: !2369)
!2372 = !DILocation(line: 1916, column: 31, scope: !2369)
!2373 = !DILocation(line: 1916, column: 29, scope: !2369)
!2374 = !DILocation(line: 1917, column: 17, scope: !2369)
!2375 = !DILocation(line: 1918, column: 13, scope: !2359)
!2376 = !DILocation(line: 1919, column: 9, scope: !2352)
!2377 = !DILocation(line: 1921, column: 16, scope: !2326)
!2378 = !DILocation(line: 1921, column: 9, scope: !2326)
!2379 = distinct !DISubprogram(name: "MPU_xQueuePeekImpl", scope: !36, file: !36, line: 1929, type: !2327, scopeLine: 1932, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2380 = !DILocalVariable(name: "xQueue", arg: 1, scope: !2379, file: !36, line: 1929, type: !41)
!2381 = !DILocation(line: 1929, column: 50, scope: !2379)
!2382 = !DILocalVariable(name: "pvBuffer", arg: 2, scope: !2379, file: !36, line: 1930, type: !1480)
!2383 = !DILocation(line: 1930, column: 49, scope: !2379)
!2384 = !DILocalVariable(name: "xTicksToWait", arg: 3, scope: !2379, file: !36, line: 1931, type: !93)
!2385 = !DILocation(line: 1931, column: 47, scope: !2379)
!2386 = !DILocalVariable(name: "lIndex", scope: !2379, file: !36, line: 1933, type: !27)
!2387 = !DILocation(line: 1933, column: 17, scope: !2379)
!2388 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2379, file: !36, line: 1934, type: !41)
!2389 = !DILocation(line: 1934, column: 23, scope: !2379)
!2390 = !DILocalVariable(name: "xReturn", scope: !2379, file: !36, line: 1935, type: !23)
!2391 = !DILocation(line: 1935, column: 20, scope: !2379)
!2392 = !DILocalVariable(name: "xIsReceiveBufferWritable", scope: !2379, file: !36, line: 1936, type: !23)
!2393 = !DILocation(line: 1936, column: 20, scope: !2379)
!2394 = !DILocation(line: 1938, column: 30, scope: !2379)
!2395 = !DILocation(line: 1938, column: 18, scope: !2379)
!2396 = !DILocation(line: 1938, column: 16, scope: !2379)
!2397 = !DILocation(line: 1940, column: 13, scope: !2398)
!2398 = distinct !DILexicalBlock(scope: !2379, file: !36, line: 1940, column: 13)
!2399 = !DILocation(line: 0, scope: !2398)
!2400 = !DILocation(line: 1940, column: 47, scope: !2398)
!2401 = !DILocation(line: 1940, column: 13, scope: !2379)
!2402 = !DILocation(line: 1942, column: 36, scope: !2403)
!2403 = distinct !DILexicalBlock(scope: !2398, file: !36, line: 1941, column: 9)
!2404 = !DILocation(line: 1942, column: 34, scope: !2403)
!2405 = !DILocation(line: 1944, column: 17, scope: !2406)
!2406 = distinct !DILexicalBlock(scope: !2403, file: !36, line: 1944, column: 17)
!2407 = !DILocation(line: 1944, column: 38, scope: !2406)
!2408 = !DILocation(line: 1944, column: 17, scope: !2403)
!2409 = !DILocation(line: 1946, column: 77, scope: !2410)
!2410 = distinct !DILexicalBlock(scope: !2406, file: !36, line: 1945, column: 13)
!2411 = !DILocation(line: 1947, column: 102, scope: !2410)
!2412 = !DILocation(line: 1947, column: 77, scope: !2410)
!2413 = !DILocation(line: 1946, column: 44, scope: !2410)
!2414 = !DILocation(line: 1946, column: 42, scope: !2410)
!2415 = !DILocation(line: 1950, column: 21, scope: !2416)
!2416 = distinct !DILexicalBlock(scope: !2410, file: !36, line: 1950, column: 21)
!2417 = !DILocation(line: 1950, column: 46, scope: !2416)
!2418 = !DILocation(line: 1950, column: 21, scope: !2410)
!2419 = !DILocation(line: 1952, column: 43, scope: !2420)
!2420 = distinct !DILexicalBlock(scope: !2416, file: !36, line: 1951, column: 17)
!2421 = !DILocation(line: 1952, column: 65, scope: !2420)
!2422 = !DILocation(line: 1952, column: 75, scope: !2420)
!2423 = !DILocation(line: 1952, column: 31, scope: !2420)
!2424 = !DILocation(line: 1952, column: 29, scope: !2420)
!2425 = !DILocation(line: 1953, column: 17, scope: !2420)
!2426 = !DILocation(line: 1954, column: 13, scope: !2410)
!2427 = !DILocation(line: 1955, column: 9, scope: !2403)
!2428 = !DILocation(line: 1957, column: 16, scope: !2379)
!2429 = !DILocation(line: 1957, column: 9, scope: !2379)
!2430 = distinct !DISubprogram(name: "MPU_xQueueSemaphoreTakeImpl", scope: !36, file: !36, line: 1964, type: !2431, scopeLine: 1966, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2431 = !DISubroutineType(types: !2432)
!2432 = !{!23, !41, !93}
!2433 = !DILocalVariable(name: "xQueue", arg: 1, scope: !2430, file: !36, line: 1964, type: !41)
!2434 = !DILocation(line: 1964, column: 59, scope: !2430)
!2435 = !DILocalVariable(name: "xTicksToWait", arg: 2, scope: !2430, file: !36, line: 1965, type: !93)
!2436 = !DILocation(line: 1965, column: 56, scope: !2430)
!2437 = !DILocalVariable(name: "lIndex", scope: !2430, file: !36, line: 1967, type: !27)
!2438 = !DILocation(line: 1967, column: 17, scope: !2430)
!2439 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2430, file: !36, line: 1968, type: !41)
!2440 = !DILocation(line: 1968, column: 23, scope: !2430)
!2441 = !DILocalVariable(name: "xReturn", scope: !2430, file: !36, line: 1969, type: !23)
!2442 = !DILocation(line: 1969, column: 20, scope: !2430)
!2443 = !DILocation(line: 1971, column: 30, scope: !2430)
!2444 = !DILocation(line: 1971, column: 18, scope: !2430)
!2445 = !DILocation(line: 1971, column: 16, scope: !2430)
!2446 = !DILocation(line: 1973, column: 13, scope: !2447)
!2447 = distinct !DILexicalBlock(scope: !2430, file: !36, line: 1973, column: 13)
!2448 = !DILocation(line: 0, scope: !2447)
!2449 = !DILocation(line: 1973, column: 47, scope: !2447)
!2450 = !DILocation(line: 1973, column: 13, scope: !2430)
!2451 = !DILocation(line: 1975, column: 36, scope: !2452)
!2452 = distinct !DILexicalBlock(scope: !2447, file: !36, line: 1974, column: 9)
!2453 = !DILocation(line: 1975, column: 34, scope: !2452)
!2454 = !DILocation(line: 1977, column: 17, scope: !2455)
!2455 = distinct !DILexicalBlock(scope: !2452, file: !36, line: 1977, column: 17)
!2456 = !DILocation(line: 1977, column: 38, scope: !2455)
!2457 = !DILocation(line: 1977, column: 17, scope: !2452)
!2458 = !DILocation(line: 1979, column: 48, scope: !2459)
!2459 = distinct !DILexicalBlock(scope: !2455, file: !36, line: 1978, column: 13)
!2460 = !DILocation(line: 1979, column: 70, scope: !2459)
!2461 = !DILocation(line: 1979, column: 27, scope: !2459)
!2462 = !DILocation(line: 1979, column: 25, scope: !2459)
!2463 = !DILocation(line: 1980, column: 13, scope: !2459)
!2464 = !DILocation(line: 1981, column: 9, scope: !2452)
!2465 = !DILocation(line: 1983, column: 16, scope: !2430)
!2466 = !DILocation(line: 1983, column: 9, scope: !2430)
!2467 = distinct !DISubprogram(name: "MPU_xQueueSelectFromSetImpl", scope: !36, file: !36, line: 2090, type: !2468, scopeLine: 2092, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2468 = !DISubroutineType(types: !2469)
!2469 = !{!46, !45, !93}
!2470 = !DILocalVariable(name: "xQueueSet", arg: 1, scope: !2467, file: !36, line: 2090, type: !45)
!2471 = !DILocation(line: 2090, column: 78, scope: !2467)
!2472 = !DILocalVariable(name: "xBlockTimeTicks", arg: 2, scope: !2467, file: !36, line: 2091, type: !93)
!2473 = !DILocation(line: 2091, column: 72, scope: !2467)
!2474 = !DILocalVariable(name: "xInternalQueueSetHandle", scope: !2467, file: !36, line: 2093, type: !45)
!2475 = !DILocation(line: 2093, column: 30, scope: !2467)
!2476 = !DILocalVariable(name: "xSelectedMemberInternal", scope: !2467, file: !36, line: 2094, type: !46)
!2477 = !DILocation(line: 2094, column: 36, scope: !2467)
!2478 = !DILocalVariable(name: "xSelectedMemberExternal", scope: !2467, file: !36, line: 2095, type: !46)
!2479 = !DILocation(line: 2095, column: 36, scope: !2467)
!2480 = !DILocalVariable(name: "lIndexQueueSet", scope: !2467, file: !36, line: 2096, type: !27)
!2481 = !DILocation(line: 2096, column: 21, scope: !2467)
!2482 = !DILocalVariable(name: "lIndexSelectedMember", scope: !2467, file: !36, line: 2096, type: !27)
!2483 = !DILocation(line: 2096, column: 37, scope: !2467)
!2484 = !DILocation(line: 2098, column: 42, scope: !2467)
!2485 = !DILocation(line: 2098, column: 30, scope: !2467)
!2486 = !DILocation(line: 2098, column: 28, scope: !2467)
!2487 = !DILocation(line: 2100, column: 17, scope: !2488)
!2488 = distinct !DILexicalBlock(scope: !2467, file: !36, line: 2100, column: 17)
!2489 = !DILocation(line: 0, scope: !2488)
!2490 = !DILocation(line: 2100, column: 59, scope: !2488)
!2491 = !DILocation(line: 2100, column: 17, scope: !2467)
!2492 = !DILocation(line: 2102, column: 43, scope: !2493)
!2493 = distinct !DILexicalBlock(scope: !2488, file: !36, line: 2101, column: 13)
!2494 = !DILocation(line: 2102, column: 41, scope: !2493)
!2495 = !DILocation(line: 2104, column: 21, scope: !2496)
!2496 = distinct !DILexicalBlock(scope: !2493, file: !36, line: 2104, column: 21)
!2497 = !DILocation(line: 2104, column: 45, scope: !2496)
!2498 = !DILocation(line: 2104, column: 21, scope: !2493)
!2499 = !DILocation(line: 2106, column: 68, scope: !2500)
!2500 = distinct !DILexicalBlock(scope: !2496, file: !36, line: 2105, column: 17)
!2501 = !DILocation(line: 2106, column: 93, scope: !2500)
!2502 = !DILocation(line: 2106, column: 47, scope: !2500)
!2503 = !DILocation(line: 2106, column: 45, scope: !2500)
!2504 = !DILocation(line: 2108, column: 25, scope: !2505)
!2505 = distinct !DILexicalBlock(scope: !2500, file: !36, line: 2108, column: 25)
!2506 = !DILocation(line: 2108, column: 49, scope: !2505)
!2507 = !DILocation(line: 2108, column: 25, scope: !2500)
!2508 = !DILocation(line: 2110, column: 48, scope: !2509)
!2509 = distinct !DILexicalBlock(scope: !2505, file: !36, line: 2109, column: 21)
!2510 = !DILocation(line: 2110, column: 46, scope: !2509)
!2511 = !DILocation(line: 2112, column: 29, scope: !2512)
!2512 = distinct !DILexicalBlock(scope: !2509, file: !36, line: 2112, column: 29)
!2513 = !DILocation(line: 2112, column: 50, scope: !2512)
!2514 = !DILocation(line: 2112, column: 29, scope: !2509)
!2515 = !DILocation(line: 2114, column: 84, scope: !2516)
!2516 = distinct !DILexicalBlock(scope: !2512, file: !36, line: 2113, column: 25)
!2517 = !DILocation(line: 2114, column: 55, scope: !2516)
!2518 = !DILocation(line: 2114, column: 53, scope: !2516)
!2519 = !DILocation(line: 2115, column: 25, scope: !2516)
!2520 = !DILocation(line: 2116, column: 21, scope: !2509)
!2521 = !DILocation(line: 2117, column: 17, scope: !2500)
!2522 = !DILocation(line: 2118, column: 13, scope: !2493)
!2523 = !DILocation(line: 2120, column: 20, scope: !2467)
!2524 = !DILocation(line: 2120, column: 13, scope: !2467)
!2525 = distinct !DISubprogram(name: "MPU_xQueueAddToSetImpl", scope: !36, file: !36, line: 2131, type: !2526, scopeLine: 2133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2526 = !DISubroutineType(types: !2527)
!2527 = !{!23, !46, !45}
!2528 = !DILocalVariable(name: "xQueueOrSemaphore", arg: 1, scope: !2525, file: !36, line: 2131, type: !46)
!2529 = !DILocation(line: 2131, column: 67, scope: !2525)
!2530 = !DILocalVariable(name: "xQueueSet", arg: 2, scope: !2525, file: !36, line: 2132, type: !45)
!2531 = !DILocation(line: 2132, column: 61, scope: !2525)
!2532 = !DILocalVariable(name: "xReturn", scope: !2525, file: !36, line: 2134, type: !23)
!2533 = !DILocation(line: 2134, column: 24, scope: !2525)
!2534 = !DILocalVariable(name: "xInternalQueueSetMemberHandle", scope: !2525, file: !36, line: 2135, type: !46)
!2535 = !DILocation(line: 2135, column: 36, scope: !2525)
!2536 = !DILocalVariable(name: "xInternalQueueSetHandle", scope: !2525, file: !36, line: 2136, type: !45)
!2537 = !DILocation(line: 2136, column: 30, scope: !2525)
!2538 = !DILocalVariable(name: "lIndexQueueSet", scope: !2525, file: !36, line: 2137, type: !27)
!2539 = !DILocation(line: 2137, column: 21, scope: !2525)
!2540 = !DILocalVariable(name: "lIndexQueueSetMember", scope: !2525, file: !36, line: 2137, type: !27)
!2541 = !DILocation(line: 2137, column: 37, scope: !2525)
!2542 = !DILocation(line: 2139, column: 42, scope: !2525)
!2543 = !DILocation(line: 2139, column: 30, scope: !2525)
!2544 = !DILocation(line: 2139, column: 28, scope: !2525)
!2545 = !DILocation(line: 2140, column: 48, scope: !2525)
!2546 = !DILocation(line: 2140, column: 36, scope: !2525)
!2547 = !DILocation(line: 2140, column: 34, scope: !2525)
!2548 = !DILocation(line: 2142, column: 19, scope: !2549)
!2549 = distinct !DILexicalBlock(scope: !2525, file: !36, line: 2142, column: 17)
!2550 = !DILocation(line: 0, scope: !2549)
!2551 = !DILocation(line: 2142, column: 61, scope: !2549)
!2552 = !DILocation(line: 2142, column: 74, scope: !2549)
!2553 = !DILocation(line: 2143, column: 19, scope: !2549)
!2554 = !DILocation(line: 2143, column: 67, scope: !2549)
!2555 = !DILocation(line: 2142, column: 17, scope: !2525)
!2556 = !DILocation(line: 2145, column: 43, scope: !2557)
!2557 = distinct !DILexicalBlock(scope: !2549, file: !36, line: 2144, column: 13)
!2558 = !DILocation(line: 2145, column: 41, scope: !2557)
!2559 = !DILocation(line: 2146, column: 49, scope: !2557)
!2560 = !DILocation(line: 2146, column: 47, scope: !2557)
!2561 = !DILocation(line: 2148, column: 23, scope: !2562)
!2562 = distinct !DILexicalBlock(scope: !2557, file: !36, line: 2148, column: 21)
!2563 = !DILocation(line: 2148, column: 47, scope: !2562)
!2564 = !DILocation(line: 2148, column: 57, scope: !2562)
!2565 = !DILocation(line: 2148, column: 62, scope: !2562)
!2566 = !DILocation(line: 2148, column: 92, scope: !2562)
!2567 = !DILocation(line: 2148, column: 21, scope: !2557)
!2568 = !DILocation(line: 2150, column: 47, scope: !2569)
!2569 = distinct !DILexicalBlock(scope: !2562, file: !36, line: 2149, column: 17)
!2570 = !DILocation(line: 2150, column: 78, scope: !2569)
!2571 = !DILocation(line: 2150, column: 31, scope: !2569)
!2572 = !DILocation(line: 2150, column: 29, scope: !2569)
!2573 = !DILocation(line: 2151, column: 17, scope: !2569)
!2574 = !DILocation(line: 2152, column: 13, scope: !2557)
!2575 = !DILocation(line: 2154, column: 20, scope: !2525)
!2576 = !DILocation(line: 2154, column: 13, scope: !2525)
!2577 = distinct !DISubprogram(name: "MPU_vQueueAddToRegistryImpl", scope: !36, file: !36, line: 2165, type: !2578, scopeLine: 2167, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2578 = !DISubroutineType(types: !2579)
!2579 = !{null, !41, !286}
!2580 = !DILocalVariable(name: "xQueue", arg: 1, scope: !2577, file: !36, line: 2165, type: !41)
!2581 = !DILocation(line: 2165, column: 57, scope: !2577)
!2582 = !DILocalVariable(name: "pcName", arg: 2, scope: !2577, file: !36, line: 2166, type: !286)
!2583 = !DILocation(line: 2166, column: 56, scope: !2577)
!2584 = !DILocalVariable(name: "lIndex", scope: !2577, file: !36, line: 2168, type: !27)
!2585 = !DILocation(line: 2168, column: 21, scope: !2577)
!2586 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2577, file: !36, line: 2169, type: !41)
!2587 = !DILocation(line: 2169, column: 27, scope: !2577)
!2588 = !DILocation(line: 2171, column: 34, scope: !2577)
!2589 = !DILocation(line: 2171, column: 22, scope: !2577)
!2590 = !DILocation(line: 2171, column: 20, scope: !2577)
!2591 = !DILocation(line: 2173, column: 17, scope: !2592)
!2592 = distinct !DILexicalBlock(scope: !2577, file: !36, line: 2173, column: 17)
!2593 = !DILocation(line: 0, scope: !2592)
!2594 = !DILocation(line: 2173, column: 51, scope: !2592)
!2595 = !DILocation(line: 2173, column: 17, scope: !2577)
!2596 = !DILocation(line: 2175, column: 40, scope: !2597)
!2597 = distinct !DILexicalBlock(scope: !2592, file: !36, line: 2174, column: 13)
!2598 = !DILocation(line: 2175, column: 38, scope: !2597)
!2599 = !DILocation(line: 2177, column: 21, scope: !2600)
!2600 = distinct !DILexicalBlock(scope: !2597, file: !36, line: 2177, column: 21)
!2601 = !DILocation(line: 2177, column: 42, scope: !2600)
!2602 = !DILocation(line: 2177, column: 21, scope: !2597)
!2603 = !DILocation(line: 2179, column: 42, scope: !2604)
!2604 = distinct !DILexicalBlock(scope: !2600, file: !36, line: 2178, column: 17)
!2605 = !DILocation(line: 2179, column: 64, scope: !2604)
!2606 = !DILocation(line: 2179, column: 21, scope: !2604)
!2607 = !DILocation(line: 2180, column: 17, scope: !2604)
!2608 = !DILocation(line: 2181, column: 13, scope: !2597)
!2609 = !DILocation(line: 2182, column: 9, scope: !2577)
!2610 = distinct !DISubprogram(name: "MPU_vQueueUnregisterQueueImpl", scope: !36, file: !36, line: 2191, type: !2611, scopeLine: 2192, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2611 = !DISubroutineType(types: !2612)
!2612 = !{null, !41}
!2613 = !DILocalVariable(name: "xQueue", arg: 1, scope: !2610, file: !36, line: 2191, type: !41)
!2614 = !DILocation(line: 2191, column: 59, scope: !2610)
!2615 = !DILocalVariable(name: "lIndex", scope: !2610, file: !36, line: 2193, type: !27)
!2616 = !DILocation(line: 2193, column: 21, scope: !2610)
!2617 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2610, file: !36, line: 2194, type: !41)
!2618 = !DILocation(line: 2194, column: 27, scope: !2610)
!2619 = !DILocation(line: 2196, column: 34, scope: !2610)
!2620 = !DILocation(line: 2196, column: 22, scope: !2610)
!2621 = !DILocation(line: 2196, column: 20, scope: !2610)
!2622 = !DILocation(line: 2198, column: 17, scope: !2623)
!2623 = distinct !DILexicalBlock(scope: !2610, file: !36, line: 2198, column: 17)
!2624 = !DILocation(line: 0, scope: !2623)
!2625 = !DILocation(line: 2198, column: 51, scope: !2623)
!2626 = !DILocation(line: 2198, column: 17, scope: !2610)
!2627 = !DILocation(line: 2200, column: 40, scope: !2628)
!2628 = distinct !DILexicalBlock(scope: !2623, file: !36, line: 2199, column: 13)
!2629 = !DILocation(line: 2200, column: 38, scope: !2628)
!2630 = !DILocation(line: 2202, column: 21, scope: !2631)
!2631 = distinct !DILexicalBlock(scope: !2628, file: !36, line: 2202, column: 21)
!2632 = !DILocation(line: 2202, column: 42, scope: !2631)
!2633 = !DILocation(line: 2202, column: 21, scope: !2628)
!2634 = !DILocation(line: 2204, column: 44, scope: !2635)
!2635 = distinct !DILexicalBlock(scope: !2631, file: !36, line: 2203, column: 17)
!2636 = !DILocation(line: 2204, column: 21, scope: !2635)
!2637 = !DILocation(line: 2205, column: 17, scope: !2635)
!2638 = !DILocation(line: 2206, column: 13, scope: !2628)
!2639 = !DILocation(line: 2207, column: 9, scope: !2610)
!2640 = distinct !DISubprogram(name: "MPU_pcQueueGetNameImpl", scope: !36, file: !36, line: 2216, type: !2641, scopeLine: 2217, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2641 = !DISubroutineType(types: !2642)
!2642 = !{!286, !41}
!2643 = !DILocalVariable(name: "xQueue", arg: 1, scope: !2640, file: !36, line: 2216, type: !41)
!2644 = !DILocation(line: 2216, column: 60, scope: !2640)
!2645 = !DILocalVariable(name: "pcReturn", scope: !2640, file: !36, line: 2218, type: !286)
!2646 = !DILocation(line: 2218, column: 26, scope: !2640)
!2647 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2640, file: !36, line: 2219, type: !41)
!2648 = !DILocation(line: 2219, column: 27, scope: !2640)
!2649 = !DILocalVariable(name: "lIndex", scope: !2640, file: !36, line: 2220, type: !27)
!2650 = !DILocation(line: 2220, column: 21, scope: !2640)
!2651 = !DILocation(line: 2222, column: 34, scope: !2640)
!2652 = !DILocation(line: 2222, column: 22, scope: !2640)
!2653 = !DILocation(line: 2222, column: 20, scope: !2640)
!2654 = !DILocation(line: 2224, column: 17, scope: !2655)
!2655 = distinct !DILexicalBlock(scope: !2640, file: !36, line: 2224, column: 17)
!2656 = !DILocation(line: 0, scope: !2655)
!2657 = !DILocation(line: 2224, column: 51, scope: !2655)
!2658 = !DILocation(line: 2224, column: 17, scope: !2640)
!2659 = !DILocation(line: 2226, column: 40, scope: !2660)
!2660 = distinct !DILexicalBlock(scope: !2655, file: !36, line: 2225, column: 13)
!2661 = !DILocation(line: 2226, column: 38, scope: !2660)
!2662 = !DILocation(line: 2228, column: 21, scope: !2663)
!2663 = distinct !DILexicalBlock(scope: !2660, file: !36, line: 2228, column: 21)
!2664 = !DILocation(line: 2228, column: 42, scope: !2663)
!2665 = !DILocation(line: 2228, column: 21, scope: !2660)
!2666 = !DILocation(line: 2230, column: 48, scope: !2667)
!2667 = distinct !DILexicalBlock(scope: !2663, file: !36, line: 2229, column: 17)
!2668 = !DILocation(line: 2230, column: 32, scope: !2667)
!2669 = !DILocation(line: 2230, column: 30, scope: !2667)
!2670 = !DILocation(line: 2231, column: 17, scope: !2667)
!2671 = !DILocation(line: 2232, column: 13, scope: !2660)
!2672 = !DILocation(line: 2234, column: 20, scope: !2640)
!2673 = !DILocation(line: 2234, column: 13, scope: !2640)
!2674 = distinct !DISubprogram(name: "MPU_vQueueDelete", scope: !36, file: !36, line: 2245, type: !2611, scopeLine: 2246, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2675 = !DILocalVariable(name: "xQueue", arg: 1, scope: !2674, file: !36, line: 2245, type: !41)
!2676 = !DILocation(line: 2245, column: 42, scope: !2674)
!2677 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2674, file: !36, line: 2247, type: !41)
!2678 = !DILocation(line: 2247, column: 23, scope: !2674)
!2679 = !DILocalVariable(name: "lIndex", scope: !2674, file: !36, line: 2248, type: !27)
!2680 = !DILocation(line: 2248, column: 17, scope: !2674)
!2681 = !DILocation(line: 2250, column: 30, scope: !2674)
!2682 = !DILocation(line: 2250, column: 18, scope: !2674)
!2683 = !DILocation(line: 2250, column: 16, scope: !2674)
!2684 = !DILocation(line: 2252, column: 13, scope: !2685)
!2685 = distinct !DILexicalBlock(scope: !2674, file: !36, line: 2252, column: 13)
!2686 = !DILocation(line: 0, scope: !2685)
!2687 = !DILocation(line: 2252, column: 47, scope: !2685)
!2688 = !DILocation(line: 2252, column: 13, scope: !2674)
!2689 = !DILocation(line: 2254, column: 36, scope: !2690)
!2690 = distinct !DILexicalBlock(scope: !2685, file: !36, line: 2253, column: 9)
!2691 = !DILocation(line: 2254, column: 34, scope: !2690)
!2692 = !DILocation(line: 2256, column: 17, scope: !2693)
!2693 = distinct !DILexicalBlock(scope: !2690, file: !36, line: 2256, column: 17)
!2694 = !DILocation(line: 2256, column: 38, scope: !2693)
!2695 = !DILocation(line: 2256, column: 17, scope: !2690)
!2696 = !DILocation(line: 2258, column: 31, scope: !2697)
!2697 = distinct !DILexicalBlock(scope: !2693, file: !36, line: 2257, column: 13)
!2698 = !DILocation(line: 2258, column: 17, scope: !2697)
!2699 = !DILocation(line: 2259, column: 53, scope: !2697)
!2700 = !DILocation(line: 2259, column: 17, scope: !2697)
!2701 = !DILocation(line: 2260, column: 13, scope: !2697)
!2702 = !DILocation(line: 2261, column: 9, scope: !2690)
!2703 = !DILocation(line: 2262, column: 5, scope: !2674)
!2704 = distinct !DISubprogram(name: "MPU_xQueueCreateCountingSemaphore", scope: !36, file: !36, line: 2330, type: !2705, scopeLine: 2332, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2705 = !DISubroutineType(types: !2706)
!2706 = !{!41, !39, !39}
!2707 = !DILocalVariable(name: "uxCountValue", arg: 1, scope: !2704, file: !36, line: 2330, type: !39)
!2708 = !DILocation(line: 2330, column: 70, scope: !2704)
!2709 = !DILocalVariable(name: "uxInitialCount", arg: 2, scope: !2704, file: !36, line: 2331, type: !39)
!2710 = !DILocation(line: 2331, column: 70, scope: !2704)
!2711 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2704, file: !36, line: 2333, type: !41)
!2712 = !DILocation(line: 2333, column: 27, scope: !2704)
!2713 = !DILocalVariable(name: "xExternalQueueHandle", scope: !2704, file: !36, line: 2334, type: !41)
!2714 = !DILocation(line: 2334, column: 27, scope: !2704)
!2715 = !DILocalVariable(name: "lIndex", scope: !2704, file: !36, line: 2335, type: !27)
!2716 = !DILocation(line: 2335, column: 21, scope: !2704)
!2717 = !DILocation(line: 2337, column: 22, scope: !2704)
!2718 = !DILocation(line: 2337, column: 20, scope: !2704)
!2719 = !DILocation(line: 2339, column: 17, scope: !2720)
!2720 = distinct !DILexicalBlock(scope: !2704, file: !36, line: 2339, column: 17)
!2721 = !DILocation(line: 2339, column: 24, scope: !2720)
!2722 = !DILocation(line: 2339, column: 17, scope: !2704)
!2723 = !DILocation(line: 2341, column: 71, scope: !2724)
!2724 = distinct !DILexicalBlock(scope: !2720, file: !36, line: 2340, column: 13)
!2725 = !DILocation(line: 2341, column: 85, scope: !2724)
!2726 = !DILocation(line: 2341, column: 40, scope: !2724)
!2727 = !DILocation(line: 2341, column: 38, scope: !2724)
!2728 = !DILocation(line: 2343, column: 21, scope: !2729)
!2729 = distinct !DILexicalBlock(scope: !2724, file: !36, line: 2343, column: 21)
!2730 = !DILocation(line: 2343, column: 42, scope: !2729)
!2731 = !DILocation(line: 2343, column: 21, scope: !2724)
!2732 = !DILocation(line: 2345, column: 21, scope: !2733)
!2733 = distinct !DILexicalBlock(scope: !2729, file: !36, line: 2344, column: 17)
!2734 = !DILocation(line: 2346, column: 62, scope: !2733)
!2735 = !DILocation(line: 2346, column: 44, scope: !2733)
!2736 = !DILocation(line: 2346, column: 42, scope: !2733)
!2737 = !DILocation(line: 2347, column: 17, scope: !2733)
!2738 = !DILocation(line: 2350, column: 57, scope: !2739)
!2739 = distinct !DILexicalBlock(scope: !2729, file: !36, line: 2349, column: 17)
!2740 = !DILocation(line: 2350, column: 21, scope: !2739)
!2741 = !DILocation(line: 2352, column: 13, scope: !2724)
!2742 = !DILocation(line: 2354, column: 20, scope: !2704)
!2743 = !DILocation(line: 2354, column: 13, scope: !2704)
!2744 = distinct !DISubprogram(name: "MPU_xQueueCreateCountingSemaphoreStatic", scope: !36, file: !36, line: 2362, type: !2745, scopeLine: 2365, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2745 = !DISubroutineType(types: !2746)
!2746 = !{!41, !2747, !2747, !2748}
!2747 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !39)
!2748 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2749, size: 64)
!2749 = !DIDerivedType(tag: DW_TAG_typedef, name: "StaticQueue_t", file: !1485, line: 1361, baseType: !2750)
!2750 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xSTATIC_QUEUE", file: !1485, line: 1335, size: 1344, elements: !2751)
!2751 = !{!2752, !2754, !2759, !2773, !2775, !2777, !2778, !2779, !2780}
!2752 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy1", scope: !2750, file: !1485, line: 1337, baseType: !2753, size: 192)
!2753 = !DICompositeType(tag: DW_TAG_array_type, baseType: !26, size: 192, elements: !1535)
!2754 = !DIDerivedType(tag: DW_TAG_member, name: "u", scope: !2750, file: !1485, line: 1343, baseType: !2755, size: 64, offset: 192)
!2755 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !2750, file: !1485, line: 1339, size: 64, elements: !2756)
!2756 = !{!2757, !2758}
!2757 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy2", scope: !2755, file: !1485, line: 1341, baseType: !26, size: 64)
!2758 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy2", scope: !2755, file: !1485, line: 1342, baseType: !39, size: 64)
!2759 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy3", scope: !2750, file: !1485, line: 1345, baseType: !2760, size: 640, offset: 256)
!2760 = !DICompositeType(tag: DW_TAG_array_type, baseType: !2761, size: 640, elements: !1514)
!2761 = !DIDerivedType(tag: DW_TAG_typedef, name: "StaticList_t", file: !1485, line: 1256, baseType: !2762)
!2762 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xSTATIC_LIST", file: !1485, line: 1245, size: 320, elements: !2763)
!2763 = !{!2764, !2765, !2766}
!2764 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy2", scope: !2762, file: !1485, line: 1250, baseType: !39, size: 64)
!2765 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy3", scope: !2762, file: !1485, line: 1251, baseType: !26, size: 64, offset: 64)
!2766 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy4", scope: !2762, file: !1485, line: 1252, baseType: !2767, size: 192, offset: 128)
!2767 = !DIDerivedType(tag: DW_TAG_typedef, name: "StaticMiniListItem_t", file: !1485, line: 1239, baseType: !2768)
!2768 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xSTATIC_MINI_LIST_ITEM", file: !1485, line: 1231, size: 192, elements: !2769)
!2769 = !{!2770, !2771}
!2770 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy2", scope: !2768, file: !1485, line: 1236, baseType: !93, size: 64)
!2771 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy3", scope: !2768, file: !1485, line: 1237, baseType: !2772, size: 128, offset: 64)
!2772 = !DICompositeType(tag: DW_TAG_array_type, baseType: !26, size: 128, elements: !1514)
!2773 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy4", scope: !2750, file: !1485, line: 1346, baseType: !2774, size: 192, offset: 896)
!2774 = !DICompositeType(tag: DW_TAG_array_type, baseType: !39, size: 192, elements: !1535)
!2775 = !DIDerivedType(tag: DW_TAG_member, name: "ucDummy5", scope: !2750, file: !1485, line: 1347, baseType: !2776, size: 16, offset: 1088)
!2776 = !DICompositeType(tag: DW_TAG_array_type, baseType: !1520, size: 16, elements: !1514)
!2777 = !DIDerivedType(tag: DW_TAG_member, name: "ucDummy6", scope: !2750, file: !1485, line: 1350, baseType: !1520, size: 8, offset: 1104)
!2778 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy7", scope: !2750, file: !1485, line: 1354, baseType: !26, size: 64, offset: 1152)
!2779 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy8", scope: !2750, file: !1485, line: 1358, baseType: !39, size: 64, offset: 1216)
!2780 = !DIDerivedType(tag: DW_TAG_member, name: "ucDummy9", scope: !2750, file: !1485, line: 1359, baseType: !1520, size: 8, offset: 1280)
!2781 = !DILocalVariable(name: "uxMaxCount", arg: 1, scope: !2744, file: !36, line: 2362, type: !2747)
!2782 = !DILocation(line: 2362, column: 82, scope: !2744)
!2783 = !DILocalVariable(name: "uxInitialCount", arg: 2, scope: !2744, file: !36, line: 2363, type: !2747)
!2784 = !DILocation(line: 2363, column: 82, scope: !2744)
!2785 = !DILocalVariable(name: "pxStaticQueue", arg: 3, scope: !2744, file: !36, line: 2364, type: !2748)
!2786 = !DILocation(line: 2364, column: 80, scope: !2744)
!2787 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2744, file: !36, line: 2366, type: !41)
!2788 = !DILocation(line: 2366, column: 27, scope: !2744)
!2789 = !DILocalVariable(name: "xExternalQueueHandle", scope: !2744, file: !36, line: 2367, type: !41)
!2790 = !DILocation(line: 2367, column: 27, scope: !2744)
!2791 = !DILocalVariable(name: "lIndex", scope: !2744, file: !36, line: 2368, type: !27)
!2792 = !DILocation(line: 2368, column: 21, scope: !2744)
!2793 = !DILocation(line: 2370, column: 22, scope: !2744)
!2794 = !DILocation(line: 2370, column: 20, scope: !2744)
!2795 = !DILocation(line: 2372, column: 17, scope: !2796)
!2796 = distinct !DILexicalBlock(scope: !2744, file: !36, line: 2372, column: 17)
!2797 = !DILocation(line: 2372, column: 24, scope: !2796)
!2798 = !DILocation(line: 2372, column: 17, scope: !2744)
!2799 = !DILocation(line: 2374, column: 77, scope: !2800)
!2800 = distinct !DILexicalBlock(scope: !2796, file: !36, line: 2373, column: 13)
!2801 = !DILocation(line: 2374, column: 89, scope: !2800)
!2802 = !DILocation(line: 2374, column: 105, scope: !2800)
!2803 = !DILocation(line: 2374, column: 40, scope: !2800)
!2804 = !DILocation(line: 2374, column: 38, scope: !2800)
!2805 = !DILocation(line: 2376, column: 21, scope: !2806)
!2806 = distinct !DILexicalBlock(scope: !2800, file: !36, line: 2376, column: 21)
!2807 = !DILocation(line: 2376, column: 42, scope: !2806)
!2808 = !DILocation(line: 2376, column: 21, scope: !2800)
!2809 = !DILocation(line: 2378, column: 21, scope: !2810)
!2810 = distinct !DILexicalBlock(scope: !2806, file: !36, line: 2377, column: 17)
!2811 = !DILocation(line: 2379, column: 62, scope: !2810)
!2812 = !DILocation(line: 2379, column: 44, scope: !2810)
!2813 = !DILocation(line: 2379, column: 42, scope: !2810)
!2814 = !DILocation(line: 2380, column: 17, scope: !2810)
!2815 = !DILocation(line: 2383, column: 57, scope: !2816)
!2816 = distinct !DILexicalBlock(scope: !2806, file: !36, line: 2382, column: 17)
!2817 = !DILocation(line: 2383, column: 21, scope: !2816)
!2818 = !DILocation(line: 2385, column: 13, scope: !2800)
!2819 = !DILocation(line: 2387, column: 20, scope: !2744)
!2820 = !DILocation(line: 2387, column: 13, scope: !2744)
!2821 = distinct !DISubprogram(name: "MPU_xQueueGenericCreate", scope: !36, file: !36, line: 2395, type: !2822, scopeLine: 2398, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2822 = !DISubroutineType(types: !2823)
!2823 = !{!41, !39, !39, !1520}
!2824 = !DILocalVariable(name: "uxQueueLength", arg: 1, scope: !2821, file: !36, line: 2395, type: !39)
!2825 = !DILocation(line: 2395, column: 60, scope: !2821)
!2826 = !DILocalVariable(name: "uxItemSize", arg: 2, scope: !2821, file: !36, line: 2396, type: !39)
!2827 = !DILocation(line: 2396, column: 60, scope: !2821)
!2828 = !DILocalVariable(name: "ucQueueType", arg: 3, scope: !2821, file: !36, line: 2397, type: !1520)
!2829 = !DILocation(line: 2397, column: 56, scope: !2821)
!2830 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2821, file: !36, line: 2399, type: !41)
!2831 = !DILocation(line: 2399, column: 27, scope: !2821)
!2832 = !DILocalVariable(name: "xExternalQueueHandle", scope: !2821, file: !36, line: 2400, type: !41)
!2833 = !DILocation(line: 2400, column: 27, scope: !2821)
!2834 = !DILocalVariable(name: "lIndex", scope: !2821, file: !36, line: 2401, type: !27)
!2835 = !DILocation(line: 2401, column: 21, scope: !2821)
!2836 = !DILocation(line: 2403, column: 22, scope: !2821)
!2837 = !DILocation(line: 2403, column: 20, scope: !2821)
!2838 = !DILocation(line: 2405, column: 17, scope: !2839)
!2839 = distinct !DILexicalBlock(scope: !2821, file: !36, line: 2405, column: 17)
!2840 = !DILocation(line: 2405, column: 24, scope: !2839)
!2841 = !DILocation(line: 2405, column: 17, scope: !2821)
!2842 = !DILocation(line: 2407, column: 61, scope: !2843)
!2843 = distinct !DILexicalBlock(scope: !2839, file: !36, line: 2406, column: 13)
!2844 = !DILocation(line: 2407, column: 76, scope: !2843)
!2845 = !DILocation(line: 2407, column: 88, scope: !2843)
!2846 = !DILocation(line: 2407, column: 40, scope: !2843)
!2847 = !DILocation(line: 2407, column: 38, scope: !2843)
!2848 = !DILocation(line: 2409, column: 21, scope: !2849)
!2849 = distinct !DILexicalBlock(scope: !2843, file: !36, line: 2409, column: 21)
!2850 = !DILocation(line: 2409, column: 42, scope: !2849)
!2851 = !DILocation(line: 2409, column: 21, scope: !2843)
!2852 = !DILocation(line: 2411, column: 21, scope: !2853)
!2853 = distinct !DILexicalBlock(scope: !2849, file: !36, line: 2410, column: 17)
!2854 = !DILocation(line: 2412, column: 62, scope: !2853)
!2855 = !DILocation(line: 2412, column: 44, scope: !2853)
!2856 = !DILocation(line: 2412, column: 42, scope: !2853)
!2857 = !DILocation(line: 2413, column: 17, scope: !2853)
!2858 = !DILocation(line: 2416, column: 57, scope: !2859)
!2859 = distinct !DILexicalBlock(scope: !2849, file: !36, line: 2415, column: 17)
!2860 = !DILocation(line: 2416, column: 21, scope: !2859)
!2861 = !DILocation(line: 2418, column: 13, scope: !2843)
!2862 = !DILocation(line: 2420, column: 20, scope: !2821)
!2863 = !DILocation(line: 2420, column: 13, scope: !2821)
!2864 = distinct !DISubprogram(name: "MPU_xQueueGenericCreateStatic", scope: !36, file: !36, line: 2428, type: !2865, scopeLine: 2433, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2865 = !DISubroutineType(types: !2866)
!2866 = !{!41, !2747, !2747, !2867, !2748, !2868}
!2867 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1520, size: 64)
!2868 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1520)
!2869 = !DILocalVariable(name: "uxQueueLength", arg: 1, scope: !2864, file: !36, line: 2428, type: !2747)
!2870 = !DILocation(line: 2428, column: 72, scope: !2864)
!2871 = !DILocalVariable(name: "uxItemSize", arg: 2, scope: !2864, file: !36, line: 2429, type: !2747)
!2872 = !DILocation(line: 2429, column: 72, scope: !2864)
!2873 = !DILocalVariable(name: "pucQueueStorage", arg: 3, scope: !2864, file: !36, line: 2430, type: !2867)
!2874 = !DILocation(line: 2430, column: 64, scope: !2864)
!2875 = !DILocalVariable(name: "pxStaticQueue", arg: 4, scope: !2864, file: !36, line: 2431, type: !2748)
!2876 = !DILocation(line: 2431, column: 70, scope: !2864)
!2877 = !DILocalVariable(name: "ucQueueType", arg: 5, scope: !2864, file: !36, line: 2432, type: !2868)
!2878 = !DILocation(line: 2432, column: 68, scope: !2864)
!2879 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2864, file: !36, line: 2434, type: !41)
!2880 = !DILocation(line: 2434, column: 27, scope: !2864)
!2881 = !DILocalVariable(name: "xExternalQueueHandle", scope: !2864, file: !36, line: 2435, type: !41)
!2882 = !DILocation(line: 2435, column: 27, scope: !2864)
!2883 = !DILocalVariable(name: "lIndex", scope: !2864, file: !36, line: 2436, type: !27)
!2884 = !DILocation(line: 2436, column: 21, scope: !2864)
!2885 = !DILocation(line: 2438, column: 22, scope: !2864)
!2886 = !DILocation(line: 2438, column: 20, scope: !2864)
!2887 = !DILocation(line: 2440, column: 17, scope: !2888)
!2888 = distinct !DILexicalBlock(scope: !2864, file: !36, line: 2440, column: 17)
!2889 = !DILocation(line: 2440, column: 24, scope: !2888)
!2890 = !DILocation(line: 2440, column: 17, scope: !2864)
!2891 = !DILocation(line: 2442, column: 67, scope: !2892)
!2892 = distinct !DILexicalBlock(scope: !2888, file: !36, line: 2441, column: 13)
!2893 = !DILocation(line: 2442, column: 82, scope: !2892)
!2894 = !DILocation(line: 2442, column: 94, scope: !2892)
!2895 = !DILocation(line: 2442, column: 111, scope: !2892)
!2896 = !DILocation(line: 2442, column: 126, scope: !2892)
!2897 = !DILocation(line: 2442, column: 40, scope: !2892)
!2898 = !DILocation(line: 2442, column: 38, scope: !2892)
!2899 = !DILocation(line: 2444, column: 21, scope: !2900)
!2900 = distinct !DILexicalBlock(scope: !2892, file: !36, line: 2444, column: 21)
!2901 = !DILocation(line: 2444, column: 42, scope: !2900)
!2902 = !DILocation(line: 2444, column: 21, scope: !2892)
!2903 = !DILocation(line: 2446, column: 21, scope: !2904)
!2904 = distinct !DILexicalBlock(scope: !2900, file: !36, line: 2445, column: 17)
!2905 = !DILocation(line: 2447, column: 62, scope: !2904)
!2906 = !DILocation(line: 2447, column: 44, scope: !2904)
!2907 = !DILocation(line: 2447, column: 42, scope: !2904)
!2908 = !DILocation(line: 2448, column: 17, scope: !2904)
!2909 = !DILocation(line: 2451, column: 57, scope: !2910)
!2910 = distinct !DILexicalBlock(scope: !2900, file: !36, line: 2450, column: 17)
!2911 = !DILocation(line: 2451, column: 21, scope: !2910)
!2912 = !DILocation(line: 2453, column: 13, scope: !2892)
!2913 = !DILocation(line: 2455, column: 20, scope: !2864)
!2914 = !DILocation(line: 2455, column: 13, scope: !2864)
!2915 = distinct !DISubprogram(name: "MPU_xQueueGenericReset", scope: !36, file: !36, line: 2461, type: !2916, scopeLine: 2463, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2916 = !DISubroutineType(types: !2917)
!2917 = !{!23, !41, !23}
!2918 = !DILocalVariable(name: "xQueue", arg: 1, scope: !2915, file: !36, line: 2461, type: !41)
!2919 = !DILocation(line: 2461, column: 54, scope: !2915)
!2920 = !DILocalVariable(name: "xNewQueue", arg: 2, scope: !2915, file: !36, line: 2462, type: !23)
!2921 = !DILocation(line: 2462, column: 51, scope: !2915)
!2922 = !DILocalVariable(name: "lIndex", scope: !2915, file: !36, line: 2464, type: !27)
!2923 = !DILocation(line: 2464, column: 17, scope: !2915)
!2924 = !DILocalVariable(name: "xInternalQueueHandle", scope: !2915, file: !36, line: 2465, type: !41)
!2925 = !DILocation(line: 2465, column: 23, scope: !2915)
!2926 = !DILocalVariable(name: "xReturn", scope: !2915, file: !36, line: 2466, type: !23)
!2927 = !DILocation(line: 2466, column: 20, scope: !2915)
!2928 = !DILocation(line: 2468, column: 31, scope: !2915)
!2929 = !DILocation(line: 2468, column: 18, scope: !2915)
!2930 = !DILocation(line: 2468, column: 16, scope: !2915)
!2931 = !DILocation(line: 2470, column: 13, scope: !2932)
!2932 = distinct !DILexicalBlock(scope: !2915, file: !36, line: 2470, column: 13)
!2933 = !DILocation(line: 0, scope: !2932)
!2934 = !DILocation(line: 2470, column: 47, scope: !2932)
!2935 = !DILocation(line: 2470, column: 13, scope: !2915)
!2936 = !DILocation(line: 2472, column: 36, scope: !2937)
!2937 = distinct !DILexicalBlock(scope: !2932, file: !36, line: 2471, column: 9)
!2938 = !DILocation(line: 2472, column: 34, scope: !2937)
!2939 = !DILocation(line: 2474, column: 17, scope: !2940)
!2940 = distinct !DILexicalBlock(scope: !2937, file: !36, line: 2474, column: 17)
!2941 = !DILocation(line: 2474, column: 38, scope: !2940)
!2942 = !DILocation(line: 2474, column: 17, scope: !2937)
!2943 = !DILocation(line: 2476, column: 47, scope: !2944)
!2944 = distinct !DILexicalBlock(scope: !2940, file: !36, line: 2475, column: 13)
!2945 = !DILocation(line: 2476, column: 69, scope: !2944)
!2946 = !DILocation(line: 2476, column: 27, scope: !2944)
!2947 = !DILocation(line: 2476, column: 25, scope: !2944)
!2948 = !DILocation(line: 2477, column: 13, scope: !2944)
!2949 = !DILocation(line: 2478, column: 9, scope: !2937)
!2950 = !DILocation(line: 2480, column: 16, scope: !2915)
!2951 = !DILocation(line: 2480, column: 9, scope: !2915)
!2952 = distinct !DISubprogram(name: "MPU_xQueueCreateSet", scope: !36, file: !36, line: 2486, type: !2953, scopeLine: 2487, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2953 = !DISubroutineType(types: !2954)
!2954 = !{!45, !39}
!2955 = !DILocalVariable(name: "uxEventQueueLength", arg: 1, scope: !2952, file: !36, line: 2486, type: !39)
!2956 = !DILocation(line: 2486, column: 59, scope: !2952)
!2957 = !DILocalVariable(name: "xInternalQueueSetHandle", scope: !2952, file: !36, line: 2488, type: !45)
!2958 = !DILocation(line: 2488, column: 30, scope: !2952)
!2959 = !DILocalVariable(name: "xExternalQueueSetHandle", scope: !2952, file: !36, line: 2489, type: !45)
!2960 = !DILocation(line: 2489, column: 30, scope: !2952)
!2961 = !DILocalVariable(name: "lIndex", scope: !2952, file: !36, line: 2490, type: !27)
!2962 = !DILocation(line: 2490, column: 21, scope: !2952)
!2963 = !DILocation(line: 2492, column: 22, scope: !2952)
!2964 = !DILocation(line: 2492, column: 20, scope: !2952)
!2965 = !DILocation(line: 2494, column: 17, scope: !2966)
!2966 = distinct !DILexicalBlock(scope: !2952, file: !36, line: 2494, column: 17)
!2967 = !DILocation(line: 2494, column: 24, scope: !2966)
!2968 = !DILocation(line: 2494, column: 17, scope: !2952)
!2969 = !DILocation(line: 2496, column: 60, scope: !2970)
!2970 = distinct !DILexicalBlock(scope: !2966, file: !36, line: 2495, column: 13)
!2971 = !DILocation(line: 2496, column: 43, scope: !2970)
!2972 = !DILocation(line: 2496, column: 41, scope: !2970)
!2973 = !DILocation(line: 2498, column: 21, scope: !2974)
!2974 = distinct !DILexicalBlock(scope: !2970, file: !36, line: 2498, column: 21)
!2975 = !DILocation(line: 2498, column: 45, scope: !2974)
!2976 = !DILocation(line: 2498, column: 21, scope: !2970)
!2977 = !DILocation(line: 2500, column: 21, scope: !2978)
!2978 = distinct !DILexicalBlock(scope: !2974, file: !36, line: 2499, column: 17)
!2979 = !DILocation(line: 2501, column: 68, scope: !2978)
!2980 = !DILocation(line: 2501, column: 47, scope: !2978)
!2981 = !DILocation(line: 2501, column: 45, scope: !2978)
!2982 = !DILocation(line: 2502, column: 17, scope: !2978)
!2983 = !DILocation(line: 2505, column: 57, scope: !2984)
!2984 = distinct !DILexicalBlock(scope: !2974, file: !36, line: 2504, column: 17)
!2985 = !DILocation(line: 2505, column: 21, scope: !2984)
!2986 = !DILocation(line: 2507, column: 13, scope: !2970)
!2987 = !DILocation(line: 2509, column: 20, scope: !2952)
!2988 = !DILocation(line: 2509, column: 13, scope: !2952)
!2989 = distinct !DISubprogram(name: "MPU_xQueueRemoveFromSet", scope: !36, file: !36, line: 2517, type: !2526, scopeLine: 2519, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!2990 = !DILocalVariable(name: "xQueueOrSemaphore", arg: 1, scope: !2989, file: !36, line: 2517, type: !46)
!2991 = !DILocation(line: 2517, column: 68, scope: !2989)
!2992 = !DILocalVariable(name: "xQueueSet", arg: 2, scope: !2989, file: !36, line: 2518, type: !45)
!2993 = !DILocation(line: 2518, column: 62, scope: !2989)
!2994 = !DILocalVariable(name: "xReturn", scope: !2989, file: !36, line: 2520, type: !23)
!2995 = !DILocation(line: 2520, column: 24, scope: !2989)
!2996 = !DILocalVariable(name: "xInternalQueueSetMemberHandle", scope: !2989, file: !36, line: 2521, type: !46)
!2997 = !DILocation(line: 2521, column: 36, scope: !2989)
!2998 = !DILocalVariable(name: "xInternalQueueSetHandle", scope: !2989, file: !36, line: 2522, type: !45)
!2999 = !DILocation(line: 2522, column: 30, scope: !2989)
!3000 = !DILocalVariable(name: "lIndexQueueSet", scope: !2989, file: !36, line: 2523, type: !27)
!3001 = !DILocation(line: 2523, column: 21, scope: !2989)
!3002 = !DILocalVariable(name: "lIndexQueueSetMember", scope: !2989, file: !36, line: 2523, type: !27)
!3003 = !DILocation(line: 2523, column: 37, scope: !2989)
!3004 = !DILocation(line: 2525, column: 42, scope: !2989)
!3005 = !DILocation(line: 2525, column: 30, scope: !2989)
!3006 = !DILocation(line: 2525, column: 28, scope: !2989)
!3007 = !DILocation(line: 2526, column: 48, scope: !2989)
!3008 = !DILocation(line: 2526, column: 36, scope: !2989)
!3009 = !DILocation(line: 2526, column: 34, scope: !2989)
!3010 = !DILocation(line: 2528, column: 19, scope: !3011)
!3011 = distinct !DILexicalBlock(scope: !2989, file: !36, line: 2528, column: 17)
!3012 = !DILocation(line: 0, scope: !3011)
!3013 = !DILocation(line: 2528, column: 61, scope: !3011)
!3014 = !DILocation(line: 2528, column: 74, scope: !3011)
!3015 = !DILocation(line: 2529, column: 19, scope: !3011)
!3016 = !DILocation(line: 2529, column: 67, scope: !3011)
!3017 = !DILocation(line: 2528, column: 17, scope: !2989)
!3018 = !DILocation(line: 2531, column: 43, scope: !3019)
!3019 = distinct !DILexicalBlock(scope: !3011, file: !36, line: 2530, column: 13)
!3020 = !DILocation(line: 2531, column: 41, scope: !3019)
!3021 = !DILocation(line: 2532, column: 49, scope: !3019)
!3022 = !DILocation(line: 2532, column: 47, scope: !3019)
!3023 = !DILocation(line: 2534, column: 23, scope: !3024)
!3024 = distinct !DILexicalBlock(scope: !3019, file: !36, line: 2534, column: 21)
!3025 = !DILocation(line: 2534, column: 47, scope: !3024)
!3026 = !DILocation(line: 2534, column: 57, scope: !3024)
!3027 = !DILocation(line: 2534, column: 62, scope: !3024)
!3028 = !DILocation(line: 2534, column: 92, scope: !3024)
!3029 = !DILocation(line: 2534, column: 21, scope: !3019)
!3030 = !DILocation(line: 2536, column: 52, scope: !3031)
!3031 = distinct !DILexicalBlock(scope: !3024, file: !36, line: 2535, column: 17)
!3032 = !DILocation(line: 2536, column: 83, scope: !3031)
!3033 = !DILocation(line: 2536, column: 31, scope: !3031)
!3034 = !DILocation(line: 2536, column: 29, scope: !3031)
!3035 = !DILocation(line: 2537, column: 17, scope: !3031)
!3036 = !DILocation(line: 2538, column: 13, scope: !3019)
!3037 = !DILocation(line: 2540, column: 20, scope: !2989)
!3038 = !DILocation(line: 2540, column: 13, scope: !2989)
!3039 = distinct !DISubprogram(name: "MPU_xQueueGenericGetStaticBuffers", scope: !36, file: !36, line: 2548, type: !3040, scopeLine: 2551, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3040 = !DISubroutineType(types: !3041)
!3041 = !{!23, !41, !3042, !3043}
!3042 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2867, size: 64)
!3043 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2748, size: 64)
!3044 = !DILocalVariable(name: "xQueue", arg: 1, scope: !3039, file: !36, line: 2548, type: !41)
!3045 = !DILocation(line: 2548, column: 69, scope: !3039)
!3046 = !DILocalVariable(name: "ppucQueueStorage", arg: 2, scope: !3039, file: !36, line: 2549, type: !3042)
!3047 = !DILocation(line: 2549, column: 66, scope: !3039)
!3048 = !DILocalVariable(name: "ppxStaticQueue", arg: 3, scope: !3039, file: !36, line: 2550, type: !3043)
!3049 = !DILocation(line: 2550, column: 72, scope: !3039)
!3050 = !DILocalVariable(name: "lIndex", scope: !3039, file: !36, line: 2552, type: !27)
!3051 = !DILocation(line: 2552, column: 21, scope: !3039)
!3052 = !DILocalVariable(name: "xInternalQueueHandle", scope: !3039, file: !36, line: 2553, type: !41)
!3053 = !DILocation(line: 2553, column: 27, scope: !3039)
!3054 = !DILocalVariable(name: "xReturn", scope: !3039, file: !36, line: 2554, type: !23)
!3055 = !DILocation(line: 2554, column: 24, scope: !3039)
!3056 = !DILocation(line: 2556, column: 34, scope: !3039)
!3057 = !DILocation(line: 2556, column: 22, scope: !3039)
!3058 = !DILocation(line: 2556, column: 20, scope: !3039)
!3059 = !DILocation(line: 2558, column: 17, scope: !3060)
!3060 = distinct !DILexicalBlock(scope: !3039, file: !36, line: 2558, column: 17)
!3061 = !DILocation(line: 0, scope: !3060)
!3062 = !DILocation(line: 2558, column: 51, scope: !3060)
!3063 = !DILocation(line: 2558, column: 17, scope: !3039)
!3064 = !DILocation(line: 2560, column: 40, scope: !3065)
!3065 = distinct !DILexicalBlock(scope: !3060, file: !36, line: 2559, column: 13)
!3066 = !DILocation(line: 2560, column: 38, scope: !3065)
!3067 = !DILocation(line: 2562, column: 21, scope: !3068)
!3068 = distinct !DILexicalBlock(scope: !3065, file: !36, line: 2562, column: 21)
!3069 = !DILocation(line: 2562, column: 42, scope: !3068)
!3070 = !DILocation(line: 2562, column: 21, scope: !3065)
!3071 = !DILocation(line: 2564, column: 62, scope: !3072)
!3072 = distinct !DILexicalBlock(scope: !3068, file: !36, line: 2563, column: 17)
!3073 = !DILocation(line: 2564, column: 84, scope: !3072)
!3074 = !DILocation(line: 2564, column: 102, scope: !3072)
!3075 = !DILocation(line: 2564, column: 31, scope: !3072)
!3076 = !DILocation(line: 2564, column: 29, scope: !3072)
!3077 = !DILocation(line: 2565, column: 17, scope: !3072)
!3078 = !DILocation(line: 2566, column: 13, scope: !3065)
!3079 = !DILocation(line: 2568, column: 20, scope: !3039)
!3080 = !DILocation(line: 2568, column: 13, scope: !3039)
!3081 = distinct !DISubprogram(name: "MPU_xQueueGenericSendFromISR", scope: !36, file: !36, line: 2574, type: !3082, scopeLine: 2578, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3082 = !DISubroutineType(types: !3083)
!3083 = !{!23, !41, !2194, !3084, !3085}
!3084 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2108)
!3085 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !23)
!3086 = !DILocalVariable(name: "xQueue", arg: 1, scope: !3081, file: !36, line: 2574, type: !41)
!3087 = !DILocation(line: 2574, column: 60, scope: !3081)
!3088 = !DILocalVariable(name: "pvItemToQueue", arg: 2, scope: !3081, file: !36, line: 2575, type: !2194)
!3089 = !DILocation(line: 2575, column: 65, scope: !3081)
!3090 = !DILocalVariable(name: "pxHigherPriorityTaskWoken", arg: 3, scope: !3081, file: !36, line: 2576, type: !3084)
!3091 = !DILocation(line: 2576, column: 65, scope: !3081)
!3092 = !DILocalVariable(name: "xCopyPosition", arg: 4, scope: !3081, file: !36, line: 2577, type: !3085)
!3093 = !DILocation(line: 2577, column: 63, scope: !3081)
!3094 = !DILocalVariable(name: "xReturn", scope: !3081, file: !36, line: 2579, type: !23)
!3095 = !DILocation(line: 2579, column: 20, scope: !3081)
!3096 = !DILocalVariable(name: "lIndex", scope: !3081, file: !36, line: 2580, type: !27)
!3097 = !DILocation(line: 2580, column: 17, scope: !3081)
!3098 = !DILocalVariable(name: "xInternalQueueHandle", scope: !3081, file: !36, line: 2581, type: !41)
!3099 = !DILocation(line: 2581, column: 23, scope: !3081)
!3100 = !DILocation(line: 2583, column: 30, scope: !3081)
!3101 = !DILocation(line: 2583, column: 18, scope: !3081)
!3102 = !DILocation(line: 2583, column: 16, scope: !3081)
!3103 = !DILocation(line: 2585, column: 13, scope: !3104)
!3104 = distinct !DILexicalBlock(scope: !3081, file: !36, line: 2585, column: 13)
!3105 = !DILocation(line: 0, scope: !3104)
!3106 = !DILocation(line: 2585, column: 47, scope: !3104)
!3107 = !DILocation(line: 2585, column: 13, scope: !3081)
!3108 = !DILocation(line: 2587, column: 36, scope: !3109)
!3109 = distinct !DILexicalBlock(scope: !3104, file: !36, line: 2586, column: 9)
!3110 = !DILocation(line: 2587, column: 34, scope: !3109)
!3111 = !DILocation(line: 2589, column: 17, scope: !3112)
!3112 = distinct !DILexicalBlock(scope: !3109, file: !36, line: 2589, column: 17)
!3113 = !DILocation(line: 2589, column: 38, scope: !3112)
!3114 = !DILocation(line: 2589, column: 17, scope: !3109)
!3115 = !DILocation(line: 2591, column: 53, scope: !3116)
!3116 = distinct !DILexicalBlock(scope: !3112, file: !36, line: 2590, column: 13)
!3117 = !DILocation(line: 2591, column: 75, scope: !3116)
!3118 = !DILocation(line: 2591, column: 90, scope: !3116)
!3119 = !DILocation(line: 2591, column: 117, scope: !3116)
!3120 = !DILocation(line: 2591, column: 27, scope: !3116)
!3121 = !DILocation(line: 2591, column: 25, scope: !3116)
!3122 = !DILocation(line: 2592, column: 13, scope: !3116)
!3123 = !DILocation(line: 2593, column: 9, scope: !3109)
!3124 = !DILocation(line: 2595, column: 16, scope: !3081)
!3125 = !DILocation(line: 2595, column: 9, scope: !3081)
!3126 = distinct !DISubprogram(name: "MPU_xQueueGiveFromISR", scope: !36, file: !36, line: 2600, type: !3127, scopeLine: 2602, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3127 = !DISubroutineType(types: !3128)
!3128 = !{!23, !41, !3084}
!3129 = !DILocalVariable(name: "xQueue", arg: 1, scope: !3126, file: !36, line: 2600, type: !41)
!3130 = !DILocation(line: 2600, column: 53, scope: !3126)
!3131 = !DILocalVariable(name: "pxHigherPriorityTaskWoken", arg: 2, scope: !3126, file: !36, line: 2601, type: !3084)
!3132 = !DILocation(line: 2601, column: 58, scope: !3126)
!3133 = !DILocalVariable(name: "xReturn", scope: !3126, file: !36, line: 2603, type: !23)
!3134 = !DILocation(line: 2603, column: 20, scope: !3126)
!3135 = !DILocalVariable(name: "lIndex", scope: !3126, file: !36, line: 2604, type: !27)
!3136 = !DILocation(line: 2604, column: 17, scope: !3126)
!3137 = !DILocalVariable(name: "xInternalQueueHandle", scope: !3126, file: !36, line: 2605, type: !41)
!3138 = !DILocation(line: 2605, column: 23, scope: !3126)
!3139 = !DILocation(line: 2607, column: 30, scope: !3126)
!3140 = !DILocation(line: 2607, column: 18, scope: !3126)
!3141 = !DILocation(line: 2607, column: 16, scope: !3126)
!3142 = !DILocation(line: 2609, column: 13, scope: !3143)
!3143 = distinct !DILexicalBlock(scope: !3126, file: !36, line: 2609, column: 13)
!3144 = !DILocation(line: 0, scope: !3143)
!3145 = !DILocation(line: 2609, column: 47, scope: !3143)
!3146 = !DILocation(line: 2609, column: 13, scope: !3126)
!3147 = !DILocation(line: 2611, column: 36, scope: !3148)
!3148 = distinct !DILexicalBlock(scope: !3143, file: !36, line: 2610, column: 9)
!3149 = !DILocation(line: 2611, column: 34, scope: !3148)
!3150 = !DILocation(line: 2613, column: 17, scope: !3151)
!3151 = distinct !DILexicalBlock(scope: !3148, file: !36, line: 2613, column: 17)
!3152 = !DILocation(line: 2613, column: 38, scope: !3151)
!3153 = !DILocation(line: 2613, column: 17, scope: !3148)
!3154 = !DILocation(line: 2615, column: 46, scope: !3155)
!3155 = distinct !DILexicalBlock(scope: !3151, file: !36, line: 2614, column: 13)
!3156 = !DILocation(line: 2615, column: 68, scope: !3155)
!3157 = !DILocation(line: 2615, column: 27, scope: !3155)
!3158 = !DILocation(line: 2615, column: 25, scope: !3155)
!3159 = !DILocation(line: 2616, column: 13, scope: !3155)
!3160 = !DILocation(line: 2617, column: 9, scope: !3148)
!3161 = !DILocation(line: 2619, column: 16, scope: !3126)
!3162 = !DILocation(line: 2619, column: 9, scope: !3126)
!3163 = distinct !DISubprogram(name: "MPU_xQueuePeekFromISR", scope: !36, file: !36, line: 2624, type: !3164, scopeLine: 2626, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3164 = !DISubroutineType(types: !3165)
!3165 = !{!23, !41, !1480}
!3166 = !DILocalVariable(name: "xQueue", arg: 1, scope: !3163, file: !36, line: 2624, type: !41)
!3167 = !DILocation(line: 2624, column: 53, scope: !3163)
!3168 = !DILocalVariable(name: "pvBuffer", arg: 2, scope: !3163, file: !36, line: 2625, type: !1480)
!3169 = !DILocation(line: 2625, column: 52, scope: !3163)
!3170 = !DILocalVariable(name: "xReturn", scope: !3163, file: !36, line: 2627, type: !23)
!3171 = !DILocation(line: 2627, column: 20, scope: !3163)
!3172 = !DILocalVariable(name: "lIndex", scope: !3163, file: !36, line: 2628, type: !27)
!3173 = !DILocation(line: 2628, column: 17, scope: !3163)
!3174 = !DILocalVariable(name: "xInternalQueueHandle", scope: !3163, file: !36, line: 2629, type: !41)
!3175 = !DILocation(line: 2629, column: 23, scope: !3163)
!3176 = !DILocation(line: 2631, column: 30, scope: !3163)
!3177 = !DILocation(line: 2631, column: 18, scope: !3163)
!3178 = !DILocation(line: 2631, column: 16, scope: !3163)
!3179 = !DILocation(line: 2633, column: 13, scope: !3180)
!3180 = distinct !DILexicalBlock(scope: !3163, file: !36, line: 2633, column: 13)
!3181 = !DILocation(line: 0, scope: !3180)
!3182 = !DILocation(line: 2633, column: 47, scope: !3180)
!3183 = !DILocation(line: 2633, column: 13, scope: !3163)
!3184 = !DILocation(line: 2635, column: 36, scope: !3185)
!3185 = distinct !DILexicalBlock(scope: !3180, file: !36, line: 2634, column: 9)
!3186 = !DILocation(line: 2635, column: 34, scope: !3185)
!3187 = !DILocation(line: 2637, column: 17, scope: !3188)
!3188 = distinct !DILexicalBlock(scope: !3185, file: !36, line: 2637, column: 17)
!3189 = !DILocation(line: 2637, column: 38, scope: !3188)
!3190 = !DILocation(line: 2637, column: 17, scope: !3185)
!3191 = !DILocation(line: 2639, column: 46, scope: !3192)
!3192 = distinct !DILexicalBlock(scope: !3188, file: !36, line: 2638, column: 13)
!3193 = !DILocation(line: 2639, column: 68, scope: !3192)
!3194 = !DILocation(line: 2639, column: 27, scope: !3192)
!3195 = !DILocation(line: 2639, column: 25, scope: !3192)
!3196 = !DILocation(line: 2640, column: 13, scope: !3192)
!3197 = !DILocation(line: 2641, column: 9, scope: !3185)
!3198 = !DILocation(line: 2643, column: 16, scope: !3163)
!3199 = !DILocation(line: 2643, column: 9, scope: !3163)
!3200 = distinct !DISubprogram(name: "MPU_xQueueReceiveFromISR", scope: !36, file: !36, line: 2648, type: !3201, scopeLine: 2651, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3201 = !DISubroutineType(types: !3202)
!3202 = !{!23, !41, !1480, !3084}
!3203 = !DILocalVariable(name: "xQueue", arg: 1, scope: !3200, file: !36, line: 2648, type: !41)
!3204 = !DILocation(line: 2648, column: 56, scope: !3200)
!3205 = !DILocalVariable(name: "pvBuffer", arg: 2, scope: !3200, file: !36, line: 2649, type: !1480)
!3206 = !DILocation(line: 2649, column: 55, scope: !3200)
!3207 = !DILocalVariable(name: "pxHigherPriorityTaskWoken", arg: 3, scope: !3200, file: !36, line: 2650, type: !3084)
!3208 = !DILocation(line: 2650, column: 61, scope: !3200)
!3209 = !DILocalVariable(name: "xReturn", scope: !3200, file: !36, line: 2652, type: !23)
!3210 = !DILocation(line: 2652, column: 20, scope: !3200)
!3211 = !DILocalVariable(name: "lIndex", scope: !3200, file: !36, line: 2653, type: !27)
!3212 = !DILocation(line: 2653, column: 17, scope: !3200)
!3213 = !DILocalVariable(name: "xInternalQueueHandle", scope: !3200, file: !36, line: 2654, type: !41)
!3214 = !DILocation(line: 2654, column: 23, scope: !3200)
!3215 = !DILocation(line: 2656, column: 30, scope: !3200)
!3216 = !DILocation(line: 2656, column: 18, scope: !3200)
!3217 = !DILocation(line: 2656, column: 16, scope: !3200)
!3218 = !DILocation(line: 2658, column: 13, scope: !3219)
!3219 = distinct !DILexicalBlock(scope: !3200, file: !36, line: 2658, column: 13)
!3220 = !DILocation(line: 0, scope: !3219)
!3221 = !DILocation(line: 2658, column: 47, scope: !3219)
!3222 = !DILocation(line: 2658, column: 13, scope: !3200)
!3223 = !DILocation(line: 2660, column: 36, scope: !3224)
!3224 = distinct !DILexicalBlock(scope: !3219, file: !36, line: 2659, column: 9)
!3225 = !DILocation(line: 2660, column: 34, scope: !3224)
!3226 = !DILocation(line: 2662, column: 17, scope: !3227)
!3227 = distinct !DILexicalBlock(scope: !3224, file: !36, line: 2662, column: 17)
!3228 = !DILocation(line: 2662, column: 38, scope: !3227)
!3229 = !DILocation(line: 2662, column: 17, scope: !3224)
!3230 = !DILocation(line: 2664, column: 49, scope: !3231)
!3231 = distinct !DILexicalBlock(scope: !3227, file: !36, line: 2663, column: 13)
!3232 = !DILocation(line: 2664, column: 71, scope: !3231)
!3233 = !DILocation(line: 2664, column: 81, scope: !3231)
!3234 = !DILocation(line: 2664, column: 27, scope: !3231)
!3235 = !DILocation(line: 2664, column: 25, scope: !3231)
!3236 = !DILocation(line: 2665, column: 13, scope: !3231)
!3237 = !DILocation(line: 2666, column: 9, scope: !3224)
!3238 = !DILocation(line: 2668, column: 16, scope: !3200)
!3239 = !DILocation(line: 2668, column: 9, scope: !3200)
!3240 = distinct !DISubprogram(name: "MPU_xQueueIsQueueEmptyFromISR", scope: !36, file: !36, line: 2673, type: !3241, scopeLine: 2674, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3241 = !DISubroutineType(types: !3242)
!3242 = !{!23, !2262}
!3243 = !DILocalVariable(name: "xQueue", arg: 1, scope: !3240, file: !36, line: 2673, type: !2262)
!3244 = !DILocation(line: 2673, column: 67, scope: !3240)
!3245 = !DILocalVariable(name: "xReturn", scope: !3240, file: !36, line: 2675, type: !23)
!3246 = !DILocation(line: 2675, column: 20, scope: !3240)
!3247 = !DILocalVariable(name: "lIndex", scope: !3240, file: !36, line: 2676, type: !27)
!3248 = !DILocation(line: 2676, column: 17, scope: !3240)
!3249 = !DILocalVariable(name: "xInternalQueueHandle", scope: !3240, file: !36, line: 2677, type: !41)
!3250 = !DILocation(line: 2677, column: 23, scope: !3240)
!3251 = !DILocation(line: 2679, column: 30, scope: !3240)
!3252 = !DILocation(line: 2679, column: 18, scope: !3240)
!3253 = !DILocation(line: 2679, column: 16, scope: !3240)
!3254 = !DILocation(line: 2681, column: 13, scope: !3255)
!3255 = distinct !DILexicalBlock(scope: !3240, file: !36, line: 2681, column: 13)
!3256 = !DILocation(line: 0, scope: !3255)
!3257 = !DILocation(line: 2681, column: 47, scope: !3255)
!3258 = !DILocation(line: 2681, column: 13, scope: !3240)
!3259 = !DILocation(line: 2683, column: 36, scope: !3260)
!3260 = distinct !DILexicalBlock(scope: !3255, file: !36, line: 2682, column: 9)
!3261 = !DILocation(line: 2683, column: 34, scope: !3260)
!3262 = !DILocation(line: 2685, column: 17, scope: !3263)
!3263 = distinct !DILexicalBlock(scope: !3260, file: !36, line: 2685, column: 17)
!3264 = !DILocation(line: 2685, column: 38, scope: !3263)
!3265 = !DILocation(line: 2685, column: 17, scope: !3260)
!3266 = !DILocation(line: 2687, column: 54, scope: !3267)
!3267 = distinct !DILexicalBlock(scope: !3263, file: !36, line: 2686, column: 13)
!3268 = !DILocation(line: 2687, column: 27, scope: !3267)
!3269 = !DILocation(line: 2687, column: 25, scope: !3267)
!3270 = !DILocation(line: 2688, column: 13, scope: !3267)
!3271 = !DILocation(line: 2689, column: 9, scope: !3260)
!3272 = !DILocation(line: 2691, column: 16, scope: !3240)
!3273 = !DILocation(line: 2691, column: 9, scope: !3240)
!3274 = distinct !DISubprogram(name: "MPU_xQueueIsQueueFullFromISR", scope: !36, file: !36, line: 2695, type: !3241, scopeLine: 2696, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3275 = !DILocalVariable(name: "xQueue", arg: 1, scope: !3274, file: !36, line: 2695, type: !2262)
!3276 = !DILocation(line: 2695, column: 66, scope: !3274)
!3277 = !DILocalVariable(name: "xReturn", scope: !3274, file: !36, line: 2697, type: !23)
!3278 = !DILocation(line: 2697, column: 20, scope: !3274)
!3279 = !DILocalVariable(name: "lIndex", scope: !3274, file: !36, line: 2698, type: !27)
!3280 = !DILocation(line: 2698, column: 17, scope: !3274)
!3281 = !DILocalVariable(name: "xInternalQueueHandle", scope: !3274, file: !36, line: 2699, type: !41)
!3282 = !DILocation(line: 2699, column: 23, scope: !3274)
!3283 = !DILocation(line: 2701, column: 30, scope: !3274)
!3284 = !DILocation(line: 2701, column: 18, scope: !3274)
!3285 = !DILocation(line: 2701, column: 16, scope: !3274)
!3286 = !DILocation(line: 2703, column: 13, scope: !3287)
!3287 = distinct !DILexicalBlock(scope: !3274, file: !36, line: 2703, column: 13)
!3288 = !DILocation(line: 0, scope: !3287)
!3289 = !DILocation(line: 2703, column: 47, scope: !3287)
!3290 = !DILocation(line: 2703, column: 13, scope: !3274)
!3291 = !DILocation(line: 2705, column: 36, scope: !3292)
!3292 = distinct !DILexicalBlock(scope: !3287, file: !36, line: 2704, column: 9)
!3293 = !DILocation(line: 2705, column: 34, scope: !3292)
!3294 = !DILocation(line: 2707, column: 17, scope: !3295)
!3295 = distinct !DILexicalBlock(scope: !3292, file: !36, line: 2707, column: 17)
!3296 = !DILocation(line: 2707, column: 38, scope: !3295)
!3297 = !DILocation(line: 2707, column: 17, scope: !3292)
!3298 = !DILocation(line: 2709, column: 53, scope: !3299)
!3299 = distinct !DILexicalBlock(scope: !3295, file: !36, line: 2708, column: 13)
!3300 = !DILocation(line: 2709, column: 27, scope: !3299)
!3301 = !DILocation(line: 2709, column: 25, scope: !3299)
!3302 = !DILocation(line: 2710, column: 13, scope: !3299)
!3303 = !DILocation(line: 2711, column: 9, scope: !3292)
!3304 = !DILocation(line: 2713, column: 16, scope: !3274)
!3305 = !DILocation(line: 2713, column: 9, scope: !3274)
!3306 = distinct !DISubprogram(name: "MPU_uxQueueMessagesWaitingFromISR", scope: !36, file: !36, line: 2718, type: !2260, scopeLine: 2719, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3307 = !DILocalVariable(name: "xQueue", arg: 1, scope: !3306, file: !36, line: 2718, type: !2262)
!3308 = !DILocation(line: 2718, column: 72, scope: !3306)
!3309 = !DILocalVariable(name: "uxReturn", scope: !3306, file: !36, line: 2720, type: !39)
!3310 = !DILocation(line: 2720, column: 21, scope: !3306)
!3311 = !DILocalVariable(name: "lIndex", scope: !3306, file: !36, line: 2721, type: !27)
!3312 = !DILocation(line: 2721, column: 17, scope: !3306)
!3313 = !DILocalVariable(name: "xInternalQueueHandle", scope: !3306, file: !36, line: 2722, type: !41)
!3314 = !DILocation(line: 2722, column: 23, scope: !3306)
!3315 = !DILocation(line: 2724, column: 30, scope: !3306)
!3316 = !DILocation(line: 2724, column: 18, scope: !3306)
!3317 = !DILocation(line: 2724, column: 16, scope: !3306)
!3318 = !DILocation(line: 2726, column: 13, scope: !3319)
!3319 = distinct !DILexicalBlock(scope: !3306, file: !36, line: 2726, column: 13)
!3320 = !DILocation(line: 0, scope: !3319)
!3321 = !DILocation(line: 2726, column: 47, scope: !3319)
!3322 = !DILocation(line: 2726, column: 13, scope: !3306)
!3323 = !DILocation(line: 2728, column: 36, scope: !3324)
!3324 = distinct !DILexicalBlock(scope: !3319, file: !36, line: 2727, column: 9)
!3325 = !DILocation(line: 2728, column: 34, scope: !3324)
!3326 = !DILocation(line: 2730, column: 17, scope: !3327)
!3327 = distinct !DILexicalBlock(scope: !3324, file: !36, line: 2730, column: 17)
!3328 = !DILocation(line: 2730, column: 38, scope: !3327)
!3329 = !DILocation(line: 2730, column: 17, scope: !3324)
!3330 = !DILocation(line: 2732, column: 59, scope: !3331)
!3331 = distinct !DILexicalBlock(scope: !3327, file: !36, line: 2731, column: 13)
!3332 = !DILocation(line: 2732, column: 28, scope: !3331)
!3333 = !DILocation(line: 2732, column: 26, scope: !3331)
!3334 = !DILocation(line: 2733, column: 13, scope: !3331)
!3335 = !DILocation(line: 2734, column: 9, scope: !3324)
!3336 = !DILocation(line: 2736, column: 16, scope: !3306)
!3337 = !DILocation(line: 2736, column: 9, scope: !3306)
!3338 = distinct !DISubprogram(name: "MPU_xQueueSelectFromSetFromISR", scope: !36, file: !36, line: 2780, type: !3339, scopeLine: 2781, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3339 = !DISubroutineType(types: !3340)
!3340 = !{!46, !45}
!3341 = !DILocalVariable(name: "xQueueSet", arg: 1, scope: !3338, file: !36, line: 2780, type: !45)
!3342 = !DILocation(line: 2780, column: 81, scope: !3338)
!3343 = !DILocalVariable(name: "xInternalQueueSetHandle", scope: !3338, file: !36, line: 2782, type: !45)
!3344 = !DILocation(line: 2782, column: 30, scope: !3338)
!3345 = !DILocalVariable(name: "xSelectedMemberInternal", scope: !3338, file: !36, line: 2783, type: !46)
!3346 = !DILocation(line: 2783, column: 36, scope: !3338)
!3347 = !DILocalVariable(name: "xSelectedMemberExternal", scope: !3338, file: !36, line: 2784, type: !46)
!3348 = !DILocation(line: 2784, column: 36, scope: !3338)
!3349 = !DILocalVariable(name: "lIndexQueueSet", scope: !3338, file: !36, line: 2785, type: !27)
!3350 = !DILocation(line: 2785, column: 21, scope: !3338)
!3351 = !DILocalVariable(name: "lIndexSelectedMember", scope: !3338, file: !36, line: 2785, type: !27)
!3352 = !DILocation(line: 2785, column: 37, scope: !3338)
!3353 = !DILocation(line: 2787, column: 42, scope: !3338)
!3354 = !DILocation(line: 2787, column: 30, scope: !3338)
!3355 = !DILocation(line: 2787, column: 28, scope: !3338)
!3356 = !DILocation(line: 2789, column: 17, scope: !3357)
!3357 = distinct !DILexicalBlock(scope: !3338, file: !36, line: 2789, column: 17)
!3358 = !DILocation(line: 0, scope: !3357)
!3359 = !DILocation(line: 2789, column: 59, scope: !3357)
!3360 = !DILocation(line: 2789, column: 17, scope: !3338)
!3361 = !DILocation(line: 2791, column: 43, scope: !3362)
!3362 = distinct !DILexicalBlock(scope: !3357, file: !36, line: 2790, column: 13)
!3363 = !DILocation(line: 2791, column: 41, scope: !3362)
!3364 = !DILocation(line: 2793, column: 21, scope: !3365)
!3365 = distinct !DILexicalBlock(scope: !3362, file: !36, line: 2793, column: 21)
!3366 = !DILocation(line: 2793, column: 45, scope: !3365)
!3367 = !DILocation(line: 2793, column: 21, scope: !3362)
!3368 = !DILocation(line: 2795, column: 75, scope: !3369)
!3369 = distinct !DILexicalBlock(scope: !3365, file: !36, line: 2794, column: 17)
!3370 = !DILocation(line: 2795, column: 47, scope: !3369)
!3371 = !DILocation(line: 2795, column: 45, scope: !3369)
!3372 = !DILocation(line: 2797, column: 25, scope: !3373)
!3373 = distinct !DILexicalBlock(scope: !3369, file: !36, line: 2797, column: 25)
!3374 = !DILocation(line: 2797, column: 49, scope: !3373)
!3375 = !DILocation(line: 2797, column: 25, scope: !3369)
!3376 = !DILocation(line: 2799, column: 48, scope: !3377)
!3377 = distinct !DILexicalBlock(scope: !3373, file: !36, line: 2798, column: 21)
!3378 = !DILocation(line: 2799, column: 46, scope: !3377)
!3379 = !DILocation(line: 2801, column: 29, scope: !3380)
!3380 = distinct !DILexicalBlock(scope: !3377, file: !36, line: 2801, column: 29)
!3381 = !DILocation(line: 2801, column: 50, scope: !3380)
!3382 = !DILocation(line: 2801, column: 29, scope: !3377)
!3383 = !DILocation(line: 2803, column: 84, scope: !3384)
!3384 = distinct !DILexicalBlock(scope: !3380, file: !36, line: 2802, column: 25)
!3385 = !DILocation(line: 2803, column: 55, scope: !3384)
!3386 = !DILocation(line: 2803, column: 53, scope: !3384)
!3387 = !DILocation(line: 2804, column: 25, scope: !3384)
!3388 = !DILocation(line: 2805, column: 21, scope: !3377)
!3389 = !DILocation(line: 2806, column: 17, scope: !3369)
!3390 = !DILocation(line: 2807, column: 13, scope: !3362)
!3391 = !DILocation(line: 2809, column: 20, scope: !3338)
!3392 = !DILocation(line: 2809, column: 13, scope: !3338)
!3393 = distinct !DISubprogram(name: "MPU_pvTimerGetTimerIDImpl", scope: !36, file: !36, line: 2823, type: !3394, scopeLine: 2824, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3394 = !DISubroutineType(types: !3395)
!3395 = !{!26, !3396}
!3396 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !50)
!3397 = !DILocalVariable(name: "xTimer", arg: 1, scope: !3393, file: !36, line: 2823, type: !3396)
!3398 = !DILocation(line: 2823, column: 63, scope: !3393)
!3399 = !DILocalVariable(name: "pvReturn", scope: !3393, file: !36, line: 2825, type: !26)
!3400 = !DILocation(line: 2825, column: 20, scope: !3393)
!3401 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3393, file: !36, line: 2826, type: !50)
!3402 = !DILocation(line: 2826, column: 27, scope: !3393)
!3403 = !DILocalVariable(name: "lIndex", scope: !3393, file: !36, line: 2827, type: !27)
!3404 = !DILocation(line: 2827, column: 21, scope: !3393)
!3405 = !DILocation(line: 2829, column: 34, scope: !3393)
!3406 = !DILocation(line: 2829, column: 22, scope: !3393)
!3407 = !DILocation(line: 2829, column: 20, scope: !3393)
!3408 = !DILocation(line: 2831, column: 17, scope: !3409)
!3409 = distinct !DILexicalBlock(scope: !3393, file: !36, line: 2831, column: 17)
!3410 = !DILocation(line: 0, scope: !3409)
!3411 = !DILocation(line: 2831, column: 51, scope: !3409)
!3412 = !DILocation(line: 2831, column: 17, scope: !3393)
!3413 = !DILocation(line: 2833, column: 40, scope: !3414)
!3414 = distinct !DILexicalBlock(scope: !3409, file: !36, line: 2832, column: 13)
!3415 = !DILocation(line: 2833, column: 38, scope: !3414)
!3416 = !DILocation(line: 2835, column: 21, scope: !3417)
!3417 = distinct !DILexicalBlock(scope: !3414, file: !36, line: 2835, column: 21)
!3418 = !DILocation(line: 2835, column: 42, scope: !3417)
!3419 = !DILocation(line: 2835, column: 21, scope: !3414)
!3420 = !DILocation(line: 2837, column: 51, scope: !3421)
!3421 = distinct !DILexicalBlock(scope: !3417, file: !36, line: 2836, column: 17)
!3422 = !DILocation(line: 2837, column: 32, scope: !3421)
!3423 = !DILocation(line: 2837, column: 30, scope: !3421)
!3424 = !DILocation(line: 2838, column: 17, scope: !3421)
!3425 = !DILocation(line: 2839, column: 13, scope: !3414)
!3426 = !DILocation(line: 2841, column: 20, scope: !3393)
!3427 = !DILocation(line: 2841, column: 13, scope: !3393)
!3428 = distinct !DISubprogram(name: "MPU_vTimerSetTimerIDImpl", scope: !36, file: !36, line: 2852, type: !3429, scopeLine: 2854, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3429 = !DISubroutineType(types: !3430)
!3430 = !{null, !50, !26}
!3431 = !DILocalVariable(name: "xTimer", arg: 1, scope: !3428, file: !36, line: 2852, type: !50)
!3432 = !DILocation(line: 2852, column: 54, scope: !3428)
!3433 = !DILocalVariable(name: "pvNewID", arg: 2, scope: !3428, file: !36, line: 2853, type: !26)
!3434 = !DILocation(line: 2853, column: 47, scope: !3428)
!3435 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3428, file: !36, line: 2855, type: !50)
!3436 = !DILocation(line: 2855, column: 27, scope: !3428)
!3437 = !DILocalVariable(name: "lIndex", scope: !3428, file: !36, line: 2856, type: !27)
!3438 = !DILocation(line: 2856, column: 21, scope: !3428)
!3439 = !DILocation(line: 2858, column: 34, scope: !3428)
!3440 = !DILocation(line: 2858, column: 22, scope: !3428)
!3441 = !DILocation(line: 2858, column: 20, scope: !3428)
!3442 = !DILocation(line: 2860, column: 17, scope: !3443)
!3443 = distinct !DILexicalBlock(scope: !3428, file: !36, line: 2860, column: 17)
!3444 = !DILocation(line: 0, scope: !3443)
!3445 = !DILocation(line: 2860, column: 51, scope: !3443)
!3446 = !DILocation(line: 2860, column: 17, scope: !3428)
!3447 = !DILocation(line: 2862, column: 40, scope: !3448)
!3448 = distinct !DILexicalBlock(scope: !3443, file: !36, line: 2861, column: 13)
!3449 = !DILocation(line: 2862, column: 38, scope: !3448)
!3450 = !DILocation(line: 2864, column: 21, scope: !3451)
!3451 = distinct !DILexicalBlock(scope: !3448, file: !36, line: 2864, column: 21)
!3452 = !DILocation(line: 2864, column: 42, scope: !3451)
!3453 = !DILocation(line: 2864, column: 21, scope: !3448)
!3454 = !DILocation(line: 2866, column: 39, scope: !3455)
!3455 = distinct !DILexicalBlock(scope: !3451, file: !36, line: 2865, column: 17)
!3456 = !DILocation(line: 2866, column: 61, scope: !3455)
!3457 = !DILocation(line: 2866, column: 21, scope: !3455)
!3458 = !DILocation(line: 2867, column: 17, scope: !3455)
!3459 = !DILocation(line: 2868, column: 13, scope: !3448)
!3460 = !DILocation(line: 2869, column: 9, scope: !3428)
!3461 = distinct !DISubprogram(name: "MPU_xTimerIsTimerActiveImpl", scope: !36, file: !36, line: 2878, type: !3462, scopeLine: 2879, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3462 = !DISubroutineType(types: !3463)
!3463 = !{!23, !50}
!3464 = !DILocalVariable(name: "xTimer", arg: 1, scope: !3461, file: !36, line: 2878, type: !50)
!3465 = !DILocation(line: 2878, column: 63, scope: !3461)
!3466 = !DILocalVariable(name: "xReturn", scope: !3461, file: !36, line: 2880, type: !23)
!3467 = !DILocation(line: 2880, column: 24, scope: !3461)
!3468 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3461, file: !36, line: 2881, type: !50)
!3469 = !DILocation(line: 2881, column: 27, scope: !3461)
!3470 = !DILocalVariable(name: "lIndex", scope: !3461, file: !36, line: 2882, type: !27)
!3471 = !DILocation(line: 2882, column: 21, scope: !3461)
!3472 = !DILocation(line: 2884, column: 34, scope: !3461)
!3473 = !DILocation(line: 2884, column: 22, scope: !3461)
!3474 = !DILocation(line: 2884, column: 20, scope: !3461)
!3475 = !DILocation(line: 2886, column: 17, scope: !3476)
!3476 = distinct !DILexicalBlock(scope: !3461, file: !36, line: 2886, column: 17)
!3477 = !DILocation(line: 0, scope: !3476)
!3478 = !DILocation(line: 2886, column: 51, scope: !3476)
!3479 = !DILocation(line: 2886, column: 17, scope: !3461)
!3480 = !DILocation(line: 2888, column: 40, scope: !3481)
!3481 = distinct !DILexicalBlock(scope: !3476, file: !36, line: 2887, column: 13)
!3482 = !DILocation(line: 2888, column: 38, scope: !3481)
!3483 = !DILocation(line: 2890, column: 21, scope: !3484)
!3484 = distinct !DILexicalBlock(scope: !3481, file: !36, line: 2890, column: 21)
!3485 = !DILocation(line: 2890, column: 42, scope: !3484)
!3486 = !DILocation(line: 2890, column: 21, scope: !3481)
!3487 = !DILocation(line: 2892, column: 52, scope: !3488)
!3488 = distinct !DILexicalBlock(scope: !3484, file: !36, line: 2891, column: 17)
!3489 = !DILocation(line: 2892, column: 31, scope: !3488)
!3490 = !DILocation(line: 2892, column: 29, scope: !3488)
!3491 = !DILocation(line: 2893, column: 17, scope: !3488)
!3492 = !DILocation(line: 2894, column: 13, scope: !3481)
!3493 = !DILocation(line: 2896, column: 20, scope: !3461)
!3494 = !DILocation(line: 2896, column: 13, scope: !3461)
!3495 = distinct !DISubprogram(name: "MPU_xTimerGetTimerDaemonTaskHandleImpl", scope: !36, file: !36, line: 2906, type: !361, scopeLine: 2907, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3496 = !DILocalVariable(name: "xReturn", scope: !3495, file: !36, line: 2908, type: !32)
!3497 = !DILocation(line: 2908, column: 26, scope: !3495)
!3498 = !DILocation(line: 2910, column: 23, scope: !3495)
!3499 = !DILocation(line: 2910, column: 21, scope: !3495)
!3500 = !DILocation(line: 2912, column: 20, scope: !3495)
!3501 = !DILocation(line: 2912, column: 13, scope: !3495)
!3502 = distinct !DISubprogram(name: "MPU_xTimerGenericCommandImpl", scope: !36, file: !36, line: 2926, type: !3503, scopeLine: 2931, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3503 = !DISubroutineType(types: !3504)
!3504 = !{!23, !50, !3085, !3505, !3084, !3505}
!3505 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !93)
!3506 = !DILocalVariable(name: "xTimer", arg: 1, scope: !3502, file: !36, line: 2926, type: !50)
!3507 = !DILocation(line: 2926, column: 64, scope: !3502)
!3508 = !DILocalVariable(name: "xCommandID", arg: 2, scope: !3502, file: !36, line: 2927, type: !3085)
!3509 = !DILocation(line: 2927, column: 67, scope: !3502)
!3510 = !DILocalVariable(name: "xOptionalValue", arg: 3, scope: !3502, file: !36, line: 2928, type: !3505)
!3511 = !DILocation(line: 2928, column: 67, scope: !3502)
!3512 = !DILocalVariable(name: "pxHigherPriorityTaskWoken", arg: 4, scope: !3502, file: !36, line: 2929, type: !3084)
!3513 = !DILocation(line: 2929, column: 69, scope: !3502)
!3514 = !DILocalVariable(name: "xTicksToWait", arg: 5, scope: !3502, file: !36, line: 2930, type: !3505)
!3515 = !DILocation(line: 2930, column: 67, scope: !3502)
!3516 = !DILocalVariable(name: "xReturn", scope: !3502, file: !36, line: 2932, type: !23)
!3517 = !DILocation(line: 2932, column: 24, scope: !3502)
!3518 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3502, file: !36, line: 2933, type: !50)
!3519 = !DILocation(line: 2933, column: 27, scope: !3502)
!3520 = !DILocalVariable(name: "lIndex", scope: !3502, file: !36, line: 2934, type: !27)
!3521 = !DILocation(line: 2934, column: 21, scope: !3502)
!3522 = !DILocalVariable(name: "xIsHigherPriorityTaskWokenWriteable", scope: !3502, file: !36, line: 2935, type: !23)
!3523 = !DILocation(line: 2935, column: 24, scope: !3502)
!3524 = !DILocation(line: 2937, column: 17, scope: !3525)
!3525 = distinct !DILexicalBlock(scope: !3502, file: !36, line: 2937, column: 17)
!3526 = !DILocation(line: 2937, column: 43, scope: !3525)
!3527 = !DILocation(line: 2937, column: 17, scope: !3502)
!3528 = !DILocation(line: 2939, column: 88, scope: !3529)
!3529 = distinct !DILexicalBlock(scope: !3525, file: !36, line: 2938, column: 13)
!3530 = !DILocation(line: 2939, column: 55, scope: !3529)
!3531 = !DILocation(line: 2939, column: 53, scope: !3529)
!3532 = !DILocation(line: 2942, column: 13, scope: !3529)
!3533 = !DILocation(line: 2944, column: 19, scope: !3534)
!3534 = distinct !DILexicalBlock(scope: !3502, file: !36, line: 2944, column: 17)
!3535 = !DILocation(line: 2944, column: 45, scope: !3534)
!3536 = !DILocation(line: 2944, column: 55, scope: !3534)
!3537 = !DILocation(line: 2944, column: 60, scope: !3534)
!3538 = !DILocation(line: 2944, column: 96, scope: !3534)
!3539 = !DILocation(line: 2944, column: 17, scope: !3502)
!3540 = !DILocation(line: 2946, column: 38, scope: !3541)
!3541 = distinct !DILexicalBlock(scope: !3534, file: !36, line: 2945, column: 13)
!3542 = !DILocation(line: 2946, column: 26, scope: !3541)
!3543 = !DILocation(line: 2946, column: 24, scope: !3541)
!3544 = !DILocation(line: 2948, column: 21, scope: !3545)
!3545 = distinct !DILexicalBlock(scope: !3541, file: !36, line: 2948, column: 21)
!3546 = !DILocation(line: 0, scope: !3545)
!3547 = !DILocation(line: 2948, column: 55, scope: !3545)
!3548 = !DILocation(line: 2948, column: 21, scope: !3541)
!3549 = !DILocation(line: 2950, column: 44, scope: !3550)
!3550 = distinct !DILexicalBlock(scope: !3545, file: !36, line: 2949, column: 17)
!3551 = !DILocation(line: 2950, column: 42, scope: !3550)
!3552 = !DILocation(line: 2952, column: 25, scope: !3553)
!3553 = distinct !DILexicalBlock(scope: !3550, file: !36, line: 2952, column: 25)
!3554 = !DILocation(line: 2952, column: 46, scope: !3553)
!3555 = !DILocation(line: 2952, column: 25, scope: !3550)
!3556 = !DILocation(line: 2954, column: 57, scope: !3557)
!3557 = distinct !DILexicalBlock(scope: !3553, file: !36, line: 2953, column: 21)
!3558 = !DILocation(line: 2954, column: 79, scope: !3557)
!3559 = !DILocation(line: 2954, column: 91, scope: !3557)
!3560 = !DILocation(line: 2954, column: 107, scope: !3557)
!3561 = !DILocation(line: 2954, column: 134, scope: !3557)
!3562 = !DILocation(line: 2954, column: 35, scope: !3557)
!3563 = !DILocation(line: 2954, column: 33, scope: !3557)
!3564 = !DILocation(line: 2955, column: 21, scope: !3557)
!3565 = !DILocation(line: 2956, column: 17, scope: !3550)
!3566 = !DILocation(line: 2957, column: 13, scope: !3541)
!3567 = !DILocation(line: 2959, column: 20, scope: !3502)
!3568 = !DILocation(line: 2959, column: 13, scope: !3502)
!3569 = distinct !DISubprogram(name: "MPU_pcTimerGetNameImpl", scope: !36, file: !36, line: 2969, type: !3570, scopeLine: 2970, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3570 = !DISubroutineType(types: !3571)
!3571 = !{!286, !50}
!3572 = !DILocalVariable(name: "xTimer", arg: 1, scope: !3569, file: !36, line: 2969, type: !50)
!3573 = !DILocation(line: 2969, column: 60, scope: !3569)
!3574 = !DILocalVariable(name: "pcReturn", scope: !3569, file: !36, line: 2971, type: !286)
!3575 = !DILocation(line: 2971, column: 26, scope: !3569)
!3576 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3569, file: !36, line: 2972, type: !50)
!3577 = !DILocation(line: 2972, column: 27, scope: !3569)
!3578 = !DILocalVariable(name: "lIndex", scope: !3569, file: !36, line: 2973, type: !27)
!3579 = !DILocation(line: 2973, column: 21, scope: !3569)
!3580 = !DILocation(line: 2975, column: 34, scope: !3569)
!3581 = !DILocation(line: 2975, column: 22, scope: !3569)
!3582 = !DILocation(line: 2975, column: 20, scope: !3569)
!3583 = !DILocation(line: 2977, column: 17, scope: !3584)
!3584 = distinct !DILexicalBlock(scope: !3569, file: !36, line: 2977, column: 17)
!3585 = !DILocation(line: 0, scope: !3584)
!3586 = !DILocation(line: 2977, column: 51, scope: !3584)
!3587 = !DILocation(line: 2977, column: 17, scope: !3569)
!3588 = !DILocation(line: 2979, column: 40, scope: !3589)
!3589 = distinct !DILexicalBlock(scope: !3584, file: !36, line: 2978, column: 13)
!3590 = !DILocation(line: 2979, column: 38, scope: !3589)
!3591 = !DILocation(line: 2981, column: 21, scope: !3592)
!3592 = distinct !DILexicalBlock(scope: !3589, file: !36, line: 2981, column: 21)
!3593 = !DILocation(line: 2981, column: 42, scope: !3592)
!3594 = !DILocation(line: 2981, column: 21, scope: !3589)
!3595 = !DILocation(line: 2983, column: 48, scope: !3596)
!3596 = distinct !DILexicalBlock(scope: !3592, file: !36, line: 2982, column: 17)
!3597 = !DILocation(line: 2983, column: 32, scope: !3596)
!3598 = !DILocation(line: 2983, column: 30, scope: !3596)
!3599 = !DILocation(line: 2984, column: 17, scope: !3596)
!3600 = !DILocation(line: 2985, column: 13, scope: !3589)
!3601 = !DILocation(line: 2987, column: 20, scope: !3569)
!3602 = !DILocation(line: 2987, column: 13, scope: !3569)
!3603 = distinct !DISubprogram(name: "MPU_vTimerSetReloadModeImpl", scope: !36, file: !36, line: 2998, type: !3604, scopeLine: 3000, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3604 = !DISubroutineType(types: !3605)
!3605 = !{null, !50, !2747}
!3606 = !DILocalVariable(name: "xTimer", arg: 1, scope: !3603, file: !36, line: 2998, type: !50)
!3607 = !DILocation(line: 2998, column: 57, scope: !3603)
!3608 = !DILocalVariable(name: "uxAutoReload", arg: 2, scope: !3603, file: !36, line: 2999, type: !2747)
!3609 = !DILocation(line: 2999, column: 61, scope: !3603)
!3610 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3603, file: !36, line: 3001, type: !50)
!3611 = !DILocation(line: 3001, column: 27, scope: !3603)
!3612 = !DILocalVariable(name: "lIndex", scope: !3603, file: !36, line: 3002, type: !27)
!3613 = !DILocation(line: 3002, column: 21, scope: !3603)
!3614 = !DILocation(line: 3004, column: 34, scope: !3603)
!3615 = !DILocation(line: 3004, column: 22, scope: !3603)
!3616 = !DILocation(line: 3004, column: 20, scope: !3603)
!3617 = !DILocation(line: 3006, column: 17, scope: !3618)
!3618 = distinct !DILexicalBlock(scope: !3603, file: !36, line: 3006, column: 17)
!3619 = !DILocation(line: 0, scope: !3618)
!3620 = !DILocation(line: 3006, column: 51, scope: !3618)
!3621 = !DILocation(line: 3006, column: 17, scope: !3603)
!3622 = !DILocation(line: 3008, column: 40, scope: !3623)
!3623 = distinct !DILexicalBlock(scope: !3618, file: !36, line: 3007, column: 13)
!3624 = !DILocation(line: 3008, column: 38, scope: !3623)
!3625 = !DILocation(line: 3010, column: 21, scope: !3626)
!3626 = distinct !DILexicalBlock(scope: !3623, file: !36, line: 3010, column: 21)
!3627 = !DILocation(line: 3010, column: 42, scope: !3626)
!3628 = !DILocation(line: 3010, column: 21, scope: !3623)
!3629 = !DILocation(line: 3012, column: 42, scope: !3630)
!3630 = distinct !DILexicalBlock(scope: !3626, file: !36, line: 3011, column: 17)
!3631 = !DILocation(line: 3012, column: 64, scope: !3630)
!3632 = !DILocation(line: 3012, column: 21, scope: !3630)
!3633 = !DILocation(line: 3013, column: 17, scope: !3630)
!3634 = !DILocation(line: 3014, column: 13, scope: !3623)
!3635 = !DILocation(line: 3015, column: 9, scope: !3603)
!3636 = distinct !DISubprogram(name: "MPU_xTimerGetReloadModeImpl", scope: !36, file: !36, line: 3024, type: !3462, scopeLine: 3025, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3637 = !DILocalVariable(name: "xTimer", arg: 1, scope: !3636, file: !36, line: 3024, type: !50)
!3638 = !DILocation(line: 3024, column: 63, scope: !3636)
!3639 = !DILocalVariable(name: "xReturn", scope: !3636, file: !36, line: 3026, type: !23)
!3640 = !DILocation(line: 3026, column: 24, scope: !3636)
!3641 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3636, file: !36, line: 3027, type: !50)
!3642 = !DILocation(line: 3027, column: 27, scope: !3636)
!3643 = !DILocalVariable(name: "lIndex", scope: !3636, file: !36, line: 3028, type: !27)
!3644 = !DILocation(line: 3028, column: 21, scope: !3636)
!3645 = !DILocation(line: 3030, column: 34, scope: !3636)
!3646 = !DILocation(line: 3030, column: 22, scope: !3636)
!3647 = !DILocation(line: 3030, column: 20, scope: !3636)
!3648 = !DILocation(line: 3032, column: 17, scope: !3649)
!3649 = distinct !DILexicalBlock(scope: !3636, file: !36, line: 3032, column: 17)
!3650 = !DILocation(line: 0, scope: !3649)
!3651 = !DILocation(line: 3032, column: 51, scope: !3649)
!3652 = !DILocation(line: 3032, column: 17, scope: !3636)
!3653 = !DILocation(line: 3034, column: 40, scope: !3654)
!3654 = distinct !DILexicalBlock(scope: !3649, file: !36, line: 3033, column: 13)
!3655 = !DILocation(line: 3034, column: 38, scope: !3654)
!3656 = !DILocation(line: 3036, column: 21, scope: !3657)
!3657 = distinct !DILexicalBlock(scope: !3654, file: !36, line: 3036, column: 21)
!3658 = !DILocation(line: 3036, column: 42, scope: !3657)
!3659 = !DILocation(line: 3036, column: 21, scope: !3654)
!3660 = !DILocation(line: 3038, column: 52, scope: !3661)
!3661 = distinct !DILexicalBlock(scope: !3657, file: !36, line: 3037, column: 17)
!3662 = !DILocation(line: 3038, column: 31, scope: !3661)
!3663 = !DILocation(line: 3038, column: 29, scope: !3661)
!3664 = !DILocation(line: 3039, column: 17, scope: !3661)
!3665 = !DILocation(line: 3040, column: 13, scope: !3654)
!3666 = !DILocation(line: 3042, column: 20, scope: !3636)
!3667 = !DILocation(line: 3042, column: 13, scope: !3636)
!3668 = distinct !DISubprogram(name: "MPU_uxTimerGetReloadModeImpl", scope: !36, file: !36, line: 3052, type: !3669, scopeLine: 3053, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3669 = !DISubroutineType(types: !3670)
!3670 = !{!39, !50}
!3671 = !DILocalVariable(name: "xTimer", arg: 1, scope: !3668, file: !36, line: 3052, type: !50)
!3672 = !DILocation(line: 3052, column: 65, scope: !3668)
!3673 = !DILocalVariable(name: "uxReturn", scope: !3668, file: !36, line: 3054, type: !39)
!3674 = !DILocation(line: 3054, column: 25, scope: !3668)
!3675 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3668, file: !36, line: 3055, type: !50)
!3676 = !DILocation(line: 3055, column: 27, scope: !3668)
!3677 = !DILocalVariable(name: "lIndex", scope: !3668, file: !36, line: 3056, type: !27)
!3678 = !DILocation(line: 3056, column: 21, scope: !3668)
!3679 = !DILocation(line: 3058, column: 34, scope: !3668)
!3680 = !DILocation(line: 3058, column: 22, scope: !3668)
!3681 = !DILocation(line: 3058, column: 20, scope: !3668)
!3682 = !DILocation(line: 3060, column: 17, scope: !3683)
!3683 = distinct !DILexicalBlock(scope: !3668, file: !36, line: 3060, column: 17)
!3684 = !DILocation(line: 0, scope: !3683)
!3685 = !DILocation(line: 3060, column: 51, scope: !3683)
!3686 = !DILocation(line: 3060, column: 17, scope: !3668)
!3687 = !DILocation(line: 3062, column: 40, scope: !3688)
!3688 = distinct !DILexicalBlock(scope: !3683, file: !36, line: 3061, column: 13)
!3689 = !DILocation(line: 3062, column: 38, scope: !3688)
!3690 = !DILocation(line: 3064, column: 21, scope: !3691)
!3691 = distinct !DILexicalBlock(scope: !3688, file: !36, line: 3064, column: 21)
!3692 = !DILocation(line: 3064, column: 42, scope: !3691)
!3693 = !DILocation(line: 3064, column: 21, scope: !3688)
!3694 = !DILocation(line: 3066, column: 54, scope: !3695)
!3695 = distinct !DILexicalBlock(scope: !3691, file: !36, line: 3065, column: 17)
!3696 = !DILocation(line: 3066, column: 32, scope: !3695)
!3697 = !DILocation(line: 3066, column: 30, scope: !3695)
!3698 = !DILocation(line: 3067, column: 17, scope: !3695)
!3699 = !DILocation(line: 3068, column: 13, scope: !3688)
!3700 = !DILocation(line: 3070, column: 20, scope: !3668)
!3701 = !DILocation(line: 3070, column: 13, scope: !3668)
!3702 = distinct !DISubprogram(name: "MPU_xTimerGetPeriodImpl", scope: !36, file: !36, line: 3080, type: !3703, scopeLine: 3081, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3703 = !DISubroutineType(types: !3704)
!3704 = !{!93, !50}
!3705 = !DILocalVariable(name: "xTimer", arg: 1, scope: !3702, file: !36, line: 3080, type: !50)
!3706 = !DILocation(line: 3080, column: 59, scope: !3702)
!3707 = !DILocalVariable(name: "xReturn", scope: !3702, file: !36, line: 3082, type: !93)
!3708 = !DILocation(line: 3082, column: 24, scope: !3702)
!3709 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3702, file: !36, line: 3083, type: !50)
!3710 = !DILocation(line: 3083, column: 27, scope: !3702)
!3711 = !DILocalVariable(name: "lIndex", scope: !3702, file: !36, line: 3084, type: !27)
!3712 = !DILocation(line: 3084, column: 21, scope: !3702)
!3713 = !DILocation(line: 3086, column: 34, scope: !3702)
!3714 = !DILocation(line: 3086, column: 22, scope: !3702)
!3715 = !DILocation(line: 3086, column: 20, scope: !3702)
!3716 = !DILocation(line: 3088, column: 17, scope: !3717)
!3717 = distinct !DILexicalBlock(scope: !3702, file: !36, line: 3088, column: 17)
!3718 = !DILocation(line: 0, scope: !3717)
!3719 = !DILocation(line: 3088, column: 51, scope: !3717)
!3720 = !DILocation(line: 3088, column: 17, scope: !3702)
!3721 = !DILocation(line: 3090, column: 40, scope: !3722)
!3722 = distinct !DILexicalBlock(scope: !3717, file: !36, line: 3089, column: 13)
!3723 = !DILocation(line: 3090, column: 38, scope: !3722)
!3724 = !DILocation(line: 3092, column: 21, scope: !3725)
!3725 = distinct !DILexicalBlock(scope: !3722, file: !36, line: 3092, column: 21)
!3726 = !DILocation(line: 3092, column: 42, scope: !3725)
!3727 = !DILocation(line: 3092, column: 21, scope: !3722)
!3728 = !DILocation(line: 3094, column: 48, scope: !3729)
!3729 = distinct !DILexicalBlock(scope: !3725, file: !36, line: 3093, column: 17)
!3730 = !DILocation(line: 3094, column: 31, scope: !3729)
!3731 = !DILocation(line: 3094, column: 29, scope: !3729)
!3732 = !DILocation(line: 3095, column: 17, scope: !3729)
!3733 = !DILocation(line: 3096, column: 13, scope: !3722)
!3734 = !DILocation(line: 3098, column: 20, scope: !3702)
!3735 = !DILocation(line: 3098, column: 13, scope: !3702)
!3736 = distinct !DISubprogram(name: "MPU_xTimerGetExpiryTimeImpl", scope: !36, file: !36, line: 3108, type: !3703, scopeLine: 3109, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3737 = !DILocalVariable(name: "xTimer", arg: 1, scope: !3736, file: !36, line: 3108, type: !50)
!3738 = !DILocation(line: 3108, column: 63, scope: !3736)
!3739 = !DILocalVariable(name: "xReturn", scope: !3736, file: !36, line: 3110, type: !93)
!3740 = !DILocation(line: 3110, column: 24, scope: !3736)
!3741 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3736, file: !36, line: 3111, type: !50)
!3742 = !DILocation(line: 3111, column: 27, scope: !3736)
!3743 = !DILocalVariable(name: "lIndex", scope: !3736, file: !36, line: 3112, type: !27)
!3744 = !DILocation(line: 3112, column: 21, scope: !3736)
!3745 = !DILocation(line: 3114, column: 34, scope: !3736)
!3746 = !DILocation(line: 3114, column: 22, scope: !3736)
!3747 = !DILocation(line: 3114, column: 20, scope: !3736)
!3748 = !DILocation(line: 3116, column: 17, scope: !3749)
!3749 = distinct !DILexicalBlock(scope: !3736, file: !36, line: 3116, column: 17)
!3750 = !DILocation(line: 0, scope: !3749)
!3751 = !DILocation(line: 3116, column: 51, scope: !3749)
!3752 = !DILocation(line: 3116, column: 17, scope: !3736)
!3753 = !DILocation(line: 3118, column: 40, scope: !3754)
!3754 = distinct !DILexicalBlock(scope: !3749, file: !36, line: 3117, column: 13)
!3755 = !DILocation(line: 3118, column: 38, scope: !3754)
!3756 = !DILocation(line: 3120, column: 21, scope: !3757)
!3757 = distinct !DILexicalBlock(scope: !3754, file: !36, line: 3120, column: 21)
!3758 = !DILocation(line: 3120, column: 42, scope: !3757)
!3759 = !DILocation(line: 3120, column: 21, scope: !3754)
!3760 = !DILocation(line: 3122, column: 52, scope: !3761)
!3761 = distinct !DILexicalBlock(scope: !3757, file: !36, line: 3121, column: 17)
!3762 = !DILocation(line: 3122, column: 31, scope: !3761)
!3763 = !DILocation(line: 3122, column: 29, scope: !3761)
!3764 = !DILocation(line: 3123, column: 17, scope: !3761)
!3765 = !DILocation(line: 3124, column: 13, scope: !3754)
!3766 = !DILocation(line: 3126, column: 20, scope: !3736)
!3767 = !DILocation(line: 3126, column: 13, scope: !3736)
!3768 = distinct !DISubprogram(name: "MPU_xTimerCreate", scope: !36, file: !36, line: 3139, type: !3769, scopeLine: 3144, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3769 = !DISubroutineType(types: !3770)
!3770 = !{!50, !1314, !3505, !2747, !1480, !62}
!3771 = !DILocalVariable(name: "pcTimerName", arg: 1, scope: !3768, file: !36, line: 3139, type: !1314)
!3772 = !DILocation(line: 3139, column: 60, scope: !3768)
!3773 = !DILocalVariable(name: "xTimerPeriodInTicks", arg: 2, scope: !3768, file: !36, line: 3140, type: !3505)
!3774 = !DILocation(line: 3140, column: 58, scope: !3768)
!3775 = !DILocalVariable(name: "uxAutoReload", arg: 3, scope: !3768, file: !36, line: 3141, type: !2747)
!3776 = !DILocation(line: 3141, column: 59, scope: !3768)
!3777 = !DILocalVariable(name: "pvTimerID", arg: 4, scope: !3768, file: !36, line: 3142, type: !1480)
!3778 = !DILocation(line: 3142, column: 54, scope: !3768)
!3779 = !DILocalVariable(name: "pxCallbackFunction", arg: 5, scope: !3768, file: !36, line: 3143, type: !62)
!3780 = !DILocation(line: 3143, column: 65, scope: !3768)
!3781 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3768, file: !36, line: 3145, type: !50)
!3782 = !DILocation(line: 3145, column: 27, scope: !3768)
!3783 = !DILocalVariable(name: "xExternalTimerHandle", scope: !3768, file: !36, line: 3146, type: !50)
!3784 = !DILocation(line: 3146, column: 27, scope: !3768)
!3785 = !DILocalVariable(name: "lIndex", scope: !3768, file: !36, line: 3147, type: !27)
!3786 = !DILocation(line: 3147, column: 21, scope: !3768)
!3787 = !DILocation(line: 3149, column: 22, scope: !3768)
!3788 = !DILocation(line: 3149, column: 20, scope: !3768)
!3789 = !DILocation(line: 3151, column: 17, scope: !3790)
!3790 = distinct !DILexicalBlock(scope: !3768, file: !36, line: 3151, column: 17)
!3791 = !DILocation(line: 3151, column: 24, scope: !3790)
!3792 = !DILocation(line: 3151, column: 17, scope: !3768)
!3793 = !DILocation(line: 3153, column: 54, scope: !3794)
!3794 = distinct !DILexicalBlock(scope: !3790, file: !36, line: 3152, column: 13)
!3795 = !DILocation(line: 3153, column: 67, scope: !3794)
!3796 = !DILocation(line: 3153, column: 88, scope: !3794)
!3797 = !DILocation(line: 3153, column: 102, scope: !3794)
!3798 = !DILocation(line: 3153, column: 40, scope: !3794)
!3799 = !DILocation(line: 3153, column: 38, scope: !3794)
!3800 = !DILocation(line: 3155, column: 21, scope: !3801)
!3801 = distinct !DILexicalBlock(scope: !3794, file: !36, line: 3155, column: 21)
!3802 = !DILocation(line: 3155, column: 42, scope: !3801)
!3803 = !DILocation(line: 3155, column: 21, scope: !3794)
!3804 = !DILocation(line: 3157, column: 21, scope: !3805)
!3805 = distinct !DILexicalBlock(scope: !3801, file: !36, line: 3156, column: 17)
!3806 = !DILocation(line: 3158, column: 62, scope: !3805)
!3807 = !DILocation(line: 3158, column: 44, scope: !3805)
!3808 = !DILocation(line: 3158, column: 42, scope: !3805)
!3809 = !DILocation(line: 3159, column: 17, scope: !3805)
!3810 = !DILocation(line: 3162, column: 57, scope: !3811)
!3811 = distinct !DILexicalBlock(scope: !3801, file: !36, line: 3161, column: 17)
!3812 = !DILocation(line: 3162, column: 21, scope: !3811)
!3813 = !DILocation(line: 3164, column: 13, scope: !3794)
!3814 = !DILocation(line: 3166, column: 20, scope: !3768)
!3815 = !DILocation(line: 3166, column: 13, scope: !3768)
!3816 = distinct !DISubprogram(name: "MPU_TimerCallback", scope: !36, file: !36, line: 325, type: !64, scopeLine: 326, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3817 = !DILocalVariable(name: "xInternalHandle", arg: 1, scope: !3816, file: !36, line: 325, type: !50)
!3818 = !DILocation(line: 325, column: 54, scope: !3816)
!3819 = !DILocalVariable(name: "i", scope: !3816, file: !36, line: 327, type: !27)
!3820 = !DILocation(line: 327, column: 21, scope: !3816)
!3821 = !DILocalVariable(name: "lIndex", scope: !3816, file: !36, line: 327, type: !27)
!3822 = !DILocation(line: 327, column: 24, scope: !3816)
!3823 = !DILocalVariable(name: "xExternalHandle", scope: !3816, file: !36, line: 328, type: !50)
!3824 = !DILocation(line: 328, column: 27, scope: !3816)
!3825 = !DILocalVariable(name: "pxApplicationCallBack", scope: !3816, file: !36, line: 329, type: !62)
!3826 = !DILocation(line: 329, column: 37, scope: !3816)
!3827 = !DILocation(line: 332, column: 13, scope: !3828)
!3828 = distinct !DILexicalBlock(scope: !3816, file: !36, line: 332, column: 13)
!3829 = !DILocation(line: 332, column: 13, scope: !3816)
!3830 = !DILocation(line: 334, column: 20, scope: !3831)
!3831 = distinct !DILexicalBlock(scope: !3816, file: !36, line: 334, column: 13)
!3832 = !DILocation(line: 334, column: 18, scope: !3831)
!3833 = !DILocation(line: 334, column: 25, scope: !3834)
!3834 = distinct !DILexicalBlock(scope: !3831, file: !36, line: 334, column: 13)
!3835 = !DILocation(line: 334, column: 27, scope: !3834)
!3836 = !DILocation(line: 334, column: 13, scope: !3831)
!3837 = !DILocation(line: 336, column: 60, scope: !3838)
!3838 = distinct !DILexicalBlock(scope: !3839, file: !36, line: 336, column: 21)
!3839 = distinct !DILexicalBlock(scope: !3834, file: !36, line: 335, column: 13)
!3840 = !DILocation(line: 336, column: 41, scope: !3838)
!3841 = !DILocation(line: 336, column: 64, scope: !3838)
!3842 = !DILocation(line: 336, column: 23, scope: !3838)
!3843 = !DILocation(line: 336, column: 89, scope: !3838)
!3844 = !DILocation(line: 336, column: 86, scope: !3838)
!3845 = !DILocation(line: 336, column: 107, scope: !3838)
!3846 = !DILocation(line: 337, column: 42, scope: !3838)
!3847 = !DILocation(line: 337, column: 23, scope: !3838)
!3848 = !DILocation(line: 337, column: 46, scope: !3838)
!3849 = !DILocation(line: 337, column: 65, scope: !3838)
!3850 = !DILocation(line: 336, column: 21, scope: !3839)
!3851 = !DILocation(line: 339, column: 30, scope: !3852)
!3852 = distinct !DILexicalBlock(scope: !3838, file: !36, line: 338, column: 17)
!3853 = !DILocation(line: 339, column: 28, scope: !3852)
!3854 = !DILocation(line: 340, column: 21, scope: !3852)
!3855 = !DILocation(line: 342, column: 13, scope: !3839)
!3856 = !DILocation(line: 334, column: 71, scope: !3834)
!3857 = !DILocation(line: 334, column: 13, scope: !3834)
!3858 = distinct !{!3858, !3836, !3859}
!3859 = !DILocation(line: 342, column: 13, scope: !3831)
!3860 = !DILocation(line: 344, column: 13, scope: !3861)
!3861 = distinct !DILexicalBlock(scope: !3816, file: !36, line: 344, column: 13)
!3862 = !DILocation(line: 344, column: 13, scope: !3816)
!3863 = !DILocation(line: 345, column: 49, scope: !3816)
!3864 = !DILocation(line: 345, column: 31, scope: !3816)
!3865 = !DILocation(line: 345, column: 29, scope: !3816)
!3866 = !DILocation(line: 347, column: 84, scope: !3816)
!3867 = !DILocation(line: 347, column: 65, scope: !3816)
!3868 = !DILocation(line: 347, column: 93, scope: !3816)
!3869 = !DILocation(line: 347, column: 37, scope: !3816)
!3870 = !DILocation(line: 347, column: 35, scope: !3816)
!3871 = !DILocation(line: 348, column: 13, scope: !3816)
!3872 = !DILocation(line: 348, column: 36, scope: !3816)
!3873 = !DILocation(line: 349, column: 9, scope: !3816)
!3874 = distinct !DISubprogram(name: "MPU_xTimerCreateStatic", scope: !36, file: !36, line: 3174, type: !3875, scopeLine: 3180, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3875 = !DISubroutineType(types: !3876)
!3876 = !{!50, !1314, !3505, !2747, !1480, !62, !3877}
!3877 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3878, size: 64)
!3878 = !DIDerivedType(tag: DW_TAG_typedef, name: "StaticTimer_t", file: !1485, line: 1417, baseType: !3879)
!3879 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xSTATIC_TIMER", file: !1485, line: 1406, size: 704, elements: !3880)
!3880 = !{!3881, !3882, !3883, !3884, !3885, !3886, !3887}
!3881 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy1", scope: !3879, file: !1485, line: 1408, baseType: !26, size: 64)
!3882 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy2", scope: !3879, file: !1485, line: 1409, baseType: !1506, size: 320, offset: 64)
!3883 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy3", scope: !3879, file: !1485, line: 1410, baseType: !93, size: 64, offset: 384)
!3884 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy5", scope: !3879, file: !1485, line: 1411, baseType: !26, size: 64, offset: 448)
!3885 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy6", scope: !3879, file: !1485, line: 1412, baseType: !1309, size: 64, offset: 512)
!3886 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy7", scope: !3879, file: !1485, line: 1414, baseType: !39, size: 64, offset: 576)
!3887 = !DIDerivedType(tag: DW_TAG_member, name: "ucDummy8", scope: !3879, file: !1485, line: 1416, baseType: !1520, size: 8, offset: 640)
!3888 = !DILocalVariable(name: "pcTimerName", arg: 1, scope: !3874, file: !36, line: 3174, type: !1314)
!3889 = !DILocation(line: 3174, column: 66, scope: !3874)
!3890 = !DILocalVariable(name: "xTimerPeriodInTicks", arg: 2, scope: !3874, file: !36, line: 3175, type: !3505)
!3891 = !DILocation(line: 3175, column: 64, scope: !3874)
!3892 = !DILocalVariable(name: "uxAutoReload", arg: 3, scope: !3874, file: !36, line: 3176, type: !2747)
!3893 = !DILocation(line: 3176, column: 65, scope: !3874)
!3894 = !DILocalVariable(name: "pvTimerID", arg: 4, scope: !3874, file: !36, line: 3177, type: !1480)
!3895 = !DILocation(line: 3177, column: 60, scope: !3874)
!3896 = !DILocalVariable(name: "pxCallbackFunction", arg: 5, scope: !3874, file: !36, line: 3178, type: !62)
!3897 = !DILocation(line: 3178, column: 71, scope: !3874)
!3898 = !DILocalVariable(name: "pxTimerBuffer", arg: 6, scope: !3874, file: !36, line: 3179, type: !3877)
!3899 = !DILocation(line: 3179, column: 63, scope: !3874)
!3900 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3874, file: !36, line: 3181, type: !50)
!3901 = !DILocation(line: 3181, column: 27, scope: !3874)
!3902 = !DILocalVariable(name: "xExternalTimerHandle", scope: !3874, file: !36, line: 3182, type: !50)
!3903 = !DILocation(line: 3182, column: 27, scope: !3874)
!3904 = !DILocalVariable(name: "lIndex", scope: !3874, file: !36, line: 3183, type: !27)
!3905 = !DILocation(line: 3183, column: 21, scope: !3874)
!3906 = !DILocation(line: 3185, column: 22, scope: !3874)
!3907 = !DILocation(line: 3185, column: 20, scope: !3874)
!3908 = !DILocation(line: 3187, column: 17, scope: !3909)
!3909 = distinct !DILexicalBlock(scope: !3874, file: !36, line: 3187, column: 17)
!3910 = !DILocation(line: 3187, column: 24, scope: !3909)
!3911 = !DILocation(line: 3187, column: 17, scope: !3874)
!3912 = !DILocation(line: 3189, column: 60, scope: !3913)
!3913 = distinct !DILexicalBlock(scope: !3909, file: !36, line: 3188, column: 13)
!3914 = !DILocation(line: 3189, column: 73, scope: !3913)
!3915 = !DILocation(line: 3189, column: 94, scope: !3913)
!3916 = !DILocation(line: 3189, column: 108, scope: !3913)
!3917 = !DILocation(line: 3189, column: 138, scope: !3913)
!3918 = !DILocation(line: 3189, column: 40, scope: !3913)
!3919 = !DILocation(line: 3189, column: 38, scope: !3913)
!3920 = !DILocation(line: 3191, column: 21, scope: !3921)
!3921 = distinct !DILexicalBlock(scope: !3913, file: !36, line: 3191, column: 21)
!3922 = !DILocation(line: 3191, column: 42, scope: !3921)
!3923 = !DILocation(line: 3191, column: 21, scope: !3913)
!3924 = !DILocation(line: 3193, column: 21, scope: !3925)
!3925 = distinct !DILexicalBlock(scope: !3921, file: !36, line: 3192, column: 17)
!3926 = !DILocation(line: 3194, column: 62, scope: !3925)
!3927 = !DILocation(line: 3194, column: 44, scope: !3925)
!3928 = !DILocation(line: 3194, column: 42, scope: !3925)
!3929 = !DILocation(line: 3195, column: 17, scope: !3925)
!3930 = !DILocation(line: 3198, column: 57, scope: !3931)
!3931 = distinct !DILexicalBlock(scope: !3921, file: !36, line: 3197, column: 17)
!3932 = !DILocation(line: 3198, column: 21, scope: !3931)
!3933 = !DILocation(line: 3200, column: 13, scope: !3913)
!3934 = !DILocation(line: 3202, column: 20, scope: !3874)
!3935 = !DILocation(line: 3202, column: 13, scope: !3874)
!3936 = distinct !DISubprogram(name: "MPU_xTimerGetStaticBuffer", scope: !36, file: !36, line: 3210, type: !3937, scopeLine: 3212, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3937 = !DISubroutineType(types: !3938)
!3938 = !{!23, !50, !3939}
!3939 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3877, size: 64)
!3940 = !DILocalVariable(name: "xTimer", arg: 1, scope: !3936, file: !36, line: 3210, type: !50)
!3941 = !DILocation(line: 3210, column: 61, scope: !3936)
!3942 = !DILocalVariable(name: "ppxTimerBuffer", arg: 2, scope: !3936, file: !36, line: 3211, type: !3939)
!3943 = !DILocation(line: 3211, column: 64, scope: !3936)
!3944 = !DILocalVariable(name: "xInternalTimerHandle", scope: !3936, file: !36, line: 3213, type: !50)
!3945 = !DILocation(line: 3213, column: 27, scope: !3936)
!3946 = !DILocalVariable(name: "lIndex", scope: !3936, file: !36, line: 3214, type: !27)
!3947 = !DILocation(line: 3214, column: 21, scope: !3936)
!3948 = !DILocalVariable(name: "xReturn", scope: !3936, file: !36, line: 3215, type: !23)
!3949 = !DILocation(line: 3215, column: 24, scope: !3936)
!3950 = !DILocation(line: 3217, column: 34, scope: !3936)
!3951 = !DILocation(line: 3217, column: 22, scope: !3936)
!3952 = !DILocation(line: 3217, column: 20, scope: !3936)
!3953 = !DILocation(line: 3219, column: 17, scope: !3954)
!3954 = distinct !DILexicalBlock(scope: !3936, file: !36, line: 3219, column: 17)
!3955 = !DILocation(line: 0, scope: !3954)
!3956 = !DILocation(line: 3219, column: 51, scope: !3954)
!3957 = !DILocation(line: 3219, column: 17, scope: !3936)
!3958 = !DILocation(line: 3221, column: 40, scope: !3959)
!3959 = distinct !DILexicalBlock(scope: !3954, file: !36, line: 3220, column: 13)
!3960 = !DILocation(line: 3221, column: 38, scope: !3959)
!3961 = !DILocation(line: 3223, column: 21, scope: !3962)
!3962 = distinct !DILexicalBlock(scope: !3959, file: !36, line: 3223, column: 21)
!3963 = !DILocation(line: 3223, column: 42, scope: !3962)
!3964 = !DILocation(line: 3223, column: 21, scope: !3959)
!3965 = !DILocation(line: 3225, column: 54, scope: !3966)
!3966 = distinct !DILexicalBlock(scope: !3962, file: !36, line: 3224, column: 17)
!3967 = !DILocation(line: 3225, column: 76, scope: !3966)
!3968 = !DILocation(line: 3225, column: 31, scope: !3966)
!3969 = !DILocation(line: 3225, column: 29, scope: !3966)
!3970 = !DILocation(line: 3226, column: 17, scope: !3966)
!3971 = !DILocation(line: 3227, column: 13, scope: !3959)
!3972 = !DILocation(line: 3229, column: 20, scope: !3936)
!3973 = !DILocation(line: 3229, column: 13, scope: !3936)
!3974 = distinct !DISubprogram(name: "MPU_xEventGroupWaitBitsImpl", scope: !36, file: !36, line: 3245, type: !3975, scopeLine: 3250, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!3975 = !DISubroutineType(types: !3976)
!3976 = !{!3977, !54, !3978, !3085, !3085, !93}
!3977 = !DIDerivedType(tag: DW_TAG_typedef, name: "EventBits_t", file: !55, line: 93, baseType: !93)
!3978 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3977)
!3979 = !DILocalVariable(name: "xEventGroup", arg: 1, scope: !3974, file: !36, line: 3245, type: !54)
!3980 = !DILocation(line: 3245, column: 65, scope: !3974)
!3981 = !DILocalVariable(name: "uxBitsToWaitFor", arg: 2, scope: !3974, file: !36, line: 3246, type: !3978)
!3982 = !DILocation(line: 3246, column: 64, scope: !3974)
!3983 = !DILocalVariable(name: "xClearOnExit", arg: 3, scope: !3974, file: !36, line: 3247, type: !3085)
!3984 = !DILocation(line: 3247, column: 63, scope: !3974)
!3985 = !DILocalVariable(name: "xWaitForAllBits", arg: 4, scope: !3974, file: !36, line: 3248, type: !3085)
!3986 = !DILocation(line: 3248, column: 63, scope: !3974)
!3987 = !DILocalVariable(name: "xTicksToWait", arg: 5, scope: !3974, file: !36, line: 3249, type: !93)
!3988 = !DILocation(line: 3249, column: 57, scope: !3974)
!3989 = !DILocalVariable(name: "xReturn", scope: !3974, file: !36, line: 3251, type: !3977)
!3990 = !DILocation(line: 3251, column: 21, scope: !3974)
!3991 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !3974, file: !36, line: 3252, type: !54)
!3992 = !DILocation(line: 3252, column: 28, scope: !3974)
!3993 = !DILocalVariable(name: "lIndex", scope: !3974, file: !36, line: 3253, type: !27)
!3994 = !DILocation(line: 3253, column: 17, scope: !3974)
!3995 = !DILocation(line: 3255, column: 30, scope: !3974)
!3996 = !DILocation(line: 3255, column: 18, scope: !3974)
!3997 = !DILocation(line: 3255, column: 16, scope: !3974)
!3998 = !DILocation(line: 3257, column: 13, scope: !3999)
!3999 = distinct !DILexicalBlock(scope: !3974, file: !36, line: 3257, column: 13)
!4000 = !DILocation(line: 0, scope: !3999)
!4001 = !DILocation(line: 3257, column: 47, scope: !3999)
!4002 = !DILocation(line: 3257, column: 13, scope: !3974)
!4003 = !DILocation(line: 3259, column: 41, scope: !4004)
!4004 = distinct !DILexicalBlock(scope: !3999, file: !36, line: 3258, column: 9)
!4005 = !DILocation(line: 3259, column: 39, scope: !4004)
!4006 = !DILocation(line: 3261, column: 17, scope: !4007)
!4007 = distinct !DILexicalBlock(scope: !4004, file: !36, line: 3261, column: 17)
!4008 = !DILocation(line: 3261, column: 43, scope: !4007)
!4009 = !DILocation(line: 3261, column: 17, scope: !4004)
!4010 = !DILocation(line: 3263, column: 48, scope: !4011)
!4011 = distinct !DILexicalBlock(scope: !4007, file: !36, line: 3262, column: 13)
!4012 = !DILocation(line: 3263, column: 75, scope: !4011)
!4013 = !DILocation(line: 3263, column: 92, scope: !4011)
!4014 = !DILocation(line: 3263, column: 106, scope: !4011)
!4015 = !DILocation(line: 3263, column: 123, scope: !4011)
!4016 = !DILocation(line: 3263, column: 27, scope: !4011)
!4017 = !DILocation(line: 3263, column: 25, scope: !4011)
!4018 = !DILocation(line: 3264, column: 13, scope: !4011)
!4019 = !DILocation(line: 3265, column: 9, scope: !4004)
!4020 = !DILocation(line: 3267, column: 16, scope: !3974)
!4021 = !DILocation(line: 3267, column: 9, scope: !3974)
!4022 = distinct !DISubprogram(name: "MPU_xEventGroupClearBitsImpl", scope: !36, file: !36, line: 3274, type: !4023, scopeLine: 3276, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4023 = !DISubroutineType(types: !4024)
!4024 = !{!3977, !54, !3978}
!4025 = !DILocalVariable(name: "xEventGroup", arg: 1, scope: !4022, file: !36, line: 3274, type: !54)
!4026 = !DILocation(line: 3274, column: 66, scope: !4022)
!4027 = !DILocalVariable(name: "uxBitsToClear", arg: 2, scope: !4022, file: !36, line: 3275, type: !3978)
!4028 = !DILocation(line: 3275, column: 65, scope: !4022)
!4029 = !DILocalVariable(name: "xReturn", scope: !4022, file: !36, line: 3277, type: !3977)
!4030 = !DILocation(line: 3277, column: 21, scope: !4022)
!4031 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4022, file: !36, line: 3278, type: !54)
!4032 = !DILocation(line: 3278, column: 28, scope: !4022)
!4033 = !DILocalVariable(name: "lIndex", scope: !4022, file: !36, line: 3279, type: !27)
!4034 = !DILocation(line: 3279, column: 17, scope: !4022)
!4035 = !DILocation(line: 3281, column: 30, scope: !4022)
!4036 = !DILocation(line: 3281, column: 18, scope: !4022)
!4037 = !DILocation(line: 3281, column: 16, scope: !4022)
!4038 = !DILocation(line: 3283, column: 13, scope: !4039)
!4039 = distinct !DILexicalBlock(scope: !4022, file: !36, line: 3283, column: 13)
!4040 = !DILocation(line: 0, scope: !4039)
!4041 = !DILocation(line: 3283, column: 47, scope: !4039)
!4042 = !DILocation(line: 3283, column: 13, scope: !4022)
!4043 = !DILocation(line: 3285, column: 41, scope: !4044)
!4044 = distinct !DILexicalBlock(scope: !4039, file: !36, line: 3284, column: 9)
!4045 = !DILocation(line: 3285, column: 39, scope: !4044)
!4046 = !DILocation(line: 3287, column: 17, scope: !4047)
!4047 = distinct !DILexicalBlock(scope: !4044, file: !36, line: 3287, column: 17)
!4048 = !DILocation(line: 3287, column: 43, scope: !4047)
!4049 = !DILocation(line: 3287, column: 17, scope: !4044)
!4050 = !DILocation(line: 3289, column: 49, scope: !4051)
!4051 = distinct !DILexicalBlock(scope: !4047, file: !36, line: 3288, column: 13)
!4052 = !DILocation(line: 3289, column: 76, scope: !4051)
!4053 = !DILocation(line: 3289, column: 27, scope: !4051)
!4054 = !DILocation(line: 3289, column: 25, scope: !4051)
!4055 = !DILocation(line: 3290, column: 13, scope: !4051)
!4056 = !DILocation(line: 3291, column: 9, scope: !4044)
!4057 = !DILocation(line: 3293, column: 16, scope: !4022)
!4058 = !DILocation(line: 3293, column: 9, scope: !4022)
!4059 = distinct !DISubprogram(name: "MPU_xEventGroupSetBitsImpl", scope: !36, file: !36, line: 3300, type: !4023, scopeLine: 3302, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4060 = !DILocalVariable(name: "xEventGroup", arg: 1, scope: !4059, file: !36, line: 3300, type: !54)
!4061 = !DILocation(line: 3300, column: 64, scope: !4059)
!4062 = !DILocalVariable(name: "uxBitsToSet", arg: 2, scope: !4059, file: !36, line: 3301, type: !3978)
!4063 = !DILocation(line: 3301, column: 63, scope: !4059)
!4064 = !DILocalVariable(name: "xReturn", scope: !4059, file: !36, line: 3303, type: !3977)
!4065 = !DILocation(line: 3303, column: 21, scope: !4059)
!4066 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4059, file: !36, line: 3304, type: !54)
!4067 = !DILocation(line: 3304, column: 28, scope: !4059)
!4068 = !DILocalVariable(name: "lIndex", scope: !4059, file: !36, line: 3305, type: !27)
!4069 = !DILocation(line: 3305, column: 17, scope: !4059)
!4070 = !DILocation(line: 3307, column: 30, scope: !4059)
!4071 = !DILocation(line: 3307, column: 18, scope: !4059)
!4072 = !DILocation(line: 3307, column: 16, scope: !4059)
!4073 = !DILocation(line: 3309, column: 13, scope: !4074)
!4074 = distinct !DILexicalBlock(scope: !4059, file: !36, line: 3309, column: 13)
!4075 = !DILocation(line: 0, scope: !4074)
!4076 = !DILocation(line: 3309, column: 47, scope: !4074)
!4077 = !DILocation(line: 3309, column: 13, scope: !4059)
!4078 = !DILocation(line: 3311, column: 41, scope: !4079)
!4079 = distinct !DILexicalBlock(scope: !4074, file: !36, line: 3310, column: 9)
!4080 = !DILocation(line: 3311, column: 39, scope: !4079)
!4081 = !DILocation(line: 3313, column: 17, scope: !4082)
!4082 = distinct !DILexicalBlock(scope: !4079, file: !36, line: 3313, column: 17)
!4083 = !DILocation(line: 3313, column: 43, scope: !4082)
!4084 = !DILocation(line: 3313, column: 17, scope: !4079)
!4085 = !DILocation(line: 3315, column: 47, scope: !4086)
!4086 = distinct !DILexicalBlock(scope: !4082, file: !36, line: 3314, column: 13)
!4087 = !DILocation(line: 3315, column: 74, scope: !4086)
!4088 = !DILocation(line: 3315, column: 27, scope: !4086)
!4089 = !DILocation(line: 3315, column: 25, scope: !4086)
!4090 = !DILocation(line: 3316, column: 13, scope: !4086)
!4091 = !DILocation(line: 3317, column: 9, scope: !4079)
!4092 = !DILocation(line: 3319, column: 16, scope: !4059)
!4093 = !DILocation(line: 3319, column: 9, scope: !4059)
!4094 = distinct !DISubprogram(name: "MPU_xEventGroupSyncImpl", scope: !36, file: !36, line: 3328, type: !4095, scopeLine: 3332, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4095 = !DISubroutineType(types: !4096)
!4096 = !{!3977, !54, !3978, !3978, !93}
!4097 = !DILocalVariable(name: "xEventGroup", arg: 1, scope: !4094, file: !36, line: 3328, type: !54)
!4098 = !DILocation(line: 3328, column: 61, scope: !4094)
!4099 = !DILocalVariable(name: "uxBitsToSet", arg: 2, scope: !4094, file: !36, line: 3329, type: !3978)
!4100 = !DILocation(line: 3329, column: 60, scope: !4094)
!4101 = !DILocalVariable(name: "uxBitsToWaitFor", arg: 3, scope: !4094, file: !36, line: 3330, type: !3978)
!4102 = !DILocation(line: 3330, column: 60, scope: !4094)
!4103 = !DILocalVariable(name: "xTicksToWait", arg: 4, scope: !4094, file: !36, line: 3331, type: !93)
!4104 = !DILocation(line: 3331, column: 53, scope: !4094)
!4105 = !DILocalVariable(name: "xReturn", scope: !4094, file: !36, line: 3333, type: !3977)
!4106 = !DILocation(line: 3333, column: 21, scope: !4094)
!4107 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4094, file: !36, line: 3334, type: !54)
!4108 = !DILocation(line: 3334, column: 28, scope: !4094)
!4109 = !DILocalVariable(name: "lIndex", scope: !4094, file: !36, line: 3335, type: !27)
!4110 = !DILocation(line: 3335, column: 17, scope: !4094)
!4111 = !DILocation(line: 3337, column: 30, scope: !4094)
!4112 = !DILocation(line: 3337, column: 18, scope: !4094)
!4113 = !DILocation(line: 3337, column: 16, scope: !4094)
!4114 = !DILocation(line: 3339, column: 13, scope: !4115)
!4115 = distinct !DILexicalBlock(scope: !4094, file: !36, line: 3339, column: 13)
!4116 = !DILocation(line: 0, scope: !4115)
!4117 = !DILocation(line: 3339, column: 47, scope: !4115)
!4118 = !DILocation(line: 3339, column: 13, scope: !4094)
!4119 = !DILocation(line: 3341, column: 41, scope: !4120)
!4120 = distinct !DILexicalBlock(scope: !4115, file: !36, line: 3340, column: 9)
!4121 = !DILocation(line: 3341, column: 39, scope: !4120)
!4122 = !DILocation(line: 3343, column: 17, scope: !4123)
!4123 = distinct !DILexicalBlock(scope: !4120, file: !36, line: 3343, column: 17)
!4124 = !DILocation(line: 3343, column: 43, scope: !4123)
!4125 = !DILocation(line: 3343, column: 17, scope: !4120)
!4126 = !DILocation(line: 3345, column: 44, scope: !4127)
!4127 = distinct !DILexicalBlock(scope: !4123, file: !36, line: 3344, column: 13)
!4128 = !DILocation(line: 3345, column: 71, scope: !4127)
!4129 = !DILocation(line: 3345, column: 84, scope: !4127)
!4130 = !DILocation(line: 3345, column: 101, scope: !4127)
!4131 = !DILocation(line: 3345, column: 27, scope: !4127)
!4132 = !DILocation(line: 3345, column: 25, scope: !4127)
!4133 = !DILocation(line: 3346, column: 13, scope: !4127)
!4134 = !DILocation(line: 3347, column: 9, scope: !4120)
!4135 = !DILocation(line: 3349, column: 16, scope: !4094)
!4136 = !DILocation(line: 3349, column: 9, scope: !4094)
!4137 = distinct !DISubprogram(name: "MPU_uxEventGroupGetNumberImpl", scope: !36, file: !36, line: 3357, type: !4138, scopeLine: 3358, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4138 = !DISubroutineType(types: !4139)
!4139 = !{!39, !26}
!4140 = !DILocalVariable(name: "xEventGroup", arg: 1, scope: !4137, file: !36, line: 3357, type: !26)
!4141 = !DILocation(line: 3357, column: 59, scope: !4137)
!4142 = !DILocalVariable(name: "xReturn", scope: !4137, file: !36, line: 3359, type: !39)
!4143 = !DILocation(line: 3359, column: 25, scope: !4137)
!4144 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4137, file: !36, line: 3360, type: !54)
!4145 = !DILocation(line: 3360, column: 32, scope: !4137)
!4146 = !DILocalVariable(name: "lIndex", scope: !4137, file: !36, line: 3361, type: !27)
!4147 = !DILocation(line: 3361, column: 21, scope: !4137)
!4148 = !DILocation(line: 3363, column: 34, scope: !4137)
!4149 = !DILocation(line: 3363, column: 22, scope: !4137)
!4150 = !DILocation(line: 3363, column: 20, scope: !4137)
!4151 = !DILocation(line: 3365, column: 17, scope: !4152)
!4152 = distinct !DILexicalBlock(scope: !4137, file: !36, line: 3365, column: 17)
!4153 = !DILocation(line: 0, scope: !4152)
!4154 = !DILocation(line: 3365, column: 51, scope: !4152)
!4155 = !DILocation(line: 3365, column: 17, scope: !4137)
!4156 = !DILocation(line: 3367, column: 45, scope: !4157)
!4157 = distinct !DILexicalBlock(scope: !4152, file: !36, line: 3366, column: 13)
!4158 = !DILocation(line: 3367, column: 43, scope: !4157)
!4159 = !DILocation(line: 3369, column: 21, scope: !4160)
!4160 = distinct !DILexicalBlock(scope: !4157, file: !36, line: 3369, column: 21)
!4161 = !DILocation(line: 3369, column: 47, scope: !4160)
!4162 = !DILocation(line: 3369, column: 21, scope: !4157)
!4163 = !DILocation(line: 3371, column: 54, scope: !4164)
!4164 = distinct !DILexicalBlock(scope: !4160, file: !36, line: 3370, column: 17)
!4165 = !DILocation(line: 3371, column: 31, scope: !4164)
!4166 = !DILocation(line: 3371, column: 29, scope: !4164)
!4167 = !DILocation(line: 3372, column: 17, scope: !4164)
!4168 = !DILocation(line: 3373, column: 13, scope: !4157)
!4169 = !DILocation(line: 3375, column: 20, scope: !4137)
!4170 = !DILocation(line: 3375, column: 13, scope: !4137)
!4171 = distinct !DISubprogram(name: "MPU_vEventGroupSetNumberImpl", scope: !36, file: !36, line: 3386, type: !4172, scopeLine: 3388, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4172 = !DISubroutineType(types: !4173)
!4173 = !{null, !26, !39}
!4174 = !DILocalVariable(name: "xEventGroup", arg: 1, scope: !4171, file: !36, line: 3386, type: !26)
!4175 = !DILocation(line: 3386, column: 51, scope: !4171)
!4176 = !DILocalVariable(name: "uxEventGroupNumber", arg: 2, scope: !4171, file: !36, line: 3387, type: !39)
!4177 = !DILocation(line: 3387, column: 56, scope: !4171)
!4178 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4171, file: !36, line: 3389, type: !54)
!4179 = !DILocation(line: 3389, column: 32, scope: !4171)
!4180 = !DILocalVariable(name: "lIndex", scope: !4171, file: !36, line: 3390, type: !27)
!4181 = !DILocation(line: 3390, column: 21, scope: !4171)
!4182 = !DILocation(line: 3392, column: 34, scope: !4171)
!4183 = !DILocation(line: 3392, column: 22, scope: !4171)
!4184 = !DILocation(line: 3392, column: 20, scope: !4171)
!4185 = !DILocation(line: 3394, column: 17, scope: !4186)
!4186 = distinct !DILexicalBlock(scope: !4171, file: !36, line: 3394, column: 17)
!4187 = !DILocation(line: 0, scope: !4186)
!4188 = !DILocation(line: 3394, column: 51, scope: !4186)
!4189 = !DILocation(line: 3394, column: 17, scope: !4171)
!4190 = !DILocation(line: 3396, column: 45, scope: !4191)
!4191 = distinct !DILexicalBlock(scope: !4186, file: !36, line: 3395, column: 13)
!4192 = !DILocation(line: 3396, column: 43, scope: !4191)
!4193 = !DILocation(line: 3398, column: 21, scope: !4194)
!4194 = distinct !DILexicalBlock(scope: !4191, file: !36, line: 3398, column: 21)
!4195 = !DILocation(line: 3398, column: 47, scope: !4194)
!4196 = !DILocation(line: 3398, column: 21, scope: !4191)
!4197 = !DILocation(line: 3400, column: 43, scope: !4198)
!4198 = distinct !DILexicalBlock(scope: !4194, file: !36, line: 3399, column: 17)
!4199 = !DILocation(line: 3400, column: 70, scope: !4198)
!4200 = !DILocation(line: 3400, column: 21, scope: !4198)
!4201 = !DILocation(line: 3401, column: 17, scope: !4198)
!4202 = !DILocation(line: 3402, column: 13, scope: !4191)
!4203 = !DILocation(line: 3403, column: 9, scope: !4171)
!4204 = distinct !DISubprogram(name: "MPU_xEventGroupCreate", scope: !36, file: !36, line: 3415, type: !4205, scopeLine: 3416, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4205 = !DISubroutineType(types: !4206)
!4206 = !{!54}
!4207 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4204, file: !36, line: 3417, type: !54)
!4208 = !DILocation(line: 3417, column: 32, scope: !4204)
!4209 = !DILocalVariable(name: "xExternalEventGroupHandle", scope: !4204, file: !36, line: 3418, type: !54)
!4210 = !DILocation(line: 3418, column: 32, scope: !4204)
!4211 = !DILocalVariable(name: "lIndex", scope: !4204, file: !36, line: 3419, type: !27)
!4212 = !DILocation(line: 3419, column: 21, scope: !4204)
!4213 = !DILocation(line: 3421, column: 22, scope: !4204)
!4214 = !DILocation(line: 3421, column: 20, scope: !4204)
!4215 = !DILocation(line: 3423, column: 17, scope: !4216)
!4216 = distinct !DILexicalBlock(scope: !4204, file: !36, line: 3423, column: 17)
!4217 = !DILocation(line: 3423, column: 24, scope: !4216)
!4218 = !DILocation(line: 3423, column: 17, scope: !4204)
!4219 = !DILocation(line: 3425, column: 45, scope: !4220)
!4220 = distinct !DILexicalBlock(scope: !4216, file: !36, line: 3424, column: 13)
!4221 = !DILocation(line: 3425, column: 43, scope: !4220)
!4222 = !DILocation(line: 3427, column: 21, scope: !4223)
!4223 = distinct !DILexicalBlock(scope: !4220, file: !36, line: 3427, column: 21)
!4224 = !DILocation(line: 3427, column: 47, scope: !4223)
!4225 = !DILocation(line: 3427, column: 21, scope: !4220)
!4226 = !DILocation(line: 3429, column: 21, scope: !4227)
!4227 = distinct !DILexicalBlock(scope: !4223, file: !36, line: 3428, column: 17)
!4228 = !DILocation(line: 3430, column: 72, scope: !4227)
!4229 = !DILocation(line: 3430, column: 49, scope: !4227)
!4230 = !DILocation(line: 3430, column: 47, scope: !4227)
!4231 = !DILocation(line: 3431, column: 17, scope: !4227)
!4232 = !DILocation(line: 3434, column: 57, scope: !4233)
!4233 = distinct !DILexicalBlock(scope: !4223, file: !36, line: 3433, column: 17)
!4234 = !DILocation(line: 3434, column: 21, scope: !4233)
!4235 = !DILocation(line: 3436, column: 13, scope: !4220)
!4236 = !DILocation(line: 3438, column: 20, scope: !4204)
!4237 = !DILocation(line: 3438, column: 13, scope: !4204)
!4238 = distinct !DISubprogram(name: "MPU_xEventGroupCreateStatic", scope: !36, file: !36, line: 3446, type: !4239, scopeLine: 3447, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4239 = !DISubroutineType(types: !4240)
!4240 = !{!54, !4241}
!4241 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4242, size: 64)
!4242 = !DIDerivedType(tag: DW_TAG_typedef, name: "StaticEventGroup_t", file: !1485, line: 1390, baseType: !4243)
!4243 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xSTATIC_EVENT_GROUP", file: !1485, line: 1378, size: 512, elements: !4244)
!4244 = !{!4245, !4246, !4247, !4248}
!4245 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy1", scope: !4243, file: !1485, line: 1380, baseType: !93, size: 64)
!4246 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy2", scope: !4243, file: !1485, line: 1381, baseType: !2761, size: 320, offset: 64)
!4247 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy3", scope: !4243, file: !1485, line: 1384, baseType: !39, size: 64, offset: 384)
!4248 = !DIDerivedType(tag: DW_TAG_member, name: "ucDummy4", scope: !4243, file: !1485, line: 1388, baseType: !1520, size: 8, offset: 448)
!4249 = !DILocalVariable(name: "pxEventGroupBuffer", arg: 1, scope: !4238, file: !36, line: 3446, type: !4241)
!4250 = !DILocation(line: 3446, column: 78, scope: !4238)
!4251 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4238, file: !36, line: 3448, type: !54)
!4252 = !DILocation(line: 3448, column: 32, scope: !4238)
!4253 = !DILocalVariable(name: "xExternalEventGroupHandle", scope: !4238, file: !36, line: 3449, type: !54)
!4254 = !DILocation(line: 3449, column: 32, scope: !4238)
!4255 = !DILocalVariable(name: "lIndex", scope: !4238, file: !36, line: 3450, type: !27)
!4256 = !DILocation(line: 3450, column: 21, scope: !4238)
!4257 = !DILocation(line: 3452, column: 22, scope: !4238)
!4258 = !DILocation(line: 3452, column: 20, scope: !4238)
!4259 = !DILocation(line: 3454, column: 17, scope: !4260)
!4260 = distinct !DILexicalBlock(scope: !4238, file: !36, line: 3454, column: 17)
!4261 = !DILocation(line: 3454, column: 24, scope: !4260)
!4262 = !DILocation(line: 3454, column: 17, scope: !4238)
!4263 = !DILocation(line: 3456, column: 70, scope: !4264)
!4264 = distinct !DILexicalBlock(scope: !4260, file: !36, line: 3455, column: 13)
!4265 = !DILocation(line: 3456, column: 45, scope: !4264)
!4266 = !DILocation(line: 3456, column: 43, scope: !4264)
!4267 = !DILocation(line: 3458, column: 21, scope: !4268)
!4268 = distinct !DILexicalBlock(scope: !4264, file: !36, line: 3458, column: 21)
!4269 = !DILocation(line: 3458, column: 47, scope: !4268)
!4270 = !DILocation(line: 3458, column: 21, scope: !4264)
!4271 = !DILocation(line: 3460, column: 21, scope: !4272)
!4272 = distinct !DILexicalBlock(scope: !4268, file: !36, line: 3459, column: 17)
!4273 = !DILocation(line: 3461, column: 72, scope: !4272)
!4274 = !DILocation(line: 3461, column: 49, scope: !4272)
!4275 = !DILocation(line: 3461, column: 47, scope: !4272)
!4276 = !DILocation(line: 3462, column: 17, scope: !4272)
!4277 = !DILocation(line: 3465, column: 57, scope: !4278)
!4278 = distinct !DILexicalBlock(scope: !4268, file: !36, line: 3464, column: 17)
!4279 = !DILocation(line: 3465, column: 21, scope: !4278)
!4280 = !DILocation(line: 3467, column: 13, scope: !4264)
!4281 = !DILocation(line: 3469, column: 20, scope: !4238)
!4282 = !DILocation(line: 3469, column: 13, scope: !4238)
!4283 = distinct !DISubprogram(name: "MPU_vEventGroupDelete", scope: !36, file: !36, line: 3475, type: !4284, scopeLine: 3476, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4284 = !DISubroutineType(types: !4285)
!4285 = !{null, !54}
!4286 = !DILocalVariable(name: "xEventGroup", arg: 1, scope: !4283, file: !36, line: 3475, type: !54)
!4287 = !DILocation(line: 3475, column: 52, scope: !4283)
!4288 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4283, file: !36, line: 3477, type: !54)
!4289 = !DILocation(line: 3477, column: 28, scope: !4283)
!4290 = !DILocalVariable(name: "lIndex", scope: !4283, file: !36, line: 3478, type: !27)
!4291 = !DILocation(line: 3478, column: 17, scope: !4283)
!4292 = !DILocation(line: 3480, column: 30, scope: !4283)
!4293 = !DILocation(line: 3480, column: 18, scope: !4283)
!4294 = !DILocation(line: 3480, column: 16, scope: !4283)
!4295 = !DILocation(line: 3482, column: 13, scope: !4296)
!4296 = distinct !DILexicalBlock(scope: !4283, file: !36, line: 3482, column: 13)
!4297 = !DILocation(line: 0, scope: !4296)
!4298 = !DILocation(line: 3482, column: 47, scope: !4296)
!4299 = !DILocation(line: 3482, column: 13, scope: !4283)
!4300 = !DILocation(line: 3484, column: 41, scope: !4301)
!4301 = distinct !DILexicalBlock(scope: !4296, file: !36, line: 3483, column: 9)
!4302 = !DILocation(line: 3484, column: 39, scope: !4301)
!4303 = !DILocation(line: 3486, column: 17, scope: !4304)
!4304 = distinct !DILexicalBlock(scope: !4301, file: !36, line: 3486, column: 17)
!4305 = !DILocation(line: 3486, column: 43, scope: !4304)
!4306 = !DILocation(line: 3486, column: 17, scope: !4301)
!4307 = !DILocation(line: 3488, column: 36, scope: !4308)
!4308 = distinct !DILexicalBlock(scope: !4304, file: !36, line: 3487, column: 13)
!4309 = !DILocation(line: 3488, column: 17, scope: !4308)
!4310 = !DILocation(line: 3489, column: 53, scope: !4308)
!4311 = !DILocation(line: 3489, column: 17, scope: !4308)
!4312 = !DILocation(line: 3490, column: 13, scope: !4308)
!4313 = !DILocation(line: 3491, column: 9, scope: !4301)
!4314 = !DILocation(line: 3492, column: 5, scope: !4283)
!4315 = distinct !DISubprogram(name: "MPU_xEventGroupGetStaticBuffer", scope: !36, file: !36, line: 3497, type: !4316, scopeLine: 3499, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4316 = !DISubroutineType(types: !4317)
!4317 = !{!23, !54, !4318}
!4318 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4241, size: 64)
!4319 = !DILocalVariable(name: "xEventGroup", arg: 1, scope: !4315, file: !36, line: 3497, type: !54)
!4320 = !DILocation(line: 3497, column: 71, scope: !4315)
!4321 = !DILocalVariable(name: "ppxEventGroupBuffer", arg: 2, scope: !4315, file: !36, line: 3498, type: !4318)
!4322 = !DILocation(line: 3498, column: 74, scope: !4315)
!4323 = !DILocalVariable(name: "xReturn", scope: !4315, file: !36, line: 3500, type: !23)
!4324 = !DILocation(line: 3500, column: 24, scope: !4315)
!4325 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4315, file: !36, line: 3501, type: !54)
!4326 = !DILocation(line: 3501, column: 32, scope: !4315)
!4327 = !DILocalVariable(name: "lIndex", scope: !4315, file: !36, line: 3502, type: !27)
!4328 = !DILocation(line: 3502, column: 21, scope: !4315)
!4329 = !DILocation(line: 3504, column: 34, scope: !4315)
!4330 = !DILocation(line: 3504, column: 22, scope: !4315)
!4331 = !DILocation(line: 3504, column: 20, scope: !4315)
!4332 = !DILocation(line: 3506, column: 17, scope: !4333)
!4333 = distinct !DILexicalBlock(scope: !4315, file: !36, line: 3506, column: 17)
!4334 = !DILocation(line: 0, scope: !4333)
!4335 = !DILocation(line: 3506, column: 51, scope: !4333)
!4336 = !DILocation(line: 3506, column: 17, scope: !4315)
!4337 = !DILocation(line: 3508, column: 45, scope: !4338)
!4338 = distinct !DILexicalBlock(scope: !4333, file: !36, line: 3507, column: 13)
!4339 = !DILocation(line: 3508, column: 43, scope: !4338)
!4340 = !DILocation(line: 3510, column: 21, scope: !4341)
!4341 = distinct !DILexicalBlock(scope: !4338, file: !36, line: 3510, column: 21)
!4342 = !DILocation(line: 3510, column: 47, scope: !4341)
!4343 = !DILocation(line: 3510, column: 21, scope: !4338)
!4344 = !DILocation(line: 3512, column: 59, scope: !4345)
!4345 = distinct !DILexicalBlock(scope: !4341, file: !36, line: 3511, column: 17)
!4346 = !DILocation(line: 3512, column: 86, scope: !4345)
!4347 = !DILocation(line: 3512, column: 31, scope: !4345)
!4348 = !DILocation(line: 3512, column: 29, scope: !4345)
!4349 = !DILocation(line: 3513, column: 17, scope: !4345)
!4350 = !DILocation(line: 3514, column: 13, scope: !4338)
!4351 = !DILocation(line: 3516, column: 20, scope: !4315)
!4352 = !DILocation(line: 3516, column: 13, scope: !4315)
!4353 = distinct !DISubprogram(name: "MPU_xEventGroupClearBitsFromISR", scope: !36, file: !36, line: 3524, type: !4354, scopeLine: 3526, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4354 = !DISubroutineType(types: !4355)
!4355 = !{!23, !54, !3978}
!4356 = !DILocalVariable(name: "xEventGroup", arg: 1, scope: !4353, file: !36, line: 3524, type: !54)
!4357 = !DILocation(line: 3524, column: 72, scope: !4353)
!4358 = !DILocalVariable(name: "uxBitsToClear", arg: 2, scope: !4353, file: !36, line: 3525, type: !3978)
!4359 = !DILocation(line: 3525, column: 71, scope: !4353)
!4360 = !DILocalVariable(name: "xReturn", scope: !4353, file: !36, line: 3527, type: !23)
!4361 = !DILocation(line: 3527, column: 24, scope: !4353)
!4362 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4353, file: !36, line: 3528, type: !54)
!4363 = !DILocation(line: 3528, column: 32, scope: !4353)
!4364 = !DILocalVariable(name: "lIndex", scope: !4353, file: !36, line: 3529, type: !27)
!4365 = !DILocation(line: 3529, column: 21, scope: !4353)
!4366 = !DILocation(line: 3531, column: 34, scope: !4353)
!4367 = !DILocation(line: 3531, column: 22, scope: !4353)
!4368 = !DILocation(line: 3531, column: 20, scope: !4353)
!4369 = !DILocation(line: 3533, column: 17, scope: !4370)
!4370 = distinct !DILexicalBlock(scope: !4353, file: !36, line: 3533, column: 17)
!4371 = !DILocation(line: 0, scope: !4370)
!4372 = !DILocation(line: 3533, column: 51, scope: !4370)
!4373 = !DILocation(line: 3533, column: 17, scope: !4353)
!4374 = !DILocation(line: 3535, column: 45, scope: !4375)
!4375 = distinct !DILexicalBlock(scope: !4370, file: !36, line: 3534, column: 13)
!4376 = !DILocation(line: 3535, column: 43, scope: !4375)
!4377 = !DILocation(line: 3537, column: 21, scope: !4378)
!4378 = distinct !DILexicalBlock(scope: !4375, file: !36, line: 3537, column: 21)
!4379 = !DILocation(line: 3537, column: 47, scope: !4378)
!4380 = !DILocation(line: 3537, column: 21, scope: !4375)
!4381 = !DILocation(line: 3539, column: 60, scope: !4382)
!4382 = distinct !DILexicalBlock(scope: !4378, file: !36, line: 3538, column: 17)
!4383 = !DILocation(line: 3539, column: 87, scope: !4382)
!4384 = !DILocation(line: 3539, column: 31, scope: !4382)
!4385 = !DILocation(line: 3539, column: 29, scope: !4382)
!4386 = !DILocation(line: 3540, column: 17, scope: !4382)
!4387 = !DILocation(line: 3541, column: 13, scope: !4375)
!4388 = !DILocation(line: 3543, column: 20, scope: !4353)
!4389 = !DILocation(line: 3543, column: 13, scope: !4353)
!4390 = distinct !DISubprogram(name: "MPU_xEventGroupSetBitsFromISR", scope: !36, file: !36, line: 3551, type: !4391, scopeLine: 3554, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4391 = !DISubroutineType(types: !4392)
!4392 = !{!23, !54, !3978, !2108}
!4393 = !DILocalVariable(name: "xEventGroup", arg: 1, scope: !4390, file: !36, line: 3551, type: !54)
!4394 = !DILocation(line: 3551, column: 70, scope: !4390)
!4395 = !DILocalVariable(name: "uxBitsToSet", arg: 2, scope: !4390, file: !36, line: 3552, type: !3978)
!4396 = !DILocation(line: 3552, column: 69, scope: !4390)
!4397 = !DILocalVariable(name: "pxHigherPriorityTaskWoken", arg: 3, scope: !4390, file: !36, line: 3553, type: !2108)
!4398 = !DILocation(line: 3553, column: 64, scope: !4390)
!4399 = !DILocalVariable(name: "xReturn", scope: !4390, file: !36, line: 3555, type: !23)
!4400 = !DILocation(line: 3555, column: 24, scope: !4390)
!4401 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4390, file: !36, line: 3556, type: !54)
!4402 = !DILocation(line: 3556, column: 32, scope: !4390)
!4403 = !DILocalVariable(name: "lIndex", scope: !4390, file: !36, line: 3557, type: !27)
!4404 = !DILocation(line: 3557, column: 21, scope: !4390)
!4405 = !DILocation(line: 3559, column: 34, scope: !4390)
!4406 = !DILocation(line: 3559, column: 22, scope: !4390)
!4407 = !DILocation(line: 3559, column: 20, scope: !4390)
!4408 = !DILocation(line: 3561, column: 17, scope: !4409)
!4409 = distinct !DILexicalBlock(scope: !4390, file: !36, line: 3561, column: 17)
!4410 = !DILocation(line: 0, scope: !4409)
!4411 = !DILocation(line: 3561, column: 51, scope: !4409)
!4412 = !DILocation(line: 3561, column: 17, scope: !4390)
!4413 = !DILocation(line: 3563, column: 45, scope: !4414)
!4414 = distinct !DILexicalBlock(scope: !4409, file: !36, line: 3562, column: 13)
!4415 = !DILocation(line: 3563, column: 43, scope: !4414)
!4416 = !DILocation(line: 3565, column: 21, scope: !4417)
!4417 = distinct !DILexicalBlock(scope: !4414, file: !36, line: 3565, column: 21)
!4418 = !DILocation(line: 3565, column: 47, scope: !4417)
!4419 = !DILocation(line: 3565, column: 21, scope: !4414)
!4420 = !DILocation(line: 3567, column: 58, scope: !4421)
!4421 = distinct !DILexicalBlock(scope: !4417, file: !36, line: 3566, column: 17)
!4422 = !DILocation(line: 3567, column: 85, scope: !4421)
!4423 = !DILocation(line: 3567, column: 98, scope: !4421)
!4424 = !DILocation(line: 3567, column: 31, scope: !4421)
!4425 = !DILocation(line: 3567, column: 29, scope: !4421)
!4426 = !DILocation(line: 3568, column: 17, scope: !4421)
!4427 = !DILocation(line: 3569, column: 13, scope: !4414)
!4428 = !DILocation(line: 3571, column: 20, scope: !4390)
!4429 = !DILocation(line: 3571, column: 13, scope: !4390)
!4430 = distinct !DISubprogram(name: "MPU_xEventGroupGetBitsFromISR", scope: !36, file: !36, line: 3577, type: !4431, scopeLine: 3578, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4431 = !DISubroutineType(types: !4432)
!4432 = !{!3977, !54}
!4433 = !DILocalVariable(name: "xEventGroup", arg: 1, scope: !4430, file: !36, line: 3577, type: !54)
!4434 = !DILocation(line: 3577, column: 67, scope: !4430)
!4435 = !DILocalVariable(name: "xReturn", scope: !4430, file: !36, line: 3579, type: !3977)
!4436 = !DILocation(line: 3579, column: 21, scope: !4430)
!4437 = !DILocalVariable(name: "xInternalEventGroupHandle", scope: !4430, file: !36, line: 3580, type: !54)
!4438 = !DILocation(line: 3580, column: 28, scope: !4430)
!4439 = !DILocalVariable(name: "lIndex", scope: !4430, file: !36, line: 3581, type: !27)
!4440 = !DILocation(line: 3581, column: 17, scope: !4430)
!4441 = !DILocation(line: 3583, column: 30, scope: !4430)
!4442 = !DILocation(line: 3583, column: 18, scope: !4430)
!4443 = !DILocation(line: 3583, column: 16, scope: !4430)
!4444 = !DILocation(line: 3585, column: 13, scope: !4445)
!4445 = distinct !DILexicalBlock(scope: !4430, file: !36, line: 3585, column: 13)
!4446 = !DILocation(line: 0, scope: !4445)
!4447 = !DILocation(line: 3585, column: 47, scope: !4445)
!4448 = !DILocation(line: 3585, column: 13, scope: !4430)
!4449 = !DILocation(line: 3587, column: 41, scope: !4450)
!4450 = distinct !DILexicalBlock(scope: !4445, file: !36, line: 3586, column: 9)
!4451 = !DILocation(line: 3587, column: 39, scope: !4450)
!4452 = !DILocation(line: 3589, column: 17, scope: !4453)
!4453 = distinct !DILexicalBlock(scope: !4450, file: !36, line: 3589, column: 17)
!4454 = !DILocation(line: 3589, column: 43, scope: !4453)
!4455 = !DILocation(line: 3589, column: 17, scope: !4450)
!4456 = !DILocation(line: 3591, column: 54, scope: !4457)
!4457 = distinct !DILexicalBlock(scope: !4453, file: !36, line: 3590, column: 13)
!4458 = !DILocation(line: 3591, column: 27, scope: !4457)
!4459 = !DILocation(line: 3591, column: 25, scope: !4457)
!4460 = !DILocation(line: 3592, column: 13, scope: !4457)
!4461 = !DILocation(line: 3593, column: 9, scope: !4450)
!4462 = !DILocation(line: 3595, column: 16, scope: !4430)
!4463 = !DILocation(line: 3595, column: 9, scope: !4430)
!4464 = distinct !DISubprogram(name: "MPU_xStreamBufferSendImpl", scope: !36, file: !36, line: 3608, type: !4465, scopeLine: 3612, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4465 = !DISubroutineType(types: !4466)
!4466 = !{!4467, !58, !2195, !4467, !93}
!4467 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !4468, line: 46, baseType: !40)
!4468 = !DIFile(filename: "/tmp/llvm-110-install_O_D_A/lib/clang/11.0.0/include/stddef.h", directory: "")
!4469 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !4464, file: !36, line: 3608, type: !58)
!4470 = !DILocation(line: 3608, column: 60, scope: !4464)
!4471 = !DILocalVariable(name: "pvTxData", arg: 2, scope: !4464, file: !36, line: 3609, type: !2195)
!4472 = !DILocation(line: 3609, column: 52, scope: !4464)
!4473 = !DILocalVariable(name: "xDataLengthBytes", arg: 3, scope: !4464, file: !36, line: 3610, type: !4467)
!4474 = !DILocation(line: 3610, column: 46, scope: !4464)
!4475 = !DILocalVariable(name: "xTicksToWait", arg: 4, scope: !4464, file: !36, line: 3611, type: !93)
!4476 = !DILocation(line: 3611, column: 50, scope: !4464)
!4477 = !DILocalVariable(name: "xReturn", scope: !4464, file: !36, line: 3613, type: !4467)
!4478 = !DILocation(line: 3613, column: 16, scope: !4464)
!4479 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4464, file: !36, line: 3614, type: !58)
!4480 = !DILocation(line: 3614, column: 30, scope: !4464)
!4481 = !DILocalVariable(name: "lIndex", scope: !4464, file: !36, line: 3615, type: !27)
!4482 = !DILocation(line: 3615, column: 17, scope: !4464)
!4483 = !DILocalVariable(name: "xIsTxDataBufferReadable", scope: !4464, file: !36, line: 3616, type: !23)
!4484 = !DILocation(line: 3616, column: 20, scope: !4464)
!4485 = !DILocation(line: 3618, column: 68, scope: !4464)
!4486 = !DILocation(line: 3619, column: 68, scope: !4464)
!4487 = !DILocation(line: 3618, column: 35, scope: !4464)
!4488 = !DILocation(line: 3618, column: 33, scope: !4464)
!4489 = !DILocation(line: 3622, column: 13, scope: !4490)
!4490 = distinct !DILexicalBlock(scope: !4464, file: !36, line: 3622, column: 13)
!4491 = !DILocation(line: 3622, column: 37, scope: !4490)
!4492 = !DILocation(line: 3622, column: 13, scope: !4464)
!4493 = !DILocation(line: 3624, column: 34, scope: !4494)
!4494 = distinct !DILexicalBlock(scope: !4490, file: !36, line: 3623, column: 9)
!4495 = !DILocation(line: 3624, column: 22, scope: !4494)
!4496 = !DILocation(line: 3624, column: 20, scope: !4494)
!4497 = !DILocation(line: 3626, column: 17, scope: !4498)
!4498 = distinct !DILexicalBlock(scope: !4494, file: !36, line: 3626, column: 17)
!4499 = !DILocation(line: 0, scope: !4498)
!4500 = !DILocation(line: 3626, column: 51, scope: !4498)
!4501 = !DILocation(line: 3626, column: 17, scope: !4494)
!4502 = !DILocation(line: 3628, column: 47, scope: !4503)
!4503 = distinct !DILexicalBlock(scope: !4498, file: !36, line: 3627, column: 13)
!4504 = !DILocation(line: 3628, column: 45, scope: !4503)
!4505 = !DILocation(line: 3630, column: 21, scope: !4506)
!4506 = distinct !DILexicalBlock(scope: !4503, file: !36, line: 3630, column: 21)
!4507 = !DILocation(line: 3630, column: 49, scope: !4506)
!4508 = !DILocation(line: 3630, column: 21, scope: !4503)
!4509 = !DILocation(line: 3632, column: 50, scope: !4510)
!4510 = distinct !DILexicalBlock(scope: !4506, file: !36, line: 3631, column: 17)
!4511 = !DILocation(line: 3632, column: 79, scope: !4510)
!4512 = !DILocation(line: 3632, column: 89, scope: !4510)
!4513 = !DILocation(line: 3632, column: 107, scope: !4510)
!4514 = !DILocation(line: 3632, column: 31, scope: !4510)
!4515 = !DILocation(line: 3632, column: 29, scope: !4510)
!4516 = !DILocation(line: 3633, column: 17, scope: !4510)
!4517 = !DILocation(line: 3634, column: 13, scope: !4503)
!4518 = !DILocation(line: 3635, column: 9, scope: !4494)
!4519 = !DILocation(line: 3637, column: 16, scope: !4464)
!4520 = !DILocation(line: 3637, column: 9, scope: !4464)
!4521 = distinct !DISubprogram(name: "MPU_xStreamBufferReceiveImpl", scope: !36, file: !36, line: 3646, type: !4522, scopeLine: 3650, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4522 = !DISubroutineType(types: !4523)
!4523 = !{!4467, !58, !26, !4467, !93}
!4524 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !4521, file: !36, line: 3646, type: !58)
!4525 = !DILocation(line: 3646, column: 63, scope: !4521)
!4526 = !DILocalVariable(name: "pvRxData", arg: 2, scope: !4521, file: !36, line: 3647, type: !26)
!4527 = !DILocation(line: 3647, column: 49, scope: !4521)
!4528 = !DILocalVariable(name: "xBufferLengthBytes", arg: 3, scope: !4521, file: !36, line: 3648, type: !4467)
!4529 = !DILocation(line: 3648, column: 49, scope: !4521)
!4530 = !DILocalVariable(name: "xTicksToWait", arg: 4, scope: !4521, file: !36, line: 3649, type: !93)
!4531 = !DILocation(line: 3649, column: 53, scope: !4521)
!4532 = !DILocalVariable(name: "xReturn", scope: !4521, file: !36, line: 3651, type: !4467)
!4533 = !DILocation(line: 3651, column: 16, scope: !4521)
!4534 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4521, file: !36, line: 3652, type: !58)
!4535 = !DILocation(line: 3652, column: 30, scope: !4521)
!4536 = !DILocalVariable(name: "lIndex", scope: !4521, file: !36, line: 3653, type: !27)
!4537 = !DILocation(line: 3653, column: 17, scope: !4521)
!4538 = !DILocalVariable(name: "xIsRxDataBufferWriteable", scope: !4521, file: !36, line: 3654, type: !23)
!4539 = !DILocation(line: 3654, column: 20, scope: !4521)
!4540 = !DILocation(line: 3656, column: 69, scope: !4521)
!4541 = !DILocation(line: 3657, column: 69, scope: !4521)
!4542 = !DILocation(line: 3656, column: 36, scope: !4521)
!4543 = !DILocation(line: 3656, column: 34, scope: !4521)
!4544 = !DILocation(line: 3660, column: 13, scope: !4545)
!4545 = distinct !DILexicalBlock(scope: !4521, file: !36, line: 3660, column: 13)
!4546 = !DILocation(line: 3660, column: 38, scope: !4545)
!4547 = !DILocation(line: 3660, column: 13, scope: !4521)
!4548 = !DILocation(line: 3662, column: 34, scope: !4549)
!4549 = distinct !DILexicalBlock(scope: !4545, file: !36, line: 3661, column: 9)
!4550 = !DILocation(line: 3662, column: 22, scope: !4549)
!4551 = !DILocation(line: 3662, column: 20, scope: !4549)
!4552 = !DILocation(line: 3664, column: 17, scope: !4553)
!4553 = distinct !DILexicalBlock(scope: !4549, file: !36, line: 3664, column: 17)
!4554 = !DILocation(line: 0, scope: !4553)
!4555 = !DILocation(line: 3664, column: 51, scope: !4553)
!4556 = !DILocation(line: 3664, column: 17, scope: !4549)
!4557 = !DILocation(line: 3666, column: 47, scope: !4558)
!4558 = distinct !DILexicalBlock(scope: !4553, file: !36, line: 3665, column: 13)
!4559 = !DILocation(line: 3666, column: 45, scope: !4558)
!4560 = !DILocation(line: 3668, column: 21, scope: !4561)
!4561 = distinct !DILexicalBlock(scope: !4558, file: !36, line: 3668, column: 21)
!4562 = !DILocation(line: 3668, column: 49, scope: !4561)
!4563 = !DILocation(line: 3668, column: 21, scope: !4558)
!4564 = !DILocation(line: 3670, column: 53, scope: !4565)
!4565 = distinct !DILexicalBlock(scope: !4561, file: !36, line: 3669, column: 17)
!4566 = !DILocation(line: 3670, column: 82, scope: !4565)
!4567 = !DILocation(line: 3670, column: 92, scope: !4565)
!4568 = !DILocation(line: 3670, column: 112, scope: !4565)
!4569 = !DILocation(line: 3670, column: 31, scope: !4565)
!4570 = !DILocation(line: 3670, column: 29, scope: !4565)
!4571 = !DILocation(line: 3671, column: 17, scope: !4565)
!4572 = !DILocation(line: 3672, column: 13, scope: !4558)
!4573 = !DILocation(line: 3673, column: 9, scope: !4549)
!4574 = !DILocation(line: 3675, column: 16, scope: !4521)
!4575 = !DILocation(line: 3675, column: 9, scope: !4521)
!4576 = distinct !DISubprogram(name: "MPU_xStreamBufferIsFullImpl", scope: !36, file: !36, line: 3681, type: !4577, scopeLine: 3682, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4577 = !DISubroutineType(types: !4578)
!4578 = !{!23, !58}
!4579 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !4576, file: !36, line: 3681, type: !58)
!4580 = !DILocation(line: 3681, column: 66, scope: !4576)
!4581 = !DILocalVariable(name: "xReturn", scope: !4576, file: !36, line: 3683, type: !23)
!4582 = !DILocation(line: 3683, column: 20, scope: !4576)
!4583 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4576, file: !36, line: 3684, type: !58)
!4584 = !DILocation(line: 3684, column: 30, scope: !4576)
!4585 = !DILocalVariable(name: "lIndex", scope: !4576, file: !36, line: 3685, type: !27)
!4586 = !DILocation(line: 3685, column: 17, scope: !4576)
!4587 = !DILocation(line: 3687, column: 30, scope: !4576)
!4588 = !DILocation(line: 3687, column: 18, scope: !4576)
!4589 = !DILocation(line: 3687, column: 16, scope: !4576)
!4590 = !DILocation(line: 3689, column: 13, scope: !4591)
!4591 = distinct !DILexicalBlock(scope: !4576, file: !36, line: 3689, column: 13)
!4592 = !DILocation(line: 0, scope: !4591)
!4593 = !DILocation(line: 3689, column: 47, scope: !4591)
!4594 = !DILocation(line: 3689, column: 13, scope: !4576)
!4595 = !DILocation(line: 3691, column: 43, scope: !4596)
!4596 = distinct !DILexicalBlock(scope: !4591, file: !36, line: 3690, column: 9)
!4597 = !DILocation(line: 3691, column: 41, scope: !4596)
!4598 = !DILocation(line: 3693, column: 17, scope: !4599)
!4599 = distinct !DILexicalBlock(scope: !4596, file: !36, line: 3693, column: 17)
!4600 = !DILocation(line: 3693, column: 45, scope: !4599)
!4601 = !DILocation(line: 3693, column: 17, scope: !4596)
!4602 = !DILocation(line: 3695, column: 48, scope: !4603)
!4603 = distinct !DILexicalBlock(scope: !4599, file: !36, line: 3694, column: 13)
!4604 = !DILocation(line: 3695, column: 27, scope: !4603)
!4605 = !DILocation(line: 3695, column: 25, scope: !4603)
!4606 = !DILocation(line: 3696, column: 13, scope: !4603)
!4607 = !DILocation(line: 3697, column: 9, scope: !4596)
!4608 = !DILocation(line: 3699, column: 16, scope: !4576)
!4609 = !DILocation(line: 3699, column: 9, scope: !4576)
!4610 = distinct !DISubprogram(name: "MPU_xStreamBufferIsEmptyImpl", scope: !36, file: !36, line: 3705, type: !4577, scopeLine: 3706, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4611 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !4610, file: !36, line: 3705, type: !58)
!4612 = !DILocation(line: 3705, column: 67, scope: !4610)
!4613 = !DILocalVariable(name: "xReturn", scope: !4610, file: !36, line: 3707, type: !23)
!4614 = !DILocation(line: 3707, column: 20, scope: !4610)
!4615 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4610, file: !36, line: 3708, type: !58)
!4616 = !DILocation(line: 3708, column: 30, scope: !4610)
!4617 = !DILocalVariable(name: "lIndex", scope: !4610, file: !36, line: 3709, type: !27)
!4618 = !DILocation(line: 3709, column: 17, scope: !4610)
!4619 = !DILocation(line: 3711, column: 30, scope: !4610)
!4620 = !DILocation(line: 3711, column: 18, scope: !4610)
!4621 = !DILocation(line: 3711, column: 16, scope: !4610)
!4622 = !DILocation(line: 3713, column: 13, scope: !4623)
!4623 = distinct !DILexicalBlock(scope: !4610, file: !36, line: 3713, column: 13)
!4624 = !DILocation(line: 0, scope: !4623)
!4625 = !DILocation(line: 3713, column: 47, scope: !4623)
!4626 = !DILocation(line: 3713, column: 13, scope: !4610)
!4627 = !DILocation(line: 3715, column: 43, scope: !4628)
!4628 = distinct !DILexicalBlock(scope: !4623, file: !36, line: 3714, column: 9)
!4629 = !DILocation(line: 3715, column: 41, scope: !4628)
!4630 = !DILocation(line: 3717, column: 17, scope: !4631)
!4631 = distinct !DILexicalBlock(scope: !4628, file: !36, line: 3717, column: 17)
!4632 = !DILocation(line: 3717, column: 45, scope: !4631)
!4633 = !DILocation(line: 3717, column: 17, scope: !4628)
!4634 = !DILocation(line: 3719, column: 49, scope: !4635)
!4635 = distinct !DILexicalBlock(scope: !4631, file: !36, line: 3718, column: 13)
!4636 = !DILocation(line: 3719, column: 27, scope: !4635)
!4637 = !DILocation(line: 3719, column: 25, scope: !4635)
!4638 = !DILocation(line: 3720, column: 13, scope: !4635)
!4639 = !DILocation(line: 3721, column: 9, scope: !4628)
!4640 = !DILocation(line: 3723, column: 16, scope: !4610)
!4641 = !DILocation(line: 3723, column: 9, scope: !4610)
!4642 = distinct !DISubprogram(name: "MPU_xStreamBufferSpacesAvailableImpl", scope: !36, file: !36, line: 3729, type: !4643, scopeLine: 3730, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4643 = !DISubroutineType(types: !4644)
!4644 = !{!4467, !58}
!4645 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !4642, file: !36, line: 3729, type: !58)
!4646 = !DILocation(line: 3729, column: 71, scope: !4642)
!4647 = !DILocalVariable(name: "xReturn", scope: !4642, file: !36, line: 3731, type: !4467)
!4648 = !DILocation(line: 3731, column: 16, scope: !4642)
!4649 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4642, file: !36, line: 3732, type: !58)
!4650 = !DILocation(line: 3732, column: 30, scope: !4642)
!4651 = !DILocalVariable(name: "lIndex", scope: !4642, file: !36, line: 3733, type: !27)
!4652 = !DILocation(line: 3733, column: 17, scope: !4642)
!4653 = !DILocation(line: 3735, column: 30, scope: !4642)
!4654 = !DILocation(line: 3735, column: 18, scope: !4642)
!4655 = !DILocation(line: 3735, column: 16, scope: !4642)
!4656 = !DILocation(line: 3737, column: 13, scope: !4657)
!4657 = distinct !DILexicalBlock(scope: !4642, file: !36, line: 3737, column: 13)
!4658 = !DILocation(line: 0, scope: !4657)
!4659 = !DILocation(line: 3737, column: 47, scope: !4657)
!4660 = !DILocation(line: 3737, column: 13, scope: !4642)
!4661 = !DILocation(line: 3739, column: 43, scope: !4662)
!4662 = distinct !DILexicalBlock(scope: !4657, file: !36, line: 3738, column: 9)
!4663 = !DILocation(line: 3739, column: 41, scope: !4662)
!4664 = !DILocation(line: 3741, column: 17, scope: !4665)
!4665 = distinct !DILexicalBlock(scope: !4662, file: !36, line: 3741, column: 17)
!4666 = !DILocation(line: 3741, column: 45, scope: !4665)
!4667 = !DILocation(line: 3741, column: 17, scope: !4662)
!4668 = !DILocation(line: 3743, column: 57, scope: !4669)
!4669 = distinct !DILexicalBlock(scope: !4665, file: !36, line: 3742, column: 13)
!4670 = !DILocation(line: 3743, column: 27, scope: !4669)
!4671 = !DILocation(line: 3743, column: 25, scope: !4669)
!4672 = !DILocation(line: 3744, column: 13, scope: !4669)
!4673 = !DILocation(line: 3745, column: 9, scope: !4662)
!4674 = !DILocation(line: 3747, column: 16, scope: !4642)
!4675 = !DILocation(line: 3747, column: 9, scope: !4642)
!4676 = distinct !DISubprogram(name: "MPU_xStreamBufferBytesAvailableImpl", scope: !36, file: !36, line: 3753, type: !4643, scopeLine: 3754, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4677 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !4676, file: !36, line: 3753, type: !58)
!4678 = !DILocation(line: 3753, column: 70, scope: !4676)
!4679 = !DILocalVariable(name: "xReturn", scope: !4676, file: !36, line: 3755, type: !4467)
!4680 = !DILocation(line: 3755, column: 16, scope: !4676)
!4681 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4676, file: !36, line: 3756, type: !58)
!4682 = !DILocation(line: 3756, column: 30, scope: !4676)
!4683 = !DILocalVariable(name: "lIndex", scope: !4676, file: !36, line: 3757, type: !27)
!4684 = !DILocation(line: 3757, column: 17, scope: !4676)
!4685 = !DILocation(line: 3759, column: 30, scope: !4676)
!4686 = !DILocation(line: 3759, column: 18, scope: !4676)
!4687 = !DILocation(line: 3759, column: 16, scope: !4676)
!4688 = !DILocation(line: 3761, column: 13, scope: !4689)
!4689 = distinct !DILexicalBlock(scope: !4676, file: !36, line: 3761, column: 13)
!4690 = !DILocation(line: 0, scope: !4689)
!4691 = !DILocation(line: 3761, column: 47, scope: !4689)
!4692 = !DILocation(line: 3761, column: 13, scope: !4676)
!4693 = !DILocation(line: 3763, column: 43, scope: !4694)
!4694 = distinct !DILexicalBlock(scope: !4689, file: !36, line: 3762, column: 9)
!4695 = !DILocation(line: 3763, column: 41, scope: !4694)
!4696 = !DILocation(line: 3765, column: 17, scope: !4697)
!4697 = distinct !DILexicalBlock(scope: !4694, file: !36, line: 3765, column: 17)
!4698 = !DILocation(line: 3765, column: 45, scope: !4697)
!4699 = !DILocation(line: 3765, column: 17, scope: !4694)
!4700 = !DILocation(line: 3767, column: 56, scope: !4701)
!4701 = distinct !DILexicalBlock(scope: !4697, file: !36, line: 3766, column: 13)
!4702 = !DILocation(line: 3767, column: 27, scope: !4701)
!4703 = !DILocation(line: 3767, column: 25, scope: !4701)
!4704 = !DILocation(line: 3768, column: 13, scope: !4701)
!4705 = !DILocation(line: 3769, column: 9, scope: !4694)
!4706 = !DILocation(line: 3771, column: 16, scope: !4676)
!4707 = !DILocation(line: 3771, column: 9, scope: !4676)
!4708 = distinct !DISubprogram(name: "MPU_xStreamBufferSetTriggerLevelImpl", scope: !36, file: !36, line: 3778, type: !4709, scopeLine: 3780, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4709 = !DISubroutineType(types: !4710)
!4710 = !{!23, !58, !4467}
!4711 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !4708, file: !36, line: 3778, type: !58)
!4712 = !DILocation(line: 3778, column: 75, scope: !4708)
!4713 = !DILocalVariable(name: "xTriggerLevel", arg: 2, scope: !4708, file: !36, line: 3779, type: !4467)
!4714 = !DILocation(line: 3779, column: 61, scope: !4708)
!4715 = !DILocalVariable(name: "xReturn", scope: !4708, file: !36, line: 3781, type: !23)
!4716 = !DILocation(line: 3781, column: 20, scope: !4708)
!4717 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4708, file: !36, line: 3782, type: !58)
!4718 = !DILocation(line: 3782, column: 30, scope: !4708)
!4719 = !DILocalVariable(name: "lIndex", scope: !4708, file: !36, line: 3783, type: !27)
!4720 = !DILocation(line: 3783, column: 17, scope: !4708)
!4721 = !DILocation(line: 3785, column: 30, scope: !4708)
!4722 = !DILocation(line: 3785, column: 18, scope: !4708)
!4723 = !DILocation(line: 3785, column: 16, scope: !4708)
!4724 = !DILocation(line: 3787, column: 13, scope: !4725)
!4725 = distinct !DILexicalBlock(scope: !4708, file: !36, line: 3787, column: 13)
!4726 = !DILocation(line: 0, scope: !4725)
!4727 = !DILocation(line: 3787, column: 47, scope: !4725)
!4728 = !DILocation(line: 3787, column: 13, scope: !4708)
!4729 = !DILocation(line: 3789, column: 43, scope: !4730)
!4730 = distinct !DILexicalBlock(scope: !4725, file: !36, line: 3788, column: 9)
!4731 = !DILocation(line: 3789, column: 41, scope: !4730)
!4732 = !DILocation(line: 3791, column: 17, scope: !4733)
!4733 = distinct !DILexicalBlock(scope: !4730, file: !36, line: 3791, column: 17)
!4734 = !DILocation(line: 3791, column: 45, scope: !4733)
!4735 = !DILocation(line: 3791, column: 17, scope: !4730)
!4736 = !DILocation(line: 3793, column: 57, scope: !4737)
!4737 = distinct !DILexicalBlock(scope: !4733, file: !36, line: 3792, column: 13)
!4738 = !DILocation(line: 3793, column: 86, scope: !4737)
!4739 = !DILocation(line: 3793, column: 27, scope: !4737)
!4740 = !DILocation(line: 3793, column: 25, scope: !4737)
!4741 = !DILocation(line: 3794, column: 13, scope: !4737)
!4742 = !DILocation(line: 3795, column: 9, scope: !4730)
!4743 = !DILocation(line: 3797, column: 16, scope: !4708)
!4744 = !DILocation(line: 3797, column: 9, scope: !4708)
!4745 = distinct !DISubprogram(name: "MPU_xStreamBufferNextMessageLengthBytesImpl", scope: !36, file: !36, line: 3803, type: !4643, scopeLine: 3804, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4746 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !4745, file: !36, line: 3803, type: !58)
!4747 = !DILocation(line: 3803, column: 78, scope: !4745)
!4748 = !DILocalVariable(name: "xReturn", scope: !4745, file: !36, line: 3805, type: !4467)
!4749 = !DILocation(line: 3805, column: 16, scope: !4745)
!4750 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4745, file: !36, line: 3806, type: !58)
!4751 = !DILocation(line: 3806, column: 30, scope: !4745)
!4752 = !DILocalVariable(name: "lIndex", scope: !4745, file: !36, line: 3807, type: !27)
!4753 = !DILocation(line: 3807, column: 17, scope: !4745)
!4754 = !DILocation(line: 3809, column: 30, scope: !4745)
!4755 = !DILocation(line: 3809, column: 18, scope: !4745)
!4756 = !DILocation(line: 3809, column: 16, scope: !4745)
!4757 = !DILocation(line: 3811, column: 13, scope: !4758)
!4758 = distinct !DILexicalBlock(scope: !4745, file: !36, line: 3811, column: 13)
!4759 = !DILocation(line: 0, scope: !4758)
!4760 = !DILocation(line: 3811, column: 47, scope: !4758)
!4761 = !DILocation(line: 3811, column: 13, scope: !4745)
!4762 = !DILocation(line: 3813, column: 43, scope: !4763)
!4763 = distinct !DILexicalBlock(scope: !4758, file: !36, line: 3812, column: 9)
!4764 = !DILocation(line: 3813, column: 41, scope: !4763)
!4765 = !DILocation(line: 3815, column: 17, scope: !4766)
!4766 = distinct !DILexicalBlock(scope: !4763, file: !36, line: 3815, column: 17)
!4767 = !DILocation(line: 3815, column: 45, scope: !4766)
!4768 = !DILocation(line: 3815, column: 17, scope: !4763)
!4769 = !DILocation(line: 3817, column: 64, scope: !4770)
!4770 = distinct !DILexicalBlock(scope: !4766, file: !36, line: 3816, column: 13)
!4771 = !DILocation(line: 3817, column: 27, scope: !4770)
!4772 = !DILocation(line: 3817, column: 25, scope: !4770)
!4773 = !DILocation(line: 3818, column: 13, scope: !4770)
!4774 = !DILocation(line: 3819, column: 9, scope: !4763)
!4775 = !DILocation(line: 3821, column: 16, scope: !4745)
!4776 = !DILocation(line: 3821, column: 9, scope: !4745)
!4777 = distinct !DISubprogram(name: "MPU_xStreamBufferGenericCreate", scope: !36, file: !36, line: 3832, type: !4778, scopeLine: 3837, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4778 = !DISubroutineType(types: !4779)
!4779 = !{!58, !4467, !4467, !23, !4780, !4780}
!4780 = !DIDerivedType(tag: DW_TAG_typedef, name: "StreamBufferCallbackFunction_t", file: !59, line: 77, baseType: !4781)
!4781 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4782, size: 64)
!4782 = !DISubroutineType(types: !4783)
!4783 = !{null, !58, !23, !3084}
!4784 = !DILocalVariable(name: "xBufferSizeBytes", arg: 1, scope: !4777, file: !36, line: 3832, type: !4467)
!4785 = !DILocation(line: 3832, column: 69, scope: !4777)
!4786 = !DILocalVariable(name: "xTriggerLevelBytes", arg: 2, scope: !4777, file: !36, line: 3833, type: !4467)
!4787 = !DILocation(line: 3833, column: 69, scope: !4777)
!4788 = !DILocalVariable(name: "xIsMessageBuffer", arg: 3, scope: !4777, file: !36, line: 3834, type: !23)
!4789 = !DILocation(line: 3834, column: 73, scope: !4777)
!4790 = !DILocalVariable(name: "pxSendCompletedCallback", arg: 4, scope: !4777, file: !36, line: 3835, type: !4780)
!4791 = !DILocation(line: 3835, column: 93, scope: !4777)
!4792 = !DILocalVariable(name: "pxReceiveCompletedCallback", arg: 5, scope: !4777, file: !36, line: 3836, type: !4780)
!4793 = !DILocation(line: 3836, column: 93, scope: !4777)
!4794 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4777, file: !36, line: 3838, type: !58)
!4795 = !DILocation(line: 3838, column: 34, scope: !4777)
!4796 = !DILocalVariable(name: "xExternalStreamBufferHandle", scope: !4777, file: !36, line: 3839, type: !58)
!4797 = !DILocation(line: 3839, column: 34, scope: !4777)
!4798 = !DILocalVariable(name: "lIndex", scope: !4777, file: !36, line: 3840, type: !27)
!4799 = !DILocation(line: 3840, column: 21, scope: !4777)
!4800 = !DILocation(line: 3846, column: 13, scope: !4801)
!4801 = distinct !DILexicalBlock(scope: !4777, file: !36, line: 3846, column: 13)
!4802 = !DILocation(line: 0, scope: !4801)
!4803 = !DILocation(line: 3846, column: 13, scope: !4777)
!4804 = !DILocation(line: 3849, column: 19, scope: !4805)
!4805 = distinct !DILexicalBlock(scope: !4777, file: !36, line: 3849, column: 17)
!4806 = !DILocation(line: 3849, column: 43, scope: !4805)
!4807 = !DILocation(line: 3849, column: 53, scope: !4805)
!4808 = !DILocation(line: 3850, column: 19, scope: !4805)
!4809 = !DILocation(line: 3850, column: 46, scope: !4805)
!4810 = !DILocation(line: 3849, column: 17, scope: !4777)
!4811 = !DILocation(line: 3852, column: 26, scope: !4812)
!4812 = distinct !DILexicalBlock(scope: !4805, file: !36, line: 3851, column: 13)
!4813 = !DILocation(line: 3852, column: 24, scope: !4812)
!4814 = !DILocation(line: 3854, column: 21, scope: !4815)
!4815 = distinct !DILexicalBlock(scope: !4812, file: !36, line: 3854, column: 21)
!4816 = !DILocation(line: 3854, column: 28, scope: !4815)
!4817 = !DILocation(line: 3854, column: 21, scope: !4812)
!4818 = !DILocation(line: 3856, column: 79, scope: !4819)
!4819 = distinct !DILexicalBlock(scope: !4815, file: !36, line: 3855, column: 17)
!4820 = !DILocation(line: 3857, column: 79, scope: !4819)
!4821 = !DILocation(line: 3858, column: 79, scope: !4819)
!4822 = !DILocation(line: 3856, column: 51, scope: !4819)
!4823 = !DILocation(line: 3856, column: 49, scope: !4819)
!4824 = !DILocation(line: 3862, column: 25, scope: !4825)
!4825 = distinct !DILexicalBlock(scope: !4819, file: !36, line: 3862, column: 25)
!4826 = !DILocation(line: 3862, column: 53, scope: !4825)
!4827 = !DILocation(line: 3862, column: 25, scope: !4819)
!4828 = !DILocation(line: 3864, column: 25, scope: !4829)
!4829 = distinct !DILexicalBlock(scope: !4825, file: !36, line: 3863, column: 21)
!4830 = !DILocation(line: 3865, column: 80, scope: !4829)
!4831 = !DILocation(line: 3865, column: 55, scope: !4829)
!4832 = !DILocation(line: 3865, column: 53, scope: !4829)
!4833 = !DILocation(line: 3866, column: 21, scope: !4829)
!4834 = !DILocation(line: 3869, column: 61, scope: !4835)
!4835 = distinct !DILexicalBlock(scope: !4825, file: !36, line: 3868, column: 21)
!4836 = !DILocation(line: 3869, column: 25, scope: !4835)
!4837 = !DILocation(line: 3871, column: 17, scope: !4819)
!4838 = !DILocation(line: 3872, column: 13, scope: !4812)
!4839 = !DILocation(line: 3876, column: 45, scope: !4840)
!4840 = distinct !DILexicalBlock(scope: !4805, file: !36, line: 3874, column: 13)
!4841 = !DILocation(line: 3879, column: 20, scope: !4777)
!4842 = !DILocation(line: 3879, column: 13, scope: !4777)
!4843 = distinct !DISubprogram(name: "MPU_xStreamBufferGenericCreateStatic", scope: !36, file: !36, line: 3887, type: !4844, scopeLine: 3894, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4844 = !DISubroutineType(types: !4845)
!4845 = !{!58, !4467, !4467, !23, !4846, !4847, !4780, !4780}
!4846 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2867)
!4847 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4848)
!4848 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4849, size: 64)
!4849 = !DIDerivedType(tag: DW_TAG_typedef, name: "StaticStreamBuffer_t", file: !1485, line: 1444, baseType: !4850)
!4850 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xSTATIC_STREAM_BUFFER", file: !1485, line: 1433, size: 704, elements: !4851)
!4851 = !{!4852, !4854, !4855, !4856, !4857}
!4852 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy1", scope: !4850, file: !1485, line: 1435, baseType: !4853, size: 256)
!4853 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4467, size: 256, elements: !1512)
!4854 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy2", scope: !4850, file: !1485, line: 1436, baseType: !2753, size: 192, offset: 256)
!4855 = !DIDerivedType(tag: DW_TAG_member, name: "ucDummy3", scope: !4850, file: !1485, line: 1437, baseType: !1520, size: 8, offset: 448)
!4856 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy4", scope: !4850, file: !1485, line: 1439, baseType: !39, size: 64, offset: 512)
!4857 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy5", scope: !4850, file: !1485, line: 1442, baseType: !2772, size: 128, offset: 576)
!4858 = !DILocalVariable(name: "xBufferSizeBytes", arg: 1, scope: !4843, file: !36, line: 3887, type: !4467)
!4859 = !DILocation(line: 3887, column: 75, scope: !4843)
!4860 = !DILocalVariable(name: "xTriggerLevelBytes", arg: 2, scope: !4843, file: !36, line: 3888, type: !4467)
!4861 = !DILocation(line: 3888, column: 75, scope: !4843)
!4862 = !DILocalVariable(name: "xIsMessageBuffer", arg: 3, scope: !4843, file: !36, line: 3889, type: !23)
!4863 = !DILocation(line: 3889, column: 79, scope: !4843)
!4864 = !DILocalVariable(name: "pucStreamBufferStorageArea", arg: 4, scope: !4843, file: !36, line: 3890, type: !4846)
!4865 = !DILocation(line: 3890, column: 84, scope: !4843)
!4866 = !DILocalVariable(name: "pxStaticStreamBuffer", arg: 5, scope: !4843, file: !36, line: 3891, type: !4847)
!4867 = !DILocation(line: 3891, column: 97, scope: !4843)
!4868 = !DILocalVariable(name: "pxSendCompletedCallback", arg: 6, scope: !4843, file: !36, line: 3892, type: !4780)
!4869 = !DILocation(line: 3892, column: 99, scope: !4843)
!4870 = !DILocalVariable(name: "pxReceiveCompletedCallback", arg: 7, scope: !4843, file: !36, line: 3893, type: !4780)
!4871 = !DILocation(line: 3893, column: 99, scope: !4843)
!4872 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4843, file: !36, line: 3895, type: !58)
!4873 = !DILocation(line: 3895, column: 34, scope: !4843)
!4874 = !DILocalVariable(name: "xExternalStreamBufferHandle", scope: !4843, file: !36, line: 3896, type: !58)
!4875 = !DILocation(line: 3896, column: 34, scope: !4843)
!4876 = !DILocalVariable(name: "lIndex", scope: !4843, file: !36, line: 3897, type: !27)
!4877 = !DILocation(line: 3897, column: 21, scope: !4843)
!4878 = !DILocation(line: 3903, column: 13, scope: !4879)
!4879 = distinct !DILexicalBlock(scope: !4843, file: !36, line: 3903, column: 13)
!4880 = !DILocation(line: 0, scope: !4879)
!4881 = !DILocation(line: 3903, column: 13, scope: !4843)
!4882 = !DILocation(line: 3906, column: 19, scope: !4883)
!4883 = distinct !DILexicalBlock(scope: !4843, file: !36, line: 3906, column: 17)
!4884 = !DILocation(line: 3906, column: 43, scope: !4883)
!4885 = !DILocation(line: 3906, column: 53, scope: !4883)
!4886 = !DILocation(line: 3907, column: 19, scope: !4883)
!4887 = !DILocation(line: 3907, column: 46, scope: !4883)
!4888 = !DILocation(line: 3906, column: 17, scope: !4843)
!4889 = !DILocation(line: 3909, column: 26, scope: !4890)
!4890 = distinct !DILexicalBlock(scope: !4883, file: !36, line: 3908, column: 13)
!4891 = !DILocation(line: 3909, column: 24, scope: !4890)
!4892 = !DILocation(line: 3911, column: 21, scope: !4893)
!4893 = distinct !DILexicalBlock(scope: !4890, file: !36, line: 3911, column: 21)
!4894 = !DILocation(line: 3911, column: 28, scope: !4893)
!4895 = !DILocation(line: 3911, column: 21, scope: !4890)
!4896 = !DILocation(line: 3913, column: 85, scope: !4897)
!4897 = distinct !DILexicalBlock(scope: !4893, file: !36, line: 3912, column: 17)
!4898 = !DILocation(line: 3914, column: 85, scope: !4897)
!4899 = !DILocation(line: 3915, column: 85, scope: !4897)
!4900 = !DILocation(line: 3916, column: 85, scope: !4897)
!4901 = !DILocation(line: 3917, column: 85, scope: !4897)
!4902 = !DILocation(line: 3913, column: 51, scope: !4897)
!4903 = !DILocation(line: 3913, column: 49, scope: !4897)
!4904 = !DILocation(line: 3921, column: 25, scope: !4905)
!4905 = distinct !DILexicalBlock(scope: !4897, file: !36, line: 3921, column: 25)
!4906 = !DILocation(line: 3921, column: 53, scope: !4905)
!4907 = !DILocation(line: 3921, column: 25, scope: !4897)
!4908 = !DILocation(line: 3923, column: 25, scope: !4909)
!4909 = distinct !DILexicalBlock(scope: !4905, file: !36, line: 3922, column: 21)
!4910 = !DILocation(line: 3924, column: 80, scope: !4909)
!4911 = !DILocation(line: 3924, column: 55, scope: !4909)
!4912 = !DILocation(line: 3924, column: 53, scope: !4909)
!4913 = !DILocation(line: 3925, column: 21, scope: !4909)
!4914 = !DILocation(line: 3928, column: 61, scope: !4915)
!4915 = distinct !DILexicalBlock(scope: !4905, file: !36, line: 3927, column: 21)
!4916 = !DILocation(line: 3928, column: 25, scope: !4915)
!4917 = !DILocation(line: 3930, column: 17, scope: !4897)
!4918 = !DILocation(line: 3931, column: 13, scope: !4890)
!4919 = !DILocation(line: 3935, column: 45, scope: !4920)
!4920 = distinct !DILexicalBlock(scope: !4883, file: !36, line: 3933, column: 13)
!4921 = !DILocation(line: 3938, column: 20, scope: !4843)
!4922 = !DILocation(line: 3938, column: 13, scope: !4843)
!4923 = distinct !DISubprogram(name: "MPU_vStreamBufferDelete", scope: !36, file: !36, line: 3944, type: !4924, scopeLine: 3945, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4924 = !DISubroutineType(types: !4925)
!4925 = !{null, !58}
!4926 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !4923, file: !36, line: 3944, type: !58)
!4927 = !DILocation(line: 3944, column: 56, scope: !4923)
!4928 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4923, file: !36, line: 3946, type: !58)
!4929 = !DILocation(line: 3946, column: 30, scope: !4923)
!4930 = !DILocalVariable(name: "lIndex", scope: !4923, file: !36, line: 3947, type: !27)
!4931 = !DILocation(line: 3947, column: 17, scope: !4923)
!4932 = !DILocation(line: 3949, column: 30, scope: !4923)
!4933 = !DILocation(line: 3949, column: 18, scope: !4923)
!4934 = !DILocation(line: 3949, column: 16, scope: !4923)
!4935 = !DILocation(line: 3951, column: 13, scope: !4936)
!4936 = distinct !DILexicalBlock(scope: !4923, file: !36, line: 3951, column: 13)
!4937 = !DILocation(line: 0, scope: !4936)
!4938 = !DILocation(line: 3951, column: 47, scope: !4936)
!4939 = !DILocation(line: 3951, column: 13, scope: !4923)
!4940 = !DILocation(line: 3953, column: 43, scope: !4941)
!4941 = distinct !DILexicalBlock(scope: !4936, file: !36, line: 3952, column: 9)
!4942 = !DILocation(line: 3953, column: 41, scope: !4941)
!4943 = !DILocation(line: 3955, column: 17, scope: !4944)
!4944 = distinct !DILexicalBlock(scope: !4941, file: !36, line: 3955, column: 17)
!4945 = !DILocation(line: 3955, column: 45, scope: !4944)
!4946 = !DILocation(line: 3955, column: 17, scope: !4941)
!4947 = !DILocation(line: 3957, column: 38, scope: !4948)
!4948 = distinct !DILexicalBlock(scope: !4944, file: !36, line: 3956, column: 13)
!4949 = !DILocation(line: 3957, column: 17, scope: !4948)
!4950 = !DILocation(line: 3958, column: 13, scope: !4948)
!4951 = !DILocation(line: 3960, column: 49, scope: !4941)
!4952 = !DILocation(line: 3960, column: 13, scope: !4941)
!4953 = !DILocation(line: 3961, column: 9, scope: !4941)
!4954 = !DILocation(line: 3962, column: 5, scope: !4923)
!4955 = distinct !DISubprogram(name: "MPU_xStreamBufferReset", scope: !36, file: !36, line: 3965, type: !4577, scopeLine: 3966, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4956 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !4955, file: !36, line: 3965, type: !58)
!4957 = !DILocation(line: 3965, column: 61, scope: !4955)
!4958 = !DILocalVariable(name: "xReturn", scope: !4955, file: !36, line: 3967, type: !23)
!4959 = !DILocation(line: 3967, column: 20, scope: !4955)
!4960 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4955, file: !36, line: 3968, type: !58)
!4961 = !DILocation(line: 3968, column: 30, scope: !4955)
!4962 = !DILocalVariable(name: "lIndex", scope: !4955, file: !36, line: 3969, type: !27)
!4963 = !DILocation(line: 3969, column: 17, scope: !4955)
!4964 = !DILocation(line: 3971, column: 30, scope: !4955)
!4965 = !DILocation(line: 3971, column: 18, scope: !4955)
!4966 = !DILocation(line: 3971, column: 16, scope: !4955)
!4967 = !DILocation(line: 3973, column: 13, scope: !4968)
!4968 = distinct !DILexicalBlock(scope: !4955, file: !36, line: 3973, column: 13)
!4969 = !DILocation(line: 0, scope: !4968)
!4970 = !DILocation(line: 3973, column: 47, scope: !4968)
!4971 = !DILocation(line: 3973, column: 13, scope: !4955)
!4972 = !DILocation(line: 3975, column: 43, scope: !4973)
!4973 = distinct !DILexicalBlock(scope: !4968, file: !36, line: 3974, column: 9)
!4974 = !DILocation(line: 3975, column: 41, scope: !4973)
!4975 = !DILocation(line: 3977, column: 17, scope: !4976)
!4976 = distinct !DILexicalBlock(scope: !4973, file: !36, line: 3977, column: 17)
!4977 = !DILocation(line: 3977, column: 45, scope: !4976)
!4978 = !DILocation(line: 3977, column: 17, scope: !4973)
!4979 = !DILocation(line: 3979, column: 47, scope: !4980)
!4980 = distinct !DILexicalBlock(scope: !4976, file: !36, line: 3978, column: 13)
!4981 = !DILocation(line: 3979, column: 27, scope: !4980)
!4982 = !DILocation(line: 3979, column: 25, scope: !4980)
!4983 = !DILocation(line: 3980, column: 13, scope: !4980)
!4984 = !DILocation(line: 3981, column: 9, scope: !4973)
!4985 = !DILocation(line: 3983, column: 16, scope: !4955)
!4986 = !DILocation(line: 3983, column: 9, scope: !4955)
!4987 = distinct !DISubprogram(name: "MPU_xStreamBufferGetStaticBuffers", scope: !36, file: !36, line: 3989, type: !4988, scopeLine: 3992, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!4988 = !DISubroutineType(types: !4989)
!4989 = !{!23, !58, !2867, !4848}
!4990 = !DILocalVariable(name: "xStreamBuffers", arg: 1, scope: !4987, file: !36, line: 3989, type: !58)
!4991 = !DILocation(line: 3989, column: 76, scope: !4987)
!4992 = !DILocalVariable(name: "ppucStreamBufferStorageArea", arg: 2, scope: !4987, file: !36, line: 3990, type: !2867)
!4993 = !DILocation(line: 3990, column: 65, scope: !4987)
!4994 = !DILocalVariable(name: "ppxStaticStreamBuffer", arg: 3, scope: !4987, file: !36, line: 3991, type: !4848)
!4995 = !DILocation(line: 3991, column: 78, scope: !4987)
!4996 = !DILocalVariable(name: "xReturn", scope: !4987, file: !36, line: 3993, type: !23)
!4997 = !DILocation(line: 3993, column: 24, scope: !4987)
!4998 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !4987, file: !36, line: 3994, type: !58)
!4999 = !DILocation(line: 3994, column: 34, scope: !4987)
!5000 = !DILocalVariable(name: "lIndex", scope: !4987, file: !36, line: 3995, type: !27)
!5001 = !DILocation(line: 3995, column: 21, scope: !4987)
!5002 = !DILocation(line: 3997, column: 34, scope: !4987)
!5003 = !DILocation(line: 3997, column: 22, scope: !4987)
!5004 = !DILocation(line: 3997, column: 20, scope: !4987)
!5005 = !DILocation(line: 3999, column: 17, scope: !5006)
!5006 = distinct !DILexicalBlock(scope: !4987, file: !36, line: 3999, column: 17)
!5007 = !DILocation(line: 0, scope: !5006)
!5008 = !DILocation(line: 3999, column: 51, scope: !5006)
!5009 = !DILocation(line: 3999, column: 17, scope: !4987)
!5010 = !DILocation(line: 4001, column: 47, scope: !5011)
!5011 = distinct !DILexicalBlock(scope: !5006, file: !36, line: 4000, column: 13)
!5012 = !DILocation(line: 4001, column: 45, scope: !5011)
!5013 = !DILocation(line: 4003, column: 21, scope: !5014)
!5014 = distinct !DILexicalBlock(scope: !5011, file: !36, line: 4003, column: 21)
!5015 = !DILocation(line: 4003, column: 49, scope: !5014)
!5016 = !DILocation(line: 4003, column: 21, scope: !5011)
!5017 = !DILocation(line: 4005, column: 66, scope: !5018)
!5018 = distinct !DILexicalBlock(scope: !5014, file: !36, line: 4004, column: 17)
!5019 = !DILocation(line: 4005, column: 95, scope: !5018)
!5020 = !DILocation(line: 4005, column: 124, scope: !5018)
!5021 = !DILocation(line: 4005, column: 31, scope: !5018)
!5022 = !DILocation(line: 4005, column: 29, scope: !5018)
!5023 = !DILocation(line: 4006, column: 17, scope: !5018)
!5024 = !DILocation(line: 4007, column: 13, scope: !5011)
!5025 = !DILocation(line: 4009, column: 20, scope: !4987)
!5026 = !DILocation(line: 4009, column: 13, scope: !4987)
!5027 = distinct !DISubprogram(name: "MPU_xStreamBufferSendFromISR", scope: !36, file: !36, line: 4015, type: !5028, scopeLine: 4019, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!5028 = !DISubroutineType(types: !5029)
!5029 = !{!4467, !58, !2195, !4467, !3084}
!5030 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !5027, file: !36, line: 4015, type: !58)
!5031 = !DILocation(line: 4015, column: 63, scope: !5027)
!5032 = !DILocalVariable(name: "pvTxData", arg: 2, scope: !5027, file: !36, line: 4016, type: !2195)
!5033 = !DILocation(line: 4016, column: 55, scope: !5027)
!5034 = !DILocalVariable(name: "xDataLengthBytes", arg: 3, scope: !5027, file: !36, line: 4017, type: !4467)
!5035 = !DILocation(line: 4017, column: 49, scope: !5027)
!5036 = !DILocalVariable(name: "pxHigherPriorityTaskWoken", arg: 4, scope: !5027, file: !36, line: 4018, type: !3084)
!5037 = !DILocation(line: 4018, column: 61, scope: !5027)
!5038 = !DILocalVariable(name: "xReturn", scope: !5027, file: !36, line: 4020, type: !4467)
!5039 = !DILocation(line: 4020, column: 16, scope: !5027)
!5040 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !5027, file: !36, line: 4021, type: !58)
!5041 = !DILocation(line: 4021, column: 30, scope: !5027)
!5042 = !DILocalVariable(name: "lIndex", scope: !5027, file: !36, line: 4022, type: !27)
!5043 = !DILocation(line: 4022, column: 17, scope: !5027)
!5044 = !DILocation(line: 4024, column: 30, scope: !5027)
!5045 = !DILocation(line: 4024, column: 18, scope: !5027)
!5046 = !DILocation(line: 4024, column: 16, scope: !5027)
!5047 = !DILocation(line: 4026, column: 13, scope: !5048)
!5048 = distinct !DILexicalBlock(scope: !5027, file: !36, line: 4026, column: 13)
!5049 = !DILocation(line: 0, scope: !5048)
!5050 = !DILocation(line: 4026, column: 47, scope: !5048)
!5051 = !DILocation(line: 4026, column: 13, scope: !5027)
!5052 = !DILocation(line: 4028, column: 43, scope: !5053)
!5053 = distinct !DILexicalBlock(scope: !5048, file: !36, line: 4027, column: 9)
!5054 = !DILocation(line: 4028, column: 41, scope: !5053)
!5055 = !DILocation(line: 4030, column: 17, scope: !5056)
!5056 = distinct !DILexicalBlock(scope: !5053, file: !36, line: 4030, column: 17)
!5057 = !DILocation(line: 4030, column: 45, scope: !5056)
!5058 = !DILocation(line: 4030, column: 17, scope: !5053)
!5059 = !DILocation(line: 4032, column: 53, scope: !5060)
!5060 = distinct !DILexicalBlock(scope: !5056, file: !36, line: 4031, column: 13)
!5061 = !DILocation(line: 4032, column: 82, scope: !5060)
!5062 = !DILocation(line: 4032, column: 92, scope: !5060)
!5063 = !DILocation(line: 4032, column: 110, scope: !5060)
!5064 = !DILocation(line: 4032, column: 27, scope: !5060)
!5065 = !DILocation(line: 4032, column: 25, scope: !5060)
!5066 = !DILocation(line: 4033, column: 13, scope: !5060)
!5067 = !DILocation(line: 4034, column: 9, scope: !5053)
!5068 = !DILocation(line: 4036, column: 16, scope: !5027)
!5069 = !DILocation(line: 4036, column: 9, scope: !5027)
!5070 = distinct !DISubprogram(name: "MPU_xStreamBufferReceiveFromISR", scope: !36, file: !36, line: 4040, type: !5071, scopeLine: 4044, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!5071 = !DISubroutineType(types: !5072)
!5072 = !{!4467, !58, !26, !4467, !3084}
!5073 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !5070, file: !36, line: 4040, type: !58)
!5074 = !DILocation(line: 4040, column: 66, scope: !5070)
!5075 = !DILocalVariable(name: "pvRxData", arg: 2, scope: !5070, file: !36, line: 4041, type: !26)
!5076 = !DILocation(line: 4041, column: 52, scope: !5070)
!5077 = !DILocalVariable(name: "xBufferLengthBytes", arg: 3, scope: !5070, file: !36, line: 4042, type: !4467)
!5078 = !DILocation(line: 4042, column: 52, scope: !5070)
!5079 = !DILocalVariable(name: "pxHigherPriorityTaskWoken", arg: 4, scope: !5070, file: !36, line: 4043, type: !3084)
!5080 = !DILocation(line: 4043, column: 64, scope: !5070)
!5081 = !DILocalVariable(name: "xReturn", scope: !5070, file: !36, line: 4045, type: !4467)
!5082 = !DILocation(line: 4045, column: 16, scope: !5070)
!5083 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !5070, file: !36, line: 4046, type: !58)
!5084 = !DILocation(line: 4046, column: 30, scope: !5070)
!5085 = !DILocalVariable(name: "lIndex", scope: !5070, file: !36, line: 4047, type: !27)
!5086 = !DILocation(line: 4047, column: 17, scope: !5070)
!5087 = !DILocation(line: 4049, column: 30, scope: !5070)
!5088 = !DILocation(line: 4049, column: 18, scope: !5070)
!5089 = !DILocation(line: 4049, column: 16, scope: !5070)
!5090 = !DILocation(line: 4051, column: 13, scope: !5091)
!5091 = distinct !DILexicalBlock(scope: !5070, file: !36, line: 4051, column: 13)
!5092 = !DILocation(line: 0, scope: !5091)
!5093 = !DILocation(line: 4051, column: 47, scope: !5091)
!5094 = !DILocation(line: 4051, column: 13, scope: !5070)
!5095 = !DILocation(line: 4053, column: 43, scope: !5096)
!5096 = distinct !DILexicalBlock(scope: !5091, file: !36, line: 4052, column: 9)
!5097 = !DILocation(line: 4053, column: 41, scope: !5096)
!5098 = !DILocation(line: 4055, column: 17, scope: !5099)
!5099 = distinct !DILexicalBlock(scope: !5096, file: !36, line: 4055, column: 17)
!5100 = !DILocation(line: 4055, column: 45, scope: !5099)
!5101 = !DILocation(line: 4055, column: 17, scope: !5096)
!5102 = !DILocation(line: 4057, column: 56, scope: !5103)
!5103 = distinct !DILexicalBlock(scope: !5099, file: !36, line: 4056, column: 13)
!5104 = !DILocation(line: 4057, column: 85, scope: !5103)
!5105 = !DILocation(line: 4057, column: 95, scope: !5103)
!5106 = !DILocation(line: 4057, column: 115, scope: !5103)
!5107 = !DILocation(line: 4057, column: 27, scope: !5103)
!5108 = !DILocation(line: 4057, column: 25, scope: !5103)
!5109 = !DILocation(line: 4058, column: 13, scope: !5103)
!5110 = !DILocation(line: 4059, column: 9, scope: !5096)
!5111 = !DILocation(line: 4061, column: 16, scope: !5070)
!5112 = !DILocation(line: 4061, column: 9, scope: !5070)
!5113 = distinct !DISubprogram(name: "MPU_xStreamBufferSendCompletedFromISR", scope: !36, file: !36, line: 4065, type: !5114, scopeLine: 4067, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!5114 = !DISubroutineType(types: !5115)
!5115 = !{!23, !58, !2108}
!5116 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !5113, file: !36, line: 4065, type: !58)
!5117 = !DILocation(line: 4065, column: 76, scope: !5113)
!5118 = !DILocalVariable(name: "pxHigherPriorityTaskWoken", arg: 2, scope: !5113, file: !36, line: 4066, type: !2108)
!5119 = !DILocation(line: 4066, column: 68, scope: !5113)
!5120 = !DILocalVariable(name: "xReturn", scope: !5113, file: !36, line: 4068, type: !23)
!5121 = !DILocation(line: 4068, column: 20, scope: !5113)
!5122 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !5113, file: !36, line: 4069, type: !58)
!5123 = !DILocation(line: 4069, column: 30, scope: !5113)
!5124 = !DILocalVariable(name: "lIndex", scope: !5113, file: !36, line: 4070, type: !27)
!5125 = !DILocation(line: 4070, column: 17, scope: !5113)
!5126 = !DILocation(line: 4072, column: 30, scope: !5113)
!5127 = !DILocation(line: 4072, column: 18, scope: !5113)
!5128 = !DILocation(line: 4072, column: 16, scope: !5113)
!5129 = !DILocation(line: 4074, column: 13, scope: !5130)
!5130 = distinct !DILexicalBlock(scope: !5113, file: !36, line: 4074, column: 13)
!5131 = !DILocation(line: 0, scope: !5130)
!5132 = !DILocation(line: 4074, column: 47, scope: !5130)
!5133 = !DILocation(line: 4074, column: 13, scope: !5113)
!5134 = !DILocation(line: 4076, column: 43, scope: !5135)
!5135 = distinct !DILexicalBlock(scope: !5130, file: !36, line: 4075, column: 9)
!5136 = !DILocation(line: 4076, column: 41, scope: !5135)
!5137 = !DILocation(line: 4078, column: 17, scope: !5138)
!5138 = distinct !DILexicalBlock(scope: !5135, file: !36, line: 4078, column: 17)
!5139 = !DILocation(line: 4078, column: 45, scope: !5138)
!5140 = !DILocation(line: 4078, column: 17, scope: !5135)
!5141 = !DILocation(line: 4080, column: 62, scope: !5142)
!5142 = distinct !DILexicalBlock(scope: !5138, file: !36, line: 4079, column: 13)
!5143 = !DILocation(line: 4080, column: 91, scope: !5142)
!5144 = !DILocation(line: 4080, column: 27, scope: !5142)
!5145 = !DILocation(line: 4080, column: 25, scope: !5142)
!5146 = !DILocation(line: 4081, column: 13, scope: !5142)
!5147 = !DILocation(line: 4082, column: 9, scope: !5135)
!5148 = !DILocation(line: 4084, column: 16, scope: !5113)
!5149 = !DILocation(line: 4084, column: 9, scope: !5113)
!5150 = distinct !DISubprogram(name: "MPU_xStreamBufferReceiveCompletedFromISR", scope: !36, file: !36, line: 4088, type: !5114, scopeLine: 4090, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !80)
!5151 = !DILocalVariable(name: "xStreamBuffer", arg: 1, scope: !5150, file: !36, line: 4088, type: !58)
!5152 = !DILocation(line: 4088, column: 79, scope: !5150)
!5153 = !DILocalVariable(name: "pxHigherPriorityTaskWoken", arg: 2, scope: !5150, file: !36, line: 4089, type: !2108)
!5154 = !DILocation(line: 4089, column: 71, scope: !5150)
!5155 = !DILocalVariable(name: "xReturn", scope: !5150, file: !36, line: 4091, type: !23)
!5156 = !DILocation(line: 4091, column: 20, scope: !5150)
!5157 = !DILocalVariable(name: "xInternalStreamBufferHandle", scope: !5150, file: !36, line: 4092, type: !58)
!5158 = !DILocation(line: 4092, column: 30, scope: !5150)
!5159 = !DILocalVariable(name: "lIndex", scope: !5150, file: !36, line: 4093, type: !27)
!5160 = !DILocation(line: 4093, column: 17, scope: !5150)
!5161 = !DILocation(line: 4095, column: 30, scope: !5150)
!5162 = !DILocation(line: 4095, column: 18, scope: !5150)
!5163 = !DILocation(line: 4095, column: 16, scope: !5150)
!5164 = !DILocation(line: 4097, column: 13, scope: !5165)
!5165 = distinct !DILexicalBlock(scope: !5150, file: !36, line: 4097, column: 13)
!5166 = !DILocation(line: 0, scope: !5165)
!5167 = !DILocation(line: 4097, column: 47, scope: !5165)
!5168 = !DILocation(line: 4097, column: 13, scope: !5150)
!5169 = !DILocation(line: 4099, column: 43, scope: !5170)
!5170 = distinct !DILexicalBlock(scope: !5165, file: !36, line: 4098, column: 9)
!5171 = !DILocation(line: 4099, column: 41, scope: !5170)
!5172 = !DILocation(line: 4101, column: 17, scope: !5173)
!5173 = distinct !DILexicalBlock(scope: !5170, file: !36, line: 4101, column: 17)
!5174 = !DILocation(line: 4101, column: 45, scope: !5173)
!5175 = !DILocation(line: 4101, column: 17, scope: !5170)
!5176 = !DILocation(line: 4103, column: 65, scope: !5177)
!5177 = distinct !DILexicalBlock(scope: !5173, file: !36, line: 4102, column: 13)
!5178 = !DILocation(line: 4103, column: 94, scope: !5177)
!5179 = !DILocation(line: 4103, column: 27, scope: !5177)
!5180 = !DILocation(line: 4103, column: 25, scope: !5177)
!5181 = !DILocation(line: 4104, column: 13, scope: !5177)
!5182 = !DILocation(line: 4105, column: 9, scope: !5170)
!5183 = !DILocation(line: 4107, column: 16, scope: !5150)
!5184 = !DILocation(line: 4107, column: 9, scope: !5150)
!5185 = distinct !DISubprogram(name: "main", scope: !79, file: !79, line: 16, type: !5186, scopeLine: 17, spFlags: DISPFlagDefinition, unit: !78, retainedNodes: !80)
!5186 = !DISubroutineType(types: !5187)
!5187 = !{!31}
!5188 = !DILocation(line: 18, column: 10, scope: !5185)
!5189 = !DILocalVariable(name: "xTaskToResume", scope: !5185, file: !79, line: 19, type: !32)
!5190 = !DILocation(line: 19, column: 14, scope: !5185)
!5191 = !DILocation(line: 20, column: 33, scope: !5185)
!5192 = !DILocation(line: 20, column: 1, scope: !5185)
!5193 = !DILocation(line: 21, column: 4, scope: !5194)
!5194 = distinct !DILexicalBlock(scope: !5185, file: !79, line: 21, column: 4)
!5195 = !DILocation(line: 21, column: 18, scope: !5194)
!5196 = !DILocation(line: 21, column: 4, scope: !5185)
!5197 = !DILocation(line: 21, column: 27, scope: !5194)
!5198 = !DILocation(line: 22, column: 22, scope: !5185)
!5199 = !DILocation(line: 22, column: 1, scope: !5185)
!5200 = !DILocation(line: 23, column: 1, scope: !5185)
!5201 = !DILocation(line: 24, column: 1, scope: !5185)
!5202 = distinct !DISubprogram(name: "vTaskFunction1", scope: !79, file: !79, line: 25, type: !1312, scopeLine: 26, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !78, retainedNodes: !80)
!5203 = !DILocalVariable(name: "pvParameters", arg: 1, scope: !5202, file: !79, line: 25, type: !26)
!5204 = !DILocation(line: 25, column: 28, scope: !5202)
!5205 = !DILocation(line: 27, column: 5, scope: !5202)
!5206 = !DILocation(line: 28, column: 1, scope: !5202)
!5207 = distinct !DISubprogram(name: "vTaskSuspend", scope: !79, file: !79, line: 30, type: !370, scopeLine: 30, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !78, retainedNodes: !80)
!5208 = !DILocalVariable(name: "xTaskToResume", arg: 1, scope: !5207, file: !79, line: 30, type: !32)
!5209 = !DILocation(line: 30, column: 32, scope: !5207)
!5210 = !DILocation(line: 31, column: 33, scope: !5207)
!5211 = !DILocation(line: 31, column: 5, scope: !5207)
!5212 = !DILocation(line: 32, column: 1, scope: !5207)
!5213 = distinct !DISubprogram(name: "portIS_TASK_PRIVILEGED", scope: !79, file: !79, line: 34, type: !5214, scopeLine: 34, spFlags: DISPFlagDefinition, unit: !78, retainedNodes: !80)
!5214 = !DISubroutineType(types: !5215)
!5215 = !{null}
!5216 = !DILocation(line: 35, column: 14, scope: !5213)
!5217 = !DILocation(line: 36, column: 1, scope: !5213)
