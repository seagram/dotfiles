vim.g.mapleader = " "
vim.g.maplocalleader = " "

local key = vim.keymap

key.set("n", "<C-d>", "<C-d>zz") -- move half page down with screen centering
key.set("n", "<C-u>", "<C-u>zz") -- move half page up with screen centering

key.set("n", "<C-k>", ":m .-2<CR>==") -- move line up
key.set("n", "<C-j>", ":m .+1<CR>==") -- move line down

key.set("n", "<leader>yb", "ggVGy", { desc = "Yank entire buffer" }) -- yank buffer

key.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- clear seach highlights

key.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic Quickfixes" })

key.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
