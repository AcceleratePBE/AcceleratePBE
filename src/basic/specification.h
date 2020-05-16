#ifndef L2S_SPECIFICATION_H
#define L2S_SPECIFICATION_H

#include "semantics.h"
#include "program.h"
#include "json/json.h"

#include <map>

class Specification;
class Rule;

class NonTerminal {
public:
    std::string name;
    Type type;
    std::vector<Rule*> rule_list;
    NonTerminal(std::string _name, Type _type): name(_name), type(_type) {}
};

class Example {
public:
    DataList inp;
    Data oup;
    Example(const DataList& _inp, Data& _oup): inp(_inp), oup(_oup) {}
    std::string toString() const;
};

class Specification {
    void recognizeSpecType();
    void initGlobalInfoForPBE();
    bool checkOracle();
    bool checkPBE();
public:
    Json::Value constraint_root, extra_root;
    std::map<std::string, int> param_map;
    struct ParamInfo {
        std::string name;
        Type type;
        ParamInfo(std::string _name, Type _type): name(_name), type(_type) {}
    };
    std::vector<ParamInfo> param_list;
    Type return_type;
    std::map<std::string, NonTerminal*> non_terminal_map;
    Program* oracle;
    NonTerminal* start_terminal;
    std::map<std::string, Type> global_variable_map;
    std::vector<Example*> example_space;
    Specification() {};
    Specification(std::string file_name);
    void print();
    bool verify(Program* program, Example*& counter_example);
};

class Rule {
    void check() {
        assert(semantics->inp_type_list.size() == param_list.size());
        for (int i = 0; i < semantics->inp_type_list.size(); ++i) {
            assert(semantics->inp_type_list[i] == param_list[i]->type);
        }
    }
public:
    Semantics* semantics;
    std::vector<NonTerminal*> param_list;
    Rule(Semantics* _semantics, const std::vector<NonTerminal*> _param_list): semantics(_semantics), param_list(_param_list) {
#ifdef DEBUG
        check();
#endif
    }
};


#endif //L2S_SPECIFICATION_H
