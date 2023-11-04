#!/usr/bin/env bash
set -e
echo "Starting with simple examples."
cd simple_examples
read -p "Compile binary encoding (press enter to continue)."
cd binary_encoding
make clean
echo ""
echo ""
echo ""
read -p "Compile for CPU:"
make -W main.cpp main-cpu
echo ""
echo ""
echo ""
read -p "Compile for GPU:"
make -W main.cpp main-gpu
echo ""
echo ""
echo ""
read -p "Compile for FPGA (emulation):"
make -W main.cpp main-fpga
read -p "Run binary encoding on CPU, GPU, and FPGA emulation (press enter to continue)."
echo "Running on CPU:"
./main-cpu
echo "Running on GPU:"
./main-gpu
echo "Running on FPGA (emulation):"
./main-fpga
cd ..
read -p "Compile cosine similarity (press enter to continue)."
cd cosine_similarity
echo "Compiling for CPU:"
make main-cpu
echo "Compiling for FPGA (emulation):"
make main-fpga
read -p "Run cosine similarity on CPU and FPGA emulation (press enter to continue)."
echo "Running on CPU:"
./main-cpu
echo "Running on FPGA (emulation):"
./main-fpga
make clean
cd ../..
read -p "Compile HD clustering (press enter to continue)."
cd HD-Clustering/Hetero-C++
echo "Compiling for CPU:"
make host-cpu
echo "Compiling for GPU:"
make host-gpu
read -p "Run HD clustering on CPU and GPU (press enter to continue)."
echo "Running on CPU:"
./host-cpu 1
echo "Running on GPU:"
./host-gpu 1
make clean
cd ../..
read -p "Compile HD classification (press enter to continue)."
cd HD-Classification/Hetero-C++
echo "Compiling for CPU:"
make host-cpu
echo "Compiling for GPU:"
make host-gpu
read -p "Run HD classification on CPU and GPU (press enter to continue)."
echo "Running on CPU:"
./host-cpu 1
echo "Running on GPU:"
./host-gpu 1
make clean
cd ../..
read -p "Run HD clustering on FPGA, precompiled (press enter to continue)."
cd HD-Clustering/Hetero-C++
cp /shared/rarbore2/host-fpga .
cp /shared/rarbore2/hpvm.kernels.fpga.aocx build/
./host-fpga 1
make clean
cd ../..
