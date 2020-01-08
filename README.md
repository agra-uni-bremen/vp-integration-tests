# Integration Tests

Tests for peripherals and other utilities of the [riscv-vp][riscv-vp gitlab].

## Dependencies

* riscv-vp binaries must be in `$PATH`
* Clang with RISC-V support or GCC cross toolchain
* GDB with RISC-V support
* CMake

## Usage

If all dependencies have been installed generate Makefiles using CMake.
The build system supports both the Clang and GCC toolchain for cross
compilation.

Using Clang:

	$ cmake -DCMAKE_TOOLCHAIN_FILE=toolchain/clang.cmake

Using GCC:

	$ cmake -DCMAKE_TOOLCHAIN_FILE=toolchain/gcc.cmake

After build all test files and invoke the tests using:


	$ make
	$ ./test.sh

[riscv-vp gitlab]: https://gitlab.informatik.uni-bremen.de/riscv/riscv-vp
