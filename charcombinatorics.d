module charcombinatorics;
import core.stdc.string;
import std;

void generation(ref string[] arr, string base, ushort lengthRemaining, const ref char* characterSet, const ref ushort charsetLength)
{
    if(lengthRemaining == 0)
        arr~=base;
    else
    {
        for(ushort i = 0; i < charsetLength; i++)
            generation(arr, base~characterSet[i], cast(ushort)(lengthRemaining-1), characterSet, charsetLength);
    }
}

string[] generate(int iterations, char* characterSet)
{
    ushort charsetLen = cast(ushort)strlen(characterSet);
    uint arrLen = charsetLen;
    for(int i = 1; i < iterations;i++)
        arrLen*= charsetLen;
    
    string[] ret;
    ret.reserve(arrLen);
    for(ushort i = 1; i <= iterations; i++)
    {
        generation(ret , "", i, characterSet, charsetLen);
    }
    return ret.dup;
}

string[] alphabetCombinatorics(int maxLength)
{
    char* set = cast(char*)"abcdefghijklmnopqrstuvwxyz";
    return generate(maxLength, set);
}

void main()
{
    string[] alpha = alphabetCombinatorics(2);
    File f = File("mega.txt", "a");
    foreach(str; alpha)
        f.writeln("hashFunction(\""~str~"\");");
    
    f.close();
    // Pid pid = spawnProcess("echo " ~ megabuffer ~ "> %CD%\\mega.txt");
    // pid.wait;
}