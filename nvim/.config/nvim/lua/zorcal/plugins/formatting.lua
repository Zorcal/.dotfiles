return {
  {
    "stevearc/conform.nvim",
    config = function()
      local conform = require "conform"

      local webdevFormatters = (function()
        if conform.get_formatter_info("biome", 0).available then
          return { "biome", "biome-check" }
        elseif conform.get_formatter_info("eslint_d", 0).available then
          return { "prettierd", "eslint_d" }
        else
          return {}
        end
      end)()

      conform.setup {
        formatters_by_ft = {
          javascript = webdevFormatters,
          typescript = webdevFormatters,
          javascriptreact = webdevFormatters,
          typescriptreact = webdevFormatters,
          css = { "prettierd" },
          html = { "prettierd" },
          json = { "prettierd" },
          yaml = { "prettierd" },
          markdown = { "prettierd" },
          graphql = { "prettierd" },
          lua = { "stylua" },
          go = {
            "goimports",
            "gofumpt",
          },
          toml = { "taplo" },
          rust = { "rustfmt" },
          elm = { "elm_format" },
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
