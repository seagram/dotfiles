return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {},
	config = function()
		require("render-markdown").setup({
			completions = { blink = { enabled = true } },
			heading = {
				sign = false,
				icons = {},
				width = "block",
				left_pad = 1,
				right_pad = 1,
			},
		})
	end,
}
