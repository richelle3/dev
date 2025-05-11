#!/usr/bin/env sh

# Этот скрипт используется для добавления плагинов в конфигурацию Neovim.

TARGET="$HOME/.config/nvim/lsp"
SOURCE="./src/lsp"

# 1. Удалить папку с lsp, если она существует
if [ -d "$TARGET" ]; then
  rm -rf "$TARGET"
  echo "[ Ok ] Удалена старая папка lsp."
fi

# 2. Проверить, существует ли исходная папка
if [ ! -d "$SOURCE" ]; then
  echo "[ !! ] Папка $SOURCE не найдена."
  exit 1
fi

# 3. Копировать новые плагины
cp -r "$SOURCE" "$TARGET"
echo "[ Ok ] Lsp успешно добавлены в конфигурацию Neovim."

