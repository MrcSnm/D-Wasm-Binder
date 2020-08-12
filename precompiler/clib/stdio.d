module precompiler.clib.stdio;
import core.stdc.stdarg;
import precompiler.clib.stdlib : vsprintf;

extern(C):
int printf(const char* format, ...);
int vprintf(const char* format, va_list args);
int cprint(const char* format, ...)
{
    va_list arg;
    va_start(arg, format);
    char* target;
    vsprintf(target, format, arg);
    va_end(arg);
    return puts(target);
}
int puts ( const char * str );
// int putsS(string str)
// {
//     return mixin("puts(cast(char*)str)");
// }