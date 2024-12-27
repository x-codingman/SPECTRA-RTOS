; ModuleID = 'test.test.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.tskTaskControlBlock = type opaque

@.str = private unnamed_addr constant [6 x i8] c"Task1\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"xTaskToResume\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !9 {
entry:
  %retval = alloca i32, align 4
  %xTaskToResume = alloca %struct.tskTaskControlBlock*, align 8
  store i32 0, i32* %retval, align 4
  %call = call i64 @xTaskCreate(void (i8*)* @vTaskFunction1, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i64 0, i64 0), i16 zeroext 200, i8* null, i64 1, %struct.tskTaskControlBlock** null), !dbg !13
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTaskToResume, metadata !14, metadata !DIExpression()), !dbg !19
  %0 = bitcast %struct.tskTaskControlBlock** %xTaskToResume to i8*, !dbg !20
  call void @klee_make_symbolic_controllable(i8* %0, i64 8, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i1 zeroext false), !dbg !21
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToResume, align 8, !dbg !22
  %call1 = call i32 (%struct.tskTaskControlBlock*, ...) bitcast (i32 (...)* @MPU_vTaskSuspendImpl to i32 (%struct.tskTaskControlBlock*, ...)*)(%struct.tskTaskControlBlock* %1), !dbg !23
  ret i32 0, !dbg !24
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @vTaskFunction1(i8* %pvParameters) #0 !dbg !25 {
entry:
  %pvParameters.addr = alloca i8*, align 8
  store i8* %pvParameters, i8** %pvParameters.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvParameters.addr, metadata !28, metadata !DIExpression()), !dbg !29
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 0), !dbg !30
  ret void, !dbg !31
}

declare dso_local i64 @xTaskCreate(void (i8*)*, i8*, i16 zeroext, i8*, i64, %struct.tskTaskControlBlock**) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

declare dso_local void @klee_make_symbolic_controllable(i8*, i64, i8*, i1 zeroext) #1

declare dso_local i32 @MPU_vTaskSuspendImpl(...) #1

declare dso_local i32 @assert(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @portIS_TASK_PRIVILEGED() #0 !dbg !32 {
entry:
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 0), !dbg !35
  ret void, !dbg !36
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!5}
!llvm.module.flags = !{!6, !7, !8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 11.0.0 (https://github.com/llvm/llvm-project.git 60a25202a7dd1e00067fcfce512086ebf3788537)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test.c", directory: "/home/klee/FreeRTOS-Kernel-10.6.0/symbolic_execution/test_access_control")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{!"clang version 11.0.0 (https://github.com/llvm/llvm-project.git 60a25202a7dd1e00067fcfce512086ebf3788537)"}
!6 = !{i32 7, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 13, type: !10, scopeLine: 14, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocation(line: 15, column: 1, scope: !9)
!14 = !DILocalVariable(name: "xTaskToResume", scope: !9, file: !1, line: 16, type: !15)
!15 = !DIDerivedType(tag: DW_TAG_typedef, name: "TaskHandle_t", file: !16, line: 92, baseType: !17)
!16 = !DIFile(filename: "include/task.h", directory: "/home/klee/FreeRTOS-Kernel-10.6.0")
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = !DICompositeType(tag: DW_TAG_structure_type, name: "tskTaskControlBlock", file: !16, line: 91, flags: DIFlagFwdDecl)
!19 = !DILocation(line: 16, column: 14, scope: !9)
!20 = !DILocation(line: 17, column: 33, scope: !9)
!21 = !DILocation(line: 17, column: 1, scope: !9)
!22 = !DILocation(line: 18, column: 22, scope: !9)
!23 = !DILocation(line: 18, column: 1, scope: !9)
!24 = !DILocation(line: 19, column: 1, scope: !9)
!25 = distinct !DISubprogram(name: "vTaskFunction1", scope: !1, file: !1, line: 21, type: !26, scopeLine: 22, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!26 = !DISubroutineType(types: !27)
!27 = !{null, !4}
!28 = !DILocalVariable(name: "pvParameters", arg: 1, scope: !25, file: !1, line: 21, type: !4)
!29 = !DILocation(line: 21, column: 28, scope: !25)
!30 = !DILocation(line: 23, column: 5, scope: !25)
!31 = !DILocation(line: 24, column: 1, scope: !25)
!32 = distinct !DISubprogram(name: "portIS_TASK_PRIVILEGED", scope: !1, file: !1, line: 26, type: !33, scopeLine: 26, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!33 = !DISubroutineType(types: !34)
!34 = !{null}
!35 = !DILocation(line: 27, column: 5, scope: !32)
!36 = !DILocation(line: 28, column: 1, scope: !32)
