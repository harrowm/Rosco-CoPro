/* 
 * Program to test divide by zero error handling
 * Malcolm Harrow, March 2024
 *
 */

#include "stdio.h"
#include "debug_stub.h"

int kmain() {
    debug_stub();
    
    int i=0;
    int j=10;

    printf("Size of long %ld\n", sizeof(long));
    printf("Div by zero trap (0x14) set to %lX\n", *(long *) 0x14);
    printf("F-line trap (0x2C) set to %lX\n", *(long *) 0x2C);
    printf("About to divide by zero ..\n");

    printf("Answer (int) %d\n", j/i);

    return 0;
}
