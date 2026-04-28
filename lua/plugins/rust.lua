local M = {}

M.plugins = {
    { repo = "mrcjkb/rustaceanvim", version = "v9.0.3" },
}

function M.setup()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    vim.g.rustaceanvim = {
        server = {
            capabilities = capabilities,
        },
    }
end

return M
