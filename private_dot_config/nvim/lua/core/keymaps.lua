local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc='Find files'})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {desc='Find git files'})
vim.keymap.set('n', '<leader>fc', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ")});
end)


vim.keymap.set("n", '<leader>fd', vim.cmd.Ex, {desc='Directory'})

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, {desc='Undotree'})


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]], {desc='Paste(again)'})

vim.keymap.set("n", "Q", "<nop>")

