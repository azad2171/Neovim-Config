return {
  "luukvbaal/statuscol.nvim",
  config = function()
    -- Custom function to show both absolute and relative line numbers
    local function lnum_both()
      local lnum = vim.v.lnum
      local relnum = vim.v.lnum == vim.fn.line(".") and 0 or math.abs(vim.v.lnum - vim.fn.line("."))
      return string.format("%3d %2d", lnum, relnum)
    end
    require("statuscol").setup({
      setopt = true,
      segments = {
        -- Diagnostics first
        {
          sign = {
            namespace = { ".*" },
            name = { ".*" },
            -- maxwidth = 2,
            auto = true,
          },
        },
        -- Line number
        {
          text = { lnum_both, " " },
          condition = { true },
          click = "v:lua.ScLa",
        },
        -- Git signs last
        {
          sign = {
            namespace = { "gitsigns.*" },
            name = { "gitsigns.*" },
          },
        },
      },
    })
  end,
}
