return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			python = { "ruff" },
		}

		local lint_augroup_id = vim.api.nvim_create_augroup("lint", { clear = true })

		local linting_enabled = true

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup_id,
			callback = function()
				if linting_enabled then
					lint.try_lint()
				end
			end,
		})
	end,
}
