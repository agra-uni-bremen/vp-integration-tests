project(vp-integration-tests)
cmake_minimum_required(VERSION 3.10.0)

# Generate debug information relative to gdb/
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -g -fdebug-prefix-map=${CMAKE_SOURCE_DIR}=..")

enable_language(C ASM)

add_subdirectory(gdb)
add_subdirectory(sw)
