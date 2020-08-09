#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include "dynarray.h"


void placeStr(DynArray* arr, const char* str)
{
    dynSet(arr, ++arr->currentSize, str);
}


void main()
{
    DynArray d = newDynArray(sizeof(long int), 4);
    float t = 5.5f;
    dynSet(&d, 0, "opa filhao");
    dynSet(&d, 1, "teste dois barra zero");
    dynSet(&d, 2, "tuma string literalmente muito grande");


    char* a = dynGet(&d, 1);

    
    // dynSet(&d, 1, (const char*)"marcelo is really taking it very loudly");
    // dynSet(&d, 2, (const char*)"my really really fucking long fucking string");
    printf("%s", a);
    // free(&d);
}