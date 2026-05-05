#!/usr/bin/env bash
set -euo pipefail

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------
readonly TIME=$(date +'%T %a %d/%b/%Y')
readonly FILE_BASE="Super-Metroid-Redux"
readonly OUT_FOLDER="out"
readonly PATCHES_FOLDER="patches"
readonly CLEAN_ROM_SRC="rom/Super Metroid (Japan, USA) (En,Ja).sfc"
readonly CLEAN_ROM="rom/SuperMetroid.sfc"
readonly PATCHED_ROM="$OUT_FOLDER/$FILE_BASE.sfc"
readonly ASM_FILE="code/main.asm"
readonly CHECKSUM="da957f0d63d14cb441d215462904c4fa8519c613"

# ---------------------------------------------------------------------------
# OS detection
# ---------------------------------------------------------------------------
case "$(uname -s)" in
    Linux*)
        readonly ASAR="bin/asar-linux/asar-standalone"
        readonly FLIPS="bin/flips" ;;
    MINGW*|MSYS*|CYGWIN*)
        readonly ASAR="bin/asar-win/asar-standalone.exe"
        readonly FLIPS="bin/flips.exe" ;;
    *)  echo >&2 "Unsupported OS: $(uname -s)"; exit 1 ;;
esac

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
die() {
    echo >&2
    echo >&2 "Redux compilation exited with errors!"
    echo >&2 "ERROR: $1"
    cleanup
    exit 1
}

cleanup() {
    [[ -f "$CLEAN_ROM" ]] && rm -f "$CLEAN_ROM"
}

reset_asm_flags() {
    sed -i 's/!newgfx = 0/!newgfx = 1/g' "$ASM_FILE"
}

help() {
    cat <<EOF
Compile 'Super Metroid Redux' with one of the following arguments:

Syntax: make.sh [option]
Options:
  -h, --help      Prints this menu.
  -r, --redux     Compiles Redux.
EOF
}

# ---------------------------------------------------------------------------
# Core build
# ---------------------------------------------------------------------------
start() {
    [[ -f "$CLEAN_ROM_SRC" ]] \
        || die "Incorrect ROM name. Rename to '$(basename "$CLEAN_ROM_SRC")' to begin."

    cp "$CLEAN_ROM_SRC" "$CLEAN_ROM"
    mkdir -p "$OUT_FOLDER"
    rm -f "$PATCHED_ROM"

    echo; echo "Verifying SHA-1 checksum..."
    local sha1
    sha1=$(sha1sum "$CLEAN_ROM" | awk '{print $1}')
    [[ "$sha1" == "$CHECKSUM" ]] \
        || die "Base ROM checksum is incorrect. Use a ROM with the proper SHA-1 hash."
    echo "SHA-1 checksum verified."

    cp "$CLEAN_ROM" "$PATCHED_ROM"
    echo; echo "Compiling assembly with Asar..."
    "$ASAR" "$ASM_FILE" "$PATCHED_ROM"
    echo "Assembly compilation succeeded!"

    echo; echo "Creating 'Super Metroid Redux.ips' patch..."
    "$FLIPS" --create --ips "$CLEAN_ROM" "$PATCHED_ROM" "$PATCHES_FOLDER/Super Metroid Redux.ips"

    echo; echo "Redux compilation finished at $TIME!"
    cleanup
}

# ---------------------------------------------------------------------------
# Argument parsing
# ---------------------------------------------------------------------------
(( $# )) || { help; exit 0; }

reset_asm_flags

while (( $# )); do
    case "$1" in
        -h|--help)
            help; exit 0 ;;
        -r|--redux)
            start ;;
        *)
            echo "Error: Invalid option '$1'"
            help; exit 1 ;;
    esac
    shift
done