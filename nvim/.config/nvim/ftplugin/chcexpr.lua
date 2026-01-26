local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.chcexpr = {
  install_info = {
    url = "~/Work/ingest/pkg/ch/chcexpr/tree-sitter-chcexpr/",
    files = { "src/parser.c" },
  },
  filetype = "chcexpr",
}

if not require("nvim-treesitter.parsers").has_parser "chcexpr" then
  vim.cmd "TSInstall chcexpr"
end

vim.api.nvim_set_hl(0, "@call", { fg = "#ff5555", bold = true })
vim.api.nvim_set_hl(0, "@expr", { fg = "#55ff55" })
vim.api.nvim_set_hl(0, "@lambda", { fg = "#5555ff", underline = true })
vim.api.nvim_set_hl(0, "@id", { fg = "#ffaa00" })
