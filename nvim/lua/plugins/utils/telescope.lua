return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				file_ignore_patterns = {
					"Applications/*",
					"Documents/*",
					"Library/*",
					"Movies/*",
					"Music/*",
					"Pictures/*",
					"Public/*",
				},
			},
		})

		telescope.load_extension("fzf")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "fzf (cwd)" })
		vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "fzf (recent)" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "fzf (string in cwd)" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "fzf diagnostics" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "fzf buffers" })
	end,
}
