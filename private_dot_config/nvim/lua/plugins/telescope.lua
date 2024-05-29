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

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
        vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[F]ind [G]it files' })
        vim.keymap.set('n', '<leader>fc', builtin.live_grep, { desc = '[F]ind [C]ode' })
        -- This is your opts table
        telescope.setup {
            defaults = {
                path_display = {
                    shorten = {
                        len = 1,
                        exclude = { 1, -1, -2 }
                    },
                },
                file_ignore_patterns = {"poetry.lock"},
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {
                    }
                },
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            },
        }
        -- To get ui-select loaded and working with telescope, you need to call
        -- load_extension, somewhere after setup function:
        telescope.load_extension("ui-select")
        telescope.load_extension('fzf')
    end
}
