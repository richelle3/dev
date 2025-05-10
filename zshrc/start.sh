#!/usr/bin/env sh

echo "[..] Installing Zsh"

# Install Zsh
apt install -y zsh

# Set paths
TARGET="$HOME/.config/zsh"
ZSH_DIR="./src/zsh"

# Create target dir and copy files
rm -rf "$TARGET"
mkdir -p "$TARGET"
cp -r "$ZSH_DIR/"* "$TARGET"

# Remove existing config files
rm -f "$HOME/.zshrc" "$HOME/.p10k.zsh"

# Copy new config files
cp ./src/.zshrc "$HOME/.zshrc"
cp ./src/.p10k.zsh "$HOME/.p10k.zsh"

# Add exec zsh to .bashrc if not already present
if ! grep -q 'exec zsh' "$HOME/.bashrc"; then
    echo 'exec zsh' >> "$HOME/.bashrc"
fi

echo "[ Ok ] Zsh installed and configured"
