#include <iostream>
#include <stdlib.h>
#include <stdlib.h>     /* srand, rand */
#include <time.h>       /* time */

#include "heterocc.h"
#include "hpvm_hdc.h"
#include "utils.h"

#define ROW 10
#define COL 10




typedef __hypervector__<COL, float> hv;
typedef __hypermatrix__<ROW, COL, float> hm;

void binary_encoding(hv* feature, size_t feature_size ,hm* rp_matrix, size_t rp_matrix_size,  hv* similarity, size_t similarity_size){

    void* section = __hetero_section_begin();

    void* task = __hetero_task_begin(
            /* Input Buffers: 3*/ 3, feature, feature_size, rp_matrix, rp_matrix_size, similarity, similarity_size,
            /* Output Buffers: 1*/ 1, similarity, similarity_size,
            "inner_rp_encoding_task"
            );
    {


        // Binarize encoded feature into +1, -1
        *similarity = __hetero_hdc_cossim<ROW,COL, float>(*feature, *rp_matrix);


    }
    __hetero_task_end(task); 


    __hetero_section_end(section);
}



float id(size_t input){
    return input;
}


float rp_init(size_t input){
    return rand() % 2 == 0 ? 1 : -1;

}


int main(){
    __hpvm__init();

    srand (time(NULL));

    hv input = __hetero_hdc_create_hypervector<ROW, float>(0, (void*) id);
    size_t input_size = get_hv_size<ROW,float>(input);

    hm rp_matrix = __hetero_hdc_create_hypermatrix<ROW, COL, float>(0, (void*) rp_init);

    size_t rp_matrix_size = get_hm_size<ROW,COL, float>(rp_matrix);

    std::cout << "Input Feature:" <<"\n";
    print_hv<float>((float*) &input, ROW);

    std::cout << "Random Projection Matrix:" <<"\n";
    print_hm<float>((float*)&rp_matrix, ROW, COL);

    hv result = __hetero_hdc_hypervector<ROW, float>();


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


    std::cout << "Similarity:" <<"\n";
    print_hv<float>((float*) &result, ROW);

    int arg_max = __hetero_hdc_arg_max<ROW, float>(*&result); 
    std::cout << "Arg Max: "<< arg_max << "\n";

    __hpvm__cleanup();
    return 0;
}
