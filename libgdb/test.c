#include <stdlib.h>
#include <ptest.h>

#include "suite.h"

int
main(void)
{
	pt_add_suite(suite_parser1);
	return pt_run();
}
