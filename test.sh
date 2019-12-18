#!/bin/sh

testfn=${0##*/}

for dir in *; do
	[ -x "${dir}/${testfn}" ] || continue

	printf "\n##\n# Running %s tests.\n##\n\n" "${dir##*/}"
	(cd "${dir}" && ./"${testfn}")
done
