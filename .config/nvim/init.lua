local global = vim.g
global.mapleader = " "
global.have_nerd_font = true
global.loaded_netrw = 1
global.loaded_netrwPlugin = 1

local set = vim.opt
set.clipboard = "unnamedplus"
set.number = true
set.relativenumber = true
set.fillchars = { eob = " ", vert = " ", horiz = " " }
set.scrolloff = 8
set.pumheight = 5
set.pummaxwidth = 100
set.pumborder = "rounded"
set.cmdheight = 0
set.winborder = "rounded"
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true
set.smartindent = true
set.ignorecase = true
set.smartcase = true
set.swapfile = false
set.undofile = true
set.wrap = false
set.hlsearch = false
set.confirm = true
set.laststatus = 0
set.helpheight = 9999
set.completeopt = "menuone,noselect,fuzzy,nosort"
set.foldmethod = "expr"
set.foldexpr = "v:lua.vim.treesitter.foldexpr()"
set.foldcolumn = "0"
set.foldtext = ""
set.foldlevelstart = 99
set.foldnestmax = 1
set.ttimeoutlen = 1
set.list = true
set.listchars = { leadmultispace = "┊   " }

vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/seagram/mtl.nvim",
    "https://github.com/seagram/pack.nvim",
    "https://github.com/seagram/void.nvim",
    "https://github.com/folke/flash.nvim",
    "https://github.com/folke/which-key.nvim",
    "https://github.com/nvim-mini/mini.icons",
    "https://github.com/nvim-mini/mini.comment",
    "https://github.com/nvim-mini/mini.surround",
    "https://github.com/nvim-mini/mini.pairs",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/nvim-tree/nvim-tree.lua",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/matkrin/telescope-spell-errors.nvim",
    "https://github.com/chomosuke/typst-preview.nvim",
}, { load = true })

vim.cmd.colorscheme("void")

require("mason").setup()
require("flash").setup()
require("mini.comment").setup()
require("mini.surround").setup()
require("mini.pairs").setup({ mappings = { ['"'] = false, ["'"] = false, ['`'] = false, }, })
require('mini.icons').mock_nvim_web_devicons()
require("which-key").setup({ preset = "helix", })
require("typst-preview").setup({ open_cmd = "open -a Helium %s", })

require("mtl").enable({
    haskell = { mason = false }, -- hls installed with ghcup
    typst,
})

require("oil").setup({
    default_file_explorer = false,
    skip_confirm_for_simple_edits = true,
    keymaps = { ["="] = "actions.close", },
    view_options = { show_hidden = true, },
})

local nvim_tree_api = require("nvim-tree.api")
require("nvim-tree").setup({
    git = { enable = false },
    filters = { dotfiles = false, custom = { "^\\.DS_Store$" }, },
    view = { width = 30, side = "right" },
    renderer = { group_empty = true },
    actions = { open_file = { quit_on_open = true }, },
})

