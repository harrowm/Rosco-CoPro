/* 
 * Program to test divide by zero error handling
 * Malcolm Harrow, March 2024
 *
 */

int main() {
    volatile int i=0; // volatiles to stop compiler trying to optimise
    volatile int j=10;
    volatile int k;

    k = j / i;
    return k;
}
