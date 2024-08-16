--          ╭─────────────────────────────────────────────────────────╮
--          │                         COLORS                          │
--          ╰─────────────────────────────────────────────────────────╯

return {
	-- Color Scheme
	color_scheme = "Catppuccin Frappe",
	-- Tab Bar Colors
	colors = {
		tab_bar = {
			inactive_tab_edge = "#484D69",
			active_tab = {
				bg_color = "#CA9EE6",
				fg_color = "#232634",
				intensity = "Normal",
				underline = "None",
				italic = false,
				strikethrough = false,
			},
			inactive_tab = {
				bg_color = "#484D69",
				fg_color = "#C6D0F5",
			},
			inactive_tab_hover = {
				bg_color = "#3b3052",
				fg_color = "#C6D0F5",
				italic = true,
				intensity = "Bold",
			},
			new_tab = {
				bg_color = "#737994",
				fg_color = "#C6D0F5",
				intensity = "Bold",
				underline = "None",
				italic = false,
				strikethrough = false,
			},
			new_tab_hover = {
				bg_color = "#3b3052",
				fg_color = "#C6D0F5",
				italic = true,
				intensity = "Bold",
			},
		},
	},
	-- Titlebar Colors
	window_frame = {
		active_titlebar_bg = "#232634",
		inactive_titlebar_bg = "#303446",
	},
	-- Terminal Variable
	term = "wezterm",
}
