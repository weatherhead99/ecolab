cmake_minimum_required(VERSION 3.0)
project(ecolab)



#generate nauty sizes
include(generate_nauty_sizes.cmake)


set(CMAKE_CXX_STANDARD 11)

include_directories("include")

add_subdirectory(src)
