return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {},
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			highlight = {
				enable = true,
			},

			indent = { enable = true },

			ensure_installed = {
				"javascript",
				"python",
				"markdown",
				"markdown_inline",
				"bash",
				"lua",
				"go",
			},
		})
	end,
}
