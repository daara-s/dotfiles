return {
    "folke/which-key.nvim",
    dependencies = {
        { 'echasnovski/mini.icons', version = false },
    },
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>c", group = "Code" },
            { "<leader>f", group = "Find" },
        })
    end,
}
