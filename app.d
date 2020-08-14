extern(C++, class)class Test
{
    private int a;
    alias toString = Object.toString;
    alias toHash = Object.toHash;
    this()
    {
        a = 50;
    }
    int get(){return this.a;}
    string toString(){return "";}
    string toHash(){return "";}
    bool opCmp(){return false;}
    bool opEquals(){return false;}
}
extern(C):
import std.string : toStringz;
import std.conv : to;
import std.range : enumerate;
import precompiler.implementations.dynarray;
import precompiler.implementations.staticarray;
import core.stdc.string;
import precompiler.implementations.object;
import precompiler.implementations.aa;
import precompiler.implementations.string;
import precompiler.clib.stdio;
import precompiler.clib.stdlib;
import precompiler.implementations.hashing;

struct MTest
{
    int[10] arr;
    int opIndex(int ind)
    {
                
        arr[ind] = 500;
        return arr[ind];
    }
    // mixin Hip_Object!"MTest";
}


double add(double a, double b)
{
    // auto arr = Hip_DynamicArray!int(8);
    // int counter = 0;
    
    // auto stArr = Hip_StaticArray!(int, 3)(200, 100, 500);
    // arr = stArr;
    // arr ~= 232; 

    // puts(str.str);
    // cprint("Teste aqui %d", 5);
    // auto aa = Hip_AssociativeArray!(int, int).create;
    // aa.set(5, 10);
    // auto bar = aa.get(5);
    // if(bar == null)
    // {
    //     puts("Merda");
    // }
    // else puts("Nice");
    
    auto arr = Hip_AssociativeArray!(char*, int).create;
    char* t = cast(char*)"ieme";
    arr.set(t, 500);
    cprint("%u", hashFunction(t));
    return arr[t];
    // arr.set(5, 10);
    // int* ret = arr.get(5);
    // return *ret;

    // size_t sz = cast(size_t)(cast(void*)&arr);
    // // puts(cast(char*)sz);
    // foreach(num; arr)
    //     counter+=num;

    return 0;
}

void aaTest()
{
    // auto arr = Hip_AssociativeArray!(int, int).create;
    // arr.set(5, 10);
    


    // auto str = Hip_cString("teste");

}
void _start()
{
}