return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")

		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"ts_ls", -- typescript lsp
				"basedpyright", -- python lsp
				"lua_ls", -- lua lsp
				"gopls", -- go lsp
				"bashls", -- bash lsp
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"isort", -- python import sorter
				"black", -- python formatter
				"pylint", -- python linter
				"eslint_d", -- js diagnostics
				"stylua", -- lua formatter
			},
		})
	end,
}
