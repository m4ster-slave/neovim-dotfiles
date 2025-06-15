return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = {
    -- https://github.com/folke/snacks.nvim
    "folke/snacks.nvim",
  },

  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = false,
    keymaps = {
      show_help = "<f1>",
      close = { "<Esc>", "q", "<c-n>" },
    },

    yazi_floating_window_winblend = 20,
  },
  -- 👇 if you use `open_for_directories=true`, this is recommended
  init = function()
    -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
    -- vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
}
