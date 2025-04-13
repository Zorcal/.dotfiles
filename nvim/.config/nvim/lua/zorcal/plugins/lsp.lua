return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      require("vim.lsp.log").set_format_func(vim.inspect)

      local lspconfig = require "lspconfig"

      local servers = {
        bashls = true,
        gopls = true,
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = {
                  [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                  [vim.fn.stdpath "config" .. "/lua"] = true,
                },
              },
            },
          },
        },
        rust_analyzer = true,
        cssls = true,
        ts_ls = true,
        emmet_ls = {
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
        },
        pyright = true,
        zls = true,
        sqlls = true,
        terraformls = true,
      }

      require("mason").setup {}

      require("mason-tool-installer").setup {}

      for name, config in pairs(servers) do
        if not config then
          return
        end
        if type(config) ~= "table" then
          config = {}
        end
        lspconfig[name].setup(config)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

          -- Turn off LSP highlighting...
          client.server_capabilities.semanticTokensProvider = nil

          -- Use built-in LSP omnifunc for completion
          vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

          local opts = { buffer = bufnr, remap = false }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "<leader>li", vim.diagnostic.open_float, opts)
          -- Some lsp keymaps are configured in fzf config
        end,
      })

      vim.diagnostic.config {
        virtual_text = {
          source = true, -- Show source in virtual text
        },
        float = {
          source = true, -- Show source in floating window
        },
      }
    end,
  },
}
