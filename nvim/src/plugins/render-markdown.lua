return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.nvim',
  },
  opts = {},
  config = function(_, opts)
    require('render-markdown').setup(opts)
  end,
}

