cmake_minimum_required(VERSION 3.11.0)
project(Advent-Of-Code VERSION 0.1.0)

enable_language(CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_BUILD_TYPE Debug)

file(GLOB SOURCES_CPP "src/*.cpp")
file(GLOB SOURCES_HPP "src/*.hpp")

set(SOURCES ${SOURCES_CPP} ${SOURCES_HPP})

add_executable(Advent-Of-Code)

target_sources(Advent-Of-Code PUBLIC ${SOURCES})
target_include_directories(Advent-Of-Code PUBLIC .)
target_include_directories(Advent-Of-Code PUBLIC src)

if(MSVC)
    target_compile_options(Advent-Of-Code PRIVATE /Wall)
else()
    target_compile_options(Advent-Of-Code PRIVATE -Wall -Wextra -pedantic -Wno-missing-field-initializers)
endif()
