return {
  {
    "oxfist/night-owl.nvim",
    -- "sainnhe/gruvbox-material",
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd [[colorscheme night-owl]]
      vim.cmd [[colorscheme tokyonight-moon]]
      -- vim.cmd [[colorscheme gruvbox-material]]
    end,
  },
}
