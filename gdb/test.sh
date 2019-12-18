#!/bin/sh

GDB_DEBUG_PROG="${GDB_DEBUG_PROG:-gdb-multiarch}"
GDB_DEBUG_PORT="${GDB_DEBUG_PORT:-2342}"

RISCV_VP="tiny64-vp --debug-mode --debug-port "${GDB_DEBUG_PORT}" --intercept-syscalls"

testdir="${TMPDIR:-/tmp}/gdb-tests"
outfile="${testdir}/gdb-log"

mkdir -p "${testdir}"
trap "rm -rf '${testdir}' ; kill %1 2>/dev/null" INT EXIT

cat > "${testdir}/gdb-cmds.in" <<-EOF
	target remote :${GDB_DEBUG_PORT}
	set confirm off
	set logging file ${outfile}
	set logging overwrite 1
	set logging on
EOF

for test in *; do
	[ -e "${test}/output" ] || continue

	name=${test##*/}
	printf "Running test case '%s': " "${name}"

	# Killed by trap handler
	(${RISCV_VP} "${test}/${name}" 1>"${testdir}/vp-out" 2>&1) &

	cat "${testdir}/gdb-cmds.in" "${test}/gdb-cmds" \
		> "${testdir}/gdb-cmds"
	"${GDB_DEBUG_PROG}" -q -x "${testdir}/gdb-cmds" "${test}/${name}" \
		1>"${testdir}/gdb-out" 2>&1

	if ! cmp -s "${outfile}" "${test}/output"; then
		printf "FAIL: Output didn't match.\n\n"
		diff -u "${outfile}" "${test}/output"
		exit 1
	fi

	printf "OK.\n"

	kill %1
	wait
done
