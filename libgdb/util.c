#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <err.h>

#include <libgdb/parser1.h>

#include "util.h"

FILE *
xfopen(char *path)
{
	FILE *stream;

	if (!(stream = fopen(path, "r")))
		err(EXIT_FAILURE, "fopen failed for '%s'", path);
	return stream;
}

gdb_packet_t *
parse_file(char *path)
{
	FILE *stream;
	gdb_packet_t *pkt;

	stream = xfopen(path);
	pkt = gdb_parse_pkt(stream);

	if (fclose(stream))
		err(EXIT_FAILURE, "fclose failed for '%s'", path);
	return pkt;
}
