return {
  {
    "ixru/nvim-markdown",
    lazy = false,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app; yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_browser = "chromium"
    end,
    ft = { "markdown" },
    config = function()
      vim.keymap.set("n", "<leader>mdn", ":MarkdownPreview<CR>")
      vim.keymap.set("n", "<leader>mds", ":MarkdownPreviewStop<CR>")

      vim.g.mkdp_markdown_css = "/home/lukas/.config/nvim/md.css"
      vim.g.mkdp_highlight_css = "/home/lukas/.config/nvim/mdhl.css"
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      heading = {
        width = 'block',
        left_pad = 2,
        right_pad = 4,
      },
    },
  }
}
