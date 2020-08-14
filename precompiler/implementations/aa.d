module precompiler.implementations.aa;
import precompiler.implementations.dynarray;
import precompiler.implementations.hashing;
import precompiler.implementations.object;
import precompiler.implementations.string;
import precompiler.clib.stdio;
import core.stdc.string;

struct Hip_Pair(K, V)
{
    K key;
    V value;
}

private struct Hip_Bucket(K, V)
{
    Hip_DynamicArray!(Hip_Pair!(K, V*)) pairs;
    
    void appendPair(K key, V* val)
    {
        cprint("Appended %d as %s", *val, key);
        Hip_Pair!(K,V*) pair;
        pair.key = key;
        pair.value = val;
        pairs~= pair;
        cprint("Appended %d as %s", *val, key);
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
        Hip_AssociativeArray!(K,V) aa;
        aa.table = Hip_DynamicArray!(Hip_Bucket!(K,V))(Hip__INITIAL_AA_SIZE);

        for(int i = 0, len = Hip__INITIAL_AA_SIZE; i < len; i++)
        {
            Hip_Bucket!(K,V) buck;
            buck.pairs.reserve(4);
            aa.table~= buck;
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
        import precompiler.implementations.string;
        Hip_Bucket!(K,V) ret = table[hash(key)];
        size_t count = 0;
        while(count < ret.pairs.length)
        {
            if(key == ret.pairs[count].key)
            {
                cprint("MITSUKETA K:%s V:%d", ret.pairs[count].key, *ret.pairs[count].value);
                return ret.pairs[count].value;
            }
            count++;
        }
        return null;
    }
    // V* get(string key){return get(cast(char*)key);}
    void set(K key, V val)
    {
        if(this.get(key) == null)//If a key is not replaced
        {
            _count++;
            size_t i = hash(key);
            V* toStore = New!V;
            *toStore = val;
            
            // cprint("K: %s, V: %d", key, *toStore);
            table[i].appendPair(key, toStore);
            // cprint("Hash for %s is %u", key, hash(key));
            // if(count> _size*0.75)growSize();
        }
        else
        {
            auto bucket = table[hash(key)];
            // Destroy(bucket.value);
            // bucket.
        }
        
    }
    mixin("ref V opIndex(K key){return *this.get(key);}");


    @property bool isEmpty(){return table.length == 0;}
    private size_t hash(K key){return hashFunction(key) & table.length-1;}
    // auto opIndexAssign(T)(T value, K key){set(key, value);return value;}
    ~this()
    {
        puts("Destroyed AA");
        for(int i = 0, len = this.table.length; i < len; i++)
            destroy(table[i]); //DynArray already got free call
        destroy(table);
    }

    private size_t _size;
    private size_t _count;
}