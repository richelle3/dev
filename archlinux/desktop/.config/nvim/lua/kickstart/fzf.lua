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

  keys = {
  -- Поиск файлов
  { "<C-p>", function() require("fzf-lua").files() end, desc = "Find Files (fzf)" },

  -- Live grep (поиск по содержимому)
  { "<leader>/", function() require("fzf-lua").live_grep() end, desc = "Live Grep (fzf)" },

  -- Открытые буферы
  { "<leader>,", function() require("fzf-lua").buffers() end, desc = "Buffers (fzf)" },

  -- Поиск хелпа
  { "<leader>?", function() require("fzf-lua").help_tags() end, desc = "Help Tags (fzf)" },

  -- Поиск в текущем буфере (через `lines`)
  { "<leader>sb", function() require("fzf-lua").blines() end, desc = "Search Buffer (fzf)" },

  -- Поиск по файлам конфигурации (если есть директория конфигов)
  { "<leader>fc", function()
      require("fzf-lua").files({ cwd = "~/.config/nvim" })
    end,
    desc = "Find Config Files (fzf)"
  },
 },
}
