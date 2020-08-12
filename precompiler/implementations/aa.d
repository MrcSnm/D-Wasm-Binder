module precompiler.implementations.aa;
import precompiler.implementations.dynarray;
import precompiler.implementations.hashing;
import precompiler.implementations.object;

struct Hip_Pair(K, V)
{
    K key;
    V value;
}

struct Hip_Bucket(K, V)
{
    Hip_DynamicArray!(Hip_Pair!(K, V*)) pairs;

    void appendPair(K key, V* val)
    {
        auto pair = Hip_Pair!(K,V*)();
        pair.key = key;
        pair.value = val;
        pairs~= pair;
    }
}

static enum Hip__INITIAL_AA_SIZE = 128;

struct Hip_AssociativeArray(K, V)
{
    Hip_DynamicArray!(Hip_Bucket!(K,V)) table;

    // static Hip_AssociativeArray!(K, V) opCall()
    // {
        // auto arr = Hip_AssociativeArray!(K,V).init;
        // arr.table = Hip_DynamicArray!(Hip_DynamicArray!(Hip_Pair!(K,V*)))(Hip__INITIAL_AA_SIZE);
        // arr._size = Hip__INITIAL_AA_SIZE;
        // return arr;
    // }

    static ref auto create()
    {
        import precompiler.clib.stdio : puts;
        Hip_AssociativeArray!(K,V)* aa = New!(Hip_AssociativeArray!(K,V));
        *aa = Hip_AssociativeArray!(K,V)();
        puts("Added key!");
        (*aa).table = Hip_DynamicArray!(Hip_Bucket!(K,V))(Hip__INITIAL_AA_SIZE);

        for(int i = 0, len = Hip__INITIAL_AA_SIZE; i < len; i++)
        {
            (*aa).table[i] = Hip_Bucket!(K,V)();
            (*aa).table[i].pairs.reserve(4);//Low sized
        }
        aa._size = Hip__INITIAL_AA_SIZE;
        return aa;
        
    }

    // private void growSize()
    // {
    //     _size<<= 1;//Grow in pow of 2
    //     //Rehash
    // }
    
    V* get(K key)
    {
        Hip_Bucket!(K,V) ret = table[hash(key)];
        size_t count = 0;
        while(count < ret.pairs.length)
        {
            
            if(key == ret.pairs[count].key)
                return ret.pairs[count].value;
            count++;
        }
        return null;
    }
    void set(K key, V val)
    {
        if(this.get(key) == null)//If a key is not replaced
        {
            _count++;
            size_t i = hash(key);
            table[i].appendPair(key, &val);
            // if(count> _size*0.75)growSize();
        }
        else
        {
            auto bucket = table[hash(key)];
        }
        
    }


    // bool isEmpty(){return table.length == 0;}
    private size_t hash(K key){return hashFunction(key) & table.length-1;}
    // ref auto opIndex(K index){return get(index);}
    // auto opIndexAssign(T)(T value, K key){set(key, value);return value;}
    ~this()
    {
        import precompiler.clib.stdio : puts;
        puts("Destroyed AA");
    }

    private size_t _size;
    private size_t _count;
}