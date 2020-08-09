module precompiler.dlib.stdio;
import precompiler.clib.stdlib;
import precompiler.clib.stdio;
import core.stdc.string;
import std.conv : to;
import std.string;
extern(C):


// void writeln(args...)()
// {
//     size_t length = 127; //Initial length for not realloc too much
//     char* msg = cast(char*)malloc(127);
//     strcat(msg, "\n\n");
//     size_t currentLength = 0;
    
//     foreach(a;args)
//     {
//         currentLength+=strlen(a);
//         if(currentLength>=length)
//         {
//             //Guarantees to have free space in case next string is shorter
//             length+= strlen(a) + 127; 
//             msg = cast(char*)realloc(msg, length);
//         }
//         strcat(msg, a);
//         strcat(msg, ", ");
//     }
//     puts(msg);
//     free(msg);
// }