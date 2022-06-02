# 'make depend'      uses makedepend to automatically generate dependencies
#                    (dependencies are added to end of Makefile)
# 'make'             build executable file 'mycc'
# 'make clean'       removes all .o files
# 'make clean all'   removes all .o files and executable file

# define the C++ compiler to use
CC := g++-11
RM := rm -rf

# define any compile-time flags
# Uncomment -g for debugging information
# Uncomment -fPIC for shared library
CFLAGS := -Wall -Werror -std=c++20 #-g #-fPIC

# define any directories containing header files other than /usr/include
#
INC := ./headers ./sources ${sort ${dir ${wildcard ./headers/*/ ./sources/*/}}}
INCLUDES := $(foreach d, $(INC), -I$d)

LFLAGS := -L./libs

# This should generate a shared object
# Uncomment -shared for shared libraries
LDFLAGS := #-shared

LIBS := -pthread

# define the C++ source files
SRCS := $(wildcard ./sources/*.cpp ./sources/*/*.cpp)

OBJS := $(SRCS:.cpp=.o)

# define the executable file
MAIN := exe

.PHONY: depend clean clean_all

all:    $(MAIN)
	@echo  '$(MAIN)' has been compiled

$(MAIN): $(OBJS)
	# TODO: If you want to create a normal binary file, use this
	$(CC) $(CFLAGS) $(INCLUDES) -o $(MAIN) $(OBJS) $(LFLAGS) $(LIBS)
	# TODO: If you want to create a shared library, use this
	# $(CC) $(CFLAGS) $(LDFLAGS) $(LIBS) -o $@ $^

.cpp.o:
	$(CC) $(CFLAGS) $(INCLUDES) -c $<  -o $@

clean:
	$(RM) sources/*.o *~
	$(RM) $(MAIN).dSYM

clean_all:
	$(RM) sources/*.o *~ $(MAIN)
	$(RM) $(MAIN).dSYM

depend: $(SRCS)
	makedepend $(INCLUDES) $^

# DO NOT DELETE THIS LINE -- make depend needs it
