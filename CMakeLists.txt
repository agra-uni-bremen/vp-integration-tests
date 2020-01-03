project(vp-integration-tests)
cmake_minimum_required(VERSION 2.8.12)

set(CMAKE_ASM_LINK_EXECUTABLE
	"riscv64-linux-gnu-ld <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_ASM_COMPILER "riscv64-linux-gnu-gcc")
set(CMAKE_ASM_FLAGS "-c -fdebug-prefix-map=${CMAKE_SOURCE_DIR}=.. -g -march=rv64g -mabi=lp64d")
set(CMAKE_EXE_LINKER_FLAGS "-nostdlib")

enable_language(C ASM)

add_subdirectory(gdb)
