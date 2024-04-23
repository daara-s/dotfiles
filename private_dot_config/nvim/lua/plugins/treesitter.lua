return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        { 'LiadOz/nvim-dap-repl-highlights' },
    },
    config = function()
        local configs = require("nvim-treesitter.configs")

        require('nvim-dap-repl-highlights').setup()
        configs.setup({
            ensure_installed = { "lua", "vim", "vimdoc", "javascript", "html", "python", "dap_repl" },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
        })
    end
}
