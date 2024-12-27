; ModuleID = 'test.test.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.tskTaskControlBlock = type opaque

@.str = private unnamed_addr constant [14 x i8] c"xTaskToResume\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %xTaskToResume = alloca %struct.tskTaskControlBlock*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.tskTaskControlBlock** %xTaskToResume, metadata !11, metadata !DIExpression()), !dbg !16
  %0 = bitcast %struct.tskTaskControlBlock** %xTaskToResume to i8*, !dbg !17
  call void @klee_make_symbolic_controllable(i8* %0, i64 8, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str, i64 0, i64 0), i1 zeroext false), !dbg !18
  %1 = load %struct.tskTaskControlBlock*, %struct.tskTaskControlBlock** %xTaskToResume, align 8, !dbg !19
  %call = call i32 (%struct.tskTaskControlBlock*, ...) bitcast (i32 (...)* @MPU_vTaskSuspendImpl to i32 (%struct.tskTaskControlBlock*, ...)*)(%struct.tskTaskControlBlock* %1), !dbg !20
  ret i32 0, !dbg !21
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local void @klee_make_symbolic_controllable(i8*, i64, i8*, i1 zeroext) #2

declare dso_local i32 @MPU_vTaskSuspendImpl(...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @vTaskFunction1(i8* %pvParameters) #0 !dbg !22 {
entry:
  %pvParameters.addr = alloca i8*, align 8
  store i8* %pvParameters, i8** %pvParameters.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %pvParameters.addr, metadata !26, metadata !DIExpression()), !dbg !27
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 0), !dbg !28
  ret void, !dbg !29
}

declare dso_local i32 @assert(...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @portIS_TASK_PRIVILEGED() #0 !dbg !30 {
entry:
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 0), !dbg !33
  ret void, !dbg !34
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!3}
!llvm.module.flags = !{!4, !5, !6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 11.0.0 (https://github.com/llvm/llvm-project.git 60a25202a7dd1e00067fcfce512086ebf3788537)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test.c", directory: "/home/klee/FreeRTOS-Kernel-10.6.0/symbolic_execution/test_access_control")
!2 = !{}
!3 = !{!"clang version 11.0.0 (https://github.com/llvm/llvm-project.git 60a25202a7dd1e00067fcfce512086ebf3788537)"}
!4 = !{i32 7, !"Dwarf Version", i32 4}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 13, type: !8, scopeLine: 14, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "xTaskToResume", scope: !7, file: !1, line: 16, type: !12)
!12 = !DIDerivedType(tag: DW_TAG_typedef, name: "TaskHandle_t", file: !13, line: 92, baseType: !14)
!13 = !DIFile(filename: "include/task.h", directory: "/home/klee/FreeRTOS-Kernel-10.6.0")
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = !DICompositeType(tag: DW_TAG_structure_type, name: "tskTaskControlBlock", file: !13, line: 91, flags: DIFlagFwdDecl)
!16 = !DILocation(line: 16, column: 14, scope: !7)
!17 = !DILocation(line: 17, column: 33, scope: !7)
!18 = !DILocation(line: 17, column: 1, scope: !7)
!19 = !DILocation(line: 18, column: 22, scope: !7)
!20 = !DILocation(line: 18, column: 1, scope: !7)
!21 = !DILocation(line: 19, column: 1, scope: !7)
!22 = distinct !DISubprogram(name: "vTaskFunction1", scope: !1, file: !1, line: 21, type: !23, scopeLine: 22, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!23 = !DISubroutineType(types: !24)
!24 = !{null, !25}
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!26 = !DILocalVariable(name: "pvParameters", arg: 1, scope: !22, file: !1, line: 21, type: !25)
!27 = !DILocation(line: 21, column: 28, scope: !22)
!28 = !DILocation(line: 23, column: 5, scope: !22)
!29 = !DILocation(line: 24, column: 1, scope: !22)
!30 = distinct !DISubprogram(name: "portIS_TASK_PRIVILEGED", scope: !1, file: !1, line: 26, type: !31, scopeLine: 26, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!31 = !DISubroutineType(types: !32)
!32 = !{null}
!33 = !DILocation(line: 27, column: 5, scope: !30)
!34 = !DILocation(line: 28, column: 1, scope: !30)
