#include "sin.h"

void test_sin(double* short_sin,
             double* short_halfsin, double* long_sin, double* long_halfsin, double* prep_sin, double* prep_halfsin)
{
    double pi_short = 3.14, pi_long = 3.141596;
    double pi_prep;
    __asm__ (".intel_syntax noprefix\n\t"
        "fldpi\n"
        "fstp %0\n"
        : 
        : "m"(pi_prep)
    );

    *short_sin = sin(pi_short);
    *long_sin = sin(pi_long);
    *short_halfsin = sin(pi_short / 2);
    *long_halfsin = sin(pi_long / 2);

    *prep_sin = sin(pi_prep);
    *prep_halfsin = sin(pi_prep / 2);
}
