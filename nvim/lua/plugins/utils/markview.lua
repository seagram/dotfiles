return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("markview").setup({
			preview = {
				filetypes = { "md" },
				ignore_buftypes = { "nofile" },
			},
			markdown = {
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
			},
		})
	end,
}
