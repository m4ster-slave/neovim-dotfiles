return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  ft = { "rust" },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok, cmp_caps = pcall(require, "cmp_nvim_lsp")
    if ok then
      capabilities = cmp_caps.default_capabilities(capabilities)
    end

    vim.g.rustaceanvim = {
      server = {
        capabilities = capabilities,
      },
    }
  end,
}
