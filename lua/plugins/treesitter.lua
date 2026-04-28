return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "TSInstall", "TSInstallFromGrammar", "TSUpdate" },
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "lua", "luadoc", "vim", "vimdoc",
      "rust", "html", "bash", "css", "c", "markdown", "markdown_inline",
      "java", "javascript", "typescript", "tsx",
      "json", "toml", "regex", "query",
      "php", "phpdoc",
      "python", "sql", "c_sharp", "typst",
    },
    sync_install = false,
    auto_install = true,
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
    incremental_selection = { enable = true },
  },

  config = function(_, opts)
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if not ok then
      vim.schedule(function()
        vim.notify("nvim-treesitter not available; run :Lazy sync", vim.log.levels.WARN)
      end)
      return
    end

    configs.setup(opts)

    -- Fallback: force-start treesitter for C-family buffers if needed.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "c", "cpp", "objc", "objcpp" },
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
