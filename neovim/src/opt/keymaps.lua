-- System clipboard yank/paste
vim.keymap.set({"n", "v"}, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>yf", 'gg"+yG', { desc = "Yank entire file to clipboard" })
vim.keymap.set({"n", "v"}, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({"n", "v"}, "<leader>P", '"+P', { desc = "Paste from system clipboard before cursor" })

-- Termux-specific clipboard
vim.keymap.set({"n", "v"}, "<leader>pt", function()
    local clip = vim.fn.system('termux-clipboard-get 2>/dev/null')
    if vim.v.shell_error == 0 then
        vim.fn.setreg('+', clip)
        vim.cmd('normal! "+p')
    else
        vim.notify("Failed to get Termux clipboard", vim.log.levels.WARN)
    end
end, { desc = "Paste from Termux clipboard" })

-- File operations
vim.keymap.set("n", "<leader>0", 'gg"_dG', { desc = "Clear file (delete all lines)" })

-- Text wrapping
vim.keymap.set("n", "<leader>w", ":set wrap<CR>", { desc = "Enable line wrapping" })
vim.keymap.set("n", "<leader>nw", ":set nowrap<CR>", { desc = "Disable line wrapping" })

-- Command mode shortcut
vim.keymap.set("n", "<leader>e", ":", { desc = "Enter command mode" })

-- Delete without yanking
vim.keymap.set({"n", "v"}, "<leader>d", '"_d', { desc = "Delete without yanking" })

vim.keymap.set("n", "<leader>tv", function()
  vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle line wrapping" })
