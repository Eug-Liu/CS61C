#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "lfsr.h"

void lfsr_calculate(uint16_t *reg) {
    /* YOUR CODE HERE */
    int r0, r2, r3, r5;
    uint16_t copy = *reg, mask = 1, r;
    r0 = copy & mask;
    copy >>= 2;
    r2 = copy & mask;
    copy >>= 1;
    r3 = copy & mask;
    copy >>= 2;
    r5 = copy & mask;
    r = r0 ^ r2 ^ r3 ^ r5;
    r <<= 15;
    *reg = (*reg >> 1) | r;
}

