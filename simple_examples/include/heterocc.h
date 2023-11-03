#pragma once

#include <stdlib.h>
extern "C" {
    extern void* __hpvm_launch(void*, ...);
    extern void __hpvm_wait(void*);
    extern void* __hpvm_parallel_section_begin();
    extern void __hpvm_parallel_section_end(void*);
    extern void* __hpvm_task_begin(unsigned,...);
    extern void __hpvm_task_end(void*);
    extern void __hpvm_parallel_loop(unsigned, ...); 
    extern void* __hpvm_launch_begin(unsigned, ...);
    extern void __hpvm_launch_end(void*);
    extern void __hpvm_priv(unsigned, ...);
    extern void __hpvm__isNonZeroLoop(long, ...) noexcept;
    extern void __hpvm__init() noexcept;
    extern void __hpvm__cleanup() noexcept;


    extern void __hetero_priv(unsigned, ...);
    extern void* __hetero_launch(void*, ...);
    extern void __hetero_wait(void*);
    extern void* __hetero_section_begin();
    extern void __hetero_section_end(void*);
    extern void* __hetero_task_begin(unsigned,...);
    extern void __hetero_task_end(void*);
    extern void __hetero_parallel_loop(unsigned, ...); 
    extern void* __hetero_launch_begin(unsigned, ...);
    extern void __hetero_launch_end(void*);
    extern void __hetero_copy_mem(void*, void*, size_t);
    extern void __hetero_request_mem(void*, size_t);
    extern void* __hetero_malloc(size_t);
    extern void __hetero_free(void*);
    extern void __hetero_hint(int);
    extern void __hetero_isNonZeroLoop(long, ...) noexcept;


}

#ifdef __cplusplus
namespace hetero {
#endif

enum Target {
  None,
  CPU_TARGET,
  GPU_TARGET,
  CUDNN_TARGET,
  TENSOR_TARGET,
  CPU_OR_GPU_TARGET,
  CPU_OR_SPIR_TARGET,
  FPGA_TARGET,
  //    ALL_TARGETS,
  NUM_TARGETS
};

#ifdef __cplusplus
}
#endif

