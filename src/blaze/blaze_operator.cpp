#include "blaze_operator.h"
#include "util.h"
#include "config.h"

#include <regex>

namespace {
    std::map<std::string, std::regex> pattern_map {
            {"ProperCase", std::regex("[A-Z][a-z]+")},
            {"CAPS", std::regex("[A-Z]+")},
            {"lowercase", std::regex("[a-z]+")},
            {"Digits", std::regex("[0-9]+")},
            {"Alphabets", std::regex("[a-zA-Z]+")},
            {"Alphanumeric", std::regex("[A-Za-z0-9]+")},
            {"WhiteSpace", std::regex("[ ]+")},
            {"ProperCaseWSpaces", std::regex("[A-Z][a-z]+( [A-Z][a-z]+)*")},
            {"CAPSWSpaces", std::regex("[A-Z]+( [A-Z]+)*")},
            {"lowercaseSpaces", std::regex("[a-z]+( [a-z]+)*")},
            {"AlphabetsWSpaces", std::regex("[a-zA-Z]+( [a-zA-Z]+)*")}
    };
}

Data BlazeSubstr::run(const DataList &inp, GlobalInfo *global_info) {
    std::string s = inp[0].getString();
    int l = inp[1].getInt();
    int r = inp[2].getInt();
    if (l > r || l < 0 || r >= s.length()) {
        return Data(new StringValue(""));
    }
    return Data(new StringValue(s.substr(l, r - l + 1)));
}

WitnessList BlazeSubstr::witnessFunction(const DataList &oup, GlobalInfo *global_info) {
    auto* param_info = dynamic_cast<ParamInfo*>(global_info);
#ifdef DEBUG
    assert(param_info != nullptr && oup.size() == 1);
#endif
    std::string res = oup[0].getString();
    if (res.length() == 0) return {};
    WitnessList result;
    for (int i = 0; i < param_info->size(); ++i) {
        if ((*param_info)[i].getType() != TSTRING) continue;
        std::string now = (*param_info)[i].getString();
        for (auto l = now.find(res); l != std::string::npos; l = now.find(res, l + 1)) {
            result.push_back({{Data (new StringValue(now))}, {Data(new IntValue(l))}, {Data(new IntValue(l + res.length() - 1))}});
        }
    }
    return result;
}

std::vector<std::pair<int, int> > BlazePos::getMatchResult(std::string s, std::string pattern) {
    std::vector<std::pair<int, int> > match_result;
    if (pattern_map.count(pattern)) {
        auto reg = pattern_map[pattern];
        std::regex_iterator<std::string::const_iterator> begin(s.begin(), s.end(), reg);
        for (auto iter = begin; iter != std::sregex_iterator(); iter++) {
            int l = iter->position();
            int len = iter->length();
            match_result.push_back(std::make_pair(l, l + len - 1));
        }
    } else {
        for (auto l = s.find(pattern); l != std::string::npos; l = s.find(pattern, l + 1)) {
            match_result.push_back(std::make_pair(l, l + pattern.length() - 1));
        }
    }
    return match_result;
}

Data BlazePos::run(const DataList &inp, GlobalInfo *global_info) {
    std::string s = inp[0].getString();
    std::string pattern = inp[1].getString();
    int pos = inp[2].getInt();
    int dir = inp[3].getInt();
    auto result = getMatchResult(s, pattern);
    if (pos < 0) {
        pos = int(result.size()) + pos;
    }
    if (pos < 0 || pos >= result.size()) {
        return Data(new IntValue(-100));
    }
    if (dir == 0) return result[pos].first; else return result[pos].second;
}

WitnessList BlazePos::witnessFunction(const DataList &oup, GlobalInfo *global_info) {
    int result_pos = oup[0].getInt();
    auto* string_info = dynamic_cast<StringInfo*>(global_info);
    std::vector<std::string> pattern_list;
    for (auto pair: pattern_map) {
        pattern_list.push_back(pair.first);
    }
    for (auto const_data: string_info->const_list) {
        std::string const_string = const_data.getString();
        if (const_string.length() == 0) continue;
        bool is_int = true;
        for (int i = 0; i < const_string.length(); ++i) {
            if (const_string[i] < '0' || const_string[i] > '9') {
                is_int = false;
                break;
            }
        }
        if (!is_int) {
            pattern_list.push_back(const_string);
        }
    }
    WitnessList witness_result;
    for (int i = 0; i < string_info->size(); ++i) {
        if ((*string_info)[i].getType() != TSTRING) continue;
        std::string s = (*string_info)[i].getString();
        for (const auto& pattern: pattern_list) {
            auto result = getMatchResult(s, pattern);
            int n = result.size();
            for (int j = 0; j < result.size(); ++j) {
                if (result[j].first == result_pos) {
                    witness_result.push_back({{Data(new StringValue(s))}, {Data(new StringValue(pattern))},
                                              {Data(new IntValue(j))}, {Data(new IntValue(0))}});
                    witness_result.push_back({{Data(new StringValue(s))}, {Data(new StringValue(pattern))},
                                              {Data(new IntValue(j - n))}, {Data(new IntValue(0))}});
                }
                if (result[j].second == result_pos) {
                    witness_result.push_back({{Data(new StringValue(s))}, {Data(new StringValue(pattern))},
                                              {Data(new IntValue(j))}, {Data(new IntValue(1))}});
                    witness_result.push_back({{Data(new StringValue(s))}, {Data(new StringValue(pattern))},
                                              {Data(new IntValue(j - n))}, {Data(new IntValue(1))}});
                }
            }
        }
    }
    return witness_result;
}