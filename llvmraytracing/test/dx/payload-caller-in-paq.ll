; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function RayGen --version 3
; RUN: opt --verify-each -passes='dxil-cont-lgc-rt-op-converter,lint,lower-raytracing-pipeline,lint,inline,lint,remove-types-metadata' -S %s --lint-abort-on-error | FileCheck -check-prefix=LOWERRAYTRACINGPIPELINE %s

; Test the special case of payload import in the caller after TraceRay. Here, we cast the
; payload storage both to the ClosestHitOut layout and the MissOut layout and import both,
; skipping duplicate copies.
; This file was generated by compiling payload_caller_in_paq.ll.hlsl
; and manually adding some gpurt content at the end.
; Also, '@"\01?RayGen@@YAXXZ"' was renamed to '@RayGen' to match update_test_checks.py's
; function name regex.
; Note that the payload has nontrivial payload access qualifiers set.

target datalayout = "e-m:e-p:64:32-p20:32:32-p21:32:32-p32:32:32-i1:32-i8:8-i16:16-i32:32-i64:32-f16:16-f32:32-f64:32-v8:8-v16:16-v32:32-v48:32-v64:32-v80:32-v96:32-v112:32-v128:32-v144:32-v160:32-v176:32-v192:32-v208:32-v224:32-v240:32-v256:32-n8:16:32"

%dx.types.Handle = type { i8* }
%struct.MyPayload = type { float, i32, double }
%dx.types.ResourceProperties = type { i32, i32 }
%struct.DispatchSystemData = type { i32 }
%struct.TraversalData = type { %struct.SystemData, i64 }
%struct.SystemData = type { %struct.DispatchSystemData }
%struct.AnyHitTraversalData = type { %struct.TraversalData, %struct.HitData }
%struct.HitData = type { float, i32 }
%struct.BuiltInTriangleIntersectionAttributes = type { <2 x float> }
%struct.RaytracingAccelerationStructure = type { i32 }
%"class.RWTexture2D<vector<float, 4> >" = type { <4 x float> }

@"\01?myAccelerationStructure@@3URaytracingAccelerationStructure@@A" = external constant %dx.types.Handle, align 4
@"\01?gOutput@@3V?$RWTexture2D@V?$vector@M$03@@@@A" = external constant %dx.types.Handle, align 4

define void @_cont_ExitRayGen(ptr nocapture readonly %data) alwaysinline nounwind !pointeetys !{%struct.DispatchSystemData poison} {
  ret void
}

