-- Diagnostic configuration
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
})


-- Set up LSP keymaps when any LSP attaches
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local function opts(desc)
            return { buffer = ev.buf, desc = desc }
        end

        -- LSP keymaps
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to Definition"))
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go to Implementation"))
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("Go to References"))
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover Info"))
        vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, opts("Signature Help"))

        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename Symbol"))
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code Action"))
        vim.keymap.set({ "n" }, "<leader>fmt", function()
            vim.lsp.buf.format { async = true }
        end, opts("Format Code"))

        -- Telescope LSP integrations
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>li", builtin.lsp_implementations, opts("Telescope: Implementations"))
        vim.keymap.set("n", "<leader>lr", builtin.lsp_references, opts("Telescope: References"))
        vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, opts("Telescope: Document Symbols"))
        -- The following Telescope functions rely on deprecated APIs in neovim
        -- vim.lsp.util.jump_to_location: See https://github.com/nvim-telescope/telescope.nvim/issues/3469
        vim.keymap.set("n", "<leader>ld", builtin.lsp_definitions, opts("Telescope: Definitions"))
        vim.keymap.set("n", "<leader>lt", builtin.lsp_type_definitions, opts("Telescope: Type Definitions"))
    end,
})

return {
    -- mason.nvim: Package manager for LSP servers, linters, and formatters.
    -- Provides a UI for browsing and installing language tools.
    {
        "mason-org/mason.nvim",
        opts = {},
    },

    -- nvim-lspconfig: Core plugin for Neovim's built-in LSP client.
    -- Provides configurations for language servers and handles server communication.
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
    },

    -- mason-lspconfig.nvim: Bridge between Mason and LSP configuration.
    -- Automatically connects Mason-installed language servers with lspconfig.
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "mason-org/mason.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        opts = {
            ensure_installed = {
                "gopls",   -- https://pkg.go.dev/golang.org/x/tools/gopls
                "pyright", -- https://github.com/microsoft/pyright
                -- "lua_ls",  -- https://github.com/LuaLS/lua-language-server
            },
            handlers = {
                function(server_name)
                    -- Setup the server with enhanced capabilities
                    require("lspconfig")[server_name].setup({
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    })
                end
            }
        }
    },

    -- nvim-cmp: Completion engine for Neovim.
    -- Provides the popup menu for code completion and integrates with LSP servers.
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- Adapter for LSP completion sources
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        -- Use Neovim's native snippet support (v0.10+)
                        if vim.snippet and vim.snippet.expand then
                            vim.snippet.expand(args.body)
                        end
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                }),
                formatting = {
                    format = function(entry, vim_item)
                        -- Show source name in the menu
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                        })[entry.source.name]

                        -- Show where snippet comes from by examining entry
                        if entry.source.name == "nvim_lsp" then
                            local client_name = entry.source.source.client.name or "unknown lsp"
                            vim_item.menu = "[" .. client_name .. "]"
                        end

                        return vim_item
                    end
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                }),
            })
        end,
    },
}
