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
-- table.insert(keys, { key = "w", mods = defaultMod, action = ac.CloseCurrentTab { confirm = false } })
table.insert(keys, { key = "x", mods = defaultMod, action = ac.CloseCurrentPane {confirm = false } })
table.insert(keys, { key = "f", mods = defaultMod, action = "ToggleFullScreen" })
table.insert(keys, { key = "[", mods = defaultMod, action = ac.MoveTabRelative(-1) })
table.insert(keys, { key = "]", mods = defaultMod, action = ac.MoveTabRelative(1) })
table.insert(keys, { key = "v", mods = defaultMod, action = ac({ SplitVertical = { domain = "CurrentPaneDomain" } }) })
table.insert(keys, { key = "Enter", mods = defaultMod, action = ac({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) })
table.insert(keys, { key = "s", mods = defaultMod, action = ac.Search { CaseSensitiveString = '' } })
table.insert(keys, { key = "RightArrow", mods = defaultMod, action = ac({ActivatePaneDirection = "Right" })} )
table.insert(keys, { key = "LeftArrow", mods = defaultMod, action = ac({ActivatePaneDirection = "Left" })} )
table.insert(keys, { key = "UpArrow", mods = defaultMod, action = ac({ActivatePaneDirection = "Up" })} )
table.insert(keys, { key = "DownArrow", mods = defaultMod, action = ac({ActivatePaneDirection = "Down" })} )
table.insert(keys, { key = "RightArrow", mods = "CTRL", action = ac.AdjustPaneSize { 'Right', 1 }})
table.insert(keys, { key = "LeftArrow", mods = "CTRL", action = ac.AdjustPaneSize { 'Left', 1 }})
table.insert(keys, { key = "UpArrow", mods = "CTRL", action = ac.AdjustPaneSize { 'Up', 1 }})
table.insert(keys, { key = "DownArrow", mods = "CTRL", action = ac.AdjustPaneSize { 'Down', 1 }})
-- This is where you actually apply your config choices
-- For example, changing the color scheme:
-- config.disable_default_key_bindings = true
-- config.color_scheme = 'Gruvbox Dark (Gogh)'
config.color_scheme = 'Catppuccin Mocha (Gogh)'

config.font = wezterm.font {
--  family = 'mononoki Nerd Font',
	family = 'Iosevka Term',
}
config.exit_behavior = "Close"
config.window_background_opacity = 1.0
config.font_size = 15
config.default_cursor_style = 'SteadyBar'
config.keys = keys
-- and finally, return the configuration to wezterm
return config
