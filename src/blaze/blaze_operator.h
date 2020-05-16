#ifndef L2S_BLAZE_OPERATOR_H
#define L2S_BLAZE_OPERATOR_H

#include "semantics.h"

class BlazeInt: public Semantics {
public:
    BlazeInt(): Semantics({TINT}, TINT, "Int") {}
    virtual Data run(const DataList &inp, GlobalInfo *global_info) {return inp[0];}
    virtual WitnessList witnessFunction(const DataList &oup, GlobalInfo *global_infol) {return {{oup}};}
};

class BlazeStr: public Semantics {
public:
    BlazeStr(): Semantics({TSTRING}, TSTRING, "Str") {}
    virtual Data run(const DataList &inp, GlobalInfo *global_info) {return inp[0];}
    virtual WitnessList witnessFunction(const DataList &oup, GlobalInfo *global_info) {return {{oup}};}
};

class BlazeSubstr: public Semantics {
public:
    BlazeSubstr(): Semantics({TSTRING, TINT, TINT}, TSTRING, "SubStr") {}
    virtual Data run(const DataList &inp, GlobalInfo *global_info);
    virtual WitnessList witnessFunction(const DataList &oup, GlobalInfo *global_info);
};

class BlazePos: public Semantics {
    std::vector<std::pair<int, int> > getMatchResult(std::string s, std::string pattern);
public:
    BlazePos(): Semantics({TSTRING, TSTRING, TINT, TINT}, TSTRING, "Pos") {}
    virtual Data run(const DataList &inp, GlobalInfo *global_info);
    virtual WitnessList witnessFunction(const DataList &oup, GlobalInfo *global_info);
};

#endif //L2S_BLAZE_OPERATOR_H
