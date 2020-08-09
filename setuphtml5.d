module setuphtml5;
import std;

enum wasmTriple = "wasm32-unknown-unknown-wasm";
enum string[] EMScriptenLibs =
[
          "USE_SDL=2",
          "USE_OGG=1",
       "USE_VORBIS=1",
    "USE_SDL_IMAGE=2",
    "USE_SDL_MIXER=2",
      "USE_SDL_TTF=2",
      "USE_SDL_NET=2",
];

//Uses a dummy file named $libName for that
enum libName = "libs";

void buildSource()
{
    string command = format!"ldc2 -mtriple=%s --output-bc -betterC "(wasmTriple);
    

}

void buildLib()
{
    string command = format!"emcc -O3 %s.cpp "(libName);

    foreach(lib; EMScriptenLibs)
        command~= format!"-s %s "(lib);
    
    command~= format!" -o lib/%s.js"(libName);
    writeln(command);
}

void main()
{
    buildLib();
}