return {
	{
		"folke/zen-mode.nvim",
		config = function()
			local default_colorscheme = vim.g.colors_name or "default"

			require("zen-mode").setup({
				window = {
					width = 80,
					options = {
						number = false,
						signcolumn = "no",
						relativenumber = false,
					},
				},
				on_open = function()
					vim.cmd("colorscheme paper") -- Switch to "paper" when ZenMode is enabled
				end,
				on_close = function()
					vim.cmd("colorscheme " .. default_colorscheme) -- Restore the previous colorscheme
				end,
			})

			vim.keymap.set({ "n", "v" }, "<leader>z", "<cmd>ZenMode<CR>")
		end,
	},
	{
		"yorickpeterse/vim-paper",
	},
}
