return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup {
        PATH = "prepend",
      }
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
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
          "sqlls",
          "wgsl_analyzer",
          "tinymist",
          "intelephense",
          "csharp_ls",
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_caps = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_caps.default_capabilities(capabilities)
      end

      local util = require("lspconfig.util")
      local lsp = vim.lsp

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
          root_dir = util.root_pattern(
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
            ".git"
          ),
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
            return util.root_pattern(".clangd", "compile_commands.json", ".git")(fname)
              or util.path.dirname(fname)
          end,
        },
        pylsp = with_capabilities {
          settings = {
            python = { pythonPath = python_path() },
          },
        },
        marksman = with_capabilities {},
        csharp_ls = with_capabilities {
          root_dir = util.root_pattern("*.sln", "*.csproj", ".git"),
        },
      }

      for name, cfg in pairs(servers) do
        lsp.config(name, cfg)
        local ok_enable, err = pcall(lsp.enable, name)
        if not ok_enable then
          vim.schedule(function()
            vim.notify(string.format("Skipping LSP '%s': %s", name, err), vim.log.levels.WARN)
          end)
        end
      end

      -- Ensure clangd starts for C-family buffers even if initial LSP autostart misses the first file.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "c", "cpp", "objc", "objcpp" },
        callback = function(args)
          local bufnr = args.buf
          if #lsp.get_clients { bufnr = bufnr, name = "clangd" } > 0 then
            return
          end
          lsp.start(vim.tbl_extend("force", {}, lsp.config.clangd or {}, { bufnr = bufnr }))
        end,
      })
    end,
  },
}
