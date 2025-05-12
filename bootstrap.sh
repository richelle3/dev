#!/usr/bin/env sh

# `bootstrap.sh` — скрипт для начальной настройки и установки зависимостей, позволяющий быстро развернуть проект с нуля.
# Скрипт предназначен для Termux
# Author: @skriptux

# Получаем путь к директории, где находится сам скрипт
SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"

# Подключаем модули
# . "$SCRIPT_DIR/bashrc/install.sh"
# . "$SCRIPT_DIR/termux/install.sh"
. "$SCRIPT_DIR/zshrc/install.sh"
. "$SCRIPT_DIR/tmux/install.sh"
. "$SCRIPT_DIR/nvim/install.sh"

