#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
PROG_NAME1=hex2bin
PROG_VERSION1=0.0.1
PROG_NAME2=bin2hex
PROG_VERSION2=0.0.1
PROG_URL=https://github.com/progman/hex2bin

SOURCE_LIST=hex2bin.cpp bin2hex.cpp submodule/lib_cpp/lib_cpp.cpp
HEADER_LIST=submodule/lib_cpp/lib_cpp.h
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
CC=gcc
LN=g++
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
CFLAGS_x32DBG=-m32 -pedantic -std=c++11 -Wall -Wextra -Wlong-long -Wunused -pipe -march=native -mtune=native -O0 -g3 -ggdb -pg
CFLAGS_x32REL=-m32 -pedantic -std=c++11 -Wall -Wextra -Wlong-long -Wunused -pipe -march=native -mtune=native -O3 -g0           -funroll-all-loops
CFLAGS_x64DBG=-m64 -pedantic -std=c++11 -Wall -Wextra -Wlong-long -Wunused -pipe -march=native -mtune=native -O0 -g3 -ggdb -pg
CFLAGS_x64REL=-m64 -pedantic -std=c++11 -Wall -Wextra -Wlong-long -Wunused -pipe -march=native -mtune=native -O3 -g0           -funroll-all-loops
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
LFLAGS_x32DBG=-m32 -g3 -ggdb
LFLAGS_x32REL=-m32 -g0       -s
LFLAGS_x64DBG=-m64 -g3 -ggdb
LFLAGS_x64REL=-m64 -g0       -s
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
help:
	@echo "use make [x32 | x64 | x32dbg | x64dbg | clean]";
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
x32dbg: Makefile $(SOURCE_LIST) $(HEADER_LIST)
	@if [ ! -e bin ]; then    (mkdir bin;)     fi

	@$(CC) submodule/lib_cpp/lib_cpp.cpp -o bin/lib_cpp.o -c -D'PROG_NAME="$(PROG_NAME1)"' -D'PROG_VERSION="$(PROG_VERSION1)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME1)-$(@)-$(PROG_VERSION1)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x32DBG)

	@$(CC) hex2bin.cpp -o bin/hex2bin.o -c -D'PROG_NAME="$(PROG_NAME1)"' -D'PROG_VERSION="$(PROG_VERSION1)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME1)-$(@)-$(PROG_VERSION1)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x32DBG)
	@$(LN) bin/lib_cpp.o bin/hex2bin.o -o bin/$(PROG_NAME1)-$(@)-$(PROG_VERSION1) $(LFLAGS_x32DBG)
	@ln -sf $(PROG_NAME1)-$(@)-$(PROG_VERSION1) bin/$(PROG_NAME1)
	@objdump -Dslx bin/$(PROG_NAME1)-$(@)-$(PROG_VERSION1) > bin/$(PROG_NAME1)-$(@)-$(PROG_VERSION1).dump;

	@$(CC) bin2hex.cpp -o bin/bin2hex.o -c -D'PROG_NAME="$(PROG_NAME2)"' -D'PROG_VERSION="$(PROG_VERSION2)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME2)-$(@)-$(PROG_VERSION2)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x32DBG)
	@$(LN) bin/lib_cpp.o bin/bin2hex.o -o bin/$(PROG_NAME2)-$(@)-$(PROG_VERSION2) $(LFLAGS_x32DBG)
	@ln -sf $(PROG_NAME2)-$(@)-$(PROG_VERSION2) bin/$(PROG_NAME2)
	@objdump -Dslx bin/$(PROG_NAME2)-$(@)-$(PROG_VERSION2) > bin/$(PROG_NAME2)-$(@)-$(PROG_VERSION2).dump;
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
x32test: Makefile $(SOURCE_LIST) $(HEADER_LIST)
	@if [ ! -e bin ]; then    (mkdir bin;)     fi

	@clang --analyze submodule/lib_cpp/lib_cpp.cpp -o bin/lib_cpp.o -c -D'PROG_NAME="$(PROG_NAME1)"' -D'PROG_VERSION="$(PROG_VERSION1)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME1)-$(@)-$(PROG_VERSION1)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x32REL)
	@clang --analyze hex2bin.cpp -o bin/hex2bin.o -c -D'PROG_NAME="$(PROG_NAME1)"' -D'PROG_VERSION="$(PROG_VERSION1)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME1)-$(@)-$(PROG_VERSION1)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x32REL)
	@clang --analyze bin2hex.cpp -o bin/bin2hex.o -c -D'PROG_NAME="$(PROG_NAME2)"' -D'PROG_VERSION="$(PROG_VERSION2)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME2)-$(@)-$(PROG_VERSION2)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x32REL)
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
x32: Makefile $(SOURCE_LIST) $(HEADER_LIST)
	@if [ ! -e bin ]; then    (mkdir bin;)     fi

	@$(CC) submodule/lib_cpp/lib_cpp.cpp -o bin/lib_cpp.o -c -D'PROG_NAME="$(PROG_NAME1)"' -D'PROG_VERSION="$(PROG_VERSION1)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME1)-$(@)-$(PROG_VERSION1)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x32REL)

	@$(CC) hex2bin.cpp -o bin/hex2bin.o -c -D'PROG_NAME="$(PROG_NAME1)"' -D'PROG_VERSION="$(PROG_VERSION1)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME1)-$(@)-$(PROG_VERSION1)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x32REL)
	@$(LN) bin/lib_cpp.o bin/hex2bin.o -o bin/$(PROG_NAME1)-$(@)-$(PROG_VERSION1) $(LFLAGS_x32REL)
	@ln -sf $(PROG_NAME1)-$(@)-$(PROG_VERSION1) bin/$(PROG_NAME1)

	@$(CC) bin2hex.cpp -o bin/bin2hex.o -c -D'PROG_NAME="$(PROG_NAME2)"' -D'PROG_VERSION="$(PROG_VERSION2)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME2)-$(@)-$(PROG_VERSION2)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x32REL)
	@$(LN) bin/lib_cpp.o bin/bin2hex.o -o bin/$(PROG_NAME2)-$(@)-$(PROG_VERSION2) $(LFLAGS_x32REL)
	@ln -sf $(PROG_NAME2)-$(@)-$(PROG_VERSION2) bin/$(PROG_NAME2)
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
x64dbg: Makefile $(SOURCE_LIST) $(HEADER_LIST)
	@if [ ! -e bin ]; then    (mkdir bin;)     fi

	@$(CC) submodule/lib_cpp/lib_cpp.cpp -o bin/lib_cpp.o -c -D'PROG_NAME="$(PROG_NAME1)"' -D'PROG_VERSION="$(PROG_VERSION1)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME1)-$(@)-$(PROG_VERSION1)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x64DBG)

	@$(CC) hex2bin.cpp -o bin/hex2bin.o -c -D'PROG_NAME="$(PROG_NAME1)"' -D'PROG_VERSION="$(PROG_VERSION1)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME1)-$(@)-$(PROG_VERSION1)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x64DBG)
	@$(LN) bin/lib_cpp.o bin/hex2bin.o -o bin/$(PROG_NAME1)-$(@)-$(PROG_VERSION1) $(LFLAGS_x64DBG)
	@ln -sf $(PROG_NAME1)-$(@)-$(PROG_VERSION1) bin/$(PROG_NAME1)
	@objdump -Dslx bin/$(PROG_NAME1)-$(@)-$(PROG_VERSION1) > bin/$(PROG_NAME1)-$(@)-$(PROG_VERSION1).dump;

	@$(CC) bin2hex.cpp -o bin/bin2hex.o -c -D'PROG_NAME="$(PROG_NAME2)"' -D'PROG_VERSION="$(PROG_VERSION2)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME2)-$(@)-$(PROG_VERSION2)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x64DBG)
	@$(LN) bin/lib_cpp.o bin/bin2hex.o -o bin/$(PROG_NAME2)-$(@)-$(PROG_VERSION2) $(LFLAGS_x64DBG)
	@ln -sf $(PROG_NAME2)-$(@)-$(PROG_VERSION2) bin/$(PROG_NAME2)
	@objdump -Dslx bin/$(PROG_NAME2)-$(@)-$(PROG_VERSION2) > bin/$(PROG_NAME2)-$(@)-$(PROG_VERSION2).dump;
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
x64test: Makefile $(SOURCE_LIST) $(HEADER_LIST)
	@if [ ! -e bin ]; then    (mkdir bin;)     fi

	@clang --analyze submodule/lib_cpp/lib_cpp.cpp -o bin/lib_cpp.o -c -D'PROG_NAME="$(PROG_NAME1)"' -D'PROG_VERSION="$(PROG_VERSION1)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME1)-$(@)-$(PROG_VERSION1)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x64REL)
	@clang --analyze hex2bin.cpp -o bin/hex2bin.o -c -D'PROG_NAME="$(PROG_NAME1)"' -D'PROG_VERSION="$(PROG_VERSION1)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME1)-$(@)-$(PROG_VERSION1)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x64REL)
	@clang --analyze bin2hex.cpp -o bin/bin2hex.o -c -D'PROG_NAME="$(PROG_NAME2)"' -D'PROG_VERSION="$(PROG_VERSION2)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME2)-$(@)-$(PROG_VERSION2)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x64REL)
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
x64: Makefile $(SOURCE_LIST) $(HEADER_LIST)
	@if [ ! -e bin ]; then    (mkdir bin;)     fi

	@$(CC) submodule/lib_cpp/lib_cpp.cpp -o bin/lib_cpp.o -c -D'PROG_NAME="$(PROG_NAME1)"' -D'PROG_VERSION="$(PROG_VERSION1)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME1)-$(@)-$(PROG_VERSION1)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x64REL)

	@$(CC) hex2bin.cpp -o bin/hex2bin.o -c -D'PROG_NAME="$(PROG_NAME1)"' -D'PROG_VERSION="$(PROG_VERSION1)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME1)-$(@)-$(PROG_VERSION1)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x64REL)
	@$(LN) bin/lib_cpp.o bin/hex2bin.o -o bin/$(PROG_NAME1)-$(@)-$(PROG_VERSION1) $(LFLAGS_x64REL)
	@ln -sf $(PROG_NAME1)-$(@)-$(PROG_VERSION1) bin/$(PROG_NAME1)

	@$(CC) bin2hex.cpp -o bin/bin2hex.o -c -D'PROG_NAME="$(PROG_NAME2)"' -D'PROG_VERSION="$(PROG_VERSION2)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME2)-$(@)-$(PROG_VERSION2)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x64REL)
	@$(LN) bin/lib_cpp.o bin/bin2hex.o -o bin/$(PROG_NAME2)-$(@)-$(PROG_VERSION2) $(LFLAGS_x64REL)
	@ln -sf $(PROG_NAME2)-$(@)-$(PROG_VERSION2) bin/$(PROG_NAME2)
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
clean:
	@if [ -e bin ]; then    rm -rf bin;    fi
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
