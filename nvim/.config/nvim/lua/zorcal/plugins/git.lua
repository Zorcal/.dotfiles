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
      local actions = require "diffview.actions"

      require("diffview").setup {
        keymaps = {
          disable_defaults = true,
          view = {
            { "n", "<leader>e", actions.toggle_files, { desc = "Toggle the file panel" } },
          },
          diff1 = {
            -- Mappings in single window diff layouts
            { "n", "g?", actions.help { "view", "diff1" }, { desc = "Open the help panel" } },
          },
          diff2 = {
            -- Mappings in 2-way diff layouts
            { "n", "g?", actions.help { "view", "diff2" }, { desc = "Open the help panel" } },
          },
          diff3 = {
            -- Mappings in 3-way diff layouts
            { "n", "g?", actions.help { "view", "diff3" }, { desc = "Open the help panel" } },
          },
          diff4 = {
            -- Mappings in 4-way diff layouts
            { "n", "g?", actions.help { "view", "diff4" }, { desc = "Open the help panel" } },
          },
          option_panel = {
            { "n", "<tab>", actions.select_entry, { desc = "Change the current option" } },
            { "n", "<esc>", actions.close, { desc = "Close the panel" } },
            { "n", "g?", actions.help "option_panel", { desc = "Open the help panel" } },
          },
          help_panel = {
            { "n", "<esc>", actions.close, { desc = "Close help menu" } },
          },
          file_panel = {
            { "n", "g?", actions.help "file_panel", { desc = "Open the help panel" } },
            {
              "n",
              "i",
              actions.listing_style,
              { desc = "Toggle between 'list' and 'tree' views" },
            },
            {
              "n",
              "R",
              actions.refresh_files,
              { desc = "Update stats and entries in the file list" },
            },
            { "n", "<leader>b", actions.toggle_files, { desc = "Toggle the file panel" } },
            {
              "n",
              "j",
              actions.next_entry,
              { desc = "Bring the cursor to the next file entry" },
            },
            {
              "n",
              "k",
              actions.prev_entry,
              { desc = "Bring the cursor to the previous file entry" },
            },
            {
              "n",
              "<cr>",
              actions.select_entry,
              { desc = "Open the diff for the selected entry" },
            },
            {
              "n",
              "s",
              actions.toggle_stage_entry,
              { desc = "Stage / unstage the selected entry" },
            },
            { "n", "L", actions.open_commit_log, { desc = "Open the commit log panel" } },
            { "n", "<leader>e", actions.toggle_files, { desc = "Toggle the file panel" } },
          },
          file_history_panel = {
            { "n", "g!", actions.options, { desc = "Open the option panel" } },
            { "n", "g?", actions.help "file_history_panel", { desc = "Open the help panel" } },
            { "n", "<leader>b", actions.toggle_files, { desc = "Toggle the file panel" } },
            { "n", "L", actions.open_commit_log, { desc = "Show commit details" } },
            { "n", "<leader>e", actions.toggle_files, { desc = "Toggle the file panel" } },
          },
        },
      }

      local function toggle_diffview(args)
        local lib = require "diffview.lib"

        if lib.get_current_view() then
          vim.cmd "DiffviewClose"
          return
        end

        vim.cmd(args and ("DiffviewOpen " .. args) or "DiffviewOpen")
      end

      vim.keymap.set("n", "<leader>gd", function()
        toggle_diffview()
      end, { desc = "Toggle working tree diff" })

      vim.keymap.set("n", "<leader>gD", function()
        toggle_diffview "origin/main...HEAD"
      end, { desc = "Toggle branch diff" })
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
      { "<leader>gg", "<cmd>Neogit kind=floating<cr>", desc = "Show Neogit UI" },
    },
  },
}
