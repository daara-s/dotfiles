return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "lua", "vim", "vimdoc", "javascript", "html", "python" },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
        })
    end
}
