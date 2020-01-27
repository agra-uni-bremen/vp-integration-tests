#!/bin/sh
set -e

GDB_DEBUG_PROG="${GDB_DEBUG_PROG:-gdb-multiarch}"
GDB_DEBUG_PORT="${GDB_DEBUG_PORT:-2342}"

VPFLAGS="--debug-mode --debug-port "${GDB_DEBUG_PORT}" --intercept-syscalls"

testdir="${TMPDIR:-/tmp}/gdb-tests"
outfile="${testdir}/gdb-log"

mkdir -p "${testdir}"
trap "rm -rf '${testdir}' ; kill $(jobs -p) 2>/dev/null || true" INT EXIT

cat > "${testdir}/gdb-cmds.in" <<-EOF
	target remote :${GDB_DEBUG_PORT}
	set confirm off

	set height unlimited
	set width unlimited

	set logging file ${outfile}.in
	set logging overwrite 1
	set logging on
EOF

for test in *; do
	[ -e "${test}/output" ] || continue

	name=${test##*/}
	printf "Running test case '%s': " "${name}"

	if [ "${name%%-*}" = "mc" ]; then
		vp="${TESTVP}-mc"
	else
		vp="${TESTVP}-vp"
	fi
	("${vp}" ${VPFLAGS} "${test}/${name}" 1>"${testdir}/vp-out" 2>&1) &

	cat "${testdir}/gdb-cmds.in" "${test}/gdb-cmds" \
		> "${testdir}/gdb-cmds"
	"${GDB_DEBUG_PROG}" -q -x "${testdir}/gdb-cmds" "${test}/${name}" \
		1>"${testdir}/gdb-out" 2>&1

	# Post process GDB log file to remove toolchain-specific output.
	if [ -x "${test}/post-process.sh" ]; then
		"${test}/post-process.sh" < "${outfile}.in" > "${outfile}"
	else
		cp "${outfile}.in" "${outfile}"
	fi

	if ! cmp -s "${outfile}" "${test}/output"; then
		printf "FAIL: Output didn't match.\n\n"
		diff -u "${outfile}" "${test}/output"
		exit 1
	fi

	printf "OK.\n"

	kill $(jobs -p) 2>/dev/null || true
	wait
done
