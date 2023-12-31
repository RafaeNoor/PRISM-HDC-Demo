HPVM_INSTALL_DIR ?= /home/arnoor2/hpvm_hdc/hpvm/hpvm/
HPVM_BUILD_DIR := $(HPVM_INSTALL_DIR)/build/
INCLUDES := -I$(HPVM_INSTALL_DIR)/include -I$(HPVM_INSTALL_DIR)/benchmarks/include -I$(HPVM_INSTALL_DIR)/projects/hpvm-hdc -I$(HPVM_INSTALL_DIR)/projects/hetero-c++/test/include -I../include

HPVM_LIB := $(HPVM_INSTALL_DIR)/build/lib
HPVM_BIN := $(HPVM_INSTALL_DIR)/build/bin

HPVM_DECLS_FILE := $(HPVM_BUILD_DIR)/tools/hpvm/projects/hetero-c++/lib/HPVMCFunctionDeclarations/HPVMCFunctionDeclarations.bc

CUDA_PATH:=/software/cuda-9.1
OPENCL_PATH:=$(CUDA_PATH)
OPENCL_LIB_PATH:=$(OPENCL_PATH/lib64)

CFLAGS := -O1 -fenable-matrix -fno-discard-value-names -fno-exceptions -lm -lrt -pthread -lOpenCL


### ---------- CPU ---------------

# Generate Executable
main-cpu: build/output.ll
	$(HPVM_INSTALL_DIR)/build/bin/clang++ -I$(OPENCL_PATH)/include/CL -L$(OPENCL_LIB_PATH) -lm -lrt -pthread -lOpenCL -O2 $< -o $@ 
#

# Clang Frontend to IR
build/main.cpu.ll: main.cpp
	$(HPVM_BIN)/clang++ -DHPVM -DDEVICE=hpvm::CPU_TARGET $(CFLAGS) $(INCLUDES) -S -emit-llvm $^ -o $@ 
#$HPVM_BIN/clang++ -O1 -I$OPENCL_PATH/include/CL -L$OPENCL_LIB_PATH -I$HPVM_ROOT/projects/hetero-c++/test/include/ -lm -lrt -pthread -lOpenCL  $INCLUDE_FLAG -fenable-matrix    $PREFIX.cpp -S -emit-llvm -o $PREFIX.ll

# GenHPVM for HDC only and mem2reg
build/hpvm.genhdc.cpu.ll: build/main.cpu.ll
	$(HPVM_BIN)/opt -mem2reg -enable-new-pm=0 -load $(HPVM_LIB)/HPVMGenHPVM.so -genhpvm -hpvm-hdc-only $< -S -o $@
# $OPT -mem2reg -enable-new-pm=0 -load $HPVM_LIB/HPVMGenHPVM.so -genhpvm  -hpvm-hdc-only $PREFIX.ll -S -o $PREFIX.genhdc.hpvm.ll

# Lower HDC Intrinsics
build/hdc.lowered.cpu.ll: build/hpvm.genhdc.cpu.ll #hpvm. # -enable-hcc 
	$(HPVM_BIN)/opt -enable-new-pm=0 -load $(HPVM_LIB)/LLVMHPVMHDC.so -vector-block-dim=1 -lower-hdc   -dce -simplifycfg $< -S -o $@ 
	
# HCC -> HPVM
build/hpvmc.cpu.ll: build/hdc.lowered.cpu.ll
	$(HPVM_BIN)/hcc $< -declsfile $(HPVM_DECLS_FILE) -sanitise-funcs --dot-dfg  -S -o $@
	$(HPVM_BIN)/opt $@ -dce -S -o $@

# GenHPVM for the HPVM IR
build/hpvm.cpu.ll: build/hpvmc.cpu.ll
	$(HPVM_BIN)/opt -enable-new-pm=0 -load $(HPVM_LIB)/HPVMGenHPVM.so -dce -mem2reg -genhpvm $< -S -o $@

