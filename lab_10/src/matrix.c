#include "matrix.h"

static matrix_t **create_matrix(int rows, int cols)
{
    matrix_t *data = calloc(sizeof(matrix_t), rows * cols);
    matrix_t **rows_data = calloc(sizeof(matrix_t *),  rows);
    for (int i = 0; i < rows; i++)
    {
        rows_data[i] = data + i * cols;
    }

    return rows_data;
}

static void print_matrix(matrix_t **matrix, int rows, int cols)
{
    for (int i = 0; i < rows; i++)
    {
        for (int j = 0; j < cols; j++)
        {
            printf("%f ", matrix[i][j]);
        }
        printf("\n");
    }
}

static void fill_matrix(matrix_t **matrix, int rows, int cols)
{
    for (int i = 0; i < rows; i++)
    {
        for (int j = 0; j < cols; j++)
        {
            matrix[i][j] = i + i * j + 10;
        }
    }
}

static void free_matrix(matrix_t **matrix)
{
    if (matrix)
    {
        free(*matrix);
        free(matrix);
    }
}

static void sumstd(matrix_t **matrix_a, matrix_t **matrix_b, int rows, int cols, int reps)
{
    for (int k = 0; k < reps; k++)
    {
        for (int i = 0; i < rows; i++)
        {
            for (int j = 0; j < cols; j++)
            {
                matrix_a[i][j] += matrix_b[i][j];
            }
        }
    }
}

static void sumasm(matrix_t **matrix_a, matrix_t **matrix_b, int rows, int cols, int reps)
{
    int len = rows * cols;
    int size = sizeof(matrix_t);
    for (int k = 0; k < reps; k++)
    {
                asm(
                    "xorl       %%ecx, %%ecx                \n\t" // Loop counter = 0
                    "loop:                                  \n\t"
                    "vmovapd    (%0,%%rcx), %%xmm0          \n\t" // Load 2 elements from matrix_a[rcx]
                    "vaddpd     (%1,%%rcx), %%xmm0, %%xmm0  \n\t" // Add  2 elements from matrix_b[rcx]
                    "vmovapd    %%xmm0, (%0,%%rcx)          \n\t" // Store result in matrix_a
                    "addl       $0x10, %%ecx                \n\t" // 8 elemtns * 2 bytes = 16 (0x10)
                    "cmpl       %2, %%ecx                   \n\t" 
                    "jb         loop"                             
                    :       
                    : "r" (*matrix_a), "r" (*matrix_b), "r"(len * size)
                    : "%ecx", "%xmm0", "memory"
                );
    }
}

void test_matrix(long long reps, double *sum_asm, double *sum_std)
{
    int rows = 8, cols =8;

    struct timeval tv_start, tv_stop;
    int64_t elapsed_time;

    matrix_t **matrix_a = create_matrix(rows, cols);
    fill_matrix(matrix_a, rows, cols);

    matrix_t **matrix_b = create_matrix(rows, cols);
    fill_matrix(matrix_b, rows, cols);

    // sum std 
    gettimeofday(&tv_start, NULL);
    sumstd(matrix_a, matrix_b, rows, cols, reps);
    gettimeofday(&tv_stop, NULL);

    elapsed_time = (tv_stop.tv_sec - tv_start.tv_sec) * 1000000LL +
    (tv_stop.tv_usec - tv_start.tv_usec); // usec
    *sum_std = (double)elapsed_time / reps;

    // print_matrix(matrix_a, rows, cols);
    free(matrix_a);
    free(matrix_b);
    matrix_a = create_matrix(rows, cols);
    fill_matrix(matrix_a, rows, cols);

    matrix_b = create_matrix(rows, cols);
    fill_matrix(matrix_b, rows, cols);
    // sum assembly 
    gettimeofday(&tv_start, NULL);
    sumasm(matrix_a, matrix_b, rows, cols, reps);
    gettimeofday(&tv_stop, NULL);

    elapsed_time = (tv_stop.tv_sec - tv_start.tv_sec) * 1000000LL +
    (tv_stop.tv_usec - tv_start.tv_usec); // usec
    *sum_asm = (double)elapsed_time / reps;
    
    // print_matrix(matrix_a, rows, cols);
    free(matrix_a);
    free(matrix_b);
}