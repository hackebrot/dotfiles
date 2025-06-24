-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = { { import = "plugins" } },

  -- Disable LuaRocks integration since we're not using any rock packages.
  rocks = { enabled = false },

  install = { colorscheme = { "quiet" } },

  -- Automatically check for plugin updates
  checker = { enabled = true },

  -- Don't require a Nerd Font for icon display
  ui = {
    icons = {
      cmd = "[CMD]",
      config = "[CONFIG]",
      event = "[EVENT]",
      ft = "[FT]",
      init = "[INIT]",
      keys = "[KEYS]",
      plugin = "[PLUGIN]",
      runtime = "[RUNTIME]",
      source = "[SRC]",
      start = "[START]",
      task = "[TASK]",
      lazy = "[LAZY]",
    },
  },
})
