local parser_so = vim.fn.stdpath("data") .. "/parser/chcexpr.so"
local parser_src = vim.fn.expand("~/Work/ingest/master/pkg/ch/chcexpr/tree-sitter-chcexpr/src/parser.c")

vim.fn.mkdir(vim.fn.stdpath("data") .. "/parser", "p")

if vim.fn.filereadable(parser_so) == 0 then
  local flags = vim.fn.has("mac") == 1
    and "-bundle -undefined dynamic_lookup"
    or "-shared -fPIC"
  local cmd = string.format("cc -o %s %s -Os %s", parser_so, flags, parser_src)
  local out = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify("chcexpr: parser compile failed\n" .. out, vim.log.levels.ERROR)
    return
  end
end

vim.treesitter.language.add("chcexpr", { path = parser_so })
vim.treesitter.start()

-- Scoped overrides — only affect chcexpr buffers
vim.api.nvim_set_hl(0, "@function.call.chcexpr",         { fg = "#ff2d7a", bold = true })   -- hot pink
vim.api.nvim_set_hl(0, "@module.chcexpr",                { fg = "#ff8c00" })                -- orange  (table names)
vim.api.nvim_set_hl(0, "@property.chcexpr",              { fg = "#00e676", bold = true })   -- electric green  (column names)
vim.api.nvim_set_hl(0, "@variable.parameter.chcexpr",    { fg = "#ffff00", italic = true }) -- pure yellow  (lambda params)
vim.api.nvim_set_hl(0, "@keyword.operator.chcexpr",      { fg = "#d000ff", bold = true })   -- violet  (AND OR NOT IN LIKE IS)
vim.api.nvim_set_hl(0, "@operator.chcexpr",              { fg = "#ff5c5c" })                -- red  (= != + - * /)
vim.api.nvim_set_hl(0, "@number.chcexpr",                { fg = "#00d4ff" })                -- electric cyan
vim.api.nvim_set_hl(0, "@string.chcexpr",                { fg = "#e5c07b" })                -- amber
vim.api.nvim_set_hl(0, "@boolean.chcexpr",               { fg = "#ff9500", bold = true })   -- deep orange
vim.api.nvim_set_hl(0, "@constant.builtin.chcexpr",      { fg = "#ff1744", italic = true }) -- bright red  (NULL)
vim.api.nvim_set_hl(0, "@variable.chcexpr",              { fg = "#abb2bf" })                -- soft grey  (bare identifiers)
vim.api.nvim_set_hl(0, "@punctuation.bracket.chcexpr",   { fg = "#4d5566" })                -- dark grey
vim.api.nvim_set_hl(0, "@punctuation.delimiter.chcexpr", { fg = "#4d5566" })                -- dark grey
vim.api.nvim_set_hl(0, "@punctuation.special.chcexpr",   { fg = "#4d5566" })                -- dark grey
vim.api.nvim_set_hl(0, "@error.chcexpr",                 { fg = "#ffffff", bg = "#ff1744", bold = true }) -- white on red
