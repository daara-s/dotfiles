return {
    { 'neovim/nvim-lspconfig' },
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup({})
        end
    },
    { 'hrsh7th/cmp-nvim-lsp' },
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
                ensure_installed = { "basedpyright", "lua_ls", "ruff", },
                handlers = {
                    default_setup,
                    basedpyright = function()
                        lspconfig.basedpyright.setup({
                            capabilities = lsp_capabilities,
                            settings = {
                                basedpyright = {
                                    analysis = {
                                        autoImportCompletions = true,
                                        diagnosticMode = "openFilesOnly",
                                        useLibraryCodeForTypes = true,
                                        typeCheckingMode = "basic",     -- off, basic, strict, all
                                        diagnosticSeverityOverrides = { -- false, none, information, warning, error, true
                                            reportMissingTypeStubs = false,
                                            reportImplicitOverride = false,
                                            reportUnsafeMultipleInheritance = false,
                                            reportIncompatibleMethodOverride = false, -- mypy covered
                                            reportAny = false,
                                            reportMissingSuperCall = false,
                                            reportAttributeAccessIssue = "information",
                                        }
                                    }
                                }
                            }
                        })
                    end,
                    -- pyright = function()
                    --     lspconfig.pyright.setup({
                    --         capabilities = lsp_capabilities,
                    --         settings = {
                    --             pyright = {
                    --                 -- eg disableOrganiseImport = true,
                    --                 typeCheckingMode = "off",
                    --             }
                    --         }
                    --     })
                    -- end,
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
                    ruff = function()
                        require('lspconfig').ruff.setup({
                            init_options = {
                                settings = {
                                    -- Ruff language server settings go here
                                }
                            }
                        })
                    end,
                },
            })
        end
    },
}
