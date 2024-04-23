return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        -- priority = 1000,
        config = function()
            require("catppuccin").setup({})
            -- vim.cmd.colorscheme "catppuccin"
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function ()
            vim.cmd.colorscheme "rose-pine-moon"
        end
    },
    {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        config = function ()
            -- vim.cmd.colorscheme "kanagawa"
        end
    },
}
