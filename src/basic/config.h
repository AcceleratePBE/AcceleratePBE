#ifndef L2S_CNFIG_H
#define L2S_CNFIG_H

#include <algorithm>
#include "specification.h"
#include "semantics.h"

#include <unordered_set>
#include <unordered_map>

enum SpecType {
    S_ORACLE, S_PBE, S_NONE
};

namespace config {
    extern const std::string KSourcePath;
    extern const std::string KTestPath;
    extern const std::string KParserMainPath;
    extern double KDefaultP;
    extern bool KIsUseMultiExample;
    extern bool KIsUseHeuristic;
    // extern bool KIsUseScheduler;
    extern bool KIsForBlaze;
}

class StringInfo : public ParamInfo{
public:
    virtual std::string getName() {return "StringInfo";}
    std::vector<Example*> example_space;
    DataList const_list; // string constant + int.to.str()
    std::unordered_set<std::string> const_set;
    std::unordered_map<std::string, std::string> const_cache;
    std::vector<int> int_const;
    Specification* spec;
    void setInp(const DataList& _inp) {
        param_value.clear();
        for (int i = 0; i < _inp.size(); ++i) {
            param_value.push_back(_inp[i]);
        }
    }
    void clear() {
        example_space.clear();
        const_list.clear();
        const_set.clear();
        const_cache.clear();
    }
};

namespace global {
    extern SpecType spec_type;
    extern StringInfo* string_info;
    extern int KIntMax;
    extern int KIntMin;
    extern int KContextDepth;
    extern bool isMatrix;
    extern int KMaxDim;
}

#endif //L2S_CNFIG_H
