
# Contains the rules for project makefiles
	
.PHONY: default all clean cleanall rebuild release debug

all: release debug

rebuild: cleanall all

release: $(TARGET)
	@$(EXTRA_RELEASE)

debug: $(DTARGET)
	@$(EXTRA_DEBUG)

clean:
	$(RM) -r $(UINT_DIR)

cleanall: clean
	@$(EXTRA_CLEANALL)
	$(RM) $(TARGET)
	$(RM) $(DTARGET)
	-@[ ! -d $(ROUT_DIR) ] || rmdir $(ROUT_DIR) 2>/dev/null
	-@[ ! -d $(DOUT_DIR) ] || rmdir $(DOUT_DIR) 2>/dev/null
	-@[ ! -d $(OUT_DIR) ] || rmdir $(OUT_DIR) 2>/dev/null