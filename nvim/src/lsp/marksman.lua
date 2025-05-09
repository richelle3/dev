-- Markdown Language Server
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#marksman
return {
  cmd = { "marksman", "server" },
  filetypes = { "markdown", "markdown.mdx" },
  root_markers = { ".marksman.toml", ".git", ".gitignore" },
}
