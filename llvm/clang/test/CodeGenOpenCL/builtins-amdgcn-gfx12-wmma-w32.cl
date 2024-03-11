// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: amdgpu-registered-target
// RUN: %clang_cc1 -triple amdgcn-unknown-unknown -target-cpu gfx1200 -target-feature +wavefrontsize32 -S -emit-llvm -o - %s | FileCheck %s --check-prefix=CHECK-GFX1200

typedef int    v2i   __attribute__((ext_vector_type(2)));
typedef float  v8f   __attribute__((ext_vector_type(8)));
typedef half   v8h   __attribute__((ext_vector_type(8)));
typedef short  v8s   __attribute__((ext_vector_type(8)));
typedef int    v8i   __attribute__((ext_vector_type(8)));

// Wave32

//
// amdgcn_wmma_f32_16x16x16_f16
//

// CHECK-GFX1200-LABEL: @test_amdgcn_wmma_f32_16x16x16_f16_w32(
// CHECK-GFX1200-NEXT:  entry:
// CHECK-GFX1200-NEXT:    [[TMP0:%.*]] = tail call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.f16.v8f32.v8f16(<8 x half> [[A:%.*]], <8 x half> [[B:%.*]], <8 x float> [[C:%.*]])
// CHECK-GFX1200-NEXT:    store <8 x float> [[TMP0]], ptr addrspace(1) [[OUT:%.*]], align 32, !tbaa [[TBAA4:![0-9]+]]
// CHECK-GFX1200-NEXT:    ret void
//
void test_amdgcn_wmma_f32_16x16x16_f16_w32(global v8f* out, v8h a, v8h b, v8f c)
{
  *out = __builtin_amdgcn_wmma_f32_16x16x16_f16_w32_gfx12(a, b, c);
}

//
// amdgcn_wmma_f32_16x16x16_bf16
//

// CHECK-GFX1200-LABEL: @test_amdgcn_wmma_f32_16x16x16_bf16_w32(
// CHECK-GFX1200-NEXT:  entry:
// CHECK-GFX1200-NEXT:    [[TMP0:%.*]] = tail call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.bf16.v8f32.v8i16(<8 x i16> [[A:%.*]], <8 x i16> [[B:%.*]], <8 x float> [[C:%.*]])
// CHECK-GFX1200-NEXT:    store <8 x float> [[TMP0]], ptr addrspace(1) [[OUT:%.*]], align 32, !tbaa [[TBAA4]]
// CHECK-GFX1200-NEXT:    ret void
//
void test_amdgcn_wmma_f32_16x16x16_bf16_w32(global v8f* out, v8s a, v8s b, v8f c)
{
  *out = __builtin_amdgcn_wmma_f32_16x16x16_bf16_w32_gfx12(a, b, c);
}

//
// amdgcn_wmma_f16_16x16x16_f16
//

// CHECK-GFX1200-LABEL: @test_amdgcn_wmma_f16_16x16x16_f16_w32(
// CHECK-GFX1200-NEXT:  entry:
// CHECK-GFX1200-NEXT:    [[TMP0:%.*]] = tail call <8 x half> @llvm.amdgcn.wmma.f16.16x16x16.f16.v8f16.v8f16(<8 x half> [[A:%.*]], <8 x half> [[B:%.*]], <8 x half> [[C:%.*]], i1 false)
// CHECK-GFX1200-NEXT:    store <8 x half> [[TMP0]], ptr addrspace(1) [[OUT:%.*]], align 16, !tbaa [[TBAA4]]
// CHECK-GFX1200-NEXT:    ret void
//
void test_amdgcn_wmma_f16_16x16x16_f16_w32(global v8h* out, v8h a, v8h b, v8h c)
{
  *out = __builtin_amdgcn_wmma_f16_16x16x16_f16_w32_gfx12(a, b, c);
}

//
// amdgcn_wmma_bf16_16x16x16_bf16
//

