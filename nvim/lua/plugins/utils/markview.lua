return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	dependencies = { "saghen/blink.cmp" },
	config = function()
		local presets = require("markview.presets")
		local headings = presets.headings.marker
		headings.heading_1.sign = ""
		headings.heading_2.sign = ""
		headings.heading_3.sign = ""
		headings.heading_4.sign = ""
		headings.heading_5.sign = ""
		headings.heading_6.sign = ""
		require("markview").setup({
			preview = {
				ignore_buftypes = { "nofile" },
				icon_provider = "mini",
			},
			markdown = {
				headings = headings,
				horizontal_rules = presets.dashed,
			},
		})
	end,
}
