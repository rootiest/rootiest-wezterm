local wezterm = WEZTERM
local config = CONFIG
local types = require("types")
local funcs = require("funcs")

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

tabline.setup({
	options = {
		icons_enabled = true,
		theme = "Catppuccin Mocha",
		section_separators = {
			left = wezterm.nerdfonts.ple_right_half_circle_thick,
			right = wezterm.nerdfonts.ple_left_half_circle_thick,
		},
		component_separators = {
			left = wezterm.nerdfonts.ple_right_half_circle_thin,
			right = wezterm.nerdfonts.ple_left_half_circle_thin,
		},
		tab_separators = {
			left = wezterm.nerdfonts.ple_right_half_circle_thick,
			right = wezterm.nerdfonts.ple_left_half_circle_thick,
		},
	},
	sections = {
		tabline_a = {
			funcs.leader_component,
			{ "mode", padding = { left = 1, right = 0 } },
		},
		tabline_b = { { "workspace", padding = { left = 1, right = 0 } } },
		tabline_c = { " " },
		tab_active = {
			{
				"zoomed",
				icon = wezterm.nerdfonts.oct_zoom_in,
				padding = { left = 0, right = 0 },
			},
			{
				"index",
				fmt = function(n, _)
					return funcs.ordinal(n)
				end,
				padding = { left = 0, right = 0 },
			},
			wezterm.nerdfonts.ple_right_half_circle_thin,
			{
				"tab",
				fmt = function(str)
					return funcs.format_tab_title(str)
				end,
				padding = { left = 0, right = 0 },
				icons_enabled = false,
			},
			{ "parent", padding = { left = 0, right = 0 } },
			"/",
			{ "cwd", padding = { left = 0, right = 1 } },
			wezterm.nerdfonts.ple_left_half_circle_thin,
			{ "process", padding = { left = 0, right = 0 } },
		},
		tab_inactive = {
			{
				"zoomed",
				icon = wezterm.nerdfonts.oct_zoom_in,
				padding = { left = 0, right = 0 },
			},
			{
				"index",
				fmt = function(n, _)
					return funcs.ordinal(n)
				end,
				padding = { left = 0, right = 0 },
			},
			":",
			{
				"tab",
				fmt = function(str)
					return funcs.format_inactive_tab_title(str)
				end,
				padding = { left = 1, right = 0 },
				icons_enabled = false,
			},
			{ "parent", padding = { left = 0, right = 0 } },
			"/",
			{ "cwd", padding = { left = 0, right = 1 } },
			{ "process", icons_only = true, padding = { left = 0, right = 0 } },
		},
		tabline_x = {},
		tabline_y = {
			{
				"datetime",
				icons_only = false,
				hour_to_icon = types.hours_icons,
				padding = { left = 0, right = 1 },
				style = "%a %R",
			},
		},
		tabline_z = {
			{ "hostname", padding = { left = 0, right = 1 } },
			{
				"battery",
				battery_to_icon = {
					empty = {
						wezterm.nerdfonts.fa_battery_empty .. " ",
						color = { fg = funcs.invert_color_brightness("#f37ca0") },
					},
					quarter = {
						wezterm.nerdfonts.fa_battery_quarter .. " ",
						color = { fg = funcs.invert_color_brightness("#ffb080") },
					},
					half = {
						wezterm.nerdfonts.fa_battery_half .. " ",
						color = { fg = funcs.invert_color_brightness("#fbe2a9") },
					},
					three_quarters = wezterm.nerdfonts.fa_battery_three_quarters .. " ",
					full = {
						wezterm.nerdfonts.fa_battery_full .. " ",
						color = { fg = funcs.invert_color_brightness("#93e398") },
					},
				},
				padding = { left = 0, right = 1 },
			},
		},
	},
	extensions = { "resurrect" },
})

local function apply_tabline_config(conf)
	conf.use_fancy_tab_bar = false
	conf.show_new_tab_button_in_tab_bar = false
	conf.tab_max_width = 64
	conf.window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	}
	local normbg = require("tabline.config").colors.normal_mode.c.bg
	conf.colors = {
		tab_bar = {
			background = normbg,
			inactive_tab_edge = normbg,
		},
	}
	config.status_update_interval = 500
end

apply_tabline_config(config)