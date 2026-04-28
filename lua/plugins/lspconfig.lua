local M = {}

M.plugins = {
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
}

function M.setup()
  require("mason").setup {
    PATH = "prepend",
  }

  require("mason-lspconfig").setup {
    ensure_installed = {
      "lua_ls",
      "gopls",
      "templ",
      "html",
      "cssls",
      "emmet_language_server",
      "htmx",
      "tailwindcss",
      "ts_ls",
      "pylsp",
      "clangd",
      "prismals",
      "yamlls",
      "jsonls",
      "eslint",
      "zls",
      "marksman",
      "sqls",
      "wgsl_analyzer",
      "tinymist",
      "intelephense",
      "csharp_ls",
      "jdtls",
      "rust_analyzer",
      "hls",
    },
  }

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local ok, cmp_caps = pcall(require, "cmp_nvim_lsp")
  if ok then
    capabilities = cmp_caps.default_capabilities(capabilities)
  end

  local function root_dir(fname, patterns)
    return vim.fs.root(fname, patterns) or vim.fs.dirname(fname)
  end

  local function with_capabilities(cfg)
    cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})
    return cfg
  end

  local function python_path()
    local venv = vim.env.VIRTUAL_ENV
    return venv and (venv .. "/bin/python3") or "/usr/bin/python3"
  end

  local servers = {
    zls = with_capabilities { cmd = { "zls" } },
    hls = with_capabilities {},
    lua_ls = with_capabilities {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    },
    wgsl_analyzer = with_capabilities {},
    jsonls = with_capabilities {},
    gopls = with_capabilities {},
    cssls = with_capabilities {},
    prismals = with_capabilities {},
    intelephense = with_capabilities {
      init_options = { globalStoragePath = "/tmp/" },
    },
    yamlls = with_capabilities {},
    html = with_capabilities {
      filetypes = { "templ", "html", "javascriptreact", "typescriptreact", "jsx", "tsx", "php" },
    },
    htmx = with_capabilities { filetypes = { "html", "templ" } },
    emmet_language_server = with_capabilities {
      filetypes = {
        "templ",
        "html",
        "css",
        "javascriptreact",
        "typescriptreact",
        "javascript",
        "typescript",
        "jsx",
        "tsx",
        "php",
      },
    },
    tailwindcss = with_capabilities {
      filetypes = { "templ", "html", "css", "javascriptreact", "typescriptreact", "javascript", "typescript", "jsx", "tsx" },
      root_dir = function(fname)
        return root_dir(fname, {
          "tailwind.config.js",
          "tailwind.config.cjs",
          "tailwind.config.mjs",
          "tailwind.config.ts",
          "postcss.config.js",
          "postcss.config.cjs",
          "postcss.config.mjs",
          "postcss.config.ts",
          "package.json",
          "node_modules",
          ".git",
        })
      end,
    },
    templ = with_capabilities { filetypes = { "templ" } },
    ts_ls = with_capabilities {},
    eslint = with_capabilities {},
    clangd = with_capabilities {
      cmd = {
        "clangd",
        "--background-index",
        "--pch-storage=memory",
        "--all-scopes-completion",
        "--pretty",
        "--header-insertion=never",
        "-j=4",
        "--inlay-hints",
        "--header-insertion-decorators",
        "--function-arg-placeholders",
        "--completion-style=detailed",
      },
      filetypes = { "c", "cpp", "objc", "objcpp" },
      root_dir = function(fname)
        return root_dir(fname, { ".clangd", "compile_commands.json", ".git" })
      end,
    },
    pylsp = with_capabilities {
      settings = {
        python = { pythonPath = python_path() },
      },
    },
    marksman = with_capabilities {},
    sqls = with_capabilities {},
    csharp_ls = with_capabilities {
      root_dir = function(fname)
        return root_dir(fname, { "*.sln", "*.csproj", ".git" })
      end,
    },
    jdtls = with_capabilities {
      root_dir = function(fname)
        return root_dir(fname, { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
      end,
    },
    tinymist = with_capabilities {
      settings = {
        exportPdf = "onSave",
        outputPath = "$root/$name",
      },
    },
  }

  for name, cfg in pairs(servers) do
    vim.lsp.config(name, cfg)
    local ok_enable, err = pcall(vim.lsp.enable, name)
    if not ok_enable then
      vim.schedule(function()
        vim.notify(string.format("Skipping LSP '%s': %s", name, err), vim.log.levels.WARN)
      end)
    end
  end

  -- Fallback: ensure clangd attaches when opening C-family files.
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "objc", "objcpp" },
    callback = function(args)
      if #vim.lsp.get_clients { bufnr = args.buf, name = "clangd" } > 0 then
        return
      end
      local clangd_cfg = servers.clangd
      if not clangd_cfg then
        return
      end
      vim.lsp.start(vim.tbl_deep_extend("force", {}, clangd_cfg, { bufnr = args.buf }))
    end,
  })
end

return M