; Function Attrs: nounwind
define void @RayGen() #0 {
; LOWERRAYTRACINGPIPELINE-LABEL: define void @RayGen(
; LOWERRAYTRACINGPIPELINE-SAME: i64 [[RETURNADDR:%.*]], [[STRUCT_DISPATCHSYSTEMDATA:%.*]] [[TMP0:%.*]]) #[[ATTR0:[0-9]+]] !lgc.rt.shaderstage [[META23:![0-9]+]] !continuation.entry [[META13:![0-9]+]] !continuation.registercount [[META23]] !continuation [[META27:![0-9]+]] {
; LOWERRAYTRACINGPIPELINE-NEXT:    [[SYSTEM_DATA_ALLOCA:%.*]] = alloca [[STRUCT_DISPATCHSYSTEMDATA]], align 8
; LOWERRAYTRACINGPIPELINE-NEXT:    [[PAYLOAD_SERIALIZATION_ALLOCA:%.*]] = alloca [7 x i32], align 4
; LOWERRAYTRACINGPIPELINE-NEXT:    store [[STRUCT_DISPATCHSYSTEMDATA]] [[TMP0]], ptr [[SYSTEM_DATA_ALLOCA]], align 4
; LOWERRAYTRACINGPIPELINE-NEXT:    call void @amd.dx.setLocalRootIndex(i32 0)
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP2:%.*]] = load [[DX_TYPES_HANDLE:%.*]], ptr @"\01?myAccelerationStructure@@3URaytracingAccelerationStructure@@A", align 4
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP3:%.*]] = load [[DX_TYPES_HANDLE]], ptr @"\01?gOutput@@3V?$RWTexture2D@V?$vector@M$03@@@@A", align 4
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP4:%.*]] = alloca [[STRUCT_MYPAYLOAD:%.*]], align 8
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP5:%.*]] = bitcast ptr [[TMP4]] to ptr
; LOWERRAYTRACINGPIPELINE-NEXT:    call void @llvm.lifetime.start.p0(i64 16, ptr [[TMP5]]) #[[ATTR0]]
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [[STRUCT_MYPAYLOAD]], ptr [[TMP4]], i32 0, i32 0
; LOWERRAYTRACINGPIPELINE-NEXT:    store float 1.000000e+00, ptr [[TMP6]], align 8, !tbaa [[TBAA28:![0-9]+]]
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP7:%.*]] = call [[DX_TYPES_HANDLE]] @[[DX_OP_CREATEHANDLEFORLIB_DX_TYPES_HANDLE:[a-zA-Z0-9_$\"\\.-]*[a-zA-Z_$\"\\.-][a-zA-Z0-9_$\"\\.-]*]](i32 160, [[DX_TYPES_HANDLE]] [[TMP2]])
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP8:%.*]] = call [[DX_TYPES_HANDLE]] @[[DX_OP_ANNOTATEHANDLE:[a-zA-Z0-9_$\"\\.-]*[a-zA-Z_$\"\\.-][a-zA-Z0-9_$\"\\.-]*]](i32 216, [[DX_TYPES_HANDLE]] [[TMP7]], [[DX_TYPES_RESOURCEPROPERTIES:%.*]] { i32 16, i32 0 })
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP9:%.*]] = call i64 @amd.dx.getAccelStructAddr([[DX_TYPES_HANDLE]] [[TMP8]])
; LOWERRAYTRACINGPIPELINE-NEXT:    [[DIS_DATA_I:%.*]] = load [[STRUCT_DISPATCHSYSTEMDATA]], ptr [[SYSTEM_DATA_ALLOCA]], align 4
; LOWERRAYTRACINGPIPELINE-NEXT:    [[SYS_DATA_I:%.*]] = insertvalue [[STRUCT_SYSTEMDATA:%.*]] undef, [[STRUCT_DISPATCHSYSTEMDATA]] [[DIS_DATA_I]], 0
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TRAV_DATA_I:%.*]] = insertvalue [[STRUCT_TRAVERSALDATA:%.*]] undef, [[STRUCT_SYSTEMDATA]] [[SYS_DATA_I]], 0
; LOWERRAYTRACINGPIPELINE-NEXT:    [[ADDR_I:%.*]] = call i64 @_AmdGetResumePointAddr() #[[ATTR3:[0-9]+]]
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TRAV_DATA2_I:%.*]] = insertvalue [[STRUCT_TRAVERSALDATA]] [[TRAV_DATA_I]], i64 [[ADDR_I]], 1
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP10:%.*]] = getelementptr inbounds [[STRUCT_MYPAYLOAD]], ptr [[TMP4]], i32 0, i32 0
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP33:%.*]] = load i32, ptr [[TMP10]], align 4
; LOWERRAYTRACINGPIPELINE-NEXT:    store i32 [[TMP33]], ptr [[PAYLOAD_SERIALIZATION_ALLOCA]], align 4
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP12:%.*]] = load [1 x i32], ptr [[PAYLOAD_SERIALIZATION_ALLOCA]], align 4
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP20:%.*]] = call { [[STRUCT_DISPATCHSYSTEMDATA]], [12 x i32], [3 x i32] } (...) @lgc.cps.await__sl_s_struct.DispatchSystemDatasa12i32a3i32s(i64 4, i32 8, i64 poison, [[STRUCT_TRAVERSALDATA]] [[TRAV_DATA2_I]], [10 x i32] poison, [1 x i32] [[TMP12]]), !continuation.registercount [[META32:![0-9]+]], !waitmask [[META13]], !continuation.returnedRegistercount [[META25:![0-9]+]]
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP15:%.*]] = extractvalue { [[STRUCT_DISPATCHSYSTEMDATA]], [12 x i32], [3 x i32] } [[TMP20]], 2
; LOWERRAYTRACINGPIPELINE-NEXT:    store [3 x i32] [[TMP15]], ptr [[PAYLOAD_SERIALIZATION_ALLOCA]], align 4
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP27:%.*]] = freeze [[STRUCT_MYPAYLOAD]] poison
; LOWERRAYTRACINGPIPELINE-NEXT:    store [[STRUCT_MYPAYLOAD]] [[TMP27]], ptr [[TMP4]], align 4
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP14:%.*]] = getelementptr inbounds [[STRUCT_MYPAYLOAD]], ptr [[TMP4]], i32 0, i32 0
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP19:%.*]] = load i32, ptr [[PAYLOAD_SERIALIZATION_ALLOCA]], align 4
; LOWERRAYTRACINGPIPELINE-NEXT:    store i32 [[TMP19]], ptr [[TMP14]], align 4
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP16:%.*]] = getelementptr inbounds [[STRUCT_MYPAYLOAD]], ptr [[TMP4]], i32 0, i32 1
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP24:%.*]] = getelementptr inbounds i32, ptr [[PAYLOAD_SERIALIZATION_ALLOCA]], i32 1
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP38:%.*]] = load i32, ptr [[TMP24]], align 4
; LOWERRAYTRACINGPIPELINE-NEXT:    store i32 [[TMP38]], ptr [[TMP16]], align 4
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP18:%.*]] = getelementptr inbounds [[STRUCT_MYPAYLOAD]], ptr [[TMP4]], i32 0, i32 2
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP26:%.*]] = getelementptr inbounds i32, ptr [[PAYLOAD_SERIALIZATION_ALLOCA]], i32 1
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP21:%.*]] = load i32, ptr [[TMP26]], align 4
; LOWERRAYTRACINGPIPELINE-NEXT:    store i32 [[TMP21]], ptr [[TMP18]], align 4
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP22:%.*]] = getelementptr inbounds i32, ptr [[TMP18]], i32 1
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP25:%.*]] = getelementptr inbounds i32, ptr [[TMP26]], i32 1
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP23:%.*]] = load i32, ptr [[TMP25]], align 4
; LOWERRAYTRACINGPIPELINE-NEXT:    store i32 [[TMP23]], ptr [[TMP22]], align 4
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP13:%.*]] = extractvalue { [[STRUCT_DISPATCHSYSTEMDATA]], [12 x i32], [3 x i32] } [[TMP20]], 0
; LOWERRAYTRACINGPIPELINE-NEXT:    store [[STRUCT_DISPATCHSYSTEMDATA]] [[TMP13]], ptr [[SYSTEM_DATA_ALLOCA]], align 4
; LOWERRAYTRACINGPIPELINE-NEXT:    call void @amd.dx.setLocalRootIndex(i32 0)
; LOWERRAYTRACINGPIPELINE-NEXT:    br label [[DOTSPLIT:%.*]]
; LOWERRAYTRACINGPIPELINE:       .split:
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP42:%.*]] = load float, ptr [[TMP6]], align 8, !tbaa [[TBAA28]]
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP43:%.*]] = getelementptr inbounds [[STRUCT_MYPAYLOAD]], ptr [[TMP4]], i32 0, i32 1
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP44:%.*]] = load i32, ptr [[TMP43]], align 4, !tbaa [[TBAA33:![0-9]+]]
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP45:%.*]] = sitofp i32 [[TMP44]] to float
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP46:%.*]] = getelementptr inbounds [[STRUCT_MYPAYLOAD]], ptr [[TMP4]], i32 0, i32 2
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP47:%.*]] = load double, ptr [[TMP46]], align 8, !tbaa [[TBAA35:![0-9]+]]
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP48:%.*]] = fptrunc double [[TMP47]] to float
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP49:%.*]] = call <3 x i32> @lgc.rt.dispatch.rays.index()
; LOWERRAYTRACINGPIPELINE-NEXT:    [[EXTRACT:%.*]] = extractelement <3 x i32> [[TMP49]], i8 0
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP50:%.*]] = call <3 x i32> @lgc.rt.dispatch.rays.index()
; LOWERRAYTRACINGPIPELINE-NEXT:    [[EXTRACT1:%.*]] = extractelement <3 x i32> [[TMP50]], i8 1
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP37:%.*]] = call [[DX_TYPES_HANDLE]] @[[DX_OP_CREATEHANDLEFORLIB_DX_TYPES_HANDLE]](i32 160, [[DX_TYPES_HANDLE]] [[TMP3]])
; LOWERRAYTRACINGPIPELINE-NEXT:    [[TMP52:%.*]] = call [[DX_TYPES_HANDLE]] @[[DX_OP_ANNOTATEHANDLE]](i32 216, [[DX_TYPES_HANDLE]] [[TMP37]], [[DX_TYPES_RESOURCEPROPERTIES]] { i32 4098, i32 1033 })
; LOWERRAYTRACINGPIPELINE-NEXT:    call void @dx.op.textureStore.f32(i32 67, [[DX_TYPES_HANDLE]] [[TMP52]], i32 [[EXTRACT]], i32 [[EXTRACT1]], i32 undef, float [[TMP42]], float [[TMP45]], float [[TMP48]], float 0.000000e+00, i8 15)
; LOWERRAYTRACINGPIPELINE-NEXT:    call void @llvm.lifetime.end.p0(i64 16, ptr [[TMP5]]) #[[ATTR0]]
; LOWERRAYTRACINGPIPELINE-NEXT:    call void @lgc.cps.complete()
; LOWERRAYTRACINGPIPELINE-NEXT:    unreachable
;
  %1 = load %dx.types.Handle, %dx.types.Handle* @"\01?myAccelerationStructure@@3URaytracingAccelerationStructure@@A", align 4
  %2 = load %dx.types.Handle, %dx.types.Handle* @"\01?gOutput@@3V?$RWTexture2D@V?$vector@M$03@@@@A", align 4
  %3 = alloca %struct.MyPayload, align 8
  %4 = bitcast %struct.MyPayload* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* %4) #0
  %5 = getelementptr inbounds %struct.MyPayload, %struct.MyPayload* %3, i32 0, i32 0
  store float 1.000000e+00, float* %5, align 8, !tbaa !24
  %6 = call %dx.types.Handle @dx.op.createHandleForLib.dx.types.Handle(i32 160, %dx.types.Handle %1)
  %7 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %6, %dx.types.ResourceProperties { i32 16, i32 0 })
  call void @dx.op.traceRay.struct.MyPayload(i32 157, %dx.types.Handle %7, i32 0, i32 0, i32 0, i32 0, i32 0, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 1.000000e+00, %struct.MyPayload* nonnull %3)
  %8 = load float, float* %5, align 8, !tbaa !24
  %9 = getelementptr inbounds %struct.MyPayload, %struct.MyPayload* %3, i32 0, i32 1
  %10 = load i32, i32* %9, align 4, !tbaa !28
  %11 = sitofp i32 %10 to float
  %12 = getelementptr inbounds %struct.MyPayload, %struct.MyPayload* %3, i32 0, i32 2
  %13 = load double, double* %12, align 8, !tbaa !30
  %14 = fptrunc double %13 to float
  %15 = call i32 @dx.op.dispatchRaysIndex.i32(i32 145, i8 0)
  %16 = call i32 @dx.op.dispatchRaysIndex.i32(i32 145, i8 1)
  %17 = call %dx.types.Handle @dx.op.createHandleForLib.dx.types.Handle(i32 160, %dx.types.Handle %2)
  %18 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %17, %dx.types.ResourceProperties { i32 4098, i32 1033 })
  call void @dx.op.textureStore.f32(i32 67, %dx.types.Handle %18, i32 %15, i32 %16, i32 undef, float %8, float %11, float %14, float 0.000000e+00, i8 15)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* %4) #0
  ret void
}

