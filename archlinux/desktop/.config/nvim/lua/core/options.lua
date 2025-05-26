-- Basic Neovim configuration --
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- Appearance and UI --
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.colorcolumn = '80' -- Вертикальная линия на 80 символе
vim.opt.signcolumn = 'yes' -- Всегда показывать столбец знаков
vim.opt.cursorline = true -- Подсветка текущей строки

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

-- Keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

