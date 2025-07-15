return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = function()
		local version = vim.version()
		local version_string = string.format("nvim v%d.%d.%d", version.major, version.minor, version.patch)

		return {
			-- file picker
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
							-- filetypes
							"**/.DS_Store",
							"**/*.pdf",
							"**/*.png",
							"**/*.jpeg",
							"**/*.jpg",
							-- directories
							"**/Library/*",
							"**/Applications/*",
							"**/Documents/*",
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
			-- indent lines
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
			-- dashboard
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
		}
	end,
	keys = {
		{
			"<leader>ff",
			function()
				Snacks.picker.smart()
				-- Snacks.picker.files() -- deprecated
			end,
			desc = "Find Files",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Find Recent",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Find Buffers",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Find Grep",
		},
		-- {
		-- 	"<leader>fn",
		-- 	function()
		-- 		Snacks.picker.notifications()
		-- 	end,
		-- 	desc = "Find Notification",
		-- },
		{
			"<leader>fk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Find Keymaps",
		},
		-- {
		-- 	"<leader>fq",
		-- 	function()
		-- 		Snacks.picker.qflist()
		-- 	end,
		-- 	desc = "Quickfix List",
		-- },
		{
			"<leader>fd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Find Diagnostics",
		},
	},
}
