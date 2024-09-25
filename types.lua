--          ╭─────────────────────────────────────────────────────────╮
--          │                          TYPES                          │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

local wezterm = WEZTERM

M.harfbuzz_features = {
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
}

M.maple_features = {
	"ss01",
	"ss02",
	"ss03",
	"ss04",
	"ss05",
}

M.hours_icons = {
	["00"] = wezterm.nerdfonts.md_clock_time_twelve_outline,
	["01"] = wezterm.nerdfonts.md_clock_time_one_outline,
	["02"] = wezterm.nerdfonts.md_clock_time_two_outline,
	["03"] = wezterm.nerdfonts.md_clock_time_three_outline,
	["04"] = wezterm.nerdfonts.md_clock_time_four_outline,
	["05"] = wezterm.nerdfonts.md_clock_time_five_outline,
	["06"] = wezterm.nerdfonts.md_clock_time_six_outline,
	["07"] = wezterm.nerdfonts.md_clock_time_seven_outline,
	["08"] = wezterm.nerdfonts.md_clock_time_eight_outline,
	["09"] = wezterm.nerdfonts.md_clock_time_nine_outline,
	["10"] = wezterm.nerdfonts.md_clock_time_ten_outline,
	["11"] = wezterm.nerdfonts.md_clock_time_eleven_outline,
	["12"] = wezterm.nerdfonts.md_clock_time_twelve, -- 12:00 in solid icon
	["13"] = wezterm.nerdfonts.md_clock_time_one, -- 1:00 in solid icon
	["14"] = wezterm.nerdfonts.md_clock_time_two, -- 2:00 in solid icon
	["15"] = wezterm.nerdfonts.md_clock_time_three, -- 3:00 in solid icon
	["16"] = wezterm.nerdfonts.md_clock_time_four, -- 4:00 in solid icon
	["17"] = wezterm.nerdfonts.md_clock_time_five, -- 5:00 in solid icon
	["18"] = wezterm.nerdfonts.md_clock_time_six, -- 6:00 in solid icon
	["19"] = wezterm.nerdfonts.md_clock_time_seven, -- 7:00 in solid icon
	["20"] = wezterm.nerdfonts.md_clock_time_eight, -- 8:00 in solid icon
	["21"] = wezterm.nerdfonts.md_clock_time_nine, -- 9:00 in solid icon
	["22"] = wezterm.nerdfonts.md_clock_time_ten, -- 10:00 in solid icon
	["23"] = wezterm.nerdfonts.md_clock_time_eleven, -- 11:00 in solid icon
}

M.font_maple = {
	{
		-- Font Family
		family = "Maple Mono NF",
		-- Font WeightLazy
		weight = "Medium",
		-- Character Varients and Ligatures
		harfbuzz_features = M.maple_features,
	},
	{
		-- Font Family
		family = "Iosevka Term",
		-- Font WeightLazy
		weight = "Medium",
		-- Character Varients and Ligatures
		harfbuzz_features = M.harfbuzz_features,
	},
	"Flog Symbols",
	"Symbols Nerd Font",
	"Symbols Nerd Font Mono",
	"VictorMono Nerd Font",
	"Hack",
	"MonaspaceKrypton Nerd Font",
	"Roboto",
	"Cascadia Code",
}

M.font = {
	{
		-- Font Family
		family = "Iosevka Term",
		-- Font WeightLazy
		weight = "Medium",
		-- Character Varients and Ligatures
		harfbuzz_features = M.harfbuzz_features,
	},
	"Flog Symbols",
	"Symbols Nerd Font",
	"Symbols Nerd Font Mono",
	"VictorMono Nerd Font",
	"Hack",
	"MonaspaceKrypton Nerd Font",
	"Roboto",
	"Cascadia Code",
}

M.win_font = {
	-- Tab Font Family
	family = "Iosevka",
	-- Tab Font Weight
	weight = "Medium",
	-- Character Varients and Ligatures
	harfbuzz_features = M.harfbuzz_features,
}

M.leader = {
	icon = "❯",
	on = "❮",
	off = "❯",
	padding = {
		left = " ",
		right = "",
	},
}

return M
