/* 
 * Program to test divide by zero error handling
 * Malcolm Harrow, March 2024
 *
 */

// #include "stdio.h"
#include "debug_stub.h"

int kmain() {
    debug_stub();
    
    int i=0;
    int j=10;
    int k;

    k = j / i;
    return k;
}
