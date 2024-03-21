#include "hashtable.h"
#include <stdlib.h>
#include <stdio.h>

/*
 * This creates a new hash table of the specified size and with
 * the given hash function and comparison function.
 */
HashTable *createHashTable(int size, unsigned int (*hashFunction)(void *),
                           int (*equalFunction)(void *, void *)) {
  int i = 0;
  HashTable *newTable = malloc(sizeof(HashTable));
  newTable->size = size;
  newTable->data = malloc(sizeof(struct HashBucket *) * size);
  for (i = 0; i < size; ++i) {
    newTable->data[i] = NULL;
  }
  newTable->hashFunction = hashFunction;
  newTable->equalFunction = equalFunction;
  return newTable;
}

void readData(HashTable *table, int loc) {
    HashBucket *ptr = table->data[loc];
    printf("Bucket number %d: ", loc);
    while(ptr) {
        printf("<key: %s, data: %s> ", ptr->key, ptr->data);
        ptr = ptr->next;
    }
}

/*
 * This inserts a key/data pair into a hash table.  To use this
 * to store strings, simply cast the char * to a void * (e.g., to store
 * the string referred to by the declaration char *string, you would
 * call insertData(someHashTable, (void *) string, (void *) string).
 * Because we only need a set data structure for this spell checker,
 * we can use the string as both the key and data.
 */
void insertData(HashTable *table, void *key, void *data) {
  // -- TODO --
  // HINT:
  // 1. Find the right hash bucket location with table->hashFunction.
  // 2. Allocate a new hash bucket struct.
  // 3. Append to the linked list or create it if it does not yet exist. 
  int loc = table->hashFunction(key) % table->size;
  if (table->data[loc]) {
    HashBucket *ptr = table->data[loc];
    while(ptr && ptr->next != NULL) {
        ptr = ptr->next;
    }

        HashBucket *newBucket = malloc(sizeof(HashBucket));
        newBucket->key = key;
        newBucket->data = data;
        newBucket->next = NULL;
        ptr->next = newBucket;
  } else {
    HashBucket *newBucket = malloc(sizeof(HashBucket));
    newBucket->key = key;
    newBucket->data = data;
    newBucket->next = NULL;
    table->data[loc] = newBucket;
  }
  
}

/*
 * This returns the corresponding data for a given key.
 * It returns NULL if the key is not found. 
 */
void *findData(HashTable *table, void *key) {
  // -- TODO --
  // HINT:
  // 1. Find the right hash bucket with table->hashFunction.
  // 2. Walk the linked list and check for equality with table->equalFunction.
  int loc = table->hashFunction(key) % table->size;
  HashBucket *ptr = table->data[loc];
  while (ptr) {
    if (table->equalFunction(ptr->key, key)) {
        return ptr->data;
    }
    ptr = ptr->next;
  }

  ptr = NULL;
  return NULL;
}

void freeHashTable(HashTable *table) {
    for (int i = 0; i < table->size; ++i) {
        HashBucket *entry = table->data[i];
        while (entry != NULL) {
            HashBucket *temp = entry;
            entry = entry->next;
            free(temp);
        }
    }
    free(table->data);
    free(table);
}