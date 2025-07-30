vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	desc = "LSP actions",
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
		end
		map("<leader>lh", vim.lsp.buf.hover, "hover")
		map("<leader>ls", vim.lsp.buf.signature_help, "signature")
		map("<leader>ld", vim.lsp.buf.declaration, "declaration")
		map("<leader>la", vim.lsp.buf.code_action, "code action")
		map("<leader>lr", vim.lsp.buf.rename, "rename")
		map("<leader>lf", vim.lsp.buf.format, "format")
		map("<leader>lH", "<cmd>:checkhealth lsp<cr>", "lsp health")
		-- map("<leader>lD", vim.lsp.buf.definition, "Goto Definition")
		-- map("<leader>li", vim.lsp.buf.implementation, "Goto Implementation")
		-- map("<leader>lt", vim.lsp.buf.type_definition, "Goto Type Definition")
		-- map("<leader>lR", vim.lsp.buf.references, "References")
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
	float = {
		border = "rounded",
		source = true,
	},
	virtual_text = {
		current_line = true,
	},
	-- virtual_lines = {
	-- 	current_line = true,
	-- },
	--
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

local lsp_configs = {}
local disable_lsp = {}

for _, f in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
	local server_name = vim.fn.fnamemodify(f, ":t:r")
	local should_disable = false
	for _, disabled_server in ipairs(disable_lsp) do
		if server_name == disabled_server then
			should_disable = true
			break
		end
	end

	if not should_disable then
		table.insert(lsp_configs, server_name)
	end
end

vim.lsp.enable(lsp_configs)
