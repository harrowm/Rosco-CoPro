// Tests for printf under newlib
// Malcolm Harrow, April 2024

#include <stdio.h>

int main() {
    printf("1 %d\n", (int)2);
    printf("2 %ld\n", (long)2);
    printf("3 %lld\n", (long long)2); // prints 0 
    
    printf("Size of float %lu\n", sizeof(float));
    printf("Size of double %lu\n", sizeof(double));
    printf("Size of long double %lu\n", sizeof(long double));
    
    printf("Number: %f\n", (float)2.0);

    float f2 = 2.0;
    f2 = f2 * 2.5;
    printf("4a %d\n", (int)f2);
    printf("4b %f\n", f2);

    printf("5 %lf\n", (double)2.0);
    printf("6 %Lf\n", (long double)2.0);
    
    return 0;
}

