return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-live-grep-args.nvim',
            version = "^1.0.0",
        },
    },
    config = function()
        local builtin = require('telescope.builtin')
        local telescope = require('telescope')

        -- Access the live_grep_args functions
        local lga_actions = require('telescope-live-grep-args.actions')
        local lga_shortcuts = require('telescope-live-grep-args.shortcuts')

        -- First setup telescope (as recommended in the docs)
        telescope.setup({
            extensions = {
                live_grep_args = {
                    auto_quoting = true, -- Enable auto-quoting
                    mappings = {
                        i = {
                            ["<C-k>"] = lga_actions.quote_prompt(),
                            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                            ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t" }),
                        },
                    },
                }
            }
        })

        -- Then load the extension (after setup)
        telescope.load_extension('live_grep_args')

        -- Core telescope mappings
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope diagnostics' })
        vim.keymap.set('n', '<leader>fD', function()
            builtin.diagnostics({ bufnr = 0 })
        end, { desc = 'Telescope diagnostics (current buffer)' })

        -- Live grep args extension mappings
        vim.keymap.set('n', '<leader>fg', telescope.extensions.live_grep_args.live_grep_args,
            { desc = 'Telescope live grep (with args)' })
        vim.keymap.set('n', '<leader>fs', lga_shortcuts.grep_word_under_cursor,
            { desc = 'Telescope grep word under cursor' })
    end,
}
