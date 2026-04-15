return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  cmd = { "TSInstall", "TSInstallFromGrammar", "TSUpdate" },
  build = ":TSUpdate",
  opts = function()
    local ensure_installed = {
      "lua", "luadoc", "vim", "vimdoc",
      "rust", "html", "bash", "css", "c", "markdown",
      "java", "go", "javascript", "typescript", "tsx",
      "json", "toml", "regex", "query",
      "php", "phpdoc",
    }

    return {
      ensure_installed = ensure_installed,
      auto_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      install_dir = vim.fn.stdpath("data") .. "/site",
    }
  end,

  config = function(_, opts)
    require("nvim-treesitter").setup(opts)

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        if pcall(vim.treesitter.start, args.buf) then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
