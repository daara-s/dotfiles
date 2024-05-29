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
                        size = 20
                    },
                    {
                        elements = {
                            { id = "stacks",      size = 0.33 },
                            { id = "breakpoints", size = 0.33 },
                            { id = "console",     size = 0.33 },
                        },
                        position = "right",
                        size = 30
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
}
