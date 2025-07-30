vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      },
    },
  },
  root_markers = { ".git" },
})

-- See https://github.com/neovim/nvim-lspconfig/tree/master/lsp for example configs.
for _, server_name in ipairs {
  "lua_ls",
  "gopls",
  "html",
  "ts_ls",
  "cssls",
  "css_variables",
  "cssmodules_ls",
  "jsonls",
  "yamlls",
  "marksman",
  "emmet_ls",
  "bashls",
  "taplo",
  "graphql",
  "protols",
  "rust",
  "elmls",
} do
  vim.lsp.enable(server_name)
end

require("vim.lsp.log").set_format_func(vim.inspect)

vim.diagnostic.config {
  virtual_text = { source = true },
  float = { source = true },
}