// CHECK-GFX1200-LABEL: @test_amdgcn_wmma_bf16_16x16x16_bf16_w32(
// CHECK-GFX1200-NEXT:  entry:
// CHECK-GFX1200-NEXT:    [[TMP0:%.*]] = tail call <8 x i16> @llvm.amdgcn.wmma.bf16.16x16x16.bf16.v8i16.v8i16(<8 x i16> [[A:%.*]], <8 x i16> [[B:%.*]], <8 x i16> [[C:%.*]], i1 false)
// CHECK-GFX1200-NEXT:    store <8 x i16> [[TMP0]], ptr addrspace(1) [[OUT:%.*]], align 16, !tbaa [[TBAA4]]
// CHECK-GFX1200-NEXT:    ret void
//
void test_amdgcn_wmma_bf16_16x16x16_bf16_w32(global v8s* out, v8s a, v8s b, v8s c)
{
  *out = __builtin_amdgcn_wmma_bf16_16x16x16_bf16_w32_gfx12(a, b, c);
}

//
// amdgcn_wmma_i32_16x16x16_iu8
//

// CHECK-GFX1200-LABEL: @test_amdgcn_wmma_i32_16x16x16_iu8_w32(
// CHECK-GFX1200-NEXT:  entry:
// CHECK-GFX1200-NEXT:    [[TMP0:%.*]] = tail call <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu8.v8i32.v2i32(i1 true, <2 x i32> [[A:%.*]], i1 true, <2 x i32> [[B:%.*]], <8 x i32> [[C:%.*]], i1 false)
// CHECK-GFX1200-NEXT:    store <8 x i32> [[TMP0]], ptr addrspace(1) [[OUT:%.*]], align 32, !tbaa [[TBAA4]]
// CHECK-GFX1200-NEXT:    ret void
//
void test_amdgcn_wmma_i32_16x16x16_iu8_w32(global v8i* out, v2i a, v2i b, v8i c)
{
  *out = __builtin_amdgcn_wmma_i32_16x16x16_iu8_w32_gfx12(true, a, true, b, c, false);
}

//
// amdgcn_wmma_i32_16x16x16_iu4
//

// CHECK-GFX1200-LABEL: @test_amdgcn_wmma_i32_16x16x16_iu4_w32(
// CHECK-GFX1200-NEXT:  entry:
// CHECK-GFX1200-NEXT:    [[TMP0:%.*]] = tail call <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu4.v8i32.i32(i1 true, i32 [[A:%.*]], i1 true, i32 [[B:%.*]], <8 x i32> [[C:%.*]], i1 false)
// CHECK-GFX1200-NEXT:    store <8 x i32> [[TMP0]], ptr addrspace(1) [[OUT:%.*]], align 32, !tbaa [[TBAA4]]
// CHECK-GFX1200-NEXT:    ret void
//
void test_amdgcn_wmma_i32_16x16x16_iu4_w32(global v8i* out, int a, int b, v8i c)
{
  *out = __builtin_amdgcn_wmma_i32_16x16x16_iu4_w32_gfx12(true, a, true, b, c, false);
}

// CHECK-GFX1200-LABEL: @test_amdgcn_wmma_f32_16x16x16_fp8_fp8_w32(
// CHECK-GFX1200-NEXT:  entry:
// CHECK-GFX1200-NEXT:    [[TMP0:%.*]] = tail call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.fp8.fp8.v8f32.v2i32(<2 x i32> [[A:%.*]], <2 x i32> [[B:%.*]], <8 x float> [[C:%.*]])
// CHECK-GFX1200-NEXT:    store <8 x float> [[TMP0]], ptr addrspace(1) [[OUT:%.*]], align 32, !tbaa [[TBAA4]]
// CHECK-GFX1200-NEXT:    ret void
//
void test_amdgcn_wmma_f32_16x16x16_fp8_fp8_w32(global v8f* out, v2i a, v2i b, v8f c)
{
  *out = __builtin_amdgcn_wmma_f32_16x16x16_fp8_fp8_w32_gfx12(a, b, c);
}

