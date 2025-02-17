local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local zorcal_group = augroup("zorcal", {})

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

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  callback = function(args)
    vim.treesitter.stop(args.buf)
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    if vim.o.background == "light" then
      vim.api.nvim_set_hl(0, "Normal", {
        fg = "#000000",
        bg = "#cccccc",
      })
      vim.api.nvim_set_hl(0, "Comment", {
        fg = "#888888",
        bg = "NONE",
      })
    else
      local slate = "#253443"
      vim.api.nvim_set_hl(0, "Normal", {
        fg = "#f0f1f2",
        bg = slate,
      })
      -- vim.api.nvim_set_hl(0, "Comment", {
      --   fg = "#888888",
      --   bg = "NONE",
      -- })
    end

    local link_to_normal = {
      "String",
      "Function",
      "Identifier",
      "Type",
      "Keyword",
      "Statement",
      "Conditional",
      "Repeat",
      "Operator",
      "Number",
      "Boolean",
      "Float",
      "Constant",
      "Character",
      "Label",
      "PreProc",
      "Include",
      "Define",
      "Macro",
      "PreCondit",
      "StorageClass",
      "Structure",
      "Typedef",
      "Special",
      "SpecialChar",
      "Delimiter",
      "SpecialComment",
      "Underlined",
      "Ignore",
      "Error",
      "Todo",
      "Comment",
    }
    for _, group in ipairs(link_to_normal) do
      vim.api.nvim_set_hl(0, group, { link = "Normal" })
    end
  end,
})

vim.api.nvim_exec_autocmds("ColorScheme", {})
