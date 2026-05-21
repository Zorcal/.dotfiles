return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      require("mason").setup {}
      require("mason-tool-installer").setup {
        ensure_installed = {
          "lua-language-server",
          "gopls",
          "typescript-language-server",
          "bash-language-server",
          "json-lsp",
          "yaml-language-server",
          "tailwindcss-language-server",
          "css-lsp",
          "css-variables-language-server",
          "cssmodules-language-server",
          "graphql-language-service-cli",
          "buf",

          "delve",
          "gofumpt",
          "goimports",
          "gci",
          "biome",
          "prettierd",
          "eslint_d",
          "stylua",
          "emmet-ls",
          "taplo",
        },
      }
    end,
  },
  {
    "dmmulroy/ts-error-translator.nvim",
    config = function()
      require("ts-error-translator").setup {
        auto_attach = true,
        servers = {
          "typescript-tools",
        },
      }
    end,
  },
}