; Function Attrs: nounwind
declare !pointeetys !32 void @dx.op.traceRay.struct.MyPayload(i32, %dx.types.Handle, i32, i32, i32, i32, i32, float, float, float, float, float, float, float, float, %struct.MyPayload*) #0

; Function Attrs: nounwind
declare void @dx.op.textureStore.f32(i32, %dx.types.Handle, i32, i32, i32, float, float, float, float, i8) #0

; Function Attrs: nounwind memory(none)
declare i32 @dx.op.dispatchRaysIndex.i32(i32, i8) #1

; Function Attrs: nounwind memory(none)
declare %dx.types.Handle @dx.op.annotateHandle(i32, %dx.types.Handle, %dx.types.ResourceProperties) #1

; Function Attrs: nounwind memory(read)
declare %dx.types.Handle @dx.op.createHandleForLib.dx.types.Handle(i32, %dx.types.Handle) #2

; Function Attrs: alwaysinline
declare %struct.DispatchSystemData @_AmdWaitAwaitTraversal(i64, i64, %struct.TraversalData) #3

; Function Attrs: alwaysinline
declare %struct.DispatchSystemData @_AmdAwaitShader(i64, %struct.DispatchSystemData) #3

; Function Attrs: alwaysinline
declare %struct.AnyHitTraversalData @_AmdAwaitAnyHit(i64, %struct.AnyHitTraversalData, float, i32) #3

