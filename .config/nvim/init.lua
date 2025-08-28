local global = vim.g
global.mapleader = " "
global.have_nerd_font = true

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
set.statusline = ' %t %r %m'

vim.pack.add({
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/echasnovski/mini.comment" },
    { src = "https://github.com/echasnovski/mini.pairs" },
    { src = "https://github.com/echasnovski/mini.icons" },
    { src = "https://github.com/echasnovski/mini.surround" },
    { src = "https://github.com/folke/flash.nvim" },
    { src = "https://github.com/folke/snacks.nvim" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/leath-dub/snipe.nvim" },
    {
        src = "https://github.com/Saghen/blink.cmp",
        version = "v1.6.0"
    },
}, { load = true })

require "vague".setup({ transparent = true, italic = false })
vim.cmd("colorscheme vague")
require("mason").setup({})
require("mini.comment").setup({})
require("mini.pairs").setup({ mappings = { ['"'] = false, ["'"] = false, ['`'] = false } })
require("mini.surround").setup({})
require("mini.icons").setup({})
require('mini.icons').mock_nvim_web_devicons()
require("nvim-treesitter").setup({})
require("which-key").setup({})
require("snipe").setup({
    ui = { position = "bottomleft", open_win_override = { title = "", }, },
    navigate = { cancel_snipe = "q" },
})
require("flash").setup({})

set.completeopt = "noselect"
require("blink.cmp").setup({
    keymap = {
        preset = "enter",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
    },
    enabled = function()
        return not vim.tbl_contains({ "fountain", "markdown" }, vim.bo.filetype)
    end,
})

require("oil").setup({ skip_confirm_for_simple_edits = true, view_options = { show_hidden = true, } })


require("snacks").setup({
    picker = {
        layout = { preset = "ivy", preview = false },
        layouts = { ivy = { layout = { height = 0.3, title = "", }, }, },
        sources = {
            files = { cmd = "fd", hidden = true, ignored = false, },
            explorer = { git_status = false, layout = { layout = { position = "right" }, }, },
        },
    },
    indent = { indent = { char = "┊" }, animate = { enabled = false }, scope = { enabled = false } },
    notifier = { style = "minimal" },
    styles = { input = { width = 40, noautocmd = false }, notification_history = { minimal = true }, },
})

local map = vim.keymap.set

map("n", "-", function() Snacks.picker.explorer() end, { desc = "tree" })
map("n", "<leader>s", function() require("snipe").open_buffer_menu() end, { desc = "tree" })
map("n", "<leader>fr", function() Snacks.picker.smart() end, { desc = "files" })
map("n", "<leader>fg", function() Snacks.picker.grep({ cwd = "." }) end, { desc = "grep" })
map("n", "<leader>fe", function() Snacks.picker.diagnostics() end, { desc = "errors" })
map("n", "<leader>fn", function() Snacks.picker.notifications() end, { desc = "notifications" })
map({ "n", "x", "o" }, "f", function() require("flash").jump() end, { desc = "flash" })
map({ "n", "x", "o" }, "F", function() require("flash").treesitter() end, { desc = "flash text objects" })

map("n", "<leader><leader>", "<C-^>")
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
map("n", "<leader>u", function() vim.pack.update() end)

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
        map("<leader>lH", "<cmd>:checkhealth lsp<CR>", "lsp health")
    end,
})


autocmd("LspAttach", {
    group = augroup("lsp", { clear = true }),
    callback = function(args)
        autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
                vim.lsp.buf.format { async = false, id = args.data.client_id }
            end,
        })
    end
})

vim.lsp.enable({ "bashls", "gopls", "lua_ls", "terraformls", "ty", "tsgo" })

autocmd("FileType", {
    pattern = "snacks_picker",
    callback = function()
        require("blink.cmp").setup_buffer({ enabled = false })
    end,
})
