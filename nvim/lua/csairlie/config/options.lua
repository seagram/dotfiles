-- disable netrw (use nvim-tree instead) --
local set = vim.g

set.loaded_netrw = 1
set.loaded_netrwPlugin = 1

-- disable language provider support (lua and vimscript plugins only)
set.loaded_perl_provider = 0
set.loaded_ruby_provider = 0
set.loaded_node_provider = 0
set.loaded_python_provider = 0
set.loaded_python3_provider = 0

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

-- tabs & indentation
set.tabstop = 4 -- tab char looks like 4 spaces
set.shiftwidth = 4 -- num of spaces when indenting
set.expandtab = true -- pressing tab insert spaces instead of a tab char
set.autoindent = true -- copy indent from curr line when starting new one

-- search settings
set.ignorecase = true
set.smartcase = true -- if you include mixed case in search, assumes you want case-sensitive

-- backspace
set.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
set.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
set.splitright = true -- split vertical window to the right
set.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
set.swapfile = false
