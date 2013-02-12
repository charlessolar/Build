
# Contains implicit rules for building libraries

TARGET = $(ROUT_DIR)/$(BINARY).$(LIBEXT)
DTARGET = $(DOUT_DIR)/$(BINARY)_d.$(LIBEXT)

$(TARGET): $(OBJECTS) $(EXTRA_OBJECTS)
	+@[ -d $(dir $@) ] || mkdir -p $(dir $@)
	@echo "    CXXLD " $(@F)
	@$(CXX) $(MAKELIB) $(RLDFLAGS) $(STRIP) $^ $(DEPENDS) -o $@
	@$(EXTRA_LINK)

$(DTARGET): $(DOBJECTS) $(EXTRA_DOBJECTS)
	+@[ -d $(dir $@) ] || mkdir -p $(dir $@)
	@echo "    CXXLD " $(@F)
	@$(CXX) $(MAKELIB) $(DLDFLAGS) $^ $(DDEPENDS) -o $@
	@$(EXTRA_DLINK)
	