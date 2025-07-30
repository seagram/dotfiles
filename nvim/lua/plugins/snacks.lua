return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = function()
		local version = vim.version()
		local version_string = string.format("nvim v%d.%d.%d", version.major, version.minor, version.patch)

		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = function()
				vim.api.nvim_set_hl(0, "SnacksPicker", { bg = "none", nocombine = true })
				vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = "#fce8c3", bg = "none", nocombine = true })
			end,
		})

		return {
			picker = {
				layout = {
					preset = "select",
					preview = false,
				},
				layouts = {
					select = {
						layout = {
							title = "",
						},
					},
				},
				sources = {
					files = {
						cmd = "fd",
						hidden = false,
						ignored = false,
						exclude = {
							"**/.DS_Store",
							"**/*.pdf",
							"**/*.png",
							"**/*.jpeg",
							"**/*.jpg",
							"**/*.mov",
							"**/*.mp4",
							"**/*.svg",
							"**/Library/*",
							"**/Applications/*",
							"**/Documents/*",
							"**/Downloads/*",
							"**/Movies/*",
							"**/Music/*",
							"**/Pictures/*",
							"**/Public/*",
							"**/.go/*",
							"**/node_modules/*",
							"**/.git/*",
						},
					},
				},
			},
			indent = {
				indent = {
					char = "┊",
				},
				animate = {
					enabled = false,
				},
				scope = {
					enabled = false,
				},
			},
			dashboard = {
				preset = {
					pick = nil,
					---@type snacks.dashboard.Item[]
					keys = {
						{ key = "n", desc = "new", action = ":ene" },
						{ icons = "", key = "ff", desc = "find", action = "lua Snacks.dashboard.pick('files')" },
						{ icons = "", key = "fr", desc = "recent", action = "lua Snacks.dashboard.pick('recent')" },
						{ icons = "", key = "q", desc = "quit", action = ":qa" },
					},
					header = version_string,
				},
				sections = {
					{ section = "header" },
					{
						section = "keys",
						padding = 1,
						gap = 1,
					},
				},
			},
			notifier = {
				style = "minimal",
			},
			styles = {
				input = {
					width = 40,
					noautocmd = false,
				},
				notification_history = {
					minimal = true,
				},
			},
		}
	end,
	keys = {
		{
			"<leader>ff",
			function()
				Snacks.picker.files({ cwd = "~/" })
			end,
			desc = "files",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "recent",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "buffers",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.grep()
			end,
			desc = "grep",
		},
		{
			"<leader>fe",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "errors",
		},
		{
			"<leader>fd",
			function()
				Snacks.picker.zoxide({
					win = {
						preview = {
							minimal = false,
						},
					},
				})
			end,
			desc = "zoxide",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "config",
		},
		{
			"<leader>fn",
			function()
				Snacks.picker.notifications()
			end,
			desc = "notifications",
		},
	},
}
