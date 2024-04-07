local lspconfig = require('lspconfig')

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gK', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', 'gd',
            function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end,
            { buffer = event.buf, desc = 'Goto Definition' })
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gI',
            function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end,
            { buffer = event.buf, desc = 'Goto Implementation' })
        vim.keymap.set('n', 'gy',
            function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end,
            { buffer = event.buf, desc = 'Goto T[y]pe Definition' })
        vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
        vim.keymap.set('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<cr>',
            { buffer = event.buf, desc = 'Rename' })
        vim.keymap.set({ 'n', 'x' }, '<leader>cf',
            function() vim.lsp.buf.format({ async = true }) end,
            { buffer = event.buf, desc = 'Format code' })
        vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>',
            { buffer = event.buf, desc = 'Code action' })
        vim.keymap.set('n', '<leader>cl', '<cmd>LspInfo<cr>', { desc = 'LSP info' })

        vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
        vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
        vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
    end
})

-- todo
-- is this bit working?
-- what should it be doing?
local default_setup = function(server)
    lspconfig[server].setup({
        capabilities = lsp_capabilities,
    })
end

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { "pyright", "ruff_lsp", "lua_ls" },
    handlers = {
        default_setup,
        pyright = function()
            require('lspconfig').pyright.setup({
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
            require('lspconfig').lua_ls.setup({
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

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require('cmp')

cmp.setup({
    sources = {
        { name = 'nvim_lsp', max_item_count = 8, keyword_length = 2 },
        { name = 'buffer',   max_item_count = 2 },
        -- should add {name='luasnip'},
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-Space>'] = cmp.mapping.complete(),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                -- that way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
})
require("luasnip.loaders.from_vscode").lazy_load()

local telescope = require("telescope")
-- This is your opts table
telescope.setup {
    defaults = {
        path_display = {
            shorten = {
                len = 1,
                exclude = { 1, -1, -2 }
            },
        },
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
        },
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    },
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension("ui-select")
telescope.load_extension('fzf')
