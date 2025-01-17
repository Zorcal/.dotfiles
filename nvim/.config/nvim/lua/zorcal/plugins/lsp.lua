return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/neodev.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      { "j-hui/fidget.nvim", opts = {} },

      -- Autoformatting
      "stevearc/conform.nvim",

      -- Linting
      "mfussenegger/nvim-lint",

      -- Schema information
      "b0o/SchemaStore.nvim",
    },
    config = function()
      require("vim.lsp.log").set_format_func(vim.inspect)

      require("neodev").setup {
        library = {
          plugins = { "nvim-dap-ui" },
          types = true,
        },
      }

      local capabilities = nil
      if pcall(require, "cmp_nvim_lsp") then
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      end

      local lspconfig = require "lspconfig"

      local servers = {
        bashls = true,
        gopls = true,
        lua_ls = true,
        rust_analyzer = true,
        cssls = true,
        ts_ls = true,
        emmet_ls = {
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
        },
        pyright = true,
        vimls = true,
        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = "",
              },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        },
        dockerls = true,
        docker_compose_language_service = true,
        marksman = true,
        awk_ls = true,
        zls = true,
        sqlls = true,
        terraformls = true,
        gleam = true,
        hyprls = true,
        erlangls = true,
        hls = {
          filetypes = {
            "haskell",
            "lhaskell",
            "cabal",
          },
          settings = {
            haskell = {
              formattingProvider = "none",
            },
          },
        },
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
        config = vim.tbl_deep_extend("force", {}, { capabilities = capabilities }, config)
        lspconfig[name].setup(config)
      end

      local disable_semantic_tokens = {
        lua = true,
        haskell = true,
      }

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
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

          local filetype = vim.bo[bufnr].filetype
          if disable_semantic_tokens[filetype] then
            client.server_capabilities.semanticTokensProvider = nil
          end
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
          sh = { "shellcheck", "shfmt" },
          bash = { "shellcheck", "shfmt" },
          tf = { "terraform_fmt" },
          haskell = { "ormolu" },
          lhaskell = { "ormolu" },
          cabal = { "ormolu" },
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
          if vim.bo.filetype == "sql" and vim.api.nvim_buf_get_name(args.buf):find "clickhouse" then
            opts.formatters = { "clickhousefmt" }
          end
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
