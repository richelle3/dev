return {
  "rose-pine/neovim",
  name = "rose-pine",
  priority = 1000, -- загружается раньше остальных
  config = function()
    require("rose-pine").setup({
      disable_background = true, -- прозрачный фон
      disable_float_background = true, -- прозрачный фон для всплывающих окон
      disable_italics = false, -- по желанию
    })
    vim.cmd("colorscheme rose-pine")
  end,
}
