local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

wezterm.on('update-right-status', function(window, _)
  window:set_right_status(window:active_workspace())
end)

wezterm.on('gui-startup', function(cmd)
  -- allow `wezterm start -- something` to affect what we spawn
  -- in our initial window
  local args = {}
  if cmd then
    args = cmd.args
  end

  -- Pre-defined workspaces.
  mux.spawn_window { workspace = 'default', cwd = wezterm.home_dir, args = args }
  mux.spawn_window { workspace = '~/.dotfiles', cwd = wezterm.home_dir .. '/.dotfiles', args = args }
  mux.spawn_window { workspace = '~/Work/frontend', cwd = wezterm.home_dir .. '/Work/frontend', args = args }
  mux.spawn_window { workspace = '~/Work/ingest', cwd = wezterm.home_dir .. '/Work/ingest', args = args }
  mux.spawn_window { workspace = '~/Work/vpn', cwd = wezterm.home_dir .. '/Work/vpn', args = args }
  mux.spawn_window { workspace = '~/Projects', cwd = wezterm.home_dir .. '/Projects', args = args }
  mux.spawn_window { workspace = '~/Downloads', cwd = wezterm.home_dir .. '/Downloads', args = args }

  mux.set_active_workspace 'default'
end)

-- Temporary fix for running wezterm on wayland...
config.enable_wayland = false

-- This should be default behaviour...
config.enable_kitty_keyboard = true

-- OpenGL for GPU acceleration, Software for CPU
config.front_end = 'OpenGL'

local dark = true
if dark then
  config.color_scheme = 'Ayu Dark (Gogh)'
  config.window_background_opacity = 0.8
else
  config.color_scheme = 'Github'
end

config.font_size = 12
config.line_height = 1.0
config.dpi = 96.0

-- Padding
local horizontalPadding = 0
local verticalPadding = 0
config.window_padding = {
  left = horizontalPadding,
  right = horizontalPadding,
  top = verticalPadding,
  bottom = verticalPadding,
}

-- Tab bar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = true
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.cursor_blink_rate = 0

config.scrollback_lines = 10000

config.skip_close_confirmation_for_processes_named = {}
config.disable_default_key_bindings = true
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  -- Leader fix: Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A.
  { key = 'a', mods = 'LEADER|CTRL', action = act.SendString '\x02' },
  -- Move between panes.
  { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
  { key = 's', mods = 'LEADER', action = act.PaneSelect },
  -- Create/close panes.
  { key = '"', mods = 'LEADER|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = '%', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true } },
  -- Move between tabs.
  { key = '1', mods = 'LEADER', action = act.MoveTab(1 - 1) },
  { key = '1', mods = 'LEADER', action = act.ActivateTab(1 - 1) },
  { key = '2', mods = 'LEADER', action = act.MoveTab(2 - 1) },
  { key = '2', mods = 'LEADER', action = act.ActivateTab(2 - 1) },
  { key = '3', mods = 'LEADER', action = act.MoveTab(3 - 1) },
  { key = '3', mods = 'LEADER', action = act.ActivateTab(3 - 1) },
  { key = '4', mods = 'LEADER', action = act.MoveTab(3 - 1) },
  { key = '4', mods = 'LEADER', action = act.ActivateTab(4 - 1) },
  { key = '5', mods = 'LEADER', action = act.MoveTab(5 - 1) },
  { key = '5', mods = 'LEADER', action = act.ActivateTab(5 - 1) },
  { key = '6', mods = 'LEADER', action = act.MoveTab(6 - 1) },
  { key = '6', mods = 'LEADER', action = act.ActivateTab(6 - 1) },
  { key = '7', mods = 'LEADER', action = act.MoveTab(7 - 1) },
  { key = '7', mods = 'LEADER', action = act.ActivateTab(7 - 1) },
  { key = '8', mods = 'LEADER', action = act.MoveTab(8 - 1) },
  { key = '8', mods = 'LEADER', action = act.ActivateTab(8 - 1) },
  { key = '9', mods = 'LEADER', action = act.MoveTab(9 - 1) },
  { key = '9', mods = 'LEADER', action = act.ActivateTab(9 - 1) },
  { key = 'p', mods = 'LEADER', action = act.MoveTabRelative(-1) },
  { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
  { key = 'n', mods = 'LEADER', action = act.MoveTabRelative(1) },
  { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
  -- Create/close tabs.
  { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'x', mods = 'LEADER|SHIFT', action = act.CloseCurrentTab { confirm = true } },
  -- Copy/paste.
  { key = 'c', mods = 'SHIFT|CTRL', action = act.CopyTo 'ClipboardAndPrimarySelection' },
  { key = 'v', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
  -- Launcher.
  { key = 's', mods = 'LEADER|SHIFT', action = act.ShowLauncher },
  -- Search.
  { key = '/', mods = 'LEADER', action = act.Search 'CurrentSelectionOrEmptyString' },
  { key = ' ', mods = 'LEADER', action = wezterm.action.QuickSelect },
  -- Workspaces.
  { key = 'n', mods = 'LEADER|SHIFT', action = act.SwitchWorkspaceRelative(1) },
  { key = 'p', mods = 'LEADER|SHIFT', action = act.SwitchWorkspaceRelative(-1) },
  -- Show the launcher in fuzzy selection mode and have it list all workspaces
  -- and allow activating one.
  { key = 'f', mods = 'CTRL', action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' } },
  {
    key = 'w',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter name for new workspace' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:perform_action(act.SwitchToWorkspace { name = line }, pane)
        end
      end),
    },
  },
}
config.key_tables = {
  search_mode = {
    { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
    { key = 'n', mods = 'CTRL', action = act.CopyMode 'NextMatch' },
    { key = 'p', mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
    { key = 'r', mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
    { key = 'u', mods = 'CTRL', action = act.CopyMode 'NextMatchPage' },
    { key = 'd', mods = 'CTRL', action = act.CopyMode 'PriorMatchPage' },
  },
}

config.automatically_reload_config = true
config.window_close_confirmation = 'NeverPrompt'

return config
