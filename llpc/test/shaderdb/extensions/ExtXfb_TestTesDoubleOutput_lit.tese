#version 450 core

layout(triangles) in;

layout(location = 0) in dvec4 fIn[];
layout(location = 0, xfb_buffer = 1, xfb_offset = 24) out dvec3 fOut1;
layout(location = 2, xfb_buffer = 0, xfb_offset = 16) out dvec2 fOut2;

void main(void)
{
    fOut1 = fIn[0].xyz + fIn[1].xyz + fIn[2].xyz;
    fOut2 = fIn[0].xy + fIn[1].xy + fIn[2].xy;
}
// BEGIN_SHADERTEST
/*
; RUN: amdllpc -v %gfxip %s | FileCheck -check-prefix=SHADERTEST %s
; SHADERTEST-LABEL: {{^// LLPC}} SPIRV-to-LLVM translation results
; SHADERTEST-LABEL: {{^// LLPC}} SPIR-V lowering results
; SHADERTEST: call void (...) @lgc.write.xfb.output({{.*}}<3 x double>
; SHADERTEST: call void @lgc.output.export.generic{{.*}}v3f64
; SHADERTEST: call void (...) @lgc.write.xfb.output({{.*}}<2 x double>
; SHADERTEST: call void @lgc.output.export.generic{{.*}}v2f64
; SHADERTEST: .vgt_strmout_buffer_config:
; SHADERTEST:   .stream_0_buffer_en: 0x0000000000000003
; SHADERTEST:   .stream_1_buffer_en: 0x0000000000000000
; SHADERTEST:   .stream_2_buffer_en: 0x0000000000000000
; SHADERTEST:   .stream_3_buffer_en: 0x0000000000000000
; SHADERTEST: AMDLLPC SUCCESS
*/
// END_SHADERTEST
