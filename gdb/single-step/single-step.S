.global _start

_start:
	li a0, 23
	li a1, 42
	add a3, a0, a1
	jal exit # breakpoint is set here

exit:
	# call exit (SYS_EXIT=93) with exit code 0 (argument in a0)
	li a7, 93
	li a0, 0
	ecall
