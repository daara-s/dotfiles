return {
    {
        'mfussenegger/nvim-dap',
        dependencies = { 'mfussenegger/nvim-dap-python' },
        config = function()
            local dap = require 'dap'
            local python_path = os.getenv("VIRTUAL_ENV") and os.getenv("VIRTUAL_ENV") .. "/bin/python" or "python"

            dap.adapters.python = {
                type = 'executable',
                command = python_path,
                args = { '-m', 'debugpy.adapter' },
            }
            dap.configurations.python = {
                {
                    type = 'python',
                    request = 'launch',
                    name = "Launch file",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                    pythonPath = python_path,
                    env = { "ENABLE_RAW_INFERENCE=1", "NUMBA_DISABLE_JIT=1" },
                },
            }
            -- pneumonic debug continue
            vim.keymap.set('n', '<leader>ds', dap.step_over, { desc = '[D]ebug [S]tep' })
            -- pneumonic debug into
            vim.keymap.set('n', '<leader>di', dap.step_into, { desc = '[D]ebug [I]nto' })
            -- pneumonic debug over
            vim.keymap.set('n', '<leader>do', dap.step_out, { desc = '[D]ebug [O]ut' })
            -- pneumonic debug continue
            vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[D]ebug [C]ontinue' })
            -- pneumonic b - break
            vim.keymap.set('n', '<Leader>db', dap.toggle_breakpoint, { desc = '[D]ebug [B]reakpoint' })
            -- pneumoic dr - dap REPL
            vim.keymap.set('n', '<Leader>dr', dap.repl.open, { desc = '[D]ebug [R]EPL' })
            -- pneumoic dl - dap run last
            vim.keymap.set('n', '<Leader>dl', dap.run_last, { desc = '[D]ebug [L]ast' })
        end,
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'nvim-neotest/nvim-nio' },
        config = function()
            local dap, dapui = require 'dap', require 'dapui'
            dapui.setup {
                controls = {
                    -- Requires Neovim nightly (or 0.8 when released)
                    enabled = true,
                    -- Display controls in this element
                    element = 'repl',
                    icons = {
                        pause = '',
                        play = '',
                        step_into = '',
                        step_over = '',
                        step_out = '',
                        step_back = '',
                        run_last = '↻',
                        terminate = '',
                    },
                },
                layouts = {
                    {
                        elements = {
                            { id = "repl",   size = 0.5 },
                            { id = "scopes", size = 0.5 },
                        },
                        position = "bottom",
                        size = 10
                    },
                    {
                        elements = {
                            { id = "stacks",      size = 0.25 },
                            { id = "breakpoints", size = 0.25 },
                            { id = "console",     size = 0.25 },
                            { id = "watches",     size = 0.25 },

                        },
                        position = "left",
                        size = 40
                    }
                },
            }

            dap.listeners.after.event_initialized['dapui_config'] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated['dapui_config'] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited['dapui_config'] = function()
                dapui.close()
            end
            vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = 'red', linehl = '', numhl = '' })
            vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
        end,
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        config = function()
            require("nvim-dap-virtual-text").setup {
                enabled = true,         -- enable this plugin (the default)
                enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
                highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
                highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
                show_stop_reason = true, -- show stop reason when stopped for exceptions
                commented = false,      -- prefix virtual text with comment string
                only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
                all_references = false, -- show virtual text on all all references of the variable (not only definitions)
                clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
                -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
                virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

                -- experimental features:
                all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
                virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
                virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
                -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
            }
        end,
    },
}
