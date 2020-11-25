#!/bin/sh
exec sed 's/riscv:rv[0-9]*/riscv/' | grep -o riscv
