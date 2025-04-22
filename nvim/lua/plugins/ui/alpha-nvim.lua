return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		local Home = {
			"+49.2673844992692",
			"",
			"-123.178222775459",
		}

		local Vim = {
			"          .          .     ",
			"        ';;,.        ::'   ",
			"      ,:::;,,        :ccc, ",
			"     ,::c::,,,,.     :cccc,",
			"     ,cccc:;;;;;.    cllll,",
			"     ,cccc;.;;;;;,   cllll;",
			"     :cccc; .;;;;;;. coooo;",
			"     ;llll;   ,:::::'loooo;",
			"     ;llll:    ':::::loooo:",
			"     :oooo:     .::::llodd:",
			"     .;ooo:       ;cclooo:.",
			"       .;oc        'coo;.  ",
			"         .'         .,.    ",
		}

		local Seagram = {

			"          +           ",
			"       +++++++        ",
			"     +++++++++++++++  ",
			"   ++  +++++++++++    ",
			"  +++     ++++++      ",
			" ++++                 ",
			"+++++++               ",
			"++++++++++            ",
			"+++++++++++++++       ",
			"  +++++++++++++++++   ",
			"    +++++++++++++++++ ",
			"        ++++++++++++++",
			"             +++++++++",
			"                +++++ ",
			"    +++++++      +++  ",
			"++++++++++++++   ++   ",
			"   ++++++++++++++     ",
			"      +++++++++       ",
			"        +++++         ",
			"          +           ",
		}
		-- Set header
		dashboard.section.header.val = Vim

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("n", "  > new", "<cmd>ene<CR>"),
			dashboard.button("<> ff", "  > find", "<cmd>Telescope find_files<CR>"),
			dashboard.button("<> fr", "  > recent", "<cmd>Telescope oldfiles<CR>"),
			dashboard.button("q", "  > quit", "<cmd>qa<CR>"),
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)
		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
		-- Remove tildes from dashboard
		vim.opt.fillchars = { eob = " " }
	end,
}
