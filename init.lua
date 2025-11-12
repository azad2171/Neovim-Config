-- Safe load for core config files
local function safe_require(mod)
  local ok, err = pcall(require, mod)
  if not ok then
    vim.notify('Error loading ' .. mod .. ':\n' .. err, vim.log.levels.ERROR)
  end
end

vim.o.guicursor = table.concat({
  'n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100',
  'i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100',
  'r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100',
}, ',')

-- Core settings
safe_require 'core.options'
safe_require 'core.keymaps'
safe_require 'core.snippets'

-- Set up Lazy plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Let Lazy load plugin specs by name instead of requiring them directly
require('lazy').setup {
  { import = 'plugins.neotree' },
  { import = 'plugins.colortheme' },
  { import = 'plugins.bufferline' },
  { import = 'plugins.lualine' },
  { import = 'plugins.treesitter' },
  { import = 'plugins.telescope' },
  { import = 'plugins.lsp' },
  { import = 'plugins.autocompletion' },
  { import = 'plugins.none-ls' },
  { import = 'plugins.gitsigns' },
  { import = 'plugins.alpha' },
  { import = 'plugins.indent-blankline' },
  { import = 'plugins.misc' },
  { import = 'plugins.comment' },
  { import = 'plugins.copilot' },
  { import = 'plugins.copilot_chat' },
  { import = 'plugins.auto-session' },
  { import = 'plugins.noice' },
  { import = 'plugins.dap' },
}
