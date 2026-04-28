local M = {}

M.plugins = {
    { repo = "chomosuke/typst-preview.nvim", version = "v1.4.2" },
}

function M.setup()
    require("typst-preview").setup({})
end

return M
