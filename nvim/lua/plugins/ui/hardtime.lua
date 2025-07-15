local enabled = false

return {
	"m4xshen/hardtime.nvim",
	enabled = enabled,
	lazy = false,
	dependencies = { "MunifTanjim/nui.nvim" },
	opts = {},
	config = function()
		if enabled then
			require("hardtime").setup()
		end
	end,
}
