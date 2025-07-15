-- disable netrw (use nvim-tree instead) --
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- disable language provider support (lua and vimscript plugins only)
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0

vim.g.have_nerd_font = true

local set = vim.opt

-- folding
set.foldmethod = "expr"
set.foldexpr = "v:lua.vim.treesitter.foldexpr()"
set.foldcolumn = "0"
set.foldtext = ""
set.foldlevel = 99
set.foldlevelstart = 99
set.foldnestmax = 99

-- general
set.number = true -- show hybrid line numbers
set.relativenumber = true -- (contd.)
set.mouse = "a" -- enable mouse
set.wrap = false -- disable text wrapping
set.termguicolors = true
set.background = "dark" -- use dark mode for colorschemes
set.showmode = false -- already in status line
set.fillchars = { eob = " " } -- hide tildas at EOF
set.termguicolors = true
set.matchtime = 2 -- how long to show matching brackets

-- tabs & indentation
set.tabstop = 4 -- tab char looks like 4 spaces
set.shiftwidth = 4 -- num of spaces when indenting
set.expandtab = true -- pressing tab insert spaces instead of a tab char
set.autoindent = true -- copy indent from curr line when starting new one
set.smartindent = true
set.breakindent = true

-- search settings
set.ignorecase = true
set.smartcase = true -- if you include mixed case in search, assumes you want case-sensitive
set.hlsearch = false -- disable search result highlighting
set.incsearch = true -- show search matches as you type

-- backspace
set.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- use system clipboard
vim.schedule(function()
	set.clipboard = "unnamedplus"
end)

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- split windows
set.splitright = true -- split vertical window to the right
set.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
set.backup = false
set.writebackup = false
set.swapfile = false
set.undofile = true
set.undodir = vim.fn.expand("~/.vim/undodir")

-- save undo history

-- confirm before exit
set.confirm = true