; Function Attrs: alwaysinline
declare !pointeetys !34 %struct.BuiltInTriangleIntersectionAttributes @_cont_GetTriangleHitAttributes(%struct.SystemData*) #3

; Function Attrs: nounwind memory(read)
declare !pointeetys !36 <3 x i32> @_cont_DispatchRaysIndex3(%struct.DispatchSystemData* nocapture readnone) #2

; Function Attrs: alwaysinline
declare !pointeetys !38 void @_cont_SetTriangleHitAttributes(%struct.SystemData*, %struct.BuiltInTriangleIntersectionAttributes) #3

; Function Attrs: alwaysinline
declare !pointeetys !39 i1 @_cont_IsEndSearch(%struct.TraversalData*) #3

; Function Attrs: nounwind memory(read)
declare !pointeetys !41 i32 @_cont_HitKind(%struct.SystemData* nocapture readnone, %struct.HitData*) #2

declare !pointeetys !50 i1 @_cont_ReportHit(%struct.AnyHitTraversalData* %data, float %t, i32 %hitKind)

; Function Attrs: nounwind memory(none)
declare !pointeetys !43 void @_AmdRestoreSystemData(%struct.DispatchSystemData*) #1

; Function Attrs: nounwind memory(none)
declare !pointeetys !44 void @_AmdRestoreSystemDataAnyHit(%struct.AnyHitTraversalData*) #1

