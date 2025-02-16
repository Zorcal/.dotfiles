return {
  {
    "stevearc/conform.nvim",
    config = function()
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
    end,
  },
}
