-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Helper: choose command (avoid nesting tmux if already inside tmux)
local function tmux_cmd(name)
  if os.getenv 'TMUX' then
    -- already inside tmux; just use your shell to avoid nesting
    return vim.o.shell
  else
    return string.format('tmux new-session -A -s %s', name)
  end
end

-- ===== Horizontal terminal (Alt-h) =====
local term_buf_h, term_win_h

vim.keymap.set('n', '<A-h>', function()
  -- If window is open, close it (buffer stays alive)
  if term_win_h and vim.api.nvim_win_is_valid(term_win_h) then
    vim.api.nvim_win_close(term_win_h, true)
    term_win_h = nil
    return
  end

  -- Open a horizontal split
  vim.cmd 'belowright split'
  term_win_h = vim.api.nvim_get_current_win()

  -- Create the buffer once and keep it hidden when the window closes
  if not term_buf_h or not vim.api.nvim_buf_is_valid(term_buf_h) then
    term_buf_h = vim.api.nvim_create_buf(false, true) -- unlisted, scratch
    vim.api.nvim_buf_set_option(term_buf_h, 'bufhidden', 'hide')
    vim.api.nvim_win_set_buf(term_win_h, term_buf_h) -- put it in the window
    vim.fn.termopen(tmux_cmd 'nvim_h') -- start tmux in THIS buffer
  else
    -- Reuse existing terminal buffer
    vim.api.nvim_win_set_buf(term_win_h, term_buf_h)
  end

  vim.cmd 'startinsert'
end, { desc = 'Toggle horizontal terminal (tmux nvim_h)' })

-- ===== Vertical terminal (Alt-v) =====
local term_buf_v, term_win_v

vim.keymap.set('n', '<A-v>', function()
  if term_win_v and vim.api.nvim_win_is_valid(term_win_v) then
    vim.api.nvim_win_close(term_win_v, true)
    term_win_v = nil
    return
  end

  vim.cmd 'vsplit'
  term_win_v = vim.api.nvim_get_current_win()

  if not term_buf_v or not vim.api.nvim_buf_is_valid(term_buf_v) then
    term_buf_v = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(term_buf_v, 'bufhidden', 'hide')
    vim.api.nvim_win_set_buf(term_win_v, term_buf_v)
    vim.fn.termopen(tmux_cmd 'nvim_v')
  else
    vim.api.nvim_win_set_buf(term_win_v, term_buf_v)
  end

  vim.cmd 'startinsert'
end, { desc = 'Toggle vertical terminal (tmux nvim_v)' })

-- Clean and then build
vim.keymap.set('n', '<leader>mb', ':!make clean && make<CR>', { desc = 'Clean & Build', silent = true })

-- Run executable
vim.keymap.set('n', '<leader>mr', ':!./build/app<CR>', { desc = 'Run executable', silent = true })

-- Clean, Build and Run
vim.keymap.set('n', '<leader>ma', ':!make clean && make && ./build/app<CR>', { desc = 'Clean, Build & Run', silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

-- move text up and down
vim.keymap.set('n', 'J', ':m .+1<CR>==', opts)
vim.keymap.set('n', 'K', ':m .-2<CR>==', opts)

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts)

vim.keymap.set({ 'n', 'v' }, 'L', '$', opts)
vim.keymap.set({ 'n', 'v' }, 'H', '^', opts)

vim.keymap.set('v', '"', 'c"<C-r>""<Esc>', opts)
vim.keymap.set('v', "'", "c'<C-r>\"'<Esc>", opts)
vim.keymap.set('v', '(', 'c(<C-r>")<Esc>', opts)
vim.keymap.set('v', '[', 'c[<C-r>"]<Esc>', opts)
vim.keymap.set('v', '{', 'c{<C-r>"}<Esc>', opts)

------------------------------------------- above this is my setup -------------------------------------------
--
-- Close terminal with Alt-h or Alt-v from terminal mode
vim.keymap.set('t', '<A-h>', [[<C-\><C-n>:q<CR>]], { desc = 'Close terminal (horizontal)', noremap = true })
vim.keymap.set('t', '<A-v>', [[<C-\><C-n>:q<CR>]], { desc = 'Close terminal (vertical)', noremap = true })

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- save file
vim.keymap.set({'n', 'i'}, '<C-s>', '<cmd>noautocmd w <CR>', opts)

-- save file with auto-formatting
vim.keymap.set('n', '<leader>sn', '<cmd> w <CR>', opts)

-- quit file
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- Resize with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>x', ':bp | bd #<CR>', opts)
-- vim.keymap.set('n', '<leader>x', ':q<CR>', opts) -- close buffer
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', opts) -- split window vertically
vim.keymap.set('n', '<leader>h', '<C-w>s', opts) -- split window horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- make split windows equal width & height
vim.keymap.set('n', '<leader>xs', ':close<CR>', opts) -- close current split window

-- Navigate between splits
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts) -- open new tab
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts) --  go to next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous diagnostic message' })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next diagnostic message' })

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Ctrl+Backspace to delete previous word in insert mode
vim.keymap.set("i", "<C-H>", "<C-w>", { noremap = true })
-- Ctrl+V to paste from system clipboard in insert mode
vim.keymap.set({"i", "n"}, "<C-v>", "<C-r>+", { noremap = true, silent = true })


-- -- For init.lua
vim.g.tmux_navigator_no_mappings = 1

vim.keymap.set('n', '<C-h>', ':TmuxNavigateLeft<CR>', { silent = true })
vim.keymap.set('n', '<C-j>', ':TmuxNavigateDown<CR>', { silent = true })
vim.keymap.set('n', '<C-k>', ':TmuxNavigateUp<CR>', { silent = true })
vim.keymap.set('n', '<C-l>', ':TmuxNavigateRight<CR>', { silent = true })


