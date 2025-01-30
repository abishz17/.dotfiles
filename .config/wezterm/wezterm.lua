local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").main
config.colors = theme.colors()
config.window_frame = theme.window_frame()

config.keys = {
	{
		key = "t",
		mods = "CMD",
		action = act.SpawnTab("DefaultDomain"),
	},
	{
		key = "Enter",
		mods = "CMD",
		action = act.ToggleFullScreen,
	},
	{
		key = "w",
		mods = "CMD",
		action = act.CloseCurrentTab({ confirm = false }),
	},

	{
		key = "1",
		mods = "CMD",
		action = act.ActivateTab(0),
	},
	{
		key = "2",
		mods = "CMD",
		action = act.ActivateTab(1),
	},
	{
		key = "3",
		mods = "CMD",
		action = act.ActivateTab(2),
	},
	{
		key = "4",
		mods = "CMD",
		action = act.ActivateTab(3),
	},
	{
		key = "5",
		mods = "CMD",
		action = act.ActivateTab(4),
	},
	{
		key = "[",
		mods = "CMD",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "]",
		mods = "CMD",
		action = act.ActivateTabRelative(1),
	},
	{
		key = "s",
		mods = "CMD",
		action = act.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		key = "n",
		mods = "CMD",
		action = act({ ActivatePaneDirection = "Next" }),
	},
	{
		key = "p",
		mods = "CMD",
		action = act({ ActivatePaneDirection = "Prev" }),
	},
}

-- Font configuration
config.font = wezterm.font_with_fallback({
	"JetBrainsMono Nerd Font",
	"Fira Code",
	"Symbols Nerd Font Mono",
})
config.font_size = 16.0
config.line_height = 1.2

config.window_background_opacity = 0.95
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 800
config.animation_fps = 60

-- General UI configuration
config.enable_scroll_bar = false
config.scrollback_lines = 10000
config.enable_wayland = true
config.enable_kitty_graphics = true
config.window_close_confirmation = "NeverPrompt"

-- Performance settings
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

config.native_macos_fullscreen_mode = true
config.max_fps = 120
return config
