return {
  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "1.*",
    opts = {},
    config = function(_, opts)
      require("typst-preview").setup(opts)

      local lsp = vim.lsp
      lsp.config.tinymist = vim.tbl_deep_extend("force", lsp.config.tinymist or {}, {
        settings = {
          exportPdf = "onSave",
          outputPath = "$root/$name",
        },
      })
      lsp.enable("tinymist")
    end,
  },
}
