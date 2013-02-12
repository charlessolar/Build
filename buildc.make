
# Contains implicit rules to build .c files

# VPATH helps make find the c files
VPATH = $(addprefix $(SOURCE_DIR)/, $(dir $(SOURCES))) $(addprefix $(SOURCE_DIR)/, $(dir $(EXTRA_SOURCES)))

OBJECTS := $(patsubst %.c, $(RINT_DIR)/%.o, $(notdir $(SOURCES)))
DOBJECTS := $(patsubst %.c, $(DINT_DIR)/%.o, $(notdir $(SOURCES)))

# Note about the cp, sed, rm.. I am sure it might seem strange.
# The 4 lines make it so that if you compile, then change one header file, then recompile,
# all the c files that depend on that header file will recompile.
# Its very handy
# Read: http://make.paulandlesley.org/autodep.html

$(OBJECTS): $(RINT_DIR)/%.o: %.c
	+@[ -d $(dir $@) ] || mkdir -p $(dir $@)
	@echo "    CC    " $(<F)
	@$(CC) $(INCLUDE) $(RCFLAGS) -o $@ -c $<
	@cp $(UINT_DIR)/$*.d $(UINT_DIR)/$*.P; \
		sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
			-e '/^$$/ d' -e 's/$$/ :/' < $(UINT_DIR)/$*.d >> $(UINT_DIR)/$*.P; \
		rm -f $(UINT_DIR)/$*.d

$(DOBJECTS): $(DINT_DIR)/%.o: %.c
	+@[ -d $(dir $@) ] || mkdir -p $(dir $@)
	@echo "    CC    " $(<F)
	@$(CC) $(INCLUDE) $(DCFLAGS) -o $@ -c $<
	@cp $(UINT_DIR)/$*.d $(UINT_DIR)/$*.P; \
		sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
			-e '/^$$/ d' -e 's/$$/ :/' < $(UINT_DIR)/$*.d >> $(UINT_DIR)/$*.P; \
		rm -f $(UINT_DIR)/$*.d

# For autodependancy, include all the rules that help make tell if a header file has changed
-include $(patsubst %.c, $(UINT_DIR)/%.P, $(notdir $(SOURCES)))