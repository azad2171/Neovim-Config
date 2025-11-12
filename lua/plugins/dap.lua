return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
      'nvim-neotest/nvim-nio',
      'mfussenegger/nvim-dap-python',
    },

    config = function()
      require('mason').setup()
      require('mason-nvim-dap').setup {
        ensure_installed = { 'cppdbg', 'python' }, -- Microsoft C++ debugger
        automatic_installation = true,
      }

      local dap = require 'dap'

      dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = vim.fn.stdpath 'data' .. '/mason/bin/OpenDebugAD7',
      }

      dap.configurations.cpp = {
        {
          name = 'Launch file',
          type = 'cppdbg',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopAtEntry = false,
          setupCommands = {
            {
              description = 'Enable pretty printing',
              text = '-enable-pretty-printing',
              ignoreFailures = false,
            },
          },
        },
      }

      dap.configurations.c = dap.configurations.cpp

      -- Python setup
      local dap_python = require 'dap-python'
      dap_python.setup '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'

      local dapui = require 'dapui'

      dapui.setup()
      vim.keymap.set('n', '<space>b', dap.toggle_breakpoint)
      vim.keymap.set('n', '<leader>rc', dap.run_to_cursor)

      -- Eval var under cursor
      vim.keymap.set('n', '<space>?', function()
        require('dapui').eval(nil, { enter = true })
      end)

      vim.keymap.set({ 'n', 'i' }, '<F5>', dap.continue)
      vim.keymap.set({ 'n', 'i' }, '<F11>', dap.step_into)
      vim.keymap.set({ 'n', 'i' }, '<F10>', dap.step_over)
      vim.keymap.set({ 'n', 'i' }, '<S-F11>', dap.step_out)
      vim.keymap.set({ 'n', 'i' }, '<F9>', dap.step_back)
      vim.keymap.set({ 'n', 'i' }, '<C-S-F5>', dap.restart)

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
}
