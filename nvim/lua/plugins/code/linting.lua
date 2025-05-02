return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			python = { "pylint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>ll", function()
			lint.try_lint()
		end, { desc = "Trigger linting" })

		-- Ignore "No EsLint config found" error
		lint.linters.eslint_d = require("lint.util").wrap(lint.linters.eslint_d, function(diagnostic)
			if diagnostic.message:find("Error: Could not find config file") then
				return nil
			end
		end)

		-- Ignore "Trailing newlines"
		lint.linters.pylint = require("lint.util").wrap(lint.linters.pylint, function(diagnostic)
			if diagnostic.message:find("Trailing whitespace (trailing-whitespace)") then
				return nil
			elseif diagnostic.message:find("Trailing newlines (trailing-newlines)") then
				return nil
			end
			return diagnostic
		end)
	end,
}
