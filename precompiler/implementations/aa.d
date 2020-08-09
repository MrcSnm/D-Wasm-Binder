module precompiler.implementations.aa;
extern(C):
import precompiler.implementations.dynarray;
import precompiler.implementations.hashing;

struct Hip_Pair(K, V)
{
    K key;
    V value;
}

enum Hip__INITIAL_AA_SIZE = 100;

struct Hip_AssociativeArray(K, V)
{
    Hip_DynamicArray!V table;

    this()
    {
        table = Hip_DynamicArray!V(Hip__INITIAL_AA_SIZE);
    }

    bool isEmpty(){return table.length == 0;}
    private size_t hash(K key);
    void set(K key, V val)
    {
        
    }
}