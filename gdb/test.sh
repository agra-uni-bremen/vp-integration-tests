#!/bin/sh

GDB_DEBUG_PROG="${GDB_DEBUG_PROG:-gdb-multiarch}"
GDB_DEBUG_PORT="${GDB_DEBUG_PORT:-2342}"

RISCV_VP="tiny64-vp --debug-mode --debug-port "${GDB_DEBUG_PORT}" --intercept-syscalls"

testdir="${TMPDIR:-/tmp}/gdb-tests"
mkdir -p "${testdir}"

trap "rm -rf '${testdir}' ; kill %1 2>/dev/null" INT EXIT
printf "target remote :%s\n" "${GDB_DEBUG_PORT}" \
	> "${testdir}/gdb-target"

for test in *; do
	[ -x "${test}/postcheck.sh" ] || continue

	name=${test##*/}
	printf "Running test case '%s': " "${name}"

	# Killed by trap handler
	(${RISCV_VP} "${test}/${name}" 1>"${testdir}/vp-log" 2>&1) &

	cat "${testdir}/gdb-target" "${test}/gdb-cmds" \
		> "${testdir}/gdb-cmds"
	"${GDB_DEBUG_PROG}" -q -x "${test}/gdb-cmds" "${test}/${name}" \
		1>"${testdir}/gdb-log" 2>&1

	export GDB_EXITCODE=$?
	if "${test}/postcheck.sh" "${testdir}"; then
		printf "OK.\n"
	fi
done
