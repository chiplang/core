// RUN: %clang_cc1 -O0 -cl-std=CL2.0 -triple amdgcn-amd-amdhsa -target-cpu gfx1100 -emit-llvm \
// RUN:   -verify -S -o - %s

// REQUIRES: amdgpu-registered-target

typedef int    v2i   __attribute__((ext_vector_type(2)));
typedef half   v8h   __attribute__((ext_vector_type(8)));
typedef short  v8s   __attribute__((ext_vector_type(8)));

typedef half   v4h   __attribute__((ext_vector_type(4)));
typedef short  v4s   __attribute__((ext_vector_type(4)));



void amdgcn_global_load_tr(global v2i* v2i_inptr, global v8s* v8s_inptr, global v8h* v8h_inptr,
                           global int* int_inptr, global v4s* v4s_inptr, global v4h* v4h_inptr)
{
  v2i out_1 = __builtin_amdgcn_global_load_tr_v2i32(v2i_inptr); // expected-error{{'__builtin_amdgcn_global_load_tr_v2i32' needs target feature gfx12-insts,wavefrontsize32}}
  v8s out_2 = __builtin_amdgcn_global_load_tr_v8i16(v8s_inptr); // expected-error{{'__builtin_amdgcn_global_load_tr_v8i16' needs target feature gfx12-insts,wavefrontsize32}}
  v8h out_3 = __builtin_amdgcn_global_load_tr_v8f16(v8h_inptr); // expected-error{{'__builtin_amdgcn_global_load_tr_v8f16' needs target feature gfx12-insts,wavefrontsize32}}

  int out_4 = __builtin_amdgcn_global_load_tr_i32(int_inptr); // expected-error{{'__builtin_amdgcn_global_load_tr_i32' needs target feature gfx12-insts,wavefrontsize64}}
  v4s out_5 = __builtin_amdgcn_global_load_tr_v4i16(v4s_inptr); // expected-error{{'__builtin_amdgcn_global_load_tr_v4i16' needs target feature gfx12-insts,wavefrontsize64}}
  v4h out_6 = __builtin_amdgcn_global_load_tr_v4f16(v4h_inptr); // expected-error{{'__builtin_amdgcn_global_load_tr_v4f16' needs target feature gfx12-insts,wavefrontsize64}}
}

