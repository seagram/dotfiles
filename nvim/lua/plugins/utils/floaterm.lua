return {
	"voldikss/vim-floaterm",
	event = "VeryLazy",
	config = function()
		vim.g.floaterm_title = "─"
		vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
		local keymap = vim.keymap
		keymap.set({ "n", "t" }, "<C-t>", "<cmd>FloatermToggle<CR>")
	end,
}
