#!/usr/bin/env bash
# install.sh - bashtidy installer
# Usage: curl -fsSL https://raw.githubusercontent.com/bashtidy/bashtidy/main/install.sh | bash

set -e

SCRIPT_URL="https://raw.githubusercontent.com/bashtidy/bashtidy/main/bashtidy.sh"
INSTALL_PATH="/etc/bashtidy.sh"
BASHRC="$HOME/.bashrc"
SOURCE_LINE="source ${INSTALL_PATH}"

echo "→ Downloading bashtidy.sh ..."
curl -fsSL "$SCRIPT_URL" -o "$INSTALL_PATH"
chmod 644 "$INSTALL_PATH"

echo "→ Writing to ${BASHRC} ..."
if grep -qF "$SOURCE_LINE" "$BASHRC" 2>/dev/null; then
    echo "  Already exists, skipping"
else
    echo "" >> "$BASHRC"
    echo "# bashtidy" >> "$BASHRC"
    echo "$SOURCE_LINE" >> "$BASHRC"
fi

echo "→ Reloading shell ..."
# shellcheck disable=SC1090
source "$BASHRC"

echo "✓ bashtidy installed successfully"