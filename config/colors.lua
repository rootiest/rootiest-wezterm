--          ╭─────────────────────────────────────────────────────────╮
--          │                         COLORS                          │
--          ╰─────────────────────────────────────────────────────────╯

local cur_hour = WEZTERM.time.now():format("%H")

local function get_hour_angle(hour)
	return (hour / 12) * 360
end

local hour_angle = get_hour_angle(cur_hour)

return {
	-- Color Scheme
	color_scheme = "Catppuccin Macchiato",
	-- Tab Bar Colors
	colors = {
		tab_bar = {
			background = "#1a1b26",
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
				bg_color = "#1a1b26",
				fg_color = "#C6D0F5",
				intensity = "Bold",
				underline = "None",
				italic = false,
				strikethrough = false,
			},
			new_tab_hover = {
				bg_color = "#CA9EE6",
				fg_color = "#232634",
				italic = true,
				intensity = "Bold",
			},
		},
		-- Visual Bell
		visual_bell = "#E78284",
	},
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

		-- Specifies the set of colors that are interpolated in the gradient.
		-- Accepts CSS style color specs, from named colors, through rgb
		-- strings and more
		colors = {
			-- "#303446",
			"#24273a",
			"#1e1e2e",
		},

		-- Instead of specifying `colors`, you can use one of a number of
		-- predefined, preset gradients.
		-- A list of presets is shown in a section below.
		-- preset = "Warm",

		-- Specifies the interpolation style to be used.
		-- "Linear", "Basis" and "CatmullRom" as supported.
		-- The default is "Linear".
		interpolation = "Linear",

		-- How the colors are blended in the gradient.
		-- "Rgb", "LinearRgb", "Hsv" and "Oklab" are supported.
		-- The default is "Rgb".
		blend = "Rgb",

		-- To avoid vertical color banding for horizontal gradients, the
		-- gradient position is randomly shifted by up to the `noise` value
		-- for each pixel.
		-- Smaller values, or 0, will make bands more prominent.
		-- The default value is 64 which gives decent looking results
		-- on a retina macbook pro display.
		-- noise = 64,

		-- By default, the gradient smoothly transitions between the colors.
		-- You can adjust the sharpness by specifying the segment_size and
		-- segment_smoothness parameters.
		-- segment_size configures how many segments are present.
		-- segment_smoothness is how hard the edge is; 0.0 is a hard edge,
		-- 1.0 is a soft edge.

		-- segment_size = 11,
		-- segment_smoothness = 0.0,
	},
}
