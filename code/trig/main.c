/* 
 * Program to test the m68882 FPU - trig functions
 * Malcolm Harrow, March 2024
 *
 */

/*
 * Adapted from libm-test.c
 * Copyright (c) 2020 Matthew Pearce (mattpearce@me.com)
 */

#include "stdio.h"
#include <math.h>

int main() {
    float result = sin(35);
    double result2 = sqrt(4);
    float result3 = cos(45);
    float result4 = log(20);
    float result5 = exp(20);
    double a = 5.8, b = 2.8; 

    printf("Answer (5.8*2.8) should be 16.24): %f\n", (a * b));
    printf("Answer (cos(0)) should be 1.0): %f\n", cos(0.0));
    printf("sin(35) =  %.02f, should be -0.43 \r\n", result);
    printf("sqrt(4) =  %.02f, should be 2.00 \r\n", result2);
    printf("cos(45)  =  %.02f, should be 0.53 \r\n", result3);
    printf("log(20) =  %.02f, should be 3.00 \r\n", result4);
    printf("exp(20) =  %.02f, should be 485165184.00\r\n", result5);

    return 0;
}
