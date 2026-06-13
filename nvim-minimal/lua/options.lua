-- Leader key settings
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- UI and display
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.laststatus = 3
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Write buffer
vim.keymap.set('n', '<leader>w', ':write<CR>', { desc = 'Write buffer' })
vim.keymap.set('n', '<leader>q', ':quit<CR>', { desc = 'Quit window' })
vim.keymap.set('n', '<leader>wq', ':wq<CR>', { desc = 'Write and quit' })

-- Tab navigation
vim.keymap.set('n', '<leader>tn', ':tabnext<CR>', { desc = 'Next tab' })
vim.keymap.set('n', '<leader>tp', ':tabprevious<CR>', { desc = 'Previous tab' })
vim.keymap.set('n', '<leader>tc', ':tabnew<CR>', { desc = 'Create tab' })
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', { desc = 'Close tab' })

-- New keymaps for tab positions
vim.keymap.set('n', '<leader>t1', '1gt', { desc = 'Go to tab 1' })
vim.keymap.set('n', '<leader>t2', '2gt', { desc = 'Go to tab 2' })
vim.keymap.set('n', '<leader>t3', '3gt', { desc = 'Go to tab 3' })
vim.keymap.set('n', '<leader>t4', '4gt', { desc = 'Go to tab 4' })
vim.keymap.set('n', '<leader>t5', '5gt', { desc = 'Go to tab 5' })
vim.keymap.set('n', '<leader>t0', ':tablast<CR>', { desc = 'Go to last tab' })

-- Search behavior
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Indentation and formatting
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.wrap = false

-- Modern file handling
vim.opt.fileformats = "unix,dos"

-- Folding
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- Better buffer handling
vim.opt.autoread = true
vim.opt.updatetime = 100

-- macOS specific
vim.opt.clipboard = ""

-- Improved backups and undo
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true

-- Auto-reload files changed outside Neovim (for Claude Code workflow)
local reload_interval = 1000

local function check_visible_buffers()
    if vim.fn.mode() ~= "n" then return end

    local seen = {}

    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)

        if not seen[buf] then
            seen[buf] = true

            if vim.bo[buf].buftype == "" then
                vim.api.nvim_buf_call(buf, function()
                    vim.cmd("checktime")
                end)
            end
        end
    end
end

vim.fn.timer_start(reload_interval, check_visible_buffers, { ["repeat"] = -1 })

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
    callback = check_visible_buffers,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
    callback = function(args)
        vim.notify("Reloaded: " .. vim.fn.fnamemodify(args.file, ":t"), vim.log.levels.INFO)
    end,
})
