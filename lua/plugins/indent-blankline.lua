return {
  "lukas-reineke/indent-blankline.nvim",
  event = "User FilePost",
  opts = {
    indent = { char = "│", },
    scope = { char = "│", },
  },
  config = function(_, opts)
    local hooks = require "ibl.hooks"
    hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)

    -- Function to disable indent-blankline for dashboard
    local disable_indent_in_dashboard = function()
      local buftype = vim.bo.buftype
      local filetype = vim.bo.filetype
      if filetype == "dashboard" then
        vim.b.indent_blankline_enabled = false
      end
    end

    -- Set autocommand to disable indent-blankline for dashboard
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dashboard",
      callback = disable_indent_in_dashboard,
    })

    require("ibl").setup(opts)
  end,
}
