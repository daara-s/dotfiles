return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-ui-select.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    keys = {
        { '<leader>ff', function() require('telescope.builtin').find_files() end,                                       desc = 'Files' },
        { '<leader>fg', function() require('telescope.builtin').git_files() end,                                        desc = 'Git files' },
        { '<leader>fc', function() require('telescope.builtin').live_grep() end,                                        desc = 'Code' },
        { '<leader>fs', function() require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") }) end,  desc = 'Search' },
        { '<leader>fw', function() require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>") }) end, desc = 'Word' },
        { '<leader>fW', function() require('telescope.builtin').grep_string({ search = vim.fn.expand("<cWORD>") }) end, desc = 'Whole word' },
    },
    config = function()
        local telescope = require("telescope")
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
