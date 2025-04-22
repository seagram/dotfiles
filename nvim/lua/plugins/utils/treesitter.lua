return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {},
	config = function()
		-- import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")

		-- configure treesitter
		treesitter.setup({ -- enable syntax highlighting
			highlight = {
				enable = true,
			},
			-- enable indentation
			indent = { enable = true },
			-- ensure these language parsers are installed
			ensure_installed = {
				-- general
				"python",
				"go",
				"javascript",
				"lua",
				"bash",
				-- other
				"json",
				"html",
				"css",
				"markdown",
				"markdown_inline",
				"dockerfile",
				"gitignore",
				"c",
				"java",
			},
		})
	end,
}
