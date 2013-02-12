
# Contains implicit rules for building executables

TARGET := $(ROUT_DIR)/$(BINARY)
DTARGET := $(DOUT_DIR)/$(BINARY)_d

$(TARGET): $(OBJECTS) $(EXTRA_OBJECTS)
	+@[ -d $(dir $@) ] || mkdir -p $(dir $@)
	@echo "    CCLD  " $(@F)
	@$(CC) $(RLDFLAGS) $(STRIP) $^ $(DEPENDS) -o $@

$(DTARGET): $(DOBJECTS) $(EXTRA_DOBJECTS)
	+@[ -d $(dir $@) ] || mkdir -p $(dir $@)
	@echo "    CCLD  " $(@F)
	@$(CC) $(DLDFLAGS) $^ $(DDEPENDS) -o $@