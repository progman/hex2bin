//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
// 0.0.1
// Alexey Potehin <gnuplanet@gmail.com>, http://www.gnuplanet.ru/doc/cv
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
#include <stdio.h>
#include <stdint.h>
#include "submodule/lib_cpp/lib_cpp.h"
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
// general function
int main(int argc, char *argv[])
{
	if (argc != 1)
	{
		printf("%s\t(%s)\n", PROG_FULL_NAME, PROG_URL);
		printf("example: echo \"hello world\" | %s\n", argv[0]);
		printf("\n");
		return 1;
	}


// read from stdin, convert to hex, write to stdout
	for (;;)
	{
		int ch = getchar();
		if (ch == EOF) break;

		const char *p = lib_cpp::bin2hex((uint8_t)ch);
		putchar(*p);
		p++;
		putchar(*p);
	}
	fflush(stdout);


	return 0;
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