# Other HPVM Passes
build/hpvmcompiled.cpu.ll: build/hpvm.cpu.ll
	$(HPVM_BIN)/opt -enable-new-pm=0 -load $(HPVM_LIB)/HPVMBuildDFG.so -load $(HPVM_LIB)/HPVMDFG2LLVM_CPU.so -load $(HPVM_LIB)/HPVMClearDFG.so -load $(HPVM_LIB)/HPVMDFGTransformPasses.so -dfg2llvm-cpu -clearDFG -hpvm-timers-cpu $< -S -o $@

HPVM_RT := $(HPVM_BUILD_DIR)/tools/hpvm/projects/hpvm-rt/hpvm-rt.bc

# LINK HPVM RT and DCE
build/output.ll: build/hpvmcompiled.cpu.ll # build/cpu_test.hpvmcompiled.ll
	$(HPVM_INSTALL_DIR)/build/bin/opt -dce -globaldce $< -S -o $<
	$(HPVM_INSTALL_DIR)/build/bin/llvm-link $< $(HPVM_RT) -S -o $@ 

### ---------- GPU ---------------

# Generate Executable
main-gpu: build/output.gpu.ll
	$(HPVM_INSTALL_DIR)/build/bin/clang++ -I$(OPENCL_PATH)/include/CL -L$(OPENCL_LIB_PATH) -lm -lrt -pthread -lOpenCL -O2 $< -o $@

# Clang Frontend to IR
build/main.gpu.ll: main.cpp
	$(HPVM_BIN)/clang++ -DHPVM -DDEVICE=hpvm::GPU_TARGET $(CFLAGS) $(INCLUDES) -S -emit-llvm $^ -o $@ 
#$HPVM_BIN/clang++ -O1 -I$OPENCL_PATH/include/CL -L$OPENCL_LIB_PATH -I$HPVM_ROOT/projects/hetero-c++/test/include/ -lm -lrt -pthread -lOpenCL  $INCLUDE_FLAG -fenable-matrix    $PREFIX.cpp -S -emit-llvm -o $PREFIX.ll

# GenHPVM for HDC only and mem2reg
build/hpvm.genhdc.gpu.ll: build/main.gpu.ll
	$(HPVM_BIN)/opt -mem2reg -enable-new-pm=0 -load $(HPVM_LIB)/HPVMGenHPVM.so -genhpvm -hpvm-hdc-only $< -S -o $@
# $OPT -mem2reg -enable-new-pm=0 -load $HPVM_LIB/HPVMGenHPVM.so -genhpvm  -hpvm-hdc-only $PREFIX.ll -S -o $PREFIX.genhdc.hpvm.ll

# Lower HDC Intrinsics
build/hdc.lowered.gpu.ll: build/hpvm.genhdc.gpu.ll #hpvm.
	$(HPVM_BIN)/opt -enable-new-pm=0 -load $(HPVM_LIB)/LLVMHPVMHDC.so -vector-block-dim=1 -lower-hdc -enable-hcc -dce -simplifycfg $< -S -o $@

# HCC -> HPVM
build/hpvmc.gpu.ll: build/hdc.lowered.gpu.ll
	$(HPVM_BIN)/hcc $< -declsfile $(HPVM_DECLS_FILE) -sanitise-funcs --dot-dfg --skip-verify -S -o $@
	$(HPVM_BIN)/opt $@ -dce -S -o $@

# GenHPVM for the HPVM IR
build/hpvm.gpu.ll: build/hpvmc.gpu.ll
	$(HPVM_BIN)/opt -enable-new-pm=0 -load $(HPVM_LIB)/HPVMGenHPVM.so -dce -mem2reg -genhpvm $< -S -o $@

build/hpvmcompiled.gpu.ll: build/hpvm.gpu.ll
	$(HPVM_BIN)/opt -enable-new-pm=0 -load $(HPVM_LIB)/HPVMBuildDFG.so -load $(HPVM_LIB)/HPVMLocalMem.so -load $(HPVM_LIB)/HPVMDFG2LLVM_GPU_OCL.so -load $(HPVM_LIB)/HPVMDFG2LLVM_CPU.so -load $(HPVM_LIB)/HPVMClearDFG.so -load $(HPVM_LIB)/HPVMDFGTransformPasses.so -localmem -dfg2llvm-gpu-ocl -dfg2llvm-cpu -clearDFG -hpvm-timers-cpu -hpvm-timers-ptx $< -S -o $@
	$(HPVM_BIN)/llvm-ocl build/hpvm.gpu.kernels.ll

