-- plugin/colorscheme.lua
-- Acme / Go Playground inspired colorscheme (ultra-minimal, linked)

local vim = vim

vim.cmd "highlight clear"
if vim.fn.exists "syntax_on" then
  vim.cmd "syntax reset"
end

vim.o.background = "light"
vim.g.colors_name = "acmeplayground"

----------------------------------------------------------------
-- Palette
----------------------------------------------------------------

local palette = {
  -- Neutrals
  bg = "#ffffdd",
  fg = "#202224",
  subtle = "#6e7072",
  border = "#c6c8ca",

  float_bg = "#f9f9d6",
  float_border = "#c6c8ca",
  float_sig_bg = "#f0f0c0",

  -- UI surfaces
  cursorline = "#fff8cc",
  visual = "#f0f1f2",

  -- Syntax nuance
  comment = "#7a7c7f", -- slightly lighter than subtle
  punct = "#4a4c4f", -- softer ink for braces / commas

  -- Search
  incsearch = "#fddd00", -- Go yellow
}

----------------------------------------------------------------
-- Helper
----------------------------------------------------------------

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

----------------------------------------------------------------
-- Core roots (explicit colors)
----------------------------------------------------------------

hl("Normal", { fg = palette.fg, bg = palette.bg })
hl("Comment", { fg = palette.comment })
hl("Delimiter", { fg = palette.punct })
hl("Visual", { bg = palette.visual })
hl("CursorLine", { bg = palette.cursorline })

-- UI elements
hl("LineNr", { link = "Comment" })
hl("CursorLineNr", { link = "Normal" })
hl("VertSplit", { fg = palette.border, bg = palette.bg })
hl("StatusLine", { link = "Visual" })
hl("StatusLineNC", { link = "Comment" })
hl("Pmenu", { link = "Visual" })
hl("PmenuSel", { link = "CursorLine" })
hl("FloatBorder", { link = "VertSplit" })
hl("NormalFloat", { fg = palette.fg, bg = palette.float_bg })
hl("FloatBorder", { fg = palette.float_border, bg = palette.float_bg })
hl("FloatSig", { fg = palette.fg, bg = palette.float_bg })

-- Search
hl("IncSearch", { fg = palette.fg, bg = palette.incsearch })
hl("Search", { link = "Visual" })

----------------------------------------------------------------
-- Legacy syntax (link to roots)
----------------------------------------------------------------

local legacy_normal = {
  "Identifier",
  "Function",
  "Keyword",
  "Statement",
  "Conditional",
  "Repeat",
  "String",
  "Number",
  "Constant",
  "Type",
  "Operator",
  "Special",
  "SpecialChar",
  "Tag",
  "Noise",
  "Todo",
}

for _, g in ipairs(legacy_normal) do
  hl(g, { link = "Normal" })
end

----------------------------------------------------------------
-- Punctuation / braces (link to Delimiter)
----------------------------------------------------------------

local punct_groups = {
  "NvimParenthesis",
  "NvimCurly",
  "NvimComma",
  "NvimColon",
}

for _, g in ipairs(punct_groups) do
  hl(g, { link = "Delimiter" })
end

----------------------------------------------------------------
-- Treesitter (link aggressively)
----------------------------------------------------------------

-- Core
local ts_normal = {
  "@text",
  "@variable",
  "@field",
  "@property",
  "@parameter",
  "@function",
  "@method",
  "@constructor",
  "@type",
  "@type.builtin",
  "@constant",
  "@constant.builtin",
  "@keyword",
  "@label",
}

for _, g in ipairs(ts_normal) do
  hl(g, { link = "Normal" })
end

-- Literals
local ts_literals = {
  "@string",
  "@string.escape",
  "@number",
  "@boolean",
  "@float",
  "@character",
}

for _, g in ipairs(ts_literals) do
  hl(g, { link = "Normal" })
end

-- Punctuation
local ts_punct = {
  "@punctuation",
  "@punctuation.bracket",
  "@punctuation.delimiter",
  "@operator",
}

for _, g in ipairs(ts_punct) do
  hl(g, { link = "Delimiter" })
end

-- Comments
hl("@comment", { link = "Comment" })

----------------------------------------------------------------
-- LSP (link to roots)
----------------------------------------------------------------

hl("LspReferenceText", { link = "Visual" })
hl("LspReferenceRead", { link = "Visual" })
hl("LspReferenceWrite", { link = "Visual" })

local lsp_diagnostics = {
  "DiagnosticError",
  "DiagnosticWarn",
  "DiagnosticInfo",
  "DiagnosticHint",
}

for _, g in ipairs(lsp_diagnostics) do
  hl(g, { link = "Normal" })
end

----------------------------------------------------------------
-- fzf-lua: flatten and link
----------------------------------------------------------------

hl("FzfLuaNormal", { link = "Normal" })
hl("FzfLuaBorder", { link = "VertSplit" })
hl("FzfLuaCursorLine", { link = "CursorLine" })
hl("FzfLuaCursorLineNr", { link = "Normal" })

local fzf_links = {
  "FzfLuaTitle",
  "FzfLuaBackdrop",
  "FzfLuaHeaderBind",
  "FzfLuaHeaderText",
  "FzfLuaPathColNr",
  "FzfLuaPathLineNr",
  "FzfLuaLivePrompt",
  "FzfLuaLiveSym",
  "FzfLuaBufNr",
  "FzfLuaBufFlagCur",
  "FzfLuaBufFlagAlt",
  "FzfLuaTabTitle",
  "FzfLuaTabMarker",
  "FzfLuaFzfMatch",
  "FzfLuaFzfPointer",
  "FzfLuaFzfSpinner",
  "FzfLuaFzfPrompt",
  "fzf1",
  "fzf2",
  "fzf3",
}

for _, g in ipairs(fzf_links) do
  hl(g, { link = "FzfLuaNormal" })
end
