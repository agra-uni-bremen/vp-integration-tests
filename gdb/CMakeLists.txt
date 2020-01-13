# gdb test cases do not require a libc
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -nostdlib")

file(GLOB files "${CMAKE_CURRENT_SOURCE_DIR}/*")
foreach(file ${files})
	if(EXISTS "${file}/CMakeLists.txt")
		add_subdirectory(${file})
	endif()
endforeach()
