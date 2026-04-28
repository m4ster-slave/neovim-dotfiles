local M = {}

M.plugins = {
    "folke/which-key.nvim",
}

function M.setup()
    require("which-key").setup({
        plugins = { spelling = true },
        win = { border = "single" },
    })
end

return M
