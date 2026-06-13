vim.pack.add({
    { src = "https://github.com/catppuccin/nvim",                       name = "catppuccin" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter",       version = "main" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
})

-- Colorscheme
require("catppuccin").setup({
    color_overrides = {
        frappe = {
            base = "#3a3a3a",
            mantle = "#3a3a3a",
            text = "#d2d2d2",
            lavender = "#c6c6c6",
        },
    },
    custom_highlights = { LineNr = { fg = "#7c7c7c" } },
})
vim.cmd("colorscheme catppuccin-frappe")

-- Treesitter (parsers installed via nvim-treesitter main branch; highlighting via core)
local ts_parsers = { "go", "python", "lua", "markdown", "markdown_inline" }
local ts_filetypes = { "go", "python", "lua", "markdown" }
require("nvim-treesitter").install(ts_parsers)
vim.api.nvim_create_autocmd("FileType", {
    pattern = ts_filetypes,
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

-- fzf-lua
local fzf = require("fzf-lua")
fzf.setup({})
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fd", fzf.diagnostics_document, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>fs", fzf.grep_cword, { desc = "Grep word under cursor" })
