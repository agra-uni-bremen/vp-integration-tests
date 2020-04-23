#ifndef LIBGDB_TEST_UTIL_H
#define LIBGDB_TEST_UTIL_H

#include <stdio.h>

#include <libgdb/parser1.h>

FILE *xfopen(char *path);
gdb_packet_t *parse_file(char *path);

#endif
