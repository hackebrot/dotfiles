return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local parsers = {
            "go", "python", "lua", "json", "yaml",
            "markdown", "markdown_inline",
        }
        local filetypes = {
            "go", "python", "lua", "json", "yaml",
            "markdown",
        }

        require("nvim-treesitter").install(parsers)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = filetypes,
            callback = function(args)
                vim.treesitter.start(args.buf)
                vim.bo[args.buf].indentexpr =
                    "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
