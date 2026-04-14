return {
  "HiPhish/rainbow-delimiters.nvim",
  event = { "BufReadPost", "BufNewFile" },
  init = function()
    vim.g.rainbow_delimiters = {
      blacklist = { "yazi", "TelescopePrompt" },
      condition = function(bufnr)
        if vim.bo[bufnr].buftype ~= "" then
          return false
        end

        local ft = vim.bo[bufnr].filetype
        return ft ~= "yazi" and ft ~= "TelescopePrompt"
      end,
    }
  end,
}
