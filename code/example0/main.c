/* 
 * Program to test the m68882 FPU
 * Malcolm Harrow, March 2024
 *
 * On a modern computer, remove -O2 flags etc from the compiler command line
 *  eg on Mac, change kmain() to main() and compile with cc -O0 main.c
 *  eg on rosco, remove -O2 from included makefile
 */

#include "stdio.h"

int kmain() {
    double a, b; 

    a = 5.8;
    b = 2.8;

    printf("Answer (int) %d=16\n", (int)(a * b));

    return 0;
}
