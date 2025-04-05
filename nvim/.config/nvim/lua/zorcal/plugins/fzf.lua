return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup {
      defaults = {
        file_icons = false,
      },
      diagnostic = {
        previewer = false,
        severity_sort = true,
      },
      winopts = {
        preview = { default = "bat" },
        row = 1,
        width = 1.0,
        height = 0.50,
        border = "none",
      },
      files = {
        rg_opts = [[--color=never --files --hidden --follow -g "!.git" -g "!vendor"]],
        fd_opts = [[--color=never --type f --hidden --follow --exclude .git --exclude vendor]],
      },
      keymap = {
        fzf = {
          -- Send results to quickfix list
          ["ctrl-q"] = "select-all+accept",
        },
      },
    }

    vim.keymap.set("n", "<leader>f", "<cmd>lua require('fzf-lua').files({previewer=false})<CR>")
    vim.keymap.set("n", "<leader>bf", "<cmd>lua require('fzf-lua').buffers({previewer=false})<CR>")
    vim.keymap.set("n", "<leader>bs", "<cmd>lua require('fzf-lua').blines()<CR>")
    vim.keymap.set("n", "<leader>blg", "<cmd>lua require('fzf-lua').lgrep_curbuf()<CR>")
    vim.keymap.set("n", "<leader>/", "<cmd>lua require('fzf-lua').grep()<CR>")
    vim.keymap.set("n", "<leader>gs", "<cmd>lua require('fzf-lua').live_grep()<CR>")
    vim.keymap.set("n", "<leader>ls", "<cmd>lua require('fzf-lua').lsp_document_symbols({previewer=false})<CR>")
    vim.keymap.set("n", "<leader>ld", "<cmd>lua require('fzf-lua').lsp_document_diagnostics({previewer=false})<CR>")
    vim.keymap.set("n", "<leader>lD", "<cmd>lua require('fzf-lua').lsp_workspace_diagnostics({previewer=false})<CR>")
  end,
}
