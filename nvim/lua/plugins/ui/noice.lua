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
				view = "notify",
				filter = {
					event = "msg_show",
					kind = "",
				},
				opts = { skip = true },
			},
		},
		views = {
			cmdline_popup = {
				size = {
					width = 30,
					height = "auto",
				},
			},
		},
		cmdline = {
			format = {
				search_down = {
					view = "cmdline",
				},
				search_up = {
					view = "cmdline",
				},
			},
		},
		vim.keymap.set("n", "<leader>n", function()
			require("noice").cmd("dismiss")
		end, { desc = "Dismiss Notifications" }),
	}),
}
