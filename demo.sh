#!/usr/bin/env bash
set -e
echo "Starting with simple examples."
cd simple_examples
read -p "Compile binary encoding (press enter to continue)."
cd binary_encoding
echo "Compiling for CPU:"
make main-cpu
echo "Compiling for GPU:"
make main-gpu
echo "Compiling for FPGA (emulation):"
make main-fpga
read -p "Run binary encoding on CPU, GPU, and FPGA emulation (press enter to continue)."
echo "Running on CPU:"
./main-cpu
echo "Running on GPU:"
./main-gpu
echo "Running on FPGA (emulation):"
./main-fpga
make clean
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