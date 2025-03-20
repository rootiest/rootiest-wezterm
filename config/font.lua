--          ╭─────────────────────────────────────────────────────────╮
--          │                          FONT                           │
--          ╰─────────────────────────────────────────────────────────╯

-- Load WezTerm module
local wezterm = WEZTERM

local types = require("types")

local opts = {
	-- Terminal Font Size
	font_size = 12.0,
	-- Terminal Font
	font = wezterm.font_with_fallback(types.rootiest_font),
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
	-- Set the initial size
	initial_cols = 180,
	initial_rows = 38,

	tab_max_width = 60,
	tab_bar_at_bottom = false,

	-- Unicode Version
	unicode_version = 14,

	-- Resize by cell
	use_resize_increments = true,

	-- Use custom block glyphs
	custom_block_glyphs = true,

	use_cap_height_to_scale_fallback_fonts = true,

	-- Ignore any missing glyphs
	-- warn_about_missing_glyphs = false,
}

return opts
