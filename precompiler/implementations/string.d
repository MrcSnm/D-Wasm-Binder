module precompiler.implementations.string;
import std.conv : to;
import core.stdc.string;
import precompiler.clib.stdio;
import precompiler.clib.stdlib;

auto asCStr(T : string)(T value){return cast(char*)value;}
auto asCStr(T : float)(T value){char* temp; sprintf(temp, "%f", value); return temp;}
auto asCStr(T : int)(T value){char* temp; sprintf(temp, "%d", value); return temp;}
auto asCStr(T : size_t)(T value)
{
    char* temp;
    static if(size_t.sizeof == uint.sizeof)
        sprintf(temp, "%u", value);
    else static if(size_t.sizeof == ulong.sizeof)
        sprintf(temp, "%lu", value);
    return temp;
}

/**
*   Used only for generating functions for formatting strings
*/
// char* format(T, A...)(T f, A arg)
// {
//     uint currArg = 0;
//     uint c = 0;
//     bool escaped = false;
//     uint retCount = 0;
//     uint currSize = 32;
//     char* ret = cast(char*)malloc(32); //32 As initial size

//     while(f[c] != 0)
//     {
//         if(escaped && f[c] == 's')
//         {
//             char* temp =  asCStr(arg[currArg]);
//             uint tempC = strlen(temp);
//             if(tempC + retCount >= currSize)
//             {
//                 currSize<<= 1;
//                 ret = cast(char*)(realloc(ret, currSize));
//             }
//             retCount+= tempC;
//             strcat(ret, temp);
//             currArg++;
//         }
//         else
//         {
//             if(!escaped && f[c] == '%')
//                 escaped = true;
//             else
//             {
//                 ret[retCount]=f[c];
//                 retCount++;
//                 if(retCount >= currSize)
//                 {
//                     currSize<<= 1;
//                     ret = cast(char*)(realloc(ret, currSize));
//                 }
//                 escaped = false;
//             }
//         }
//         c++;
//     }
//     return strcat(ret, "\0");
// }

extern(C):
struct Hip_cString
{
    
    char* str;
    size_t length;

    auto opAssign(T : char*)(T value)
    {
        str = value;
        length = strlen(value);
        puts(str);
        return this;
    } 
    auto opAssign(T : string)(T value){return opAssign(asCStr(value));}
    auto opAssign(T : int)(T value){return opAssign(asCStr(value));}
    auto opAssign(T : float)(T value){return opAssign(asCStr(value));}

    auto opOpAssign(string op, T)(T value)
    {
        if(op == "~")
        {
            char* s = asCStr(value);
            length+= strlen(s);
            strcat(str, s);
        }
        return this;
    }

    ref auto opIndex(size_t index){return str[index];}
    auto opIndexAssign(T)(T value, size_t index)
    {
        str[index] = asCStr(value);
        return value;
    }
}

// Hip_cString create(immutable(char)* initStr)
// {
//     Hip_cString str = Hip_cString();
//     str = Hip_cString();
//     str.str = initStr;
//     str.length = strlen(initStr);
//     return str;
// }

extern(C) int ret500()
{
    int b = 500;
    int d = 200;
    return b+d;
}