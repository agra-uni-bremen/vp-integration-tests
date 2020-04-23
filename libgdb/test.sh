#!/bin/sh
set -e

if [ ! -d "${RISCV_VP_BASE}" ]; then
	printf "Directory '%s' with riscv-vp source does not exist\n" "${RISCV_VP_BASE}" 1>&2
	exit 1
fi

cmake -DRISCV_VP_BASE="${RISCV_VP_BASE}" .
make
./run_tests.sh
