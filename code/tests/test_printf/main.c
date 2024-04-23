// Tests for printf under newlib
// Malcolm Harrow, April 2024

#include <stdio.h>


void print_in_fn(long N, long J, long K, double X1, double X2, double X3, double X4);

int main() {
    printf("1 %d\n", (int)2);
    printf("2 %ld\n", (long)2);
    printf("3 %lld\n", (long long)2); // prints 0 
    
    printf("Size of float %lu\n", sizeof(float));
    printf("Size of double %lu\n", sizeof(double));
    printf("Size of long double %lu\n", sizeof(long double));
    printf("Size of unsigned long long %lu\n", sizeof(unsigned long long));
    
    printf("Number: %f\n", (float)2.0);

    float f2 = 2.0;
    f2 = f2 * 2.5;
    printf("4a %d\n", (int)f2);
    printf("4b %f\n", f2);

    printf("5 %lf\n", (double)2.0);
    printf("6 %Lf\n", (long double)2.0);

    int a = 3;
    float b = 3.14;
    double c = 3.14;
    double d = 6.28;
    

    printf("a is %d\n", a);
    printf("b is %f\n", b);
    printf("c is %lf\n", c); 
    printf("c, d is %lf %lf\n", c, d); 
    printf("c, d is %12.4e %12.4e\n", c, d); 

    long N = 1;
    long J = 2;
    long K = 3;
    double X1 = 4.0;
    double X2 = 5.0;
    double X3 = 6.0;
    double X4 = 7.0;
    
    printf("%7ld %7ld %7ld %12.4e %12.4e %12.4e %12.4e\n", N, J, K, X1, X2, X3, X4);
    print_in_fn(N, J, K, X1, X2, X3, X4);
    
    return 0;
}

void print_in_fn(long N, long J, long K, double X1, double X2, double X3, double X4)
{
	printf("%7ld %7ld %7ld %12.4e %12.4e %12.4e %12.4e\n", N, J, K, X1, X2, X3, X4);
}

