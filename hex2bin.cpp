//-----------------------------------------------------------------------------------------------------------------------------------------------------------//
// 0.0.1
// Alexey Potehin http://www.gnuplanet.ru/doc/cv
//-----------------------------------------------------------------------------------------------------------------------------------------------------------//
#include <stdio.h>
#include <stdlib.h>
//-----------------------------------------------------------------------------------------------------------------------------------------------------------//
// convert sibmol to number, example: '0' -> 0, 'F' -> 15
unsigned char hex2bin(unsigned char ch)
{
	static unsigned char hex2bin_table[] =
	{
//      00  01  02  03  04  05  06  07  08  09  0A  0B  0C  0D  0E  0F
		 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, // 00
		 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, // 10
		 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, // 20
		 0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  0,  0,  0,  0,  0,  0, // 30
		 0, 10, 11, 12, 13, 14, 15,  0,  0,  0,  0,  0,  0,  0,  0,  0, // 40
		 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, // 50
		 0, 10, 11, 12, 13, 14, 15,  0,  0,  0,  0,  0,  0,  0,  0,  0, // 60
		 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, // 70
		 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, // 80
		 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, // 90
		 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, // A0
		 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, // B0
		 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, // C0
		 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, // D0
		 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, // E0
		 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0  // F0
	};

	return hex2bin_table[ch];
/*
	if
	(
		(ch >= '0') &&
		(ch <= '9')
	)
	{
		return ch - '0';
	}


	if
	(
		(ch >= 'a') &&
		(ch <= 'f')
	)
	{
		return ch - 'a' + 10;
	}


	if
	(
		(ch >= 'A') &&
		(ch <= 'F')
	)
	{
		return ch - 'A' + 10;
	}


	return 0;
*/
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------//
// general function
int main(int argc, char* argv[])
{
	if (argc != 1)
	{
		printf("example: echo \"68656C6C6F206675636B696E6720776F726C64210A\" | %s\n", argv[0]);
		exit(1);
	}


// read from stdin, convert to bin, write to stdout
	for(;;)
	{
		int ch1 = getchar();
		if (ch1 == EOF) break;

		int ch2 = getchar();
		if (ch2 == EOF) break;

		unsigned char ch = (char)((hex2bin((unsigned char)ch1) * 16) + hex2bin((unsigned char)ch2));

		printf ("%c", ch);
	}
	fflush(stdout);


	return 0;
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------//
