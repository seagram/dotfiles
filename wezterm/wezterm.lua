local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- coolnight colorscheme
config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

-- fonts
config.font = wezterm.font("Liga SFMono Nerd Font", { weight = "Medium" })
config.font_size = 18

-- window
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8
config.window_close_confirmation = "NeverPrompt"
config.initial_rows = 27
config.initial_cols = 70
config.window_padding = {
	left = "10pt",
	right = "10pt",
	top = "10pt",
	bottom = "10pt",
}
config.macos_window_background_blur = 10
config.max_fps = 120
config.enable_tab_bar = false

-- cursor
config.default_cursor_style = "SteadyUnderline"

-- keybindings
local act = wezterm.action
config.keys = {
	{
		key = ">",
		mods = "CMD|SHIFT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "<",
		mods = "CMD|SHIFT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = '"',
		mods = "CMD|SHIFT",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = ":",
		mods = "CMD|SHIFT",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "_",
		mods = "CMD|SHIFT",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "+",
		mods = "CMD|SHIFT",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
}

return config
