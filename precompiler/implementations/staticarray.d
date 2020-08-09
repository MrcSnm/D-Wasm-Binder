module precompiler.implementations.staticarray;
import std.conv : to;
import std.range : iota;
import precompiler.implementations.array;

/**
*   This will create variadic args(while not supported on wasm)
*/
static private string generateConstructor(T)(size_t size, string arrName)
{
    bool isFirst = true;
    string _constructor = "this(";
    for(int i = 0; i < size; i++)
    {
        if(!isFirst)
            _constructor~=", ";
        _constructor~="T data"~to!string(i);
        isFirst = false;
    }
    _constructor~="){";
    
    for(int i = 0; i < size; i++)
        _constructor~=arrName~"["~to!string(i)~"] = data"~to!string(i)~";";
    _constructor~="}";
    return _constructor;
}

/**
*   This array will be used only when assigning to a dynamic array,
*   As a structure for defining array [9, 6, 4] is considered druntime dependent
*/ 
struct Hip_StaticArray(T, size_t SIZE)
{
    size_t length = SIZE;
    T[SIZE] arr;
    static if (SIZE != 0)
    {
        mixin(generateConstructor!T(SIZE, "arr"));
        pragma(msg, generateConstructor!T(SIZE, "arr"));
    }
    
    mixin Hip_ArrayImpl!(arr, T);
}