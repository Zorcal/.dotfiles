local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- OpenGL for GPU acceleration, Software for CPU
config.front_end = 'OpenGL'

config.color_scheme = 'ayu'

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
config.hide_tab_bar_if_only_one_tab = false
config.show_tab_index_in_tab_bar = true
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.cursor_blink_rate = 0

config.scrollback_lines = 10000

config.automatically_reload_config = true
config.window_close_confirmation = 'NeverPrompt'
config.enable_kitty_keyboard = true

return config
