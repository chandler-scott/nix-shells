#!/bin/bash

# Get the directory of the install.sh script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="/usr/share/nix-shells"
BASHRC_FILE="$HOME/.bashrc"

# Create the target directory if it doesn't exist
if [ ! -d "$TARGET_DIR" ]; then
    sudo mkdir -p "$TARGET_DIR"
fi

# Link all .sh files from the scripts directory to /usr/scripts
for script in "$SCRIPT_DIR"/*.sh; do
    if [ -f "$script" ]; then
        sudo ln -sf "$script" "$TARGET_DIR/$(basename $script)"
    fi
done

# Add /usr/scripts to .bashrc if it doesn't already exist
if ! grep -q "$TARGET_DIR" "$BASHRC_FILE"; then
    echo "export PATH=\$PATH:$TARGET_DIR" >> "$BASHRC_FILE"
    echo "$TARGET_DIR added to PATH in .bashrc"
fi

# Reload .bashrc
source "$BASHRC_FILE"

