return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"saghen/blink.cmp",
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		-- local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local blink = require("blink.cmp")

		local keymap = vim.keymap -- for conciseness

		-- LSP keymaps
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>lD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		-- local capabilities = cmp_nvim_lsp.default_capabilities()
		local capabilities = blink.get_lsp_capabilities()

		-- Enable folding for ufo.nvim
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,

			["terraformls"] = function()
				lspconfig["terraformls"].setup({
					capabilities = capabilities,
					filetypes = { "terraform", "tf" }, -- specify .tf filetype for terraformls
				})
			end,

			["pyright"] = function()
				lspconfig["pyright"].setup({
					capabilities = capabilities,
					settings = {
						python = {
							analysis = {
								autoImportCompletion = true,
								reportUsedImports = "none",
								typeCheckingMode = "basic",
							},
						},
					},
				})
			end,

			["gopls"] = function()
				lspconfig["gopls"].setup({
					capabilities = capabilities,
					settings = {
						gopls = {
							completeUnimported = true,
							usePlaceholders = true,
						},
						analyses = {
							unusedparams = true,
						},
					},
				})
			end,

			["sqls"] = function()
				lspconfig["sqls"].setup({
					capabilities = capabilities,
					settings = {
						init_options = {
							provideFormatter = false,
						},
					},
				})
			end,
		})
	end,
}
