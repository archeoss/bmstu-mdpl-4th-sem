#ifndef _MATRIX_H_

#define _MATRIX_H_

#include <malloc.h>
#include <stdio.h>
#include <inttypes.h>
#include <sys/time.h>

typedef double matrix_t;
void test_matrix(long long reps, double *sum_asm, double *sum_std);

#endif // !_MATRIX_H_