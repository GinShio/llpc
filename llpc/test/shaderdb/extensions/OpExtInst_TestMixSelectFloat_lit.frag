// NOTE: Assertions have been autogenerated by tool/update_llpc_test_checks.py
// RUN: amdllpc -emit-lgc -o - %s | FileCheck -check-prefix=CHECK %s

#version 450

layout(binding = 0) uniform Uniforms
{
    float f1_1, f1_2;
    bool b1;

    vec3 f3_1, f3_2;
    bvec3 b3;
};

layout(location = 0) out vec4 fragColor;

void main()
{
    float f1_0 = mix(f1_1, f1_2, b1);

    vec3 f3_0 = mix(f3_1, f3_2, b3);

    fragColor = (f3_0.y == f1_0) ? vec4(0.0) : vec4(1.0);
}

// CHECK-LABEL: @lgc.shader.FS.main(
// CHECK-NEXT:  .entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call ptr addrspace(7) @lgc.load.buffer.desc(i64 0, i32 0, i32 0, i32 0)
// CHECK-NEXT:    [[TMP1:%.*]] = call ptr @llvm.invariant.start.p7(i64 -1, ptr addrspace(7) [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = load float, ptr addrspace(7) [[TMP0]], align 4
// CHECK-NEXT:    [[TMP3:%.*]] = getelementptr {{inbounds i8|<{ float, float, i32, [[]4 x i8], [[]3 x float], [[]4 x i8], [[]3 x float], [[]4 x i8], [[]3 x i32] }>|i8}}, ptr addrspace(7) [[TMP0]], i32 {{4|0, i32 1}}
// CHECK-NEXT:    [[TMP4:%.*]] = load float, ptr addrspace(7) [[TMP3]], align 4
// CHECK-NEXT:    [[TMP5:%.*]] = getelementptr {{inbounds i8|<{ float, float, i32, [[]4 x i8], [[]3 x float], [[]4 x i8], [[]3 x float], [[]4 x i8], [[]3 x i32] }>|i8}}, ptr addrspace(7) [[TMP0]], i32 {{8|0, i32 2}}
// CHECK-NEXT:    [[TMP6:%.*]] = load i32, ptr addrspace(7) [[TMP5]], align 4
// CHECK-NEXT:    [[DOTNOT:%.*]] = icmp eq i32 [[TMP6]], 0
// CHECK-NEXT:    [[TMP7:%.*]] = select reassoc nnan nsz arcp contract afn i1 [[DOTNOT]], float [[TMP2]], float [[TMP4]]
// CHECK-NEXT:    [[TMP8:%.*]] = getelementptr {{inbounds i8|<{ float, float, i32, [[]4 x i8], [[]3 x float], [[]4 x i8], [[]3 x float], [[]4 x i8], [[]3 x i32] }>|i8}}, ptr addrspace(7) [[TMP0]], i32 {{16|0, i32 4}}
// CHECK-NEXT:    [[TMP9:%.*]] = load <3 x float>, ptr addrspace(7) [[TMP8]], align 16
// CHECK-NEXT:    [[TMP10:%.*]] = getelementptr {{inbounds i8|<{ float, float, i32, [[]4 x i8], [[]3 x float], [[]4 x i8], [[]3 x float], [[]4 x i8], [[]3 x i32] }>|i8}}, ptr addrspace(7) [[TMP0]], i32 {{32|0, i32 6}}
// CHECK-NEXT:    [[TMP11:%.*]] = load <3 x float>, ptr addrspace(7) [[TMP10]], align 16
// CHECK-NEXT:    [[TMP12:%.*]] = getelementptr {{inbounds i8|<{ float, float, i32, [[]4 x i8], [[]3 x float], [[]4 x i8], [[]3 x float], [[]4 x i8], [[]3 x i32] }>|i8}}, ptr addrspace(7) [[TMP0]], i32 {{48|0, i32 8}}
// CHECK-NEXT:    [[TMP13:%.*]] = load <3 x i32>, ptr addrspace(7) [[TMP12]], align 16
// CHECK-NEXT:    [[TMP14:%.*]] = extractelement <3 x i32> [[TMP13]], i64 1
// CHECK-NEXT:    [[DOTNOT2:%.*]] = icmp eq i32 [[TMP14]], 0
// CHECK-NEXT:    [[TMP15:%.*]] = extractelement <3 x float> [[TMP11]], i64 1
// CHECK-NEXT:    [[TMP16:%.*]] = extractelement <3 x float> [[TMP9]], i64 1
// CHECK-NEXT:    [[TMP17:%.*]] = select reassoc nnan nsz arcp contract afn i1 [[DOTNOT2]], float [[TMP16]], float [[TMP15]]
// CHECK-NEXT:    [[TMP18:%.*]] = fcmp oeq float [[TMP17]], [[TMP7]]
// CHECK-NEXT:    [[TMP19:%.*]] = select reassoc nnan nsz arcp contract afn i1 [[TMP18]], <4 x float> zeroinitializer, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
// CHECK-NEXT:    call void (...) @lgc.create.write.generic.output(<4 x float> [[TMP19]], i32 0, i32 0, i32 0, i32 0, i32 0, i32 poison)
// CHECK-NEXT:    ret void
//
