#!/bin/sh
set -e

##
# Global Variables
##

TESTSCRIPT="${0##*/}"

##
# Utility functions
##

build() {
	[ $# -eq 1 ] || return 1

	# remove previously generated files
	git clean -fdX

	# build cmake system for requested target
	cmake -DCMAKE_TOOLCHAIN_FILE=toolchain/${1}.cmake .

	# build all test programs for the target
	make
}

tests() {
	[ $# -eq 0 ] && return 1

	for dir in "$@"; do
		[ -x "${dir}/${TESTSCRIPT}" ] || continue

		printf "\n##\n# Running %s tests.\n##\n\n" "${dir##*/}"
		(cd "${dir}" && ./"${TESTSCRIPT}")
	done
}

##
# Code
##

printf "--- Testing RV32 ---\n"

export TESTVP="tiny32"
build rv32 >/dev/null
tests sw

printf "\n--- Testing RV64 ---\n"

export TESTVP="tiny64"
build rv64 >/dev/null
tests sw gdb
