module precompiler.regexmount;
import std.regex : regex;

/**
 * Match any word without operators, it can match hel1o, 1hello, wont match hello++, hel+o, 
*/
string noOp(string cat = "")
{
    return cat~r"\w";
}

/**
 * Matches possible variables starts, case insentivie a-z + _
*/
string varStart(string cat = "")
{
    return cat~r"[a-zA-Z_]";
}

/**
 * Starts with a insentitive A-Z or _, then match every alphanumeric + _
*/
string varDef(string cat = "")
{
    return cat.varStart.noOp~"*";
}

/**
 * Starts with a insentitive A-Z or _, then match alphanumeric + _ + [](array type)
*/
string varType(string cat = "")
{
    return cat.varStart~r"[\w\[\]]*";
}

/**
 * Returns a regex for associative array, it will return a group with the variable name and its type
*/
string varAa(string cat = "")
{
    return cat.varDef.group ~ (noOp ~ "+").group.betweenBrackets;
}

/**
 * Returns a regex for when assigning a variable to a value
*/
string assign(string cat = "")
{
    return cat ~ r"\ *=\ *";
}
/**
 * Returns alphanumeric + any symbol word
*/ 
string valueNoSpace(string cat = "")
{
    return cat ~ r"[^\s]+";
}

/**
 *  Make the current regex a group to be catched
*/
string group(string cat = "")
{
    return "("~cat~")";
}

/**
 * Matches the current regex only if between brackets
*/
string betweenBrackets(string cat = "")
{
    return "\\["~cat~"\\]";
}

/**
 * Matches any num of spaces
*/
string anySpace(string cat = "")
{
    return cat~"\\ *";
}

/**
 * Return a regex with global and multiline flags
*/
auto gm(string reg)
{
    return regex(reg, "gm");
}