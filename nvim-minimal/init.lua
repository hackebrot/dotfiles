if vim.fn.has("nvim-0.12") == 0 then
    error("nvim-minimal requires Neovim 0.12+ (vim.pack, vim.lsp.config)")
end

require("options")
require("plugins")
require("lsp")
