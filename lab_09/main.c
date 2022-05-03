#include "32bit.h"
#include "64bit.h"
#include "80bit.h"
#include <stdio.h>

void test_80bit(long long reps, double* sum_asm, double* sum_std,
                          double* mul_asm, double* mul_std);

int main(void)
{
    long long reps = 1e9;
    double sum_asm = 0, sum_std = 0, mul_asm = 0, mul_std = 0;

    printf("SUM\t\t\t\t MUL\n");
    printf("ASM\t\t STD\t\t ASM\t\t STD\t\n");

    test_32bit(reps, &sum_asm, &sum_std, &mul_asm, &mul_std);
    printf("%lf\t %lf\t %lf\t %lf\t\n", sum_asm, sum_std, mul_asm, mul_std);

    test_64bit(reps, &sum_asm, &sum_std, &mul_asm, &mul_std);
    printf("%lf\t %lf\t %lf\t %lf\t\n", sum_asm, sum_std, mul_asm, mul_std);

    test_80bit(reps, &sum_asm, &sum_std, &mul_asm, &mul_std);
    printf("%lf\t %lf\t %lf\t %lf\t\n", sum_asm, sum_std, mul_asm, mul_std);

    return 0;
}

