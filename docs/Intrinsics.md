
template<int N, typename elemTy>
using __hypervector__ __attribute__((matrix_type(1, N))) = elemTy;

// Hypermatrix – M Hypervectors of length N
template<int M, int N, typename elemTy>
using  __hypermatrix__ __attribute__((matrix_type(M, N))) = elemTy;


template<int N, typename elemTy>
__hypervector__<N, elemTy> __hetero_hdc_hypervector () noexcept;

template<int M, int N, typename elemTy>
__hypermatrix__<M, N, elemTy> __hetero_hdc_hypermatrix () noexcept;


template<int N, typename elemTy>
__hypervector__<N, elemTy> __hetero_hdc_random_hypervector() noexcept;

template<int M, int N, typename elemTy>
__hypermatrix__<M, N, elemTy> __hetero_hdc_random_hypermatrix() noexcept;

template<int N, typename elemTy>
__hypervector__<N, elemTy> __hetero_hdc_gaussian_hypervector() noexcept;

template<int M, int N, typename elemTy>
__hypermatrix__<M, N, elemTy> __hetero_hdc_gaussian_hypermatrix() noexcept;


template<int N, typename elemTy>
__hypervector__<N, elemTy> __hetero_hdc_create_hypervector(int, void*, ...) noexcept;

template<int M, int N, typename elemTy>
__hypermatrix__<M, N, elemTy> __hetero_hdc_create_hypermatrix(int, void*, ...) noexcept;

## Operations on Hypervectors
template<int N, typename elemTy>
__hypervector__<N, elemTy> __hetero_hdc_sum (__hypervector__<N, elemTy>, __hypervector__<N, elemTy>) noexcept;


template<int N, typename elemTy>
__hypervector__<N, elemTy> __hetero_hdc_sub (__hypervector__<N, elemTy>, __hypervector__<N, elemTy>) noexcept;


template<int N, typename elemTy>
__hypervector__<N, elemTy> __hetero_hdc_mul (__hypervector__<N, elemTy>, __hypervector__<N, elemTy>) noexcept;


template<int N, typename elemTy>
__hypervector__<N, elemTy> __hetero_hdc_div (__hypervector__<N, elemTy>, __hypervector__<N, elemTy>) noexcept;


template<int N, typename elemTy>
__hypervector__<N, elemTy> __hetero_hdc_absolute_value (__hypervector__<N, elemTy>) noexcept;

template<int N, typename elemTy>
__hypervector__<N, elemTy> __hetero_hdc_shuffle (__hypervector__<N, elemTy> vector, int seed) noexcept;

template<int N, typename elemTy>
__hypervector__<N,elemTy> __hetero_hdc_wrap_shift (__hypervector__<N, elemTy>, int) noexcept;

template<int N, typename elemTy>
__hypervector__<N, elemTy> __hetero_hdc_sign_flip (__hypervector__<N, elemTy>) noexcept;

template<int N, typename elemTy>
__hypervector__<N, elemTy> __hetero_hdc_sign (__hypervector__<N, elemTy>) noexcept;

template<int N, typename elemTy>
__hypervector__<N, elemTy> __hetero_hdc_cosine (__hypervector__<N, elemTy>) noexcept;


template<int N, typename fromelemTy, typename toelemTy>
__hypervector__<N, toelemTy> __hetero_hdc_type_cast (__hypervector__<N, fromelemTy>) noexcept;

## Operations on Hypermatrices

template<int M, int N, typename elemTy>
__hypermatrix__<M, N, elemTy> __hetero_hdc_shuffle (__hypermatrix__<M, N, elemTy> matrix, int seed) noexcept;

template<int M, int N, typename elemTy>
__hypermatrix__<M, N, elemTy> __hetero_hdc_wrap_shift (__hypermatrix__<M, N, elemTy>, int) noexcept;

template<int M, int N, typename elemTy>
__hypermatrix__<M, N, elemTy> __hetero_hdc_sign_flip (__hypermatrix__<M, N, elemTy>) noexcept;

