; ModuleID = '/home/klee/klee_src/freertos_10_5_1_test/test_bc_files/test_MPU_xTaskCallApplicationTaskHook.test.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.tskTaskControlBlock = type { i64*, %struct.xLIST_ITEM, %struct.xLIST_ITEM, i64, i64*, [12 x i8], i64, i64, i64, i64, i64 (i8*)*, [1 x i8*], i32, [1 x i32], [1 x i8], i8, i8 }
%struct.xLIST_ITEM = type { i64, %struct.xLIST_ITEM*, %struct.xLIST_ITEM*, i8*, %struct.xLIST* }
%struct.xLIST = type { i64, %struct.xLIST_ITEM*, %struct.xMINI_LIST_ITEM }
%struct.xMINI_LIST_ITEM = type { i64, %struct.xLIST_ITEM*, %struct.xLIST_ITEM* }
%struct.xMEMORY_REGION = type { i8*, i32, i32 }

@pxCurrentTCB = internal global %struct.tskTaskControlBlock* null, align 8, !dbg !0
@.str.5 = private unnamed_addr constant [55 x i8] c"/tmp/klee_src/test-rtos/freertos-10.5.1/Source/tasks.c\00", align 1
@uxCurrentNumberOfTasks = internal global i64 0, align 8, !dbg !146
@xSchedulerRunning = internal global i64 0, align 8, !dbg !148
@uxTaskNumber = internal global i64 0, align 8, !dbg !139
@pxReadyTasksLists = internal global [7 x %struct.xLIST] zeroinitializer, align 16, !dbg !119
@xDelayedTaskList1 = internal global %struct.xLIST zeroinitializer, align 8, !dbg !135
@xDelayedTaskList2 = internal global %struct.xLIST zeroinitializer, align 8, !dbg !137
@xPendingReadyList = internal global %struct.xLIST zeroinitializer, align 8, !dbg !129
@xTasksWaitingTermination = internal global %struct.xLIST zeroinitializer, align 8, !dbg !131
@xSuspendedTaskList = internal global %struct.xLIST zeroinitializer, align 8, !dbg !133
@pxDelayedTaskList = internal global %struct.xLIST* null, align 8, !dbg !124
@pxOverflowDelayedTaskList = internal global %struct.xLIST* null, align 8, !dbg !127
@.str.59 = private unnamed_addr constant [6 x i8] c"Task1\00", align 1
@.str.1.60 = private unnamed_addr constant [18 x i8] c"KLEE_kernel_xTask\00", align 1
@.str.2.61 = private unnamed_addr constant [17 x i8] c"KLEE_pvParameter\00", align 1
@.str.3 = private unnamed_addr constant [16 x i8] c"KLEE_return_val\00", align 1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #0

declare dso_local void @vAssertCalled(i8*, i64) #1

declare dso_local i8* @pvPortMalloc(i64) #1

; Function Attrs: argmemonly nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #2

declare dso_local void @vPortFree(i8*) #1

declare dso_local void @vPortEnterCritical() #1

declare dso_local void @vPortExitCritical() #1

declare dso_local void @vPortYield() #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @vListInitialise(%struct.xLIST* %pxList) #3 !dbg !472 {
entry:
  %pxList.addr = alloca %struct.xLIST*, align 8
  store %struct.xLIST* %pxList, %struct.xLIST** %pxList.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xLIST** %pxList.addr, metadata !479, metadata !DIExpression()), !dbg !480
  %0 = load %struct.xLIST*, %struct.xLIST** %pxList.addr, align 8, !dbg !481
  %xListEnd = getelementptr inbounds %struct.xLIST, %struct.xLIST* %0, i32 0, i32 2, !dbg !482
  %1 = bitcast %struct.xMINI_LIST_ITEM* %xListEnd to %struct.xLIST_ITEM*, !dbg !483
  %2 = load %struct.xLIST*, %struct.xLIST** %pxList.addr, align 8, !dbg !484
  %pxIndex = getelementptr inbounds %struct.xLIST, %struct.xLIST* %2, i32 0, i32 1, !dbg !485
  store %struct.xLIST_ITEM* %1, %struct.xLIST_ITEM** %pxIndex, align 8, !dbg !486
  %3 = load %struct.xLIST*, %struct.xLIST** %pxList.addr, align 8, !dbg !487
  %xListEnd1 = getelementptr inbounds %struct.xLIST, %struct.xLIST* %3, i32 0, i32 2, !dbg !488
  %xItemValue = getelementptr inbounds %struct.xMINI_LIST_ITEM, %struct.xMINI_LIST_ITEM* %xListEnd1, i32 0, i32 0, !dbg !489
  store i64 -1, i64* %xItemValue, align 8, !dbg !490
  %4 = load %struct.xLIST*, %struct.xLIST** %pxList.addr, align 8, !dbg !491
  %xListEnd2 = getelementptr inbounds %struct.xLIST, %struct.xLIST* %4, i32 0, i32 2, !dbg !492
  %5 = bitcast %struct.xMINI_LIST_ITEM* %xListEnd2 to %struct.xLIST_ITEM*, !dbg !493
  %6 = load %struct.xLIST*, %struct.xLIST** %pxList.addr, align 8, !dbg !494
  %xListEnd3 = getelementptr inbounds %struct.xLIST, %struct.xLIST* %6, i32 0, i32 2, !dbg !495
  %pxNext = getelementptr inbounds %struct.xMINI_LIST_ITEM, %struct.xMINI_LIST_ITEM* %xListEnd3, i32 0, i32 1, !dbg !496
  store %struct.xLIST_ITEM* %5, %struct.xLIST_ITEM** %pxNext, align 8, !dbg !497
  %7 = load %struct.xLIST*, %struct.xLIST** %pxList.addr, align 8, !dbg !498
  %xListEnd4 = getelementptr inbounds %struct.xLIST, %struct.xLIST* %7, i32 0, i32 2, !dbg !499
  %8 = bitcast %struct.xMINI_LIST_ITEM* %xListEnd4 to %struct.xLIST_ITEM*, !dbg !500
  %9 = load %struct.xLIST*, %struct.xLIST** %pxList.addr, align 8, !dbg !501
  %xListEnd5 = getelementptr inbounds %struct.xLIST, %struct.xLIST* %9, i32 0, i32 2, !dbg !502
  %pxPrevious = getelementptr inbounds %struct.xMINI_LIST_ITEM, %struct.xMINI_LIST_ITEM* %xListEnd5, i32 0, i32 2, !dbg !503
  store %struct.xLIST_ITEM* %8, %struct.xLIST_ITEM** %pxPrevious, align 8, !dbg !504
  %10 = load %struct.xLIST*, %struct.xLIST** %pxList.addr, align 8, !dbg !505
  %uxNumberOfItems = getelementptr inbounds %struct.xLIST, %struct.xLIST* %10, i32 0, i32 0, !dbg !506
  store volatile i64 0, i64* %uxNumberOfItems, align 8, !dbg !507
  ret void, !dbg !508
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @vListInitialiseItem(%struct.xLIST_ITEM* %pxItem) #3 !dbg !509 {
entry:
  %pxItem.addr = alloca %struct.xLIST_ITEM*, align 8
  store %struct.xLIST_ITEM* %pxItem, %struct.xLIST_ITEM** %pxItem.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xLIST_ITEM** %pxItem.addr, metadata !513, metadata !DIExpression()), !dbg !514
  %0 = load %struct.xLIST_ITEM*, %struct.xLIST_ITEM** %pxItem.addr, align 8, !dbg !515
  %pvContainer = getelementptr inbounds %struct.xLIST_ITEM, %struct.xLIST_ITEM* %0, i32 0, i32 4, !dbg !516
  store %struct.xLIST* null, %struct.xLIST** %pvContainer, align 8, !dbg !517
  ret void, !dbg !518
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @prvInitialiseNewTask(void (i8*)* %pxTaskCode, i8* %pcName, i32 %ulStackDepth, i8* %pvParameters, i64 %uxPriority, %struct.tskTaskControlBlock** %pxCreatedTask, %struct.tskTaskControlBlock* %pxNewTCB, %struct.xMEMORY_REGION* %xRegions) #3 !dbg !519 {
entry:
  %pxTaskCode.addr = alloca void (i8*)*, align 8
  %pcName.addr = alloca i8*, align 8
  %ulStackDepth.addr = alloca i32, align 4
  %pvParameters.addr = alloca i8*, align 8
  %uxPriority.addr = alloca i64, align 8
  %pxCreatedTask.addr = alloca %struct.tskTaskControlBlock**, align 8
  %pxNewTCB.addr = alloca %struct.tskTaskControlBlock*, align 8
  %xRegions.addr = alloca %struct.xMEMORY_REGION*, align 8
  %pxTopOfStack = alloca i64*, align 8
  %x = alloca i64, align 8
  store void (i8*)* %pxTaskCode, void (i8*)** %pxTaskCode.addr, align 8
  call void @llvm.dbg.declare(metadata void (i8*)** %pxTaskCode.addr, metadata !541, metadata !DIExpression()), !dbg !542
  store i8* %pcName, i8** %pcName.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pcName.addr, metadata !543, metadata !DIExpression()), !dbg !544
  store i32 %ulStackDepth, i32* %ulStackDepth.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %ulStackDepth.addr, metadata !545, metadata !DIExpression()), !dbg !546
  store i8* %pvParameters, i8** %pvParameters.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvParameters.addr, metadata !547, metadata !DIExpression()), !dbg !548
  store i64 %uxPriority, i64* %uxPriority.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxPriority.addr, metadata !549, metadata !DIExpression()), !dbg !550
  store %struct.tskTaskControlBlock** %pxCreatedTask, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock*** %pxCreatedTask.addr, metadata !551, metadata !DIExpression()), !dbg !552
  store %struct.tskTaskControlBlock* %pxNewTCB, %struct.tskTaskControlBlock** %pxNewTCB.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %pxNewTCB.addr, metadata !553, metadata !DIExpression()), !dbg !554
  store %struct.xMEMORY_REGION* %xRegions, %struct.xMEMORY_REGION** %xRegions.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.xMEMORY_REGION** %xRegions.addr, metadata !555, metadata !DIExpression()), !dbg !556
  call void @llvm.dbg.declare(metadata i64** %pxTopOfStack, metadata !557, metadata !DIExpression()), !dbg !558
  call void @llvm.dbg.declare(metadata i64* %x, metadata !559, metadata !DIExpression()), !dbg !560
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB.addr, align 8, !dbg !561
  %pxStack = getelementptr inbounds %struct.tskTaskControlBlock, %struct.tskTaskControlBlock* %0, i32 0, i32 4, !dbg !563
  %1 = load i64*, i64** %pxStack, align 8, !dbg !563
  %2 = bitcast i64* %1 to i8*, !dbg !564
  %3 = load i32, i32* %ulStackDepth.addr, align 4, !dbg !565
  %conv = zext i32 %3 to i64, !dbg !566
  %mul = mul i64 %conv, 8, !dbg !567
  %4 = call i8* @memset(i8* %2, i32 165, i64 %mul), !dbg !564
  %5 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB.addr, align 8, !dbg !568
  %pxStack1 = getelementptr inbounds %struct.tskTaskControlBlock, %struct.tskTaskControlBlock* %5, i32 0, i32 4, !dbg !570
  %6 = load i64*, i64** %pxStack1, align 8, !dbg !570
  %7 = load i32, i32* %ulStackDepth.addr, align 4, !dbg !571
  %sub = sub i32 %7, 1, !dbg !572
  %idxprom = zext i32 %sub to i64, !dbg !568
  %arrayidx = getelementptr inbounds i64, i64* %6, i64 %idxprom, !dbg !568
  store i64* %arrayidx, i64** %pxTopOfStack, align 8, !dbg !573
  %8 = load i64*, i64** %pxTopOfStack, align 8, !dbg !574
  %9 = ptrtoint i64* %8 to i64, !dbg !575
  %and = and i64 %9, -8, !dbg !576
  %10 = inttoptr i64 %and to i64*, !dbg !577
  store i64* %10, i64** %pxTopOfStack, align 8, !dbg !578
  %11 = load i64*, i64** %pxTopOfStack, align 8, !dbg !579
  %12 = ptrtoint i64* %11 to i64, !dbg !579
  %and2 = and i64 %12, 7, !dbg !579
  %cmp = icmp eq i64 %and2, 0, !dbg !579
  %conv3 = zext i1 %cmp to i32, !dbg !579
  %cmp4 = icmp eq i32 %conv3, 0, !dbg !579
  br i1 %cmp4, label %if.then, label %if.end, !dbg !581

if.then:                                          ; preds = %entry
  call void @vAssertCalled(i8* getelementptr inbounds ([55 x i8], [55 x i8]* @.str.5, i64 0, i64 0), i64 861), !dbg !579
  br label %if.end, !dbg !579

if.end:                                           ; preds = %if.then, %entry
  %13 = load i8*, i8** %pcName.addr, align 8, !dbg !582
  %cmp6 = icmp ne i8* %13, null, !dbg !584
  br i1 %cmp6, label %if.then8, label %if.else, !dbg !585

if.then8:                                         ; preds = %if.end
  br label %if.end9, !dbg !586

if.else:                                          ; preds = %if.end
  br label %if.end9

if.end9:                                          ; preds = %if.else, %if.then8
  %14 = load i64, i64* %uxPriority.addr, align 8, !dbg !588
  %cmp10 = icmp ult i64 %14, 7, !dbg !588
  %conv11 = zext i1 %cmp10 to i32, !dbg !588
  %cmp12 = icmp eq i32 %conv11, 0, !dbg !588
  br i1 %cmp12, label %if.then14, label %if.end15, !dbg !590

if.then14:                                        ; preds = %if.end9
  call void @vAssertCalled(i8* getelementptr inbounds ([55 x i8], [55 x i8]* @.str.5, i64 0, i64 0), i64 914), !dbg !588
  br label %if.end15, !dbg !588

if.end15:                                         ; preds = %if.then14, %if.end9
  %15 = load i64, i64* %uxPriority.addr, align 8, !dbg !591
  %cmp16 = icmp uge i64 %15, 7, !dbg !593
  br i1 %cmp16, label %if.then18, label %if.else19, !dbg !594

if.then18:                                        ; preds = %if.end15
  store i64 6, i64* %uxPriority.addr, align 8, !dbg !595
  br label %if.end20, !dbg !597

if.else19:                                        ; preds = %if.end15
  br label %if.end20

