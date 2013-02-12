
# This file defines BIN_DIR so that all binaries will be build into a public example directory

BIN_DIR := $(SOLUTION_DIR)/bin
BUILD_DIR = build
SOURCE_DIR = src

# Output directory
OUT_DIR = $(BIN_DIR)
UOUT_DIR = $(OUT_DIR)/$(UNAME)
ROUT_DIR = $(UOUT_DIR)/Release/examples
DOUT_DIR = $(UOUT_DIR)/Debug/examples

# Intermediate directory
INT_DIR = $(BUILD_DIR)
UINT_DIR = $(INT_DIR)/$(UNAME)
RINT_DIR = $(UINT_DIR)/Release
DINT_DIR = $(UINT_DIR)/Debug