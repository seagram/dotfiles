return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	require("noice").setup({
		routes = {
			{
				filter = {
					event = "msg_show",
					kind = "",
				},
				opts = { skip = true },
			},
		},
	}),
}
