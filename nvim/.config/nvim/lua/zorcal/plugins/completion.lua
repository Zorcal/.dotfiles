return {
  "saghen/blink.cmp",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "onsails/lspkind.nvim",
  },
  version = "1.*",
  opts = {
    keymap = {
      ["<C-space>"] = { "show" },
      ["<C-e>"] = { "hide" },
      ["<C-y>"] = { "select_and_accept" },

      ["<Up>"] = false,
      ["<Down>"] = false,
      ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
      ["<C-n>"] = { "select_next", "fallback_to_mappings" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },

      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

      ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
    },
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
      menu = {
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                local icon = ctx.kind_icon
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    icon = dev_icon
                  end
                else
                  icon = require("lspkind").symbolic(ctx.kind, {
                    mode = "symbol",
                  })
                end

                return icon .. ctx.icon_gap
              end,

              -- Optionally, use the highlight groups from nvim-web-devicons
              -- You can also add the same function for `kind.highlight` if you want to
              -- keep the highlight groups in sync with the icons.
              highlight = function(ctx)
                local hl = ctx.kind_hl
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    hl = dev_hl
                  end
                end
                return hl
              end,
            },
          },
        },
      },
    },
    sources = {
      default = { "lsp", "path", "buffer" },
    },
  },
  opts_extend = { "sources.default" },
}
