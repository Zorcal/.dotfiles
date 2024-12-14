return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.surround").setup {
        mappings = {
          add = "sa",
          delete = "sd",
          replace = "sr",
          -- Disabled mappings:
          find = "",
          find_left = "",
          highlight = "",
          update_n_lines = "",
          suffix_last = "",
          suffix_next = "",
        },
      }
    end,
  },
}
