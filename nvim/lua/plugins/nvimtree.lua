return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  keys = {
    { "<C-n>", ":NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
  },
  init = function()
    -- Disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  config = function()
    require("nvim-tree").setup {
      renderer = {
        icons = {
          webdev_colors = false,
          git_placement = "before",
          modified_placement = "after",
          padding = " ",
          glyphs = {
            default = "F",
            symlink = "<>",
            folder = {
              arrow_closed = "+",
              arrow_open = "-",
              default = "D",
              open = "D",
              empty = "E",
              empty_open = "E",
              symlink = "<>",
            },
            git = {
              unstaged = "m",
              staged = "M",
              unmerged = "U",
              renamed = "R",
              untracked = "?",
              deleted = "D",
              ignored = "I",
            },
          },
        },
      },
      git = {
        ignore = true,
      },
    }
  end,
}
