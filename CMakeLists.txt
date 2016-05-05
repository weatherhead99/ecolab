cmake_minimum_required(VERSION 3.0)
project(ecolab)


#find dependencies
include(dependencies.cmake)


#XDR option - what is this?
option(ENABLE_XDR "enable XDR build" ON)
if(ENABLE_XDR)
  message(STATUS "building with XDR enabled")
  add_definitions(-DXDR_PACK)
endif()

#generate nauty sizes
include(generate_nauty_sizes.cmake)


#hash define... not sure what other options do
#add_definitions(-DHASH_hash_map)
add_definitions(-DHASH_TCL_hash -DTR1 )



include_directories("include")

add_subdirectory(classdesc)
include(classdesc/classdesc.cmake)

add_subdirectory(graphcode)

add_subdirectory(src)

add_subdirectory(models)
