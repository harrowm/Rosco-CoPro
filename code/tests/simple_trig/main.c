#include <stdio.h>
//#include <math-68881.h>
#include <math.h>

// return a number between 0 and 1
#define _TIMER_100HZ  0x40c
float getnum() {
    return (*(int *)_TIMER_100HZ) / 65536.0;
}

int main() {
    //float c;

    // try to stop compiler optimizing away call to cos
    float num = getnum() * 360.0;
    float dummy = 45;
    float c = cos(num);
    
    printf("Cosine %f %f = %f\n", dummy, num, c);

    (c == num) ? printf("same\n") : printf("different\n"); 

    float result3 = cos(45.0);
    printf("cos(45)  =  %.02f, should be 0.53 \r\n", result3);

    return 0;
}
