local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = {buffer = event.buf}

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gK', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', 'gd', function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end,
            { buffer = event.buf, desc = 'Goto Definition' })
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gI', function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end,
            { buffer = event.buf, desc = 'Goto Implementation' })
        vim.keymap.set('n', 'gy', function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end,
            { buffer = event.buf, desc = 'Goto T[y]pe Definition' })
        vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
        vim.keymap.set('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<cr>',
            { buffer = event.buf, desc = 'Rename' })
        vim.keymap.set({ 'n', 'x' }, '<leader>cf', function() vim.lsp.buf.format({ async = true }) end,
            { buffer = event.buf, desc = 'Format code' })
        vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>',
            { buffer = event.buf, desc = 'Code action' })
        vim.keymap.set('n', '<leader>cl', '<cmd>LspInfo<cr>', { desc = 'LSP info' })

        vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
        vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
        vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
    end
})

local default_setup = function(server)
    lspconfig[server].setup({
        capabilities = lsp_capabilities,
    })
end

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {"pylsp", "ruff_lsp", "lua_ls"},
    handlers = {
        default_setup,
        pylsp = function ()
            require('lspconfig').pylsp.setup({
                capabilities = lsp_capabilities,
                settings = {
                    pylsp = {
                        plugins= {
                            pyflakes = {enabled = false},
                            mccabe = {enabled = false},
                            pycodestyle = {enabled = false},
                            rope_autoimport = {enabled = true},
                            jedi_completions = {include_params = true},
                        }
                    }
                }
            })
        end,
        lua_ls = function()
            require('lspconfig').lua_ls.setup({
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT'
                        },
                        diagnostics = {
                            globals = {'vim'},
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

local cmp = require('cmp')

cmp.setup({
    sources = {
        {name = 'nvim_lsp'},
    },
    mapping = cmp.mapping.preset.insert({
        -- Enter key confirms completion item
        ['<CR>'] = cmp.mapping.confirm({select = false}),

        -- Ctrl + space triggers completion menu
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})

-- This is your opts table
require("telescope").setup {
    defaults = {
        path_display = {'truncate'},
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
        }
    }
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")
