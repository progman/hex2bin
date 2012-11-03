#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
PROG_NAME1=hex2bin
PROG_VERSION1=0.0.1
PROG_NAME2=bin2hex
PROG_VERSION2=0.0.1
PROG_URL=https://github.com/progman/hex2bin
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
CXX=gcc
LN=g++
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
#-D_FILE_OFFSET_BITS=64 -D_LARGEFILE64_SOURCE
CFLAGS_x32DBG=-m32 -ggdb -pg -pedantic -O0 -std=c++11 -Wall -Wextra -Wlong-long -Wunused
CFLAGS_x32REL=-m32           -pedantic -O3 -std=c++11 -Wall -Wextra -Wlong-long -Wunused
CFLAGS_x64DBG=-m64 -ggdb -pg -pedantic -O0 -std=c++11 -Wall -Wextra -Wlong-long -Wunused
CFLAGS_x64REL=-m64           -pedantic -O3 -std=c++11 -Wall -Wextra -Wlong-long -Wunused
# --analyze
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
LFLAGS_x32DBG=-m32 -ggdb
LFLAGS_x32REL=-m32 -s
LFLAGS_x64DBG=-m64 -ggdb
LFLAGS_x64REL=-m64 -s
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
help:
	@echo "use make [x32 | x64 | x32dbg | x64dbg | clean]";
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
x32dbg: hex2bin.cpp bin2hex.cpp Makefile
	@if [ ! -e bin ]; then    (mkdir bin;)     fi

	@$(CXX) hex2bin.cpp -c -o bin/hex2bin.o -D'PROG_NAME="$(PROG_NAME1)"' -D'PROG_VERSION="$(PROG_VERSION1)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME1)-$(@)-$(PROG_VERSION1)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x32DBG)
	@$(LN) bin/hex2bin.o -o bin/$(PROG_NAME1)-$(@)-$(PROG_VERSION1) $(LFLAGS_x32DBG)
	@ln -sf $(PROG_NAME1)-$(@)-$(PROG_VERSION1) bin/$(PROG_NAME1)
	@objdump -Dslx bin/$(PROG_NAME1)-$(@)-$(PROG_VERSION1) > bin/$(PROG_NAME1)-$(@)-$(PROG_VERSION1).dump;

	@$(CXX) bin2hex.cpp -c -o bin/bin2hex.o -D'PROG_NAME="$(PROG_NAME2)"' -D'PROG_VERSION="$(PROG_VERSION2)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME2)-$(@)-$(PROG_VERSION2)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x32DBG)
	@$(LN) bin/bin2hex.o -o bin/$(PROG_NAME2)-$(@)-$(PROG_VERSION2) $(LFLAGS_x32DBG)
	@ln -sf $(PROG_NAME2)-$(@)-$(PROG_VERSION2) bin/$(PROG_NAME2)
	@objdump -Dslx bin/$(PROG_NAME2)-$(@)-$(PROG_VERSION2) > bin/$(PROG_NAME2)-$(@)-$(PROG_VERSION2).dump;
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
x32:    hex2bin.cpp bin2hex.cpp Makefile
	@if [ ! -e bin ]; then    (mkdir bin;)     fi

	@$(CXX) hex2bin.cpp -c -o bin/hex2bin.o -D'PROG_NAME="$(PROG_NAME1)"' -D'PROG_VERSION="$(PROG_VERSION1)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME1)-$(@)-$(PROG_VERSION1)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x32REL)
	@$(LN) bin/hex2bin.o -o bin/$(PROG_NAME1)-$(@)-$(PROG_VERSION1) $(LFLAGS_x32REL)
	@ln -sf $(PROG_NAME1)-$(@)-$(PROG_VERSION1) bin/$(PROG_NAME1)

	@$(CXX) bin2hex.cpp -c -o bin/bin2hex.o -D'PROG_NAME="$(PROG_NAME2)"' -D'PROG_VERSION="$(PROG_VERSION2)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME2)-$(@)-$(PROG_VERSION2)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x32REL)
	@$(LN) bin/bin2hex.o -o bin/$(PROG_NAME2)-$(@)-$(PROG_VERSION2) $(LFLAGS_x32REL)
	@ln -sf $(PROG_NAME2)-$(@)-$(PROG_VERSION2) bin/$(PROG_NAME2)
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
x64dbg: hex2bin.cpp bin2hex.cpp Makefile
	@if [ ! -e bin ]; then    (mkdir bin;)     fi

	@$(CXX) hex2bin.cpp -c -o bin/hex2bin.o -D'PROG_NAME="$(PROG_NAME1)"' -D'PROG_VERSION="$(PROG_VERSION1)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME1)-$(@)-$(PROG_VERSION1)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x64DBG)
	@$(LN) bin/hex2bin.o -o bin/$(PROG_NAME1)-$(@)-$(PROG_VERSION1) $(LFLAGS_x64DBG)
	@ln -sf $(PROG_NAME1)-$(@)-$(PROG_VERSION1) bin/$(PROG_NAME1)
	@objdump -Dslx bin/$(PROG_NAME1)-$(@)-$(PROG_VERSION1) > bin/$(PROG_NAME1)-$(@)-$(PROG_VERSION1).dump;

	@$(CXX) bin2hex.cpp -c -o bin/bin2hex.o -D'PROG_NAME="$(PROG_NAME2)"' -D'PROG_VERSION="$(PROG_VERSION2)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME2)-$(@)-$(PROG_VERSION2)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x64DBG)
	@$(LN) bin/bin2hex.o -o bin/$(PROG_NAME2)-$(@)-$(PROG_VERSION2) $(LFLAGS_x64DBG)
	@ln -sf $(PROG_NAME2)-$(@)-$(PROG_VERSION2) bin/$(PROG_NAME2)
	@objdump -Dslx bin/$(PROG_NAME2)-$(@)-$(PROG_VERSION2) > bin/$(PROG_NAME2)-$(@)-$(PROG_VERSION2).dump;
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
x64:    hex2bin.cpp bin2hex.cpp Makefile
	@if [ ! -e bin ]; then    (mkdir bin;)     fi

	@$(CXX) hex2bin.cpp -c -o bin/hex2bin.o -D'PROG_NAME="$(PROG_NAME1)"' -D'PROG_VERSION="$(PROG_VERSION1)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME1)-$(@)-$(PROG_VERSION1)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x64REL)
	@$(LN) bin/hex2bin.o -o bin/$(PROG_NAME1)-$(@)-$(PROG_VERSION1) $(LFLAGS_x64REL)
	@ln -sf $(PROG_NAME1)-$(@)-$(PROG_VERSION1) bin/$(PROG_NAME1)

	@$(CXX) bin2hex.cpp -c -o bin/bin2hex.o -D'PROG_NAME="$(PROG_NAME2)"' -D'PROG_VERSION="$(PROG_VERSION2)"' -D'PROG_TARGET="$(@)"' -D'PROG_FULL_NAME="$(PROG_NAME2)-$(@)-$(PROG_VERSION2)"' -D'PROG_URL="$(PROG_URL)"' $(CFLAGS_x64REL)
	@$(LN) bin/bin2hex.o -o bin/$(PROG_NAME2)-$(@)-$(PROG_VERSION2) $(LFLAGS_x64REL)
	@ln -sf $(PROG_NAME2)-$(@)-$(PROG_VERSION2) bin/$(PROG_NAME2)
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
clean:
	@if [ -e bin ]; then    rm -rf bin;    fi
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
