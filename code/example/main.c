/* 
 * Program to test the m68882 FPU
 * Malcolm Harrow, March 2024
 *
 * From Byte July 1987
 * A simple benchmark for testing floating-point speed of C libraries; 
 * does repeated multiplications and divisions in a loop that is large 
 * enough to make the looping time insignificant
 * 
 *  Results in 1987, for 10K iterations:
 *      MacSE:                      229.98
 *      MacSe with HyperCharger:      4.16
 *      Arete 1100:                   2.90
 *      Deskpro 386 with FPU:         5.41
 *      IBM PC AT (8Mhz) no FPU:    116.36
 *      IBM PC AT (8 MHz) with FPU:   9.70
 *
 * Results in 2024 (100M iterations then scaled):
 *      Mac M1 Air                    0.000044
 *     
 * On a modern computer, remove -O2 flags etc from the compiler command line
 *  eg on Mac, change kmain() to main() and compile with cc -O0 main.c
 *  eg on rosco, remove -O2 from included makefile
 */

#include "stdio.h"

#define CONST1 3.141597 
#define CONST2 1.7839032E4
#define COUNT 10000

#ifdef ROSCO
#define _TIMER_100HZ  0x40c
#endif

int gettimer() {
#ifdef ROSCO
    return *(int *)_TIMER_100HZ;
#else
    return 0;
#endif
}

// Returns the number of 100ths of a second passed
int getduration(int start, int end) {
    return (end > start) ? (end - start) : (0xFFFF - start + end);
}

int kmain() {
    double a, b, c; 
    int i;

    int start = gettimer();

    a = CONST1;
    b = CONST2;

    for (i=0; i<COUNT; ++i) {
        c = a * b; 
        c = c / a; 
        c = a * b; 
        c = c / a; 
        c = a * b; 
        c = c / a; 
        c = a * b; 
        c = c / a; 
        c = a * b; 
        c = c / a; 
        c = a * b; 
        c = c / a; 
        c = a * b; 
        c = c / a; 
    }

    int end = gettimer();
    int duration = getduration(start, end);

    printf("Time: %d.%03d\n", duration/100, duration%100);
    return 0;
}