template<int M, int N, typename elemTy>
__hypermatrix__<M, N, elemTy> __hetero_hdc_sign (__hypermatrix__<M, N, elemTy>) noexcept;

template<int M, int N, typename elemTy>
__hypermatrix__<M, N, elemTy> __hetero_hdc_cosine (__hypermatrix__<M, N, elemTy>) noexcept;



## Operations between Hypervectors
template<int M, int N, typename elemTy>
__hypervector__<N, elemTy> __hetero_hdc_search (__hypervector__<N, elemTy> C, __hypervector__<N, elemTy> A) noexcept;

template< int N, typename elemTy>
elemTy __hetero_hdc_cossim (__hypervector__<N, elemTy> C, __hypervector__<N, elemTy> A) noexcept;

template< int N, typename elemTy>
elemTy __hetero_hdc_hamming_distance (__hypervector__<N, elemTy> C, __hypervector__<N, elemTy> A) noexcept;

template< int N, typename elemTy>
elemTy __hetero_hdc_l2norm (__hypervector__<N, elemTy> A) noexcept;


template< int N, typename elemTy>
int __hetero_hdc_arg_max (__hypervector__<N, elemTy> A) noexcept;

template< int N, typename elemTy>
int __hetero_hdc_arg_min (__hypervector__<N, elemTy> A) noexcept;



## Operations between Hypervectors and Hypermatrices
template<int M, int N, typename elemTy>
__hypervector__<N, elemTy> __hetero_hdc_search (__hypervector__<N, elemTy> C, __hypermatrix__<M, N, elemTy> A) noexcept;

template<int M, int N, typename elemTy>
__hypervector__<M, elemTy> __hetero_hdc_matmul (__hypervector__<N, elemTy> C, __hypermatrix__<M, N, elemTy> A) noexcept;


template<int M, int N, typename elemTy>
__hypervector__<M, elemTy> __hetero_hdc_transposed_matmul (__hypervector__<N, elemTy> C, __hypermatrix__<M, N, elemTy> A) noexcept;

template<int M, int N, typename elemTy>
__hypervector__<M, elemTy> __hetero_hdc_cossim (__hypervector__<N, elemTy> C, __hypermatrix__<M, N, elemTy> A) noexcept;


template<int M, int N, typename elemTy>
__hypervector__<M, elemTy> __hetero_hdc_l2norm ( __hypermatrix__<M, N, elemTy> A) noexcept;

template<int M, int N, typename elemTy>
__hypervector__<M, elemTy> __hetero_hdc_hamming_distance (__hypervector__<N, elemTy> C, __hypermatrix__<M, N, elemTy> A) noexcept;

## Operations to access Hypermatrices

template<int M, int N, typename elemTy>
__hypervector__<N, elemTy> __hetero_hdc_get_matrix_row (__hypermatrix__<M,N, elemTy> A, size_t rows, size_t cols, size_t row_index) noexcept;


template<int M, int N, typename elemTy>
__hypermatrix__<M, N, elemTy> __hetero_hdc_set_matrix_row (__hypermatrix__<M,N, elemTy> A,__hypervector__<N, elemTy> V, size_t row_index) noexcept;

template<int M, int N, typename elemTy>
__hypermatrix__<N, M, elemTy> __hetero_hdc_matrix_transpose (__hypermatrix__<M, N, elemTy> A, size_t rows, size_t cols) noexcept;

## Hyperdimensional Computing Stages

### Encoding
void __hetero_hdc_encoding(unsigned num_args, void *func, ...) noexcept;

### Training

void __hetero_hdc_training (unsigned num_args, void *func, ...) noexcept;
void __hetero_hdc_retraining (unsigned num_args, void *func, ...) noexcept;

### Similarity checking
void __hetero_hdc_similarity_check(unsigned num_args, void *func, ...) noexcept;


### Inference
void __hetero_hdc_inference(unsigned num_args, void *func, ...) noexcept;
