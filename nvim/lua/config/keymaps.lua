vim.g.mapleader = " "
vim.g.maplocalleader = " "
local key = vim.keymap

key.set("n", "<C-d>", "<C-d>zz", { desc = "Move half page down with screen centering" })
key.set("n", "<C-u>", "<C-u>zz", { desc = "Move half page up with screen centering" })

key.set("n", "n", "nzzzv", { desc = "Next search result with screen centering" })
key.set("n", "N", "Nzzzv", { desc = "Previous search result with screen centering" })

key.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up" })
key.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down" })

key.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
key.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

key.set("v", "<", "<gv", { desc = "Indent left and reselect" })
key.set("v", ">", ">gv", { desc = "Indent right and reselect" })

key.set("n", "<leader>yb", "ggVGy", { desc = "Yank entire buffer" })

key.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

key.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic Quickfixes" })

key.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

key.set("n", "<leader>q", ":wq<CR>", { desc = "Write and quit" })

vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>', { desc = "Disable left arrow key" })
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>', { desc = "Disable right arrow key" })
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>', { desc = "Disable up arrow key" })
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>', { desc = "Disable down arrow key" })
