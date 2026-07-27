local M = {}

M.plugins = {
    "stevearc/aerial.nvim",
}

function M.setup()
    require("aerial").setup({
        layout = {
            default_direction = "right",
            default_size = 35,
        },

        attach_mode = "window",
        close_automatic_events = {},

        -- Use LSP when available, otherwise Treesitter
        backends = { "lsp", "treesitter", "markdown", "man" },
    })

    vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle!<CR>", {
        desc = "Toggle Aerial",
    })
end

return M
