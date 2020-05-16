cmake_minimum_required(VERSION 3.5.1)
project(L2S)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3")
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")
link_directories(/home/jiry/work/z3/build)

#ADD_DEFINITIONS(-DDEBUG)

include_directories(./parser ./train ./basic ./solver . ./blaze ./matrix)

add_library(basic_lib basic/value.h basic/data.h basic/util.h basic/util.cpp basic/context.h basic/context.cpp basic/semantics.h basic/semantics_factory.h basic/semantics_factory.cpp
        basic/specification.h basic/specification.cpp basic/program.h basic/program.cpp basic/config.cpp basic/config.h basic/semantics.cpp blaze/blaze_operator.cpp blaze/blaze_operator.h matrix/matrix_operator.cpp matrix/matrix_operator.h)
add_library(parser_lib parser/specification_parser.h parser/specification_parser.cpp)
add_library(solver_lib solver/context_maintainer.h solver/context_maintainer.cpp solver/minimal_context_graph.cpp solver/minimal_context_graph.h
        solver/solver.cpp solver/solver.h
        )

INCLUDE(FindPkgConfig)
find_package(Jsoncpp)
include_directories(${Jsoncpp_INCLUDE_DIR})

add_executable(run_string main/run.cpp)
#target_link_libraries(run basic_lib parser_lib solver_lib basic_lib ${Jsoncpp_LIBRARY} libz3.so)

add_executable(run_matrix main/test_matrix.cpp)
target_link_libraries(test_matrix basic_lib parser_lib solver_lib basic_lib ${Jsoncpp_LIBRARY} libz3.so)