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



      dap.adapters.python = {
        type = "executable",
        command = vim.fn.exepath("python"), -- automatically picks your current venv python
        args = { "-m", "debugpy.adapter" },
      }

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          env = { PYTHONPATH = vim.fn.getcwd() },

          pythonPath = function()
            -- 1st priority: active venv
            local venv = os.getenv("VIRTUAL_ENV")
            if venv and #venv > 0 then
              return venv .. "/bin/python"
            end

            -- 2nd: project-level .venv or venv folder
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
              return cwd .. "/.venv/bin/python"
            elseif vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
              return cwd .. "/venv/bin/python"
            end

            -- fallback
            return vim.fn.exepath("python")
          end,
        },
      }






      local dapui = require 'dapui'

      dapui.setup()
      vim.keymap.set('n', '<space>b', dap.toggle_breakpoint)
      vim.keymap.set('n', '<leader>rc', dap.run_to_cursor)

      -- Eval var under cursor
      vim.keymap.set('n', '<space>?', function()
        require('dapui').eval(nil, { enter = true })
      end)

      vim.keymap.set({ 'n', 'i' }, '<F4>', dap.terminate)
      vim.keymap.set({ 'n', 'i' }, '<F5>', dap.continue)
      vim.keymap.set({ 'n', 'i' }, '<F6>', dap.restart)
      vim.keymap.set({ 'n', 'i' }, '<F7>', dap.run_to_cursor)
      vim.keymap.set({ 'n', 'i' }, '<F9>', dap.step_back)
      vim.keymap.set({ 'n', 'i' }, '<F10>', dap.step_over)
      vim.keymap.set({ 'n', 'i' }, '<F11>', dap.step_into)
      vim.keymap.set({ 'n', 'i' }, '<F12>', dap.step_out)

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
