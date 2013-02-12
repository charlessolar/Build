
# This file defines certain platform specific things, its an abstration for the other makefiles

UNAME_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
UNAME_M := $(shell sh -c 'uname -m 2>/dev/null || echo not')
UNAME_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
UNAME_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
UNAME_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
UNAME_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')

UNAME := $(UNAME_S)-$(UNAME_M)-$(UNAME_R)

GCC := $(shell sh -c "gcc --version | sed -n 's/.*\([1-9][0-9]*\.[1-9][0-9]*\)\..*/\1/p' 2>/dev/null || echo not")

ifeq ($(UNAME_S), Linux)
	LIBC := $(shell sh -c "echo /lib/libc-*.so | sed -n 's/.*-\([1-9][0-9]*\.[1-9][0-9]*\).*\.so/\1/p'")
	UNAME := $(UNAME_S)-glibc-$(LIBC)-$(UNAME_M)
endif

ifeq ($(UNAME_S), SunOS)
	ARCH := $(shell sh -c 'isainfo -k')
	UNAME := $(UNAME_S)-$(UNAME_R)-$(ARCH)
endif

ifeq ($(UNAME_S), Darwin)
	UNAME := $(UNAME_S)-$(UNAME_R)-$(UNAME_M)
endif

ifeq ($(UNAME_S), AIX)
	UNAME := $(UNAME_S)-$(UNAME_V)-$(UNAME_P)
endif

ifeq ($(UNAME_S), HP-UX)
	UNAME := $(UNAME_S)-$(UNAME_R)-$(UNAME_M)
endif

#
# Shared lib extension
#
LIBEXT = so
ifeq ($(UNAME_S), Darwin)
	LIBEXT = dylib
endif
ifeq ($(UNAME_S), AIX)
	LIBEXT = a
endif

#
# Shared library
#
ifeq ($(UNAME_S), Darwin)
	MAKELIB = -dynamiclib -Wl,-single_module -undefined dynamic_lookup
else
	MAKELIB = -shared
endif

#
# Stripper
#
ifeq ($(UNAME_S), Darwin)
	STRIP = -dead_strip
else
	STRIP = -s
endif

#
# Platform rpath
#
ifeq ($(UNAME_S), Linux)
	RPATH = -Wl,-rpath=
endif
ifeq ($(UNAME_S), SunOS)
	RPATH = -Wl,-rpath=
endif
ifeq ($(UNAME_S), HP-UX)
	RPATH = -Wl,+nodefaultrpath -Wl,+b,
endif
ifeq ($(UNAME_S), Darwin)
	RPATH = -Wl,-rpath,
endif
ifeq ($(UNAME_S), AIX)
	RPATH = -Wl,-L
endif

ifeq ($(UNAME_S), Darwin)
	LDFLAGS += -framework CoreFoundation
endif


