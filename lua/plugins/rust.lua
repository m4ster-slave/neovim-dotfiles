local M = {}

M.plugins = {
    { repo = "mrcjkb/rustaceanvim", version = "v9.0.3" },
}

function M.setup()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    vim.g.rustaceanvim = {
        server = {
            capabilities = capabilities,
            ["rust-analyzer"] = {
                check = { command = "clippy" }, -- or "check"
            },
        },
        tools = {
            -- if this key exists and is enabled, disable it
            cargo_check = { enable = false },
        },
    }
end

return M
