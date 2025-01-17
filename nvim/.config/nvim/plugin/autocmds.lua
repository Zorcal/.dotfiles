local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local zorcal_group = augroup("zorcal", {})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Make NeoVim transparent.
    vim.cmd "hi! Normal guibg=NONE ctermbg=NONE"
    vim.cmd "hi! NonText guibg=NONE ctermbg=NONE"
  end,
})

autocmd("TextYankPost", {
  group = zorcal_group,
  pattern = "*",
  desc = "Highlight yank",
  callback = function()
    vim.highlight.on_yank {
      higroup = "IncSearch",
      timeout = 40,
    }
  end,
})

autocmd("VimResized", {
  group = zorcal_group,
  pattern = "*",
  desc = "Auto equalize splits when Vim is resized",
  command = "wincmd =",
})

autocmd({ "BufWritePre" }, {
  group = zorcal_group,
  pattern = "*",
  desc = "Remove extra whitespace",
  command = [[%s/\s\+$//e]],
})

autocmd({ "BufRead", "BufNewFile" }, {
  group = zorcal_group,
  pattern = "*",
  desc = "Those damn format options...",
  command = [[setlocal formatoptions-=cro]],
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.hs",
  callback = function()
    vim.cmd "setlocal syntax=OFF"
  end,
})