; Function Attrs: nounwind
declare i64 @_AmdGetResumePointAddr() #3

; Function Attrs: alwaysinline
define i32 @_cont_GetLocalRootIndex(%struct.DispatchSystemData* %data) #3 !pointeetys !46 {
  ret i32 5
}

; Function Attrs: alwaysinline
define void @_cont_TraceRay(%struct.DispatchSystemData* %data, i64 %0, i32 %1, i32 %2, i32 %3, i32 %4, i32 %5, float %6, float %7, float %8, float %9, float %10, float %11, float %12, float %13) #3 !pointeetys !47 {
  %dis_data = load %struct.DispatchSystemData, %struct.DispatchSystemData* %data, align 4
  %sys_data = insertvalue %struct.SystemData undef, %struct.DispatchSystemData %dis_data, 0
  %trav_data = insertvalue %struct.TraversalData undef, %struct.SystemData %sys_data, 0
  %addr = call i64 @_AmdGetResumePointAddr() #3
  %trav_data2 = insertvalue %struct.TraversalData %trav_data, i64 %addr, 1
  %newdata = call %struct.DispatchSystemData @_AmdWaitAwaitTraversal(i64 4, i64 -1, %struct.TraversalData %trav_data2)
  store %struct.DispatchSystemData %newdata, %struct.DispatchSystemData* %data, align 4
  call void @_AmdRestoreSystemData(%struct.DispatchSystemData* %data)
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare !pointeetys !48 void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare !pointeetys !48 void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #4

