local wezterm = require("wezterm")

local act = wezterm.action

local window_background_opacity = 0.9
local function toggle_window_background_opacity(window)
  local overrides = window:get_config_overrides() or {}
  if not overrides.window_background_opacity then
    overrides.window_background_opacity = 1.0
  else
    overrides.window_background_opacity = nil
  end
  window:set_config_overrides(overrides)
end
wezterm.on("toggle-window-background-opacity", toggle_window_background_opacity)

local function toggle_ligatures(window)
  local overrides = window:get_config_overrides() or {}
  if not overrides.harfbuzz_features then
    overrides.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
  else
    overrides.harfbuzz_features = nil
  end
  window:set_config_overrides(overrides)
end
wezterm.on("toggle-ligatures", toggle_ligatures)

-- Initialize actual config
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

wezterm.plugin.require("https://github.com/yriveiro/wezterm-tabs").apply_to_config(config, {
	tabs = {
		tab_bar_at_bottom = true,
		hide_tab_bar_if_only_one_tab = false,
	},
})

local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").main
config.colors = theme.colors()
config.window_frame = theme.window_frame()

-- Appearance
config.font_size = 16.0
config.window_background_opacity = window_background_opacity
config.macos_window_background_blur = 10
config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = false
config.max_fps = 120
config.native_macos_fullscreen_mode = false
config.animation_fps = 60

--Performance settings
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"


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


-- Return config to WezTerm
return config
