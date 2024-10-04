--          ╭─────────────────────────────────────────────────────────╮
--          │                         COLORS                          │
--          ╰─────────────────────────────────────────────────────────╯
-- Load WezTerm module
local wezterm = WEZTERM

local types = require("types")

local cur_hour = wezterm.time.now():format("%H")

local hour_angle = require("funcs").get_hour_angle(cur_hour)

local opts = {
	-- Color Scheme
	color_scheme = "Catppuccin Mocha",
	-- Tab Bar Colors
	colors = {
		-- Compose Cursor
		compose_cursor = "#a5e3a0",
		-- Visual Bell
		visual_bell = "#E78284",
	},
	-- Command Palette Colors
	command_palette_bg_color = "#232634", -- Command Palette Background
	command_palette_fg_color = "#C6D0F5", -- Command Palette Foreground
	-- Titlebar and Frame Colors
	window_frame = {
		active_titlebar_bg = "#232634",
		inactive_titlebar_bg = "#303446",
		inactive_titlebar_fg = "#484D69",
		active_titlebar_fg = "#C6D0F5",
		inactive_titlebar_border_bottom = "#3b3052",
		active_titlebar_border_bottom = "#3b3052",
		button_fg = "#C6D0F5",
		button_bg = "#3b3052",
		button_hover_fg = "#C6D0F5",
		button_hover_bg = "#2b2042",
		font = wezterm.font(types.win_font),
		-- Tab Font Size
		font_size = 10,
	},
	-- Inactive Pane Filter
	inactive_pane_hsb = {
		saturation = 1.0,
		brightness = 0.5,
	},
	window_background_gradient = {
		orientation = {
			Linear = {
				angle = hour_angle,
			},
		},
		colors = {
			-- "#303446",
			"#24273a",
			"#1e1e2e",
		},
		interpolation = "CatmullRom",
		blend = "Oklab",
		noise = 128,
		segment_size = 7,
		segment_smoothness = 1.0,
	},
}

return opts
