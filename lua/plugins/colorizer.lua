return {
  -- Replaced norcalli/nvim-colorizer.lua (archived) with maintained fork.
  "NvChad/nvim-colorizer.lua",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.opt.termguicolors = true
    require("colorizer").setup({ "*", css = { rgb_fn = true } })
  end,
}
