/* 
 * Program to test the m68882 FPU
 * Malcolm Harrow, March 2024
 *
 */

#include "stdio.h"

int main() {
    volatile double a, b; // volatile to stop compiler optimizing away

    a = 5.8;
    b = 2.8;

    printf("Answer (int(5.8*2.8) should be 16): %d\n", (int)(a * b));
    printf("Answer (5.8*2.8) should be 16.24): %f\n", (a * b));

    return 0;
}
