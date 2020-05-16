#include "config.h"

const std::string config::KSourcePath = SOURCEPATH;
const std::string config::KTestPath = KSourcePath + "test/";
const std::string config::KParserMainPath = KSourcePath + "parser/python/main.py";
double config::KDefaultP = 0.001;
bool config::KIsUseMultiExample = true;
bool config::KIsUseHeuristic = true;
// bool config::KIsUseScheduler = true;
bool config::KIsForBlaze = false;
SpecType global::spec_type = S_NONE;
StringInfo* global::string_info = new StringInfo();
int global::KIntMax = 20;
int global::KIntMin = -5;
int global::KContextDepth = 2;
bool global::isMatrix = false;
int global::KMaxDim = 3;