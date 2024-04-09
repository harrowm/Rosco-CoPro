#include <stdio.h>
//#include <math-68881.h>
#include <math.h>

// Below to stop the optimizer removing out code
#define _TIMER_100HZ  0x40c
int getnum() {
    return *(int *)_TIMER_100HZ;
}

int main() {
    volatile float c; // volatile to stop compiler optimizing away

    c = cos(getnum()/65536);
    printf("Cosine 1 = %f\n",c);
    return 0;
}
