return {
  {
    "oxfist/night-owl.nvim",
    -- "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme night-owl]]
      -- vim.cmd [[colorscheme gruvbox-material]]
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    end,
  },
}
