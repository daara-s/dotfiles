local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[f]ind [f]iles' })
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[f]ind [g]it files' })
vim.keymap.set('n', '<leader>sc', builtin.live_grep, { desc = '[s]earch [c]ode' })
vim.keymap.set('n', '<leader>fc',
    function() builtin.find_files({ cwd = vim.fn.stdpath("config") }) end,
    { desc = '[f]ind [c]onfig' }
)


vim.keymap.set("n", '<leader>fd', vim.cmd.Ex, {desc='[f]ind [d]irectory'})

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, {desc='Undotree'})

-- move selected code up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc="move selected code down"})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc="move selected code up"})

vim.keymap.set("n", "J", "mzJ`z", {desc="append below line to current line"})

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<S-Down>", "<C-d>zz")
vim.keymap.set("n", "<S-Up>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]], {desc='Paste(again)'})

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("v", "<leader>cc", ":norm ", {desc="comment out code with i# or ^x"})

vim.keymap.set("n", "<leader>t", ":norm [m<CR>wyiw <C-O> :!pytest -k \"<C-R>0\"<CR>", {desc="pytest this function"})
