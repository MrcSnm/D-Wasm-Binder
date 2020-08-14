module precompiler.implementations.dynarray;
extern(C):
import core.stdc.string;
import precompiler.clib.stdio;
import precompiler.clib.stdlib;
import precompiler.implementations.array;
import precompiler.implementations.staticarray;

struct Hip_DynamicArray(T)
{
    T* arr;
    size_t capacity;
    size_t length = 0;

    this(size_t capacity)
    {
        this.reserve(capacity);
    }
    void alloc(size_t toalloc)
    {
        arr = cast(T*)realloc(arr, T.sizeof*toalloc);
    }
    void reserve(size_t capacity)
    {
        cprint("Ta reservando %u", capacity);
        if(this.capacity < capacity)
        {
            this.capacity = capacity;
            alloc(capacity);
        }
    }
    mixin Hip_ArrayImpl!(arr, T);
    auto opAssign(T)(T sArr)
    {
        this.reserve(sArr.length);
        this.length = sArr.length;
        for(int i = 0, len = sArr.length; i < len; i++)
            arr[i] = sArr[i];
        return this;
    }
    void append(T val)
    {
        if(this.length == this.capacity)
            this.reserve(this.length+16); //For decreasing realloc amount
        this[$] = val;
        this.length++;
    }
    ref auto opOpAssign(string op)(T value)
    {
        if(op == "~")
            this.append(value);
        return this;
    }
    ~this()
    {
        // puts("Deleted DynArr");
        free(this.arr);
    }

    auto dup(T)()
    {
        Hip_DynamicArray!T duplicated = Hip_DynamicArray!T(this.capacity);
        for(int i = 0, len = this.length; i < len; i++)
            duplicated[i] = this[i];
        return duplicated;
    }
}