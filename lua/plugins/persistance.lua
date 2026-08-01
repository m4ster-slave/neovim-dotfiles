-- lua/plugins/persistence.lua
local M = {}

M.plugins = {
    "folke/persistence.nvim",
}

function M.setup()
    require("persistence").setup()

    -- auto-restore session when nvim is opened with no file args
    vim.api.nvim_create_autocmd("VimEnter", {
        nested = true,
        callback = function()
            if vim.fn.argc() == 0 then
                require("persistence").load()
            end
        end,
    })

    vim.keymap.set("n", "<leader>qs", function()
        require("persistence").load()
    end, { desc = "Session Restore (cwd)" })
    vim.keymap.set("n", "<leader>ql", function()
        require("persistence").load({ last = true })
    end, { desc = "Session Restore Last" })
    vim.keymap.set("n", "<leader>qd", function()
        require("persistence").stop()
    end, { desc = "Session Don't Save" })
end

return M
