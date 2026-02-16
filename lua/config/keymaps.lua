-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- For conciseness
local opts = { noremap = true, silent = true }

-- move text up and down
vim.keymap.set("n", "J", ":m .+1<CR>==", opts)
vim.keymap.set("n", "K", ":m .-2<CR>==", opts)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

vim.keymap.set({ "n", "v" }, "L", "$", opts)
vim.keymap.set({ "n", "v" }, "H", "^", opts)

vim.keymap.set("n", "<M-l>", ":bnext<CR>", opts)
vim.keymap.set("n", "<M-h>", ":bprevious<CR>", opts)