if.end20:                                         ; preds = %if.else19, %if.then18
  %16 = load i64, i64* %uxPriority.addr, align 8, !dbg !598
  %17 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB.addr, align 8, !dbg !599
  %uxPriority21 = getelementptr inbounds %struct.tskTaskControlBlock, %struct.tskTaskControlBlock* %17, i32 0, i32 3, !dbg !600
  store i64 %16, i64* %uxPriority21, align 8, !dbg !601
  %18 = load i64, i64* %uxPriority.addr, align 8, !dbg !602
  %19 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB.addr, align 8, !dbg !604
  %uxBasePriority = getelementptr inbounds %struct.tskTaskControlBlock, %struct.tskTaskControlBlock* %19, i32 0, i32 8, !dbg !605
  store i64 %18, i64* %uxBasePriority, align 8, !dbg !606
  %20 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB.addr, align 8, !dbg !607
  %xStateListItem = getelementptr inbounds %struct.tskTaskControlBlock, %struct.tskTaskControlBlock* %20, i32 0, i32 1, !dbg !608
  call void @vListInitialiseItem(%struct.xLIST_ITEM* %xStateListItem), !dbg !609
  %21 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB.addr, align 8, !dbg !610
  %xEventListItem = getelementptr inbounds %struct.tskTaskControlBlock, %struct.tskTaskControlBlock* %21, i32 0, i32 2, !dbg !611
  call void @vListInitialiseItem(%struct.xLIST_ITEM* %xEventListItem), !dbg !612
  %22 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB.addr, align 8, !dbg !613
  %23 = bitcast %struct.tskTaskControlBlock* %22 to i8*, !dbg !613
  %24 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB.addr, align 8, !dbg !613
  %xStateListItem22 = getelementptr inbounds %struct.tskTaskControlBlock, %struct.tskTaskControlBlock* %24, i32 0, i32 1, !dbg !613
  %pvOwner = getelementptr inbounds %struct.xLIST_ITEM, %struct.xLIST_ITEM* %xStateListItem22, i32 0, i32 3, !dbg !613
  store i8* %23, i8** %pvOwner, align 8, !dbg !613
  %25 = load i64, i64* %uxPriority.addr, align 8, !dbg !614
  %sub23 = sub i64 7, %25, !dbg !614
  %26 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB.addr, align 8, !dbg !614
  %xEventListItem24 = getelementptr inbounds %struct.tskTaskControlBlock, %struct.tskTaskControlBlock* %26, i32 0, i32 2, !dbg !614
  %xItemValue = getelementptr inbounds %struct.xLIST_ITEM, %struct.xLIST_ITEM* %xEventListItem24, i32 0, i32 0, !dbg !614
  store i64 %sub23, i64* %xItemValue, align 8, !dbg !614
  %27 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB.addr, align 8, !dbg !615
  %28 = bitcast %struct.tskTaskControlBlock* %27 to i8*, !dbg !615
  %29 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB.addr, align 8, !dbg !615
  %xEventListItem25 = getelementptr inbounds %struct.tskTaskControlBlock, %struct.tskTaskControlBlock* %29, i32 0, i32 2, !dbg !615
  %pvOwner26 = getelementptr inbounds %struct.xLIST_ITEM, %struct.xLIST_ITEM* %xEventListItem25, i32 0, i32 3, !dbg !615
  store i8* %28, i8** %pvOwner26, align 8, !dbg !615
  %30 = load %struct.xMEMORY_REGION*, %struct.xMEMORY_REGION** %xRegions.addr, align 8, !dbg !616
  %31 = load %struct.tskTaskControlBlock**, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8, !dbg !618
  %cmp27 = icmp ne %struct.tskTaskControlBlock** %31, null, !dbg !620
  br i1 %cmp27, label %if.then29, label %if.else30, !dbg !621

if.then29:                                        ; preds = %if.end20
  %32 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB.addr, align 8, !dbg !622
  %33 = load %struct.tskTaskControlBlock**, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8, !dbg !624
  store %struct.tskTaskControlBlock* %32, %struct.tskTaskControlBlock** %33, align 8, !dbg !625
  br label %if.end31, !dbg !626

if.else30:                                        ; preds = %if.end20
  br label %if.end31

if.end31:                                         ; preds = %if.else30, %if.then29
  ret void, !dbg !627
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @prvAddNewTaskToReadyList(%struct.tskTaskControlBlock* %pxNewTCB) #3 !dbg !628 {
entry:
  %pxNewTCB.addr = alloca %struct.tskTaskControlBlock*, align 8
  store %struct.tskTaskControlBlock* %pxNewTCB, %struct.tskTaskControlBlock** %pxNewTCB.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %pxNewTCB.addr, metadata !631, metadata !DIExpression()), !dbg !632
  call void @vPortEnterCritical(), !dbg !633
  %0 = load volatile i64, i64* @uxCurrentNumberOfTasks, align 8, !dbg !634
  %inc = add i64 %0, 1, !dbg !634
  store volatile i64 %inc, i64* @uxCurrentNumberOfTasks, align 8, !dbg !634
  %1 = load volatile %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** @pxCurrentTCB, align 8, !dbg !636
  %cmp = icmp eq %struct.tskTaskControlBlock* %1, null, !dbg !638
  br i1 %cmp, label %if.then, label %if.else3, !dbg !639

if.then:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB.addr, align 8, !dbg !640
  store volatile %struct.tskTaskControlBlock* %2, %struct.tskTaskControlBlock** @pxCurrentTCB, align 8, !dbg !642
  %3 = load volatile i64, i64* @uxCurrentNumberOfTasks, align 8, !dbg !643
  %cmp1 = icmp eq i64 %3, 1, !dbg !645
  br i1 %cmp1, label %if.then2, label %if.else, !dbg !646

if.then2:                                         ; preds = %if.then
  call void @prvInitialiseTaskLists(), !dbg !647
  br label %if.end, !dbg !649

if.else:                                          ; preds = %if.then
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then2
  br label %if.end13, !dbg !650

if.else3:                                         ; preds = %entry
  %4 = load volatile i64, i64* @xSchedulerRunning, align 8, !dbg !651
  %cmp4 = icmp eq i64 %4, 0, !dbg !654
  br i1 %cmp4, label %if.then5, label %if.else11, !dbg !655

if.then5:                                         ; preds = %if.else3
  %5 = load volatile %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** @pxCurrentTCB, align 8, !dbg !656
  %uxPriority = getelementptr inbounds %struct.tskTaskControlBlock, %struct.tskTaskControlBlock* %5, i32 0, i32 3, !dbg !659
  %6 = load i64, i64* %uxPriority, align 8, !dbg !659
  %7 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB.addr, align 8, !dbg !660
  %uxPriority6 = getelementptr inbounds %struct.tskTaskControlBlock, %struct.tskTaskControlBlock* %7, i32 0, i32 3, !dbg !661
  %8 = load i64, i64* %uxPriority6, align 8, !dbg !661
  %cmp7 = icmp ule i64 %6, %8, !dbg !662
  br i1 %cmp7, label %if.then8, label %if.else9, !dbg !663

if.then8:                                         ; preds = %if.then5
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB.addr, align 8, !dbg !664
  store volatile %struct.tskTaskControlBlock* %9, %struct.tskTaskControlBlock** @pxCurrentTCB, align 8, !dbg !666
  br label %if.end10, !dbg !667

if.else9:                                         ; preds = %if.then5
  br label %if.end10

if.end10:                                         ; preds = %if.else9, %if.then8
  br label %if.end12, !dbg !668

if.else11:                                        ; preds = %if.else3
  br label %if.end12

if.end12:                                         ; preds = %if.else11, %if.end10
  br label %if.end13

if.end13:                                         ; preds = %if.end12, %if.end
  %10 = load i64, i64* @uxTaskNumber, align 8, !dbg !669
  %inc14 = add i64 %10, 1, !dbg !669
  store i64 %inc14, i64* @uxTaskNumber, align 8, !dbg !669
  %11 = load i64, i64* @uxTaskNumber, align 8, !dbg !670
  %12 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB.addr, align 8, !dbg !672
  %uxTCBNumber = getelementptr inbounds %struct.tskTaskControlBlock, %struct.tskTaskControlBlock* %12, i32 0, i32 6, !dbg !673
  store i64 %11, i64* %uxTCBNumber, align 8, !dbg !674
  %13 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB.addr, align 8, !dbg !675
  call void @vPortExitCritical(), !dbg !676
  %14 = load volatile i64, i64* @xSchedulerRunning, align 8, !dbg !677
  %cmp15 = icmp ne i64 %14, 0, !dbg !679
  br i1 %cmp15, label %if.then16, label %if.else23, !dbg !680

if.then16:                                        ; preds = %if.end13
  %15 = load volatile %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** @pxCurrentTCB, align 8, !dbg !681
  %uxPriority17 = getelementptr inbounds %struct.tskTaskControlBlock, %struct.tskTaskControlBlock* %15, i32 0, i32 3, !dbg !684
  %16 = load i64, i64* %uxPriority17, align 8, !dbg !684
  %17 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB.addr, align 8, !dbg !685
  %uxPriority18 = getelementptr inbounds %struct.tskTaskControlBlock, %struct.tskTaskControlBlock* %17, i32 0, i32 3, !dbg !686
  %18 = load i64, i64* %uxPriority18, align 8, !dbg !686
  %cmp19 = icmp ult i64 %16, %18, !dbg !687
  br i1 %cmp19, label %if.then20, label %if.else21, !dbg !688

if.then20:                                        ; preds = %if.then16
  call void @vPortYield(), !dbg !689
  br label %if.end22, !dbg !691

if.else21:                                        ; preds = %if.then16
  br label %if.end22

if.end22:                                         ; preds = %if.else21, %if.then20
  br label %if.end24, !dbg !692

if.else23:                                        ; preds = %if.end13
  br label %if.end24

if.end24:                                         ; preds = %if.else23, %if.end22
  ret void, !dbg !693
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @prvInitialiseTaskLists() #3 !dbg !694 {
entry:
  %uxPriority = alloca i64, align 8
  call void @llvm.dbg.declare(metadata i64* %uxPriority, metadata !695, metadata !DIExpression()), !dbg !696
  store i64 0, i64* %uxPriority, align 8, !dbg !697
  br label %for.cond, !dbg !699

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i64, i64* %uxPriority, align 8, !dbg !700
  %cmp = icmp ult i64 %0, 7, !dbg !702
  br i1 %cmp, label %for.body, label %for.end, !dbg !703

for.body:                                         ; preds = %for.cond
  %1 = load i64, i64* %uxPriority, align 8, !dbg !704
  %arrayidx = getelementptr inbounds [7 x %struct.xLIST], [7 x %struct.xLIST]* @pxReadyTasksLists, i64 0, i64 %1, !dbg !706
  call void @vListInitialise(%struct.xLIST* %arrayidx), !dbg !707
  br label %for.inc, !dbg !708

for.inc:                                          ; preds = %for.body
  %2 = load i64, i64* %uxPriority, align 8, !dbg !709
  %inc = add i64 %2, 1, !dbg !709
  store i64 %inc, i64* %uxPriority, align 8, !dbg !709
  br label %for.cond, !dbg !710, !llvm.loop !711

for.end:                                          ; preds = %for.cond
  call void @vListInitialise(%struct.xLIST* @xDelayedTaskList1), !dbg !713
  call void @vListInitialise(%struct.xLIST* @xDelayedTaskList2), !dbg !714
  call void @vListInitialise(%struct.xLIST* @xPendingReadyList), !dbg !715
  call void @vListInitialise(%struct.xLIST* @xTasksWaitingTermination), !dbg !716
  call void @vListInitialise(%struct.xLIST* @xSuspendedTaskList), !dbg !718
  store volatile %struct.xLIST* @xDelayedTaskList1, %struct.xLIST** @pxDelayedTaskList, align 8, !dbg !720
  store volatile %struct.xLIST* @xDelayedTaskList2, %struct.xLIST** @pxOverflowDelayedTaskList, align 8, !dbg !721
  ret void, !dbg !722
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i64 @xTaskCreate(void (i8*)* %pxTaskCode, i8* %pcName, i32 %usStackDepth, i8* %pvParameters, i64 %uxPriority, %struct.tskTaskControlBlock** %pxCreatedTask) #3 !dbg !723 {
entry:
  %pxTaskCode.addr = alloca void (i8*)*, align 8
  %pcName.addr = alloca i8*, align 8
  %usStackDepth.addr = alloca i32, align 4
  %pvParameters.addr = alloca i8*, align 8
  %uxPriority.addr = alloca i64, align 8
  %pxCreatedTask.addr = alloca %struct.tskTaskControlBlock**, align 8
  %pxNewTCB = alloca %struct.tskTaskControlBlock*, align 8
  %xReturn = alloca i64, align 8
  %pxStack = alloca i64*, align 8
  store void (i8*)* %pxTaskCode, void (i8*)** %pxTaskCode.addr, align 8
  call void @llvm.dbg.declare(metadata void (i8*)** %pxTaskCode.addr, metadata !726, metadata !DIExpression()), !dbg !727
  store i8* %pcName, i8** %pcName.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pcName.addr, metadata !728, metadata !DIExpression()), !dbg !729
  store i32 %usStackDepth, i32* %usStackDepth.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %usStackDepth.addr, metadata !730, metadata !DIExpression()), !dbg !731
  store i8* %pvParameters, i8** %pvParameters.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvParameters.addr, metadata !732, metadata !DIExpression()), !dbg !733
  store i64 %uxPriority, i64* %uxPriority.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %uxPriority.addr, metadata !734, metadata !DIExpression()), !dbg !735
  store %struct.tskTaskControlBlock** %pxCreatedTask, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock*** %pxCreatedTask.addr, metadata !736, metadata !DIExpression()), !dbg !737
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %pxNewTCB, metadata !738, metadata !DIExpression()), !dbg !739
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !740, metadata !DIExpression()), !dbg !741
  call void @llvm.dbg.declare(metadata i64** %pxStack, metadata !742, metadata !DIExpression()), !dbg !744
  %0 = load i32, i32* %usStackDepth.addr, align 4, !dbg !745
  %conv = zext i32 %0 to i64, !dbg !746
  %mul = mul i64 %conv, 8, !dbg !747
  %call = call i8* @pvPortMalloc(i64 %mul), !dbg !748
  %1 = bitcast i8* %call to i64*, !dbg !748
  store i64* %1, i64** %pxStack, align 8, !dbg !749
  %2 = load i64*, i64** %pxStack, align 8, !dbg !750
  %cmp = icmp ne i64* %2, null, !dbg !752
  br i1 %cmp, label %if.then, label %if.else7, !dbg !753

if.then:                                          ; preds = %entry
  %call2 = call i8* @pvPortMalloc(i64 184), !dbg !754
  %3 = bitcast i8* %call2 to %struct.tskTaskControlBlock*, !dbg !756
  store %struct.tskTaskControlBlock* %3, %struct.tskTaskControlBlock** %pxNewTCB, align 8, !dbg !757
  %4 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB, align 8, !dbg !758
  %cmp3 = icmp ne %struct.tskTaskControlBlock* %4, null, !dbg !760
  br i1 %cmp3, label %if.then5, label %if.else, !dbg !761

if.then5:                                         ; preds = %if.then
  %5 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB, align 8, !dbg !762
  %6 = bitcast %struct.tskTaskControlBlock* %5 to i8*, !dbg !764
  %7 = call i8* @memset(i8* %6, i32 0, i64 184), !dbg !764
  %8 = load i64*, i64** %pxStack, align 8, !dbg !765
  %9 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB, align 8, !dbg !766
  %pxStack6 = getelementptr inbounds %struct.tskTaskControlBlock, %struct.tskTaskControlBlock* %9, i32 0, i32 4, !dbg !767
  store i64* %8, i64** %pxStack6, align 8, !dbg !768
  br label %if.end, !dbg !769

if.else:                                          ; preds = %if.then
  %10 = load i64*, i64** %pxStack, align 8, !dbg !770
  %11 = bitcast i64* %10 to i8*, !dbg !770
  call void @vPortFree(i8* %11), !dbg !772
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then5
  br label %if.end8, !dbg !773

if.else7:                                         ; preds = %entry
  store %struct.tskTaskControlBlock* null, %struct.tskTaskControlBlock** %pxNewTCB, align 8, !dbg !774
  br label %if.end8

if.end8:                                          ; preds = %if.else7, %if.end
  %12 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB, align 8, !dbg !776
  %cmp9 = icmp ne %struct.tskTaskControlBlock* %12, null, !dbg !778
  br i1 %cmp9, label %if.then11, label %if.else12, !dbg !779

