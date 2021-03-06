#ifndef L2S_SEMANTICS_H
#define L2S_SEMANTICS_H

#include <vector>
#include <algorithm>
#include "util.h"
#include "data.h"
#include "z3++.h"

typedef std::vector<DataList> WitnessTerm;
typedef std::vector<WitnessTerm> WitnessList;

class GlobalInfo {
public:
    virtual std::string getName() {return "GlobalInfo";}
};

class ParamInfo: public GlobalInfo {
protected:
    DataList param_value;
public:
    virtual std::string getName() {return "ParamInfo";}
    ParamInfo(const DataList& _param_value): param_value(_param_value) {}
    ParamInfo() = default;
    Data& operator [] (int k) {return param_value[k];}
    int size() {return param_value.size();}
};

class Semantics {
protected:
    void check(const DataList& inp_list) {
        assert(inp_list.size() == inp_type_list.size());
        for (int i = 0; i < inp_list.size(); ++i) {
            assert(inp_list[i].getType() == inp_type_list[i]);
        }
    }
public:
    std::vector<Type> inp_type_list;
    Type oup_type;
    std::string name;
    Semantics(const std::vector<Type>& _inp_type_list, Type _oup_type, std::string _name):
        inp_type_list(_inp_type_list), oup_type(_oup_type), name(_name) {}
    virtual WitnessList witnessFunction(const DataList &oup, GlobalInfo* global_info) = 0;
    virtual Data run(const DataList &inp, GlobalInfo* global_info) = 0;
};

class Z3InterpretableSemantics: public Semantics {
public:
    Z3InterpretableSemantics(const std::vector<Type>& _inp_type_list, Type _oup_type, std::string _name):
        Semantics(_inp_type_list, _oup_type, _name) {
    }
    virtual z3::expr encodeZ3Expr(
            z3::context& ctx, const std::vector<z3::expr>& inp_expr, std::vector<z3::expr> param_expr) = 0;
};

class ConstSemantics: public Z3InterpretableSemantics {
public:
    Data value;
    ConstSemantics(Data _value):
        value(_value), Z3InterpretableSemantics({}, _value.getType(), _value.toString()) {}
    virtual WitnessList witnessFunction(const DataList& oup, GlobalInfo* global_info);

    virtual z3::expr encodeZ3Expr(z3::context& ctx, const std::vector<z3::expr>& inp_expr,
            std::vector<z3::expr> param_expr) {
        return value.encodeZ3Expr(ctx);
    }

    virtual Data run(const DataList &inp, GlobalInfo *global_info) {
        return value;
    }
};

class ParamSemantics: public Z3InterpretableSemantics {
    int id;
    Type type;
public:
    ParamSemantics(int _id, Type _type): id(_id), type(_type),
        Z3InterpretableSemantics({}, _type, "Param" + std::to_string(_id)) {}
    virtual WitnessList witnessFunction(const DataList& oup, GlobalInfo* global_info);
    virtual Data run(const DataList &inp, GlobalInfo *global_info) {
        ParamInfo* param_info = dynamic_cast<ParamInfo*>(global_info);
#ifdef DEBUG
        assert(param_info != nullptr);
#endif
        return (*param_info)[id];
    }
    virtual z3::expr encodeZ3Expr(z3::context &ctx, const std::vector<z3::expr> &inp_expr,
            std::vector<z3::expr> param_expr) {
        return param_expr[id];
    }
};


#endif //L2S_SEMANTICS_H
