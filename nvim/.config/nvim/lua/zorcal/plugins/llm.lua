return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    strategies = {
      chat = {
        adapter = "anthropic",
        model = "claude-sonnet-4-20250514",
      },
      inline = {
        adapter = "anthropic",
      },
    },
    opts = {
      log_level = "DEBUG",
    },
  },
}
