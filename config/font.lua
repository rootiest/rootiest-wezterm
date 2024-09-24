--          ╭─────────────────────────────────────────────────────────╮
--          │                          FONTS                          │
--          ╰─────────────────────────────────────────────────────────╯

local types = require("types")

return {
	-- Terminal Font Size
	font_size = 12.0,
	-- Terminal Font
	font = WEZTERM.font_with_fallback(types.font),
	-- Tab Font
	window_frame = {
		font = WEZTERM.font(types.win_font),
		-- Tab Font Size
		font_size = 10,
	},
	-- Cell Sizing
	cell_width = 1.0,
	line_height = 1.0,
	-- ANSI Colors
	bold_brightens_ansi_colors = "BrightAndBold",
	-- FreeType Load Flags
	freetype_load_flags = "DEFAULT",
	-- FreeType Load Target
	freetype_load_target = "Normal",
	-- Default Cursor Shape
	default_cursor_style = "BlinkingBar",
	-- Fallback Fonts
}
