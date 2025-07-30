local tn = {
	"folke/tokyonight.nvim",
	priority = 1000,
	config = function()
		local bg = "#011628"
		local bg_dark = "#011423"
		local bg_highlight = "#143652"
		local bg_search = "#0A64AC"
		local bg_visual = "#275378"
		local fg = "#CBE0F0" -- local variables
		local fg_dark = "#B4D0E9" -- brackets
		local fg_gutter = "#627E97"
		local border = "#547998"
		local bg_dark1 = "#1b1e2d"
		local blue = "#fce8c3" -- function names
		local blue0 = "#3d59a1"
		local blue1 = "#90a6ba" -- types
		local blue2 = "#0db9d7"
		local blue5 = "#CBE0F0" -- operators (*, -, +, etc.)
		local blue6 = "#b4f9f8"
		local blue7 = "#394b70"
		local comment = "#565f89"
		local cyan = "#90a6ba" -- import statements / decorators
		local dark3 = "#545c7e"
		local dark5 = "#737aa2"
		local green = "#fce8c3"
		local green1 = "#ffffff" -- example.this
		local green2 = "#41a6b5"
		local magenta = "#B4D0E9" -- function def
		local magenta2 = "#ff007c"
		local orange = "#CBE0F0" -- global variables
		local purple = "#CBE0F0" -- return statement / class
		local red = "#CBE0F0" -- attribute identifier
		local red1 = "#db4b4b"
		local teal = "#1abc9c"
		local terminal_black = "#414868"
		local transparent = true
		local yellow = "#B4D0E9" -- comments, local scope variables
		require("tokyonight").setup({
			style = "night",
			transparent = transparent,
			styles = {
				sidebars = transparent and "transparent" or "dark",
				floats = transparent and "transparent" or "dark",
			},
			on_colors = function(colors)
				colors.bg = bg
				colors.bg_dark = transparent and colors.none or bg_dark
				colors.bg_dark1 = bg_dark1
				colors.bg_float = transparent and colors.none or bg_dark
				colors.bg_highlight = bg_highlight
				colors.bg_popup = bg_dark
				colors.bg_search = bg_search
				colors.bg_sidebar = transparent and colors.none or bg_dark
				colors.bg_statusline = transparent and colors.none or bg_dark
				colors.bg_visual = bg_visual
				colors.border = border
				colors.fg = fg
				colors.fg_dark = fg_dark
				colors.fg_float = fg
				colors.fg_gutter = fg_gutter
				colors.fg_sidebar = fg_dark
				colors.blue = blue
				colors.blue0 = blue0
				colors.blue1 = blue1
				colors.blue2 = blue2
				colors.blue5 = blue5
				colors.blue6 = blue6
				colors.blue7 = blue7
				colors.comment = comment
				colors.cyan = cyan
				colors.dark3 = dark3
				colors.dark5 = dark5
				colors.green = green
				colors.green1 = green1
				colors.green2 = green2
				colors.magenta = magenta
				colors.magenta2 = magenta2
				colors.orange = orange
				colors.purple = purple
				colors.red = red
				colors.red1 = red1
				colors.teal = teal
				colors.terminal_black = terminal_black
				colors.yellow = yellow
			end,
		})
		vim.cmd("colorscheme tokyonight")
	end,
}

local poimandres = {
	"olivercederborg/poimandres.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("poimandres").setup({
			disable_background = true,
			disable_float_background = false,
			disable_italics = false,
		})
	end,

	init = function()
		vim.cmd("colorscheme poimandres")
	end,
}

local moon = {
	"kyazdani42/blue-moon",
	config = function()
		vim.opt.termguicolors = true
		vim.cmd("colorscheme blue-moon")
	end,
}

return tn
