local M = {}

M.plugins = {
    "nvim-tree/nvim-web-devicons",
}

function M.setup()
    require("nvim-web-devicons").setup()
end

return M
