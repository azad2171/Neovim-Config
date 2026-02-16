return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", desc = "Navigate left" },
    { "<C-j>", "<Cmd>TmuxNavigateDown<CR>", desc = "Navigate down" },
    { "<C-k>", "<Cmd>TmuxNavigateUp<CR>", desc = "Navigate up" },
    { "<C-l>", "<Cmd>TmuxNavigateRight<CR>", desc = "Navigate right" },
    { "<C-\\>", "<Cmd>TmuxNavigatePrevious<CR>", desc = "Navigate previous" },
  },
  config = function()
    -- Optional: disable default mappings if you prefer the ones above
    vim.g.tmux_navigator_no_mappings = 1
  end,
}
