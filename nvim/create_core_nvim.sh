#!/usr/bin/env sh

# Название скрипта: create_core_nvim.sh
# Автор: skriptux

echo "[ * ] Старт конфигурации"

conf_dir="$HOME/.config/nvim"
share_dir="$HOME/.local/share/nvim"

# Create necessary directories
mkdir -p "$conf_dir/lua/core"
mkdir -p "$share_dir"

# Create necessary files
touch $conf_dir/.marksman.toml
touch $conf_dir/.luacheck

# Create basic init.lua file
cat > "$conf_dir/init.lua" << 'EOF'
-- Basic Neovim configuration
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- 
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Цвета терминала и отступы
vim.opt.termguicolors = true
vim.opt.scrolloff = 3

-- Статус и визуальные элементы
vim.opt.showmode = false -- Не показывать режим внизу

-- Перенос строк и визуальное отображение
vim.opt.wrap = true -- Не переносить строки
vim.opt.linebreak = true -- Переносить строки по словам
vim.opt.breakindent = true -- Сохранять отступ при переносе
vim.opt.breakindentopt = 'shift:2' -- Настройка отступа для переноса
vim.opt.showbreak = '↪ ' -- Символ для переноса строки
vim.opt.fillchars:append({ eob = ' ' }) -- Убрать тильду в конце файла

-- Отображение скрытых символов
vim.opt.list = true
vim.opt.listchars = {
  tab = '▸ ',
  trail = '·',
  extends = '>',
  precedes = '<',
  nbsp = '␣',
}

require('core').setup({
  use_termux_open = true,
  lazy_manager = true,
})

require('lazy').setup({
  import = 'plugins',
})

-- Подключение LSP
vim.lsp.enable("luals")
vim.lsp.enable("bashls")
vim.lsp.enable("marksman")
vim.lsp.enable("pyright")
vim.lsp.enable("rust_analyzer")
EOF

# Create core module
cat > "$conf_dir/lua/core/init.lua" << 'EOF'
-- Core Neovim configuration module
-- https://neovim.io/doc/user/lsp.html

local M = {}

function M.setup(opts)
  opts = opts or {}

  -- Использовать termux-open (например, для Android/Termux)
  if opts.use_termux_open then
    vim.ui.open = function(url)
      vim.fn.jobstart({ "termux-open", url }, { detach = true })
    end
  else
    vim.ui.open = function(url)
      vim.fn.jobstart({ "xdg-open", url }, { detach = true })
    end
  end

  -- Настройка автокоманд
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('core-highlight-yank', { clear = true }),
    callback = function()
      vim.highlight.on_yank()
    end,
  })

  -- Ленивая инициализация менеджера плагинов
  if opts.lazy_manager then
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
      vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
      })
    end
    vim.opt.rtp:prepend(lazypath)
  end
end

return M
EOF

echo "[ Ok ] Basic Neovim core configuration created"
