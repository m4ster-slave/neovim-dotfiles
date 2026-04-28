local M = {}

M.plugins = {
  "HiPhish/rainbow-delimiters.nvim",
}

function M.setup()
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
end

return M
