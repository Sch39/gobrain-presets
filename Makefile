# =========================
# GoBrain Makefile
# =========================

APP_NAME := gob

SANDBOX_DIR := sandbox

# -------------------------
# Default
# -------------------------
.PHONY: help
help:
	@echo "Available commands:"
	@echo "  make sandbox   - Build gob & prepare sandbox for manual testing"
	@echo "  make clean     - Remove build & sandbox artifacts"

# -------------------------
# Build
# -------------------------

.PHONY: sandbox
sandbox:
	@echo ">> Preparing sandbox environment..."
	@rm -rf $(SANDBOX_DIR)
	@mkdir -p $(SANDBOX_DIR)
	@echo ""
	@echo "Sandbox ready!"
	@echo "-----------------------------------"
	@echo "Example:"
	@echo "  cd $(SANDBOX_DIR) && $(APP_NAME) init"
	@echo ""

# -------------------------
# Clean
# -------------------------
.PHONY: clean
clean:
	@echo ">> Cleaning artifacts..."
	@rm -rf $(SANDBOX_DIR)
