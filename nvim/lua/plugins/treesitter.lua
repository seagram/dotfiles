return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter.configs")
		vim.treesitter.language.register("markdown", "mdx")
		treesitter.setup({
			highlight = {
				enable = true,
			},

			indent = { enable = true },

			ensure_installed = {
				"bash",
				"lua",
				"python",
				"go",
				"sql",
				"markdown",
				"markdown_inline",
				"dockerfile",
				"yaml",
				"json",
				"hcl",
				"toml",
				"gitignore",
			},
		})
	end,
}
