return {
  {
    "mistricky/codesnap.nvim",
    build = "make",
    config = function()
      require("codesnap").setup {
        mac_window_bar = false,
        has_breadcrumbs = true,
        show_workspace = true,
        has_line_number = true,
        bg_theme = "dusk",
        watermark = "",
      }
    end,
  },
}