if.then11:                                        ; preds = %if.end8
  %13 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB, align 8, !dbg !780
  %ucStaticallyAllocated = getelementptr inbounds %struct.tskTaskControlBlock, %struct.tskTaskControlBlock* %13, i32 0, i32 15, !dbg !783
  store i8 0, i8* %ucStaticallyAllocated, align 1, !dbg !784
  %14 = load void (i8*)*, void (i8*)** %pxTaskCode.addr, align 8, !dbg !785
  %15 = load i8*, i8** %pcName.addr, align 8, !dbg !786
  %16 = load i32, i32* %usStackDepth.addr, align 4, !dbg !787
  %17 = load i8*, i8** %pvParameters.addr, align 8, !dbg !788
  %18 = load i64, i64* %uxPriority.addr, align 8, !dbg !789
  %19 = load %struct.tskTaskControlBlock**, %struct.tskTaskControlBlock*** %pxCreatedTask.addr, align 8, !dbg !790
  %20 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB, align 8, !dbg !791
  call void @prvInitialiseNewTask(void (i8*)* %14, i8* %15, i32 %16, i8* %17, i64 %18, %struct.tskTaskControlBlock** %19, %struct.tskTaskControlBlock* %20, %struct.xMEMORY_REGION* null), !dbg !792
  %21 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %pxNewTCB, align 8, !dbg !793
  call void @prvAddNewTaskToReadyList(%struct.tskTaskControlBlock* %21), !dbg !794
  store i64 1, i64* %xReturn, align 8, !dbg !795
  br label %if.end13, !dbg !796

if.else12:                                        ; preds = %if.end8
  store i64 -1, i64* %xReturn, align 8, !dbg !797
  br label %if.end13

if.end13:                                         ; preds = %if.else12, %if.then11
  %22 = load i64, i64* %xReturn, align 8, !dbg !799
  ret i64 %22, !dbg !800
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i64 @xTaskCallApplicationTaskHook(%struct.tskTaskControlBlock* %xTask, i8* %pvParameter) #3 !dbg !801 {
entry:
  %xTask.addr = alloca %struct.tskTaskControlBlock*, align 8
  %pvParameter.addr = alloca i8*, align 8
  %xTCB = alloca %struct.tskTaskControlBlock*, align 8
  %xReturn = alloca i64, align 8
  store %struct.tskTaskControlBlock* %xTask, %struct.tskTaskControlBlock** %xTask.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTask.addr, metadata !804, metadata !DIExpression()), !dbg !805
  store i8* %pvParameter, i8** %pvParameter.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvParameter.addr, metadata !806, metadata !DIExpression()), !dbg !807
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTCB, metadata !808, metadata !DIExpression()), !dbg !809
  call void @llvm.dbg.declare(metadata i64* %xReturn, metadata !810, metadata !DIExpression()), !dbg !811
  %0 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !812
  %cmp = icmp eq %struct.tskTaskControlBlock* %0, null, !dbg !814
  br i1 %cmp, label %if.then, label %if.else, !dbg !815

if.then:                                          ; preds = %entry
  %1 = load volatile %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** @pxCurrentTCB, align 8, !dbg !816
  store %struct.tskTaskControlBlock* %1, %struct.tskTaskControlBlock** %xTCB, align 8, !dbg !818
  br label %if.end, !dbg !819

if.else:                                          ; preds = %entry
  %2 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTask.addr, align 8, !dbg !820
  store %struct.tskTaskControlBlock* %2, %struct.tskTaskControlBlock** %xTCB, align 8, !dbg !822
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %3 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTCB, align 8, !dbg !823
  %pxTaskTag = getelementptr inbounds %struct.tskTaskControlBlock, %struct.tskTaskControlBlock* %3, i32 0, i32 10, !dbg !825
  %4 = load i64 (i8*)*, i64 (i8*)** %pxTaskTag, align 8, !dbg !825
  %cmp1 = icmp ne i64 (i8*)* %4, null, !dbg !826
  br i1 %cmp1, label %if.then2, label %if.else4, !dbg !827

if.then2:                                         ; preds = %if.end
  %5 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTCB, align 8, !dbg !828
  %pxTaskTag3 = getelementptr inbounds %struct.tskTaskControlBlock, %struct.tskTaskControlBlock* %5, i32 0, i32 10, !dbg !830
  %6 = load i64 (i8*)*, i64 (i8*)** %pxTaskTag3, align 8, !dbg !830
  %7 = load i8*, i8** %pvParameter.addr, align 8, !dbg !831
  %call = call i64 %6(i8* %7), !dbg !828
  store i64 %call, i64* %xReturn, align 8, !dbg !832
  br label %if.end5, !dbg !833

if.else4:                                         ; preds = %if.end
  store i64 0, i64* %xReturn, align 8, !dbg !834
  br label %if.end5

if.end5:                                          ; preds = %if.else4, %if.then2
  %8 = load i64, i64* %xReturn, align 8, !dbg !836
  ret i64 %8, !dbg !837
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @assert(i32 %condition) #3 !dbg !838 {
entry:
  %condition.addr = alloca i32, align 4
  store i32 %condition, i32* %condition.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %condition.addr, metadata !842, metadata !DIExpression()), !dbg !843
  ret void, !dbg !844
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @vTaskFunction1() #3 !dbg !845 {
entry:
  call void @assert(i32 0), !dbg !846
  ret void, !dbg !847
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #3 !dbg !848 {
entry:
  %retval = alloca i32, align 4
  %initial_xTask = alloca %struct.tskTaskControlBlock*, align 8
  %KLEE_xTask = alloca %struct.tskTaskControlBlock*, align 8
  %KLEE_pvParameter = alloca i8*, align 8
  %KLEE_return_val = alloca i64, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %initial_xTask, metadata !851, metadata !DIExpression()), !dbg !852
  %call = call i64 @xTaskCreate(void (i8*)* bitcast (void ()* @vTaskFunction1 to void (i8*)*), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.59, i64 0, i64 0), i32 1000, i8* null, i64 1, %struct.tskTaskControlBlock** %initial_xTask), !dbg !853
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %KLEE_xTask, metadata !854, metadata !DIExpression()), !dbg !855
  %0 = bitcast %struct.tskTaskControlBlock** %KLEE_xTask to i8*, !dbg !856
  call void @klee_make_symbolic_controllable(i8* %0, i64 8, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.1.60, i64 0, i64 0), i1 zeroext true), !dbg !857
  call void @llvm.dbg.declare(metadata i8** %KLEE_pvParameter, metadata !858, metadata !DIExpression()), !dbg !859
  %1 = bitcast i8** %KLEE_pvParameter to i8*, !dbg !860
  call void @klee_make_symbolic_controllable(i8* %1, i64 8, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.2.61, i64 0, i64 0), i1 zeroext true), !dbg !861
  call void @llvm.dbg.declare(metadata i64* %KLEE_return_val, metadata !862, metadata !DIExpression()), !dbg !863
  %2 = bitcast i64* %KLEE_return_val to i8*, !dbg !864
  call void @klee_make_symbolic_controllable(i8* %2, i64 8, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.3, i64 0, i64 0), i1 zeroext true), !dbg !865
  %3 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %KLEE_xTask, align 8, !dbg !866
  %4 = load i8*, i8** %KLEE_pvParameter, align 8, !dbg !867
  %call1 = call i64 @xTaskCallApplicationTaskHook(%struct.tskTaskControlBlock* %3, i8* %4), !dbg !868
  store i64 %call1, i64* %KLEE_return_val, align 8, !dbg !869
  ret i32 0, !dbg !870
}

declare dso_local void @klee_make_symbolic_controllable(i8*, i64, i8*, i1 zeroext) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i8* @memset(i8* %dst, i32 %s, i64 %count) #4 !dbg !871 {
entry:
  %dst.addr = alloca i8*, align 8
  %s.addr = alloca i32, align 4
  %count.addr = alloca i64, align 8
  %a = alloca i8*, align 8
  store i8* %dst, i8** %dst.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %dst.addr, metadata !877, metadata !DIExpression()), !dbg !878
  store i32 %s, i32* %s.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %s.addr, metadata !879, metadata !DIExpression()), !dbg !880
  store i64 %count, i64* %count.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %count.addr, metadata !881, metadata !DIExpression()), !dbg !882
  call void @llvm.dbg.declare(metadata i8** %a, metadata !883, metadata !DIExpression()), !dbg !885
  %0 = load i8*, i8** %dst.addr, align 8, !dbg !886
  store i8* %0, i8** %a, align 8, !dbg !885
  %1 = load i64, i64* %count.addr, align 8, !dbg !887
  %dec = add i64 %1, -1, !dbg !887
  store i64 %dec, i64* %count.addr, align 8, !dbg !887
  %cmp = icmp ugt i64 %1, 0, !dbg !889
  br i1 %cmp, label %if.then, label %if.end, !dbg !890

if.then:                                          ; preds = %entry
  %2 = load i32, i32* %s.addr, align 4, !dbg !891
  %conv = trunc i32 %2 to i8, !dbg !891
  %3 = load i8*, i8** %a, align 8, !dbg !892
  %incdec.ptr = getelementptr inbounds i8, i8* %3, i32 1, !dbg !892
  store i8* %incdec.ptr, i8** %a, align 8, !dbg !892
  store i8 %conv, i8* %3, align 1, !dbg !893
  br label %if.end, !dbg !894

if.end:                                           ; preds = %if.then, %entry
  %4 = load i8*, i8** %dst.addr, align 8, !dbg !895
  ret i8* %4, !dbg !896
}

