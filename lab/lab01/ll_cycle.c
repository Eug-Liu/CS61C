#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    /* your code here */
    struct node hare;
    struct node tortoise;
    tortoise.next = &hare;
    hare.value = 5;
    printf("%d", hare.value);
    return 0;
}
