return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        -- priority = 1000,
        event = "VeryLazy",
        config = function()
            require("catppuccin").setup({})
            -- vim.cmd.colorscheme "catppuccin"
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        event = "VeryLazy",
        config = function ()
            -- vim.cmd.colorscheme "rose-pine-moon"
        end
    },
    {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        lazy = false,
        priority = 1000,
        config = function ()
            vim.cmd.colorscheme "kanagawa"
        end
    },
}
