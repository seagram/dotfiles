return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
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
			-- list of servers for mason to install
			ensure_installed = {
				"ts_ls", -- javascript lsp
				"html", -- html lsp
				"cssls", -- css lsp
				"pyright", -- python lsp
				"clangd", -- c/cpp lsp
				"lua_ls", -- lua lsp
				"marksman", -- markdown lsp
				"gopls", -- go lsp
				"intelephense", -- php lsp
				"terraformls",
				"sqls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- javascript formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint", -- python linter
				"eslint_d", -- js diagnostics
				"stylua", -- lua formatter
				"sqlfluff",
			},
		})
	end,
}
