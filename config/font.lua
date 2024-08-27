--          ╭─────────────────────────────────────────────────────────╮
--          │                          FONTS                          │
--          ╰─────────────────────────────────────────────────────────╯

return {
	-- Terminal Font Size
	font_size = 12.0,
	-- Terminal Font
	font = WEZTERM.font_with_fallback({
		{
			-- Font Family
			family = "Iosevka Term",
			-- Font Weight
			weight = "Medium",
			-- Character Varients and Ligatures
			harfbuzz_features = {
				"VSAH=7",
				"VSAF=3",
				"VSAI=3",
				"VSAJ=8",
				"VSAM=4",
				"VLAB=5",
				"cv10=7",
				"cv41=3",
				"cv44=6",
				"cv07=4",
			},
		},
		"Symbols Nerd Font",
		"Symbols Nerd Font Mono",
		"VictorMono Nerd Font",
		"Hack",
		"MonaspaceKrypton Nerd Font",
		"Roboto",
		"Cascadia Code",
	}),
	-- Tab Font
	window_frame = {
		font = WEZTERM.font({
			-- Tab Font Family
			family = "Iosevka",
			-- Tab Font Weight
			weight = "Medium",
			-- Character Varients and Ligatures
			harfbuzz_features = {
				"VSAH=7",
				"VSAF=3",
				"VSAI=3",
				"VSAJ=8",
				"VSAM=4",
				"VLAB=5",
				"cv10=7",
				"cv41=3",
				"cv44=6",
				"cv07=4",
			},
		}),
		-- Tab Font Size
		font_size = 11,
	},
	-- Cell Width
	cell_width = 1.0,
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
