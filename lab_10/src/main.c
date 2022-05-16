#include "matrix.h"

int main(void)
{
    long long reps = 1e8;
    double sum_asm = 0, sum_std = 0;

    printf("Sum\t\t\n");
    printf("asm\t\t std\t\t\n");
    test_matrix(reps, &sum_asm, &sum_std);
    printf("%lf\t %lf", sum_asm, sum_std);
   
    return 0;
}

