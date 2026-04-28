local M = {}

M.plugins = {
  "lewis6991/gitsigns.nvim",
}

function M.setup()
  require("gitsigns").setup {
    signs = {
      delete = { text = "󰍵" },
      changedelete = { text = "󱕖" },
    },
  }
end

return M
