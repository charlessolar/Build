
# Contains implicit rules to build .cpp files

# VPATH helps make find the c files
VPATH = $(addprefix $(SOURCE_DIR)/, $(dir $(SOURCES))) $(addprefix $(SOURCE_DIR)/, $(dir $(EXTRA_SOURCES)))

OBJECTS := $(patsubst %.cpp, $(RINT_DIR)/%.o, $(notdir $(SOURCES)))
DOBJECTS := $(patsubst %.cpp, $(DINT_DIR)/%.o, $(notdir $(SOURCES)))

# Note about the cp, sed, rm.. I am sure it might seem strange.
# The 4 lines make it so that if you compile, then change one header file, then recompile,
# all the c files that depend on that header file will recompile.
# Its very handy
# Read: http://make.paulandlesley.org/autodep.html

$(OBJECTS): $(RINT_DIR)/%.o: %.cpp
	+@[ -d $(dir $@) ] || mkdir -p $(dir $@)
	@echo "    CXX   " $<
	@$(CXX) $(INCLUDE) $(RCXXFLAGS) -o $@ -c $<
	@cp $(UINT_DIR)/$*.d $(UINT_DIR)/$*.P; \
		sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
			-e '/^$$/ d' -e 's/$$/ :/' < $(UINT_DIR)/$*.d >> $(UINT_DIR)/$*.P; \
		rm -f $(UINT_DIR)/$*.d

$(DOBJECTS): $(DINT_DIR)/%.o: %.cpp
	+@[ -d $(dir $@) ] || mkdir -p $(dir $@)
	@echo "    CXX   " $<
	@$(CXX) $(INCLUDE) $(DCXXFLAGS) -o $@ -c $<
	@cp $(UINT_DIR)/$*.d $(UINT_DIR)/$*.P; \
		sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
			-e '/^$$/ d' -e 's/$$/ :/' < $(UINT_DIR)/$*.d >> $(UINT_DIR)/$*.P; \
		rm -f $(UINT_DIR)/$*.d
		
-include $(patsubst %.cpp, $(UINT_DIR)/%.P, $(notdir $(SOURCES)))
