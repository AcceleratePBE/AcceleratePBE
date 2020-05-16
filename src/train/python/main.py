from sexp import sexp as sexpParser
import os
import json
import sys
import pickle as pkl
import pprint as pp
from enum import IntEnum

alpha = 0
is_matrix = False

benchmark_type = None

class Tcond(IntEnum):
    UP = 0
    DOWN_FIRST = 1
    DOWN_LAST = 2
    LEFT = 3
    RIGHT = 4
    PREV_DFS = 5
    WRITE_VALUE = 6

def strip_comments(bmFile):
    no_comments = '('
    for line in bmFile:
        line = line.split(';', 1)[0]
        no_comments += line
    return no_comments + ")"

def sexp_from_string(string):
    return sexpParser.parseString(string, parseAll=True).asList()[0]

def load_cache():
    if not os.path.exists("parse_cache.pkl"):
        return {}
    with open("parse_cache.pkl", "rb") as inp:
        return pkl.load(inp)

def save_cache(result):
    with open("parse_cache.pkl", "wb") as oup:
        pkl.dump(result, oup)


def sexp_from_file(file_name):
    with open(file_name, "r") as inp:
        bm = strip_comments(inp)
        bm_expr = sexp_from_string(bm)
    return bm_expr

def filter_by_name(bm_expr, name):
    return list(filter(lambda x: x[0] == name, bm_expr))

def get_name_from_func_info(func_info):
    return func_info[1]

def get_params_from_func_info(func_info):
    return func_info[2]

def get_return_type_from_func_info(func_info):
    return func_info[3]

def get_prog_from_func_info(func_info):
    return func_info[4]

def check_in(constant, s):
    if s[0] != "String": return False
    return constant in s[1]

def get_abstracted_type(constant, example_list):
    inp_num = 0
    oup_num = 0
    total = len(example_list)
    for inp, oup in example_list:
        for inp_string in inp:
            if check_in(constant, inp_string):
                inp_num += 1
                break
        if check_in(constant, oup): oup_num += 1
    if inp_num > 0 and oup_num > 0: return "SomeInOutput"
    if inp_num > 0: return "SomeInput"
    if oup_num > 0: return "SomeOutput"
    return "None"

def get_abstracted_program(prog, param_list, example_list):
    if type(prog) == str:
        for (param_name, param_type) in param_list:
            if param_name == prog:
                return "Param@" + param_type
        return prog
    if type(prog) == tuple:
        if example_list is None or prog[0] != "String":
            return "Constant@" + prog[0]
        else:
            return "Constant@" + get_abstracted_type(prog[1], example_list)
    if type(prog) == list:
        return list(map(lambda sublist: get_abstracted_program(sublist, param_list, example_list), prog))
    assert False

def get_example_from_spec(bm_expr):
    constraint_list = filter_by_name(bm_expr, "constraint")
    example_list = []
    for _, constraint in constraint_list:
        assert constraint[0] == "=" and len(constraint) == 3
        inp = constraint[1][1:]
        oup = constraint[2]
        example_list.append([inp, oup])
    return example_list

class Model:
    def __init__(self, prog, info_map):
        self.prog = prog
        self.info_map = {}
        for ctxt, info in info_map.items():
            probability_sum = 0
            for op, value in info.items():
                probability_sum += value
            new_info = {}
            for op, value in info.items():
                new_info[op] = value / probability_sum
            self.info_map[ctxt] = new_info

    def query(self, ctxt):
        ctxt_str = ",".join(ctxt)
        assert ctxt_str in self.info_map
        return self.info_map[ctxt_str]

model_map = {}

class PBESpecKind(IntEnum):
    SOME_INPUT_BELONG_TO_OUTPUT = 0
    SOME_OUTPUT_BELONG_TO_INPUT = 1
    # ALL_INPUT_BELONG_TO_OUTPUT = 2
    # ALL_OUTPUT_BELONG_TO_INPUT = 3
    SOME_INPUT_INTERSECT_OUTPUT = 4
    # ALL_INPUT_INTERSECT_OUTPUT = 5
    # SOME_INPUT_BELONG_TO_SOME_INPUT = 6
    NO_INTERSECTION = 7