attributes #0 = { nounwind }
attributes #1 = { nounwind memory(none) }
attributes #2 = { nounwind memory(read) }
attributes #3 = { alwaysinline }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!1}
!dx.shaderModel = !{!2}
!dx.resources = !{!3}
!dx.typeAnnotations = !{!10}
!dx.dxrPayloadAnnotations = !{!14}
!dx.entryPoints = !{!19, !21}

!0 = !{!"dxcoob 2019.05.00"}
!1 = !{i32 1, i32 7}
!2 = !{!"lib", i32 6, i32 7}
!3 = !{!4, !7, null, null}
!4 = !{!5}
!5 = !{i32 0, %struct.RaytracingAccelerationStructure* bitcast (%dx.types.Handle* @"\01?myAccelerationStructure@@3URaytracingAccelerationStructure@@A" to %struct.RaytracingAccelerationStructure*), !"myAccelerationStructure", i32 0, i32 3, i32 1, i32 16, i32 0, !6}
!6 = !{i32 0, i32 4}
!7 = !{!8}
!8 = !{i32 0, %"class.RWTexture2D<vector<float, 4> >"* bitcast (%dx.types.Handle* @"\01?gOutput@@3V?$RWTexture2D@V?$vector@M$03@@@@A" to %"class.RWTexture2D<vector<float, 4> >"*), !"gOutput", i32 0, i32 0, i32 1, i32 2, i1 false, i1 false, i1 false, !9}
!9 = !{i32 0, i32 9}
!10 = !{i32 1, void ()* @RayGen, !11}
!11 = !{!12}
!12 = !{i32 1, !13, !13}
!13 = !{}
!14 = !{i32 0, %struct.MyPayload undef, !15}
!15 = !{!16, !17, !18}
!16 = !{i32 0, i32 3}
!17 = !{i32 0, i32 33}
!18 = !{i32 0, i32 513}
!19 = !{null, !"", null, !3, !20}
!20 = !{i32 0, i64 65540}
!21 = !{void ()* @RayGen, !"RayGen", null, null, !22}
!22 = !{i32 8, i32 7, i32 5, !23}
!23 = !{i32 0}
!24 = !{!25, !25, i64 0}
!25 = !{!"float", !26, i64 0}
!26 = !{!"omnipotent char", !27, i64 0}
!27 = !{!"Simple C/C++ TBAA"}
!28 = !{!29, !29, i64 0}
!29 = !{!"int", !26, i64 0}
!30 = !{!31, !31, i64 0}
!31 = !{!"double", !26, i64 0}
!32 = !{%struct.MyPayload poison}
!33 = !{i32 0, %struct.MyPayload poison}
!34 = !{%struct.SystemData poison}
!35 = !{i32 0, %struct.SystemData poison}
!36 = !{%struct.DispatchSystemData poison}
!37 = !{i32 0, %struct.DispatchSystemData poison}
!38 = !{%struct.SystemData poison}
!39 = !{%struct.TraversalData poison}
!40 = !{i32 0, %struct.TraversalData poison}
!41 = !{null, %struct.SystemData poison, %struct.HitData poison}
!42 = !{i32 0, %struct.HitData poison}
!43 = !{%struct.DispatchSystemData poison}
!44 = !{%struct.AnyHitTraversalData poison}
!45 = !{i32 0, %struct.AnyHitTraversalData poison}
!46 = !{%struct.DispatchSystemData poison}
!47 = !{%struct.DispatchSystemData poison}
!48 = !{i8 poison}
!49 = !{i32 0, i8 poison}
!50 = !{%struct.AnyHitTraversalData poison}
