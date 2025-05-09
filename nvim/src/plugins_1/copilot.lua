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
        suggestion = {
          enabled = true,
          auto_trigger = true, -- Автоматически предлагать код
          keymap = {
            accept = "<Tab>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = { enabled = true },
      })
    end,
  },
}

-- Что такое "<M-]>"?
--
-- <M-]> означает "Meta + ]", где Meta обычно соответствует клавише Alt на большинстве клавиатур.
-- -- То есть, когда вы нажимаете Alt и клавишу ] одновременно, это будет считаться нажатием сочетания <M-]>.

