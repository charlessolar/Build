
# Contains the optimization and debug flags used for all builds

RELEASE_FLAGS = -pipe -O3 -fomit-frame-pointer -Wall -Wno-unknown-pragmas -fno-common -fno-stack-check
DEBUG_FLAGS = -pipe -g -ggdb3 -Wall -Wno-unknown-pragmas

# -MMD and -MF are for specifying auto dependancies aka, if you modify a header file, the c files are recompiled
AUTO_DEP_FLAGS = -MMD -MF $(UINT_DIR)/$*.d

RCFLAGS = $(AUTO_DEP_FLAGS) $(RELEASE_FLAGS) $(CFLAGS) $(DEFINES) -DNDEBUG
DCFLAGS = $(AUTO_DEP_FLAGS) $(DEBUG_FLAGS) $(CFLAGS) $(DDEFINES) -D_DEBUG

RCXXFLAGS = $(AUTO_DEP_FLAGS) $(RELEASE_FLAGS) $(CXXFLAGS) $(DEFINES) -DNDEBUG
DCXXFLAGS = $(AUTO_DEP_FLAGS) $(DEBUG_FLAGS) $(CXXFLAGS) $(DDEFINES) -D_DEBUG

ifeq ($(strip $(DDEFINES)),)
	DDEFINES = $(DEFINES)
endif

# This will make the linker tell us when there are unresolved externals when linking a library
# Default behavior is to allow it for some reason
ifeq ($(UNAME_S), Linux)
	LDFLAGS += -Wl,-z,defs
endif
ifeq ($(UNAME_S), SunOS)
	LDFLAGS += -Wl,-z,defs
endif

RLDFLAGS = $(LDFLAGS)
DLDFLAGS = $(LDFLAGS)

