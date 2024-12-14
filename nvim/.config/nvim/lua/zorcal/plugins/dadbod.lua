return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.cmd [[
      function s:buffer_name_generator(opts)
        let l:time = strftime('%Y-%m-%dT%T')
        if empty(a:opts.table)
          return printf('%s.sql', l:time)
		    endif
        return printf('%s-%s.sql', a:opts.table, l:time)
      endfunction

      let g:Db_ui_buffer_name_generator = function('s:buffer_name_generator')
    ]]
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}

--[[

In ~/.local/share/db_ui/connections.json (g:db_ui_save_location):

  [
    {"url": "postgresql://postgres@localhost:5432/local_graphql", "name": "local_graphql"},
    {"url": "clickhouse:///", "name": "local_clickhouse"},
    {"url": "clickhouse://localhost:19440/", "name": "localhost:19440"}
  ]

--]]
