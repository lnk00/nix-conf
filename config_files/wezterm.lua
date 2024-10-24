-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

local nordlight = wezterm.color.get_builtin_schemes()['nord-light']
nordlight.ansi = {
  "#3b4252",
  "#bf616a",
  "#3B4252",
  "#ebcb8b",
  "#81a1c1",
  "#b48ead",
  "#88c0d0",
  "#d8dee9"
}

-- This is where you actually apply your config choices
config.color_schemes = {
  ['custom-nord-light'] = nordlight,
}
config.color_scheme = "custom-nord-light"
-- config.color_scheme = 'NordLight (Gogh)'
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 30
config.enable_tab_bar = false
config.tab_bar_at_bottom = true
config.colors = {
    tab_bar = {
      background = "rgba(255,255,255,0.7)",
      active_tab = {
          fg_color = 'rgba(255,255,255,0.7)',
          bg_color = '#183691',

          -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
          -- label shown for this tab.
          -- The default is "Normal"
          intensity = 'Bold',

          -- Specify whether you want "None", "Single" or "Double" underline for
          -- label shown for this tab.
          -- The default is "None"
          underline = 'None',

          -- Specify whether you want the text to be italic (true) or not (false)
          -- for this tab.  The default is false.
          italic = false,

          -- Specify whether you want the text to be rendered with strikethrough (true)
          -- or not for this tab.  The default is false.
          strikethrough = false,
        },

        -- Inactive tabs are the tabs that do not have focus
        inactive_tab = {
          bg_color = 'rgba(255,255,255,0.7)',
          fg_color = '#808080',

        },

        new_tab = {
          bg_color = 'rgba(255,255,255,0.7)',
          fg_color = 'rgba(255,255,255,0.7)',
        },
    },
}
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
