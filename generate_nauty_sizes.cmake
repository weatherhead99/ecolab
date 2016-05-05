include(CheckTypeSize)

message(STATUS "generating nauty_sizes.h")
check_type_size(int SIZEOF_INT)
check_type_size(long SIZEOF_LONG)
check_type_size("long long" SIZEOF_LONG_LONG)

configure_file(nauty_sizes.h.in nauty_sizes.h)
include_directories(${CMAKE_BINARY_DIR})
