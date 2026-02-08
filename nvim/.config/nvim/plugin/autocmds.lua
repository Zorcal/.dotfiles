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

autocmd("LspAttach", {
  group = zorcal_group,
  callback = function(args)
    -- Disable legacy omnifunc completion; use LSP-native completion instead
    vim.o.omnifunc = ""

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client ~= nil then
      -- Enable inlay hints (ghost text) when supported by the server
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
      end

      -- if client.server_capabilities.signatureHelpProvider then
      --   require("lsp_signature").on_attach({
      --     -- floating_window = false,
      --     -- hint_enable = true,
      --   }, args.buf)
      -- end
    end

    local opts = { buffer = args.buf, remap = false }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>li", vim.diagnostic.open_float, opts)
    -- Some lsp keymaps are configured in fzf config
  end,
})
