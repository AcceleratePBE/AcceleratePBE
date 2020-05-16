import sys
from sexp import sexp as sexpParser
from enum import Enum
import pickle as pkl
import json
import pprint as pp

is_parse_for_blaze = False
is_get_invalid_list_for_blaze = False

def stripComments(bmFile):
    noComments = '('
    for line in bmFile:
        line = line.split(';', 1)[0]
        noComments += line
    return noComments + ')'

def sexpFromString(value):
    return sexpParser.parseString(value, parseAll = True).asList()[0]

def sexpFromFile(benchmarkFileName):
    try:
        benchmarkFile = open(benchmarkFileName)
    except:
        # print('File not found: %s' % benchmarkFileName)
        return None

    bm = stripComments(benchmarkFile)
    bmExpr = sexpFromString(bm)
    benchmarkFile.close()
    return bmExpr

def getSublist(bmExpr, name):
    return list(filter(lambda x: x[0] == name, bmExpr))

def getName(func_info): return func_info[1]
def getParamType(func_info): return list(map(lambda x: x[1], func_info[2]))
def getReturnType(func_info): return func_info[3]
def getSpec(func_info): return func_info[4]

def getConstMap(expr, result):
    if type(expr) == tuple:
        const_type = expr[0]
        if const_type not in result:
            result[const_type] = []
        result[const_type].append(expr)
    if type(expr) == list:
        for subexpr in expr:
            getConstMap(subexpr, result)

def toString(line):
    if type(line) == tuple:
        if line[0] == "String":
            return "\"" + line[1] + "\""
        return str(line[1])
    if type(line) == str:
        return line
    if type(line) == list:
        return "(" + " ".join(list(map(toString, line))) + ")"
    assert False

def load_result(file):
    with open(file, "rb") as inp:
        return pkl.load(inp)

if __name__ == "__main__":
    assert len(sys.argv) == 4
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    bmExpr = sexpFromFile(input_file)
    if len(sys.argv) == 3:
        blaze_dsl = """ ((ntString String (
        (Str A)
        (str.++ ntString A)
    ))
    (A String (
        (Str ConstString)
        (SubStr X P P)
    ))
    (P Int (
        (Int ntInt)
        (Pos X Pattern ntInt Direction)
    ))
    (Pattern String ((Str ConstString) "ProperCase" "CAPS" "lowercase" "Digits" "Alphabets" "Alphanumeric" "WhiteSpace" "ProperCaseWSpaces" "CAPSWSpaces" "lowercaseSpaces" "AlphabetsWSpaces"))
    (X String (InsertStringVariable))
    (ConstString String (InsertStringVariable InsertStringConstant))
    (Direction Int (0 1))
    (ntInt Int (-5 -4 -3 -2 -1 0 1 2 3 4 5 InsertIntVariable))
    )"""
        blaze_list = sexpFromString(blaze_dsl)
        synth_info = getSublist(bmExpr, "synth-fun")
        assert len(synth_info) == 1
        define_info = getSublist(bmExpr, "define-fun")
        bmExpr = list(filter(lambda x: x not in synth_info + define_info, bmExpr))
        const_map = {}
        getConstMap(synth_info, const_map)
        synth_info = synth_info[0]
        var_list = synth_info[2]
        var_map = {}

        for var_name, var_type in var_list:
            if var_type not in var_map:
                var_map[var_type] = []
            var_map[var_type].append(var_name)

        def replaceConstAndVar(rule, const_map, var_map):
            if type(rule) == list:
                result = []
                for subrule in rule:
                    if subrule == "InsertStringVariable":
                        if "String" in var_map:
                            result += var_map["String"]
                    elif subrule == "InsertIntVariable":
                        if "Int" in var_map:
                            result += var_map["Int"]
                    elif subrule == "InsertStringConstant":
                        if "String" in const_map:
                            result += const_map["String"]
                    else:
                        result.append(replaceConstAndVar(subrule, const_map, var_map))
                return result
            return rule
        blaze_list = replaceConstAndVar(blaze_list, const_map, var_map)
        rule_list = synth_info[4]
        new_rule_list = [rule_list[0]] + blaze_list
        new_synth_info = synth_info[:4]
        new_synth_info.append(new_rule_list)
        bmExpr.append(new_synth_info)

        with open(output_file, "w") as oup:
            for line in bmExpr:
                oup.write(toString(line) + "\n")
        exit(0)

    programs = load_result(sys.argv[3])["1,blaze"]

    benchmark_name = input_file.split("/")[-1]
    bmExpr = sexpFromFile(input_file)
    synth_info = getSublist(bmExpr, "synth-fun")[0]
    assert benchmark_name in programs
    if programs[benchmark_name] is not None:
        program = programs[benchmark_name]["Program"]
        program_expr = sexpFromString(program)
        var_list = synth_info[2]
        def replace_param(prog):
            if type(prog) == str:
                if "Param" in prog:
                    var_id = int(prog[5:])
                    return var_list[var_id][0]
                return prog
            if type(prog) == list:
                return list(map(replace_param, prog))
            return prog
        bmExpr.append(["define-fun", "ResFun", synth_info[2], synth_info[3], replace_param(program_expr)])
    with open(output_file, "w") as oup:
        for line in bmExpr:
            oup.write(toString(line) + "\n")