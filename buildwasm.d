#!/usr/bin/rdmd
module buildwasm;
import std;

string compiler = "ldc2";
string[] archs = ["wasm32"];
string emscriptenPath;

string[] sourcePaths = [
	"precompiler/implementations",
	"precompiler/dlib",
	"precompiler/clib",
	// These should be local git submodules or something instead of getting them from the ~/.dub/packages
];

string[] sdlLibs =
[
	"USE_SDL=2",
	"USE_OGG=1",
	"USE_VORBIS=1",
	"USE_SDL_IMAGE=2",
	"USE_SDL_MIXER=2",
	"USE_SDL_TTF=2",
	"USE_SDL_NET=2"
];
string[] versions = 
[
	
];

string[] exportedFunctions = //Functions to export to emcc
[
	"add"
];
string[] exportedRtMethods =
[
	"ccall",
	"cwrap"
];
string[] debugs = [];

enum tripleSystem = "unknown-unknown-wasm";


string exportToWasm(string[] toExport, string exportName, bool prependUnderline = true)
{
	if(toExport.length == 0)
		return "";
	string exp = exportName~"[";
	bool isFirst = true;
	foreach (exported; toExport)
	{
		if(!isFirst)exp~=",";
		exp~="\"";
		if(prependUnderline)
			exp~= "_";
		exp~=exported~"\"";
		isFirst = false;
	}
	return exp ~ "]";
}

string[] getSources(string path) {
	string[] files;
	foreach (DirEntry e; path.dirEntries(SpanMode.depth).filter!(f => f.name.endsWith(".d")))
		files ~= e.name;
	return files;
}

void buildProgram(string arch, string[] sources) {
	string[] command = [compiler];

	// foreach (sourcePath; sourcePaths)
		// command ~= format!"-I%s"(sourcePath);

	foreach (version_; versions)
		command ~= format!"-d-version=%s"(version_);

	command ~= format!"-mtriple=%s-%s"(arch, tripleSystem);
	command ~= "-L-allow-undefined";
	command ~= "--output-bc";
	command~= "app.d";

	foreach(source; sources)
		command~= source;

	command ~= "--of=bitcode/app.bc";

	Pid pid = spawnProcess(command);
	if(pid.wait != 0)
	{
		writeln("Build failed! Check your command:");
		writeln(command.join(" "));
	}
}

void buildSDL()
{
	if(exists("out/libs.js"))
	{
		writeln("Skipping SDL Libraries build, out/libs.js already exists");
		return;
	}
	string[] toBuild = ["emcc", "-O3", "libs.cpp"];
	foreach(lib; sdlLibs)
		toBuild~= ["-s", lib];
	toBuild~= ["-o", "out/libs.js"];
	Pid pid = spawnProcess(toBuild);
	pid.wait;
}

void buildEmscripten()
{
	string[] command = ["emcc", "-O0", "bitcode/app.bc"];
	string funcs = exportToWasm(exportedFunctions, "EXPORTED_FUNCTIONS=");
	if(funcs != "")
	{
		command~="-s";
		command~=funcs;
	}
	string rtmethods = exportToWasm(exportedRtMethods, "EXPORTED_RUNTIME_METHODS=", false);
	if(rtmethods != "")
	{
		command~="-s";
		command~=rtmethods;
	}
	command~= ["-o", "dtest/index.html"];

	// execute(command);
	Pid pid = spawnProcess(command);
	if(pid.wait() != 0)
	{
		writeln("Your emscripten build failed, check your command");
		writeln(command.join(" "));
	}
	else
	{
		writeln("Finished building EMScripten");
	}
}



void main() {
	
	emscriptenPath = environment["EMSDK"];
	if(emscriptenPath == "")
	{
		writeln("You must define the environment variable EMSDK");
		return;
	}
	emscriptenPath~="/upstream/emscripten/";
	writeln("EMSDK Path: " ~ environment["EMSDK"]);
	string[] sources;

	foreach (sourcePath; sourcePaths)
		sources ~= sourcePath.getSources;
	foreach (arch; archs)
		buildProgram(arch, sources);
	buildSDL();
	buildEmscripten();
}