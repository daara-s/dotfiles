-- Pull in the wezterm API
local wezterm = require("wezterm")
-- This table will hold the configuration.
local config = {}
local act = wezterm.action

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Mocha"
config.audible_bell = "Disabled"
config.font = wezterm.font({
	family = "FiraCode Nerd Font",
	harfbuzz_features = { "ss02" },
})
config.keys = {
	{ action = act.ActivateCommandPalette, mods = "CTRL|SHIFT", key = "P" },
	{ action = act.CopyTo("Clipboard"), mods = "CTRL|SHIFT", key = "C" },
	{ action = act.DecreaseFontSize, mods = "CTRL", key = "-" },
	{ action = act.IncreaseFontSize, mods = "CTRL", key = "=" },
	{ action = act.Nop, mods = "ALT", key = "Enter" },
	{ action = act.PasteFrom("Clipboard"), mods = "CTRL|SHIFT", key = "V" },
	{ action = act.ResetFontSize, mods = "CTRL", key = "0" },
    {
        key = "B",
        mods = "SHIFT|ALT|CTRL|SUPER",
        action = act.DisableDefaultAssignment,
    },

}

config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false
config.use_dead_keys = false
config.debug_key_events = true
config.hide_tab_bar_if_only_one_tab = true

-- and finally, return the configuration to wezterm
return config
