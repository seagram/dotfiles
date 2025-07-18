---@type vim.lsp.Config
return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gosum", "gowork", "gotmpl" },
	root_markers = {
		"go.mod",
		"go.sum",
		".git",
	},
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
				fieldalignment = true,
				inferTypeArgs = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			staticcheck = true,
			gofumpt = true,
			semanticTokens = true,
			completeUnimported = true,
			usePlaceholders = true,
		},
	},
}
