return {
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = {
    { 'zbirenbaum/copilot.lua' },
    { 'nvim-lua/plenary.nvim' },
  },
  opts = {},
  keys = {
    -- Built-in commands
    { '<leader>ce', '<cmd>CopilotChatExplain<cr>', desc = 'Explain code' },
    { '<leader>cf', '<cmd>CopilotChatFix<cr>', desc = 'Fix code' },
    { '<leader>cr', '<cmd>CopilotChatRefactor<cr>', desc = 'Refactor code' },

    -- Custom prompt (Normal mode)
    {
      '<leader>ci',
      function()
        local input = vim.fn.input 'Ask Copilot: '
        if input ~= '' then
          require('CopilotChat').open { prompt = input }
        end
      end,
      mode = 'n',
      desc = 'Ask Copilot (Normal mode)',
    },

    -- Custom prompt (Visual mode)
    {
      '<leader>ci',
      function()
        local input = vim.fn.input 'Ask Copilot about selection: '
        if input ~= '' then
          local start_pos = vim.fn.getpos "'<"
          local end_pos = vim.fn.getpos "'>"
          require('CopilotChat').open {
            prompt = input,
            selection = {
              start_line = start_pos[2],
              start_col = start_pos[3],
              end_line = end_pos[2],
              end_col = end_pos[3],
            },
          }
        end
      end,
      mode = 'v',
      desc = 'Ask Copilot about selection (Visual mode)',
    },

    -- Toggle Copilot Chat panel (Normal mode only)
    {
      '<leader>cc',
      function()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local name = vim.api.nvim_buf_get_name(buf)
          if name:match 'CopilotChat' then
            vim.api.nvim_win_close(win, true)
            return
          end
        end
        require('CopilotChat').toggle()
      end,
      mode = 'n',
      desc = 'Toggle Copilot Chat panel',
    },

    -- Visual mode: send selection to Copilot
    {
      '<leader>cc',
      function()
        local start_pos = vim.fn.getpos "'<"
        local end_pos = vim.fn.getpos "'>"
        require('CopilotChat').open {
          prompt = 'Please review this code:',
          selection = {
            start_line = start_pos[2],
            start_col = start_pos[3],
            end_line = end_pos[2],
            end_col = end_pos[3],
          },
        }
      end,
      mode = 'v',
      desc = 'Ask Copilot about selection',
    },
  },
}