def get_phog_predict_result(program, model: Model):
    path_to_program_cache = {}
    def prepare_cache(program, path):
        path_to_program_cache[str(path)] = program
        if type(program) == list:
            for (i, param) in enumerate(program[1:]):
                path.append(i)
                prepare_cache(param, path)
                path.pop()

    #pp.pprint(program)
    #print()

    def get_ctxt(target_path):
        result = []
        def run_phog_inst(path, inst):
            if inst == Tcond.UP:
                if len(path) > 0:
                    path.pop()
                return path
            if inst == Tcond.DOWN_FIRST:
                current_program = path_to_program_cache[str(path)]
                if type(current_program) == list:
                    path.append(0)
                return path
            if inst == Tcond.DOWN_LAST:
                current_program = path_to_program_cache[str(path)]
                if type(current_program) == list:
                    path.append(len(current_program) - 2)
                return path
            if inst == Tcond.LEFT:
                if len(path) > 0:
                    last = path.pop()
                    path.append(last - 1 if last > 0 else 0)
                return path
            if inst == Tcond.RIGHT:
                if len(path) > 0:
                    last = path.pop()
                    father_program = path_to_program_cache[str(path)]
                    size = len(father_program) - 1
                    path.append(last + 1 if last + 1 < size else last)
                return path
            if inst == Tcond.PREV_DFS:
                if len(path) > 0:
                    last = path.pop()
                    if last > 0:
                        path.append(last - 1)
                        while True:
                            current_program = path_to_program_cache[str(path)]
                            if type(current_program) == str: break
                            path.append(len(current_program) - 2)
                return path
            if inst == Tcond.WRITE_VALUE:
                if path == target_path:
                    result.append("_")
                else:
                    current_program = path_to_program_cache[str(path)]
                    if type(current_program) == str:
                        if "Param" in current_program:
                            result.append("Var")
                        else:
                            result.append(current_program)
                    else:
                        result.append(current_program[0])
                return path
            assert False
        path = []
        for i in target_path: path.append(i)
        for inst in model.prog:
            path = run_phog_inst(path, inst)
        return result

    result = {}
    whole_program = program

    def get_partial(program, path):
        if type(program) != list:
            return program
        if len(path) == 0:
            return program[0]
        hd, *tl = path
        partial_result = program[0: hd + 1]
        partial_result.append(get_partial(program[hd + 1], tl))
        return partial_result

    def get_result(program, path):
        global path_to_program_cache
        path_to_program_cache = {}
        partial_program = get_partial(whole_program, path)
        #print("partial")
        #pp.pprint(partial_program)
        prepare_cache(partial_program, [])
        #pp.pprint(path_to_program_cache)
        #print(path, get_ctxt(path))
        result[str(path)] = model.query(get_ctxt(path))
        #print(get_ctxt(path), result[str(path)])
        if type(program) == list:
            for (i, sub_program) in enumerate(program[1:]):
                path.append(i)
                get_result(sub_program, path)
                path.pop()
    get_result(program, [])
    #pp.pprint(result)
    return result

def parse_head_info(line):
    flag_info_str, type_info_str = line.split(')')
    flag_info_list = flag_info_str.split(',')
    flag = []
    for flag_info in flag_info_list:
        if len(flag_info) == 0:
            continue
        if "0" in flag_info:
            flag.append(PBESpecKind.SOME_INPUT_BELONG_TO_OUTPUT)
        elif "1" in flag_info:
            flag.append(PBESpecKind.SOME_OUTPUT_BELONG_TO_INPUT)
        elif "4" in flag_info:
            flag.append(PBESpecKind.SOME_INPUT_INTERSECT_OUTPUT)
        elif "7" in flag_info:
            flag.append(PBESpecKind.NO_INTERSECTION)
        else:
            assert False
    if "String" in type_info_str:
        return_type = "String"
    elif "Int" in type_info_str:
        return_type = "Int"
    elif "Bool" in type_info_str:
        return_type = "Bool"
    else:
        assert False
    return flag, return_type

