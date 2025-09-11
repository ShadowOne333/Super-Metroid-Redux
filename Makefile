#-------------------------------------------------------------
#	SUPER METROID REDUX COMPILATION MAKEFILE
#-------------------------------------------------------------
# Paths
OUT_DIR       := out
PATCHES_DIR   := patches
ROM_DIR       := rom
ARCHIVE_DIR   := outarchive
ASM_FILE      := code/main.asm
FILE_BASE     := Super-Metroid-Redux

# Time variables
START := $(shell date +%s)
TIME = `date +'%T, %a %d/%b/%Y'`

# Detect OS for Asar + Flips
ifeq ($(OS),Windows_NT)
    ASAR  := bin/asar-win/asar-standalone.exe
    FLIPS := bin/flips.exe
else
    ASAR  := bin/asar-linux/asar-standalone
    FLIPS := bin/flips
endif

# ROMs
NAME         := 'Super Metroid (Japan, USA) (En,Ja).sfc'
CLEAN_ROM    := '$(ROM_DIR)/Super Metroid (Japan, USA) (En,Ja).sfc'
COPY_ROM     := $(ROM_DIR)/SuperMetroid.sfc
PATCHED_ROM  := $(OUT_DIR)/$(FILE_BASE).sfc
IPS_PATCH    := $(PATCHES_DIR)/$(FILE_BASE).ips
BPS_PATCH    := $(PATCHES_DIR)/$(FILE_BASE).bps

# Checksums
SHA1SUM = `sha1sum $(CLEAN_ROM) | awk '{ print $$1 }'`
CLEAN_CHECKSUM   := da957f0d63d14cb441d215462904c4fa8519c613
#-------------------------------------------------------------
# Default targets
.PHONY: all
all: check_rom check_checksum compile_project create_patches finish
#-------------------------------------------------------------
# Check if the base ROM exists and has the correct name
check_rom:
	@if [ ! -e $(CLEAN_ROM) ]; then \
		echo "ERROR: Base ROM not found."; \
		echo "Please, rename the ROM to ${NAME} to begin the patching process."; \
		exit 1; \
	fi
	@echo "ROM detected. Verifying name..."
#-------------------------------------------------------------
# Copy base ROM into the /out/ folder
	@{ \
		cp $(CLEAN_ROM) $(COPY_ROM); \
		[ ! -d $(OUT_DIR) ] && mkdir $(OUT_DIR); \
		[ -f $(PATCHED_ROM) ] && rm $(PATCHED_ROM) || echo; \
		cp $(COPY_ROM) $(PATCHED_ROM); \
	}
#-------------------------------------------------------------
# Verify SHA-1 checksum
check_checksum:
	@echo "Base ROM detected with proper name."; echo
	@echo "Verifying SHA-1 checksum hash..."
	@if [ "$(SHA1SUM)" != "$(CLEAN_CHECKSUM)" ]; then \
		echo "ERROR: Base ROM checksum is incorrect."; \
		echo "Use a Super Metroid ROM with the proper SHA-1 checksum for patching."; \
		exit 1; \
	fi
	@echo SHA1=$(SHA1SUM)
	@echo "Base ROM SHA-1 checksum verified."; echo
#-------------------------------------------------------------
# Compile the main assembly code
compile_project:
	@echo "Beginning main assembly code compilation with Asar..."; echo
	@$(ASAR) $(ASM_FILE) $(PATCHED_ROM)

	@echo "Main assembly code compilation succeded!"; echo
#-------------------------------------------------------------
# Create both additional BPS and IPS patches files
create_patches:
	@echo
	@echo "Creating both BPS and IPS patches..."
	@$(FLIPS) -c $(CLEAN_ROM) $(PATCHED_ROM) $(BPS_PATCH)
	@$(FLIPS) -c $(CLEAN_ROM) $(PATCHED_ROM) $(IPS_PATCH)
	@echo; echo "BPS & IPS patches created successfully!"; echo
#-------------------------------------------------------------
# Finish the process
finish:
	@echo "Final compilation time: $$(( `date +%s` - $(START) )) seconds"
	@echo "Redux compilation finished at $(TIME)!"
#-------------------------------------------------------------
.PHONY: all check_rom check_checksum compile_project create_patches finish
#-------------------------------------------------------------
# Archive build
.PHONY: archive
archive: $(PATCHED_ROM)
	@mkdir -p $(ARCHIVE_DIR)
	@ts=$$(date +%Y%m%d-%H%M%S); \
	@cp $(PATCHED_ROM) $(ARCHIVE_DIR)/$(FILE_BASE)-$$ts.sfc; \
	echo "Archived build as $(ARCHIVE_DIR)/$(FILE_BASE)-$$ts.sfc"
#-------------------------------------------------------------
# Cleanup
.PHONY: clean
clean:
	rm -f $(PATCHED_ROM) $(IPS_PATCH)
