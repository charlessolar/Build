# An example of a C shared library makefile using this build system

# Define the solution dir relative to this file in case it has not been declared yet.
ifeq ($(strip $(SOLUTION_DIR)),)
	export SOLUTION_DIR := $(shell pwd)/..
endif

# Platform is included at the top so we can define certain extra flags for certain platforms
include $(SOLUTION_DIR)/props/platform.make

BINARY = libcexample

INCLUDE = -I./include

# Define rpath as $ORIGIN for every platform
LDFLAGS += $(RPATH)'$$ORIGIN' -pthread -ldl

# Solaris needs extra libs
ifeq ($(UNAME_S), SunOS)
	LDFLAGS += -lrt -lnsl
endif

CXXFLAGS += -fPIC -fno-strict-aliasing -Wno-enum-compare
# Project uses threads, and solaris needs to know
ifeq ($(UNAME_S), SunOS)
	CXXFLAGS += -pthreads
endif

SOURCES = \
Source1.c \
Source2.c \
Source3.c \
Source4.c

# Dont edit anything below here

default: all

# I put the makefiles into a props directory for my projects
include $(SOLUTION_DIR)/props/buildpublic.make
include $(SOLUTION_DIR)/props/flags.make
include $(SOLUTION_DIR)/props/buildc.make
include $(SOLUTION_DIR)/props/linkclib.make
include $(SOLUTION_DIR)/props/rules.make
