#ifndef L2S_SPECIFICATION_PARSER_H
#define L2S_SPECIFICATION_PARSER_H

#include "specification.h"

namespace parser {
    extern Specification* loadSpecification(std::string file_name, std::string benchmark_type);
}


#endif //L2S_SPECIFICATION_PARSER_H
