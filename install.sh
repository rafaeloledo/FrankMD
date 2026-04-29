#!/bin/bash
# FrankMD installer - https://github.com/akitaonrails/FrankMD
set -e

REPO="https://raw.githubusercontent.com/akitaonrails/FrankMD/master"
CONFIG_DIR="$HOME/.config/frankmd"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_FED_DIR="$SCRIPT_DIR/config/fed"

echo "Installing FrankMD..."

# Create config directory
mkdir -p "$CONFIG_DIR"

# Copy from local repo if available, otherwise download from GitHub
if [[ -f "$LOCAL_FED_DIR/fed.sh" && -f "$LOCAL_FED_DIR/fed.fish" ]]; then
  cp "$LOCAL_FED_DIR/fed.sh" "$CONFIG_DIR/fed.sh"
  cp "$LOCAL_FED_DIR/fed.fish" "$CONFIG_DIR/fed.fish"
  cp "$LOCAL_FED_DIR/splash.html" "$CONFIG_DIR/splash.html"
  cp "$LOCAL_FED_DIR/env.example" "$CONFIG_DIR/env.example"
  echo "  Copied config files from local repo to $CONFIG_DIR"
else
  curl -sL "$REPO/config/fed/fed.sh" -o "$CONFIG_DIR/fed.sh"
  curl -sL "$REPO/config/fed/fed.fish" -o "$CONFIG_DIR/fed.fish"
  curl -sL "$REPO/config/fed/splash.html" -o "$CONFIG_DIR/splash.html"
  curl -sL "$REPO/config/fed/env.example" -o "$CONFIG_DIR/env.example"
  echo "  Downloaded config files to $CONFIG_DIR"
fi

echo ""
echo "Done! For bash/zsh, add this line to your ~/.bashrc or ~/.zshrc:"
echo ""
echo "  source $CONFIG_DIR/fed.sh"
echo ""
echo "For fish, add this line to your ~/.config/fish/config.fish:"
echo ""
echo "  source $CONFIG_DIR/fed.fish"
echo ""
echo "Then reload your shell and run:"
echo ""
echo "  fed ~/my-notes"
echo ""
echo "Commands:"
echo "  fed [path]   - Open notes directory"
echo "  fed-update   - Update Docker image"
echo "  fed-stop     - Stop container"
echo ""
echo "To configure API keys, see: $CONFIG_DIR/env.example"
