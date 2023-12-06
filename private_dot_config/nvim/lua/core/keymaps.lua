local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc='Find files'})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {desc='Find git files'})
vim.keymap.set('n', '<leader>fc', builtin.live_grep, {desc='Find code'})


vim.keymap.set("n", '<leader>fd', vim.cmd.Ex, {desc='Directory'})

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, {desc='Undotree'})

-- move selected code up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc="move selected code down"})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc="move selected code up"})

vim.keymap.set("n", "J", "mzJ`z", {desc="append below line to current line"})
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]], {desc='Paste(again)'})

vim.keymap.set("n", "Q", "<nop>")

