local M = {}

M.plugins = {
  "lukas-reineke/indent-blankline.nvim",
}

function M.setup()
  local hooks = require "ibl.hooks"
  hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)

  -- Disable indent-blankline for dashboard
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "dashboard",
    callback = function()
      vim.b.indent_blankline_enabled = false
    end,
  })

  require("ibl").setup {
    indent = { char = "│" },
    scope = { char = "│" },
  }
end

return M
