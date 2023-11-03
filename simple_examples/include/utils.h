#include <iostream>
#include <stdlib.h>




template <typename elemTy>
void print_hv(elemTy* base_pointer, size_t num_elements){
    std::cout <<"["<<" ";
    for(int i = 0; i < num_elements; i++){
        std::string sep = i == (num_elements - 1) ? "" : ", ";
        std::cout << base_pointer[i] << sep; 
    }
    std::cout << "]" << "\n";
}


template <typename elemTy>
void print_hm(elemTy* base_pointer, size_t num_rows, size_t num_cols){
    std::cout <<"["<<"\n";
    for(int i = 0 ; i < num_rows; i++){
        std::cout <<"[" <<"";
        for(int j = 0; j < num_cols; j++){
        std::string sep = j == (num_cols - 1) ? "" : ", ";
        std::cout << base_pointer[i*num_cols + j] << sep; 
        }
        std::cout<<"]" << "\n";
    }
    std::cout << "]" << "\n";
}


template <int N, typename elemTy>
size_t get_hv_size(__hypervector__<N, elemTy> hv){
    return sizeof(elemTy) * N;

};


template <int M, int N,  typename elemTy>
size_t get_hm_size(__hypermatrix__<M,N, elemTy> hm){
    return sizeof(elemTy) * N * M;

};
