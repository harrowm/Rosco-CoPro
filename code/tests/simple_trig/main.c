#include <stdio.h>
//#include <math-68881.h>
#include <math.h>

#define _TIMER_100HZ  0x40c
int getnum() {
    return *(int *)_TIMER_100HZ;
}

int main() {
    float c;

    // try to stop compiler optimizing away call to cos
    float num = getnum()/65536.0;
    printf("Cosine %f = ", num);
    c = cosf(num);
    printf(" %f\n", c);
    return 0;
}
