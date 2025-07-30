vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0

vim.g.have_nerd_font = true

local set = vim.opt

set.foldmethod = "expr"
set.foldexpr = "v:lua.vim.treesitter.foldexpr()"
set.foldcolumn = "0"
set.foldtext = ""
set.foldlevel = 99
set.foldlevelstart = 99
set.foldnestmax = 99

set.number = true
set.relativenumber = true
set.mouse = "a"
set.termguicolors = true
set.background = "dark"
set.showmode = false
set.fillchars = { eob = " " }
set.termguicolors = true
set.matchtime = 2
set.scrolloff = 3
set.inccommand = "split"
set.pumheight = 5
set.cmdheight = 0

set.tabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.autoindent = true
set.copyindent = true
set.smartindent = true
set.breakindent = true

set.ignorecase = true
set.smartcase = true
set.hlsearch = false
set.incsearch = true

set.backspace = "indent,eol,start"

set.splitright = true
set.splitbelow = true

set.backup = false
set.writebackup = false
set.swapfile = false
set.undofile = true
set.undodir = vim.fn.expand("~/.vim/undodir")

set.confirm = true

set.wrap = false

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "md", "mdx" },
	callback = function()
		vim.opt_local.spelllang = "en_ca"
		vim.opt_local.spell = true
		local colors = vim.api.nvim_get_hl(0, { name = "Error" })
		vim.api.nvim_set_hl(0, "SpellBad", {
			fg = colors.fg,
			bg = colors.bg,
			bold = true,
		})
	end,
	desc = "Enable Spellcheck only on Markdown Files",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
	desc = "Disable New Line Comment",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "BufEnter" }, {
	pattern = { "*.md", "*.mdx" },
	callback = function()
		vim.opt_local.wrap = true
	end,
	desc = "Enable Text Wrapping only on Markdown Files",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "BufEnter" }, {
	pattern = { "*.md", "*.mdx" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.textwidth = 80
	end,
})

vim.schedule(function()
	set.clipboard = "unnamedplus"
end)

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.filetype.add({
	extension = {
		mdx = "mdx",
	},
})

for _, plugin in pairs({
	"netrwFileHandlers",
	"2html_plugin",
	"spellfile_plugin",
	"matchit",
}) do
	vim.g["loaded_" .. plugin] = 1
end
