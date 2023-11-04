

/* Support for floating point constants */
typedef ulong ConstantDoubleTy;
typedef uint ConstantFloatTy;
typedef struct { ulong f1; ushort f2; ushort pad[3]; } ConstantFP80Ty;
typedef struct { ulong f1; ulong f2; } ConstantFP128Ty;


/* OpenCL Pragmas */
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
#pragma OPENCL EXTENSION cl_khr_int64_base_atomics : enable
#pragma OPENCL EXTENSION cl_khr_int64_extended_atomics : enable


/* Global Declarations */
/* Helper union for bitcasts */
typedef union {
  uint Int32;
  ulong Int64;
  float Float;
  double Double;
} llvmBitCastUnion;

/* Types Declarations */

/* Types Definitions */
struct l_array_10_uint {
  uint array[10];
};
struct l_array_100_uint {
  uint array[100];
};
struct l_vector_10_uint {
  uint vector[10];
} __attribute__((aligned(64)));
struct l_vector_100_uint {
  uint vector[100];
} __attribute__((aligned(512)));

/* Function definitions */

/* Function Declarations */
__kernel 
void/* Processing Function: _Z15binary_encodingPu11matrix_typeILm1ELm10EiEmPu11matrix_typeILm10ELm10EiEmS0_m_loop_header_reorder_c_opencl_c_c_c: 0*/
 _Z15binary_encodingPu11matrix_typeILm1ELm10EiEmPu11matrix_typeILm10ELm10EiEmS0_m_loop_header_reorder_c_opencl_c_c_c(__global struct l_array_10_uint*, ulong, __global struct l_array_100_uint*, ulong, __global struct l_array_10_uint*, ulong);
ulong/* Processing Function: get_global_id: 0*/
 get_global_id(uint);
ulong/* Processing Function: get_global_size: 0*/
 get_global_size(uint);
__kernel 
void/* Processing Function: _Z15binary_encodingPu11matrix_typeILm1ELm10EiEmPu11matrix_typeILm10ELm10EiEmS0_m_loop_header15_reorder_c_opencl_c_c: 0*/
 _Z15binary_encodingPu11matrix_typeILm1ELm10EiEmPu11matrix_typeILm10ELm10EiEmS0_m_loop_header15_reorder_c_opencl_c_c(__global struct l_array_10_uint*, ulong);


/* LLVM Intrinsic Builtin Function Bodies */
static __forceinline int llvm_fcmp_ord(double X, double Y) { return X == X && Y == Y; }
static __forceinline int llvm_fcmp_uno(double X, double Y) { return X != X || Y != Y; }
static __forceinline int llvm_fcmp_ueq(double X, double Y) { return X == Y || llvm_fcmp_uno(X, Y); }
static __forceinline int llvm_fcmp_une(double X, double Y) { return X != Y; }
static __forceinline int llvm_fcmp_ult(double X, double Y) { return X <  Y || llvm_fcmp_uno(X, Y); }
static __forceinline int llvm_fcmp_ugt(double X, double Y) { return X >  Y || llvm_fcmp_uno(X, Y); }
static __forceinline int llvm_fcmp_ule(double X, double Y) { return X <= Y || llvm_fcmp_uno(X, Y); }
static __forceinline int llvm_fcmp_uge(double X, double Y) { return X >= Y || llvm_fcmp_uno(X, Y); }
static __forceinline int llvm_fcmp_oeq(double X, double Y) { return X == Y ; }
static __forceinline int llvm_fcmp_one(double X, double Y) { return X != Y && llvm_fcmp_ord(X, Y); }
static __forceinline int llvm_fcmp_olt(double X, double Y) { return X <  Y ; }
static __forceinline int llvm_fcmp_ogt(double X, double Y) { return X >  Y ; }
static __forceinline int llvm_fcmp_ole(double X, double Y) { return X <= Y ; }
static __forceinline int llvm_fcmp_oge(double X, double Y) { return X >= Y ; }
static __forceinline int llvm_fcmp_0(double X, double Y) { return 0; }
static __forceinline int llvm_fcmp_1(double X, double Y) { return 1; }
static __forceinline uint llvm_select_u32(bool condition, uint iftrue, uint ifnot) {
  uint r;
  r = condition ? iftrue : ifnot;
  return r;
}


