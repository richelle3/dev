#!/usr/bin/env sh

# Этот скрипт используется для добавления плагинов в конфигурацию Neovim.

# 1. Удалить папку с плагинами, если она существует
if [ -d "$HOME/.config/nvim/plugins" ]; then
  rm -rf "$HOME/.config/nvim/plugins"
  echo "Удалена старая папка плагинов."
fi

# 2. Переместить новые плагины из ./nvim/plugins (в текущем репозитории) в ~/.config/nvim/plugins
cp -r ./src/plugins "$HOME/.config/nvim/plugins"
echo "[ Ok ] Плагины успешно добавлены в конфигурацию Neovim."

