#!/bin/sh
exec sed '/^Program received signal SIGQUIT, Quit.$/ { q }'
