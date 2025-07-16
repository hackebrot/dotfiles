local servers = {
    "gopls",   -- https://pkg.go.dev/golang.org/x/tools/gopls
    "pyright", -- https://github.com/microsoft/pyright
}

-- Keymap setup
local on_attach = function(_, bufnr)
    local function opts(desc)
        return { buffer = bufnr, desc = desc }
    end

    -- LSP keymaps
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to Definition"))
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go to Implementation"))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("Go to References"))
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover Info"))
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts("Signature Help"))
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename Symbol"))
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code Action"))
    vim.keymap.set({ "n", "v" }, "<leader>f", function()
        vim.lsp.buf.format { async = true }
    end, opts("Format Code"))

    -- Telescope LSP integrations
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>li", builtin.lsp_implementations, opts("Telescope: Implementations"))
    vim.keymap.set("n", "<leader>lr", builtin.lsp_references, opts("Telescope: References"))
    vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, opts("Telescope: Document Symbols"))
    -- The following functions rely on deprecated APIs in neovim
    -- vim.lsp.util.jump_to_location: See https://github.com/nvim-telescope/telescope.nvim/issues/3469
    vim.keymap.set("n", "<leader>ld", builtin.lsp_definitions, opts("Telescope: Definitions"))
    vim.keymap.set("n", "<leader>lt", builtin.lsp_type_definitions, opts("Telescope: Type Definitions"))
end

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
})

return {
    {
        "mason-org/mason.nvim",
        opts = {},
    },
    {
        "neovim/nvim-lspconfig",
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "mason-org/mason.nvim",
        },
        opts = {
            ensure_installed = servers,
        },
        config = function(_, opts)
            require("mason-lspconfig").setup(opts)

            for _, server in ipairs(servers) do
                vim.lsp.config(server, {
                    on_attach = on_attach,
                })
            end
        end,
    },
}
