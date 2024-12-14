return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lzy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup {
        auto_install = true,
        sync_install = false,
        ensure_installed = {},
        ignore_install = {},
        modules = {},
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<M-n>",
            node_incremental = "<M-n>",
            scope_incremental = "<M-c>",
            node_decremental = "<M-p>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            include_surrounding_whitespace = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["aa"] = "@parameter.outer", -- 'a' for argument
              ["ia"] = "@parameter.inner",
              ["ac"] = "@comment.outer",
              ["ic"] = "@comment.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
            },
            selection_modes = {
              ["@parameter.outer"] = "v", -- charwise
              ["@function.outer"] = "V", -- linewise
              ["@class.outer"] = "<c-v>", -- blockwise
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]a"] = "@parameter.inner",
              ["]c"] = "@comment.outer",
              ["]l"] = "@loop.outer",
            },
            goto_next_end = {},
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[a"] = "@parameter.inner",
              ["[c"] = "@comment.outer",
              ["[l"] = "@loop.outer",
            },
            goto_previous_end = {},
            goto_next = {},
            goto_previous = {},
          },
          swap = {
            enable = true,
            swap_next = { ["<leader>z"] = "@parameter.inner" },
            swap_previous = { ["<leader>Z"] = "@parameter.inner" },
          },
        },
      }

      local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
      -- vim way: ; goes to the direction you were moving.
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
      -- Make builtin f, F, t, T also repeatable with ; and ,
      vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
      vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
      vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
      vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      vim.g.skip_ts_context_commentstring_module = true
      ---@diagnostic disable-next-line: missing-fields
      require("Comment").setup {
        -- Comment.nvim already supports treesitter out-of-the-box for all the
        -- languages except tsx/jsx. Wee hook it in ourselves.
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },
}
