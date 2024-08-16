--          ╭─────────────────────────────────────────────────────────╮
--          │                          FONTS                          │
--          ╰─────────────────────────────────────────────────────────╯

return {
	-- Terminal Font
	font = WEZTERM.font({
		family = "Iosevka",
		weight = "Regular",
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
	font_size = 12.0,
	-- Fancy Tab Bar Font
	window_frame = {
		font = WEZTERM.font({
			family = "Iosevka",
			weight = "Medium",
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
		font_size = 11,
	},
	-- Cursor Shape
	default_cursor_style = "BlinkingBar",
}
