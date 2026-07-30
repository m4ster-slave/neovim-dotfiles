local M = {}

M.plugins = {
    "m4xshen/hardtime.nvim",
}

function M.setup()
    require("hardtime").setup()
end

return M
