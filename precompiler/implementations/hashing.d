module precompiler.implementations.hashing;
extern(C):

/**
*   Default implementation if no specialized type is passed
*/
size_t hashFunction(auto obj)
{
    return cast(size_t)(cast(void*)obj);
}

/**
*   
*/
size_t hashFunction(char* str)
{

}