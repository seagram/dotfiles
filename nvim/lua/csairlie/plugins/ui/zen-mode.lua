return {
	{
		"folke/zen-mode.nvim",
		config = function()
			local default_colorscheme = vim.g.colors_name or "default"
			local default_guicursor = vim.o.guicursor -- Store default guicursor

			require("zen-mode").setup({
				window = {
					width = 80,
					options = {
						number = false,
						signcolumn = "no",
						relativenumber = false,
					},
				},
				plugins = {
					twilight = { enabled = true },
					wezterm = {
						enable = true,
						font = "+4",
					},
				},
				on_open = function()
					vim.cmd("color paper") -- Switch to "paper" when ZenMode is enabled
					vim.cmd([[
                    set termguicolors
                    highlight Cursor guibg=#A9A9A9 cterm=reverse
                    set guicursor=n-v-c-o:block-Cursor/lCursor,i:ver25-Cursor
                    ]])
				end,
				on_close = function()
					vim.cmd("color tokyonight") -- Restore the previous colorscheme
					vim.cmd([[
                    set termguicolors
                    highlight Cursor guibg=#47FF9C cterm=reverse
                    set guicursor=n-v-c-o:block-Cursor/lCursor,i:ver25-Cursor
                    ]])
				end,
			})

			vim.keymap.set({ "n", "v" }, "<leader>z", "<cmd>ZenMode<CR>")
		end,
	},
	{
		"yorickpeterse/vim-paper",
	},
	{
		"folke/twilight.nvim",
		opts = {
			dimming = {
				alpha = 0.25, -- amount of dimming
			},
			context = 10, -- amount of lines
		},
	},
	{
		"kblin/vim-fountain",
	},
}
