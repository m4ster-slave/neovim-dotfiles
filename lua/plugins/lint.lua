local M = {}

M.plugins = {
    "mfussenegger/nvim-lint",
}

function M.setup()
    local lint = require("lint")
    local config = vim.fn.stdpath("config") .. "/java-checkstyle.xml"

    lint.linters.checkstyle.args = { "-c", config, "-f", "sarif" }
    lint.linters_by_ft = {
        java = { "checkstyle" },
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        pattern = "*.java",
        callback = function()
            lint.try_lint()
        end,
    })
end

return M
