#ifndef DYNARRAY_H
#define DYNARRAY_H


typedef struct
{
  unsigned long currentSize;
  unsigned long allocated;
  unsigned long typeSize;
  void** arr;
}DynArray;

DynArray newDynArray(unsigned long type, unsigned long size);
void dynSet(DynArray* arr, unsigned long index, void* val);
void* dynGet(DynArray* arr, unsigned long ind);
void dynAlloc(DynArray* arr, unsigned long quant);
void start(DynArray *arr, unsigned long quant, unsigned long typeSize);
void reserve(DynArray *arr, unsigned long quant);


#endif