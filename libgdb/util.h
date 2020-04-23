#ifndef LIBGDB_TEST_UTIL_H
#define LIBGDB_TEST_UTIL_H

#include <libgdb/parser1.h>
#include <libgdb/parser2.h>

#define ARRAY_LEN(X) (sizeof(X) / sizeof(X[0]))

gdb_packet_t *parse_file1(char *path);
gdb_command_t *parse_file2(char *path);

#endif
