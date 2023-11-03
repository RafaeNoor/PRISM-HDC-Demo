#!/usr/bin/env bash
set -e
HD_CLUSTERING_DIR=~/HD-Clustering/Hetero-C++

cd $HD_CLUSTERING_DIR
make clean

# CPU
make host-cpu
./host-cpu 2
mv out.txt cpu-out.txt

# GPU
make host-gpu
./host-gpu 2
mv out.txt gpu-out.txt

#FPGA
make host-fpga
