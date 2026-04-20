return {
    -- nvim-dap: Debug Adapter Protocol client for Neovim.
    -- Provides breakpoints, stepping, variable inspection, and REPL.
    {
        "mfussenegger/nvim-dap",
        keys = {
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
            { "<leader>dB", function()
                require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, desc = "Conditional Breakpoint" },
            { "<leader>dl", function()
                require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
            end, desc = "Log Point" },
            { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
            { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
            { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
            { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
            { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
            { "<leader>dR", function() require("dap").restart() end, desc = "Restart" },
            { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
            { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
        },
        config = function()
            -- Use simple ASCII signs for breakpoints
            vim.fn.sign_define("DapBreakpoint", { text = "B>", texthl = "DiagnosticError" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "C>", texthl = "DiagnosticWarn" })
            vim.fn.sign_define("DapLogPoint", { text = "L>", texthl = "DiagnosticInfo" })
            vim.fn.sign_define("DapStopped", { text = "->", texthl = "DiagnosticOk", linehl = "DapStoppedLine" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "X>", texthl = "DiagnosticError" })
        end,
    },

    -- nvim-dap-ui: UI widgets for nvim-dap.
    -- Provides panels for variables, watches, stacks, breakpoints, and console.
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        keys = {
            { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle Debug UI" },
            { "<leader>de", function() require("dapui").eval() end, desc = "Eval Expression", mode = { "n", "v" } },
            { "<leader>dw", function() require("dapui").elements.watches.add(vim.fn.input("Watch expression: ")) end, desc = "Add Watch" },
        },
        opts = {
            icons = {
                expanded = "-",
                collapsed = "+",
                current_frame = ">",
            },
            controls = {
                icons = {
                    pause = "||",
                    play = "|>",
                    step_into = "v>",
                    step_over = ">>",
                    step_out = "<^",
                    step_back = "<<",
                    run_last = "@>",
                    terminate = "XX",
                    disconnect = "<>",
                },
            },
        },
        config = function(_, opts)
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup(opts)

            -- Automatically open/close UI when debugging starts/stops
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    },

    -- nvim-dap-go: Go/Delve debug adapter configuration for nvim-dap.
    -- Automatically configures Delve for debugging Go programs and tests.
    {
        "leoluz/nvim-dap-go",
        dependencies = { "mfussenegger/nvim-dap" },
        ft = "go",
        keys = {
            { "<leader>dgt", function() require("dap-go").debug_test() end, desc = "Debug Go Test", ft = "go" },
            { "<leader>dgT", function() require("dap-go").debug_last_test() end, desc = "Debug Last Go Test", ft = "go" },
        },
        opts = {},
    },}
