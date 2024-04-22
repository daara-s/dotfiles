vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", {}),
    desc = "Highlight selection on yank",
    callback = function()
        vim.highlight.on_yank()
    end,
})

local wr_group = vim.api.nvim_create_augroup('WinResize', { clear = true })

vim.api.nvim_create_autocmd(
    'VimResized',
    {
        group = wr_group,
        pattern = '*',
        command = 'wincmd =',
        desc = 'Automatically resize windows when the host window size changes.'
    }
)

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gK', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', 'gd',
            function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end,
            { buffer = event.buf, desc = 'Goto Definition' })
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gI',
            function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end,
            { buffer = event.buf, desc = 'Goto Implementation' })
        vim.keymap.set('n', 'gy',
            function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end,
            { buffer = event.buf, desc = 'Goto T[y]pe Definition' })
        vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
        vim.keymap.set('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<cr>',
            { buffer = event.buf, desc = 'Rename' })
        vim.keymap.set({ 'n', 'x' }, '<leader>cf',
            function() vim.lsp.buf.format({ async = true }) end,
            { buffer = event.buf, desc = 'Format code' })
        vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>',
            { buffer = event.buf, desc = 'Code action' })
        vim.keymap.set('n', '<leader>cl', '<cmd>LspInfo<cr>', { desc = 'LSP info' })

        vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
        vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
        vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
    end
})
