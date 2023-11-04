1.
* HDC is an performant, energy efficient computing paradigm
2.
* We improve programmability of HDC algorithms using high level algorithmic HDC operations on HD data types - we call this HDC++
* There are two main benefits of our work
* First this raises the abstraction level for describing HD algorithms
* Second we developed a retargetable compiler implementing these intrinsics, which achieves portability of the HDC code
3.
* HD-Classification is a popular application using HDC to perform classification 
* We will live demonstrate compiling HD-Classification
* (run compile steps)
* Stop, examine quickly the GPU compile log
* Point out clang++ (C++ frontend), opt -lower-hdc lowers the HDC intrinsics into device independent HPVM IR, which is later compiled to CPU, GPU, or FPGA
* Now we will run HD-Classification on the CPU, GPU, and FPGA
* Show the test accuracy is bit-identical across targets
* Show the .dot graphs for HD-Classification, explain hierarchical structure (DFG captures parallelism.)
4.
* We've prepared a simple example using HDC intrinsics to demonstrate their usage
* Show binary encoding main.cpp - this is the first step of many HDC applications
5.
* HD-Clustering is another popular application using HDC to perform k-means clustering
* It's a different important algorithm, and HDC++ can support it using the same intrinsics
* We will live demonstrate compiling HD-Clustering
* (run compile steps)
* Now we will run HD-Clustering on the CPU, GPU, and FPGA
* It produces the same results across devices
* Show the .dot graph for HD-Clustering (can explain if they want)
