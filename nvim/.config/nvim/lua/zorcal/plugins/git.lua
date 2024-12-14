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
}