// CHECK-GFX1200-LABEL: @test_amdgcn_wmma_f32_16x16x16_fp8_bf8_w32(
// CHECK-GFX1200-NEXT:  entry:
// CHECK-GFX1200-NEXT:    [[TMP0:%.*]] = tail call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.fp8.bf8.v8f32.v2i32(<2 x i32> [[A:%.*]], <2 x i32> [[B:%.*]], <8 x float> [[C:%.*]])
// CHECK-GFX1200-NEXT:    store <8 x float> [[TMP0]], ptr addrspace(1) [[OUT:%.*]], align 32, !tbaa [[TBAA4]]
// CHECK-GFX1200-NEXT:    ret void
//
void test_amdgcn_wmma_f32_16x16x16_fp8_bf8_w32(global v8f* out, v2i a, v2i b, v8f c)
{
  *out = __builtin_amdgcn_wmma_f32_16x16x16_fp8_bf8_w32_gfx12(a, b, c);
}

// CHECK-GFX1200-LABEL: @test_amdgcn_wmma_f32_16x16x16_bf8_fp8_w32(
// CHECK-GFX1200-NEXT:  entry:
// CHECK-GFX1200-NEXT:    [[TMP0:%.*]] = tail call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.bf8.fp8.v8f32.v2i32(<2 x i32> [[A:%.*]], <2 x i32> [[B:%.*]], <8 x float> [[C:%.*]])
// CHECK-GFX1200-NEXT:    store <8 x float> [[TMP0]], ptr addrspace(1) [[OUT:%.*]], align 32, !tbaa [[TBAA4]]
// CHECK-GFX1200-NEXT:    ret void
//
void test_amdgcn_wmma_f32_16x16x16_bf8_fp8_w32(global v8f* out, v2i a, v2i b, v8f c)
{
  *out = __builtin_amdgcn_wmma_f32_16x16x16_bf8_fp8_w32_gfx12(a, b, c);
}

// CHECK-GFX1200-LABEL: @test_amdgcn_wmma_f32_16x16x16_bf8_bf8_w32(
// CHECK-GFX1200-NEXT:  entry:
// CHECK-GFX1200-NEXT:    [[TMP0:%.*]] = tail call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.bf8.bf8.v8f32.v2i32(<2 x i32> [[A:%.*]], <2 x i32> [[B:%.*]], <8 x float> [[C:%.*]])
// CHECK-GFX1200-NEXT:    store <8 x float> [[TMP0]], ptr addrspace(1) [[OUT:%.*]], align 32, !tbaa [[TBAA4]]
// CHECK-GFX1200-NEXT:    ret void
//
void test_amdgcn_wmma_f32_16x16x16_bf8_bf8_w32(global v8f* out, v2i a, v2i b, v8f c)
{
  *out = __builtin_amdgcn_wmma_f32_16x16x16_bf8_bf8_w32_gfx12(a, b, c);
}

// CHECK-GFX1200-LABEL: @test_amdgcn_wmma_i32_16x16x32_iu4_w32(
// CHECK-GFX1200-NEXT:  entry:
// CHECK-GFX1200-NEXT:    [[TMP0:%.*]] = tail call <8 x i32> @llvm.amdgcn.wmma.i32.16x16x32.iu4.v8i32.v2i32(i1 true, <2 x i32> [[A:%.*]], i1 true, <2 x i32> [[B:%.*]], <8 x i32> [[C:%.*]], i1 false)
// CHECK-GFX1200-NEXT:    store <8 x i32> [[TMP0]], ptr addrspace(1) [[OUT:%.*]], align 32, !tbaa [[TBAA4]]
// CHECK-GFX1200-NEXT:    ret void
//
void test_amdgcn_wmma_i32_16x16x32_iu4_w32(global v8i* out, v2i a, v2i b, v8i c)
{
  *out = __builtin_amdgcn_wmma_i32_16x16x32_iu4_w32_gfx12(true, a, true, b, c, false);
}