def load_model(file_name):
    with open(file_name, "r") as inp:
        info = inp.readlines()
    group_list = []
    current_group = None
    for line in info:
        line = line[:-1]
        if len(line) <= 2: continue
        if "(<PBESpecKind." in line:
            if current_group is not None: group_list.append(current_group)
            current_group = [line]
        else:
            current_group.append(line)
    if len(current_group) > 0:
        group_list.append(current_group)

    def rename_item(ctxt_item):
        if "C_" in ctxt_item:
            item_id = int(ctxt_item[2])
            assert item_id in range(0, 7)
            if item_id == 0:
                item_type = "AllInOutput"
            elif item_id == 1:
                item_type = "AllOutput"
            elif item_id == 2:
                item_type = "AllInput"
            elif item_id == 3:
                item_type = "SomeInOutput"
            elif item_id == 4:
                item_type = "SomeOutput"
            elif item_id == 5:
                item_type = "SomeInput"
            else:
                item_type = "None"
            return "Constant@" + item_type
        else:
            try:
                _ = int(ctxt_item)
                return "Constant@Int"
            except ValueError:
                return ctxt_item
    for current_group in group_list:
        flag, return_type = parse_head_info(current_group[0])
        prog = list(map(Tcond, map(int, current_group[1].split(' '))))
        model_info = {}
        for info_line in current_group[2:]:
            ctxt, op, probability = info_line.split(' ')
            probability = float(probability) / 1000.0
            ctxt_list = ctxt.split(',')
            new_ctxt_list = []
            for ctxt_item in ctxt_list:
                new_ctxt_list.append(rename_item(ctxt_item))
            op = rename_item(op)
            ctxt_str = ",".join(new_ctxt_list)
            if ctxt_str not in model_info: model_info[ctxt_str] = {}
            if op == "Var":
                op = "Param@String"
            if op not in model_info[ctxt_str]:
                model_info[ctxt_str][op] = 0.0
            model_info[ctxt_str][op] += probability
        flag = sorted(flag)
        model_map[str(flag) + "@" + return_type] = Model(prog, model_info)

def get_benchmark_flag(example_list):
    flags = []

    def add_flag(flag):
        if flag not in flags:
            flags.append(flag)

    def is_sub(v1, v2):
        assert isinstance(v1, tuple) and isinstance(v2, tuple)
        if v1[0] == "String" and v2[0] == "String":
            return v1[1] in v2[1]
        else:
            return False

    def is_intersecion_nonempty(v1, v2):
        assert isinstance(v1, tuple) and isinstance(v2, tuple)
        if v1[0] == "String" and v2[0] == "String":
            for i in range(len(v1[1])):
                if v1[1][i: i+1] in v2[1]:
                    return True
            return False
        else:
            return False

    for input_list, output in example_list:
        if any(is_sub(inp, output) for inp in input_list):
            add_flag(PBESpecKind.SOME_INPUT_BELONG_TO_OUTPUT)
        if any(is_sub(output, inp) for inp in input_list):
            add_flag(PBESpecKind.SOME_OUTPUT_BELONG_TO_INPUT)
        if any(is_intersecion_nonempty(output, inp) for inp in input_list):
            add_flag(PBESpecKind.SOME_INPUT_INTERSECT_OUTPUT)
    if len(flags) == 0: add_flag(PBESpecKind.NO_INTERSECTION)
    flags = sorted(flags)
    return str(flags)

def get_matrix_data_info(file_name):
    with open(file_name, "r") as inp:
        info = inp.readlines()
    assert len(info) >= 5 and "// desired program" in info[3]
    code = info[4][:-1]

    def normalize(code):
        while code[0] == ' ': code = code[1:]
        while code[-1] == ' ': code = code[:-1]
        return code

    def parse_code(code):
        code = normalize(code)
        if "(" not in code:
            if code == "x":
                return "Param@Matrix"
            return "Constant@Int"
        assert code[-1] == ')'
        pos = code.find('(')
        operator = normalize(code[:pos])
        param = normalize(code[pos + 1: -1])
        pre_pos = 0
        left_num = 0
        param_list = []
        param = param + ","
        for i, ch in enumerate(param):
            if ch == '(': left_num += 1
            if ch == ')':
                left_num -= 1
            if ch == ',' and left_num == 0:
                param_list.append(normalize(param[pre_pos:i]))
                pre_pos = i + 1
        result = [operator]
        for param_code in param_list:
            result.append(parse_code(param_code))
        return result

    result = parse_code(code)
    return [["", result]]

