; RUN: llvm-as -opaque-pointers=1 %s -o %t.o
; RUN: llvm-lto2 run -lto-opaque-pointers -opaque-pointers -r %t.o,_start,px %t.o -o %t.s
; RUN: llvm-objdump -d %t.s.0 | FileCheck %s --check-prefix=CHECK-SMALL

target triple = "x86_64-unknown-linux-gnu"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"

!llvm.module.flags = !{!0, !1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"Code Model", i32 1}

@data = internal constant [0 x i32] []

define ptr @_start() nounwind readonly {
entry:
; CHECK-SMALL-LABEL:  <_start>:
; CHECK-SMALL: leaq    (%rip), %rax
    ret ptr @data
}
