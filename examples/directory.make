# I use a file similar to this inside each directory that contains at least one folder that can build something.
# In this way users can decend into a folder and use make like normal


# Define the solution dir relative to this file in case it has not been declared yet.
ifeq ($(strip $(SOLUTION_DIR)),)
	export SOLUTION_DIR := $(shell pwd)/..
endif

DEPENDS = \
Directory1 \
Directory2 \
Directory3

#
# Do not edit below this line
#

# _debug and _clean is needed to make the list different so the right rule will be executed
# The extra characters are trimed off automatically
DEPENDS_R := $(DEPENDS:%=%_release)
DEPENDS_D := $(DEPENDS:%=%_debug)
DEPENDS_C := $(DEPENDS:%=%_clean)
DEPENDS_A := $(DEPENDS:%=%_cleanall)
DEPENDS_B := $(DEPENDS:%=%_rebuild)

default: all
.PHONY: default all clean cleanall rebuild release debug $(DEPENDS) $(DEPENDS_R) $(DEPENDS_D) $(DEPENDS_C) $(DEPENDS_B) $(DEPENDS_A)

all: release debug

rebuild: $(DEPENDS_B)

release: $(DEPENDS_R)

debug: $(DEPENDS_D)

clean: $(DEPENDS_C)

cleanall: $(DEPENDS_A)

$(DEPENDS):
	$(MAKE) -C $@

$(DEPENDS_R):
	$(MAKE) -C $(patsubst %_release, %, $@) release

$(DEPENDS_D):
	$(MAKE) -C $(patsubst %_debug, %, $@) debug
	
$(DEPENDS_C):
	$(MAKE) -C $(patsubst %_clean, %, $@) clean
	
$(DEPENDS_A):
	$(MAKE) -C $(patsubst %_cleanall, %, $@) cleanall
	
$(DEPENDS_B):
	$(MAKE) -C $(patsubst %_rebuild, %, $@) rebuild
