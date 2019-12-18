# Integration Tests

Tests for peripherals and other utilities of the [riscv-vp][riscv-vp gitlab].

## Dependencies

* riscv-vp binaries must be in `$PATH`
* RISC-V compiler toolchain
* GDB with RISC-V support
* CMake

## Usage

If all dependencies have been installed the tests can be invoked using:

	$ cmake .
	$ make
	$ ./test.sh

[riscv-vp gitlab]: https://gitlab.informatik.uni-bremen.de/riscv/riscv-vp
