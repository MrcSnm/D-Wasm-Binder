module precompiler.implementations.hashing;
import precompiler.implementations.dynarray;
import std.conv : to;
extern(C):

size_t toAddress(T)(ref T t)
{
    return cast(size_t)(cast(void*)&t);
}

//Optimization 1 for hashFunction
//Instead of using Modulo operator(%), use always pow of 2 size
//And then use and operator(&)


/**
*   Default implementation if no specialized type is passed
*/


size_t hashFunction(void*  obj)
{
    return hashFunction(cast(size_t*)obj);
}
/**
*   
*/
size_t hashFunction(char*  str)
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

size_t hashFunction(immutable(char)* str)
{
    return hashFunction(cast(char*)str);
}


size_t hashFunction(T)(ref T str)
{   
    import precompiler.implementations.string : asCStr;
    return hashFunction(asCStr(str));
}