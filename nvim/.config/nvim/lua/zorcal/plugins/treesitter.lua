return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opra = {
      ensure_installed = {
        "lua",
        "python",
        "javascript",
        "typescript",
        "go",
        "rust",
        "c",
        "cpp",
        "yaml",
        "json",
        "html",
        "css",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      playground = {
        enable = true,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesitter-context").setup {
        enable = true,
        max_lines = 0,
        trim_scope = "outer",
        mode = "cursor",
        separator = nil,
      }
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("ts_context_commentstring").setup {
        enable = true,
        enable_autocmd = false,
      }
    end,
  },
  {
    "numToStr/Comment.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },
}
