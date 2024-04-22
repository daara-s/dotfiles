return {
    { 'neovim/nvim-lspconfig' },
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup({})
        end
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            local lspconfig = require('lspconfig')
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

            local default_setup = function(server)
                lspconfig[server].setup({
                    capabilities = lsp_capabilities,
                })
            end

            require('mason-lspconfig').setup({
                ensure_installed = { "pyright", "ruff_lsp", "lua_ls" },
                handlers = {
                    default_setup,
                    pyright = function()
                        lspconfig.pyright.setup({
                            capabilities = lsp_capabilities,
                            settings = {
                                pyright = {
                                    -- eg disableOrganiseImport = true,
                                    typeCheckingMode = "off",
                                }
                            }
                        })
                    end,
                    lua_ls = function()
                        lspconfig.lua_ls.setup({
                            settings = {
                                Lua = {
                                    runtime = {
                                        version = 'LuaJIT'
                                    },
                                    diagnostics = {
                                        globals = { 'vim' },
                                    },
                                    workspace = {
                                        library = {
                                            vim.env.VIMRUNTIME,
                                        }
                                    }
                                }
                            }
                        })
                    end,
                },
            })
        end
    },
    { 'hrsh7th/cmp-nvim-lsp' },
}
