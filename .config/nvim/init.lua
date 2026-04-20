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
set.laststatus = 0 -- set.statusline = '%=%t %r %m'
set.helpheight = 9999
set.completeopt = "menuone,noselect,fuzzy,nosort"
set.foldmethod = "expr"
set.foldexpr = "v:lua.vim.treesitter.foldexpr()"
set.foldtext = ""
set.foldnestmax = 1
set.foldlevelstart = 99
set.ttimeoutlen = 1

vim.pack.add({
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/folke/flash.nvim" },
    { src = "https://github.com/folke/snacks.nvim" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/nvim-mini/mini.icons" },
    { src = "https://github.com/nvim-mini/mini.comment" },
    { src = "https://github.com/nvim-mini/mini.surround" },
    { src = "https://github.com/nvim-mini/mini.pairs" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-tree/nvim-tree.lua" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
}, { load = true })


require("mason").setup()
require("flash").setup()
require("mini.comment").setup()
require("mini.surround").setup()
require("mini.pairs").setup({ mappings = { ['"'] = false, ["'"] = false, ['`'] = false, }, })
require('mini.icons').mock_nvim_web_devicons()
require("which-key").setup({ preset = "helix", })
vim.cmd.colorscheme("quiet")
vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })

require("oil").setup({
    default_file_explorer = false,
    skip_confirm_for_simple_edits = true,
    keymaps = { ["="] = "actions.close", },
    view_options = { show_hidden = true, },
})

local nvim_tree_api = require("nvim-tree.api")
require("nvim-tree").setup({
    git = { enable = false },
    filters = { dotfiles = false },
    view = { width = 30, side = "right" },
    renderer = { group_empty = true },
    actions = {
        open_file = { quit_on_open = true },
    },
})

require("snacks").setup({
    indent = { indent = { char = "┊" }, animate = { enabled = false }, scope = { enabled = false } },
    notifier = { style = "minimal" },
    zen = { toggles = { dim = false }, show = { statusline = false, tabline = false }, win = { style = "zen", minimal = true, width = 100, wo = { wrap = true, number = false, relativenumber = false, signcolumn = "no", statuscolumn = "", }, }, },
    styles = { input = { width = 40, noautocmd = false }, notification_history = { minimal = true }, },
})

local telescope = require("telescope")
local themes = require("telescope.themes")
local tel_builtin = require("telescope.builtin")
local tel_no_win_titles = { prompt_title = false, results_title = false }
telescope.setup({
    defaults = vim.tbl_deep_extend("force", themes.get_ivy({}), {
        layout_config = { height = 0.25 },
    }, tel_no_win_titles),
    pickers = {
        find_files = vim.tbl_extend("force", {
            preview = false,
            hidden = true,
            cwd = vim.uv.os_homedir(),
            find_command = { "fd", "--type", "f", "--hidden", "--strip-cwd-prefix" },
        }, tel_no_win_titles),
        live_grep = vim.tbl_extend("force", {
            additional_args = function() return { "--hidden" } end,
        }, tel_no_win_titles),
        buffers = vim.tbl_extend("force", {}, tel_no_win_titles),
        spell_suggest = vim.tbl_extend("force", {}, tel_no_win_titles),
        commands = vim.tbl_extend("force", {}, tel_no_win_titles),
        diagnostics = vim.tbl_extend("force", {}, tel_no_win_titles),
    },
})

