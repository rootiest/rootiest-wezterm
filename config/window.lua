--          ╭─────────────────────────────────────────────────────────╮
--          │                         WINDOW                          │
--          ╰─────────────────────────────────────────────────────────╯

local opts = {
	-- Use Retro tab bar
	use_fancy_tab_bar = false,

	-- Set the window padding
	window_padding = {
		left = "0%",
		right = "0%",
		top = "0%",
		bottom = "0%",
	},

	-- Set the animation framerate
	animation_fps = 120,

	-- Window Decorations
	window_decorations = "TITLE | RESIZE",
	--window_decorations = "INTEGRATED_BUTTONS|TITLE|RESIZE",
	integrated_title_buttons = { "Hide", "Maximize", "Close" },
	window_frame = {
		inactive_titlebar_bg = "#353535",
		active_titlebar_bg = "#2b2042",
		inactive_titlebar_fg = "#cccccc",
		active_titlebar_fg = "#ffffff",
		inactive_titlebar_border_bottom = "#2b2042",
		active_titlebar_border_bottom = "#2b2042",
		button_fg = "#cccccc",
		button_bg = "#2b2042",
		button_hover_fg = "#ffffff",
		button_hover_bg = "#3b3052",
	},

	-- Visual Bell
	visual_bell = {
		fade_in_function = "EaseIn",
		fade_in_duration_ms = 150,
		fade_out_function = "EaseOut",
		fade_out_duration_ms = 150,
	},
	--{
	--  fade_in_duration_ms = 75,
	--  fade_out_duration_ms = 75,
	--  target = "CursorColor",
	--},

	-- Audible Bell
	audible_bell = "SystemBeep",

	-- Terminal Variable
	-- term = "wezterm",

	--Honor kitty protocol inputs
	enable_kitty_keyboard = true,

	-- Rendering
	front_end = "WebGpu",
	-- webgpu_power_preference = "HighPerformance",
	-- webgpu_power_preference = "LowPower",
	-- webgpu_preferred_adapter = gpus[1],
	-- front_end = "OpenGL",

	-- Scrollback Lines
	scrollback_lines = 20000,
}

return opts
