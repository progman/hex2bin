//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
// 0.0.3
// Alexey Potehin <gnuplanet@gmail.com>, http://www.gnuplanet.ru/doc/cv
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include "submodule/libcore.cpp/libcore.hpp"
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
// convert hex2bin
int hex2bin()
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

		if (libcore::hex2bin((uint8_t)ch1, r1) == false)
		{
			return -1;
		}
		if (libcore::hex2bin((uint8_t)ch2, r2) == false)
		{
			return -1;
		}

		out = (uint8_t)((r1 << 4) + r2);

		putchar(out);
	}
	fflush(stdout);

	return 0;
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

		const char *p = libcore::bin2hex((uint8_t)ch);
		putchar(*p);
		p++;
		putchar(*p);
	}
	fflush(stdout);
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
// convert bin2hex_c
void bin2hex_c()
{
// read from stdin, convert to hex, write to stdout

	bool flag_first = true;
	for (;;)
	{
		int ch = getchar();
		if (ch == EOF) break;

		const char *p = libcore::bin2hex((uint8_t)ch);

		if (flag_first == false)
		{
			putchar(',');
			putchar(' ');
		}
		else
		{
			flag_first = false;
		}
		putchar('0');
		putchar('x');

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
	if (argc == 1)
	{
		if (hex2bin() == -1)
		{
			return 1;
		}
		return 0;
	}

	if (strcmp(argv[1], "--hex2bin") == 0)
	{
		if (hex2bin() == -1)
		{
			return 1;
		}
		return 0;
	}

	if (strcmp(argv[1], "--bin2hex") == 0)
	{
		bin2hex();
		return 0;
	}

	if (strcmp(argv[1], "--bin2hex_c") == 0)
	{
		bin2hex_c();
		return 0;
	}


	printf("%s    %s\n", PROG_FULL_NAME, PROG_URL);
	printf("example: cat FILE | %s [ --hex2bin | --bin2hex | --bin2hex_c ]\n", argv[0]);
	printf("         echo \"68656c6c6f206675636b696e6720776f726c64210a\" | %s [--hex2bin]\n", argv[0]);
	printf("         echo \"hello world\" | %s --bin2hex\n", argv[0]);
	printf("\n");


	return 1;
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
