return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		local nvimtree = require("nvim-tree")

		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
		vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

		nvimtree.setup({
			view = {
				width = 30,
				relativenumber = true,
			},
			renderer = {
				icons = {
					webdev_colors = true,
					glyphs = {
						folder = {
							default = "",
							open = "",
							arrow_closed = "",
							arrow_open = "",
						},
					},
					show = {
						git = false,
					},
				},
			},
			actions = {
				open_file = {
					quit_on_open = true,
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				git_clean = false,
				no_buffer = false,
				custom = {
					".DS_Store",
					"*.o",
					".android",
					".cache",
				},
			},
			git = {
				ignore = false,
			},
		})
		vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "nvim-tree" })
	end,
}
