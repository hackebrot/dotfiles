vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
})

-- Filetype detection for Go templates so gopls attaches
vim.filetype.add({
    extension = { tmpl = "gotmpl", gotmpl = "gotmpl" },
})

-- Language servers (install via: brew install gopls pyright)
vim.lsp.config("gopls", {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.mod", "go.work", ".git" },
    settings = {
        gopls = {
            usePlaceholders = true,
        },
    },
})

vim.lsp.config("pyright", {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
})

vim.lsp.enable({ "gopls", "pyright" })

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local function opts(desc) return { buffer = ev.buf, desc = desc } end
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        -- Native insert-mode completion (Neovim 0.11+)
        if client and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to Definition"))
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts("Signature Help"))

        local fzf = require("fzf-lua")
        vim.keymap.set("n", "<leader>li", fzf.lsp_implementations, opts("Implementations"))
        vim.keymap.set("n", "<leader>lr", fzf.lsp_references, opts("References"))
        vim.keymap.set("n", "<leader>ls", fzf.lsp_document_symbols, opts("Document Symbols"))
        vim.keymap.set("n", "<leader>ld", fzf.lsp_definitions, opts("Definitions"))
        vim.keymap.set("n", "<leader>lt", fzf.lsp_typedefs, opts("Type Definitions"))
    end,
})
