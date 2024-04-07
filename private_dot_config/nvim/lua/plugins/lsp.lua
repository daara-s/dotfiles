return {
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    {
        'L3MON4D3/LuaSnip',
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },

    },
    { 'hrsh7th/cmp-buffer' },
}
