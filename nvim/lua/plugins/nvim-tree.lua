return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		local nvimtree = require("nvim-tree")

		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvimtree.setup({
			view = {
				-- width = 30,
			},
			-- change folder arrow icons
			renderer = {
				icons = {
					webdev_colors = true,
					glyphs = {
						folder = {
							default = "",
							open = "",
						},
					},
					show = {
						git = false,
						folder_arrow = false,
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
				expand_all = {
					max_folder_discovery = 20,
					exclude = { ".git", ".terraform", "node_modules", ".astro" },
				},
			},
			filters = {
				custom = {
					".DS_Store",
				},
			},
			git = {
				ignore = false,
			},
		})

		local nvimtree = require("nvim-tree")
		local api = require("nvim-tree.api")
		local tree_is_expanded = false

		local function toggle_tree_folds()
			local cur_buf_name = vim.api.nvim_buf_get_name(0)
			if not string.match(cur_buf_name, "NvimTree") then
				return
			end
			if tree_is_expanded then
				api.tree.collapse_all()
				tree_is_expanded = false
			else
				api.tree.expand_all()
				tree_is_expanded = true
			end
		end

		vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "nvim-tree" })
		vim.keymap.set("n", "<leader>w", toggle_tree_folds, { desc = "fold/unfold nvim-tree" })
	end,
}
