-- Pull in the wezterm API
local wezterm = require 'wezterm'
-- This table will hold the configuration.
local config = {}
local ac = wezterm.action;
local defaultMod = "ALT"
local keys = {} -- Key map
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end
-- Key Bindings -- 
for i = 1, 8 do
  table.insert(keys, { key = tostring(i), mods = "ALT", action = ac({ ActivateTab = i - 1 }), })
end 
table.insert(keys, { key = "n", mods = defaultMod, action = ac({ SpawnTab = "CurrentPaneDomain" }) })
table.insert(keys, { key = "w", mods = defaultMod, action = ac.CloseCurrentTab { confirm = false } })
table.insert(keys, { key = "f", mods = defaultMod, action = "ToggleFullScreen" })
table.insert(keys, { key = "[", mods = defaultMod, action = ac.MoveTabRelative(-1) })
table.insert(keys, { key = "]", mods = defaultMod, action = ac.MoveTabRelative(1) })
table.insert(keys, { key = "H", mods = defaultMod, action = ac({ SplitVertical = { domain = "CurrentPaneDomain" } }) })
table.insert(keys, { key = "V", mods = defaultMod, action = ac({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) })
table.insert(keys, { key = "s", mods = defaultMod, action = ac.Search { CaseSensitiveString = '' } })

-- This is where you actually apply your config choices
-- For example, changing the color scheme:
config.disable_default_key_bindings = true
config.color_scheme = 'Gruvbox Dark (Gogh)'
config.font = wezterm.font {
  family = 'Mononoki Nerd Font',
}
config.exit_behavior = "Close"
config.window_background_opacity = 0.92
config.font_size = 16
config.default_cursor_style = 'SteadyBar'
config.keys = keys
-- and finally, return the configuration to wezterm
return config