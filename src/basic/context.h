#ifndef L2S_CONTEXT_H
#define L2S_CONTEXT_H

#include <vector>
#include <algorithm>
#include <unordered_map>
#include <cassert>

class Context {
public:
    virtual std::string encodeContext() const = 0;
};

class TopDownContext: public Context {
    int depth;
    std::vector<std::string> info;
public:
    TopDownContext(std::string context_string);
    TopDownContext(const std::vector<std::string>& _info): info(_info), depth(_info.size()) {}
    virtual std::string encodeContext() const;
};

typedef std::vector<std::pair<std::string, double>> ContextInfo;

class ContextInfoMap {
public:
    std::vector<ContextInfo> info_list;
    std::unordered_map<std::string, int> pos_map;
    void setContextInfo(Context* ctx, const ContextInfo& info);
    ContextInfo* getContextInfo(Context* ctx);
    ContextInfoMap(std::string json_file_name);
    void print();
};


#endif //L2S_CONTEXT_H
