module precompiler.implementations.hashing;
import precompiler.implementations.dynarray;
import std.conv : to;
import precompiler.implementations.string : asCStr;
import precompiler.clib.stdio;

// extern(C):
size_t toAddress(T)(ref T t)
{
    return cast(size_t)(cast(void*)&t);
}

//Optimization 1 for hashFunction
//Instead of using Modulo operator(%), use always pow of 2 size
//And then use and operator(&)

size_t _hashFunction(char* str)
{
    size_t c = 0;
    size_t hash =0;
    while(str[c] != 0)
    {
        hash+=str[c] * (c+1);
        //if(c>0)
            //hash+= str[c-1]*c;
        c++;
    }
    return hash;
}


size_t hashFunction(void* arg)
{
    return _hashFunction(asCStr(cast(size_t)arg));
}
size_t hashFunction(char* arg)
{
    return _hashFunction(arg);
}
size_t hashFunction(immutable(char)* arg)
{
    return _hashFunction(cast(char*)arg);
}
size_t hashFunction(int arg)
{
    return _hashFunction(asCStr(arg));
}
size_t hashFunction(float arg)
{
    return _hashFunction(asCStr(arg));
}

size_t hashFunction(T)(T arg)
{
    cprint("Something really strange happened at hash function");
    return 0;
}