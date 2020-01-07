# Integration Tests

Tests for peripherals and other utilities of the [riscv-vp][riscv-vp gitlab].

## Dependencies

* riscv-vp binaries must be in `$PATH`
* clang with riscv-v support
* GDB with RISC-V support
* CMake

## Usage

If all dependencies have been installed the tests can be invoked using:

	$ cmake -DCMAKE_TOOLCHAIN_FILE=toolchain/clang.cmake
	$ make
	$ ./test.sh

[riscv-vp gitlab]: https://gitlab.informatik.uni-bremen.de/riscv/riscv-vp
