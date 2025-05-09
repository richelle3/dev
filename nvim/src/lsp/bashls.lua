-- Bash Language Server
return {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash" },
  root_markers = { ".git" },
  settings = {
    bashIde = {
      lint = {
        enabled = true,
        lintOnChange = true,
      },
      format = {
        enabled = true,
        formatOnSave = true,
      },
    },
  },
}
