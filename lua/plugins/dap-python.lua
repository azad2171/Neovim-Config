return {
  "mfussenegger/nvim-dap-python",
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    local dap_python = require("dap-python")
    local dap = require("dap")

    -- Use active venv if available, otherwise fallback
    dap_python.setup(os.getenv("VIRTUAL_ENV") and os.getenv("VIRTUAL_ENV") .. "/bin/python" or "python")

    -- 🔥 auto-install debugpy into venv if missing
    dap_python.ensure_installed = true

    -- Make output visible + better debugging defaults
    for _, cfg in pairs(dap.configurations.python or {}) do
      cfg.console = "integratedTerminal"
      cfg.justMyCode = false
    end

    vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DapBreakpoint", linehl = "", numhl = "" })

    -- Keymaps (unchanged)
    vim.keymap.set({ "n", "i" }, "<F4>", dap.terminate)
    vim.keymap.set({ "n", "i" }, "<F5>", dap.continue)
    vim.keymap.set({ "n", "i" }, "<F6>", dap.restart)
    vim.keymap.set({ "n", "i" }, "<F7>", dap.run_to_cursor)
    vim.keymap.set({ "n", "i" }, "<F9>", dap.step_back)
    vim.keymap.set({ "n", "i" }, "<F10>", dap.step_over)
    vim.keymap.set({ "n", "i" }, "<F11>", dap.step_into)
    vim.keymap.set({ "n", "i" }, "<F12>", dap.step_out)
  end,
}
