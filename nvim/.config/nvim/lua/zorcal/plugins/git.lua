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
    "sindrets/diffview.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("diffview").setup {
        keymaps = {
          disable_defaults = true,
        },
      }

      vim.keymap.set("n", "<leader>gd", function()
        local lib = require "diffview.lib"
        local view = lib.get_current_view()

        if view then
          vim.cmd "DiffviewClose"
        else
          vim.cmd "DiffviewOpen"
        end
      end, { desc = "Toggle Git diff view" })
    end,
  },
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "ibhagwan/fzf-lua",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit kind=auto<cr>", desc = "Show Neogit UI" },
    },
  },
}