/* Function Bodies */
__kernel 
void/* Processing Function: _Z15binary_encodingPu11matrix_typeILm1ELm10EiEmPu11matrix_typeILm10ELm10EiEmS0_m_loop_header_reorder_c_opencl_c_c_c: 0*/
 _Z15binary_encodingPu11matrix_typeILm1ELm10EiEmPu11matrix_typeILm10ELm10EiEmS0_m_loop_header_reorder_c_opencl_c_c_c(__global struct l_array_10_uint* feature, ulong feature_size, __global struct l_array_100_uint* rp_matrix, ulong rp_matrix_size, __global struct l_array_10_uint* encoded_feature, ulong encoded_feature_size) {

  ulong tmp__1;
  ulong tmp__2;
  __global struct l_vector_10_uint* _clone2_cloned;
  __global struct l_vector_10_uint* _clone1_cloned;
  __global struct l_vector_100_uint* _clone_cloned;
  ulong loop_iv9_cloned;
  ulong loop_iv9_cloned__PHI_TEMPORARY;
  uint load_buffer_cloned;
  uint load_buffer12_cloned;
  uint load_buffer13_cloned;
  ulong loop_step10_cloned;


/* Printing: newFuncRoot_cloned */


/* Processing Basic Block: newFuncRoot_cloned */
/* newFuncRoot_cloned: */
  tmp__1 = get_global_id((uint) 0);
  tmp__2 = get_global_size((uint) 0);
  _clone2_cloned = ((__global struct l_vector_10_uint*)encoded_feature->array);
  _clone1_cloned = ((__global struct l_vector_10_uint*)feature->array);
  _clone_cloned = ((__global struct l_vector_100_uint*)rp_matrix->array);

/* Branch:   br label %loop.header7_cloned */
/* Printing PHIs for newFuncRoot_cloned->loop.header7_cloned */
/* Printing phi node:   %loop.iv9_cloned = phi i64 [ 0, %newFuncRoot_cloned ], [ %loop.step10_cloned, %loop.header7_cloned ] */
    loop_iv9_cloned__PHI_TEMPORARY = (ulong) 0;   /* for PHI node */

/* Printing: loop.header7_cloned */


/* Processing Loop Block: loop.header7_cloned */

  #pragma unroll 1
  for ( loop_iv9_cloned = 0; loop_iv9_cloned != tmp__2; loop_iv9_cloned = loop_iv9_cloned + 1) {


/* Processing Basic Block: loop.header7_cloned */
/* loop_header7_cloned: */
/* PHINode of induction variable was here */
  load_buffer_cloned = *((&(((__global uint*)_clone_cloned))[(loop_iv9_cloned + (tmp__2 * tmp__1))]));
  load_buffer12_cloned = *((&(((__global uint*)_clone1_cloned))[loop_iv9_cloned]));
  load_buffer13_cloned = *((&(((__global uint*)_clone2_cloned))[tmp__1]));
  *((&(((__global uint*)_clone2_cloned))[tmp__1])) = (load_buffer13_cloned + (((uint)(load_buffer_cloned * load_buffer12_cloned))));
  loop_step10_cloned = loop_iv9_cloned + (ulong) 1;

/* Branch:   br i1 %loop.step11_cloned, label %loop.header7_cloned, label %loop.latch3_cloned, !llvm.loop !13 */
/* This is a loop branch! */
/* Branching back to header: loop.header7_cloned */
/* Closing loop! */
/* Printing PHIs for loop.header7_cloned->loop.header7_cloned */
/* Skipping (indvar) phi node:   %loop.iv9_cloned = phi i64 [ 0, %newFuncRoot_cloned ], [ %loop.step10_cloned, %loop.header7_cloned ] */
  }
/* Printing PHIs for loop.header7_cloned->loop.latch3_cloned */

/* Printing: loop.latch3_cloned */


/* Processing Basic Block: loop.latch3_cloned */
/* loop_latch3_cloned: */
  return;


}

__kernel 
void/* Processing Function: _Z15binary_encodingPu11matrix_typeILm1ELm10EiEmPu11matrix_typeILm10ELm10EiEmS0_m_loop_header15_reorder_c_opencl_c_c: 0*/
 _Z15binary_encodingPu11matrix_typeILm1ELm10EiEmPu11matrix_typeILm10ELm10EiEmS0_m_loop_header15_reorder_c_opencl_c_c(__global struct l_array_10_uint* encoded_feature, ulong encoded_feature_size) {

  ulong tmp__3;
  ulong tmp__4;
  uint load_buffer21_cloned;


/* Printing: newFuncRoot_cloned */


/* Processing Basic Block: newFuncRoot_cloned */
/* newFuncRoot_cloned: */
  tmp__3 = get_global_id((uint) 0);
  tmp__4 = get_global_size((uint) 0);
  load_buffer21_cloned = *((&(((__global uint*)(((__global struct l_vector_10_uint*)encoded_feature->array))))[tmp__3]));
  *((&(((__global uint*)(((__global struct l_vector_10_uint*)encoded_feature->array))))[tmp__3])) = (llvm_select_u32((((((int)load_buffer21_cloned) > ((int)(uint) 0))&1)), (uint) 1, (uint) -1));
}

