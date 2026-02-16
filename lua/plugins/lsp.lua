return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- ------------------------------------------------------------------
        -- Global capabilities override
        -- ------------------------------------------------------------------
        ["*"] = {
          capabilities = {
            general = {
              positionEncodings = { "utf-16" },
            },
          },
        },

        -- ------------------------------------------------------------------
        -- C / C++ (clangd) – formatting handled by conform/clang-format
        -- ------------------------------------------------------------------
        clangd = {
          on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },

        -- ------------------------------------------------------------------
        -- Python
        -- ------------------------------------------------------------------

        -- Disable pylsp completely (major source of duplicate diagnostics)
        pylsp = { enabled = false },

        -- Ruff LSP = lint diagnostics + quickfixes
        ruff = {},
      },
    },
  },
}
