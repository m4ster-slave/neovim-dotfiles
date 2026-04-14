return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      css = { "prettier" },
      html = { "prettier" },
      rust = { "rustfmt" },
      markdown = { "prettier" },
      json = { "prettier" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      python = { "ruff_format" },
      php = { "php_cs_fixer", "phpcbf" },
    },
    format_on_save = function()
      if vim.g.format_on_save == false then
        return nil
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,
  },
}
