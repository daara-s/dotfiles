return {
    "nvim-neotest/neotest",
    event = 'VeryLazy',
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        'nvim-neotest/neotest-python',
        "nvim-treesitter/nvim-treesitter"
    },
    config = function()
        local neotest = require 'neotest'
        neotest.setup {
            log_level = 1, -- For verbose logs
            adapters = {
                require 'neotest-python' {
                    dap = { justMyCode = false },
                },
            },
        }
        vim.keymap.set('n', '<leader>tr', function()
            neotest.run.run()
        end, { desc = '[T]est [R]un' })
        vim.keymap.set('n', '<leader>ta', function()
            neotest.run.run(vim.fn.expand("%"))
        end, { desc = '[T]est [A]ll' })
        vim.keymap.set('n', '<leader>td', function()
            neotest.run.run { strategy = 'dap' }
        end, { desc = '[T]est [D]ebug' })
        vim.keymap.set('n', '<leader>ts', function()
            neotest.summary.toggle()
        end, { desc = '[T]est [S]ummary' })
        vim.keymap.set('n', '<leader>to', function()
            neotest.output.open()
        end, { desc = '[T]est [O]utput' })
        vim.keymap.set('n', '<leader>tp', function()
            neotest.output_panel.toggle()
        end, { desc = '[T]est [P]anel' })
    end,
}
