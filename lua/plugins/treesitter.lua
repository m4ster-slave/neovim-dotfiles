local M = {}

M.plugins = {
    { repo = "nvim-treesitter/nvim-treesitter", branch = "main" },
}

function M.setup()
    vim.cmd("packadd nvim-treesitter")
    local ok, treesitter = pcall(require, "nvim-treesitter")
    if not ok then
        if not vim.g.treesitter_missing_warned then
            vim.g.treesitter_missing_warned = true
            vim.schedule(function()
                vim.notify("nvim-treesitter not available; run :lua vim.pack.update()", vim.log.levels.WARN)
            end)
        end
        return
    end

    treesitter.setup({
        ensure_installed = {
            "lua",
            "luadoc",
            "vim",
            "vimdoc",
            "rust",
            "html",
            "bash",
            "css",
            "c",
            "markdown",
            "markdown_inline",
            "java",
            "javascript",
            "typescript",
            "tsx",
            "json",
            "toml",
            "regex",
            "query",
            "php",
            "phpdoc",
            "python",
            "sql",
            "c_sharp",
            "typst",
        },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        indent = { enable = true },
        incremental_selection = { enable = true },
    })

    -- Note: nvim-treesitter main requires the tree-sitter CLI on your system.

    -- Fallback: force-start treesitter for C-family buffers if needed.
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "c", "cpp", "objc", "objcpp" },
        callback = function(args)
            pcall(vim.treesitter.start, args.buf)
        end,
    })
end

return M
