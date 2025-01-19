local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

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
local rose_pine = {
	-- Base colors
	base = "#191724",
	surface = "#1f1d2e",
	overlay = "#26233a",
	muted = "#6e6a86",
	subtle = "#908caa",
	text = "#e0def4",
	love = "#eb6f92",
	gold = "#f6c177",
	rose = "#ebbcba",
	pine = "#31748f",
	foam = "#9ccfd8",
	iris = "#c4a7e7",
	highlight_low = "#21202e",
	highlight_med = "#403d52",
	highlight_high = "#524f67",
}

config.colors = {
	foreground = rose_pine.text,
	-- The default background color
	background = rose_pine.base,

	-- Overrides the cell background color when the current cell is occupied by the
	-- cursor and the cursor style is set to Block
	cursor_bg = rose_pine.highlight_high,
	-- Overrides the text color when the current cell is occupied by the cursor
	cursor_fg = rose_pine.text,
	-- Specifies the border color of the cursor when the cursor style is set to Block,
	-- or the color of the vertical or horizontal bar when the cursor style is set to
	-- Bar or Underline.
	cursor_border = rose_pine.highlight_high,

	-- the foreground color of selected text
	selection_fg = rose_pine.text,
	-- the background color of selected text
	selection_bg = rose_pine.overlay,

	-- The color of the scrollbar "thumb"; the portion that represents the current viewport
	scrollbar_thumb = rose_pine.overlay,

	-- The color of the split lines between panes
	split = rose_pine.overlay,

	ansi = {
		rose_pine.overlay, -- black
		rose_pine.love, -- red
		rose_pine.pine, -- green
		rose_pine.gold, -- yellow
		rose_pine.foam, -- blue
		rose_pine.iris, -- magenta
		rose_pine.rose, -- cyan
		rose_pine.text, -- white
	},
	brights = {
		rose_pine.muted, -- bright black
		rose_pine.love, -- bright red
		rose_pine.pine, -- bright green
		rose_pine.gold, -- bright yellow
		rose_pine.foam, -- bright blue
		rose_pine.iris, -- bright magenta
		rose_pine.rose, -- bright cyan
		rose_pine.text, -- bright white
	},

	-- Tab bar colors
	tab_bar = {
		background = rose_pine.base,
		active_tab = {
			bg_color = rose_pine.overlay,
			fg_color = rose_pine.text,
		},
		inactive_tab = {
			bg_color = rose_pine.base,
			fg_color = rose_pine.muted,
		},
		inactive_tab_hover = {
			bg_color = rose_pine.surface,
			fg_color = rose_pine.text,
		},
		new_tab = {
			bg_color = rose_pine.base,
			fg_color = rose_pine.muted,
		},
		new_tab_hover = {
			bg_color = rose_pine.surface,
			fg_color = rose_pine.text,
		},
	},
}

-- config.colors = {
-- 	-- Background and foreground
-- 	foreground = "#E2E2E3",
-- 	background = "#0E0E0E",
--
-- 	-- Cursor colors
-- 	cursor_bg = "#F5E0DC",
-- 	cursor_fg = "#1C1B1D",
-- 	cursor_border = "#F5E0DC",
--
-- 	-- Selection colors
-- 	selection_fg = "#1C1B1D",
-- 	selection_bg = "#F5E0DC",
--
-- 	-- Normal colors
-- 	ansi = {
-- 		"#1C1B1D", -- Black
-- 		"#F28FAD", -- Red
-- 		"#ABE9B3", -- Green
-- 		"#FAE3B0", -- Yellow
-- 		"#96CDFB", -- Blue
-- 		"#DDB6F2", -- Magenta
-- 		"#89DCEB", -- Cyan
-- 		"#D9E0EE", -- White
-- 	},
--
-- 	-- Bright colors
-- 	brights = {
-- 		"#575268", -- Bright Black
-- 		"#F28FAD", -- Bright Red
-- 		"#ABE9B3", -- Bright Green
-- 		"#FAE3B0", -- Bright Yellow
-- 		"#96CDFB", -- Bright Blue
-- 		"#DDB6F2", -- Bright Magenta
-- 		"#89DCEB", -- Bright Cyan
-- 		"#D9E0EE", -- Bright White
-- 	},
-- }

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
