return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	-- ft = "markdown", -- for lazy loading

	dependencies = {
		"nvim-treesitter/nvim-treesitter",

		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("markview").setup({
			buf_ignore = { "nofile " },
			headings = {
				heading_1 = {
					style = "simple",
				},
				heading_2 = {
					style = "simple",
				},
				heading_3 = {
					style = "simple",
				},
				heading_4 = {
					style = "simple",
				},
			},
		})
	end,
}
