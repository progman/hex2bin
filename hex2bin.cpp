//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
// 0.0.2
// Alexey Potehin <gnuplanet@gmail.com>, http://www.gnuplanet.ru/doc/cv
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include "submodule/lib_cpp/lib_cpp.h"
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
// convert hex2bin
void hex2bin()
{
	int ch1, ch2;
	uint8_t r1, r2, out;


// read from stdin, convert to bin, write to stdout
	for (;;)
	{
		ch1 = getchar();
		if (ch1 == EOF) break;

		ch2 = getchar();
		if (ch2 == EOF) break;

		if (lib_cpp::hex2bin((uint8_t)ch1, r1) == false) break;
		if (lib_cpp::hex2bin((uint8_t)ch2, r2) == false) break;

		out = (uint8_t)((r1 << 4) + r2);

		putchar(out);
	}
	fflush(stdout);
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
// convert bin2hex
void bin2hex()
{
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
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
// general function
int main(int argc, char *argv[])
{
	bool flag_hex2bin = false;
	bool flag_bin2hex = false;


	if (argc == 1)
	{
		flag_hex2bin = true;
	}
	else
	{
		if (strcmp(argv[1], "--hex2bin") == 0)
		{
			flag_hex2bin = true;
		}

		if (strcmp(argv[1], "--bin2hex") == 0)
		{
			flag_bin2hex = true;
		}
	}


	if (flag_hex2bin == true)
	{
		hex2bin();
		return 0;
	}


	if (flag_bin2hex == true)
	{
		bin2hex();
		return 0;
	}


	printf("%s\t(%s)\n", PROG_FULL_NAME, PROG_URL);
	printf("example: echo \"68656c6c6f206675636b696e6720776f726c64210a\" | %s [--hex2bin]\n", argv[0]);
	printf("         echo \"hello world\" | %s --bin2hex\n", argv[0]);
	printf("\n");


	return 1;
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
