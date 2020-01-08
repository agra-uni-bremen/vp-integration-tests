#!/bin/sh
exec sed -e '/^pc =/d' -e '/^num-instr =/d'
