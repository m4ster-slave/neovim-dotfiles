local M = {}

M.plugins = {
    "chomosuke/typst-preview.nvim",
}

function M.setup()
    require("typst-preview").setup({})
end

return M
