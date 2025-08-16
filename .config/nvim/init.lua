local global = vim.g
global.mapleader = " "
global.maplocalleader = " "
global.have_nerd_font = true

local set = vim.opt
set.clipboard = "unnamedplus"
set.number = true
set.relativenumber = true
set.mouse = "a"
set.termguicolors = true
set.fillchars = { eob = " " }
set.scrolloff = 8
set.pumheight = 5
set.cmdheight = 0
set.winborder = "rounded"
set.autocomplete = true
set.complete = "o,.,w,b,u"
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
set.backup = false
set.writebackup = false
set.swapfile = false
set.undofile = true
set.undodir = vim.fn.expand("~/.vim/undodir")
set.confirm = true
set.wrap = false
vim.cmd.filetype("plugin indent on")
vim.o.statusline = ' %t %r %m'

vim.pack.add({
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/echasnovski/mini.comment" },
    { src = "https://github.com/echasnovski/mini.pairs" },
    { src = "https://github.com/echasnovski/mini.icons" },
    { src = "https://github.com/echasnovski/mini.surround" },
    { src = "https://github.com/echasnovski/mini.pick" },
    { src = "https://github.com/folke/flash.nvim" },
    { src = "https://github.com/mfussenegger/nvim-lint" },
    { src = "https://github.com/folke/snacks.nvim" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" }
}, { load = true })

require "vague".setup({ transparent = true, italic = false })
vim.cmd("colorscheme vague")
require("mason").setup({})
require("mini.comment").setup({})
require("mini.pairs").setup({})
require("mini.surround").setup({})
require("mini.icons").setup({})
require('mini.icons').mock_nvim_web_devicons()
require("mini.pick").setup()
require("oil").setup()
require("which-key").setup({})

require("flash").setup({
    opts = {
        modes = {
            search = {
                enabled = true,
            },
            char = {
                jump_labels = true,
            },
        },
    },
    keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
})

require("lint").linters_by_ft = {
    python = { "ruff" },
}


require("snacks").setup({
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
            -- char = "│",
        },
        animate = {
            enabled = false,
        },
        scope = {
            enabled = false,
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
})
-- local map = vim.map.set


--- keymaps --
local map = vim.keymap.set
local s = { silent = true }
map('n', '<leader>ff', ":Pick files<CR>")
map('n', '<leader>e', ":Oil<CR>")
map('n', '<leader>lf', vim.lsp.buf.format)
-- map("n", "<leader>ff", function() Snacks.picker.files({ cwd = "~/" }) end, { desc = "files" })
map("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "recent" })
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "buffers" })
map("n", "<leader>fg", function() Snacks.picker.grep() end, { desc = "grep" })
map("n", "<leader>fe", function() Snacks.picker.diagnostics() end, { desc = "errors" })
map("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "config" })
map("n", "<leader>fn", function() Snacks.picker.notifications() end, { desc = "notifications" })

map("n", "<C-d>", "<C-d>zz", { desc = "Move half page down with screen centering" })
map("n", "<C-u>", "<C-u>zz", { desc = "Move half page up with screen centering" })
map("n", "n", "nzzzv", { desc = "Next search result with screen centering" })
map("n", "N", "Nzzzv", { desc = "Previous search result with screen centering" })
map("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "yb", "ggVGy", { desc = "Yank entire buffer" })
map("n", "db", "ggVGd", { desc = "Delete entire buffer" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic Quickfixes" })

map("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

--- lsp ---
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    desc = "LSP actions",
    callback = function(event)
        local map = function(keys, func, desc)
            vim.map.set("n", keys, func, { buffer = event.buf, desc = desc })
        end
        map("<leader>lh", vim.lsp.buf.hover, "hover")
        map("<leader>ls", vim.lsp.buf.signature_help, "signature")
        map("<leader>ld", vim.lsp.buf.declaration, "declaration")
        map("<leader>la", vim.lsp.buf.code_action, "code action")
        map("<leader>lr", vim.lsp.buf.rename, "rename")
        map("<leader>lf", vim.lsp.buf.format, "format")
        map("<leader>lH", "<cmd>:checkhealth lsp<cr>", "lsp health")
        map("<leader>lD", vim.lsp.buf.definition, "Goto Definition")
        map("<leader>li", vim.lsp.buf.implementation, "Goto Implementation")
        map("<leader>lt", vim.lsp.buf.type_definition, "Goto Type Definition")
        map("<leader>lR", vim.lsp.buf.references, "References")
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
            vim.opt.completeopt = { "fuzzy", "menuone", "menu", "noselect", "noinsert", "popup", "preview" }
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
            vim.map.set("i", "<C-Space>", function()
                vim.lsp.completion.get()
            end)
        end
    end,
})

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰠠 ",
            [vim.diagnostic.severity.INFO] = " ",
        },
    },
    float = {
        border = "rounded",
        source = true,
    },
    virtual_text = { -- alternative: virtual_lines
        current_line = true,
    },
})

vim.lsp.enable({
    "bashls", "gopls", "lua_ls", "postgres_lsp", "ruff", "terraformls", "ty"
})
