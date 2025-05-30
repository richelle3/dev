-- Core Neovim configuration module
-- https://neovim.io/doc/user/lsp.html
local M = {}

function M.setup(opts)

  opts = opts or {}

  if opts.checkhealth then
    require('core.checkhealth')
  end

  if opts.options then
    require('core.options')
  end

  if opts.cmds then
    require('core.cmds')
  end

  if opts.keymaps then
    require('core.keymaps')
  end

  if opts.lazy_manager then
    require('core.lazy_manager')
  end

  if opts.lsps then
    require('core.lsps')
  end

end

return M
