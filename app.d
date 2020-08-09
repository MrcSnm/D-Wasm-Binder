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
import precompiler.dlib.stdio;
import core.stdc.string;
import precompiler.implementations.object;


struct MTest
{
    int[10] arr;
    int opIndex(int ind)
    {
                
        arr[ind] = 500;
        return arr[ind];
    }
    mixin Hip_Object!"MTest";
}

double add(double a, double b)
{
    auto arr = Hip_DynamicArray!int(3);
    int counter = 0;

    // arr.precompilerAssign(3, 500, 200, 100);
    auto stArr = Hip_StaticArray!(int, 3)(200, 100, 500);
    arr = stArr;
    // arr ~= 232; 
    foreach(i, num; arr.enumerate)
        counter = i;

    return counter;
}

const(char*) mtest()
{
    return toStringz("OI");
}
void _start()
{
}