attributes #0 = { nounwind readnone speculatable willreturn }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind willreturn writeonly }
attributes #3 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!168, !198, !280, !282, !307, !2, !346, !463, !466}
!llvm.ident = !{!468, !468, !468, !468, !468, !468, !468, !468, !468}
!llvm.module.flags = !{!469, !470, !471}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "pxCurrentTCB", scope: !2, file: !26, line: 329, type: !167, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 11.0.0 (https://github.com/llvm/llvm-project.git 60a25202a7dd1e00067fcfce512086ebf3788537)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !22, globals: !115, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "/tmp/klee_src/test-rtos/freertos-10.5.1/Source/tasks.c", directory: "/tmp/klee_src/freertos_10_5_1_test")
!4 = !{!5, !15}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !6, line: 96, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "test-rtos/freertos-10.5.1/Source/include/task.h", directory: "/tmp/klee_src")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13, !14}
!9 = !DIEnumerator(name: "eRunning", value: 0, isUnsigned: true)
!10 = !DIEnumerator(name: "eReady", value: 1, isUnsigned: true)
!11 = !DIEnumerator(name: "eBlocked", value: 2, isUnsigned: true)
!12 = !DIEnumerator(name: "eSuspended", value: 3, isUnsigned: true)
!13 = !DIEnumerator(name: "eDeleted", value: 4, isUnsigned: true)
!14 = !DIEnumerator(name: "eInvalid", value: 5, isUnsigned: true)
!15 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !6, line: 107, baseType: !7, size: 32, elements: !16)
!16 = !{!17, !18, !19, !20, !21}
!17 = !DIEnumerator(name: "eNoAction", value: 0, isUnsigned: true)
!18 = !DIEnumerator(name: "eSetBits", value: 1, isUnsigned: true)
!19 = !DIEnumerator(name: "eIncrement", value: 2, isUnsigned: true)
!20 = !DIEnumerator(name: "eSetValueWithOverwrite", value: 3, isUnsigned: true)
!21 = !DIEnumerator(name: "eSetValueWithoutOverwrite", value: 4, isUnsigned: true)
!22 = !{!23, !24, !66, !98, !103, !88, !81, !53, !42, !105, !107, !109, !111, !112, !113, !69}
!23 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!24 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!25 = !DIDerivedType(tag: DW_TAG_typedef, name: "TCB_t", file: !26, line: 325, baseType: !27)
!26 = !DIFile(filename: "test-rtos/freertos-10.5.1/Source/tasks.c", directory: "/tmp/klee_src")
!27 = !DIDerivedType(tag: DW_TAG_typedef, name: "tskTCB", file: !26, line: 321, baseType: !28)
!28 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tskTaskControlBlock", file: !26, line: 255, size: 1472, elements: !29)
!29 = !{!30, !36, !63, !64, !65, !67, !72, !73, !74, !75, !76, !83, !87, !92, !95, !101, !102}
!30 = !DIDerivedType(tag: DW_TAG_member, name: "pxTopOfStack", scope: !28, file: !26, line: 257, baseType: !31, size: 64)
!31 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !32, size: 64)
!32 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !33)
!33 = !DIDerivedType(tag: DW_TAG_typedef, name: "StackType_t", file: !34, line: 59, baseType: !35)
!34 = !DIFile(filename: "test-rtos/freertos-10.5.1/Source/portable/ThirdParty/GCC/Posix/portmacro.h", directory: "/tmp/klee_src")
!35 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "xStateListItem", scope: !28, file: !26, line: 263, baseType: !37, size: 320, offset: 64)
!37 = !DIDerivedType(tag: DW_TAG_typedef, name: "ListItem_t", file: !38, line: 154, baseType: !39)
!38 = !DIFile(filename: "test-rtos/freertos-10.5.1/Source/include/list.h", directory: "/tmp/klee_src")
!39 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xLIST_ITEM", file: !38, line: 144, size: 320, elements: !40)
!40 = !{!41, !43, !45, !46, !47}
!41 = !DIDerivedType(tag: DW_TAG_member, name: "xItemValue", scope: !39, file: !38, line: 147, baseType: !42, size: 64)
!42 = !DIDerivedType(tag: DW_TAG_typedef, name: "TickType_t", file: !34, line: 63, baseType: !35)
!43 = !DIDerivedType(tag: DW_TAG_member, name: "pxNext", scope: !39, file: !38, line: 148, baseType: !44, size: 64, offset: 64)
!44 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !39, size: 64)
!45 = !DIDerivedType(tag: DW_TAG_member, name: "pxPrevious", scope: !39, file: !38, line: 149, baseType: !44, size: 64, offset: 128)
!46 = !DIDerivedType(tag: DW_TAG_member, name: "pvOwner", scope: !39, file: !38, line: 150, baseType: !23, size: 64, offset: 192)
!47 = !DIDerivedType(tag: DW_TAG_member, name: "pvContainer", scope: !39, file: !38, line: 151, baseType: !48, size: 64, offset: 256)
!48 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !49, size: 64)
!49 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xLIST", file: !38, line: 172, size: 320, elements: !50)
!50 = !{!51, !54, !56}
!51 = !DIDerivedType(tag: DW_TAG_member, name: "uxNumberOfItems", scope: !49, file: !38, line: 175, baseType: !52, size: 64)
!52 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !53)
!53 = !DIDerivedType(tag: DW_TAG_typedef, name: "UBaseType_t", file: !34, line: 61, baseType: !35)
!54 = !DIDerivedType(tag: DW_TAG_member, name: "pxIndex", scope: !49, file: !38, line: 176, baseType: !55, size: 64, offset: 64)
!55 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !37, size: 64)
!56 = !DIDerivedType(tag: DW_TAG_member, name: "xListEnd", scope: !49, file: !38, line: 177, baseType: !57, size: 192, offset: 128)
!57 = !DIDerivedType(tag: DW_TAG_typedef, name: "MiniListItem_t", file: !38, line: 164, baseType: !58)
!58 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xMINI_LIST_ITEM", file: !38, line: 157, size: 192, elements: !59)
!59 = !{!60, !61, !62}
!60 = !DIDerivedType(tag: DW_TAG_member, name: "xItemValue", scope: !58, file: !38, line: 160, baseType: !42, size: 64)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "pxNext", scope: !58, file: !38, line: 161, baseType: !44, size: 64, offset: 64)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "pxPrevious", scope: !58, file: !38, line: 162, baseType: !44, size: 64, offset: 128)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "xEventListItem", scope: !28, file: !26, line: 264, baseType: !37, size: 320, offset: 384)
!64 = !DIDerivedType(tag: DW_TAG_member, name: "uxPriority", scope: !28, file: !26, line: 265, baseType: !53, size: 64, offset: 704)
!65 = !DIDerivedType(tag: DW_TAG_member, name: "pxStack", scope: !28, file: !26, line: 266, baseType: !66, size: 64, offset: 768)
!66 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!67 = !DIDerivedType(tag: DW_TAG_member, name: "pcTaskName", scope: !28, file: !26, line: 267, baseType: !68, size: 96, offset: 832)
!68 = !DICompositeType(tag: DW_TAG_array_type, baseType: !69, size: 96, elements: !70)
!69 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!70 = !{!71}
!71 = !DISubrange(count: 12)
!72 = !DIDerivedType(tag: DW_TAG_member, name: "uxTCBNumber", scope: !28, file: !26, line: 278, baseType: !53, size: 64, offset: 960)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "uxTaskNumber", scope: !28, file: !26, line: 279, baseType: !53, size: 64, offset: 1024)
!74 = !DIDerivedType(tag: DW_TAG_member, name: "uxBasePriority", scope: !28, file: !26, line: 283, baseType: !53, size: 64, offset: 1088)
!75 = !DIDerivedType(tag: DW_TAG_member, name: "uxMutexesHeld", scope: !28, file: !26, line: 284, baseType: !53, size: 64, offset: 1152)
!76 = !DIDerivedType(tag: DW_TAG_member, name: "pxTaskTag", scope: !28, file: !26, line: 288, baseType: !77, size: 64, offset: 1216)
!77 = !DIDerivedType(tag: DW_TAG_typedef, name: "TaskHookFunction_t", file: !6, line: 93, baseType: !78)
!78 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !79, size: 64)
!79 = !DISubroutineType(types: !80)
!80 = !{!81, !23}
!81 = !DIDerivedType(tag: DW_TAG_typedef, name: "BaseType_t", file: !34, line: 60, baseType: !82)
!82 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!83 = !DIDerivedType(tag: DW_TAG_member, name: "pvThreadLocalStoragePointers", scope: !28, file: !26, line: 292, baseType: !84, size: 64, offset: 1280)
!84 = !DICompositeType(tag: DW_TAG_array_type, baseType: !23, size: 64, elements: !85)
!85 = !{!86}
!86 = !DISubrange(count: 1)
!87 = !DIDerivedType(tag: DW_TAG_member, name: "ulRunTimeCounter", scope: !28, file: !26, line: 296, baseType: !88, size: 32, offset: 1344)
!88 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !89, line: 26, baseType: !90)
!89 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h", directory: "")
!90 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !91, line: 41, baseType: !7)
!91 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "")
!92 = !DIDerivedType(tag: DW_TAG_member, name: "ulNotifiedValue", scope: !28, file: !26, line: 304, baseType: !93, size: 32, offset: 1376)
!93 = !DICompositeType(tag: DW_TAG_array_type, baseType: !94, size: 32, elements: !85)
!94 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !88)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "ucNotifyState", scope: !28, file: !26, line: 305, baseType: !96, size: 8, offset: 1408)
!96 = !DICompositeType(tag: DW_TAG_array_type, baseType: !97, size: 8, elements: !85)
!97 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !98)
!98 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !89, line: 24, baseType: !99)
!99 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !91, line: 37, baseType: !100)
!100 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!101 = !DIDerivedType(tag: DW_TAG_member, name: "ucStaticallyAllocated", scope: !28, file: !26, line: 311, baseType: !98, size: 8, offset: 1416)
!102 = !DIDerivedType(tag: DW_TAG_member, name: "ucDelayAborted", scope: !28, file: !26, line: 315, baseType: !98, size: 8, offset: 1424)
!103 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !104, line: 46, baseType: !35)
!104 = !DIFile(filename: "llvm-110-install_O_D_A/lib/clang/11.0.0/include/stddef.h", directory: "/tmp")
!105 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !106, size: 64)
!106 = !DIDerivedType(tag: DW_TAG_typedef, name: "List_t", file: !38, line: 179, baseType: !49)
!107 = !DIDerivedType(tag: DW_TAG_typedef, name: "TaskHandle_t", file: !6, line: 87, baseType: !108)
!108 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!109 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !110, size: 64)
!110 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !69)
!111 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !98, size: 64)
!112 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!113 = !DIDerivedType(tag: DW_TAG_typedef, name: "intptr_t", file: !114, line: 97, baseType: !82)
!114 = !DIFile(filename: "/usr/include/stdint.h", directory: "")
!115 = !{!0, !116, !119, !124, !127, !129, !131, !133, !135, !137, !139, !141, !143, !146, !148, !150, !152, !155, !157, !159, !161, !163, !165}
!116 = !DIGlobalVariableExpression(var: !117, expr: !DIExpression())
!117 = distinct !DIGlobalVariable(name: "uxTopUsedPriority", scope: !2, file: !26, line: 376, type: !118, isLocal: false, isDefinition: true)
!118 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !52)
!119 = !DIGlobalVariableExpression(var: !120, expr: !DIExpression())
!120 = distinct !DIGlobalVariable(name: "pxReadyTasksLists", scope: !2, file: !26, line: 335, type: !121, isLocal: true, isDefinition: true)
!121 = !DICompositeType(tag: DW_TAG_array_type, baseType: !106, size: 2240, elements: !122)
!122 = !{!123}
!123 = !DISubrange(count: 7)
!124 = !DIGlobalVariableExpression(var: !125, expr: !DIExpression())
!125 = distinct !DIGlobalVariable(name: "pxDelayedTaskList", scope: !2, file: !26, line: 338, type: !126, isLocal: true, isDefinition: true)
!126 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !105)
!127 = !DIGlobalVariableExpression(var: !128, expr: !DIExpression())
!128 = distinct !DIGlobalVariable(name: "pxOverflowDelayedTaskList", scope: !2, file: !26, line: 339, type: !126, isLocal: true, isDefinition: true)
!129 = !DIGlobalVariableExpression(var: !130, expr: !DIExpression())
!130 = distinct !DIGlobalVariable(name: "xPendingReadyList", scope: !2, file: !26, line: 340, type: !106, isLocal: true, isDefinition: true)
!131 = !DIGlobalVariableExpression(var: !132, expr: !DIExpression())
!132 = distinct !DIGlobalVariable(name: "xTasksWaitingTermination", scope: !2, file: !26, line: 344, type: !106, isLocal: true, isDefinition: true)
!133 = !DIGlobalVariableExpression(var: !134, expr: !DIExpression())
!134 = distinct !DIGlobalVariable(name: "xSuspendedTaskList", scope: !2, file: !26, line: 351, type: !106, isLocal: true, isDefinition: true)
!135 = !DIGlobalVariableExpression(var: !136, expr: !DIExpression())
!136 = distinct !DIGlobalVariable(name: "xDelayedTaskList1", scope: !2, file: !26, line: 336, type: !106, isLocal: true, isDefinition: true)
!137 = !DIGlobalVariableExpression(var: !138, expr: !DIExpression())
!138 = distinct !DIGlobalVariable(name: "xDelayedTaskList2", scope: !2, file: !26, line: 337, type: !106, isLocal: true, isDefinition: true)
!139 = !DIGlobalVariableExpression(var: !140, expr: !DIExpression())
!140 = distinct !DIGlobalVariable(name: "uxTaskNumber", scope: !2, file: !26, line: 369, type: !53, isLocal: true, isDefinition: true)
!141 = !DIGlobalVariableExpression(var: !142, expr: !DIExpression())
!142 = distinct !DIGlobalVariable(name: "uxDeletedTasksWaitingCleanUp", scope: !2, file: !26, line: 345, type: !52, isLocal: true, isDefinition: true)
!143 = !DIGlobalVariableExpression(var: !144, expr: !DIExpression())
!144 = distinct !DIGlobalVariable(name: "xYieldPending", scope: !2, file: !26, line: 367, type: !145, isLocal: true, isDefinition: true)
!145 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !81)
!146 = !DIGlobalVariableExpression(var: !147, expr: !DIExpression())
!147 = distinct !DIGlobalVariable(name: "uxCurrentNumberOfTasks", scope: !2, file: !26, line: 362, type: !52, isLocal: true, isDefinition: true)
!148 = !DIGlobalVariableExpression(var: !149, expr: !DIExpression())
!149 = distinct !DIGlobalVariable(name: "xSchedulerRunning", scope: !2, file: !26, line: 365, type: !145, isLocal: true, isDefinition: true)
!150 = !DIGlobalVariableExpression(var: !151, expr: !DIExpression())
!151 = distinct !DIGlobalVariable(name: "uxSchedulerSuspended", scope: !2, file: !26, line: 386, type: !52, isLocal: true, isDefinition: true)
!152 = !DIGlobalVariableExpression(var: !153, expr: !DIExpression())
!153 = distinct !DIGlobalVariable(name: "xTickCount", scope: !2, file: !26, line: 363, type: !154, isLocal: true, isDefinition: true)
!154 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !42)
!155 = !DIGlobalVariableExpression(var: !156, expr: !DIExpression())
!156 = distinct !DIGlobalVariable(name: "xIdleTaskHandle", scope: !2, file: !26, line: 371, type: !107, isLocal: true, isDefinition: true)
!157 = !DIGlobalVariableExpression(var: !158, expr: !DIExpression())
!158 = distinct !DIGlobalVariable(name: "xNextTaskUnblockTime", scope: !2, file: !26, line: 370, type: !154, isLocal: true, isDefinition: true)
!159 = !DIGlobalVariableExpression(var: !160, expr: !DIExpression())
!160 = distinct !DIGlobalVariable(name: "xPendedTicks", scope: !2, file: !26, line: 366, type: !154, isLocal: true, isDefinition: true)
!161 = !DIGlobalVariableExpression(var: !162, expr: !DIExpression())
!162 = distinct !DIGlobalVariable(name: "xNumOfOverflows", scope: !2, file: !26, line: 368, type: !145, isLocal: true, isDefinition: true)
!163 = !DIGlobalVariableExpression(var: !164, expr: !DIExpression())
!164 = distinct !DIGlobalVariable(name: "ulTotalRunTime", scope: !2, file: !26, line: 393, type: !94, isLocal: true, isDefinition: true)
!165 = !DIGlobalVariableExpression(var: !166, expr: !DIExpression())
!166 = distinct !DIGlobalVariable(name: "ulTaskSwitchedInTime", scope: !2, file: !26, line: 392, type: !88, isLocal: true, isDefinition: true)
!167 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !24)
!168 = distinct !DICompileUnit(language: DW_LANG_C99, file: !169, producer: "clang version 11.0.0 (https://github.com/llvm/llvm-project.git 60a25202a7dd1e00067fcfce512086ebf3788537)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !170, retainedTypes: !171, splitDebugInlining: false, nameTableKind: None)
!169 = !DIFile(filename: "/tmp/klee_src/test-rtos/freertos-10.5.1/Source/stream_buffer.c", directory: "/tmp/klee_src/freertos_10_5_1_test")
!170 = !{!15}
!171 = !{!81, !98, !103, !111, !23, !172, !191, !42, !88, !53, !194, !196, !112}
!172 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !173, size: 64)
!173 = !DIDerivedType(tag: DW_TAG_typedef, name: "StreamBuffer_t", file: !174, line: 242, baseType: !175)
!174 = !DIFile(filename: "test-rtos/freertos-10.5.1/Source/stream_buffer.c", directory: "/tmp/klee_src")
!175 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "StreamBufferDef_t", file: !174, line: 223, size: 576, elements: !176)
!176 = !{!177, !179, !180, !181, !182, !187, !188, !189, !190}
!177 = !DIDerivedType(tag: DW_TAG_member, name: "xTail", scope: !175, file: !174, line: 225, baseType: !178, size: 64)
!178 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !103)
!179 = !DIDerivedType(tag: DW_TAG_member, name: "xHead", scope: !175, file: !174, line: 226, baseType: !178, size: 64, offset: 64)
!180 = !DIDerivedType(tag: DW_TAG_member, name: "xLength", scope: !175, file: !174, line: 227, baseType: !103, size: 64, offset: 128)
!181 = !DIDerivedType(tag: DW_TAG_member, name: "xTriggerLevelBytes", scope: !175, file: !174, line: 228, baseType: !103, size: 64, offset: 192)
!182 = !DIDerivedType(tag: DW_TAG_member, name: "xTaskWaitingToReceive", scope: !175, file: !174, line: 229, baseType: !183, size: 64, offset: 256)
!183 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !184)
!184 = !DIDerivedType(tag: DW_TAG_typedef, name: "TaskHandle_t", file: !6, line: 87, baseType: !185)
!185 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !186, size: 64)
!186 = !DICompositeType(tag: DW_TAG_structure_type, name: "tskTaskControlBlock", file: !6, line: 86, flags: DIFlagFwdDecl)
!187 = !DIDerivedType(tag: DW_TAG_member, name: "xTaskWaitingToSend", scope: !175, file: !174, line: 230, baseType: !183, size: 64, offset: 320)
!188 = !DIDerivedType(tag: DW_TAG_member, name: "pucBuffer", scope: !175, file: !174, line: 231, baseType: !111, size: 64, offset: 384)
!189 = !DIDerivedType(tag: DW_TAG_member, name: "ucFlags", scope: !175, file: !174, line: 232, baseType: !98, size: 8, offset: 448)
!190 = !DIDerivedType(tag: DW_TAG_member, name: "uxStreamBufferNumber", scope: !175, file: !174, line: 235, baseType: !53, size: 64, offset: 512)
!191 = !DIDerivedType(tag: DW_TAG_typedef, name: "StreamBufferHandle_t", file: !192, line: 72, baseType: !193)
!192 = !DIFile(filename: "test-rtos/freertos-10.5.1/Source/include/stream_buffer.h", directory: "/tmp/klee_src")
!193 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !175, size: 64)
!194 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !195, size: 64)
!195 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !98)
!196 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !197, size: 64)
!197 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!198 = distinct !DICompileUnit(language: DW_LANG_C99, file: !199, producer: "clang version 11.0.0 (https://github.com/llvm/llvm-project.git 60a25202a7dd1e00067fcfce512086ebf3788537)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !200, retainedTypes: !201, globals: !268, splitDebugInlining: false, nameTableKind: None)
!199 = !DIFile(filename: "/tmp/klee_src/test-rtos/freertos-10.5.1/Source/queue.c", directory: "/tmp/klee_src/freertos_10_5_1_test")
!200 = !{}
!201 = !{!81, !23, !53, !202, !206, !103, !111, !42, !98, !266, !213}
!202 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !203, line: 24, baseType: !204)
!203 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-intn.h", directory: "")
!204 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int8_t", file: !91, line: 36, baseType: !205)
!205 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!206 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !207, size: 64)
!207 = !DIDerivedType(tag: DW_TAG_typedef, name: "Queue_t", file: !208, line: 137, baseType: !209)
!208 = !DIFile(filename: "test-rtos/freertos-10.5.1/Source/queue.c", directory: "/tmp/klee_src")
!209 = !DIDerivedType(tag: DW_TAG_typedef, name: "xQUEUE", file: !208, line: 133, baseType: !210)
!210 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "QueueDefinition", file: !208, line: 100, size: 1344, elements: !211)
!211 = !{!212, !214, !215, !230, !254, !255, !256, !257, !258, !260, !261, !262, !264, !265}
!212 = !DIDerivedType(tag: DW_TAG_member, name: "pcHead", scope: !210, file: !208, line: 102, baseType: !213, size: 64)
!213 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !202, size: 64)
!214 = !DIDerivedType(tag: DW_TAG_member, name: "pcWriteTo", scope: !210, file: !208, line: 103, baseType: !213, size: 64, offset: 64)
!215 = !DIDerivedType(tag: DW_TAG_member, name: "u", scope: !210, file: !208, line: 109, baseType: !216, size: 128, offset: 128)
!216 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !210, file: !208, line: 105, size: 128, elements: !217)
!217 = !{!218, !224}
!218 = !DIDerivedType(tag: DW_TAG_member, name: "xQueue", scope: !216, file: !208, line: 107, baseType: !219, size: 128)
!219 = !DIDerivedType(tag: DW_TAG_typedef, name: "QueuePointers_t", file: !208, line: 73, baseType: !220)
!220 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "QueuePointers", file: !208, line: 69, size: 128, elements: !221)
!221 = !{!222, !223}
!222 = !DIDerivedType(tag: DW_TAG_member, name: "pcTail", scope: !220, file: !208, line: 71, baseType: !213, size: 64)
!223 = !DIDerivedType(tag: DW_TAG_member, name: "pcReadFrom", scope: !220, file: !208, line: 72, baseType: !213, size: 64, offset: 64)
!224 = !DIDerivedType(tag: DW_TAG_member, name: "xSemaphore", scope: !216, file: !208, line: 108, baseType: !225, size: 128)
!225 = !DIDerivedType(tag: DW_TAG_typedef, name: "SemaphoreData_t", file: !208, line: 79, baseType: !226)
!226 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "SemaphoreData", file: !208, line: 75, size: 128, elements: !227)
!227 = !{!228, !229}
!228 = !DIDerivedType(tag: DW_TAG_member, name: "xMutexHolder", scope: !226, file: !208, line: 77, baseType: !184, size: 64)
!229 = !DIDerivedType(tag: DW_TAG_member, name: "uxRecursiveCallCount", scope: !226, file: !208, line: 78, baseType: !53, size: 64, offset: 64)
!230 = !DIDerivedType(tag: DW_TAG_member, name: "xTasksWaitingToSend", scope: !210, file: !208, line: 111, baseType: !231, size: 320, offset: 256)
!231 = !DIDerivedType(tag: DW_TAG_typedef, name: "List_t", file: !38, line: 179, baseType: !232)
!232 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xLIST", file: !38, line: 172, size: 320, elements: !233)
!233 = !{!234, !235, !247}
!234 = !DIDerivedType(tag: DW_TAG_member, name: "uxNumberOfItems", scope: !232, file: !38, line: 175, baseType: !52, size: 64)
!235 = !DIDerivedType(tag: DW_TAG_member, name: "pxIndex", scope: !232, file: !38, line: 176, baseType: !236, size: 64, offset: 64)
!236 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !237, size: 64)
!237 = !DIDerivedType(tag: DW_TAG_typedef, name: "ListItem_t", file: !38, line: 154, baseType: !238)
!238 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xLIST_ITEM", file: !38, line: 144, size: 320, elements: !239)
!239 = !{!240, !241, !243, !244, !245}
!240 = !DIDerivedType(tag: DW_TAG_member, name: "xItemValue", scope: !238, file: !38, line: 147, baseType: !42, size: 64)
!241 = !DIDerivedType(tag: DW_TAG_member, name: "pxNext", scope: !238, file: !38, line: 148, baseType: !242, size: 64, offset: 64)
!242 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !238, size: 64)
!243 = !DIDerivedType(tag: DW_TAG_member, name: "pxPrevious", scope: !238, file: !38, line: 149, baseType: !242, size: 64, offset: 128)
!244 = !DIDerivedType(tag: DW_TAG_member, name: "pvOwner", scope: !238, file: !38, line: 150, baseType: !23, size: 64, offset: 192)
!245 = !DIDerivedType(tag: DW_TAG_member, name: "pvContainer", scope: !238, file: !38, line: 151, baseType: !246, size: 64, offset: 256)
!246 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !232, size: 64)
!247 = !DIDerivedType(tag: DW_TAG_member, name: "xListEnd", scope: !232, file: !38, line: 177, baseType: !248, size: 192, offset: 128)
!248 = !DIDerivedType(tag: DW_TAG_typedef, name: "MiniListItem_t", file: !38, line: 164, baseType: !249)
!249 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xMINI_LIST_ITEM", file: !38, line: 157, size: 192, elements: !250)
!250 = !{!251, !252, !253}
!251 = !DIDerivedType(tag: DW_TAG_member, name: "xItemValue", scope: !249, file: !38, line: 160, baseType: !42, size: 64)
!252 = !DIDerivedType(tag: DW_TAG_member, name: "pxNext", scope: !249, file: !38, line: 161, baseType: !242, size: 64, offset: 64)
!253 = !DIDerivedType(tag: DW_TAG_member, name: "pxPrevious", scope: !249, file: !38, line: 162, baseType: !242, size: 64, offset: 128)
!254 = !DIDerivedType(tag: DW_TAG_member, name: "xTasksWaitingToReceive", scope: !210, file: !208, line: 112, baseType: !231, size: 320, offset: 576)
!255 = !DIDerivedType(tag: DW_TAG_member, name: "uxMessagesWaiting", scope: !210, file: !208, line: 114, baseType: !52, size: 64, offset: 896)
!256 = !DIDerivedType(tag: DW_TAG_member, name: "uxLength", scope: !210, file: !208, line: 115, baseType: !53, size: 64, offset: 960)
!257 = !DIDerivedType(tag: DW_TAG_member, name: "uxItemSize", scope: !210, file: !208, line: 116, baseType: !53, size: 64, offset: 1024)
!258 = !DIDerivedType(tag: DW_TAG_member, name: "cRxLock", scope: !210, file: !208, line: 118, baseType: !259, size: 8, offset: 1088)
!259 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !202)
!260 = !DIDerivedType(tag: DW_TAG_member, name: "cTxLock", scope: !210, file: !208, line: 119, baseType: !259, size: 8, offset: 1096)
!261 = !DIDerivedType(tag: DW_TAG_member, name: "ucStaticallyAllocated", scope: !210, file: !208, line: 122, baseType: !98, size: 8, offset: 1104)
!262 = !DIDerivedType(tag: DW_TAG_member, name: "pxQueueSetContainer", scope: !210, file: !208, line: 126, baseType: !263, size: 64, offset: 1152)
!263 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !210, size: 64)
!264 = !DIDerivedType(tag: DW_TAG_member, name: "uxQueueNumber", scope: !210, file: !208, line: 130, baseType: !53, size: 64, offset: 1216)
!265 = !DIDerivedType(tag: DW_TAG_member, name: "ucQueueType", scope: !210, file: !208, line: 131, baseType: !98, size: 8, offset: 1280)
!266 = !DIDerivedType(tag: DW_TAG_typedef, name: "QueueHandle_t", file: !267, line: 51, baseType: !263)
!267 = !DIFile(filename: "test-rtos/freertos-10.5.1/Source/include/queue.h", directory: "/tmp/klee_src")
!268 = !{!269}
!269 = !DIGlobalVariableExpression(var: !270, expr: !DIExpression())
!270 = distinct !DIGlobalVariable(name: "xQueueRegistry", scope: !198, file: !208, line: 164, type: !271, isLocal: false, isDefinition: true)
!271 = !DICompositeType(tag: DW_TAG_array_type, baseType: !272, size: 2560, elements: !278)
!272 = !DIDerivedType(tag: DW_TAG_typedef, name: "QueueRegistryItem_t", file: !208, line: 159, baseType: !273)
!273 = !DIDerivedType(tag: DW_TAG_typedef, name: "xQueueRegistryItem", file: !208, line: 154, baseType: !274)
!274 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "QUEUE_REGISTRY_ITEM", file: !208, line: 150, size: 128, elements: !275)
!275 = !{!276, !277}
!276 = !DIDerivedType(tag: DW_TAG_member, name: "pcQueueName", scope: !274, file: !208, line: 152, baseType: !109, size: 64)
!277 = !DIDerivedType(tag: DW_TAG_member, name: "xHandle", scope: !274, file: !208, line: 153, baseType: !266, size: 64, offset: 64)
!278 = !{!279}
!279 = !DISubrange(count: 20)
!280 = distinct !DICompileUnit(language: DW_LANG_C99, file: !281, producer: "clang version 11.0.0 (https://github.com/llvm/llvm-project.git 60a25202a7dd1e00067fcfce512086ebf3788537)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !200, splitDebugInlining: false, nameTableKind: None)
!281 = !DIFile(filename: "/tmp/klee_src/test-rtos/freertos-10.5.1/Source/croutine.c", directory: "/tmp/klee_src/freertos_10_5_1_test")
!282 = distinct !DICompileUnit(language: DW_LANG_C99, file: !283, producer: "clang version 11.0.0 (https://github.com/llvm/llvm-project.git 60a25202a7dd1e00067fcfce512086ebf3788537)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !200, retainedTypes: !284, splitDebugInlining: false, nameTableKind: None)
!283 = !DIFile(filename: "/tmp/klee_src/test-rtos/freertos-10.5.1/Source/list.c", directory: "/tmp/klee_src/freertos_10_5_1_test")
!284 = !{!285, !42, !53}
!285 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !286, size: 64)
!286 = !DIDerivedType(tag: DW_TAG_typedef, name: "ListItem_t", file: !38, line: 154, baseType: !287)
!287 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xLIST_ITEM", file: !38, line: 144, size: 320, elements: !288)
!288 = !{!289, !290, !292, !293, !294}
!289 = !DIDerivedType(tag: DW_TAG_member, name: "xItemValue", scope: !287, file: !38, line: 147, baseType: !42, size: 64)
!290 = !DIDerivedType(tag: DW_TAG_member, name: "pxNext", scope: !287, file: !38, line: 148, baseType: !291, size: 64, offset: 64)
!291 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !287, size: 64)
!292 = !DIDerivedType(tag: DW_TAG_member, name: "pxPrevious", scope: !287, file: !38, line: 149, baseType: !291, size: 64, offset: 128)
!293 = !DIDerivedType(tag: DW_TAG_member, name: "pvOwner", scope: !287, file: !38, line: 150, baseType: !23, size: 64, offset: 192)
!294 = !DIDerivedType(tag: DW_TAG_member, name: "pvContainer", scope: !287, file: !38, line: 151, baseType: !295, size: 64, offset: 256)
!295 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !296, size: 64)
!296 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xLIST", file: !38, line: 172, size: 320, elements: !297)
!297 = !{!298, !299, !300}
!298 = !DIDerivedType(tag: DW_TAG_member, name: "uxNumberOfItems", scope: !296, file: !38, line: 175, baseType: !52, size: 64)
!299 = !DIDerivedType(tag: DW_TAG_member, name: "pxIndex", scope: !296, file: !38, line: 176, baseType: !285, size: 64, offset: 64)
!300 = !DIDerivedType(tag: DW_TAG_member, name: "xListEnd", scope: !296, file: !38, line: 177, baseType: !301, size: 192, offset: 128)
!301 = !DIDerivedType(tag: DW_TAG_typedef, name: "MiniListItem_t", file: !38, line: 164, baseType: !302)
!302 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xMINI_LIST_ITEM", file: !38, line: 157, size: 192, elements: !303)
!303 = !{!304, !305, !306}
!304 = !DIDerivedType(tag: DW_TAG_member, name: "xItemValue", scope: !302, file: !38, line: 160, baseType: !42, size: 64)
!305 = !DIDerivedType(tag: DW_TAG_member, name: "pxNext", scope: !302, file: !38, line: 161, baseType: !291, size: 64, offset: 64)
!306 = !DIDerivedType(tag: DW_TAG_member, name: "pxPrevious", scope: !302, file: !38, line: 162, baseType: !291, size: 64, offset: 128)
!307 = distinct !DICompileUnit(language: DW_LANG_C99, file: !308, producer: "clang version 11.0.0 (https://github.com/llvm/llvm-project.git 60a25202a7dd1e00067fcfce512086ebf3788537)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !200, retainedTypes: !309, splitDebugInlining: false, nameTableKind: None)
!308 = !DIFile(filename: "/tmp/klee_src/test-rtos/freertos-10.5.1/Source/event_groups.c", directory: "/tmp/klee_src/freertos_10_5_1_test")
!309 = !{!310, !23, !81, !42, !316, !88, !344, !53, !98}
!310 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !311, size: 64)
!311 = !DIDerivedType(tag: DW_TAG_typedef, name: "EventGroup_t", file: !312, line: 76, baseType: !313)
!312 = !DIFile(filename: "test-rtos/freertos-10.5.1/Source/event_groups.c", directory: "/tmp/klee_src")
!313 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "EventGroupDef_t", file: !312, line: 64, size: 512, elements: !314)
!314 = !{!315, !318, !342, !343}
!315 = !DIDerivedType(tag: DW_TAG_member, name: "uxEventBits", scope: !313, file: !312, line: 66, baseType: !316, size: 64)
!316 = !DIDerivedType(tag: DW_TAG_typedef, name: "EventBits_t", file: !317, line: 93, baseType: !42)
!317 = !DIFile(filename: "test-rtos/freertos-10.5.1/Source/include/event_groups.h", directory: "/tmp/klee_src")
!318 = !DIDerivedType(tag: DW_TAG_member, name: "xTasksWaitingForBits", scope: !313, file: !312, line: 67, baseType: !319, size: 320, offset: 64)
!319 = !DIDerivedType(tag: DW_TAG_typedef, name: "List_t", file: !38, line: 179, baseType: !320)
!320 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xLIST", file: !38, line: 172, size: 320, elements: !321)
!321 = !{!322, !323, !335}
!322 = !DIDerivedType(tag: DW_TAG_member, name: "uxNumberOfItems", scope: !320, file: !38, line: 175, baseType: !52, size: 64)
!323 = !DIDerivedType(tag: DW_TAG_member, name: "pxIndex", scope: !320, file: !38, line: 176, baseType: !324, size: 64, offset: 64)
!324 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !325, size: 64)
!325 = !DIDerivedType(tag: DW_TAG_typedef, name: "ListItem_t", file: !38, line: 154, baseType: !326)
!326 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xLIST_ITEM", file: !38, line: 144, size: 320, elements: !327)
!327 = !{!328, !329, !331, !332, !333}
!328 = !DIDerivedType(tag: DW_TAG_member, name: "xItemValue", scope: !326, file: !38, line: 147, baseType: !42, size: 64)
!329 = !DIDerivedType(tag: DW_TAG_member, name: "pxNext", scope: !326, file: !38, line: 148, baseType: !330, size: 64, offset: 64)
!330 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !326, size: 64)
!331 = !DIDerivedType(tag: DW_TAG_member, name: "pxPrevious", scope: !326, file: !38, line: 149, baseType: !330, size: 64, offset: 128)
!332 = !DIDerivedType(tag: DW_TAG_member, name: "pvOwner", scope: !326, file: !38, line: 150, baseType: !23, size: 64, offset: 192)
!333 = !DIDerivedType(tag: DW_TAG_member, name: "pvContainer", scope: !326, file: !38, line: 151, baseType: !334, size: 64, offset: 256)
!334 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !320, size: 64)
!335 = !DIDerivedType(tag: DW_TAG_member, name: "xListEnd", scope: !320, file: !38, line: 177, baseType: !336, size: 192, offset: 128)
!336 = !DIDerivedType(tag: DW_TAG_typedef, name: "MiniListItem_t", file: !38, line: 164, baseType: !337)
!337 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xMINI_LIST_ITEM", file: !38, line: 157, size: 192, elements: !338)
!338 = !{!339, !340, !341}
!339 = !DIDerivedType(tag: DW_TAG_member, name: "xItemValue", scope: !337, file: !38, line: 160, baseType: !42, size: 64)
!340 = !DIDerivedType(tag: DW_TAG_member, name: "pxNext", scope: !337, file: !38, line: 161, baseType: !330, size: 64, offset: 64)
!341 = !DIDerivedType(tag: DW_TAG_member, name: "pxPrevious", scope: !337, file: !38, line: 162, baseType: !330, size: 64, offset: 128)
!342 = !DIDerivedType(tag: DW_TAG_member, name: "uxEventGroupNumber", scope: !313, file: !312, line: 70, baseType: !53, size: 64, offset: 384)
!343 = !DIDerivedType(tag: DW_TAG_member, name: "ucStaticallyAllocated", scope: !313, file: !312, line: 74, baseType: !98, size: 8, offset: 448)
!344 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !345, size: 64)
!345 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !325)
!346 = distinct !DICompileUnit(language: DW_LANG_C99, file: !347, producer: "clang version 11.0.0 (https://github.com/llvm/llvm-project.git 60a25202a7dd1e00067fcfce512086ebf3788537)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !200, retainedTypes: !348, globals: !391, splitDebugInlining: false, nameTableKind: None)
!347 = !DIFile(filename: "/tmp/klee_src/test-rtos/freertos-10.5.1/Source/timers.c", directory: "/tmp/klee_src/freertos_10_5_1_test")
!348 = !{!81, !23, !53, !349, !98, !42, !387}
!349 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !350, size: 64)
!350 = !DIDerivedType(tag: DW_TAG_typedef, name: "Timer_t", file: !351, line: 90, baseType: !352)
!351 = !DIFile(filename: "test-rtos/freertos-10.5.1/Source/timers.c", directory: "/tmp/klee_src")
!352 = !DIDerivedType(tag: DW_TAG_typedef, name: "xTIMER", file: !351, line: 86, baseType: !353)
!353 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tmrTimerControl", file: !351, line: 75, size: 704, elements: !354)
!354 = !{!355, !356, !379, !380, !381, !389, !390}
!355 = !DIDerivedType(tag: DW_TAG_member, name: "pcTimerName", scope: !353, file: !351, line: 77, baseType: !109, size: 64)
!356 = !DIDerivedType(tag: DW_TAG_member, name: "xTimerListItem", scope: !353, file: !351, line: 78, baseType: !357, size: 320, offset: 64)
!357 = !DIDerivedType(tag: DW_TAG_typedef, name: "ListItem_t", file: !38, line: 154, baseType: !358)
!358 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xLIST_ITEM", file: !38, line: 144, size: 320, elements: !359)
!359 = !{!360, !361, !363, !364, !365}
!360 = !DIDerivedType(tag: DW_TAG_member, name: "xItemValue", scope: !358, file: !38, line: 147, baseType: !42, size: 64)
!361 = !DIDerivedType(tag: DW_TAG_member, name: "pxNext", scope: !358, file: !38, line: 148, baseType: !362, size: 64, offset: 64)
!362 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !358, size: 64)
!363 = !DIDerivedType(tag: DW_TAG_member, name: "pxPrevious", scope: !358, file: !38, line: 149, baseType: !362, size: 64, offset: 128)
!364 = !DIDerivedType(tag: DW_TAG_member, name: "pvOwner", scope: !358, file: !38, line: 150, baseType: !23, size: 64, offset: 192)
!365 = !DIDerivedType(tag: DW_TAG_member, name: "pvContainer", scope: !358, file: !38, line: 151, baseType: !366, size: 64, offset: 256)
!366 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !367, size: 64)
!367 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xLIST", file: !38, line: 172, size: 320, elements: !368)
!368 = !{!369, !370, !372}
!369 = !DIDerivedType(tag: DW_TAG_member, name: "uxNumberOfItems", scope: !367, file: !38, line: 175, baseType: !52, size: 64)
!370 = !DIDerivedType(tag: DW_TAG_member, name: "pxIndex", scope: !367, file: !38, line: 176, baseType: !371, size: 64, offset: 64)
!371 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !357, size: 64)
!372 = !DIDerivedType(tag: DW_TAG_member, name: "xListEnd", scope: !367, file: !38, line: 177, baseType: !373, size: 192, offset: 128)
!373 = !DIDerivedType(tag: DW_TAG_typedef, name: "MiniListItem_t", file: !38, line: 164, baseType: !374)
!374 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xMINI_LIST_ITEM", file: !38, line: 157, size: 192, elements: !375)
!375 = !{!376, !377, !378}
!376 = !DIDerivedType(tag: DW_TAG_member, name: "xItemValue", scope: !374, file: !38, line: 160, baseType: !42, size: 64)
!377 = !DIDerivedType(tag: DW_TAG_member, name: "pxNext", scope: !374, file: !38, line: 161, baseType: !362, size: 64, offset: 64)
!378 = !DIDerivedType(tag: DW_TAG_member, name: "pxPrevious", scope: !374, file: !38, line: 162, baseType: !362, size: 64, offset: 128)
!379 = !DIDerivedType(tag: DW_TAG_member, name: "xTimerPeriodInTicks", scope: !353, file: !351, line: 79, baseType: !42, size: 64, offset: 384)
!380 = !DIDerivedType(tag: DW_TAG_member, name: "pvTimerID", scope: !353, file: !351, line: 80, baseType: !23, size: 64, offset: 448)
!381 = !DIDerivedType(tag: DW_TAG_member, name: "pxCallbackFunction", scope: !353, file: !351, line: 81, baseType: !382, size: 64, offset: 512)
!382 = !DIDerivedType(tag: DW_TAG_typedef, name: "TimerCallbackFunction_t", file: !383, line: 85, baseType: !384)
!383 = !DIFile(filename: "test-rtos/freertos-10.5.1/Source/include/timers.h", directory: "/tmp/klee_src")
!384 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !385, size: 64)
!385 = !DISubroutineType(types: !386)
!386 = !{null, !387}
!387 = !DIDerivedType(tag: DW_TAG_typedef, name: "TimerHandle_t", file: !383, line: 80, baseType: !388)
!388 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !353, size: 64)
!389 = !DIDerivedType(tag: DW_TAG_member, name: "uxTimerNumber", scope: !353, file: !351, line: 83, baseType: !53, size: 64, offset: 576)
!390 = !DIDerivedType(tag: DW_TAG_member, name: "ucStatus", scope: !353, file: !351, line: 85, baseType: !98, size: 8, offset: 640)
!391 = !{!392, !397, !399, !403, !410, !412, !454, !459, !461}
!392 = !DIGlobalVariableExpression(var: !393, expr: !DIExpression())
!393 = distinct !DIGlobalVariable(name: "xTimerQueue", scope: !346, file: !351, line: 143, type: !394, isLocal: true, isDefinition: true)
!394 = !DIDerivedType(tag: DW_TAG_typedef, name: "QueueHandle_t", file: !267, line: 51, baseType: !395)
!395 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !396, size: 64)
!396 = !DICompositeType(tag: DW_TAG_structure_type, name: "QueueDefinition", file: !267, line: 50, flags: DIFlagFwdDecl)
!397 = !DIGlobalVariableExpression(var: !398, expr: !DIExpression())
!398 = distinct !DIGlobalVariable(name: "xTimerTaskHandle", scope: !346, file: !351, line: 144, type: !184, isLocal: true, isDefinition: true)
!399 = !DIGlobalVariableExpression(var: !400, expr: !DIExpression())
!400 = distinct !DIGlobalVariable(name: "pxCurrentTimerList", scope: !346, file: !351, line: 139, type: !401, isLocal: true, isDefinition: true)
!401 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !402, size: 64)
!402 = !DIDerivedType(tag: DW_TAG_typedef, name: "List_t", file: !38, line: 179, baseType: !367)
!403 = !DIGlobalVariableExpression(var: !404, expr: !DIExpression())
!404 = distinct !DIGlobalVariable(name: "xLastTime", scope: !405, file: !351, line: 696, type: !42, isLocal: true, isDefinition: true)
!405 = distinct !DISubprogram(name: "prvSampleTimeNow", scope: !351, file: !351, line: 693, type: !406, scopeLine: 694, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !346, retainedNodes: !200)
!406 = !DISubroutineType(types: !407)
!407 = !{!42, !408}
!408 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !409)
!409 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !81, size: 64)
!410 = !DIGlobalVariableExpression(var: !411, expr: !DIExpression())
!411 = distinct !DIGlobalVariable(name: "pxOverflowTimerList", scope: !346, file: !351, line: 140, type: !401, isLocal: true, isDefinition: true)
!412 = !DIGlobalVariableExpression(var: !413, expr: !DIExpression())
!413 = distinct !DIGlobalVariable(name: "xStaticTimerQueue", scope: !414, file: !351, line: 951, type: !417, isLocal: true, isDefinition: true)
!414 = distinct !DISubprogram(name: "prvCheckForValidListAndQueue", scope: !351, file: !351, line: 933, type: !415, scopeLine: 934, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !346, retainedNodes: !200)
!415 = !DISubroutineType(types: !416)
!416 = !{null}
!417 = !DIDerivedType(tag: DW_TAG_typedef, name: "StaticQueue_t", file: !418, line: 1346, baseType: !419)
!418 = !DIFile(filename: "test-rtos/freertos-10.5.1/Source/include/FreeRTOS.h", directory: "/tmp/klee_src")
!419 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xSTATIC_QUEUE", file: !418, line: 1320, size: 1344, elements: !420)
!420 = !{!421, !425, !430, !446, !448, !450, !451, !452, !453}
!421 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy1", scope: !419, file: !418, line: 1322, baseType: !422, size: 192)
!422 = !DICompositeType(tag: DW_TAG_array_type, baseType: !23, size: 192, elements: !423)
!423 = !{!424}
!424 = !DISubrange(count: 3)
!425 = !DIDerivedType(tag: DW_TAG_member, name: "u", scope: !419, file: !418, line: 1328, baseType: !426, size: 64, offset: 192)
!426 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !419, file: !418, line: 1324, size: 64, elements: !427)
!427 = !{!428, !429}
!428 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy2", scope: !426, file: !418, line: 1326, baseType: !23, size: 64)
!429 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy2", scope: !426, file: !418, line: 1327, baseType: !53, size: 64)
!430 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy3", scope: !419, file: !418, line: 1330, baseType: !431, size: 640, offset: 256)
!431 = !DICompositeType(tag: DW_TAG_array_type, baseType: !432, size: 640, elements: !444)
!432 = !DIDerivedType(tag: DW_TAG_typedef, name: "StaticList_t", file: !418, line: 1241, baseType: !433)
!433 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xSTATIC_LIST", file: !418, line: 1230, size: 320, elements: !434)
!434 = !{!435, !436, !437}
!435 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy2", scope: !433, file: !418, line: 1235, baseType: !53, size: 64)
!436 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy3", scope: !433, file: !418, line: 1236, baseType: !23, size: 64, offset: 64)
!437 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy4", scope: !433, file: !418, line: 1237, baseType: !438, size: 192, offset: 128)
!438 = !DIDerivedType(tag: DW_TAG_typedef, name: "StaticMiniListItem_t", file: !418, line: 1224, baseType: !439)
!439 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xSTATIC_MINI_LIST_ITEM", file: !418, line: 1216, size: 192, elements: !440)
!440 = !{!441, !442}
!441 = !DIDerivedType(tag: DW_TAG_member, name: "xDummy2", scope: !439, file: !418, line: 1221, baseType: !42, size: 64)
!442 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy3", scope: !439, file: !418, line: 1222, baseType: !443, size: 128, offset: 64)
!443 = !DICompositeType(tag: DW_TAG_array_type, baseType: !23, size: 128, elements: !444)
!444 = !{!445}
!445 = !DISubrange(count: 2)
!446 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy4", scope: !419, file: !418, line: 1331, baseType: !447, size: 192, offset: 896)
!447 = !DICompositeType(tag: DW_TAG_array_type, baseType: !53, size: 192, elements: !423)
!448 = !DIDerivedType(tag: DW_TAG_member, name: "ucDummy5", scope: !419, file: !418, line: 1332, baseType: !449, size: 16, offset: 1088)
!449 = !DICompositeType(tag: DW_TAG_array_type, baseType: !98, size: 16, elements: !444)
!450 = !DIDerivedType(tag: DW_TAG_member, name: "ucDummy6", scope: !419, file: !418, line: 1335, baseType: !98, size: 8, offset: 1104)
!451 = !DIDerivedType(tag: DW_TAG_member, name: "pvDummy7", scope: !419, file: !418, line: 1339, baseType: !23, size: 64, offset: 1152)
!452 = !DIDerivedType(tag: DW_TAG_member, name: "uxDummy8", scope: !419, file: !418, line: 1343, baseType: !53, size: 64, offset: 1216)
!453 = !DIDerivedType(tag: DW_TAG_member, name: "ucDummy9", scope: !419, file: !418, line: 1344, baseType: !98, size: 8, offset: 1280)
!454 = !DIGlobalVariableExpression(var: !455, expr: !DIExpression())
!455 = distinct !DIGlobalVariable(name: "ucStaticTimerQueueStorage", scope: !414, file: !351, line: 952, type: !456, isLocal: true, isDefinition: true)
!456 = !DICompositeType(tag: DW_TAG_array_type, baseType: !98, size: 5120, elements: !457)
!457 = !{!458}
!458 = !DISubrange(count: 640)
!459 = !DIGlobalVariableExpression(var: !460, expr: !DIExpression())
!460 = distinct !DIGlobalVariable(name: "xActiveTimerList1", scope: !346, file: !351, line: 137, type: !402, isLocal: true, isDefinition: true)
!461 = !DIGlobalVariableExpression(var: !462, expr: !DIExpression())
!462 = distinct !DIGlobalVariable(name: "xActiveTimerList2", scope: !346, file: !351, line: 138, type: !402, isLocal: true, isDefinition: true)
!463 = distinct !DICompileUnit(language: DW_LANG_C99, file: !464, producer: "clang version 11.0.0 (https://github.com/llvm/llvm-project.git 60a25202a7dd1e00067fcfce512086ebf3788537)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !200, retainedTypes: !465, splitDebugInlining: false, nameTableKind: None)
!464 = !DIFile(filename: "test_files/test_MPU_xTaskCallApplicationTaskHook.c", directory: "/tmp/klee_src/freertos_10_5_1_test")
!465 = !{!23}
!466 = distinct !DICompileUnit(language: DW_LANG_C99, file: !467, producer: "clang version 11.0.0 (https://github.com/llvm/llvm-project.git 60a25202a7dd1e00067fcfce512086ebf3788537)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !200, splitDebugInlining: false, nameTableKind: None)
!467 = !DIFile(filename: "/home/klee/klee_src/runtime/Freestanding/memset.c", directory: "/home/klee/klee_src/build/runtime/Freestanding")
!468 = !{!"clang version 11.0.0 (https://github.com/llvm/llvm-project.git 60a25202a7dd1e00067fcfce512086ebf3788537)"}
!469 = !{i32 7, !"Dwarf Version", i32 4}
!470 = !{i32 2, !"Debug Info Version", i32 3}
!471 = !{i32 1, !"wchar_size", i32 4}
!472 = distinct !DISubprogram(name: "vListInitialise", scope: !473, file: !473, line: 50, type: !474, scopeLine: 51, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !282, retainedNodes: !200)
!473 = !DIFile(filename: "test-rtos/freertos-10.5.1/Source/list.c", directory: "/tmp/klee_src")
!474 = !DISubroutineType(types: !475)
!475 = !{null, !476}
!476 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !477)
!477 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !478, size: 64)
!478 = !DIDerivedType(tag: DW_TAG_typedef, name: "List_t", file: !38, line: 179, baseType: !296)
!479 = !DILocalVariable(name: "pxList", arg: 1, scope: !472, file: !473, line: 50, type: !476)
!480 = !DILocation(line: 50, column: 38, scope: !472)
!481 = !DILocation(line: 55, column: 43, scope: !472)
!482 = !DILocation(line: 55, column: 51, scope: !472)
!483 = !DILocation(line: 55, column: 23, scope: !472)
!484 = !DILocation(line: 55, column: 5, scope: !472)
!485 = !DILocation(line: 55, column: 13, scope: !472)
!486 = !DILocation(line: 55, column: 21, scope: !472)
!487 = !DILocation(line: 61, column: 5, scope: !472)
!488 = !DILocation(line: 61, column: 13, scope: !472)
!489 = !DILocation(line: 61, column: 22, scope: !472)
!490 = !DILocation(line: 61, column: 33, scope: !472)
!491 = !DILocation(line: 65, column: 51, scope: !472)
!492 = !DILocation(line: 65, column: 59, scope: !472)
!493 = !DILocation(line: 65, column: 31, scope: !472)
!494 = !DILocation(line: 65, column: 5, scope: !472)
!495 = !DILocation(line: 65, column: 13, scope: !472)
!496 = !DILocation(line: 65, column: 22, scope: !472)
!497 = !DILocation(line: 65, column: 29, scope: !472)
!498 = !DILocation(line: 66, column: 55, scope: !472)
!499 = !DILocation(line: 66, column: 63, scope: !472)
!500 = !DILocation(line: 66, column: 35, scope: !472)
!501 = !DILocation(line: 66, column: 5, scope: !472)
!502 = !DILocation(line: 66, column: 13, scope: !472)
!503 = !DILocation(line: 66, column: 22, scope: !472)
!504 = !DILocation(line: 66, column: 33, scope: !472)
!505 = !DILocation(line: 77, column: 5, scope: !472)
!506 = !DILocation(line: 77, column: 13, scope: !472)
!507 = !DILocation(line: 77, column: 29, scope: !472)
!508 = !DILocation(line: 83, column: 1, scope: !472)
!509 = distinct !DISubprogram(name: "vListInitialiseItem", scope: !473, file: !473, line: 86, type: !510, scopeLine: 87, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !282, retainedNodes: !200)
!510 = !DISubroutineType(types: !511)
!511 = !{null, !512}
!512 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !285)
!513 = !DILocalVariable(name: "pxItem", arg: 1, scope: !509, file: !473, line: 86, type: !512)
!514 = !DILocation(line: 86, column: 46, scope: !509)
!515 = !DILocation(line: 89, column: 5, scope: !509)
!516 = !DILocation(line: 89, column: 13, scope: !509)
!517 = !DILocation(line: 89, column: 25, scope: !509)
!518 = !DILocation(line: 95, column: 1, scope: !509)
!519 = distinct !DISubprogram(name: "prvInitialiseNewTask", scope: !26, file: !26, line: 816, type: !520, scopeLine: 824, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !200)
!520 = !DISubroutineType(types: !521)
!521 = !{null, !522, !527, !528, !529, !53, !530, !24, !532}
!522 = !DIDerivedType(tag: DW_TAG_typedef, name: "TaskFunction_t", file: !523, line: 36, baseType: !524)
!523 = !DIFile(filename: "test-rtos/freertos-10.5.1/Source/include/projdefs.h", directory: "/tmp/klee_src")
!524 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !525, size: 64)
!525 = !DISubroutineType(types: !526)
!526 = !{null, !23}
!527 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !109)
!528 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !88)
!529 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !23)
!530 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !531)
!531 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !107, size: 64)
!532 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !533)
!533 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !534, size: 64)
!534 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !535)
!535 = !DIDerivedType(tag: DW_TAG_typedef, name: "MemoryRegion_t", file: !6, line: 133, baseType: !536)
!536 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xMEMORY_REGION", file: !6, line: 128, size: 128, elements: !537)
!537 = !{!538, !539, !540}
!538 = !DIDerivedType(tag: DW_TAG_member, name: "pvBaseAddress", scope: !536, file: !6, line: 130, baseType: !23, size: 64)
!539 = !DIDerivedType(tag: DW_TAG_member, name: "ulLengthInBytes", scope: !536, file: !6, line: 131, baseType: !88, size: 32, offset: 64)
!540 = !DIDerivedType(tag: DW_TAG_member, name: "ulParameters", scope: !536, file: !6, line: 132, baseType: !88, size: 32, offset: 96)
!541 = !DILocalVariable(name: "pxTaskCode", arg: 1, scope: !519, file: !26, line: 816, type: !522)
!542 = !DILocation(line: 816, column: 50, scope: !519)
!543 = !DILocalVariable(name: "pcName", arg: 2, scope: !519, file: !26, line: 817, type: !527)
!544 = !DILocation(line: 817, column: 54, scope: !519)
!545 = !DILocalVariable(name: "ulStackDepth", arg: 3, scope: !519, file: !26, line: 818, type: !528)
!546 = !DILocation(line: 818, column: 50, scope: !519)
!547 = !DILocalVariable(name: "pvParameters", arg: 4, scope: !519, file: !26, line: 819, type: !529)
!548 = !DILocation(line: 819, column: 48, scope: !519)
!549 = !DILocalVariable(name: "uxPriority", arg: 5, scope: !519, file: !26, line: 820, type: !53)
!550 = !DILocation(line: 820, column: 47, scope: !519)
!551 = !DILocalVariable(name: "pxCreatedTask", arg: 6, scope: !519, file: !26, line: 821, type: !530)
!552 = !DILocation(line: 821, column: 56, scope: !519)
!553 = !DILocalVariable(name: "pxNewTCB", arg: 7, scope: !519, file: !26, line: 822, type: !24)
!554 = !DILocation(line: 822, column: 43, scope: !519)
!555 = !DILocalVariable(name: "xRegions", arg: 8, scope: !519, file: !26, line: 823, type: !532)
!556 = !DILocation(line: 823, column: 64, scope: !519)
!557 = !DILocalVariable(name: "pxTopOfStack", scope: !519, file: !26, line: 825, type: !66)
!558 = !DILocation(line: 825, column: 19, scope: !519)
!559 = !DILocalVariable(name: "x", scope: !519, file: !26, line: 826, type: !53)
!560 = !DILocation(line: 826, column: 17, scope: !519)
!561 = !DILocation(line: 847, column: 26, scope: !562)
!562 = distinct !DILexicalBlock(scope: !519, file: !26, line: 845, column: 5)
!563 = !DILocation(line: 847, column: 36, scope: !562)
!564 = !DILocation(line: 847, column: 18, scope: !562)
!565 = !DILocation(line: 847, column: 84, scope: !562)
!566 = !DILocation(line: 847, column: 73, scope: !562)
!567 = !DILocation(line: 847, column: 97, scope: !562)
!568 = !DILocation(line: 857, column: 27, scope: !569)
!569 = distinct !DILexicalBlock(scope: !519, file: !26, line: 856, column: 5)
!570 = !DILocation(line: 857, column: 37, scope: !569)
!571 = !DILocation(line: 857, column: 46, scope: !569)
!572 = !DILocation(line: 857, column: 59, scope: !569)
!573 = !DILocation(line: 857, column: 22, scope: !569)
!574 = !DILocation(line: 858, column: 72, scope: !569)
!575 = !DILocation(line: 858, column: 46, scope: !569)
!576 = !DILocation(line: 858, column: 87, scope: !569)
!577 = !DILocation(line: 858, column: 24, scope: !569)
!578 = !DILocation(line: 858, column: 22, scope: !569)
!579 = !DILocation(line: 861, column: 9, scope: !580)
!580 = distinct !DILexicalBlock(scope: !569, file: !26, line: 861, column: 9)
!581 = !DILocation(line: 861, column: 9, scope: !569)
!582 = !DILocation(line: 885, column: 9, scope: !583)
!583 = distinct !DILexicalBlock(scope: !519, file: !26, line: 885, column: 9)
!584 = !DILocation(line: 885, column: 16, scope: !583)
!585 = !DILocation(line: 885, column: 9, scope: !519)
!586 = !DILocation(line: 907, column: 5, scope: !587)
!587 = distinct !DILexicalBlock(scope: !583, file: !26, line: 886, column: 5)
!588 = !DILocation(line: 914, column: 5, scope: !589)
!589 = distinct !DILexicalBlock(scope: !519, file: !26, line: 914, column: 5)
!590 = !DILocation(line: 914, column: 5, scope: !519)
!591 = !DILocation(line: 916, column: 9, scope: !592)
!592 = distinct !DILexicalBlock(scope: !519, file: !26, line: 916, column: 9)
!593 = !DILocation(line: 916, column: 20, scope: !592)
!594 = !DILocation(line: 916, column: 9, scope: !519)
!595 = !DILocation(line: 918, column: 20, scope: !596)
!596 = distinct !DILexicalBlock(scope: !592, file: !26, line: 917, column: 5)
!597 = !DILocation(line: 919, column: 5, scope: !596)
!598 = !DILocation(line: 925, column: 28, scope: !519)
!599 = !DILocation(line: 925, column: 5, scope: !519)
!600 = !DILocation(line: 925, column: 15, scope: !519)
!601 = !DILocation(line: 925, column: 26, scope: !519)
!602 = !DILocation(line: 928, column: 36, scope: !603)
!603 = distinct !DILexicalBlock(scope: !519, file: !26, line: 927, column: 5)
!604 = !DILocation(line: 928, column: 9, scope: !603)
!605 = !DILocation(line: 928, column: 19, scope: !603)
!606 = !DILocation(line: 928, column: 34, scope: !603)
!607 = !DILocation(line: 932, column: 29, scope: !519)
!608 = !DILocation(line: 932, column: 39, scope: !519)
!609 = !DILocation(line: 932, column: 5, scope: !519)
!610 = !DILocation(line: 933, column: 29, scope: !519)
!611 = !DILocation(line: 933, column: 39, scope: !519)
!612 = !DILocation(line: 933, column: 5, scope: !519)
!613 = !DILocation(line: 937, column: 5, scope: !519)
!614 = !DILocation(line: 940, column: 5, scope: !519)
!615 = !DILocation(line: 941, column: 5, scope: !519)
!616 = !DILocation(line: 950, column: 18, scope: !617)
!617 = distinct !DILexicalBlock(scope: !519, file: !26, line: 948, column: 5)
!618 = !DILocation(line: 1013, column: 9, scope: !619)
!619 = distinct !DILexicalBlock(scope: !519, file: !26, line: 1013, column: 9)
!620 = !DILocation(line: 1013, column: 23, scope: !619)
!621 = !DILocation(line: 1013, column: 9, scope: !519)
!622 = !DILocation(line: 1017, column: 43, scope: !623)
!623 = distinct !DILexicalBlock(scope: !619, file: !26, line: 1014, column: 5)
!624 = !DILocation(line: 1017, column: 10, scope: !623)
!625 = !DILocation(line: 1017, column: 24, scope: !623)
!626 = !DILocation(line: 1018, column: 5, scope: !623)
!627 = !DILocation(line: 1023, column: 1, scope: !519)
!628 = distinct !DISubprogram(name: "prvAddNewTaskToReadyList", scope: !26, file: !26, line: 1026, type: !629, scopeLine: 1027, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !200)
!629 = !DISubroutineType(types: !630)
!630 = !{null, !24}
!631 = !DILocalVariable(name: "pxNewTCB", arg: 1, scope: !628, file: !26, line: 1026, type: !24)
!632 = !DILocation(line: 1026, column: 47, scope: !628)
!633 = !DILocation(line: 1030, column: 5, scope: !628)
!634 = !DILocation(line: 1032, column: 31, scope: !635)
!635 = distinct !DILexicalBlock(scope: !628, file: !26, line: 1031, column: 5)
!636 = !DILocation(line: 1034, column: 13, scope: !637)
!637 = distinct !DILexicalBlock(scope: !635, file: !26, line: 1034, column: 13)
!638 = !DILocation(line: 1034, column: 26, scope: !637)
!639 = !DILocation(line: 1034, column: 13, scope: !635)
!640 = !DILocation(line: 1038, column: 28, scope: !641)
!641 = distinct !DILexicalBlock(scope: !637, file: !26, line: 1035, column: 9)
!642 = !DILocation(line: 1038, column: 26, scope: !641)
!643 = !DILocation(line: 1040, column: 17, scope: !644)
!644 = distinct !DILexicalBlock(scope: !641, file: !26, line: 1040, column: 17)
!645 = !DILocation(line: 1040, column: 40, scope: !644)
!646 = !DILocation(line: 1040, column: 17, scope: !641)
!647 = !DILocation(line: 1045, column: 17, scope: !648)
!648 = distinct !DILexicalBlock(scope: !644, file: !26, line: 1041, column: 13)
!649 = !DILocation(line: 1046, column: 13, scope: !648)
!650 = !DILocation(line: 1051, column: 9, scope: !641)
!651 = !DILocation(line: 1057, column: 17, scope: !652)
!652 = distinct !DILexicalBlock(scope: !653, file: !26, line: 1057, column: 17)
!653 = distinct !DILexicalBlock(scope: !637, file: !26, line: 1053, column: 9)
!654 = !DILocation(line: 1057, column: 35, scope: !652)
!655 = !DILocation(line: 1057, column: 17, scope: !653)
!656 = !DILocation(line: 1059, column: 21, scope: !657)
!657 = distinct !DILexicalBlock(scope: !658, file: !26, line: 1059, column: 21)
!658 = distinct !DILexicalBlock(scope: !652, file: !26, line: 1058, column: 13)
!659 = !DILocation(line: 1059, column: 35, scope: !657)
!660 = !DILocation(line: 1059, column: 49, scope: !657)
!661 = !DILocation(line: 1059, column: 59, scope: !657)
!662 = !DILocation(line: 1059, column: 46, scope: !657)
!663 = !DILocation(line: 1059, column: 21, scope: !658)
!664 = !DILocation(line: 1061, column: 36, scope: !665)
!665 = distinct !DILexicalBlock(scope: !657, file: !26, line: 1060, column: 17)
!666 = !DILocation(line: 1061, column: 34, scope: !665)
!667 = !DILocation(line: 1062, column: 17, scope: !665)
!668 = !DILocation(line: 1067, column: 13, scope: !658)
!669 = !DILocation(line: 1074, column: 21, scope: !635)
!670 = !DILocation(line: 1079, column: 37, scope: !671)
!671 = distinct !DILexicalBlock(scope: !635, file: !26, line: 1077, column: 9)
!672 = !DILocation(line: 1079, column: 13, scope: !671)
!673 = !DILocation(line: 1079, column: 23, scope: !671)
!674 = !DILocation(line: 1079, column: 35, scope: !671)
!675 = !DILocation(line: 1086, column: 9, scope: !635)
!676 = !DILocation(line: 1088, column: 5, scope: !628)
!677 = !DILocation(line: 1090, column: 9, scope: !678)
!678 = distinct !DILexicalBlock(scope: !628, file: !26, line: 1090, column: 9)
!679 = !DILocation(line: 1090, column: 27, scope: !678)
!680 = !DILocation(line: 1090, column: 9, scope: !628)
!681 = !DILocation(line: 1094, column: 13, scope: !682)
!682 = distinct !DILexicalBlock(scope: !683, file: !26, line: 1094, column: 13)
!683 = distinct !DILexicalBlock(scope: !678, file: !26, line: 1091, column: 5)
!684 = !DILocation(line: 1094, column: 27, scope: !682)
!685 = !DILocation(line: 1094, column: 40, scope: !682)
!686 = !DILocation(line: 1094, column: 50, scope: !682)
!687 = !DILocation(line: 1094, column: 38, scope: !682)
!688 = !DILocation(line: 1094, column: 13, scope: !683)
!689 = !DILocation(line: 1096, column: 13, scope: !690)
!690 = distinct !DILexicalBlock(scope: !682, file: !26, line: 1095, column: 9)
!691 = !DILocation(line: 1097, column: 9, scope: !690)
!692 = !DILocation(line: 1102, column: 5, scope: !683)
!693 = !DILocation(line: 1107, column: 1, scope: !628)
!694 = distinct !DISubprogram(name: "prvInitialiseTaskLists", scope: !26, file: !26, line: 3657, type: !415, scopeLine: 3658, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !200)
!695 = !DILocalVariable(name: "uxPriority", scope: !694, file: !26, line: 3659, type: !53)
!696 = !DILocation(line: 3659, column: 17, scope: !694)
!697 = !DILocation(line: 3661, column: 21, scope: !698)
!698 = distinct !DILexicalBlock(scope: !694, file: !26, line: 3661, column: 5)
!699 = !DILocation(line: 3661, column: 10, scope: !698)
!700 = !DILocation(line: 3661, column: 43, scope: !701)
!701 = distinct !DILexicalBlock(scope: !698, file: !26, line: 3661, column: 5)
!702 = !DILocation(line: 3661, column: 54, scope: !701)
!703 = !DILocation(line: 3661, column: 5, scope: !698)
!704 = !DILocation(line: 3663, column: 48, scope: !705)
!705 = distinct !DILexicalBlock(scope: !701, file: !26, line: 3662, column: 5)
!706 = !DILocation(line: 3663, column: 29, scope: !705)
!707 = !DILocation(line: 3663, column: 9, scope: !705)
!708 = !DILocation(line: 3664, column: 5, scope: !705)
!709 = !DILocation(line: 3661, column: 104, scope: !701)
!710 = !DILocation(line: 3661, column: 5, scope: !701)
!711 = distinct !{!711, !703, !712}
!712 = !DILocation(line: 3664, column: 5, scope: !698)
!713 = !DILocation(line: 3666, column: 5, scope: !694)
!714 = !DILocation(line: 3667, column: 5, scope: !694)
!715 = !DILocation(line: 3668, column: 5, scope: !694)
!716 = !DILocation(line: 3672, column: 9, scope: !717)
!717 = distinct !DILexicalBlock(scope: !694, file: !26, line: 3671, column: 5)
!718 = !DILocation(line: 3678, column: 9, scope: !719)
!719 = distinct !DILexicalBlock(scope: !694, file: !26, line: 3677, column: 5)
!720 = !DILocation(line: 3684, column: 23, scope: !694)
!721 = !DILocation(line: 3685, column: 31, scope: !694)
!722 = !DILocation(line: 3686, column: 1, scope: !694)
!723 = distinct !DISubprogram(name: "xTaskCreate", scope: !26, file: !26, line: 721, type: !724, scopeLine: 727, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !200)
!724 = !DISubroutineType(types: !725)
!725 = !{!81, !522, !527, !528, !529, !53, !530}
!726 = !DILocalVariable(name: "pxTaskCode", arg: 1, scope: !723, file: !26, line: 721, type: !522)
!727 = !DILocation(line: 721, column: 44, scope: !723)
!728 = !DILocalVariable(name: "pcName", arg: 2, scope: !723, file: !26, line: 722, type: !527)
!729 = !DILocation(line: 722, column: 48, scope: !723)
!730 = !DILocalVariable(name: "usStackDepth", arg: 3, scope: !723, file: !26, line: 723, type: !528)
!731 = !DILocation(line: 723, column: 58, scope: !723)
!732 = !DILocalVariable(name: "pvParameters", arg: 4, scope: !723, file: !26, line: 724, type: !529)
!733 = !DILocation(line: 724, column: 42, scope: !723)
!734 = !DILocalVariable(name: "uxPriority", arg: 5, scope: !723, file: !26, line: 725, type: !53)
!735 = !DILocation(line: 725, column: 41, scope: !723)
!736 = !DILocalVariable(name: "pxCreatedTask", arg: 6, scope: !723, file: !26, line: 726, type: !530)
!737 = !DILocation(line: 726, column: 50, scope: !723)
!738 = !DILocalVariable(name: "pxNewTCB", scope: !723, file: !26, line: 728, type: !24)
!739 = !DILocation(line: 728, column: 17, scope: !723)
!740 = !DILocalVariable(name: "xReturn", scope: !723, file: !26, line: 729, type: !81)
!741 = !DILocation(line: 729, column: 20, scope: !723)
!742 = !DILocalVariable(name: "pxStack", scope: !743, file: !26, line: 760, type: !66)
!743 = distinct !DILexicalBlock(scope: !723, file: !26, line: 759, column: 9)
!744 = !DILocation(line: 760, column: 27, scope: !743)
!745 = !DILocation(line: 763, column: 57, scope: !743)
!746 = !DILocation(line: 763, column: 46, scope: !743)
!747 = !DILocation(line: 763, column: 72, scope: !743)
!748 = !DILocation(line: 763, column: 23, scope: !743)
!749 = !DILocation(line: 763, column: 21, scope: !743)
!750 = !DILocation(line: 765, column: 17, scope: !751)
!751 = distinct !DILexicalBlock(scope: !743, file: !26, line: 765, column: 17)
!752 = !DILocation(line: 765, column: 25, scope: !751)
!753 = !DILocation(line: 765, column: 17, scope: !743)
!754 = !DILocation(line: 768, column: 40, scope: !755)
!755 = distinct !DILexicalBlock(scope: !751, file: !26, line: 766, column: 13)
!756 = !DILocation(line: 768, column: 28, scope: !755)
!757 = !DILocation(line: 768, column: 26, scope: !755)
!758 = !DILocation(line: 770, column: 21, scope: !759)
!759 = distinct !DILexicalBlock(scope: !755, file: !26, line: 770, column: 21)
!760 = !DILocation(line: 770, column: 30, scope: !759)
!761 = !DILocation(line: 770, column: 21, scope: !755)
!762 = !DILocation(line: 772, column: 40, scope: !763)
!763 = distinct !DILexicalBlock(scope: !759, file: !26, line: 771, column: 17)
!764 = !DILocation(line: 772, column: 21, scope: !763)
!765 = !DILocation(line: 775, column: 41, scope: !763)
!766 = !DILocation(line: 775, column: 21, scope: !763)
!767 = !DILocation(line: 775, column: 31, scope: !763)
!768 = !DILocation(line: 775, column: 39, scope: !763)
!769 = !DILocation(line: 776, column: 17, scope: !763)
!770 = !DILocation(line: 781, column: 37, scope: !771)
!771 = distinct !DILexicalBlock(scope: !759, file: !26, line: 778, column: 17)
!772 = !DILocation(line: 781, column: 21, scope: !771)
!773 = !DILocation(line: 783, column: 13, scope: !755)
!774 = !DILocation(line: 786, column: 26, scope: !775)
!775 = distinct !DILexicalBlock(scope: !751, file: !26, line: 785, column: 13)
!776 = !DILocation(line: 791, column: 13, scope: !777)
!777 = distinct !DILexicalBlock(scope: !723, file: !26, line: 791, column: 13)
!778 = !DILocation(line: 791, column: 22, scope: !777)
!779 = !DILocation(line: 791, column: 13, scope: !723)
!780 = !DILocation(line: 797, column: 17, scope: !781)
!781 = distinct !DILexicalBlock(scope: !782, file: !26, line: 794, column: 13)
!782 = distinct !DILexicalBlock(scope: !777, file: !26, line: 792, column: 9)
!783 = !DILocation(line: 797, column: 27, scope: !781)
!784 = !DILocation(line: 797, column: 49, scope: !781)
!785 = !DILocation(line: 801, column: 35, scope: !782)
!786 = !DILocation(line: 801, column: 47, scope: !782)
!787 = !DILocation(line: 801, column: 68, scope: !782)
!788 = !DILocation(line: 801, column: 82, scope: !782)
!789 = !DILocation(line: 801, column: 96, scope: !782)
!790 = !DILocation(line: 801, column: 108, scope: !782)
!791 = !DILocation(line: 801, column: 123, scope: !782)
!792 = !DILocation(line: 801, column: 13, scope: !782)
!793 = !DILocation(line: 802, column: 39, scope: !782)
!794 = !DILocation(line: 802, column: 13, scope: !782)
!795 = !DILocation(line: 803, column: 21, scope: !782)
!796 = !DILocation(line: 804, column: 9, scope: !782)
!797 = !DILocation(line: 807, column: 21, scope: !798)
!798 = distinct !DILexicalBlock(scope: !777, file: !26, line: 806, column: 9)
!799 = !DILocation(line: 810, column: 16, scope: !723)
!800 = !DILocation(line: 810, column: 9, scope: !723)
!801 = distinct !DISubprogram(name: "xTaskCallApplicationTaskHook", scope: !26, file: !26, line: 2978, type: !802, scopeLine: 2980, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !200)
!802 = !DISubroutineType(types: !803)
!803 = !{!81, !107, !23}
!804 = !DILocalVariable(name: "xTask", arg: 1, scope: !801, file: !26, line: 2978, type: !107)
!805 = !DILocation(line: 2978, column: 59, scope: !801)
!806 = !DILocalVariable(name: "pvParameter", arg: 2, scope: !801, file: !26, line: 2979, type: !23)
!807 = !DILocation(line: 2979, column: 53, scope: !801)
!808 = !DILocalVariable(name: "xTCB", scope: !801, file: !26, line: 2981, type: !24)
!809 = !DILocation(line: 2981, column: 17, scope: !801)
!810 = !DILocalVariable(name: "xReturn", scope: !801, file: !26, line: 2982, type: !81)
!811 = !DILocation(line: 2982, column: 20, scope: !801)
!812 = !DILocation(line: 2985, column: 13, scope: !813)
!813 = distinct !DILexicalBlock(scope: !801, file: !26, line: 2985, column: 13)
!814 = !DILocation(line: 2985, column: 19, scope: !813)
!815 = !DILocation(line: 2985, column: 13, scope: !801)
!816 = !DILocation(line: 2987, column: 20, scope: !817)
!817 = distinct !DILexicalBlock(scope: !813, file: !26, line: 2986, column: 9)
!818 = !DILocation(line: 2987, column: 18, scope: !817)
!819 = !DILocation(line: 2988, column: 9, scope: !817)
!820 = !DILocation(line: 2991, column: 20, scope: !821)
!821 = distinct !DILexicalBlock(scope: !813, file: !26, line: 2990, column: 9)
!822 = !DILocation(line: 2991, column: 18, scope: !821)
!823 = !DILocation(line: 2994, column: 13, scope: !824)
!824 = distinct !DILexicalBlock(scope: !801, file: !26, line: 2994, column: 13)
!825 = !DILocation(line: 2994, column: 19, scope: !824)
!826 = !DILocation(line: 2994, column: 29, scope: !824)
!827 = !DILocation(line: 2994, column: 13, scope: !801)
!828 = !DILocation(line: 2996, column: 23, scope: !829)
!829 = distinct !DILexicalBlock(scope: !824, file: !26, line: 2995, column: 9)
!830 = !DILocation(line: 2996, column: 29, scope: !829)
!831 = !DILocation(line: 2996, column: 40, scope: !829)
!832 = !DILocation(line: 2996, column: 21, scope: !829)
!833 = !DILocation(line: 2997, column: 9, scope: !829)
!834 = !DILocation(line: 3000, column: 21, scope: !835)
!835 = distinct !DILexicalBlock(scope: !824, file: !26, line: 2999, column: 9)
!836 = !DILocation(line: 3003, column: 16, scope: !801)
!837 = !DILocation(line: 3003, column: 9, scope: !801)
!838 = distinct !DISubprogram(name: "assert", scope: !839, file: !839, line: 39, type: !840, scopeLine: 39, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !463, retainedNodes: !200)
!839 = !DIFile(filename: "./klee_help.h", directory: "/tmp/klee_src/freertos_10_5_1_test")
!840 = !DISubroutineType(types: !841)
!841 = !{null, !112}
!842 = !DILocalVariable(name: "condition", arg: 1, scope: !838, file: !839, line: 39, type: !112)
!843 = !DILocation(line: 39, column: 17, scope: !838)
!844 = !DILocation(line: 41, column: 1, scope: !838)
!845 = distinct !DISubprogram(name: "vTaskFunction1", scope: !464, file: !464, line: 14, type: !415, scopeLine: 14, spFlags: DISPFlagDefinition, unit: !463, retainedNodes: !200)
!846 = !DILocation(line: 15, column: 5, scope: !845)
!847 = !DILocation(line: 16, column: 1, scope: !845)
!848 = distinct !DISubprogram(name: "main", scope: !464, file: !464, line: 20, type: !849, scopeLine: 21, spFlags: DISPFlagDefinition, unit: !463, retainedNodes: !200)
!849 = !DISubroutineType(types: !850)
!850 = !{!112}
!851 = !DILocalVariable(name: "initial_xTask", scope: !848, file: !464, line: 22, type: !184)
!852 = !DILocation(line: 22, column: 18, scope: !848)
!853 = !DILocation(line: 23, column: 5, scope: !848)
!854 = !DILocalVariable(name: "KLEE_xTask", scope: !848, file: !464, line: 24, type: !184)
!855 = !DILocation(line: 24, column: 18, scope: !848)
!856 = !DILocation(line: 25, column: 37, scope: !848)
!857 = !DILocation(line: 25, column: 5, scope: !848)
!858 = !DILocalVariable(name: "KLEE_pvParameter", scope: !848, file: !464, line: 26, type: !23)
!859 = !DILocation(line: 26, column: 12, scope: !848)
!860 = !DILocation(line: 27, column: 37, scope: !848)
!861 = !DILocation(line: 27, column: 5, scope: !848)
!862 = !DILocalVariable(name: "KLEE_return_val", scope: !848, file: !464, line: 28, type: !81)
!863 = !DILocation(line: 28, column: 16, scope: !848)
!864 = !DILocation(line: 29, column: 37, scope: !848)
!865 = !DILocation(line: 29, column: 5, scope: !848)
!866 = !DILocation(line: 30, column: 56, scope: !848)
!867 = !DILocation(line: 30, column: 68, scope: !848)
!868 = !DILocation(line: 30, column: 23, scope: !848)
!869 = !DILocation(line: 30, column: 21, scope: !848)
!870 = !DILocation(line: 31, column: 5, scope: !848)
!871 = distinct !DISubprogram(name: "memset", scope: !872, file: !872, line: 12, type: !873, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !466, retainedNodes: !200)
!872 = !DIFile(filename: "runtime/Freestanding/memset.c", directory: "/home/klee/klee_src")
!873 = !DISubroutineType(types: !874)
!874 = !{!23, !23, !112, !875}
!875 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !876, line: 46, baseType: !35)
!876 = !DIFile(filename: "/tmp/llvm-110-install_O_D_A/lib/clang/11.0.0/include/stddef.h", directory: "")
!877 = !DILocalVariable(name: "dst", arg: 1, scope: !871, file: !872, line: 12, type: !23)
!878 = !DILocation(line: 12, column: 20, scope: !871)
!879 = !DILocalVariable(name: "s", arg: 2, scope: !871, file: !872, line: 12, type: !112)
!880 = !DILocation(line: 12, column: 29, scope: !871)
!881 = !DILocalVariable(name: "count", arg: 3, scope: !871, file: !872, line: 12, type: !875)
!882 = !DILocation(line: 12, column: 39, scope: !871)
!883 = !DILocalVariable(name: "a", scope: !871, file: !872, line: 13, type: !884)
!884 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !69, size: 64)
!885 = !DILocation(line: 13, column: 9, scope: !871)
!886 = !DILocation(line: 13, column: 13, scope: !871)
!887 = !DILocation(line: 14, column: 12, scope: !888)
!888 = distinct !DILexicalBlock(scope: !871, file: !872, line: 14, column: 7)
!889 = !DILocation(line: 14, column: 15, scope: !888)
!890 = !DILocation(line: 14, column: 7, scope: !871)
!891 = !DILocation(line: 15, column: 12, scope: !888)
!892 = !DILocation(line: 15, column: 7, scope: !888)
!893 = !DILocation(line: 15, column: 10, scope: !888)
!894 = !DILocation(line: 15, column: 5, scope: !888)
!895 = !DILocation(line: 16, column: 10, scope: !871)
!896 = !DILocation(line: 16, column: 3, scope: !871)
