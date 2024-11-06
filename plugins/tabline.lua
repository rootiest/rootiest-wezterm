local wezterm = WEZTERM
local config = CONFIG
local types = require("types")
local funcs = require("funcs")
local batteries = BATTERIES

local tabline = WEZTERM.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

wezterm.on("bell", function(_, pane)
	wezterm.log_info("the bell was rung in pane " .. pane:pane_id() .. "!")
end)

local tab_opts = {
	options = {
		icons_enabled = true,
		theme = COLORTHEME,
		section_separators = {
			left = WEZTERM.nerdfonts.ple_right_half_circle_thick,
			right = WEZTERM.nerdfonts.ple_left_half_circle_thick,
		},
		component_separators = {
			left = WEZTERM.nerdfonts.ple_right_half_circle_thin,
			right = WEZTERM.nerdfonts.ple_left_half_circle_thin,
		},
		tab_separators = {
			left = WEZTERM.nerdfonts.ple_right_half_circle_thick,
			right = WEZTERM.nerdfonts.ple_left_half_circle_thick,
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
				icon = WEZTERM.nerdfonts.oct_zoom_in,
				padding = { left = 0, right = 0 },
			},
			{
				"index",
				fmt = function(n, _)
					return funcs.ordinal(n)
				end,
				padding = { left = 0, right = 0 },
			},
			WEZTERM.nerdfonts.ple_right_half_circle_thin,
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
			WEZTERM.nerdfonts.ple_left_half_circle_thin,
			{
				"process",
				process_to_icon = {
					["discordo"] = { WEZTERM.nerdfonts.md_discord, color = { fg = "#a5e3a0" } },
					["iamb"] = { WEZTERM.nerdfonts.md_chat, color = { fg = "#E78284" } },
				},
				padding = { left = 0, right = 0 },
			},
		},
		tab_inactive = {
			{
				"zoomed",
				icon = WEZTERM.nerdfonts.oct_zoom_in,
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
			-- { "parent", padding = { left = 0, right = 0 } },
			-- "/",
			-- { "cwd", padding = { left = 0, right = 1 } },
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
		},
	},
	extensions = { "resurrect" },
}

if batteries.get_battery_icons() ~= "" then
	tab_opts.sections.tabline_z = {
		{ "hostname", padding = { left = 0, right = 1 } },
		batteries.get_battery_icons,
	}
end

if MYTABLINE ~= nil then
	tab_opts = MYTABLINE
end

tabline.setup(tab_opts)

local function apply_tabline_config(conf)
	conf.use_fancy_tab_bar = false
	conf.show_new_tab_button_in_tab_bar = false
	conf.tab_bar_at_bottom = false
	conf.tab_max_width = 64
	conf.window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	}
	tabline.get_colors()
	local normbg = require("tabline.config").colors.normal_mode.c.bg
	conf.colors = {
		tab_bar = {
			background = normbg,
			inactive_tab_edge = normbg,
		},
	}
	conf.status_update_interval = 500
end

apply_tabline_config(config)
