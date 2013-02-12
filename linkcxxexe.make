
# Contains implicit rules for building executables

TARGET := $(ROUT_DIR)/$(BINARY)
DTARGET := $(DOUT_DIR)/$(BINARY)_d

$(TARGET): $(OBJECTS) $(EXTRA_OBJECTS)
	+@[ -d $(dir $@) ] || mkdir -p $(dir $@)
	@echo "    CXXLD " $(@F)
	@$(CXX) $(RLDFLAGS) $(STRIP) $^ $(DEPENDS) -o $@
	@$(EXTRA_LINK)

$(DTARGET): $(DOBJECTS) $(EXTRA_DOBJECTS)
	+@[ -d $(dir $@) ] || mkdir -p $(dir $@)
	@echo "    CXXLD " $(@F)
	@$(CXX) $(DLDFLAGS) $^ $(DDEPENDS) -o $@
	@$(EXTRA_DLINK)