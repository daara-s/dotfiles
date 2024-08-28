return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-ui-select.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        local telescope = require("telescope")
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Files' })
        vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Git files' })
        vim.keymap.set('n', '<leader>fc', builtin.live_grep, { desc = 'Code' })
        vim.keymap.set('n', '<leader>fs',
            function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end,
            { desc = 'Search' }
        )
        vim.keymap.set('n', '<leader>fw',
            function()
                local word = vim.fn.expand("<cword>")
                builtin.grep_string({ search = word })
            end,
            { desc = 'Word' }
        )
        vim.keymap.set('n', '<leader>fW',
            function()
                local word = vim.fn.expand("<cWORD>")
                builtin.grep_string({ search = word })
            end,
            { desc = 'Whole word' }
        )
        --
        -- This is your opts table
        telescope.setup {
            defaults = {
                path_display = {
                    shorten = {
                        len = 1,
                        exclude = { 1, -1, -2 }
                    },
                },
                file_ignore_patterns = { "poetry.lock" },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                ["ui-select"] = {
                    require("telescope.themes").get_cursor {
                        sorting_strategy = "ascending",
                        layout_config = {
                            prompt_position = "top", -- Place the prompt at the top
                        },

                    }
                },
            },
        }
        -- To get ui-select loaded and working with telescope, you need to call
        -- load_extension, somewhere after setup function:
        telescope.load_extension('fzf')
        telescope.load_extension("ui-select")
    end
}