-- keymaps
local map = vim.keymap.set
map("n", "<leader>f", tel_builtin.find_files, { desc = "files" })
map("n", "<leader>g", tel_builtin.live_grep, { desc = "grep" })
map({ "n", "x", "o" }, "f", function() require("flash").jump() end, { desc = "flash" })
map({ "n", "x", "o" }, "F", function() require("flash").treesitter() end, { desc = "flash text objects" })
map("n", "-", function() require("oil").open() end, { desc = "open oil" })
map("n", "<leader>e", function() nvim_tree_api.tree.toggle({ find_file = true, focus = true }) end, { desc = "tree" })
map("n", "<leader>b", tel_builtin.buffers, { desc = "buffers" })
map("n", "<leader>s", tel_builtin.spell_suggest, { desc = "spell check" })
map("n", "<leader>c", tel_builtin.commands, { desc = "commands" })
map("n", "<leader>d", tel_builtin.diagnostics, { desc = "diagnostics" })
map("n", "<leader>rd", function() vim.fn.jobstart({ "rustup", "doc", "--std" }, { detach = true }) end)
map("n", "<leader><leader>", "<C-^>")
map("n", "<C-l>", "<cmd>tabnext<CR>", { desc = "next tab" })
map("n", "<C-h>", "<cmd>tabprevious<CR>", { desc = "previous tab" })
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
map('n', "<leader>w", "<cmd>write<CR>")
map('n', "<leader>q", "<cmd>quit<CR>")

local sign = "󰝤 "
local vd = vim.diagnostic
local sev = vd.severity
vd.config({ signs = { text = { [sev.ERROR] = sign, [sev.WARN] = sign, [sev.HINT] = sign, [sev.INFO] = sign, }, }, float = { border = "rounded", source = true }, virtual_text = { current_line = true }, })

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local usercmd = vim.api.nvim_create_user_command

-- lsp
autocmd("LspAttach", {
    group = augroup("lsp-attach", { clear = true }),
    callback = function(event)
        local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
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
        map("<leader>d", vim.diagnostic.open_float, "diagnostic")

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

-- vim.cmd('syntax off')
local treesitter_grammars = { "typst", "rust", "terraform", "yaml", "xml", "zsh" }
autocmd("FileType", {
    group = augroup("treesitter-start", { clear = true }),
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})

usercmd("TSInstallAll", function()
    require("nvim-treesitter").install(treesitter_grammars)
end, {})

usercmd("TSUninstallAll", function()
    local ts, i = require("nvim-treesitter"), require("nvim-treesitter").get_installed()
    if #i == 0 then return vim.notify("err: no grammars installed", vim.log.levels.INFO) end
    ts.uninstall(i, { summary = true })
end, {})

local installed_pack_names = function()
    local p = vim.iter(vim.pack.get()):map(function(x) return x.spec.name end):totable()
    if #p == 0 then return vim.notify("err: no plugins installed", vim.log.levels.INFO) end
    return p
end

usercmd("PackUpdateAll", function()
    local p = installed_pack_names()
    if not p then return end
    vim.pack.update(p, { force = true })
end, {})

usercmd("PackUninstallAll", function()
    local p = installed_pack_names()
    if not p then return end
    vim.pack.del(p, { force = true })
    vim.cmd("qa!")
end, {})

local mason_lsps = { "lua-language-server", "rust-analyzer", "terraform-ls", "tinymist", "clangd" }
local nvim_lsps = { "lua_ls", "rust_analyzer", "terraformls", "tinymist", "clangd" }
usercmd("MasonInstallAll", function()
    vim.cmd("MasonInstall " .. table.concat(mason_lsps, " "))
end, {})

vim.lsp.config("lua_ls", {
    settings = { Lua = { runtime = { version = "LuaJIT" }, workspace = { library = { vim.env.VIMRUNTIME } }, }, },
})

vim.lsp.enable(nvim_lsps)
vim.lsp.document_color.enable()

vim.pack.add({ { src = "https://github.com/chomosuke/typst-preview.nvim" }, }, { load = function() end })
autocmd("FileType", {
    pattern = "typst",
    once = true,
    callback = function()
        vim.cmd.packadd("typst-preview.nvim")
        require("typst-preview").setup()
    end
})
vim.filetype.add({ extension = { fountain = "fountain" } })
autocmd("FileType", {
    pattern = { "markdown", "typst", "fountain" },
    callback = function()
        local loc = vim.opt_local
        loc.textwidth = vim.o.columns
        loc.spell = true
        loc.spelllang = "en"
        vim.keymap.set("n", "<leader>z", function() Snacks.zen() end, { buffer = true, desc = "toggle zen mode" })
    end,
})
