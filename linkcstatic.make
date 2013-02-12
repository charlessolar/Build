
# Contains implicit rules for building static libraries

TARGET = $(ROUT_DIR)/$(BINARY).a
DTARGET = $(DOUT_DIR)/$(BINARY)_d.a

$(TARGET): $(OBJECTS) $(EXTRA_OBJECTS)
	+@[ -d $(dir $@) ] || mkdir -p $(dir $@)
	@echo "    AR    " $(@F)
	@$(AR) rcs $@ $^

$(DTARGET): $(DOBJECTS) $(EXTRA_DOBJECTS)
	+@[ -d $(dir $@) ] || mkdir -p $(dir $@)
	@echo "    AR    " $(@F)
	@$(AR) rcs $@ $^