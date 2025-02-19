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
      python = { "prettier" },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
