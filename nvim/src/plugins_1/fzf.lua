return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    winopts = {
      height = 0.85,
      width  = 0.80,
      row    = 0.3,
      col    = 0.5,
      border = 'rounded',
    },
  },
  config = function()
    -- Проверка наличия fzf и установка, если его нет
    if vim.fn.executable("fzf") == 0 then
      vim.fn.system({ "apt", "install", "-y", "fzf" })
    end
  end,
  keys = {
    { "<leader>ff", function() require("fzf-lua").files() end,     desc = "Find Files (fzf)" },
    { "<leader>fg", function() require("fzf-lua").live_grep() end, desc = "Live Grep (fzf)" },
    { "<leader>fb", function() require("fzf-lua").buffers() end,   desc = "Find Buffers (fzf)" },
    { "<leader>fh", function() require("fzf-lua").help_tags() end, desc = "Help Tags (fzf)" },
  },
}

