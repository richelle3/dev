#!/usr/bin/env sh

# This script sets up Zsh and its configuration files.

# Проверка и установка Zsh в Termux
if ! command -v zsh >/dev/null 2>&1; then
  echo '[..] Installing zsh...'
  apt install -y zsh
  echo '[ Ok ] Zsh installed'
fi

echo '[..] Configuring Zsh'

# Получаем путь к директории, в которой лежит сам скрипт
SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"

# Set paths
TARGET="$HOME/.config/zsh"
ZSH_DIR="$SCRIPT_DIR/src/zsh"

# Create target dir and copy files
rm -rf "$TARGET"
mkdir -p "$TARGET"
cp -r "$ZSH_DIR/"* "$TARGET"

# Remove existing config files
rm -f "$HOME/.zshrc" "$HOME/.p10k.zsh"

# Copy new config files
cp "$SCRIPT_DIR/src/.zshrc" "$HOME/.zshrc"
cp "$SCRIPT_DIR/src/.p10k.zsh" "$HOME/.p10k.zsh"

# Add exec zsh to .bashrc if not already present
if ! grep -q 'exec zsh' "$HOME/.bashrc"; then
  echo 'exec zsh' >> "$HOME/.bashrc"
fi

echo '[ Ok ] Zsh installed and configured'

