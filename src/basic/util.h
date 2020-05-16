#ifndef L2S_UTIL_H
#define L2S_UTIL_H

#include "z3++.h"
#include "json/json.h"
#include "data.h"

namespace util {
    z3::expr defineVar(z3::context& ctx, Type type, std::string name);
    std::string loadStringFromFile(std::string file_name);
    Type string2Type(std::string name);
    Data parseDataFromJson(Json::Value node);
    Json::Value loadJsonFromFile(std::string file_name);
    Data parseDataFromModel(z3::context& ctx, z3::model& model, Type type, std::string name);
    std::string dataList2String(const DataList& data_list);
    std::string type2String(Type type);
    std::string getStringConstType(std::string s);
    bool checkInOupList(const Data& value, const DataList& oup);
}

#endif //L2S_UTIL_H
