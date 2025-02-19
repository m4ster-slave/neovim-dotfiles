return {
  "lewis6991/gitsigns.nvim",
  event = "User FilePost",
  opts = function()
    local opts = {
      signs = {
        delete = { text = "󰍵" },
        changedelete = { text = "󱕖" },
      },
    }

    return opts
  end,
}
