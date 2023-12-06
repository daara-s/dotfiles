vim.api.nvim_create_autocmd("TextYankPost",{
    group = vim.api.nvim_create_augroup("highlight_yank", {}),
    desc = "Highlight selection on yank",
    callback = function()
        vim.highlight.on_yank()
    end,
})