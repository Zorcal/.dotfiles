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

-- Navigate quickfix list.
set("n", "<C-j>", "<cmd>cnext<CR>zz")
set("n", "<C-k>", "<cmd>cprev<CR>zz")

-- Navigate location list.
set("n", "<leader>j", "<cmd>lnext<CR>zz")
set("n", "<leader>k", "<cmd>lprev<CR>zz")

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
vim.keymap.set("n", "<C-q>", ":call ToggleQuickfixList()<CR>")
