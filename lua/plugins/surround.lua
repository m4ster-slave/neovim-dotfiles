local M = {}

M.plugins = {
    { repo = "kylechui/nvim-surround" },
}

function M.setup()
    require("nvim-surround").setup({})
end

return M
