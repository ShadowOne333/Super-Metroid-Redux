#-------------------------------------------------------------
# Super Metroid Redux Makefile
#-------------------------------------------------------------

# Paths
OUT_DIR       := out
PATCHES_DIR   := patches
ROM_DIR       := rom
ARCHIVE_DIR   := outarchive
ASM_FILE      := code/main.asm
FILE_BASE     := Super-Metroid-Redux

# Detect OS for Asar + Flips
ifeq ($(OS),Windows_NT)
    ASAR  := bin/asar-win/asar-standalone.exe
    FLIPS := bin/flips.exe
else
    ASAR  := bin/asar-linux/asar-standalone
    FLIPS := bin/flips
endif

# ROMs
CLEAN_ROM    := $(ROM_DIR)/SuperMetroid.sfc
PATCHED_ROM  := $(OUT_DIR)/$(FILE_BASE).sfc
IPS_PATCH    := $(PATCHES_DIR)/$(FILE_BASE).ips

# Checksums
CLEAN_CHECKSUM   := da957f0d63d14cb441d215462904c4fa8519c613
PATCHED_CHECKSUM := PUT_KNOWN_PATCHED_SHA1_HERE

#-------------------------------------------------------------
# Default target
.PHONY: all
all: redux

#-------------------------------------------------------------
# Redux build
.PHONY: redux
redux: reset_flags build archive
	@echo "=== Redux build finished at $$(date '+%T %a %d/%b/%Y') ==="

#-------------------------------------------------------------
# Reset ASM flags
.PHONY: reset_flags
reset_flags:
	@sed -i 's/!newgfx = 0/!newgfx = 1/g' $(ASM_FILE)
	@sed -i 's/!retranslation = 1/!retranslation = 0/g' $(ASM_FILE)

#-------------------------------------------------------------
# Build process
.PHONY: build
build: $(PATCHED_ROM) $(IPS_PATCH)

# Build patched ROM
$(PATCHED_ROM): $(CLEAN_ROM)
	@echo "=== Build started at $$(date '+%T %a %d/%b/%Y') ==="
	@mkdir -p $(OUT_DIR)
	@echo "Verifying clean ROM checksum..."
	@[ "$$(sha1sum $(CLEAN_ROM) | awk '{print $$1}')" = "$(CLEAN_CHECKSUM)" ] || \
		( echo "ERROR: Clean ROM checksum mismatch!" && exit 1 )
	@cp $(CLEAN_ROM) $(PATCHED_ROM)
	@echo "Running Asar ($(ASAR))..."
	@$(ASAR) $(ASM_FILE) $(PATCHED_ROM)
	@echo "Asar assembly complete."
	@echo "Verifying patched ROM checksum..."
	@if [ "$(PATCHED_CHECKSUM)" != "PUT_KNOWN_PATCHED_SHA1_HERE" ]; then \
		if [ "$$(sha1sum $(PATCHED_ROM) | awk '{print $$1}')" != "$(PATCHED_CHECKSUM)" ]; then \
			echo "WARNING: Patched ROM checksum mismatch!"; \
		else \
			echo "Patched ROM checksum verified."; \
		fi \
	else \
		echo "Patched ROM checksum skipped (no reference set)."; \
	fi

# Create IPS patch
$(IPS_PATCH): $(CLEAN_ROM) $(PATCHED_ROM)
	@mkdir -p $(PATCHES_DIR)
	@echo "Creating IPS patch..."
	@$(FLIPS) --create --ips $(CLEAN_ROM) $(PATCHED_ROM) $(IPS_PATCH)

#-------------------------------------------------------------
# Archive build
.PHONY: archive
archive: $(PATCHED_ROM)
	@mkdir -p $(ARCHIVE_DIR)
	@ts=$$(date +%Y%m%d-%H%M%S); \
	cp $(PATCHED_ROM) $(ARCHIVE_DIR)/$(FILE_BASE)-$$ts.sfc; \
	echo "Archived build as $(ARCHIVE_DIR)/$(FILE_BASE)-$$ts.sfc"

#-------------------------------------------------------------
# Cleanup
.PHONY: clean
clean:
	rm -f $(PATCHED_ROM) $(IPS_PATCH)
