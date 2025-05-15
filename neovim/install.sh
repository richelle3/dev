#!/usr/bin/env sh

#########################
## Конфигурация Neovim ##
##  -- for Termux --   ##
#########################

# Получаем абсолютный путь к директории, где лежит сам скрипт
SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"

# Подключаем скрипты, независимо от текущей директории
. "$SCRIPT_DIR/shell/create_core_nvim.sh"
. "$SCRIPT_DIR/shell/add_plugins.sh"
. "$SCRIPT_DIR/shell/add_lsp.sh"

