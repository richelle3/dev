-- Rust Language Server
return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { ".git" },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}
