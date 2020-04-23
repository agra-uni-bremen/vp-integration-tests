#include <ptest.h>
#include <libgdb/parser2.h>

#include "suite.h"
#include "util.h"

#define SUITE "Suite for second parser stage"

static void
test_set_thread_packet(void)
{
	gdb_command_t *cmd;
	gdb_cmd_h_t *hcmd;

	cmd = parse_file2("testdata/parser2/h.dat");
	PT_ASSERT_STR_EQ(cmd->name, "H");
	PT_ASSERT(cmd->type == GDB_ARG_H);

	hcmd = &cmd->v.hcmd;
	PT_ASSERT(hcmd->op == 'c');
	PT_ASSERT(hcmd->id.pid == GDB_THREAD_UNSET);
	PT_ASSERT(hcmd->id.tid == -1);

	gdb_free_cmd(cmd);
}

static void
test_read_register_packet(void)
{
	gdb_command_t *cmd;

	cmd = parse_file2("testdata/parser2/p.dat");
	PT_ASSERT_STR_EQ(cmd->name, "p");
	PT_ASSERT(cmd->type == GDB_ARG_INT);

	PT_ASSERT(cmd->v.ival == 0x20);

	gdb_free_cmd(cmd);
}

void
suite_parser2(void)
{
	pt_add_test(test_set_thread_packet, "Test parser for 'H' packet", SUITE);
	pt_add_test(test_read_register_packet, "Test parser for 'P' packet", SUITE);
	return;
}
