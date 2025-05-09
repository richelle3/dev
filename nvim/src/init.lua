--[[ The Base Config ]]--
require 'simple'
require 'lazynvim'
require 'lsp'

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 2
vim.g.netrw_browse_split = 0
vim.g.netrw_list_hide = ''

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd("Explore")
    end
  end,
})

