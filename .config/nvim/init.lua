local global = vim.g
global.mapleader = " "
global.have_nerd_font = true
global.loaded_netrw = 1
global.loaded_netrwPlugin = 1

local set = vim.opt
set.clipboard = "unnamedplus"
set.number = true
set.relativenumber = true
set.fillchars = { eob = " " }
set.scrolloff = 8
set.pumheight = 5
set.cmdheight = 0
set.winborder = "rounded"
set.tabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.smartindent = true
set.ignorecase = true
set.smartcase = true
set.hlsearch = false
set.swapfile = false
set.undofile = true
set.wrap = false
set.confirm = true
set.statusline = '%=%t %r %m'
set.helpheight = 9999
set.termguicolors = true

vim.pack.add({
    { src = "https://github.com/folke/flash.nvim" },
    { src = "https://github.com/folke/snacks.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/leath-dub/snipe.nvim" },
    { src = "https://github.com/nvim-mini/mini.icons" },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = "https://github.com/nvim-mini/mini.comment" },
    { src = "https://github.com/vimpostor/vim-tpipeline" },
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/nvim-mini/mini.surround" },
    { src = "https://github.com/chomosuke/typst-preview.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/Saghen/blink.cmp",                version = "v1.8.0" },
}, { load = true })

require "vague".setup({ transparent = true, italic = false })
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")
require("mason").setup()
require("mini.comment").setup()
require("mini.surround").setup()
require('mini.icons').mock_nvim_web_devicons()
require("which-key").setup({ preset = "helix", })
require("typst-preview").setup()
require("nvim-treesitter").setup()
require("flash").setup()

require("snipe").setup({
    ui = { position = "bottomleft", open_win_override = { title = "", }, },
    navigate = { cancel_snipe = "q" },
})

require("oil").setup({
    skip_confirm_for_simple_edits = true,
    view_options = { show_hidden = true, },
})

set.completeopt = "menuone,noselect,fuzzy,nosort"
require("blink.cmp").setup({
    keymap = {
        preset = "enter",
        ['<Tab>'] = { "accept" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
    },
    enabled = function()
        return not vim.tbl_contains({ "fountain", "markdown", "typst" }, vim.bo.filetype)
    end,
})

require("snacks").setup({
    picker = {
        layout = { preset = "ivy", preview = false },
        layouts = { ivy = { layout = { height = 0.3, title = "", }, }, },
        sources = {
            files = { cmd = "fd", hidden = true, ignored = false, },
        },
    },
    indent = { indent = { char = "┊" }, animate = { enabled = false }, scope = { enabled = false } },
    notifier = { style = "minimal" },
    styles = { input = { width = 40, noautocmd = false }, notification_history = { minimal = true }, },
})

local map = vim.keymap.set

-- find
map("n", "<leader>fr", function() Snacks.picker.smart() end, { desc = "files" })
map("n", "<leader>fe", function() Snacks.picker.files({ cwd = "." }) end, { desc = "cwd" })
map("n", "<leader>fg", function() Snacks.picker.grep({ cwd = "." }) end, { desc = "grep" })
map("n", "<leader>fd", function() Snacks.picker.zoxide() end, { desc = "cd" })

-- flash
map({ "n", "x", "o" }, "f", function() require("flash").jump() end, { desc = "flash" })
map({ "n", "x", "o" }, "F", function() require("flash").treesitter() end, { desc = "flash text objects" })

-- oil
map("n", "<leader>e", ":Oil<CR>", { desc = "toggle oil" })

-- buffers
map("n", "<leader><leader>", "<C-^>")
map("n", "<leader>s", function() require("snipe").open_buffer_menu() end, { desc = "buffers" })

-- vim.pack
map("n", "<leader>u", function() vim.pack.update() end, { desc = "update" })

-- general
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "<C-k>", ":m .-2<CR>==")
map("n", "<C-j>", ":m .+1<CR>==")
map("n", "yb", "ggVGy")
map("n", "db", "ggVGd")
map("v", "<C-j>", ":m '>+1<CR>gv=gv")
map("v", "<C-k>", ":m '<-2<CR>gv=gv")
map("v", "<", "<gv")
map("v", ">", ">gv")
map('n', "<leader>w", ":write<CR>")
map('n', "<leader>q", ":quit<CR>")

vim.lsp.document_color.enable()

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰝤 ",
            [vim.diagnostic.severity.WARN] = "󰝤 ",
            [vim.diagnostic.severity.HINT] = "󰝤 ",
            [vim.diagnostic.severity.INFO] = "󰝤 ",
        },
    },
    float = { border = "rounded", source = true, },
    virtual_text = { current_line = true, },
})

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd("LspAttach", {
    group = augroup("lsp-attach", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
        end
        map("<leader>lh", vim.lsp.buf.hover, "hover")
        map("<leader>ls", vim.lsp.buf.signature_help, "signature")
        map("<leader>ld", vim.lsp.buf.declaration, "declaration")
        map("<leader>lD", vim.lsp.buf.definition, "definition")
        map("<leader>lt", vim.lsp.buf.type_definition, "type definition")
        map("<leader>la", vim.lsp.buf.code_action, "code action")
        map("<leader>li", vim.lsp.buf.implementation, "implementation")
        map("<leader>lR", vim.lsp.buf.references, "references")
        map("<leader>lr", vim.lsp.buf.rename, "rename")
        map("<leader>lf", vim.lsp.buf.format, "format")
        map("<leader>d", vim.diagnostic.open_float, "diagnostic")
        map("<leader>lH", "<cmd>:checkhealth lsp<CR>", "health")
    end,
})

-- format on save
autocmd("LspAttach", {
    group = augroup("lsp-format", {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if not client:supports_method("textDocument/willSaveWaitUntil")
            and client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("lsp-format", { clear = false }),
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, timeout_ms = 1000 })
                end,
            })
        end
    end,
})

vim.lsp.enable({
    "lua_ls",
    "ty",
    "ruff",
    "terraformls",
    "tinymist",
    "rust_analyzer"
})

-- toggle word wrap
autocmd("FileType", {
    pattern = { "markdown", "tyspt" },
    callback = function()
        vim.opt_local.textwidth = 80
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.showbreak = "↪ "
        vim.keymap.set("n", "<leader>w", function()
            vim.opt_local.wrap = not vim.opt_local.wrap:get()
        end, { buffer = true, desc = "toggle word wrap" })
    end,
})

autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.fountain",
    callback = function()
        vim.bo.filetype = "fountain"
    end,
})
