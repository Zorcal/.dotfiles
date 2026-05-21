local set = vim.keymap.set

-- Unbind
set("n", "Q", "<nop>")
set({ "v", "i" }, "<Up>", "<nop>")
set({ "v", "i" }, "<Down>", "<nop>")
set({ "v", "i" }, "<Left>", "<nop>")
set({ "v", "i" }, "<Right>", "<nop>")

-- Move selected text
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- Always center
set("n", "J", "mzJ`z")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

-- Paste, yank and replace
set("x", "R", [["_dP]])
set("x", "<leader>R", [["+p]])
set({ "n", "v" }, "<leader>y", [["+y]])
set({ "n", "v" }, "<leader>p", [["+p]])
set("n", "<leader>Y", [["+Y]])
set({ "n", "v" }, "<A-d>", [["_d]])
set({ "n", "v" }, "<A-c>", [["_c]])

-- Resize windows
set("n", "<M-h>", "<c-w>5<")
set("n", "<M-l>", "<c-w>5>")
set("n", "<M-k>", "<C-W>+")
set("n", "<M-j>", "<C-W>-")

-- Undo stops.
set("i", ",", ",<C-g>u")
set("i", ".", ".<C-g>u")
set("i", "!", "!<C-g>u")
set("i", "?", "?<C-g>u")
set("i", " ", " <C-g>u")

-- Indent.
set("v", "<", "<gv")
set("v", ">", ">gv")

-- Undo.
set("n", "U", "<C-R>")

vim.cmd [[
  function! ToggleQuickfixList()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]
set("n", "<C-q>", ":call ToggleQuickfixList()<CR>")

function _G.toggle_light_dark()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
  -- Re-run ColorScheme autocmds so your highlight overrides apply
  vim.cmd "doautocmd ColorScheme"
end

set("n", "<leader>tb", toggle_light_dark, { desc = "Toggle light/dark background" })

--When not using oil.nvim:
-- set("n", "-", ":Explore<CR>", { silent = true, noremap = true })

if vim.g.neovide then
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  set("n", "<C-=>", function()
    change_scale_factor(1.25)
  end)
  set("n", "<C-->", function()
    change_scale_factor(1 / 1.25)
  end)
end
