#!/bin/sh
set -e

build() {
	# remove previously generated files
	git clean -fdX

	# build cmake system for RV64
	cmake -DCMAKE_TOOLCHAIN_FILE=../toolchain/rv64.cmake .

	# build all test programs for the target
	make
}

build >/dev/null
export TESTVP=tiny64
./run_tests.sh | sed 's/^/[RV64] /'
