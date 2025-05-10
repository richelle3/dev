-- Copilot
-- https://github.com/zbirenbaum/copilot.lua
return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      -- Проверка наличия node и установка, если его нет
      if vim.fn.executable("node") == 0 then
        vim.fn.system({ "apt", "install", "-y", "nodejs" })
      end

      require("copilot").setup({
        filetypes = {
          ["*"] = true, -- Включить для всех файлов          markdown = true, -- Явно включить для markdown
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<TAB>",
            next = "<C-j>",
            prev = "<C-k>",
            dismiss = "<C-h>",
          }

        },
        panel = { enabled = true },
      })
    end,
  },
}

