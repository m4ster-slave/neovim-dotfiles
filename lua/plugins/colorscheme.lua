local M = {}

M.plugins = {
    "folke/tokyonight.nvim",
    "oxfist/night-owl.nvim",
    "rose-pine/neovim",
}

function M.setup()
    vim.cmd([[colorscheme rose-pine-moon]])
end

return M
