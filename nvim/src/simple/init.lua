-- Base --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Цвета терминала и отступы
vim.opt.termguicolors = true -- Включаем true color
vim.opt.scrolloff = 3        -- Отступ от краёв экрана при прокрутке

-- Перенос строк и визуальное отображение
vim.opt.wrap = false -- Не переносить строки
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

-- Статус и визуальные элементы
vim.opt.showmode = false -- Не показывать режим внизу

vim.opt.showcmd = false
vim.opt.ruler = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.signcolumn = 'yes'
vim.opt.number = true
vim.opt.relativenumber = true

-- Поиск
vim.opt.wrapscan = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Файлы

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.cmd 'colorscheme wildcharm'

-- UI Open --

vim.ui.open = function(url)
  vim.fn.jobstart({ "xdg-open", url }, { detach = true })
end

-- Yank --

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Keymaps --
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set("n", "<leader>e", ":wqa" )
vim.keymap.set("n", "<leader>w", ":set wrap<CR>" )
vim.keymap.set("n", "<leader>nw", ":set nowrap<CR>" )

-- Копировать выделенное в буфер +
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank selection to system clipboard" })

-- Копировать весь файл в буфер +
vim.keymap.set("n", "<leader>ya", 'gg"+yG', { desc = "Yank all to system clipboard" })

-- Удалить все
vim.keymap.set("n", "<leader>0", 'gg"_dG', { desc = "Clear file (delete all lines)" })

vim.keymap.set("n", "<leader>pa", function()
  local clip = vim.fn.system('termux-clipboard-get')
  vim.fn.setreg('+', clip)
  vim.cmd('normal! "+p')
end, { desc = "Paste from Termux clipboard" })
