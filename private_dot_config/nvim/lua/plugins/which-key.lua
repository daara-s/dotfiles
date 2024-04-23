return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
	defaults = {
        ["<leader>f"] = { name = "Find" },
        ["<leader>c"] = { name = "Code" },
        ["<leader>t"] = { name = "Test" },

	},
  },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
}
