vim.g.mapleader = " "
vim.g.maplocalleader = " "

local key = vim.keymap

-- Remap half page navigation to include screen centering
key.set("n", "<C-d>", "<C-d>zz")
key.set("n", "<C-u>", "<C-u>zz")

key.set("n", "<C-k>", ":m .-2<CR>==") -- move line up
key.set("n", "<C-j>", ":m .+1<CR>==") -- move line down

-- Copy entire buffer
key.set("n", "<leader>cc", "ggVGy", { desc = "Yank entire buffer" })

-- Clear search highlights with <Esc>
key.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Open Quickfix Diagnostic Panel
key.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit Terminal Mode
key.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
