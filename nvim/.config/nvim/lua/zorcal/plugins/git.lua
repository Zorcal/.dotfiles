return {
  {
    "FabijanZulj/blame.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("blame").setup()
      vim.keymap.set("n", "<leader>gb", "<cmd>BlameToggle window<CR>")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup {}
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("git-conflict").setup {
        default_mappings = false,
        default_commands = true,
        disable_diagnostics = false,
        list_opener = "copen", -- command or function to open the conflicts list
        highlights = { -- They must have background color, otherwise the default color will be used
          incoming = "DiffAdd",
          current = "DiffText",
        },
      }
    end,
  },
}
