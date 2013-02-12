# An example of a C++ executable makefile using this build system

# Define the solution dir relative to this file in case it has not been declared yet.
ifeq ($(strip $(SOLUTION_DIR)),)
	export SOLUTION_DIR := $(shell pwd)/..
endif

# Platform is included at the top so we can define certain extra flags for certain platforms
include $(SOLUTION_DIR)/props/platform.make

BINARY = example

INCLUDE = -I./include

CXXFLAGS += -Wno-strict-aliasing -Wno-sign-compare -Wno-unused-variable
# Define rpath as $ORIGIN for every platform
LDFLAGS += $(RPATH)'$$ORIGIN' -pthread -ldl

# Project uses threads, and solaris needs to know
ifeq ($(UNAME_S), SunOS)
	CXXFLAGS += -pthreads
endif

# example executable depends on libexample
DEPENDS = -L$(ROUT_DIR) -lexample
DDEPENDS = -L$(DOUT_DIR) -lexample_d

SOURCES = \
Source1.cpp \
Source2.cpp \
Source3.cpp \
Source4.cpp

# Dont edit anything below here

default: all

# Run extra things after done linking
EXTRA_RELEASE = echo "Finished building example"
EXTRA_DEBUG = echo "Finished building example debug"

# I put the makefiles into a props directory for my projects
include $(SOLUTION_DIR)/props/buildpublic.make
include $(SOLUTION_DIR)/props/flags.make
include $(SOLUTION_DIR)/props/buildcxx.make
include $(SOLUTION_DIR)/props/linkcxxexe.make
include $(SOLUTION_DIR)/props/rules.make

# Advanced use of -rpath-link, most people never need to do this
# but your makefiles can add things to our 'internal' variables like so
ifeq ($(UNAME_S), Linux)
	RLDFLAGS += -Xlinker -rpath-link=$(ROUT_DIR)
	DLDFLAGS += -Xlinker -rpath-link=$(DOUT_DIR)
endif
ifeq ($(UNAME_S), SunOS)
	RLDFLAGS += -Xlinker -rpath-link=$(ROUT_DIR)
	DLDFLAGS += -Xlinker -rpath-link=$(DOUT_DIR)
endif
