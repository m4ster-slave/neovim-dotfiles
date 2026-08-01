local M = {}

M.plugins = {
    "folke/snacks.nvim",
}

function M.setup()
    require("snacks").setup({
        bigfile = { enabled = true }, -- disables treesitter/lsp on huge files so nvim doesn't choke
        notifier = { enabled = true }, -- replaces vim.notify with a proper toast UI
        quickfile = { enabled = true }, -- renders file content before plugins finish loading
        words = { enabled = true }, -- auto-highlight + jump between refs of word under cursor
        zen = { enabled = true },
        scroll = { enabled = true },
        indent = { enabled = true },
    })

    vim.keymap.set("n", "<leader>z", function()
        require("snacks").zen()
    end, { desc = "Zen mode" })
    vim.keymap.set({ "n", "v" }, "]]", function()
        require("snacks").words.jump(1)
    end, { desc = "Next reference" })
    vim.keymap.set({ "n", "v" }, "[[", function()
        require("snacks").words.jump(-1)
    end, { desc = "Prev reference" })
end

return M