HPVM_RT := $(HPVM_BUILD_DIR)/tools/hpvm/projects/hpvm-rt/hpvm-rt.bc

# LINK HPVM RT and DCE
build/output.gpu.ll: build/hpvmcompiled.gpu.ll # build/gpu_test.hpvmcompiled.ll
	$(HPVM_INSTALL_DIR)/build/bin/llvm-link $< $(HPVM_RT) -S -o $@ 
	$(HPVM_INSTALL_DIR)/build/bin/opt -dce -globaldce $< -S -o $<

### ---------- FPGA ---------------

# Generate Executable
main-fpga: build/output.fpga.ll
	$(HPVM_INSTALL_DIR)/build/bin/clang++ -I$(OPENCL_PATH)/include/CL -L$(OPENCL_LIB_PATH) -lm -lrt -pthread -lOpenCL -O2 $< -o $@

# Clang Frontend to IR
build/main.fpga.ll: main.cpp
	$(HPVM_BIN)/clang++ -DHPVM -DFPGA -DDEVICE=hpvm::FPGA_TARGET $(CFLAGS) $(INCLUDES) -S -emit-llvm $^ -o $@ 
#$HPVM_BIN/clang++ -O1 -I$OPENCL_PATH/include/CL -L$OPENCL_LIB_PATH -I$HPVM_ROOT/projects/hetero-c++/test/include/ -lm -lrt -pthread -lOpenCL  $INCLUDE_FLAG -fenable-matrix    $PREFIX.cpp -S -emit-llvm -o $PREFIX.ll

# GenHPVM for HDC only and mem2reg
build/hpvm.genhdc.fpga.ll: build/main.fpga.ll
	$(HPVM_BIN)/opt -mem2reg -enable-new-pm=0 -load $(HPVM_LIB)/HPVMGenHPVM.so -genhpvm -hpvm-hdc-only $< -S -o $@
# $OPT -mem2reg -enable-new-pm=0 -load $HPVM_LIB/HPVMGenHPVM.so -genhpvm  -hpvm-hdc-only $PREFIX.ll -S -o $PREFIX.genhdc.hpvm.ll

# Lower HDC Intrinsics
build/hdc.lowered.fpga.ll: build/hpvm.genhdc.fpga.ll #hpvm.
	$(HPVM_BIN)/opt -enable-new-pm=0 -load $(HPVM_LIB)/LLVMHPVMHDC.so -vector-block-dim=1 -lower-hdc  -dce -simplifycfg $< -S -o $@

# HCC -> HPVM
build/hpvmc.fpga.ll: build/hdc.lowered.fpga.ll
	$(HPVM_BIN)/hcc $< -declsfile $(HPVM_DECLS_FILE) -sanitise-funcs --dot-dfg  -S -o $@
	$(HPVM_BIN)/opt $@ -dce -S -o $@

build/hpvm.main.fpga.ll build/hpvm.kernels.fpga.ll build/hpvm.kernels.fpga.cl build/hpvm.kernels.fpga.aocx: build/hpvmc.fpga.ll
	$(HPVM_BIN)/hpvm2fpga -hm=build/hpvm.main.fpga.ll -km=build/hpvm.kernels.fpga.ll -clm=build/hpvm.kernels.fpga.cl -cxm=build/hpvm.kernels.fpga.aocx -emu -run-aoc $^


HPVM_RT := $(HPVM_BUILD_DIR)/tools/hpvm/projects/hpvm-rt/hpvm-rt.bc

# LINK HPVM RT and DCE
build/output.fpga.ll: build/hpvm.main.fpga.ll
	$(HPVM_INSTALL_DIR)/build/bin/llvm-link $< $(HPVM_RT) -S -o $@ 
	$(HPVM_INSTALL_DIR)/build/bin/opt -dce -globaldce $< -S -o $<

.PHONY: clean

clean:
	rm -rf *.dot build/*.ll build/* main-gpu main-cpu main-fpga *.aoco
