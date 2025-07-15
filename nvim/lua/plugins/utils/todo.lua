return {
	"bngarren/checkmate.nvim",
	ft = "markdown",
	config = function()
		require("checkmate").setup({
			files = { "*.md" },
		})
		vim.keymap.set("n", "<leader>tt", ":CheckmateToggle<CR>", { desc = "Toggle Checkmate" })
		vim.keymap.set("n", "<leader>tn", ":CheckmateCreate<CR>", { desc = "Create Checkmate" })
	end,
}
