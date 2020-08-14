module precompiler.implementations.string;
import std.conv : to;
import core.stdc.string;
import precompiler.clib.stdio;
import precompiler.implementations.object;
import precompiler.clib.stdlib;

auto asCStr(T : string)(T value){return cast(char*)value;}
auto asCStr(T : float)(T value)
{
    char* temp;
    sprintf(temp, "%f", value);
    char* ret = New!char(strlen(temp)+1);
    strcpy(ret, temp);
    return ret;
}
auto asCStr(T : int)(T value)
{
    char* temp;
    sprintf(temp, "%d", value);
    char* ret = New!char(strlen(temp)+1);
    strcpy(ret, temp);
    return ret;
}
auto asCStr(T : size_t)(T value)
{
    char* temp;
    static if(size_t.sizeof == uint.sizeof)
        sprintf(temp, "%u", value);
    else static if(size_t.sizeof == ulong.sizeof)
        sprintf(temp, "%lu", value);
    char* ret = New!char(strlen(temp)+1);
    strcpy(ret, temp);
    return ret;
}
struct Hip_cString
{
    
    char* str;
    size_t length;

    static auto opCall(T: string)(T str)
    {
        char* buf = cast(char*)str;
        Hip_cString ret;
        ret.str = buf;
        ret.length = strlen(buf);
        return ret;
    }
    static auto opCall(T: char*)(T initStr)
    {
        Hip_cString ret;
        ret.str = initStr;
        ret.length = strlen(initStr);
        return ret;
    }

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