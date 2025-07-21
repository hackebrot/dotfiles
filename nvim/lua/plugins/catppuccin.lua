return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,    -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        require("catppuccin").setup({
            color_overrides = {
                frappe = {
                    base = "#3a3a3a",
                    mantle = "#3a3a3a",
                    text = "#d2d2d2",
                    lavender = "#c6c6c6",
                },
            },
            custom_highlights = {
                LineNr = { fg = "#7c7c7c" },
            },
        })
        vim.cmd("colorscheme catppuccin-frappe")
    end,
}
