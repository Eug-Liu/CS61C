#include <stdio.h>
#include <string.h>
#include "hashtable.h"

// Custom hash function for strings
unsigned int customStringHashFunction(void *key) {
    char *str = (char *)key;
    int hash = 0;
    while (*str) {
        hash = hash * 31 + *str;
        str++;
    }
    return hash;
}

// Custom equal comparison function for strings
int customStringEqualFunction(void *key1, void *key2) {
    return strcmp((char *)key1, (char *)key2) == 0;
}

int main() {
    HashTable *table = createHashTable(10, customStringHashFunction, customStringEqualFunction);

    char key1[] = "apple";
    char data1[] = "A fruit";
    insertData(table, key1, data1);

    char key2[] = "banana";
    char data2[] = "Another fruit";
    insertData(table, key2, data2);

    char key3[] = "Cat";
    char data3[] = "Animal";
    insertData(table, key3, data3);

    char key4[] = "dog";
    char data4[] = "from wolf";
    insertData(table, key4, data4);

    char searchKey[] = "dog";
    char *result = (char *)findData(table, searchKey);

    if (result) {
        printf("%s: Data found: %s\n", searchKey, result);
    } else {
        printf("Data not found for key: %s\n", searchKey);
    }

    // Free the memory allocated for the hash table
    freeHashTable(table);

    return 0;
}