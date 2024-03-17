/* 
 * Program to test the m68882 FPU
 * Malcolm Harrow, March 2024
 *
 * On a modern computer, remove -O2 flags etc from the compiler command line
 * This is why there is a local copy of software.mk in this project's directory
 *
 */

#include "stdio.h"
#include "debug_stub.h"

int kmain() {
    debug_stub();
    double a, b; 

    a = 5.8;
    b = 2.8;

    printf("Answer (int(5.8*2.8) should be 16): %d\n", (int)(a * b));

    return 0;
}
