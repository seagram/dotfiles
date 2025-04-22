---@type vim.lsp.Config
return {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "typescript" },
	root_markers = {
		"package.json",
		"tsconfig.json",
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.json",
		".prettierrc.js",
		".prettierrc.cjs",
		".prettierrc.json",
	},
}
