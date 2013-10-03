#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
PROG_NAME=hex2bin
PROG_VERSION=0.0.2
PROG_URL=https://github.com/progman/hex2bin

SOURCE_LIST=hex2bin.cpp submodule/lib_cpp/lib_cpp.cpp
HEADER_LIST=submodule/lib_cpp/lib_cpp.h
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
CC=g++
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
	@$(CC) submodule/lib_cpp/lib_cpp.cpp -o bin/lib_cpp.o -c -D'PROG_NAME="$(PROG_NAME)"' -D'PROG_VERSION="$(PROG_VERSION)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME)-$(@)-$(PROG_VERSION)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x32DBG)
	@$(CC) hex2bin.cpp                   -o bin/hex2bin.o -c -D'PROG_NAME="$(PROG_NAME)"' -D'PROG_VERSION="$(PROG_VERSION)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME)-$(@)-$(PROG_VERSION)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x32DBG)

	@$(LN) bin/lib_cpp.o bin/hex2bin.o -o bin/$(PROG_NAME)-$(@)-$(PROG_VERSION) $(LFLAGS_x32DBG)
	@ln -sf $(PROG_NAME)-$(@)-$(PROG_VERSION) bin/$(PROG_NAME)
	@objdump -Dslx bin/$(PROG_NAME)-$(@)-$(PROG_VERSION) > bin/$(PROG_NAME)-$(@)-$(PROG_VERSION).dump;
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
x32test: Makefile $(SOURCE_LIST) $(HEADER_LIST)
	@if [ ! -e bin ]; then    (mkdir bin;)     fi
	@clang --analyze submodule/lib_cpp/lib_cpp.cpp -o bin/lib_cpp.o -c -D'PROG_NAME="$(PROG_NAME)"' -D'PROG_VERSION="$(PROG_VERSION)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME)-$(@)-$(PROG_VERSION)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x32REL)
	@clang --analyze hex2bin.cpp -o bin/hex2bin.o -c -D'PROG_NAME="$(PROG_NAME)"' -D'PROG_VERSION="$(PROG_VERSION)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME)-$(@)-$(PROG_VERSION)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x32REL)
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
x32: Makefile $(SOURCE_LIST) $(HEADER_LIST)
	@if [ ! -e bin ]; then    (mkdir bin;)     fi
	@$(CC) submodule/lib_cpp/lib_cpp.cpp -o bin/lib_cpp.o -c -D'PROG_NAME="$(PROG_NAME)"' -D'PROG_VERSION="$(PROG_VERSION)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME)-$(@)-$(PROG_VERSION)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x32REL)
	@$(CC) hex2bin.cpp                   -o bin/hex2bin.o -c -D'PROG_NAME="$(PROG_NAME)"' -D'PROG_VERSION="$(PROG_VERSION)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME)-$(@)-$(PROG_VERSION)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x32REL)

	@$(LN) bin/lib_cpp.o bin/hex2bin.o -o bin/$(PROG_NAME)-$(@)-$(PROG_VERSION) $(LFLAGS_x32REL)
	@ln -sf $(PROG_NAME)-$(@)-$(PROG_VERSION) bin/$(PROG_NAME)
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
x64dbg: Makefile $(SOURCE_LIST) $(HEADER_LIST)
	@if [ ! -e bin ]; then    (mkdir bin;)     fi
	@$(CC) submodule/lib_cpp/lib_cpp.cpp -o bin/lib_cpp.o -c -D'PROG_NAME="$(PROG_NAME)"' -D'PROG_VERSION="$(PROG_VERSION)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME)-$(@)-$(PROG_VERSION)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x64DBG)
	@$(CC) hex2bin.cpp                   -o bin/hex2bin.o -c -D'PROG_NAME="$(PROG_NAME)"' -D'PROG_VERSION="$(PROG_VERSION)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME)-$(@)-$(PROG_VERSION)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x64DBG)

	@$(LN) bin/lib_cpp.o bin/hex2bin.o -o bin/$(PROG_NAME)-$(@)-$(PROG_VERSION) $(LFLAGS_x64DBG)
	@ln -sf $(PROG_NAME)-$(@)-$(PROG_VERSION) bin/$(PROG_NAME)
	@objdump -Dslx bin/$(PROG_NAME)-$(@)-$(PROG_VERSION) > bin/$(PROG_NAME)-$(@)-$(PROG_VERSION).dump;
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
x64test: Makefile $(SOURCE_LIST) $(HEADER_LIST)
	@if [ ! -e bin ]; then    (mkdir bin;)     fi
	@clang --analyze submodule/lib_cpp/lib_cpp.cpp -o bin/lib_cpp.o -c -D'PROG_NAME="$(PROG_NAME)"' -D'PROG_VERSION="$(PROG_VERSION)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME)-$(@)-$(PROG_VERSION)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x64REL)
	@clang --analyze hex2bin.cpp -o bin/hex2bin.o -c -D'PROG_NAME="$(PROG_NAME)"' -D'PROG_VERSION="$(PROG_VERSION)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME)-$(@)-$(PROG_VERSION)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x64REL)
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
x64: Makefile $(SOURCE_LIST) $(HEADER_LIST)
	@if [ ! -e bin ]; then    (mkdir bin;)     fi
	@$(CC) submodule/lib_cpp/lib_cpp.cpp -o bin/lib_cpp.o -c -D'PROG_NAME="$(PROG_NAME)"' -D'PROG_VERSION="$(PROG_VERSION)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME)-$(@)-$(PROG_VERSION)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x64REL)
	@$(CC) hex2bin.cpp                   -o bin/hex2bin.o -c -D'PROG_NAME="$(PROG_NAME)"' -D'PROG_VERSION="$(PROG_VERSION)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME)-$(@)-$(PROG_VERSION)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x64REL)

	@$(LN) bin/lib_cpp.o bin/hex2bin.o -o bin/$(PROG_NAME)-$(@)-$(PROG_VERSION) $(LFLAGS_x64REL)
	@ln -sf $(PROG_NAME)-$(@)-$(PROG_VERSION) bin/$(PROG_NAME)
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
clean:
	@if [ -e bin ]; then    rm -rf bin;    fi
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
