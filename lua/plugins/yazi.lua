local M = {}

M.plugins = {
    "mikavilpas/yazi.nvim",
    "folke/snacks.nvim",
}

function M.setup()
    local function set_yazi_highlights()
        vim.api.nvim_set_hl(0, "YaziFloat", { bg = "#1e2030" })
        vim.api.nvim_set_hl(0, "YaziFloatBorder", { bg = "#1e2030", fg = "#7aa2f7" })
    end

    -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
    -- vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_yazi_highlights,
    })

    set_yazi_highlights()

    require("yazi").setup({
        open_for_directories = false,
        keymaps = {
            show_help = "<f1>",
            close = { "<Esc>", "q", "<c-n>" },
        },
        yazi_floating_window_winblend = 0,
    })
end

return M
