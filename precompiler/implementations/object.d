module precompiler.implementations.object;

extern(C):

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