local M = {}

M.plugins = {
    { repo = "mrcjkb/rustaceanvim" },
}

function M.setup()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok, cmp_caps = pcall(require, "cmp_nvim_lsp")
    if ok then
        capabilities = cmp_caps.default_capabilities(capabilities)
    end

    vim.g.rustaceanvim = {
        server = {
            capabilities = capabilities,
            ["rust-analyzer"] = {
                check = {
                    command = "clippy",
                    extraArgs = {
                        "--",
                        "-W",
                        "clippy::all",
                        "-W",
                        "clippy::pedantic",
                        "-W",
                        "clippy::nursery",
                        "-W",
                        "clippy::cargo",
                    },
                },
            },
        },
    }
end

return M
