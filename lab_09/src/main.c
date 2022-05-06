#include "32bit.h"
#include "64bit.h"
#include "80bit.h"
#include "sin.h"

int main(void)
{
    long long reps = 1e10;
    double sum_asm = 0, sum_std = 0, mul_asm = 0, mul_std = 0;

    printf("Sum\t\t\t\t Mul\n");
    printf("\tasm\t\t std\t\t asm\t\t std\t\n");

    test_32bit(reps, &sum_asm, &sum_std, &mul_asm, &mul_std);
    printf("32bit:\t%lf\t %lf\t %lf\t %lf\t\n", sum_asm, sum_std, mul_asm, mul_std);

    test_64bit(reps, &sum_asm, &sum_std, &mul_asm, &mul_std);
    printf("64bit:\t%lf\t %lf\t %lf\t %lf\t\n", sum_asm, sum_std, mul_asm, mul_std);

    test_80bit(reps, &sum_asm, &sum_std, &mul_asm, &mul_std);
    printf("80bit:\t%lf\t %lf\t %lf\t %lf\t\n", sum_asm, sum_std, mul_asm, mul_std);

    
    double short_sin = 0, short_halfsin = 0, long_sin = 0, long_halfsin = 0, prep_sin = 0, prep_halfsin = 0;
    printf("Sin:\t\n");
    test_sin(&short_sin, &short_halfsin, &long_sin, &long_halfsin, &prep_sin, &prep_halfsin);
    printf("3.14\t\t3.141596\tPreproccesor\t\t\n");
    printf("%lf\t%lf\t%lf\t\n", short_sin, long_sin, prep_sin);
    printf("3.14 / 2\t3.141596 / 2\tPreproccesor / 2\t\t\n");
    printf("%lf\t%lf\t%lf\t\n", short_halfsin, long_halfsin, prep_halfsin);
    return 0;
}

