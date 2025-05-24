print("Neovim configuration loaded in VSCode")
--
-- highlight yanked text for half a second
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
    end,
})


local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- remap leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- yank to system clipboard
keymap({"n", "v"}, "<leader>y", '"+y', opts)

-- paste from system clipboard
keymap({"n", "v"}, "<leader>p", '"+p', opts)

-- better indent handling
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- move text up and down
keymap("v", "J", ":m .+1<CR>==", opts)
keymap("v", "K", ":m .-2<CR>==", opts)

-- removes highlighting after escaping vim search
keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)

keymap({"n", "v"}, "<leader>b", "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>")
keymap({"n", "v"}, "<leader>d", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")
keymap({"n", "v"}, "<leader>a", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")
keymap({"n", "v"}, "<leader>sp", "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>")


-- navigate between tabs
keymap("n", "<leader>h", "<cmd>lua require('vscode').action('workbench.action.previousEditor')<CR>", opts)
keymap("n", "<leader>l", "<cmd>lua require('vscode').action('workbench.action.nextEditor')<CR>", opts)




-- fold unfold code
keymap("n", "<leader>f", "<cmd>lua require('vscode').action('editor.fold')<CR>", opts)
keymap("n", "<leader>u", "<cmd>lua require('vscode').action('editor.unfold')<CR>", opts)




-- move text up and down
keymap("n", "K", ":m .-2<CR>==", opts)
keymap("n", "J", ":m .+1<CR>==", opts)

keymap("v", "K", ":m '<-2<CR>gv==gv", opts)
keymap("v", "J", ":m '>+1<CR>gv==gv", opts)

keymap({"n", "v"}, "L", "$", opts)
keymap({"n", "v"}, "H", "^", opts)


-- change sidebar width
keymap("n", "<leader>-", "<cmd>lua require('vscode').action('workbench.action.increaseViewSize')<CR>", opts)
keymap("n", "<leader>+", "<cmd>lua require('vscode' ).action('workbench.action.decreaseViewSize')<CR>", opts)

-- Map [c to navigate to the previous Git diff
keymap("n", "[c", "<cmd>lua require('vscode').action('workbench.action.compareEditor.previousChange')<CR>", opts)

-- Map ]c to navigate to the next Git diff
keymap("n", "]c", "<cmd>lua require('vscode').action('workbench.action.compareEditor.nextChange' )<CR>", opts)

-- Split left
keymap("n", "<C-h>", "<cmd>lua require('vscode').action('workbench.action.splitEditorLeft')<CR>", opts)
-- Split down
keymap("n", "<C-j>", "<cmd>lua require('vscode').action('workbench.action.splitEditorDown' )<CR>", opts)
-- Split up
keymap("n", "<C-k>", "<cmd>lua require('vscode').action('workbench.action.splitEditorUp')<CR>", opts)
-- Split right
keymap("n", "<C-1>", "<cmd>lua require('vscode' ).action('workbench.action.splitEditorRight')<CR>", opts)


-- Focus left editor group
-- keymap("n", "<leader>h", "<cmd>lua require('vscode' ).action('workbench.action.focusLeftGroup' )<CR>",

-- Focus down editor group
keymap("n", "<leader>j", "<cmd>lua require('vscode'). action('workbench.action.focusBelowGroup' )<CR>", opts)

-- Focus up editor group
keymap("n", "<leader>k", "<cmd>lua require('vscode').action('workbench.action.focusAboveGroup' )<CR>", opts)

-- Focus right editor group
-- keymap("n", "<leader>1", "<cmd>lua require('vscode' ).action('workbench.action. focusRightGroup')<CR>",opts)


