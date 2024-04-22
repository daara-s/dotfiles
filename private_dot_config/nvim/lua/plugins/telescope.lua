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

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[f]ind [f]iles' })
        vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[f]ind [g]it files' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[s]earch [g]rep' })
        -- This is your opts table
        telescope.setup {
            defaults = {
                path_display = {
                    shorten = {
                        len = 1,
                        exclude = { 1, -1, -2 }
                    },
                },
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
