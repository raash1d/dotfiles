local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.check_for_updates = true
config.automatically_reload_config = true

config.color_scheme = "Catppuccin Macchiato"

config.font = wezterm.font_with_fallback({
	"RobotoMono Nerd Font",
	"JetBrains Mono",
	"Noto Color Emoji",
})
config.font_size = 14
config.font_rules = {
	{
		italic = true,
		font = wezterm.font("RecMonoCasual Nerd Font", { weight = "Regular", italic = true }),
	},
}
config.harfbuzz_features = { "ss01" }

config.initial_cols = 100
config.initial_rows = 24

config.window_padding = {
	left = 2,
	right = 2,
	top = 2,
	bottom = 2,
}

config.hide_tab_bar_if_only_one_tab = true

return config
