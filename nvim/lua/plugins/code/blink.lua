return {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",
	version = "*",
	config = function()
		require("blink.cmp").setup({
			keymap = {
				preset = "enter",
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			cmdline = {
				enabled = false,
			},
			enabled = function()
				return not vim.tbl_contains({ "fountain", "markdown" }, vim.bo.filetype)
			end,
			completion = {
				menu = {
					border = "rounded",
					scrolloff = 1,
					scrollbar = false,
					draw = {
						columns = {
							-- { "kind_icon" },
							-- { "label", "label_description", gap = 1 },
							{ "kind_icon", "label", gap = 1 },
							-- { "kind" },
						},
					},
				},
				documentation = {
					window = {
						border = nil,
						scrollbar = false,
						winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
					},
					auto_show = true,
					auto_show_delay_ms = 500,
				},
			},
		})
	end,
	opts_extend = { "sources.default" },
}
