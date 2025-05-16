return {
	"00msjr/nvim-fountain",
	ft = "fountain", -- Lazy-load only for fountain files
	config = function()
		require("nvim-fountain").setup({
			-- Optional configuration
			keymaps = {
				next_scene = "]]",
				prev_scene = "[[",
				uppercase_line = "<S-CR>",
			},
			-- Export configuration
			export = {
				output_dir = nil,
				pdf = { options = "--overwrite --font Courier" },
			},
			use_treesitter = true,
		})
	end,
}
