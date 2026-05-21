return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require "lint"
      local webdevLinters = {
        "biomejs", --[[ "eslint_d", "eslint" ]]
      }
      lint.linters_by_ft = {
        javascript = webdevLinters,
        typescript = webdevLinters,
        javascriptreact = webdevLinters,
        typescriptreact = webdevLinters,
      }
      lint.linters.eslint_d.args = {
        "--no-ignore",
        "--format",
        "json",
        "--stdin",
        "--stdin-filename",
        function()
          return vim.api.nvim_buf_get_name(0)
        end,
      }
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("lint", { clear = true }),
        callback = function()
          lint.try_lint(nil, { ignore_errors = true })
        end,
      })
    end,
  },
}
