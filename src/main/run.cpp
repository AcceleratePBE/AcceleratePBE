//
// Created by pro on 2020/1/21.
//

#include "context.h"
#include "specification.h"
#include "specification_parser.h"
#include "minimal_context_graph.h"
#include "solver.h"

#include <ctime>
#include <cassert>
#include <iostream>
#include "config.h"

int main(int argc, char** argv) {
    assert((argc >= 4 && argc <= 5) || argc == 1);
    std::string spec_file, model_file, output_file, benchmark_type;
    auto start = clock();

    spec_file = std::string(argv[2]);
    model_file = std::string(argv[1]);
    output_file = std::string(argv[3]);
    benchmark_type = "string";
    if (argc == 5) {
        std::string forbid = std::string(argv[4]);
        if (forbid == "FMultiExample") config::KIsUseMultiExample = false;
        else if (forbid == "FFHeuristic") config::KIsUseHeuristic = false;
        else if (forbid == "blaze") config::KIsForBlaze = true;
    }

    Specification* spec = parser::loadSpecification(spec_file, benchmark_type);
    auto* info_map = new ContextInfoMap(model_file);
    auto* graph = new MinimalContextGraph(spec->start_terminal, new TopDownContextMaintainer(), info_map);
    SynthesisTask task(graph, spec);
    auto* result = task.solve();
    if (output_file.length()) {
        auto *F = std::fopen(output_file.c_str(), "w");
        fprintf(F, "%s\n", result->toString().c_str());
        fprintf(F, "%.10lf\n", (clock() - start) * 1.0 / CLOCKS_PER_SEC);
    } else {
        std::cout << result->toString() << std::endl;
        std::cout << (clock() - start) * 1.0 / CLOCKS_PER_SEC << std::endl;
    }
} 

