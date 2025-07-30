return {
	"gbprod/yanky.nvim",
	opts = {},
	dependencies = { "folke/snacks.nvim" },
	config = function()
		local picker = require("yanky.picker")
		local utils = require("yanky.utils")
		require("yanky").setup({
			picker = {
				select = {
					action = picker.actions.set_register(utils.get_default_register()),
				},
			},
		})
	end,
	keys = {
		{
			"<leader>fy",
			function()
				Snacks.picker.yanky()
			end,
			mode = { "n" },
			desc = "yank",
		},
	},
}
