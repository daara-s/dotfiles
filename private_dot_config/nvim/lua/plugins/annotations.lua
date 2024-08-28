return {
    "danymat/neogen",
    event = "VeryLazy",
    config = function()
        require('neogen').setup({
            snippet_engine = "luasnip",
            languages = {
                python = {
                    template = {
                        annotation_convention = "numpydoc"
                    }
                }
            }
        })
    end,
}
