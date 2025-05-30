require('core').setup({
  checkhealth = true,
  options = true,
  keymaps = true,
  cmds = true,
  lazy_manager = true,
  lsps = true,
})

require('lazy').setup({
  import = 'kickstart',
})
