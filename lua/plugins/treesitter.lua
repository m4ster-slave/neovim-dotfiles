return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  opts = function()
    local opts = {
      ensure_installed = {
        "lua", "luadoc", "vim", "vimdoc",
        "rust", "html", "bash", "css", "c", "markdown",
        "java", "go", "javascript", "typescript", "tsx",
        "json", "toml", "regex", "query",
        "php", "phpdoc"
      },

      highlight = {
        enable = true,
        use_languagetree = true,
      },

  indent = { enable = true },
      auto_install = true,
    }

    return opts
  end,

  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
