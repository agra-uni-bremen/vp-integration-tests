#include <stdlib.h>
#include <ptest.h>

#include "suite.h"

int
main(void)
{
	pt_add_suite(suite_parser1);
	pt_add_suite(suite_parser2);
	pt_add_suite(suite_parser_util);
	return pt_run();
}
