return {
  'olimorris/onedarkpro.nvim',
  name = 'onedarkpro',
  lazy = false, -- make sure we load this during startup
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('onedarkpro').setup({
      -- ...
    })

    vim.cmd('colorscheme onelight')
  end,
}
