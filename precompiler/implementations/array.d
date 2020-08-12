module precompiler.implementations.array;
import std.conv:to;
/**
*   Basic array operators, array must have property "length"
*   Implements:
*   opIndex
*   opIndexAssign
*   opDollar
*   opApply(empty,front,popFront)
*    Not supported yet -> 
*       opApplyReverse(save, popBack, back
*/
mixin template Hip_ArrayImpl(alias arrName, T)
{
    T opIndex(size_t ind){return arrName[ind];}
    T opIndexAssign(T value, size_t index)
    {
        // if(this.length < index)
        //     printf("\nSomething happened\n");
        //, (arrName~"["~to!string(index)~"]Out of range");
        arrName[index] = value;
        return value;
    }
    size_t opDollar(){return this.length;}

    //Foreach implementation as range(for some reason opApply don't work)
    size_t _feachBegin;
    bool empty(){return (_feachBegin == this.length);}
    void popFront(){_feachBegin++;}
    T front(){return arrName[_feachBegin];}
    size_t back(){return this.length - 1;}
    void popBack(){_feachBegin--;}
    auto save()
    {
        return this;
    }
}