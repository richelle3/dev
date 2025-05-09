vim.keymap.set("n", "<leader>e", ":" )
vim.keymap.set("n", "<leader>w", ":set wrap<CR>" )
vim.keymap.set("n", "<leader>nw", ":set nowrap<CR>" )

-- Копировать выделенное в буфер +
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank selection to system clipboard" })

-- Копировать весь файл в буфер +
vim.keymap.set("n", "<leader>yA", 'gg"+yG', { desc = "Yank all to system clipboard" })

-- Удалить все
vim.keymap.set("n", "<leader>0", 'gg"_dG', { desc = "Clear file (delete all lines)" })

vim.keymap.set("n", "<leader>pA", function()
  local clip = vim.fn.system('termux-clipboard-get')
  vim.fn.setreg('+', clip)
  vim.cmd('normal! "+p')
end, { desc = "Paste from Termux clipboard" })