local telescope = require("telescope")
local tel_builtin = require("telescope.builtin")
local hide_titles = { prompt_title = false, results_title = false, preview_title = false }
local home = vim.fn.expand("~")
local path_display_tilde = function(_, path) return path:sub(1, #home) == home and "~" .. path:sub(#home + 1) or path end
telescope.load_extension("spell_errors")
telescope.setup({
    defaults = {
        prompt_prefix = " ", selection_caret = " ",
        layout_strategy = "horizontal", sorting_strategy = "descending",
        layout_config = { width = 0.7, height = 0.7, preview_width = 0.55 },
    },
    pickers = {
        find_files = vim.tbl_extend("force", hide_titles, {
            path_display = path_display_tilde,
            find_command = { "fd", "--type", "f", "--color", "never" },
        }),
        buffers = hide_titles,
        diagnostics = hide_titles,
        commands = vim.tbl_extend("force", {
            entry_maker = function(entry) return { value = entry, ordinal = entry.name, display = entry.name } end,
        }, hide_titles),
    },
})

local map = vim.keymap.set
map("n", "<leader>f", function()
    local roots = {}
    for line in io.lines(vim.fn.expand("~/.config/fd/roots")) do
        if line:match("%S") and not line:match("^%s*#") then roots[#roots + 1] = vim.fn.expand("~/" .. line) end
    end
    tel_builtin.find_files({ search_dirs = roots, hidden = true })
end, { desc = "files" })
map("n", "<leader>b", tel_builtin.buffers, { desc = "buffers" })
map("n", "<leader>s", function() telescope.extensions.spell_errors.spell_errors(hide_titles) end, { desc = "spelling" })
map("n", "<leader>c", tel_builtin.commands, { desc = "commands" })
map("n", "<leader>d", tel_builtin.diagnostics, { desc = "diagnostics" })
map({ "n", "x", "o" }, "f", function() require("flash").jump() end, { desc = "flash" })
map({ "n", "x", "o" }, "F", function() require("flash").treesitter() end, { desc = "flash text objects" })
map("n", "-", function() require("oil").open() end, { desc = "open oil" })
map("n", "<leader>e", function() nvim_tree_api.tree.toggle({ find_file = true, focus = true }) end, { desc = "tree" })
map('n', "<leader>w", "<cmd>write<CR>", { desc = "write" })
map('n', "<leader>q", "<cmd>quit<CR>", { desc = "quit" })
map("n", "<leader><leader>", "<C-^>", { desc = "last buffer" })
map("n", "<C-l>", "<cmd>tabnext<CR>", { desc = "next tab" })
map("n", "<C-h>", "<cmd>tabprevious<CR>", { desc = "previous tab" })
map("n", "<C-d>", "<C-d>zz", { desc = "scroll down" })
map("n", "<C-u>", "<C-u>zz", { desc = "scroll up" })
map("n", "n", "nzzzv", { desc = "next match" })
map("n", "N", "Nzzzv", { desc = "prev match" })
map("n", "<C-k>", ":m .-2<CR>==", { desc = "move line up" })
map("n", "<C-j>", ":m .+1<CR>==", { desc = "move line down" })
map("n", "yb", "ggVGy", { desc = "yank buffer" })
map("n", "db", "ggVGd", { desc = "delete buffer" })
map("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "move selection down" })
map("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "move selection up" })
map("v", "<", "<gv", { desc = "indent left" })
map("v", ">", ">gv", { desc = "indent right" })

local s = vim.diagnostic.severity
vim.diagnostic.config({
    signs = { text = { [s.ERROR] = "E ", [s.WARN] = "W ", [s.HINT] = "H ", [s.INFO] = "I ", }, },
    float = { border = "rounded", source = true },
    virtual_text = { prefix = "" },
})

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local usercmd = vim.api.nvim_create_user_command

-- lsp
vim.lsp.document_color.enable()
autocmd("LspAttach", {
    group = augroup("lsp-attach", { clear = true }),
    callback = function(event)
        local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
        -- lsp keymaps
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
        end
        map("gh", vim.lsp.buf.hover, "hover")
        map("gs", vim.lsp.buf.signature_help, "signature")
        map("gD", vim.lsp.buf.declaration, "declaration")
        map("gd", vim.lsp.buf.definition, "definition")
        map("gy", vim.lsp.buf.type_definition, "type definition")
        map("ga", vim.lsp.buf.code_action, "code action")
        map("gi", vim.lsp.buf.implementation, "implementation")
        map("gr", vim.lsp.buf.references, "references")
        map("gR", vim.lsp.buf.rename, "rename")
        map("gF", vim.lsp.buf.format, "format")
        map("gf", vim.diagnostic.open_float, "diagnostic")

        -- native completion
        if client:supports_method("textDocument/completion")
            and not vim.tbl_contains({ "fountain", "markdown", "typst" }, vim.bo[event.buf].filetype) then
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
            local function pum_map(lhs, when_visible, when_hidden, desc)
                vim.keymap.set("i", lhs, function()
                    return vim.fn.pumvisible() == 1 and when_visible or when_hidden
                end, { expr = true, buffer = event.buf, desc = desc })
            end
            pum_map("<C-j>", "<C-n>", "<C-j>", "next completion")
            pum_map("<C-k>", "<C-p>", "<C-k>", "prev completion")
            pum_map("<Tab>", "<C-y>", "<Tab>", "accept completion")
            pum_map("<Esc>", "<C-e><Esc>", "<Esc>", "cancel completion")
        end

        -- format on save
        if not client:supports_method("textDocument/willSaveWaitUntil")
            and client:supports_method("textDocument/formatting") then
            autocmd("BufWritePre", {
                group = augroup("lsp-format", { clear = false }),
                buffer = event.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = event.buf, timeout_ms = 1000 })
                end,
            })
        end
    end,
})
