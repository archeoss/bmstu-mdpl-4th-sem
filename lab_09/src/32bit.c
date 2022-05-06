#include "32bit.h"

static void std_add_nums(float a, float b, long long reps)
{
    float c = 0;

    for (int i = 0; i < reps; i++)
    {
        c = a + b;
    }
}

static void asm_add_nums(float a, float b, long long reps)
{
    float c = 0;

    for (int i = 0; i < reps; i++)
    {
        __asm__ (
                "fld %1\n"
                "fld %2\n"
                "faddp\n"
                "fstp %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
        );
    }
}

static void std_mul_nums(float a, float b, long long reps)
{
    float c = 0;

    for (int i = 0; i < reps; i++)
    {
        c = a * b;
    }
}

static void asm_mul_nums(float a, float b, long long reps)
{
    float c = 0;

    for (int i = 0; i < reps; i++)
    {
        __asm__ (".intel_syntax noprefix\n\t"
                "fld %1\n"
                "fld %2\n"
                "fmulp\n"
                "fstp %0\n"
                : "=m"(c)
                : "m"(a), "m"(b)
        );
    }
}

void test_32bit(long long reps, double* sum_asm, double* sum_std, double* mul_asm, double* mul_std)
{
    float a = 3e6, b = -2e7;

    struct timeval tv_start, tv_stop;
    int64_t elapsed_time;

    // sum assembly 
    gettimeofday(&tv_start, NULL);
    asm_add_nums(a, b, reps);
    gettimeofday(&tv_stop, NULL);

    elapsed_time = (tv_stop.tv_sec - tv_start.tv_sec) * 1000000LL +
    (tv_stop.tv_usec - tv_start.tv_usec); // usec
    *sum_asm = (double)elapsed_time / reps;

    // sum std
    gettimeofday(&tv_start, NULL);
    std_add_nums(a, b, reps);
    gettimeofday(&tv_stop, NULL);

    elapsed_time = (tv_stop.tv_sec - tv_start.tv_sec) * 1000000LL +
    (tv_stop.tv_usec - tv_start.tv_usec); // usec
    *sum_std = ((double) elapsed_time / reps);

    // mul assembly 
    gettimeofday(&tv_start, NULL);
    asm_mul_nums(a, b, reps);
    gettimeofday(&tv_stop, NULL);

    elapsed_time = (tv_stop.tv_sec - tv_start.tv_sec) * 1000000LL +
    (tv_stop.tv_usec - tv_start.tv_usec); // usec
    *mul_asm = ((double) elapsed_time / reps);

    // mul std
    gettimeofday(&tv_start, NULL);
    std_mul_nums(a, b, reps);
    gettimeofday(&tv_stop, NULL);

    elapsed_time = (tv_stop.tv_sec - tv_start.tv_sec) * 1000000LL +
    (tv_stop.tv_usec - tv_start.tv_usec); // usec
    *mul_std = ((double) elapsed_time / reps); 
}

