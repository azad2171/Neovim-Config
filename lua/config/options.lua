-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- A TAB character will appear as 4 spaces on screen
opt.tabstop = 4

-- Pressing the TAB key will insert spaces instead of a TAB character
opt.expandtab = true

-- Number of spaces inserted/deleted when indenting
opt.shiftwidth = 4

-- Number of spaces a <Tab> counts for when expandtab is on
opt.softtabstop = 4
vim.o.autochdir = true
