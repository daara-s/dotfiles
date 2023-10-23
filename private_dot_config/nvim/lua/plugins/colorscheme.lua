-- return {
--   "catppuccin/nvim",
--   lazy = true,
--   name = "catppuccin",
--   opts = {
--     integrations = {
--       alpha = true,
--       cmp = true,
--       flash = true,
--       gitsigns = true,
--       illuminate = true,
--       indent_blankline = { enabled = true },
--       lsp_trouble = true,
--       mason = true,
--       mini = true,
--       native_lsp = {
--         enabled = true,
--         underlines = {
--           errors = { "undercurl" },
--           hints = { "undercurl" },
--           warnings = { "undercurl" },
--           information = { "undercurl" },
--         },
--       },
--       navic = { enabled = true, custom_bg = "lualine" },
--       neotest = true,
--       noice = true,
--       notify = true,
--       neotree = true,
--       semantic_tokens = true,
--       telescope = true,
--       treesitter = true,
--       which_key = true,
--     },
--   },
-- }
-- return {
--   "loctvl842/monokai-pro.nvim",
-- }
return {
  { "ellisonleao/gruvbox.nvim" },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
