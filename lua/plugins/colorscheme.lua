local M = {}

M.plugins = {
  "folke/tokyonight.nvim",
  "oxfist/night-owl.nvim",
}

function M.setup()
  vim.cmd [[colorscheme tokyonight-moon]]
end

return M
