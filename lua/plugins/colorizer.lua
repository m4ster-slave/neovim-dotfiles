local M = {}

M.plugins = {
  -- Replaced norcalli/nvim-colorizer.lua (archived) with maintained fork.
  "NvChad/nvim-colorizer.lua",
}

function M.setup()
  vim.opt.termguicolors = true
  require("colorizer").setup({ "*", css = { rgb_fn = true } })
end

return M
