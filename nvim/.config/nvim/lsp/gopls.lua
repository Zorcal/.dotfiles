return {
  cmd = {
    "gopls",
    "-remote=auto",
    "-listen.timeout=1h",
    "-logfile=/tmp/gopls.log",
    "-rpc.trace",
    "-vv",
  },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod" },
  settings = {
    gopls = {
      directoryFilters = { "-**/node_modules", "-**/vendor" },
      analyses = {
        unusedparams = false,
        unusedwrite = false,
      },
    },
  },
}
