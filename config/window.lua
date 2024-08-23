--          ╭─────────────────────────────────────────────────────────╮
--          │                         WINDOW                          │
--          ╰─────────────────────────────────────────────────────────╯

return {
	-- Set the initial size
	initial_cols = 180,
	initial_rows = 38,

	tab_max_width = 60,

	-- Resize by cell
	use_resize_increments = true,

	-- Use Retro tab bar
	use_fancy_tab_bar = false,

	-- Prefer to spawn tabs rather than windows
	prefer_to_spawn_tabs = true,

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

	-- Visual Bell
	visual_bell = {
		fade_in_duration_ms = 75,
		fade_out_duration_ms = 75,
		target = "CursorColor",
	},

	-- Audible Bell
	audible_bell = "SystemBeep",

	-- Terminal Variable
	term = "wezterm",
	webgpu_preferred_adapter = {
		backend = "Vulkan",
		device = 7954,
		device_type = "DiscreteGpu",
		driver = "NVIDIA",
		driver_info = "560.35.03",
		name = "NVIDIA GeForce RTX 2060 with Max-Q Design",
		vendor = 4318,
	},
	-- Scrollback Lines
	scrollback_lines = 20000,
}
