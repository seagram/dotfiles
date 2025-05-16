return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			python = { "ruff" },
		}

		local lint_augroup_id = vim.api.nvim_create_augroup("lint", { clear = true })

		local linting_enabled = true

		local function toggle_linting()
			linting_enabled = not linting_enabled
			vim.api.nvim_del_augroup_by_id(lint_augroup_id)

			if linting_enabled then
				lint_augroup_id = vim.api.nvim_create_augroup("lint", { clear = true })
				vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
					group = lint_augroup_id,
					callback = function()
						lint.try_lint()
					end,
				})
				vim.diagnostic.enable(true)
				lint.try_lint()
			else
				lint_augroup_id = vim.api.nvim_create_augroup("lint", { clear = true })
				vim.diagnostic.enable(false)
			end
			print("Linting " .. (linting_enabled and "enabled" or "disabled"))
		end

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup_id,
			callback = function()
				if linting_enabled then
					lint.try_lint()
				end
			end,
		})

		vim.keymap.set("n", "<leader>tt", function()
			lint.try_lint()
		end, { desc = "Trigger linting" })

		vim.keymap.set("n", "<leader>tl", toggle_linting, { desc = "Toggle linting" })

		-- Ignore "No EsLint config found" error
		lint.linters.eslint_d = require("lint.util").wrap(lint.linters.eslint_d, function(diagnostic)
			if diagnostic.message:find("Error: Could not find config file") then
				return nil
			end
		end)

		-- Disable hover for ruff, use basedpyright instead
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client == nil then
					return
				end
				if client.name == "ruff" then
					client.server_capabilities.hoverProvider = false
				end
			end,
			desc = "LSP: Disable hover capability from Ruff",
		})
	end,
}
