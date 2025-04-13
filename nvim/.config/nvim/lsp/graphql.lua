local path = require "zorcal.path"

return {
  cmd = { "graphql-lsp", "server", "-m", "stream" },
  filetypes = { "graphql", "typescriptreact", "javascriptreact" },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(path.root_pattern(".graphqlrc*", ".graphql.config.*", "graphql.config.*", "gqlgen.yml")(fname))
  end,
}
