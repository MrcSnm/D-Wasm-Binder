/**
*   Provides default C functions to use in this project.
*   Although named as stdlib, it contains functions from other
*   Modules.
*/
module precompiler.clib.stdlib;
extern(C):
import core.stdc.stdarg;
void*   malloc(size_t size);
void*   calloc(size_t nmemb, size_t size);
void*   realloc(void* ptr, size_t size);
void    free(void* ptr);
int     atoi(const char* str);
int     sprintf(char*str, const char* format, ...);
int     vsprintf(char*str, const char* format, va_list args);
void    perror(const char* str);