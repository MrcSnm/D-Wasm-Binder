module precompiler.precompiler;
import precompiler.regexmount;
import std.getopt;
import std.file;
import std.conv : to;
import std.stdio, std.regex;
import std.format : format;

string[string] implementations;
enum string defImplImport = "precompiler.implementations";

enum string defImplFolder = "d-to-c";

enum string[] implList =
[
    "associative-array"
];

void getImplmentations(string path)
{
    // foreach(implement; implList)
    //     implementations[implement] = fileContents(path~implement);
}

/**
 * The current support only allows setting as private, public or protected if you use it in another line, so instead of
 * doing public int[string] mapIntString;
 * do public: 
 *      int[string] mapIntString;
 * This way, the precompile won't break anything
*/ 
string associativeArray(string code)
{
    //Get the associative array definition
    string ncode = code;
    //Anything until finding last [], which contains a string that can't start with number, it can have a space and can't have any operator

    static auto aaDef = gm(varType.group ~ varType.betweenBrackets.group.anySpace ~ varDef.group ~ ";$"); //Matches int[string] myvar 
    bool[string] aaDefinitions;
    foreach(m; matchAll(ncode, aaDef)) //Store definitions
    {
        aaDefinitions[m[3]] = true;
        // writeln("Found definition "~ m[3]);
    }
    
    ncode = replaceAll(ncode, aaDef, "$3 = map!($1, $2)");

    //Replace associative array setter
    static auto aaSet = gm(varAa.assign ~ valueNoSpace.group ~ ";$"); //Matches myvar[var2] = something
    string replaceMapSet(Captures!string m)
    {
        //M1 = variable definition
        if(m[1] in aaDefinitions)
        {
            string _set = format!"aaSet(%s, %s, %s);"(m[1], m[2], m[3]);
            // writeln("Replaced "~m.hit~" to "~_set);
            return _set;
        }
        return m.hit;
    }
    ncode = replaceAll!replaceMapSet(ncode, aaSet);

    //Replace associative array getter
    string replaceMapGet(Captures!string m)
    {
        if(m[1] in aaDefinitions)
        {
            string _get = format!"aaGet(%s, %s)"(m[1], m[2]);
            // writefln("Replaced %s to %s", m.hit, _get);
            return _get;
        }
        return m.hit;
    }
    static auto aaGet = varAa.gm;
    ncode = replaceAll!replaceMapGet(ncode, aaGet);

    appendModuleImports(ncode, defImplImport, ["aa"]);
    return ncode;
}

void appendModuleImports(ref string code, string importPath, string[] deps)
{
    string addDeps(Captures!string m)
    {
        if(deps.length > 0)
        {
            string ret = m.hit~"\n";
            foreach(dep;deps)
            {
                // writefln("Added %s to imports", dep);
                ret~= format!"import %s.%s;\n"(importPath, dep);
            }
            return ret;
        }
        return m.hit;
    }
    auto reg = regex(r"module \S+", "m");
    code = replace!addDeps(code, reg);
}


int showHelp(GetoptResult res)
{
    defaultGetoptPrinter("", res.options);
    return 2;
}

int main(string[] args)
{
    string output;
    string implFolder = defImplFolder;
    bool aa = true;
    auto opts = getopt
    (
        args,
        "output|o", &output,
        "impl-folder|impl", &implFolder,
        "associative-array|aa", &aa
    );
    if(opts.helpWanted)
        return showHelp(opts);

    writeln(associativeArray(std.file.readText("/home/hipreme/Desktop/HipremeEngine/source/sdl/event/handlers/keyboard.d")));
    // associativeArray(std.file.readText("/home/hipreme/Desktop/HipremeEngine/source/sdl/event/handlers/keyboard.d"));
    return 1;
}   