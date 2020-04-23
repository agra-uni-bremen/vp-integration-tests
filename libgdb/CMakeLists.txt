project(libgdb-tests)
cmake_minimum_required(VERSION 3.10.0)

add_subdirectory("${RISCV_VP_BASE}/vp/src/core/common/gdb-mc/libgdb" ./build)
target_compile_definitions(gdb PRIVATE GDB_PARSER_DEBUG)

add_library(ptest
	ptest/ptest.c
	ptest/ptest.h)
set_source_files_properties(ptest/pest.c
	PROPERTIES COMPILE_FLAGS "-w -ansi")
target_include_directories(ptest PUBLIC ptest/)

add_executable(test
	test.c
	parser1.c
	parser_util.c
	util.c
	util.h
	suite.h)
target_link_libraries(test gdb ptest)
set_property(TARGET test PROPERTY C_STANDARD 99)
target_compile_options(test PRIVATE -Werror
	-Wpedantic -Wall -Wextra -Wmissing-prototypes)
