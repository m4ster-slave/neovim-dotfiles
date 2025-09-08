return {
  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "1.*",
  opts = {},
    require("lspconfig").tinymist.setup {
      settings = {
        exportPdf = "onSave",
        outputPath = "$root/$name",
      },
    },
  },
}
