-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.color_scheme = "rose-pine"
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 60
config.enable_tab_bar = false
config.font = wezterm.font('GeistMono Nerd Font Mono', { weight = 'Bold' })
config.font_size = 15.0
config.window_padding = {
  left = 12,
  right = 12,
  top = 12,
  bottom = 12,
}

config.keys = {
  { key = 't', mods = 'SHIFT|SUPER', action = wezterm.action.ShowTabNavigator },
}

-- and finally, return the configuration to wezterm
return config
