module precompiler.implementations.object;
import precompiler.clib.stdlib;
import core.stdc.string;
import core.vararg;
import precompiler.clib.stdio;

/**
*   Provides a way for every Hip_Object/Struct being able to be returned
*/
mixin template Hip_Object(string objName)
{
    char* toString() const
    {
        return objName;
    }
}

/**
*   Internal memory, shoul not mess with!
*   It will be destroyed on the end
*/


private:
static void** newCalls = null;
static size_t newCount = 0;
static size_t newSize = 0;
static size_t newCountPattern = 8;

public:
/**
*   Allocates objects in a controlled heap
*/
template New(T)
{
    T* New(size_t quant = 1)
    {
        import precompiler.implementations.string : Hip_cString;
        newCount++;
        if(newCount>= newSize)
        {
            newSize+= newCountPattern;
            newCalls = cast(void**)realloc(newCalls, newSize * (void*).sizeof);
        }
        newCalls[newCount-1] = malloc(T.sizeof * quant);
        if(newCalls[newCount-1] == null)
            perror("Out of memory");
        else
        {
            memset(newCalls[newCount-1], 0, T.sizeof * quant);
            //Initialize it with arguments

        }
        return cast(T*)newCalls[newCount - 1];
    }
}


void Destroy(T)(ref T* pointer)
{
    for(size_t i = 0; i < newCount; i++)
    {
        if(pointer == newCalls[i])
        {
            free(newCalls[i]);
            newCalls[i] = null;
            pointer= null;
        }
    }
}