#!/bin/sh
set -e

VPFLAGS="--intercept-syscalls"

testdir="${TMPDIR:-/tmp}/sw-tests"
outfile="${testdir}/vp-out"
errfile="${testdir}/vp-err"

mkdir -p "${testdir}"
trap "rm -rf '${testdir}'" INT EXIT

for test in *; do
	[ -e "${test}/output" ] || continue

	name=${test##*/}
	printf "Running test case '%s': " "${name}"

	vp=tiny64-vp
	if [ -r "${test}/vp" ]; then
		read -r vp < "${test}/vp"
	fi

	"${vp}" ${VPFLAGS} "${test}/${name}" \
		1>"${outfile}.in" 2>"${errfile}"

	# Post process $outfile to remove toolchain-specific output.
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
done
