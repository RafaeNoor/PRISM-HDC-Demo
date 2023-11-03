#include <iostream>
#include <stdlib.h>
#include <stdlib.h>     /* srand, rand */
#include <time.h>       /* time */

#include "heterocc.h"
#include "hpvm_hdc.h"
#include "utils.h"

#define ROW 10
#define COL 10




typedef __hypervector__<COL, int> hv;
typedef __hypermatrix__<ROW, COL, int> hm;

void binary_encoding(hv* feature, size_t feature_size ,hm* rp_matrix, size_t rp_matrix_size,  hv* encoded_feature, size_t encoded_feature_size){

    void* section = __hetero_section_begin();

    void* task = __hetero_task_begin(
            /* Input Buffers: 3*/ 3, feature, feature_size, rp_matrix, rp_matrix_size, encoded_feature, encoded_feature_size,
            /* Output Buffers: 1*/ 1, encoded_feature, encoded_feature_size,
            "inner_rp_encoding_task"
            );
    {

        // Perform Initial Encoding by multiplying feature vector
        // with random projection matrix
        *encoded_feature = __hetero_hdc_matmul<ROW, COL,  int>(*feature, *rp_matrix);

        // Binarize encoded feature into +1, -1
        *encoded_feature = __hetero_hdc_sign<ROW, int>(*encoded_feature);


    }
    __hetero_task_end(task); 


    __hetero_section_end(section);
}



int id(size_t input){
    return input;
}


int rp_init(size_t input){
    return rand() % 2 == 0 ? 1 : -1;

}


int main(){
    __hpvm__init();

    srand (time(NULL));

    hv input = __hetero_hdc_create_hypervector<ROW, int>(0, (void*) id);
    size_t input_size = get_hv_size<ROW,int>(input);

    hm rp_matrix = __hetero_hdc_create_hypermatrix<ROW, COL, int>(0, (void*) rp_init);

    size_t rp_matrix_size = get_hm_size<ROW,COL, int>(rp_matrix);

    std::cout << "Input Feature:" <<"\n";
    print_hv<int>((int*) &input, ROW);

    std::cout << "Random Projection Matrix:" <<"\n";
    print_hm<int>((int*)&rp_matrix, ROW, COL);

    hv result = __hetero_hdc_hypervector<ROW, int>();


    void* GenRPMatDAG = __hetero_launch(
            (void*) binary_encoding,
            3,
            /* Input Buffers: 3*/ 
            &input, input_size,
            &rp_matrix, rp_matrix_size,
            &result, input_size,
            /* Output Buffers: 1*/ 
            1,
            &result, input_size
            );

    __hetero_wait(GenRPMatDAG);


    std::cout << "Encoded Feature:" <<"\n";
    print_hv<int>((int*) &result, ROW);


    __hpvm__cleanup();
    return 0;
}
