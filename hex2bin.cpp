//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
// 0.0.4
// Alexey Potehin <gnuplanet@gmail.com>, http://www.gnuplanet.ru/doc/cv
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include "submodule/libcore.cpp/libcore.hpp"
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
#define BUFFER_SIZE 65536
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
// convert hex2bin
int hex2bin(size_t size_max)
{
	uint8_t r1;
	uint8_t r2;
	uint8_t out;
	ssize_t size;
	uint8_t *pin;
	uint8_t *pin_end;


	void *pdata = malloc(size_max);
	if (pdata == NULL)
	{
		printf("ERROR[malloc()]: %s (%u)\n", strerror(errno), errno);
		return -1;
	}


// read from stdin, convert to bin, write to stdout
	for (;;)
	{
		size = read(STDIN_FILENO, pdata, size_max); // this faster than getchar()
		if (size == 0)
		{
			break; // EOF
		}
		if (size == ssize_t(-1))
		{
			printf("ERROR[read()]: %s (%u)\n", strerror(errno), errno);
			return -1;
		}


		pin = (uint8_t *)pdata;
		pin_end = pin + size;
		for (;;)
		{
			if (pin == pin_end) break;


			if (libcore::hex2bin(*pin, r1) == false)
			{
				return -1;
			}
			pin++;


			if (pin == pin_end) break;


			if (libcore::hex2bin(*pin, r2) == false)
			{
				return -1;
			}
			pin++;


			out = (uint8_t)((r1 << 4) + r2);
			putchar(out);
		}
	}

	fflush(stdout);

	free(pdata);

	return 0;
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
// convert bin2hex
int bin2hex(size_t size_max)
{
	ssize_t size;
	uint8_t *pin;
	const char *pout;
	ssize_t i;


	void *pdata = malloc(size_max);
	if (pdata == NULL)
	{
		printf("ERROR[malloc()]: %s (%u)\n", strerror(errno), errno);
		return -1;
	}


// read from stdin, convert to hex, write to stdout
	for (;;)
	{
		size = read(STDIN_FILENO, pdata, size_max); // this faster than getchar()
		if (size == 0)
		{
			break; // EOF
		}
		if (size == ssize_t(-1))
		{
			printf("ERROR[read()]: %s (%u)\n", strerror(errno), errno);
			return -1;
		}

		pin = (uint8_t *)pdata;
		for (i=0; i < size; i++)
		{
			pout = libcore::bin2hex(*pin);
			pin++;

			putchar(*pout);
			pout++;
			putchar(*pout);
		}
	}

	fflush(stdout);

	free(pdata);

	return 0;
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
// convert bin2hex_c
int bin2hex_c(size_t size_max)
{
	bool flag_first = true;
	ssize_t size;
	uint8_t *pin;
	const char *pout;
	ssize_t i;


	void *pdata = malloc(size_max);
	if (pdata == NULL)
	{
		printf("ERROR[malloc()]: %s (%u)\n", strerror(errno), errno);
		return -1;
	}


// read from stdin, convert to hex, write to stdout
	for (;;)
	{
		size = read(STDIN_FILENO, pdata, size_max); // this faster than getchar()
		if (size == 0)
		{
			break; // EOF
		}
		if (size == ssize_t(-1))
		{
			printf("ERROR[read()]: %s (%u)\n", strerror(errno), errno);
			return -1;
		}

		pin = (uint8_t *)pdata;
		for (i=0; i < size; i++)
		{
			pout = libcore::bin2hex(*pin);
			pin++;

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

			putchar(*pout);
			pout++;
			putchar(*pout);
		}
	}

	fflush(stdout);

	free(pdata);

	return 0;
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
// general function
int main(int argc, char *argv[])
{
	if (argc == 1)
	{
		if (hex2bin(BUFFER_SIZE) == -1)
		{
			return 1;
		}
		return 0;
	}

	if (strcmp(argv[1], "--hex2bin") == 0)
	{
		if (hex2bin(BUFFER_SIZE) == -1)
		{
			return 1;
		}
		return 0;
	}

	if (strcmp(argv[1], "--bin2hex") == 0)
	{
		if (bin2hex(BUFFER_SIZE) == -1)
		{
			return 1;
		}
		return 0;
	}

	if (strcmp(argv[1], "--bin2hex_c") == 0)
	{
		if (bin2hex_c(BUFFER_SIZE) == -1)
		{
			return 1;
		}
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
