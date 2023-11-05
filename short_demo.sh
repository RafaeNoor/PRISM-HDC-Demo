#!/usr/bin/env bash
set -e
clear
echo "============================================================================="
echo "                          HD - Classification"
echo "============================================================================="


read -p "Compile HD classification (press Enter to continue)."
cd HD-Classification/Hetero-C++
make clean

echo "============================================================================="
echo "                      Compiling for CPU:"
echo "============================================================================="
sleep 1
make host-cpu
echo ""
echo "Done Compiling for CPU!"
echo ""


echo "============================================================================="
echo "                      Compiling for GPU:"
echo "============================================================================="
sleep 1
make host-gpu

echo ""
echo "Done Compiling for GPU!"
echo ""

echo "============================================================================="
read -p "Run HD classification on CPU and GPU (press Enter to continue)."
echo "Running on CPU:"
echo ""
./host-cpu 1
sleep 1
echo ""
echo "Running on GPU:"
echo ""
./host-gpu 1
sleep 1
make clean
rm out.txt
cd ../..
read -p  " *** Please refer to HD Classification Dataflow graphs (press Enter to continue)"
clear
echo "============================================================================="
echo "                          Simple Example: Binary Encoding"
echo "============================================================================="

read -p  " *** Please refer to simple_examples/binary_encdoing/main.cpp (press Enter to continue)"


echo "============================================================================="
echo "                          HD - Clustering"
echo "============================================================================="


read -p "Compile HD clustering (press enter to continue)."
cd HD-Clustering/Hetero-C++
make clean

echo "============================================================================="
echo "                      Compiling for CPU:"
echo "============================================================================="
sleep 1
make host-cpu
echo ""
echo "Done Compiling for CPU!"
echo ""


echo "============================================================================="
echo "                      Compiling for GPU:"
echo "============================================================================="
sleep 1
make host-gpu


echo "============================================================================="
echo "                      Compiling for FPGA:"
echo "============================================================================="
echo " *** Being skipped for live demo as FPGA synthesis requires significant time"
cp /shared/rarbore2/host-fpga .
cp /shared/rarbore2/hpvm.kernels.fpga.aocx build/
sleep 1

echo ""
echo "Done Compiling for FPGA!"
echo ""


echo "============================================================================="
read -p "Run HD clustering on CPU, GPU and FPGA (press Enter to continue)."
echo "Running on CPU:"
echo ""
./host-cpu 1 | grep -v "Cluter"
sleep 1
echo ""
echo "Running on GPU:"
echo ""
./host-gpu 1 | grep -v "Cluter"
sleep 1
echo "Running on FPGA:"
echo ""
./host-fpga 1 | grep -v "Cluter"
sleep 1
make clean
cd ../../

echo "============================================================================="
echo "                          Thank You!"
echo "============================================================================="
