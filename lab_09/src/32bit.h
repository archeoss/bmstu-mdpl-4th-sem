#include <stdio.h>
#include <inttypes.h>
#include <sys/time.h>

void test_32bit(long long reps, double* sum_asm, double* sum_std,
                          double* mul_asm, double* mul_std);