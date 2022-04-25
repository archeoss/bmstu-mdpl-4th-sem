#include <stdio.h>

int asmlen(const char *strptr)
{
    int len = 0;
    const char *ptr = strptr;
    asm(
        "mov %1, %%rdi      \n"
        "xor %%ecx, %%ecx   \n"
        "not %%ecx          \n"
        "xor %%al, %%al     \n"
        "cld                \n"
        "repne scasb        \n"
        "not %%ecx          \n"
        "dec %%ecx          \n"
        "mov %%ecx, %0      \n"
        :"=r"(len)
        :"r"(ptr)
        :"%ecx", "%al", "%rdi" 
    );

    return len + 1;
}

void strcpy(char *dstptr, char *srcptr, int n);

int main()
{
    char test[] = "qwertyasdfg";    // len = 12
    char test_cpy[64];
    int n = asmlen(test);
    printf(">>>%d<<<\n", n);
    strcpy(test_cpy, test, n);
    printf(">>>%s<<<\n", test_cpy);
    strcpy(test_cpy, test + 3, n);
    printf(">>>%s<<<\n", test_cpy);
    strcpy(test_cpy, test_cpy + 3, n);
    printf(">>>%s<<<\n", test_cpy);
    return 0;
}

