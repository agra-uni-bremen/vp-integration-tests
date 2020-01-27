project(vp-integration-tests)
cmake_minimum_required(VERSION 3.10.0)

# Generate debug information relative to gdb/
string(APPEND CMAKE_ASM_FLAGS_INIT " -g")
string(APPEND CMAKE_ASM_FLAGS_INIT " -fdebug-prefix-map=${CMAKE_SOURCE_DIR}=..")

enable_language(C ASM)

add_subdirectory(gdb)
add_subdirectory(sw)
