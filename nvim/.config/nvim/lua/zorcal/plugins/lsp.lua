return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      { "j-hui/fidget.nvim", opts = {} },

      -- Autoformatting
      "stevearc/conform.nvim",

      -- Linting
      "mfussenegger/nvim-lint",
    },
    config = function()
      require("vim.lsp.log").set_format_func(vim.inspect)

      local lspconfig = require "lspconfig"

      local servers = {
        bashls = true,
        gopls = true,
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = {
                  [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                  [vim.fn.stdpath "config" .. "/lua"] = true,
                },
              },
            },
          },
        },
        rust_analyzer = true,
        cssls = true,
        ts_ls = true,
        emmet_ls = {
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
        },
        pyright = true,
        zls = true,
        sqlls = true,
        terraformls = true,
      }

      require("mason").setup {}

      require("mason-tool-installer").setup {}

      for name, config in pairs(servers) do
        if not config then
          return
        end
        if type(config) ~= "table" then
          config = {}
        end
        lspconfig[name].setup(config)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

          -- Turn off LSP highlighting...
          client.server_capabilities.semanticTokensProvider = nil

          -- Use built-in LSP omnifunc for completion
          vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

          local opts = { buffer = bufnr, remap = false }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>li", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "]d", function()
            vim.diagnostic.jump { count = 1, float = true }
          end, opts)
          vim.keymap.set("n", "[d", function()
            vim.diagnostic.jump { count = -1, float = true }
          end, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

          -- Some lsp keymaps are configured in fzf config
        end,
      })

      vim.diagnostic.config {
        virtual_text = {
          source = true, -- Show source in virtual text
        },
        float = {
          source = true, -- Show source in floating window
        },
      }

      -- Autoformatting setup
      local conform = require "conform"
      local webdevFormatters = (function()
        if conform.get_formatter_info("biome", 0).available then
          return { "biome", "biome-check" }
        elseif conform.get_formatter_info("eslint_d", 0).available then
          return { "prettier", "eslint_d" }
        else
          return {}
        end
      end)()
      conform.setup {
        formatters = {
          clickhousefmt = {
            command = "/usr/bin/clickhouse-format",
            stdin = true,
          },
        },
        formatters_by_ft = {
          javascript = webdevFormatters,
          typescript = webdevFormatters,
          javascriptreact = webdevFormatters,
          typescriptreact = webdevFormatters,
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          graphql = { "prettier" },
          lua = { "stylua" },
          python = { "isort", "black" },
          go = {
            -- See formatter_args below. golines is a wrapper around gofumpt.
            "goimports",
            "gofumpt",
          },
          rust = { "rustfmt" },
          toml = { "taplo" },
          sql = { "sql_formatter" },
          tf = { "terraform_fmt" },
        },
      }
      require("conform.util").add_formatter_args(require "conform.formatters.goimports", {
        "-local",
        "github.com/formulatehq",
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function(args)
          local opts = {
            bufnr = args.buf,
            lsp_fallback = true,
            async = false,
            quiet = false,
            timeout_ms = 500,
          }
          require("conform").format(opts)
        end,
      })

      local lint = require "lint"
      local webdevLinters = {
        "biomejs", --[[ "eslint_d", "eslint" ]]
      }
      lint.linters_by_ft = {
        javascript = webdevLinters,
        typescript = webdevLinters,
        javascriptreact = webdevLinters,
        typescriptreact = webdevLinters,
        python = { "pylint" },
        go = { "golangcilint" },
      }
      lint.linters.eslint_d.args = {
        "--no-ignore",
        "--format",
        "json",
        "--stdin",
        "--stdin-filename",
        function()
          return vim.api.nvim_buf_get_name(0)
        end,
      }
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("lint", { clear = true }),
        callback = function()
          lint.try_lint(nil, { ignore_errors = true })
        end,
      })
    end,
  },
}
