local M = {}

M.plugins = {
  -- Replaced ixru/nvim-markdown (unmaintained) with markdown.nvim (maintained).
  "tadmccorkle/markdown.nvim",
  "iamcco/markdown-preview.nvim",
  "MeanderingProgrammer/render-markdown.nvim",
}

function M.setup()
  pcall(function()
    require("markdown").setup {}
  end)

  vim.g.mkdp_filetypes = { "markdown" }
  vim.g.mkdp_browser = "chromium"
  vim.g.mkdp_markdown_css = "/home/lukas/.config/nvim/md.css"
  vim.g.mkdp_highlight_css = "/home/lukas/.config/nvim/mdhl.css"

  vim.keymap.set("n", "<leader>mdn", ":MarkdownPreview<CR>")
  vim.keymap.set("n", "<leader>mds", ":MarkdownPreviewStop<CR>")

  require("render-markdown").setup {
    heading = {
      width = "block",
      left_pad = 2,
      right_pad = 4,
    },
  }
end

return M
