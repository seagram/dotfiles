vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }
		local map = vim.keymap.set
		map("n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<cr>", {
			desc = "Hover Documentation",
			buffer = opts.buffer,
		})
		map("n", "<leader>lH", "<cmd>:checkhealth lsp<cr>", {
			desc = "Check LSP health",
			buffer = opts.buffer,
		})
		map("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>", {
			desc = "Goto Definition",
			buffer = opts.buffer,
		})
		map("n", "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<cr>", {
			desc = "Goto Declaration",
			buffer = opts.buffer,
		})
		map("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<cr>", {
			desc = "Goto Implementation",
			buffer = opts.buffer,
		})
		map("n", "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", {
			desc = "Goto Type Definition",
			buffer = opts.buffer,
		})
		map("n", "<leader>lR", "<cmd>lua vim.lsp.buf.references()<cr>", {
			desc = "References",
			buffer = opts.buffer,
		})
		map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", {
			desc = "Rename",
			buffer = opts.buffer,
		})
		map("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<cr>", {
			desc = "Signature Help",
			buffer = opts.buffer,
		})
		map({ "n" }, "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", {
			desc = "Code Action",
			buffer = opts.buffer,
		})
		map({ "n" }, "<leader>lx", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", {
			desc = "LSP Format",
			buffer = opts.buffer,
		})
	end,
})

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},

	-- virtual_lines = {
	-- 	current_line = true,
	-- },
	--
	virtual_text = {
		current_line = true,
	},
})

local capabilities = {
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		},
	},
}

capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

vim.lsp.config("*", {
	capabilities = capabilities,
	root_markers = { ".git" },
})

vim.lsp.enable({ "gopls", "luals", "basedpyright", "tsls", "bashls", "postgrestools", "ruff" })