def get_data_info(file_name):
    global parse_cache
    if file_name in parse_cache:
        return parse_cache[file_name]
    if is_matrix:
        result = get_matrix_data_info(file_name)
        parse_cache[file_name] = result
        save_cache(parse_cache)
        return result
    bm_expr = sexp_from_file(file_name)
    def_func = filter_by_name(bm_expr, "define-fun")

    if benchmark_type == "circuit":
        assert False
        result = []
        for func_info in def_func:
            prog = get_prog_from_func_info(func_info)
            param_list = get_params_from_func_info(func_info)
            result.append(get_abstracted_program(prog, param_list, None))
        return result
    elif benchmark_type == "string":
        if len(def_func) == 0:
            result = []
        else:
            assert len(def_func) == 1
            func_info = def_func[0]
            prog = get_prog_from_func_info(func_info)
            param_list = get_params_from_func_info(func_info)
            example_list = get_example_from_spec(bm_expr)

            synth_info = filter_by_name(bm_expr, "synth-fun")
            assert len(synth_info) == 1
            synth_info = synth_info[0]
            return_type = synth_info[3]
            flag = get_benchmark_flag(example_list)
            result = [[flag + "@" + return_type, get_abstracted_program(prog, param_list, example_list)]]
        parse_cache[file_name] = result
        save_cache(parse_cache)
        return result
    assert False

def encode_context(context):
    return "{" + ",".join(list(map(str, context))) + "}"

def decode_context(context_string):
    return context_string[1:-1].split(",")

def train_model(program_list, lookup_depth):
    model = {}
    context = [None for _ in range(lookup_depth)]

    def count_combine_in_program(program, path):
        if lookup_depth > 0:
            context_string = encode_context(context[-lookup_depth:])
        else:
            context_string = ""
        if context_string not in model:
            model[context_string] = {}
        if type(program) == str:
            current_name = program
        else:
            assert type(program) == list
            current_name = program[0]
            for i in range(1, len(program)):
                context.append(current_name + "@" + str(i))
                path.append(i - 1)
                count_combine_in_program(program[i], path)
                path.pop()
                context.pop()
        if current_name not in model[context_string]:
            model[context_string][current_name] = 0
        model[context_string][current_name] += 1 - alpha

    for flag, program in program_list:
        count_combine_in_program(program, [])

    for context in model:
        total = 0
        for _, value in model[context].items():
            total += value
        for possible_result in model[context]:
            model[context][possible_result] /= 1.0 * total
    return model

def print_model(model):
    for context in model:
        results = []
        for possible_result, probability in model[context].items():
            results.append([probability, possible_result])
        results = sorted(results, reverse=True)
        result_string = ", ".join(list(map(lambda x: x[1] + ": {0:2f}".format(x[0]), results)))
        print(context + " => " + result_string)

def save_model(model, file_name):
    json_dict = []
    for context_string in model:
        context = decode_context(context_string)
        current_info = {"context": context, "rule": []}
        for possible_term, probability in model[context_string].items():
            current_info["rule"].append({"term": possible_term, "p": probability})
        json_dict.append(current_info)
    with open(file_name, "w") as oup:
        json.dump(json_dict, fp=oup, indent=4)

def get_data_list(train_path):
    result = []
    file_name_list = os.listdir(train_path)
    for file_name in file_name_list:
        if ".sl" in file_name or is_matrix:
            result.append(train_path + file_name)
    return result

if __name__ == "__main__":
    data_path = sys.argv[1] + "/"
    default_depth = int(sys.argv[2])
    oup_dict = sys.argv[3]
    if len(sys.argv) >= 5 and sys.argv[4] == "Y":
        if os.path.exists("parse_cache.pkl"):
            os.system("rm parse_cache.pkl")
        print("Clear cache")
    if len(sys.argv) >= 6 and sys.argv[5] == "Matrix":
        is_matrix = True

    parse_cache = load_cache()
    data_list = get_data_list(data_path)
    benchmark_type = "string"
    program_list = []
    for (i, file_name) in enumerate(data_list):
        print("\r{0:d}/{1:d}".format(i, len(data_list)), end="")
        prog = get_data_info(file_name)
        program_list += prog
    print("\rLoading finished.")

    model = train_model(program_list, default_depth)
    save_model(model, oup_dict + "/model@depth" + str(default_depth) + ".json")