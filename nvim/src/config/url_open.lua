vim.ui.open = function(url)
  vim.fn.jobstart({ "xdg-open", url }, { detach = true })
end
