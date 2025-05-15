```lua
config = function()
-- Проверка наличия fzf и установка, если его нет
    if vim.fn.executable("fzf") == 0 then
        vim.fn.system({ "apt", "install", "-y", "fzf" })
    end
end,
```
