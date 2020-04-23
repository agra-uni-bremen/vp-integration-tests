#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <err.h>

#include <libgdb/parser1.h>
#include <libgdb/parser2.h>

#include "util.h"

gdb_packet_t *
parse_file1(char *path)
{
	FILE *stream;
	gdb_packet_t *pkt;

	if (!(stream = fopen(path, "r")))
		err(EXIT_FAILURE, "fopen failed for '%s'", path);
	pkt = gdb_parse_pkt(stream);

	if (fclose(stream))
		err(EXIT_FAILURE, "fclose failed for '%s'", path);
	return pkt;
}

gdb_command_t *
parse_file2(char *path)
{
	gdb_packet_t *pkt;
	gdb_command_t *cmd;

	pkt = parse_file1(path);
	cmd = gdb_parse_cmd(pkt);

	gdb_free_packet(pkt);
	return cmd;
}
