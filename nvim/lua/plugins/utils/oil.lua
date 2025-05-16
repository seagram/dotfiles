return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	lazy = false,
	config = function()
		require("oil").setup({
			skip_confirm_for_simple_edits = true,
			view_options = {
				show_hidden = true,
			},
		})
		vim.keymap.set("n", "<leader>o", function()
			local oil = require("oil")
			if vim.bo.filetype == "oil" then
				oil.save()
				oil.close()
			else
				vim.cmd("Oil")
			end
		end, { desc = "Toggle oil.nvim" })
	end,
}
