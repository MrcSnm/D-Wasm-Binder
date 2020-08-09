#include "dynarray.h"
#include <memory.h>
#include <stdlib.h>



DynArray newDynArray(unsigned long typeSize, unsigned long size)
{
  DynArray* d = malloc(sizeof(DynArray));
  start(d, size, typeSize);
  return *d;
}

void dynAlloc(DynArray* arr, unsigned long quant)
{
  arr->arr = realloc(arr->arr, quant*arr->typeSize);
}

void dynSet(DynArray* arr, unsigned long index, void* val)
{
    if(arr->currentSize > index)
    {
        
        arr->arr[index*arr->typeSize] = val;
    }
}

void* dynGet(DynArray* arr, unsigned long ind)
{
    return arr->arr[ind * arr->typeSize];
}

void start(DynArray *arr, unsigned long quant, unsigned long typeSize)
{
  arr->currentSize = quant;
  arr->typeSize = typeSize;
  if(quant != 0)
    dynAlloc(arr, quant);
}

void reserve(DynArray *arr, unsigned long quant)
{
  if(arr->currentSize< quant)
    dynAlloc(arr, quant);
}


void __DESTROY_DYN_ARRAYS(void)
{
    
}