return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = { "OXY2DEV/markview.nvim" },
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			highlight = {
				enable = true,
			},

			indent = { enable = true },

			ensure_installed = {
				"bash",
				"lua",
				"python",
				"javascript",
				"go",
				"markdown",
				"markdown_inline",
			},
		})
	end,
}
